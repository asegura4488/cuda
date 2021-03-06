#include <stdio.h>
#include <iostream>

const int N = 1;

__global__
void add(int *a, int *b, int *c){
int tID = threadIdx.x;
if(tID < N) *c=*a+*b;
if(tID == N) *c=*a-*b;
}

int main( void ){
int a,b,c;
int *dev_a,*dev_b,*dev_c;
int size = sizeof(int);

a=3;b=2;c=0;

cudaMalloc( (void **)&dev_a, size );
cudaMalloc( (void **)&dev_b, size );
cudaMalloc( (void **)&dev_c, size );

cudaMemcpy(dev_a, &a, size, cudaMemcpyHostToDevice ); 
cudaMemcpy(dev_b, &b, size, cudaMemcpyHostToDevice ); 


add<<<1, 1>>>(dev_a, dev_b, dev_c);
cudaMemcpy(&c, dev_c, size, cudaMemcpyDeviceToHost);
std::cout << "ThreadIDx= " << "0" << std::endl; 
std::cout << " a=" << a << " b=" << b << " a+b=" << c << std::endl;

add<<<1, 2>>>(dev_a, dev_b, dev_c);
cudaMemcpy(&c, dev_c, size, cudaMemcpyDeviceToHost);
std::cout << "ThreadIDx= " << "1" << std::endl; 
std::cout << " a=" << a << " b=" << b << " a-b=" << c << std::endl;
 

cudaFree(dev_a);
cudaFree(dev_b);
cudaFree(dev_c);

//return EXIT_SUCCESS;
return 0;
}
