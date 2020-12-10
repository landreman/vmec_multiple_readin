# Set STELLOPT_PATH if it is not already set.
STELLOPT_PATH=/Users/mattland/stellopt_github/mango/STELLOPT
LIBSTELL = $(STELLOPT_PATH)/LIBSTELL/Release/libstell.a
VMEC_DIR = $(STELLOPT_PATH)/VMEC2000
VMEC_OBJFILE = $(VMEC_DIR)/ObjectList
VMEC_OBJDIR = $(VMEC_DIR)/Release

FC = mpifort-mpich-gcc8
EXTRA_COMPILE_FLAGS = -ffree-line-length-none -I $(VMEC_OBJDIR) -g -O0
EXTRA_LINK_FLAGS = -L/opt/local/lib -lnetcdff  -lnetcdf -lscalapack -framework Accelerate

TARGET = vmec_multiple_readin

# ObjectFiles is defined in the next line:
include $(VMEC_OBJFILE)

# We can't have 2 mains, so remove vmec.o:
TEMP = $(filter-out vmec.o, $(ObjectFiles))
VMEC_OBJ = $(patsubst %.o, $(VMEC_OBJDIR)/%.o, $(TEMP))

.PHONY: all clean

all: $(TARGET)

%.o: %.f90
	$(FC) $(EXTRA_COMPILE_FLAGS) -c $<

$(TARGET): $(TARGET).o
	$(FC) -o $(TARGET) $(TARGET).o $(VMEC_OBJ) $(LIBSTELL) $(EXTRA_LINK_FLAGS)

clean:
	rm -f *.o *~ $(TARGET)
