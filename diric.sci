//Parthasarathi Panda
//parthasarathipanda@gmail.com
function [y]=diric(x,n)
    //checked for [pi,2pi,3pi,4pi] and [1,2,3,4]
    y=sin(n*x/2)./(n*sin(x/2));
endfunction
