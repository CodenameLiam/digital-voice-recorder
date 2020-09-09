fsamp = 15.625e3;           % Sample rate, Hz
fs = fsamp/2;               % Stopband frequency, Hz
fp = 2780;                  % Passband frequency, Hz

wp = 2*pi*fp;               % Stopband frequency, rad/s
ws = 2*pi*fs;               % Passband frequency, rad/s

Amin = 20*log10(1/2^8);     % min. stopband attentuation, dB
Amax = 1.3;                 % max. passband attentuation, dB

[n_butt, wn_butt] = buttord(wp, ws, Amax, Amin, 's');
[n_cheb, wn_cheb] = cheb1ord(wp, ws, Amax, Amin, 's')

[b, a] = cheby1(n_cheb, Amax, wn_cheb, 'low', 's');

H = tf(b, a)       % Define transfer function
%bodemag(H);            % Plot transfer function freq resp.

[z, p, k] = tf2zpk(b, a);   % Factor polynomial to find pole pairs 

c1 = -p(1)-p(2);            % Calculate wn/Q (1)
c2 = p(1)*p(2);             % Calculate wn^2 (1)
c3 = -p(3)-p(4);            % Calculate wn/Q (2)
c4 = p(3)*p(4);             % Calculate wn^2 (2)

wn1 = sqrt(c2)              % Calculate wn (1)
Q1 = wn1/c1                 % Calculate Q (1)

wn2 = sqrt(c4)              % Calculate wn (2)
Q2 = wn2/c3                 % Calculate Q (2)

% wnHz = wn/(2*pi);   % Hz

% Using unity gain, ratio between R1, R2 and C1, C2
bodemag(H);            % Plot transfer function freq resp.
hold on
plot(1500*(2*pi), -0.02, 'ro')
plot(2800*(2*pi), -1.7, 'ro')
plot(4000*(2*pi), -17.52, 'ro')
plot(7800*(2*pi), -47.23, 'ro')