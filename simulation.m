% simulation
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%% digital input setting %%%%%%%%%%%%%%%%%%%%%%
A = 1;
B = 1;
C = 0;
D = 1;
E = 1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% fast verification %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [S,C] = FA_ver1(1,0,0)

RCA_2bit_ver1([1 1],[0 1],1)

% OR_ver1(1,1) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% digital to analog conversion %%%%%%%%%%%%%%%%%%%%%%%

in_A = DAC_ver2(A);
in_B = DAC_ver2(B);
in_C = DAC_ver2(C);
in_D = DAC_ver2(D);
in_E = DAC_ver2(E);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% simulation circuit %%%%%%%%%%%%%%%%%%%%%%%%%
% % OR_out = OR_ver2(in_A,in_B);
% % OR_out = OR_ver2(OR_out,in_B);
% % 
% % OR_out(1)^2/0.153^2

% % NOT_ver2(in_A)

% mux2to1_ver2(in_A,in_B,in_C)

[S,C] = FA_ver2(in_A,in_B,in_C);
% (C(1)/0.153)^2
% (S(1)/0.153)^2

in1 = [in_A; in_B];
in2 = [in_C; in_D];
X = RCA_2bit_ver2(in1,in2,in_E);

% % XOR_ver2(in_A,in_B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


