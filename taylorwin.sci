//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
//the function is for application on vectors only
function w=taylorwin(n,nbar,sll)
    [nargout,nargin]=argn();
    if nargin==1 then
        nbar=4;
        sll=-30;
    elseif nargin==2
        sll=-30;
    end
    if type(n)~=1 | type(nbar)~=1 | type(sll)~=1 then
        error('check the data type of input'); //to check if the inputs are real/complex arrays
    end
    
    if size(n)~=[1,1] then
        error('check the data type of input'); //to check that n is single dimensional
    end
    if floor(n)~=n | imag(n)~=0 then
        error('check that n is an integer');//to check if n is an integer
    end
    
    if size(nbar)~=[1,1] then
        error('check the data type of input'); //to check that nbar is single dimensional
    end
    if floor(nbar)~=nbar | imag(nbar)~=0 then
        error('check that nbar is an integer');//to check if nbar is an integer
    end
    
    if size(sll)~=[1,1] then
        error('check the data type of input'); //to check that sll is single dimensional
    end
    if sll>0 | imag(sll)~=0 then
        error('check that sll is a negative number');//to check if sll is a negative no.
    end
    
    B=10^(-sll/20);
    A=log(B+sqrt(B*B-1))/%pi;
    sig=nbar*nbar/(A*A+(nbar-0.5)*(nbar-0.5));
    //computing Fm (the coefficients for the cosines
    m=ones(nbar-1,1)*[1:nbar-1];
    i=([1:nbar-1])'*ones(1,nbar-1);
    M=((1-((m.*m/sig)./(A*A+(i-0.5).*(i-0.5)))));//./(1-(m.*m)./(i.*i)));
    m=[1:nbar-1];
    F=prod(M,1).*((-1)^(m+1));
    for m=1:nbar-1
        j=[[1:m-1],[m+1:nbar-1]];
        F(m)=F(m)/prod((1-(m.*m)./(j.*j)));
    end
    //computing the window
    nv=ones(nbar-1,1)*([0:n-1]);
    m=([1:nbar-1])'*ones(1,n);
    M=cos(2*%pi*m.*(nv-(n-1)/2)/n);
    w=ones(1,n)+F*M;
endfunction
