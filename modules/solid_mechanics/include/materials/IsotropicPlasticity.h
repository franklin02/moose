#ifndef ISOTROPICPLASTICITY_H
#define ISOTROPICPLASTICITY_H

#include "ReturnMappingModel.h"

class PiecewiseLinear;

/**
 */

class IsotropicPlasticity : public ReturnMappingModel
{
public:
  IsotropicPlasticity( const std::string & name,
                       InputParameters parameters );

  virtual void initStatefulProperties(unsigned n_points);

protected:
  virtual void computeStressInitialize(unsigned qp, Real effectiveTrialStress, const SymmElasticityTensor & elasticityTensor);
  virtual void computeStressFinalize(unsigned qp, const SymmTensor & plasticStrainIncrement);

  virtual Real computeResidual(unsigned qp, Real effectiveTrialStress, Real scalar);
  virtual Real computeDerivative(unsigned qp, Real effectiveTrialStress, Real scalar);
  virtual void iterationFinalize(unsigned qp, Real scalar);

  virtual Real computeHardening(unsigned qp, Real scalar);

  const Real _yield_stress;
  const Real _hardening_constant;
  PiecewiseLinear * const _hardening_function;

  Real _yield_condition;
  Real _shear_modulus;
  Real _hardening_slope;

  MaterialProperty<SymmTensor> & _plastic_strain;
  MaterialProperty<SymmTensor> & _plastic_strain_old;
  MaterialProperty<Real> * _scalar_plastic_strain;
  MaterialProperty<Real> * _scalar_plastic_strain_old;

  MaterialProperty<Real> & _hardening_variable;
  MaterialProperty<Real> & _hardening_variable_old;

private:

};

template<>
InputParameters validParams<IsotropicPlasticity>();

#endif // ISOTROPICPLASTICITY_H
