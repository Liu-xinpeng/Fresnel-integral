% 计算菲涅耳积分主程序
% SJTU LXP 2022.11.27
close; clear; clc;
Int_i = IntFunction_i;      %实例化IntFunction接口

%% 计算F(5)=int(cos(pi()/2*t^2),t,0,5)
h = 0.01;
eps = 0.00000001;
f =@(t) cos(t.*t.*pi()./2);
f2 =@(t) sin(t.*t.*pi()./2);

Ft = IntByH(f,@Int_i.Ti,0,h,5);
Fm = IntByH(f,@Int_i.Mid,0,h,5);
Fs = IntByH(f,@Int_i.Sim,0,h,5);
Fr = IntByH(f,@Int_i.Rom,0,h,5);
[h Ft Fm Fs Fr]

% %定精度
% Ft1 = IntByEps(f,@Int_i.Ti,0,5,eps);
% Fm1 = IntByEps(f,@Int_i.Mid,0,5,eps);
% Fs1 = IntByEps(f,@Int_i.Sim,0,5,eps);
% Fr1 = IntByEps(f,@Int_i.Rom,0,5,eps);
% [eps Ft1 Fm1 Fs1 Fr1]

Ft2 = IntByH(f2,@Int_i.Ti,0,h,5);
Fm2 = IntByH(f2,@Int_i.Mid,0,h,5);
Fs2 = IntByH(f2,@Int_i.Sim,0,h,5);
Fr2 = IntByH(f2,@Int_i.Rom,0,h,5);
[h Ft2 Fm2 Fs2 Fr2]

et = abs(fresnelc(5)-Ft);
em = abs(fresnelc(5)-Fm);
es = abs(fresnelc(5)-Fs);
er = abs(fresnelc(5)-Fr);
[h et em es er]

et2 = abs(fresnels(5)-Ft2);
em2 = abs(fresnels(5)-Fm2);
es2 = abs(fresnels(5)-Fs2);
er2 = abs(fresnels(5)-Fr2);
[h et2 em2 es2 er2]

% 绘制变上限积分F(x)=int(cos(pi()/2*t^2),t,0,x)
% 采用定精度的求积公式,和已有库函数比较
x = -20:0.1:20;

subplot(2,2,1);
plot(x,IntByEps(f,@Int_i.Rom,0,x,eps),'k--',x,fresnelc(x),'r*')
set(gca,'linewidth',1,'fontsize',18,'fontname','Times New Roman');
grid on
xlabel('x');
ylabel('Romberg-C(x)');
title('Romberg-C(x) Compare');
legend('self function','system function','Location','SouthEast');

subplot(2,2,2);
plot(x,IntByEps(f,@Int_i.Sim,0,x,eps),'k--',x,fresnelc(x),'r*')
set(gca,'linewidth',1,'fontsize',18,'fontname','Times New Roman');
grid on
xlabel('x');
ylabel('Simpson-C(x)');
title('Simpson-C(x) Compare');
legend('self function','system function','Location','SouthEast');

% figure(3);
% plot(x,IntByEps(f,@Int_i.Ti,0,x,eps))
% grid on
% figure(4);
% plot(x,IntByEps(f,@Int_i.Mid,0,x,eps))
% grid on

subplot(2,2,3);
plot(x,IntByEps(f2,@Int_i.Rom,0,x,eps),'k--',x,fresnels(x),'r*')
set(gca,'linewidth',1,'fontsize',18,'fontname','Times New Roman');
grid on
xlabel('x');
ylabel('Romberg-S(x)');
title('Romberg-S(x) Compare');
legend('self function','system function','Location','SouthEast');

subplot(2,2,4);
plot(x,IntByEps(f2,@Int_i.Sim,0,x,eps),'k--',x,fresnels(x),'r*')
set(gca,'linewidth',1,'fontsize',18,'fontname','Times New Roman');
grid on
xlabel('x');
ylabel('Simpson-S(x)');
title('Simpson-S(x) Compare');
legend('self function','system function','Location','SouthEast');

% 一些菲涅尔积分的有趣图像
x1 = -10:0.01:10;
figure(7);
plot(IntByEps(f,@Int_i.Sim,0,x1,eps),IntByEps(f2,@Int_i.Sim,0,x1,eps),'k')
set(gca,'linewidth',1,'fontsize',18,'fontname','Times New Roman');
grid on
xlabel('C(x)');
ylabel('S(x)');

% figure(8);
% plot(x1,(IntByEps(f,@Int_i.Sim,0,x1,eps).^2 + IntByEps(f2,@Int_i.Sim,0,x1,eps).^2))
% grid on

% %% 设置被积函数
% function y= f(t)
% y = t.t;
% % y = cos(t.*t.*pi()./2);
% %y = sin(t.*t.*pi()./2);
% end