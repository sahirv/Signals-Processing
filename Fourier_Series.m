function out = getAk(x, k, w0)
    %% All below are calculated
    T = 2*pi/w0;
    f = 1/T;
    dT = T/1000;
    ak = 0;
    for n = dT:dT:T
        ak = ak + x(n)*exp(-(i)*k*w0*n)*dT;
        end
    ak = (1/T)*ak;
    out = ak;
end