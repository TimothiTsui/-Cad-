function [mp,ess,ts] = magicfun(sys_close)
t=0:0.01:5;
y=step(sys_close,t);
N=length(y);                                 %(4)������
    yss=y(N);
    mp=(max(y)-yss)/yss*100;
    
    ess=max(y)-yss;                               %��̬���
    
    x=N;
    while abs(y(x)-yss)/yss<=0.02
        x=x-1;
    end
    ts=t(x);                                     %���ɹ���ʱ��
end

