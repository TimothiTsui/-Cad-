function [mp,ess,Ts] = magicfun(y)
t=0:0.01:5;
N=length(y);                                 %(4)������
    yss=y(N);
    mp=(max(y)-yss)/yss*100;
    
    ess=max(y)-yss;                               %��̬���
    
    x=N;
    while abs(y(x)-yss)/yss<=0.02
        x=x-1;
    end
    Ts=t(x);                                     %���ɹ���ʱ��
end

