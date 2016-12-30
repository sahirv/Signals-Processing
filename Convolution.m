clear;

%test inputs
input1 = 0.01:0.01:2;
input2 = ones(1,100);
dT = 0.01;

%variables x and y are assigned
if (size(input1, 2) > size(input2, 2))
    x = input1;
    y = input2;
else
    x = input2;
    y = input1;
end

z = [];

%flips the array over as should be done in convolution y(k) --> y(-k)
y = y(end:-1:1);

%for loop to shift signal y from 1 to len(y) + len(x) + 2
for n = 1:((size(y,2)+size(x,2)+2))
    sum = 0;
    m = 0;
    for m = 1:size(y,2)
        %if overlap occurs, sum all the products, if not, add 0
        if ((n-m) > 0 && n-m < (size(x,2)+1))
            sum = sum + x(1,n-m)*y(1,size(y,2)- m + 1)*dT;
        else
            sum = sum + 0;
        end
    end
    z = [z sum];
end

figure, plot(z)