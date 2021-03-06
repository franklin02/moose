#ifndef NSMOMENTUMINVISCIDSPECIFIEDPRESSUREBC_H
#define NSMOMENTUMINVISCIDSPECIFIEDPRESSUREBC_H

#include "NSMomentumInviscidBC.h"


// Forward Declarations
class NSMomentumInviscidSpecifiedPressureBC;

template<>
InputParameters validParams<NSMomentumInviscidSpecifiedPressureBC>();

/**
 * Momentum equation boundary condition in which pressure is specified (given)
 * and the value of the convective part is allowed to vary (is computed implicitly).
 */
class NSMomentumInviscidSpecifiedPressureBC : public NSMomentumInviscidBC
{
public:
  NSMomentumInviscidSpecifiedPressureBC(const std::string & name, InputParameters parameters);

  virtual ~NSMomentumInviscidSpecifiedPressureBC(){}

protected:

  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();
  virtual Real computeQpOffDiagJacobian(unsigned jvar);

  // The specified value of the pressure.  This must be passed to the parent's
  // pressure_qp_residual function.
  Real _specified_pressure;
};

#endif // NSMOMENTUMINVISCIDSPECIFIEDPRESSUREBC_H
