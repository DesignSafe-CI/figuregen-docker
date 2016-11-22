# figuregen-docker
Docker container for running FigureGen

To run your own input, mount your data to the `/data` volume and
specify the traditional invocation command. In the following example,
a file in the current directory named `FG51.inp` is passed into FigureGen.

> docker run -it --rm -v `pwd`:/data stevemock/figuregen-docker /bin/sh -c 'FigureGen.out -I FG51.inp'

After FigureGen completes running, all output data will appear in your
current directory.

Configure your input '.inp' file like so:

Use '/usr/lib/gmt/bin/' for the Path where GMT executables are located and '/usr/bin/' for the Path where GhostScript executable is located.

See FG51.inp for a working example of an input file. This does not include the rest of the input data, however, and will not run as is.
