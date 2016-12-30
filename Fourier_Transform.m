function out = P1_MyFT(x0, t0, w0)
    x = inline(x0)
    out = []
    for w = w0
        ak = 0
        for t = t0
            ak = ak + x(t)*exp(-(i)*t*w)*(t0(3)- t0(2));
        end
        ak
        out(end + 1) = ak;
    end
    figure, plot(w0, abs(out))
end