# vmec_multiple_readin
Minimal example showing a problem with calling runvmec multiple times with readin_flag set.

I would like to be able to call vmec from an outside application using the `runvmec` function,
using several different input files in succession. However I find that when `runvmec` is called more than once with `readin_flag` set, it crashes with an allocation error.
This repository contains a minimal example that demonstrates this behavior.

To build the example, you first need to run `make`. The first few lines of `makefile` will likely need to be edited for your system.
When `make` succeeds, an executable `vmec_multiple_readin` will be created.

This program merely calls runvmec twice using the same input file. In a real scenario, the second input file would be different than the first, but here we use the same input file twice for simplicity.

If the `vmec_multiple_readin` executable is called with no arguments, `runvmec` is called twice, with `readin_flag` set only for the first run. Everything works fine. However, if any arguments are provided to `vmec_multiple_readin`, then `readin_flag` is set for both calls to `runvmec`. In this case I get an error message
~~~~
 Run 2:
 Including readin_flag
STOP allocation error in fixaray: istat1
~~~~
