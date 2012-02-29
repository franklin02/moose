from options import *

# In addition to testing the checks in the harness
# we will stress the dependencies a bit here too

test_compiler_check= { INPUT : '2d_diffusion_test2.i',
                       EXODIFF : ['out2.e'],
                       COMPILER : ['GCC'],
 }

test_platform_check= { INPUT : '2d_diffusion_test.i',
                       EXODIFF : ['out.e'],
                       PLATFORM : ['DARWIN'],
                       PREREQ : 'test_compiler_check'
 }

test_petsc_check= { INPUT : '2d_diffusion_test2.i',
                    EXODIFF : ['out2.e'],
                    PETSC_VERSION : ['3.1.0'],
                    PREREQ : 'test_compiler_check'
 }

test_parmesh_check= { INPUT : '2d_diffusion_test.i',
                      EXODIFF : ['out.e'],
                      MESH_MODE : ['SERIAL'],
                      PREREQ : 'test_platform_check'
 }

test_combined= { INPUT : '2d_diffusion_test.i',
                 EXODIFF : ['out.e'],
                 COMPILER : ['GCC'],
                 MESH_MODE : ['SERIAL'],
                 PLATFORM : ['DARWIN'],
                 PREREQ : 'test_parmesh_check'
 }

# This test should always be skipped
test_always_skipped = { INPUT : 'no_filename.i',
                        SKIP : 'Dependency Skip Test'
}

# This test won't run because of the failed depenedency
test_skip_depend_test = { INPUT : '2d_diffusion_test.i',
                          EXODIFF : ['out.e'],
                          PREREQ : 'test_always_skipped'
}


