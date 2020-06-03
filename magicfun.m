function [mp,ess,ts] = magicfun(sys_close)
t=0:0.01:5;
y=step(sys_close,t);
N=length(y);                                 %(4)超调量
    yss=y(N);
    mp=(max(y)-yss)/yss*100;
    
    ess=max(y)-yss;                               %稳态误差
    
    x=N;
    while abs(y(x)-yss)/yss<=0.02
        x=x-1;
    end
    ts=t(x);                                     %过渡过程时间
end

