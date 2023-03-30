#include <algorithm>
#include <array>
#include <atomic>
#include <cmath>
#include <execution>
#include <fstream>
#include <iostream>
#include <memory>
#include <vector>

//#include "/w/halla-scshelf2102/solid/shuo/sidis/include/sidis/sidis.hpp"
//export SIDIS_PATH=/w/halla-scshelf2102/solid/shuo/sidis:$SIDIS_PATH
#include "sidis/sidis.hpp"
#include <sidis/sf_set/mask.hpp>
#include <sidis/sf_set/prokudin.hpp>
#include <sidis/sf_set/stf.hpp>
#include <sidis/sf_set/test.hpp>

#include <sidis/extra/math.hpp>

#undef LOG_PROGRESS

using namespace sidis;
using namespace sidis::kin;
using namespace sidis::math;
using namespace sidis::part;

bool const NORMAL_ASYMMETRIES = false;

struct TestSfSet : public sf::SfSet {
	TestSfSet() : sf::SfSet(part::Nucleus::P) { }
	Real F_UUT(part::Hadron, Real, Real, Real, Real) const override {
		return 1.;
	}
	Real F_UTT_sin_phih_m_phis(part::Hadron, Real, Real, Real, Real) const override {
		return 0.1;
	}
	Real F_UT_sin_phih_p_phis(part::Hadron, Real, Real, Real, Real) const override {
		return 0.1;
	}
};

// Run like `./make_ssa_csv jlab2`.
int main(int argc, char** argv) {
	IntegParams params_unpol { IntegMethod::VEGAS, 10000, 1000 };
	IntegParams params_sivers { IntegMethod::VEGAS, 10000, 1000 };
	IntegParams params_collins { IntegMethod::VEGAS, 10000, 1000 };
	if (argc != 2) {
		std::cout << "Needs an argument" << std::endl;
		return 1;
	}
	sf::set::StfTmdSet tmd_set;
	sf::GaussianTmdSfSet sf_set_full(tmd_set);
	TestSfSet sf_set;
	//sf::set::TestSfSet sf_set_full(part::Nucleus::P);
	sf::set::MaskSfSet sf_set_sivers({
		false, true,  false, false, false, false, false, true,  false,
		false, false, false, false, false, false, false, false, false },
		std::make_unique<sf::GaussianTmdSfSet>(tmd_set));
	sf::set::MaskSfSet sf_set_collins({
		false, true,  false, false, false, false, false, false, false,
		false, false, true,  false, false, false, false, false, false },
		std::make_unique<sf::GaussianTmdSfSet>(tmd_set));
	sf::SfSet const* sf_set_arr[] = {
		&sf_set_full,
		&sf_set_sivers,
		&sf_set_collins,
	};

	Particles ps(
		part::Nucleus::P,
		part::Lepton::E,
		part::Hadron::PI_P,
		MASS_P + MASS_PI_0);
	Real S, x, y, z, Q, Q_sq;
	std::string name = argv[1];
	if (name == "jlab1") {
		// JLAB 1 kinematics
		S = 10.3;
		Q = 1.52;
		x = 0.32;
		z = 0.55;
		Q_sq = Q * Q;
		y = Q_sq / (S * x);
	} else if (name == "jlab2") {
		// JLAB 2 kinematics
		S = 2. * 12. * MASS_P;
		Q_sq = 8.;
		x = 0.48;
		z = 0.375;
		Q = std::sqrt(Q_sq);
		y = Q_sq / (S * x);
	} else if (name == "jlab3") {
		// JLAB 3 kinematics
		S = 2. * 24. * MASS_P;
		Q_sq = 15.;
		x = 0.48;
		z = 0.375;
		Q = std::sqrt(Q_sq);
		y = Q_sq / (S * x);
	} else if (name == "eic1") {
		// EIC 1 kinematics
		S = 140. * 140.;
		Q = 3.;
		y = 0.4;
		z = 0.5;
		Q_sq = Q * Q;
		x = Q_sq / (S * y);
	} else if (name == "eic2") {
		// EIC 2 kinematics
		S = 140. * 140.;
		Q = 10.;
		y = 0.4;
		z = 0.5;
		Q_sq = Q * Q;
		x = Q_sq / (S * y);
	} else if (name == "eic3") {
		// EIC 3 kinematics
		S = 140. * 140.;
		Q = 5.;
		x = 0.01;
		z = 0.5;
		Q_sq = Q * Q;
		y = Q_sq / (S * x);
	} else if (name == "test") {
		// Test kinematics
		S = 140. * 140.;
		Q = 10.;
		x = 0.01;
		z = 0.5;
		Q_sq = Q * Q;
		y = Q_sq / (S * x);
	} else {
		std::cout << "Unrecognized kinematics " << name << std::endl;
		return 1;
	}

	Real qt_to_Q_min = 0.05;
	Real qt_to_Q_max = 1.50;
	std::size_t num_points = 30;

	std::vector<std::size_t> indices(num_points, 0);
	std::vector<Real> qt_to_Q(num_points, 0);
	std::vector<EstErr> unpol_bn(num_points, EstErr{});
	std::vector<EstErr> unpol_rc(num_points, EstErr{});
	std::vector<EstErr> asym_sivers_bn(num_points, EstErr{});
	std::vector<EstErr> asym_sivers_rc(num_points, EstErr{});
	std::vector<EstErr> asym_collins_bn(num_points, EstErr{});
	std::vector<EstErr> asym_collins_rc(num_points, EstErr{});

	for (std::size_t idx = 0; idx < indices.size(); ++idx) {
		indices[idx] = idx;
		qt_to_Q[idx] = static_cast<Real>(idx) / (num_points - 1) * (qt_to_Q_max - qt_to_Q_min) + qt_to_Q_min;
	}

	std::size_t select = 0;
	std::atomic_size_t counter = 0;

#ifdef LOG_PROGRESS
	std::cout << '\r' << 0 << " / " << num_points;
	std::cout.flush();
#endif
	std::for_each(std::execution::par_unseq, indices.begin(), indices.end(), [&](std::size_t idx) {
		Real ph_t_sq = math::sq(qt_to_Q[idx] * z) * Q_sq;
		kin::Kinematics kin_valid(ps, S, { x, y, z, ph_t_sq, 0., 0. });
		if (cut::valid(kin_valid)) {
			unpol_bn[idx] = asym::uu_integ(
				*sf_set_arr[select],
				ps, S, x, y, z, ph_t_sq,
				false,
				params_unpol);
			unpol_rc[idx] = asym::uu_integ(
				*sf_set_arr[select],
				ps, S, x, y, z, ph_t_sq,
				true,
				params_unpol);
			if (NORMAL_ASYMMETRIES) {
				asym_sivers_bn[idx] = asym::sivers(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					false,
					params_sivers);
				asym_sivers_rc[idx] = asym::sivers(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					true,
					params_sivers);
				asym_collins_bn[idx] = asym::collins(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					false,
					params_collins);
				asym_collins_rc[idx] = asym::collins(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					true,
					params_collins);
			} else {
				asym_sivers_bn[idx] = asym::ut_integ(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					-1, 1, 0,
					false,
					params_sivers);
				asym_sivers_rc[idx] = asym::ut_integ(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					-1, 1, 0,
					true,
					params_sivers);
				asym_collins_bn[idx] = asym::ut_integ(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					1, 1, 0,
					false,
					params_collins);
				asym_collins_rc[idx] = asym::ut_integ(
					*sf_set_arr[select],
					ps, S, x, y, z, ph_t_sq,
					1, 1, 0,
					true,
					params_collins);
			}
		}
		counter++;
#ifdef LOG_PROGRESS
		std::cout << '\r' << counter << " / " << num_points;
		std::cout.flush();
#endif
	});
#ifdef LOG_PROGRESS
	std::cout << '\r' << num_points << " / " << num_points << std::endl;
	std::cout.flush();
#endif

	// Write results to file.
	std::ofstream fout("results-" + name + ".txt", std::ofstream::out | std::ofstream::trunc);
	fout << std::scientific;
	fout << "qt_to_Q\tunpol_bn\terr\tunpol_rc\terr\tsivers_bn\terr\tsivers_rc\terr\tcollins_bn\terr\tcollins_rc\terr" << std::endl;
	for (std::size_t idx : indices) {
		fout << qt_to_Q[idx] << '\t'
			<< unpol_bn[idx].val << '\t' << unpol_bn[idx].err << '\t'
			<< unpol_rc[idx].val << '\t' << unpol_rc[idx].err << '\t'
			<< asym_sivers_bn[idx].val << '\t' << asym_sivers_bn[idx].err << '\t'
			<< asym_sivers_rc[idx].val << '\t' << asym_sivers_rc[idx].err << '\t'
			<< asym_collins_bn[idx].val << '\t' << asym_collins_bn[idx].err << '\t'
			<< asym_collins_rc[idx].val << '\t' << asym_collins_rc[idx].err << '\t'
			<< std::endl;
	}

	return 0;
}

