
clc;
clear;



% time-step of the solver 
ts = 2e-6;

% control frequency of the current loop 
f_cc = 1e4;
ts_cc = 1/f_cc;

% control frequency of the speed loop 
f_sc = 500;
ts_sc = 1/f_sc;

%%===================para motor===========================%%

rs = 10e-3;     %stator resistance
Ls_d = 0.365e-3; %stator inductance(d_axis)
Ls_q = 0.643e-3; %stator inductance(q_axis)
Lamda_pm = 0.074429;
pp = 6;         % pole pairs

J = 0.15;      % inertia (rotor + load?)

theta0 = 0;     % initial rotor position

%%===================para battery=========================%%
U_bat = 200;





%%================== load ================================%%
MotOpMod = 2;           % 1:constant speed; 2:depend on load torque 
nMotOpSpdMod = 1000*2*pi/60;    % only valid when MotOpMod = 1

%%===================controller===========================%%

n_max = 6000;               %maximum speed

%=== speed controller ===%
omega_sc = 30;
Kp_n = J*omega_sc;
Ki_n = 0.2*Kp_n*omega_sc*ts_sc;
Kc_n = 1/Kp_n;                  %reference to Prof Seung-Ki Sul
Te_min = -100;
Te_max = 100;


theta_mtpa = 0.1*pi;
r_dq = tan(theta_mtpa);

%=== current controller ===%
omega_cc = 2000;

Kp_id = Ls_d*omega_cc;
Ki_id = rs/Ls_d*ts_cc;          % pole-zero cancelling
Kc_id = 1/Kp_id;

Kp_iq = Ls_q*omega_cc;
Ki_iq = rs/Ls_q*ts_cc;
Kc_iq = 1/Kp_iq;

i_min = -140;
i_max = 140;

omega_lp = 1000;
lpa_cc = (2 - omega_lp*ts_cc)/(2. + omega_lp*ts_cc);	
lpb_cc = (omega_lp*ts_cc)/(2. + omega_lp*ts_cc);       	     


