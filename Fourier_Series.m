%inputs are sampling frequency, function x (with time period included,
%and function y (with time period included)
%For example: AQ1b(100,sin(0:0.01:2*pi),2*cos(0:0.01:4*pi))
%For example: AQ1b(10,ones(1,100),ones(1,10))

function z = AQ1b(f, input1, input2) 
    if (size(input1, 2) > size(input2, 2))
        x = input1;
        y = input2;
    else
        x = input2;
        y = input1;
    end
    
    dT =1/f;
    z = [];
    y = y(end:-1:1);
    
    for n = 1:((size(y,2)+size(x,2)+2))
        sum = 0;
        m = 0;
        for m = 1:size(y,2)
            if ((n-m) > 0 && n-m < (size(x,2)+1))
                sum = sum + x(1,n-m)*y(1,size(y,2)- m + 1)*dT;
            else
                sum = sum + 0;
            end
        end
        z = [z sum];
    end
    figure, plot(z)
end






