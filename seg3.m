function [X, Y, theta, curv] = seg3(x, y, sk, skh, skp, k2, l)

kc = k2*l^2/2;
dtheta = pi/2 - 2*k2*l^3/4; % 圆弧转角
theta0 = k2*l^3/4 + dtheta;
k2 = -k2;

% 第三段 螺旋线
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
    theta = k2/3*skp^3 + kc*skp + theta0;
    curv = k2*skp^2 + kc;
else
    cosskp = cos(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp + kc*skp + theta0);
    sinskp = sin(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp + kc*skp + theta0);
    theta = k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp + kc*skp + theta0;
    curv = -k2*skp^2+2*k2*l*skp-k2*l^2/2 + kc;
end
X = x + (skp-sk)/6*(cossk+4*cosskh+cosskp);
Y = y + (skp-sk)/6*(sinsk+4*sinskh+sinskp);
