//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function isstab=isstable(varargin)
    [nargout,nargin]=argn();
    if (nargin==2) then//(a,b) is the input
        a=varargin(1);
        b=varargin(2);
        //verifying type and length of input
        if type(a)~=1 | type(b)~=1 then
            error('check input type');
        end
        v=size(a);
        if length(v)>2 then
            error('check input dimension');
        end
        v=size(b);
        if length(v)>2 then
            error('check input dimension');
        end
        [n,k]=size(a);
        if k==1 then
            a=a';
        elseif n~=1 then
            error('check input dimension');
        end
        [n,k]=size(b);
        if k==1 then
            b=b';
            k=n;
        elseif n~=1 then
            error('check input dimension');
        end
    elseif (nargin==1) then//sos form is given as input
        sos=varargin(1);
        //verifying type and length of input
        if type(sos)~=1 then
            error('check input dimension');
        end
        v=size(sos);
        if length(v)>2 then
            error('check input dimension');
        end
        if v(2)~=6 then
            error('no. of columns must be 6');
        end
        a=1;b=1;
        //converting it to rational form
        for i=[1:v(1)]
            a=convol(a,sos(i,1:3));
            b=convol(b,sos(i,4:6));
        end
    else
        error('no. of inputs not matching');
    end
    if length(b)==1 then
        isstab=1;
    else
        poly_a=inv_coeff(a);//constructing numerator polynomial
        poly_b=inv_coeff(b);//constructing denominator polynomial
        gc=gcd([poly_a,poly_b]);//computing gcd to remove common roots
        [r,den]=pdiv(poly_b,gc);//dividing off gcd
        time_constant=min(abs(roots(den)));//finding the minumum magnitude pole
        if time_constant<=1 then//pole magnitude should be greater than 1
            disp('unstable system');
            isstab=0;
        else
            isstab=1;
        end
    end
endfunction
