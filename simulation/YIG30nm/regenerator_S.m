function [out_signal] = regenerator_S(in_signal)

% This function describes the behavior of the regenerator (DC+amplifier)
% for the sum bit output.
% This block regenerates the correct SW amplitude according to the logic
% value.

% The input and output variables are vectors, and they are composed in
% the following way:
% [amplitude(dimensionless), frequency [GHz], phase [rad]]


%%%%%%%%%%%%%%%%%%%%%%%% parameters setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gain_in = 8;
gain_interm = 2;

h=10;           % thinckness  [nm]
w=30;          % width  [nm]
L3=900;         % length of the coupling region  [nm]
L4=978;
gap=10;        % the gap between the second coupled waveguides [nm]
d=w+gap;       % [nm]
B=0;            % external field [mT]
cd common
SW_parameters % script
cd ..
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% input signal amplification %%%%%%%%%%%%%%%%%%%%%%%%%
DC3_akx = amplifier(in_signal,gain_in);
DC3_akx = DC3_akx(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% equations implementation %%%%%%%%%%%%%%%%%%%%%%%%%%%
dkx=1e-3;
kmax=0.04;
limitation = limitation2;
DC_design = [h, w, d, B];
cd common
[wm1, wm2, Tkx] = DC_equations(dkx, kmax, limitation, DC_design);
cd ..
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% regenerator operation %%%%%%%%%%%%%%%%%%%%%%%%%%%

k1=dkx:dkx:kmax;
ff1=wm1./(2*pi);
ff2=wm2./(2*pi);

delta_phase = 0;
dl=dx/2;
N_cycle = ceil(L3/dl);
for i1=1:N_cycle
    if i1 == N_cycle
        dl = L3 - (N_cycle-1)*dl;
    end
    DC3_akx = DC3_akx*exp(-dl/x_freepath);
    ff1_s = ff1+Tkx.*abs(DC3_akx).^2;
    ff2_s = ff2+Tkx.*abs(DC3_akx).^2;
    DC3_ks = interp1(abs(ff1_s),k1,SW_frequency);  % rad/nm
    DC3_kas = interp1(abs(ff2_s),k1,SW_frequency); % rad/nm
    delta_k = abs(DC3_ks-DC3_kas); % rad/nm
    delta_phase = delta_phase + delta_k*dl; % [rad], phase shift accumulated until this sub-interval
end


Lc_avg = pi*L3/delta_phase;  % [nm]
pow_par = cos(pi*L3/(2*Lc_avg))^2;
DC4_akx = DC3_akx * sqrt(pow_par);
DC4_akx = amplifier(DC4_akx,gain_interm);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DC4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delta_phase = 0;
dl=dx/2;
N_cycle = ceil(L4/dl);
for i1=1:N_cycle
    if i1 == N_cycle
        dl = L4 - (N_cycle-1)*dl;
    end
    DC4_akx = DC4_akx*exp(-dl/x_freepath);
    ff1_s = ff1+Tkx.*abs(DC4_akx).^2;
    ff2_s = ff2+Tkx.*abs(DC4_akx).^2;
    DC4_ks = interp1(abs(ff1_s),k1,SW_frequency);  % rad/nm
    DC4_kas = interp1(abs(ff2_s),k1,SW_frequency); % rad/nm
    delta_k = abs(DC4_ks-DC4_kas); % rad/nm
    delta_phase = delta_phase + delta_k*dl; % [rad], phase shift accumulated until this sub-interval
end

Lc_avg = pi*L4/delta_phase;  % [nm]
pow_par = cos(pi*L4/(2*Lc_avg))^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% outputs generation %%%%%%%%%%%%%%%%%%%%%%%%%%
out_signal = in_signal; % to have the same frequency and phase

% propagation delay
out_signal(4) = in_signal(4) + tpd_regS; 

% power splitting and amplification
out_signal(1) = DC4_akx * sqrt(1-pow_par);
% out_signal = amplifier(out_signal,gain_out);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end
