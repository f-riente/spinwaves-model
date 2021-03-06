function [tpd_DC] = DC_delay_calculation(lengths,model_parameters)

%SW_parameters % script

% type of DC
DC_type = size(lengths);
DC_type = DC_type(2); % =2 it's DC1 or DC2, =1 it's regS or regC
% lengths(1) is the length of coupling region, lengths(2) is the other
% regions one

if DC_type == 1
    tpd_DC = lengths/model_parameters.vgr_coup;      % [ns]
else
    tpd_DC = lengths(1)/model_parameters.vgr_coup + lengths(2)/model_parameters.vgr_sing;        % [ns] 
end

end

