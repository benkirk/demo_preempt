#!/bin/bash
#PBS -N hello_preempt
#PBS -A <project_code>
#PBS -j oe
#PBS -q preempt
#PBS -l walltime=00:15:00
#PBS -l select=8:ncpus=128:mpiprocs=128:ompthreads=1

### Set temp to scratch
export TMPDIR=/glade/gust/scratch/${USER}/temp && mkdir -p $TMPDIR

module list
make all

export PALS_HOSTFILE=${PBS_NODEFILE}

### Interrogate Environment
env | egrep "PBS|MPI|THREADS|PALS" | sort | uniq
[ ! -z ${PBS_NODEFILE} ] \
    && nodes_list=$(cat $PBS_NODEFILE | sort | uniq) \
    && nodes_list=${nodes_list//.ib0.cheyenne.ucar.edu/} \
    && nodes_list=${nodes_list//.hsn.gu.hpc.ucar.edu/} \
    && echo "NODES=\""${nodes_list}"\"" \
    || echo "NODES="$(hostname)

[ ! -z ${PBS_NODEFILE} ] && \
    [ -f ${PBS_NODEFILE} ] && \
    nranks=$(cat ${PBS_NODEFILE} | wc -l) && \
    nnodes=$(cat ${PBS_NODEFILE} | sort | uniq | wc -l) && \
    ppn=$((${nranks} / ${nnodes})) && \
    export PALS_NRANKS=${nranks} && \
    export PALS_PPN=${ppn} && \
    export PALS_HOSTFILE=${PBS_NODEFILE} || { echo "Cannot set up PALS"; exit 1; }


while true; do
    echo && echo && echo "Running the C MPI code..."
    mpiexec ./demo_mpi

done

echo && echo && echo "Done at $(date)"
