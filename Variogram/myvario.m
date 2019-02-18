function myvario(data,co,c,a)
clf;
% This function is for variogram fitting
dl=length(data);
dis=data(1:end,1)
maxd=max(dis);
gam=data(1:end,2);
y=[];
xc=[];
for x=0:5:maxd
    %yg=co+c.*(1-exp(-3.*x.*x/a^2));
    if (x<=a)
        yg=co+(c-co).*((1.5.*x./a)-(0.5.*x.^2./a.^2));
    else
        yg=c;
    end
    y = [y;yg];
    xc = [xc;x];
end;
plot(xc,y,'b-');
hold on;
myg=max(gam);
myg=1.1*myg;
maxd=max(dis)
plot(dis,gam,'.');
axis([0.0,maxd,0,myg]);