CC	= gcc
NVCC	= nvcc
CFLAGS	= -std=gnu11 -Ofast -c
NVFLAGS	= -O3 -DUSE_MAPPED_MEMORY -Xptxas "-abi=no -v" --restrict --use_fast_math

all:
	$(CC) $(CFLAGS) cpu-miner.c -o cpu-miner.o
	$(CC) $(CFLAGS) util.c -o util.o
	$(CC) $(CFLAGS) x11.c -o x11.o
	$(NVCC) $(NVFLAGS) -arch=compute_50 cpu-miner.o util.o x11.o x11.cu wildkeccak.cu -lcurl -ljansson -o cudaminerd

maxwell:
	$(CC) $(CFLAGS) cpu-miner.c -o cpu-miner.o
	$(CC) $(CFLAGS) util.c -o util.o
	$(CC) $(CFLAGS) x11.c -o x11.o
	$(NVCC) $(NVFLAGS) -arch=compute_50 cpu-miner.o util.o x11.o x11.cu wildkeccak.cu -lcurl -ljansson -o cudaminerd
	
kepler:
	$(CC) $(CFLAGS) cpu-miner.c -o cpu-miner.o
	$(CC) $(CFLAGS) util.c -o util.o
	$(CC) $(CFLAGS) x11.c -o x11.o
	$(NVCC) $(NVFLAGS) -arch=compute_35 cpu-miner.o util.o x11.o x11.cu wildkeccak.cu -lcurl -ljansson -o cudaminerd

clean:
	rm -rf *.o cudaminerd
