/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#include "NodalBC.h"
#include "MooseVariable.h"


template<>
InputParameters validParams<NodalBC>()
{
  InputParameters params = validParams<BoundaryCondition>();
  params += validParams<RandomInterface>();

  return params;
}


NodalBC::NodalBC(const std::string & name, InputParameters parameters) :
    BoundaryCondition(name, parameters),
    RandomInterface(name, parameters, _fe_problem, _tid, true),
    CoupleableMooseVariableDependencyIntermediateInterface(parameters, true),
    _current_node(_var.node()),
    _u(_var.nodalSln())
{
}

void
NodalBC::computeResidual(NumericVector<Number> & residual)
{
  if (_var.isNodalDefined())
  {
    dof_id_type & dof_idx = _var.nodalDofIndex();
    _qp = 0;
    residual.set(dof_idx, computeQpResidual());
  }
}

void
NodalBC::computeJacobian(SparseMatrix<Number> & /*jacobian*/)
{
  mooseError("This shouldn't be called!");
}
