function yg=myvarifit(co,c,a,type,x)%,data)
% This function is for covariance modeling fitting
%Target covariance
lenx=length(x);
for i=1:lenx
    if(type==1)
    %Spherical covariance
        if(x(i)<a)
            yg(i)=co+(c-co).*((1.5.*x(i)./a)-(0.5.*x(i).^3./a.^3));
        else 
            yg(i)=c;
        end
    end;
    if(type==2)
    %Gaussian Covariance
        yg(i)=co+(c-co).*(1-exp((-3.*x(i).^2)/a.^2)); 
    end;
    if(type==3)
    %Exponential Covariance
        yg(i)=co+(c-co).*(1-exp((-3.*x(i))/a)); 
    end;
end
%{
plot(x,yg)
hold on;
plot(data(:,1),data(:,2),'.');
%}