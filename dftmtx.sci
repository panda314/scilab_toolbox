//Parthasarathi Panda
//parthasarathipanda@gmail.com
function [H]=dftmtx(n)
    v=[0:n-1];
    M=(v')*v;//generating Matrix M with Mij=(i-1)*(j-1)
    H=exp(-2*%pi*%i*M/n);//Ech entry is exp(2pi*i*(k-1)*(l-1)/N) where k,l are row and column indices
    //checked on n=3 and 5 and compared with matlab output
endfunction
