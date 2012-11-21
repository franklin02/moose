#
# This is not very strong test since the problem being solved is linear, so the difference between
# full Jacobian and block diagonal preconditioner is not that big
#

[Mesh]
  type = GeneratedMesh
	dim = 2
	xmin = 0
	xmax = 1
	ymin = 0
	ymax = 1
	nx = 3
	ny = 3
	elem_type = QUAD4
[]

[Variables]
	active = 'u v'

  [./u]
    order = FIRST
    family = LAGRANGE
  [../]

  [./v]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    off_diag_row    = 'u'
    off_diag_column = 'v'
  [../]
[]

[Kernels]
  active = 'diff_u diff_v'
#  active = 'diff_u conv_u diff_v'

  [./diff_u]
    type = Diffusion
    variable = u
  [../]

  [./conv_u]
    type = CoupledForce
    variable = u
    v = v
  [../]

  [./diff_v]
    type = Diffusion
    variable = v
  [../]
[]

[BCs]
  active = 'left_u right_u left_v'
#  active = 'left_u right_u left_v'

  [./left_u]
    type = DirichletBC
    variable = u
    boundary = 1
    value = 1
  [../]

  [./right_u]
    type = DirichletBC
    variable = u
    boundary = 3
    value = 9
  [../]

  [./left_v]
    type = DirichletBC
    variable = v
    boundary = 1
    value = 5
  [../]

  [./right_v]
    type = DirichletBC
    variable = v
    boundary = 2
    value = 2
  [../]
[]

[Executioner]
  type = Steady

#  l_max_its = 1
#  nl_max_its = 1

#	nl_rel_tol = 1e-10

  petsc_options = '-snes_mf_operator'

  [./Adaptivity]
    steps = 3
    print_changed_info = true
    coarsen_fraction = 0.
    refine_fraction = 0.01
    max_h_level = 5
  []
[]

[Output]
  output_initial = true
  interval = 1
  exodus = true
  perf_log = true
[]