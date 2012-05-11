[Mesh]
  file = pl_test5q.e
  displacements = 'disp_x disp_y'
[]

[Variables]
  [./disp_x]
    order = SECOND
    family = LAGRANGE
  [../]
  [./disp_y]
    order = SECOND
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./distance]
    order = SECOND
    family = LAGRANGE
  [../]
  [./tangential_distance]
    order = SECOND
    family = LAGRANGE
  [../]
  [./normal_x]
    order = SECOND
    family = LAGRANGE
  [../]
  [./normal_y]
    order = SECOND
    family = LAGRANGE
  [../]
  [./closest_point_x]
    order = SECOND
    family = LAGRANGE
  [../]
  [./closest_point_y]
    order = SECOND
    family = LAGRANGE
  [../]
  [./element_id]
    order = SECOND
    family = LAGRANGE
  [../]
  [./side]
    order = SECOND
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./diff_x]
    type = Diffusion
    variable = disp_x 
  [../]
  [./diff_y]
    type = Diffusion
    variable = disp_y 
  [../]
[]

[AuxBCs]
  [./penetrate]
    type = PenetrationAux
    variable = distance
    boundary = 11            #slave
    paired_boundary = 12     #master
  [../]

  [./penetrate2]
    type = PenetrationAux
    variable = distance
    boundary = 12            #slave
    paired_boundary = 11     #master
  [../]

  [./penetrate3]
    type = PenetrationAux
    variable = tangential_distance
    boundary = 11
    paired_boundary = 12
    quantity = tangential_distance
  [../]

  [./penetrate4]
    type = PenetrationAux
    variable = tangential_distance
    boundary = 12
    paired_boundary = 11
    quantity = tangential_distance
  [../]

  [./penetrate5]
    type = PenetrationAux
    variable = normal_x
    boundary = 11
    paired_boundary = 12
    quantity = normal_x
  [../]

  [./penetrate6]
    type = PenetrationAux
    variable = normal_x
    boundary = 12
    paired_boundary = 11
    quantity = normal_x
  [../]

  [./penetrate7]
    type = PenetrationAux
    variable = normal_y
    boundary = 11
    paired_boundary = 12
    quantity = normal_y
  [../]

  [./penetrate8]
    type = PenetrationAux
    variable = normal_y
    boundary = 12
    paired_boundary = 11
    quantity = normal_y
  [../]

  [./penetrate9]
    type = PenetrationAux
    variable = closest_point_x
    boundary = 11
    paired_boundary = 12
    quantity = closest_point_x
  [../]

  [./penetrate10]
    type = PenetrationAux
    variable = closest_point_x
    boundary = 12
    paired_boundary = 11
    quantity = closest_point_x
  [../]

  [./penetrate11]
    type = PenetrationAux
    variable = closest_point_y
    boundary = 11
    paired_boundary = 12
    quantity = closest_point_y
  [../]

  [./penetrate12]
    type = PenetrationAux
    variable = closest_point_y
    boundary = 12
    paired_boundary = 11
    quantity = closest_point_y
  [../]

  [./penetrate13]
    type = PenetrationAux
    variable = element_id
    boundary = 11
    paired_boundary = 12
    quantity = element_id
  [../]

  [./penetrate14]
    type = PenetrationAux
    variable = element_id
    boundary = 12
    paired_boundary = 11
    quantity = element_id
  [../]

  [./penetrate15]
    type = PenetrationAux
    variable = side
    boundary = 11
    paired_boundary = 12
    quantity = side
  [../]

  [./penetrate16]
    type = PenetrationAux
    variable = side
    boundary = 12
    paired_boundary = 11
    quantity = side
  [../]
[]

[BCs]
  [./b1x]
    type = DirichletBC
    variable = disp_x
    boundary = 1
    value = 0
  [../]

  [./b1y]
    type = DirichletBC
    variable = disp_y
    boundary = 1
    value = 0
  [../]

  [./b2x]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = 2
    function = disp_x
  [../]

  [./b2y]
    type = FunctionDirichletBC
    variable = disp_y
    boundary = 2
    function = disp_y
  [../]
[]

[Functions]
  [./disp_x]
    type = PiecewiseLinear
    x = '0.0 1.0  1.3 1.9  2.0  3.0  3.1  4.1 4.2 5.2 5.3 6.3'
    y = '0.0 0.0 -0.3 0.3 -0.2 -0.2 -0.3 -0.3 0.2 0.2 0.3 0.3'
  [../]
  [./disp_y]
    type = PiecewiseLinear
    x = '0.0 1.0 2.0 3.0 3.1 4.1 4.2 5.2 5.3 6.3'
    y = '0.0 2.0 2.0 0.0 0.0 2.0 2.0 0.0 0.0 2.0'
  [../]
[]

[Executioner]
  type = Transient
  petsc_options = '-snes_mf_operator -ksp_monitor -snes_ksp_ew'

  nl_abs_tol = 1e-7
  l_max_its = 10

  start_time = 0.0
  dt = 0.10
  end_time = 6.3
  [./Quadrature]
    order = THIRD
  [../]
[]

[Output]
  file_base = pl_test5q_out
  output_initial = true
  interval = 1
  exodus = true
  perf_log = true
[]