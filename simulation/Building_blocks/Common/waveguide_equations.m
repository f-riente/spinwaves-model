function [wm0, DC_Tkx] = waveguide_equations(dkx, kmax, limitation, waveguide_design)

h = waveguide_design(1);
w = waveguide_design(2);
B = waveguide_design(3);

%%%%%%%%%%%%%%%%%% physical parameters (constants) %%%%%%%%%%%%%%%%%%%%
DC_physical_parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% output vectors creation (to reduce the computation time)%%%%%%
N = size(dkx:dkx:kmax);
N = max(N);
wm0 = zeros(1,N);
DC_Tkx = zeros(1,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%% equations implementation %%%%%%%%%%%%%%%%%%%%%
i1=1;
for kx=dkx:dkx:kmax                       

    f1=@(ky)(abs(2*sqrt(2./(1+sinc(k*w./pi))).*(ky.*cos(k.*w./2).*sin(ky.*w./2)-k.*(cos(ky.*w./2).*sin(k.*w./2)))./(ky.^2-k.^2))).^2./w.*ky.^2./(kx.^2+ky.^2).*(1-(1-exp(-sqrt(kx.^2+ky.^2).*h))./(sqrt(kx.^2+ky.^2).*h))./(2*pi);
    f2=@(ky)(abs(2*sqrt(2./(1+sinc(k*w./pi))).*(ky.*cos(k.*w./2).*sin(ky.*w./2)-k.*(cos(ky.*w./2).*sin(k.*w./2)))./(ky.^2-k.^2))).^2./w.*((1-exp(-sqrt(kx.^2+ky.^2).*h))./(sqrt(kx.^2+ky.^2).*h))./(2*pi);

    Fkxyy0(i1)=integral(f1,-limitation,limitation);                                                                                                       %integral
    Fkxzz0(i1)=integral(f2,-limitation,limitation);                                                                                                       %integral
    
    wm0(i1)=sqrt((Wh+Wm*(Le.^2.*(kx.^2+Ky.^2)+Fkxyy0(i1))).*(Wh+Wm*(Le.^2.*(kx.^2+Ky.^2)+Fkxzz0(i1))));
  
    % nonlinear shift coefficient Tkx calculation
    Akx(i1) = Wh+Wm/2.*(2*(Le.^2).*(kx.^2+Ky.^2)+Fkxyy0(i1)+Fkxzz0(i1));  % [rad/ns]
    Bkx(i1) = Wm/2.*(Fkxyy0(i1)-Fkxzz0(i1));  % [rad/ns]

    f5=@(ky)(abs(2*sqrt(2./(1+sinc(k*w./pi))).*(ky.*cos(k.*w./2).*sin(ky.*w./2)-k.*(cos(ky.*w./2).*sin(k.*w./2)))./(ky.^2-k.^2))).^2./w.*(2*kx).^2./((2*kx).^2+ky.^2).*(1-(1-exp(-sqrt((2*kx).^2+ky.^2).*h))./(sqrt((2*kx).^2+ky.^2).*h))./(2*pi);
    F2kxxx0(i1) = integral(f5,-limitation,limitation); 
    
    DC_Tkx(i1) = (Wh-Akx(i1)+Bkx(i1).^2./(2*wm0(i1).^2).*( Wm.*(4*Le.^2.*(kx.^2+Ky.^2)+F2kxxx0(i1))+3*Wh))./(2*pi);  % [GHz]    
    i1=i1+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

