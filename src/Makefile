

# Update the following lines to your system requirements
#AURYNPATH=$(HOME)/auryn
AURYNPATH = /mnt/c/Users/pauls/Desktop/work/auryn

# Path to Auryn include files (auryn.h)
AURYNINC=$(AURYNPATH)/src

# Path to Auryn library (libauryn.a)
AURYNLIB=$(AURYNPATH)/build/release/src



# The following should not require updating in most cases 
CC = mpic++
CFLAGS=-ansi -pipe -O3 -march=native -ffast-math -pedantic -I/usr/include -I$(AURYNINC) -I/usr/local/include
LDFLAGS=$(AURYNLIB)/libauryn.a -lboost_filesystem -lboost_system -lboost_program_options -lboost_mpi -lboost_serialization 
SIMFILES=sim_script
OBJFILES=P10Connection.o GlobalPFConnection.o 
#OBJFILES=P10Connection.o P11Connection.o P12Connection.o GlobalPFConnection.o P10ConnectionP.o P10Connection_delayed.o P10Connection_nocons_dirty.o

.SECONDARY:

simfiles: $(SIMFILES)

sim_%: sim_%.o $(OBJFILES) 
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $(subst .o,,$<)

%.o : %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *~ *.o core a.out *.log *.a $(SIMFILES)

