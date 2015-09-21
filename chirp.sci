//Parthasarathi Panda
//parthasarathipanda@gmail.com
//t is the array over which thee chirp is computed
//f0 is the frequency at t=0
//f1 is the frequency at t=t1
//phi is the phase at t=0 (0 optional)
//method indicates the way in which frequency varies (quadratic,linear or logarithmic) and is linear when unspecified
//tested for t=[1:5], f0=0 and 1 t1=100, f1=5, all possible methods, phi=0,pi/3
function [y]=chirp(t,f0,t1,f1,method,phi)
    [lhs,rhs]=argn();
    if (rhs<6) then
        phi=0; 
        if (rhs<5) then
            method="linear";
        end
    end
    if ((method=="li") | (method=="linear")) then
        b=(f1-f0)/t1;
        y=cos(phi+2*%pi*(f0*t+0.5*b*t.*t));
    elseif ((method=="q") | (method=="quadratic")) then
        b=(f1-f0)/(t1*t1);
        y=cos(phi+2*%pi*(f0*t+b*t.*t.*t/3));
    elseif ((method=="lo") | (method=="logarithmic")) then
        if f0==0 then
            error("f0 must be non zero");
        else
            b=(f1/f0)^(1/t1);
            y=cos(phi+2*%pi*(f0*(b.^t)/log(b)));
        end
    else 
        error("unidentified method");
    end,
endfunction
