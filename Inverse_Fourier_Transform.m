function out = P1_MyiFT(xw0, w0, t0)
    xw = inline(xw0);
    out = []
    for t = t0
        rsum = 0
        for w = w0
            rsum = rsum + xw(w)*exp((i)*t*w)*(w0(3)- w0(2));
        end
        out(end + 1) = rsum ./ (2*pi);
    end
    figure, plot(t0, abs(out))
end