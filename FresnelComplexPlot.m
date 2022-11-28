%此文件绘制复函数菲涅尔积分模值的三维图，计算速度较慢
%可能5min计算完，龟速的原因不知
%默认0-10^8范围，手动调节颜色bar
clear,clc;
t = -2:.01:2;
[x,y] = meshgrid(t);%形成格点矩阵

%计算复函数情况下的模值
f = real(fresnelc(x+1j*y)).^2+imag(fresnelc(x+1j*y)).^2;
f2 = real(fresnels(x+1j*y)).^2+imag(fresnels(x+1j*y)).^2;

%C(x)
subplot(1,2,1);
mesh(x,y,f);
set(gca,'fontsize',18,'fontname','Times New Roman');
grid on
xlabel('x');
ylabel('y');
title('|C(x+iy)|^2');
axis([-2 2 -2 2 -5 100]);
colormap parula
colorbar


%S(x)
subplot(1,2,2);
mesh(x,y,f2);
set(gca,'fontsize',18,'fontname','Times New Roman');
grid on
xlabel('x');
ylabel('y');
title('|S(x+iy)|^2');
axis([-2 2 -2 2 -5 100]);

colormap parula
colorbar
