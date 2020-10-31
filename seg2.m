function [X, Y, theta, curv] = seg2(x, y, Node, k2, l)

kc = k2*l^2/2; % Բ������
curv = kc;

X0 = Node(1,1); Y0 = Node(2,1); theta0 = k2*l^3/4; % Բ�����
Xo = X0 - 1/kc*sin(theta0); Yo = Y0 + 1/kc*cos(theta0); % Բ��
thetak = acos( ([X0 Y0]-[Xo Yo]) * ([x y]-[Xo Yo])' / (1/kc) / norm([x y]-[Xo Yo]) ); % ��ת��

tmp_x = 1/kc*sin(thetak);
tmp_y = 1/kc - 1/kc*cos(thetak);
X = X0+tmp_x*cos(theta0)-tmp_y*sin(theta0);
Y = Y0+tmp_x*sin(theta0)+tmp_y*cos(theta0);
theta = thetak + theta0;
