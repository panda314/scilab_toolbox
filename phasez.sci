//Author: Parthasarathi Panda
//parthasarathipanda314@gmail.com
function [phi, varargout]=phasez(varargin)
    //cas variable is 2 if sos form is involved and 1 if direct rational form is given
    //(sos,n) or (sos,w) or (sos,'whole')or (b,a) is the input
    //cas variable is 2 if sos form is involved and 1 if direct rational form is given
    //cas1 variable is 1 if f is to be given as output, 2 other wise
    [nargout,nargin]=argn();
    //do not forget to execute 'phaseInputParseAs_sos' and 'phaseInputParseAs_ab' before running
    v=size(varargin(1));
    if size(v)>2 then
        error ('invalid input dimension');
    end
    [n,k]=size(varargin(1));
    if type(varargin(1))~=1 then
        error ('check the input type');
    end
    if (n==1 & k==6) then //not clear if sos or (a,b)
        v=size(varargin(2));
        if (nargin==1) //(sos) is the input
            cas=2;
            [sos,w,cas1,fs]=phaseInputParseAs_sos(varargin,nargin);
        elseif (varargin(2)=='whole') //(sos,'whole')is the input
            cas=2;
            [sos,w,cas1,fs]=phaseInputParseAs_sos(varargin,nargin);
        else //taking it as (a,b)
            cas=1;
            [a,b,w,cas1,fs]=phaseInputParseAs_ab(varargin,nargin);
        end
    elseif (n==1 | k==1) then
        cas=1;
        [a,b,w,cas1,fs]=phaseInputParseAs_ab(varargin,nargin);
    elseif k==6 then //first variable is sos
        cas=2;
        [sos,w,cas1,fs]=phaseInputParseAs_sos(varargin,nargin);
    end
    //cas,cas1,fs,w,[(a,b),sos]
    if cas==1 then
        [m,n]=size(a);
        N=[0:n-1];
        M=N'*w;//computing matrix Mij=(i-1)*wj
        ph_num=phasemag(a*exp(%i*M));//the operation computes phase of sum(ak*exp(i*w*k))
        
        [m,n]=size(b);
        N=[0:n-1];
        M=N'*w;
        ph_den=phasemag(b*exp(%i*M));//similar result for denominator
        [m,n]=size(w);
        phi=pmodulo(ph_num-ph_den,360);//takes the difference in phase modulo 360
    else
        N=[0,1,2];
        M=N'*w;
        ph_num=phasemag(sos(:,4:6)*exp(%i*M));
        ph_den=phasemag(sos(:,1:3)*exp(%i*M));//the numerator phases for each second order componenet
        phi_mat=ph_num-ph_den;
        [m,n]=size(w);
        phi=pmodulo(sum(phi_mat,1),360);//summing each of the componenet second order system phases
    end
    if cas1==1 then
        varargout(2)=w*fs/(2*%pi);
        if nargout>2 then
            varargout(3)=struct('plot', 'both', 'fvflag', 0, 'yunits','degrees','xunit','Hz','fs',fs);
        end
    else
        varargout(2)=w;
        if nargout>2 then
            varargout(3)=struct('plot', 'both', 'fvflag', 0, 'yunits','degrees','xunit','radian/sample','fs',[]);
        end
    end
endfunction
