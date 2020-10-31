clear
clc

k2 = 0.0025; % 曲率二阶系数
l = 7.5; % 过度曲线长度
kc = k2*l^2/2; % 圆弧曲率
dtheta = pi/2 - 2*k2*l^3/4; % 圆弧转角

% 绘制轨迹
spnum = 50; % 分段数
diff = l/(spnum/2);
X = 0; Y = 0; S = 0;
% 第一段 螺旋线
for i = 1:spnum/2
    sk = diff*(i-1); skh = sk + diff/2; skp = sk + diff;
    if sk <= l/2
        cossk = cos(k2/3*sk^3);
        sinsk = sin(k2/3*sk^3);
    else
        cossk = cos(k2*l^3/12-k2/3*sk^3+k2*l*sk^2-k2*l^2/2*sk);
        sinsk = sin(k2*l^3/12-k2/3*sk^3+k2*l*sk^2-k2*l^2/2*sk);
    end
    if skh <= l/2
        cosskh = cos(k2/3*skh^3);
        sinskh = sin(k2/3*skh^3);
    else
        cosskh = cos(k2*l^3/12-k2/3*skh^3+k2*l*skh^2-k2*l^2/2*skh);
        sinskh = sin(k2*l^3/12-k2/3*skh^3+k2*l*skh^2-k2*l^2/2*skh);
    end
    if skp <= l/2
        cosskp = cos(k2/3*skp^3);
        sinskp = sin(k2/3*skp^3);
    else
        cosskp = cos(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp);
        sinskp = sin(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp);
    end
    X = [X X(end)+diff/6*(cossk+4*cosskh+cosskp)];
    Y = [Y Y(end)+diff/6*(sinsk+4*sinskh+sinskp)];
    S = [S S(end)+diff];
end
Node = [X(end); Y(end); S(end)];
% 第二段 圆弧
spnum2 = 50;
X0 = X(end); Y0 = Y(end); theta0 = k2*l^3/4;
for i = 1:spnum2
    thetak = dtheta/spnum2*i;
    x = 1/kc*sin(thetak);
    y = 1/kc - 1/kc*cos(thetak);
    X = [X X0+x*cos(theta0)-y*sin(theta0)];
    Y = [Y Y0+x*sin(theta0)+y*cos(theta0)];
    S = [S S(end)+dtheta/kc/spnum2];
end
Node = [Node [X(end); Y(end); S(end)]];
% 第三段 螺旋线
theta0 = k2*l^3/4 + dtheta;
diff = l/(spnum/2);
k2 = -k2;
for i = 1:spnum/2
    sk = diff*(i-1); skh = sk + diff/2; skp = sk + diff;
    if sk <= l/2
        cossk = cos(k2/3*sk^3 + kc*sk + theta0);
        sinsk = sin(k2/3*sk^3 + kc*sk + theta0);
    else
        cossk = cos(k2*l^3/12-k2/3*sk^3+k2*l*sk^2-k2*l^2/2*sk + kc*sk + theta0);
        sinsk = sin(k2*l^3/12-k2/3*sk^3+k2*l*sk^2-k2*l^2/2*sk + kc*sk + theta0);
    end
    if skh <= l/2
        cosskh = cos(k2/3*skh^3 + kc*skh + theta0);
        sinskh = sin(k2/3*skh^3 + kc*skh + theta0);
    else
        cosskh = cos(k2*l^3/12-k2/3*skh^3+k2*l*skh^2-k2*l^2/2*skh + kc*skh + theta0);
        sinskh = sin(k2*l^3/12-k2/3*skh^3+k2*l*skh^2-k2*l^2/2*skh + kc*skh + theta0);
    end
    if skp <= l/2
        cosskp = cos(k2/3*skp^3 + kc*skp + theta0);
        sinskp = sin(k2/3*skp^3 + kc*skp + theta0);
    else
        cosskp = cos(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp + kc*skp + theta0);
        sinskp = sin(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp + kc*skp + theta0);
    end
    X = [X X(end)+diff/6*(cossk+4*cosskh+cosskp)];
    Y = [Y Y(end)+diff/6*(sinsk+4*sinskh+sinskp)];
    S = [S S(end)+diff];
end
k2 = -k2;
Node = [Node [X(end); Y(end); S(end)]];

plot(X,Y);
axis equal
hold on
plot([0 Node(1,:)], [0 Node(2,:)], '*');
ylabel('X(m)','FontName','simhei');
xlabel('Y(m)','FontName','simhei');
title('参考路径','FontName','simhei');

disp(['路径长度: ' num2str(dtheta/kc + 2*l) ' m']);
spl = 1:1:length(S);
out = [X(spl)' Y(spl)' S(spl)'];
% save('data.mat','out','Node','k2','l');