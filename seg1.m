function [X, Y, theta, curv] = seg1(x, y, sk, skh, skp, k2, l)

% µÚÒ»¶Î ÂİĞıÏß
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
    theta = k2/3*skp^3;
    curv = k2*skp^2;
else
    cosskp = cos(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp);
    sinskp = sin(k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp);
    theta = k2*l^3/12-k2/3*skp^3+k2*l*skp^2-k2*l^2/2*skp;
    curv = -k2*skp^2+2*k2*l*skp-k2*l^2/2;
end
X = x + (skp-sk)/6*(cossk+4*cosskh+cosskp);
Y = y + (skp-sk)/6*(sinsk+4*sinskh+sinskp);
