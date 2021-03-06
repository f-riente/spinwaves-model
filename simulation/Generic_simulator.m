
% Generic simulator

% This interface script allows to simulate all the circuit of "Circuits"
% folder
% To run the script you must set all the parameters of "simulation setting"
% section.


% A_bin, B_bin, C_bin and D_bin are binary inputs of the circuit. You can
% set more than one simulation using multiple rows of the inputs: every row
% is a std_logic_vector(MSB downto LSB) that will be used for a single
% simulation. In that case, the code runs a number of simulations
% equal to the number of the input A (rows). The inputs can be modified
% only through the GUI

% You simulate the following circuits:
%  1) AND(A,B)
%  2) AND4(A,B,C,D)
%  3) N-bit Carry_skip_adder(A,B,C), where the C is the carry_in
%  4) FA(A,B,C), where the C is the carry_in
%  5) HA(A,B)
%  6) Mux2to1(A,B,C), where the C is the selector
%  7) NOT(A)
%  8) OR(A,B)
%  9) N-bit RCA(A,B,C), where the C is the carry_in
%  10) waveguide(A,Lw), it is the magnonic "wire" for interconnections
%  11) XOR(A,B)


Lw = 7000;   % it is the length of "waveguide" block, [nm]

titleFontSize = 25;   % title FontSize of the plots
axisFontSize = 13;    % axes FontSize of the plots
labelFontSize = 20;   % labels FontSize of the plots
legendFontSize = 14;  % legend FontSize of the plots
line_width = 2;       % LineWidth of the lines  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Choosing of model category %%%%%%%%%%%%%%%%%%%
switch model 
    case 'YIG 100nm'
        model_path = 'simulation/Building_blocks/YIG100nm_Physical_model';
    case 'YIG 30nm'
        model_path = 'simulation/Building_blocks/YIG30nm_Physical_model';  
end
addpath(model_path)
addpath('simulation/Building_blocks/Common')
addpath('simulation/Circuits')

SW_parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% simulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size_A = size(A_bin);
N_simulation = size_A(1);
Nbit = size_A(2);
analyzed_figures = 0;
for ii = 1:N_simulation
    switch circuit
        case 'AND(A,B)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('"\n')
            AND_out = AND(A, B,model_parameters, plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                %ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'AND4(A,B,C,D)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            C = DAC(C_bin(ii,:),model_parameters);
            D = DAC(D_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('", C = "')
            fprintf('%d',C_bin(ii,:))
            fprintf('", D = "')
            fprintf('%d',D_bin(ii,:))
            fprintf('"\n')
            AND4_out = AND4(A, B, C, D,model_parameters, plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'N-bit Carry_skip_adder(A,B,C=Carry_in)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            C = DAC(C_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('", C = "')
            fprintf('%d',C_bin(ii,:))
            fprintf('"\n')
            CSA_out = carry_skip_adder(A, B, C, Nbit,model_parameters, plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'FA(A,B,C)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            C = DAC(C_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('", C = "')
            fprintf('%d',C_bin(ii,:))
            fprintf('"\n')
            [FA_S,FA_C] = FA(A,B,C,model_parameters,plot_info,opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                %ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'HA(A,B)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('"\n')
            [HA_S,HA_C] = HA(A, B,model_parameters,plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                %ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'Mux2to1(A,B,C=sel)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            C = DAC(C_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('", C = "')
            fprintf('%d',C_bin(ii,:))
            fprintf('"\n')
            MUX2TO1_out = mux2to1(A,B,C,model_parameters,plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'NOT(A)'
            A = DAC(A_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('"\n')
            NOT_out = NOT(A,model_parameters,plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'OR(A,B)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('"\n')
            OR_out = OR(A,B,model_parameters,plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'N-bit RCA(A,B,C=Carry_in)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            C = DAC(C_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('", C = "')
            fprintf('%d',C_bin(ii,:))
            fprintf('"\n')
            RCA_out = RCA_Nbit(A,B,C,Nbit,model_parameters,plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'waveguide(A,Lw)'
            A = DAC(A_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d"\n',A_bin(ii,:))
            waveguide_out = waveguide(A, Lw,model_parameters, opt_parameters{:});
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
            
        case 'XOR(A,B)'
            A = DAC(A_bin(ii,:),model_parameters);
            B = DAC(B_bin(ii,:),model_parameters);
            fprintf('Simulation %d:  A = "',ii)
            fprintf('%d',A_bin(ii,:))
            fprintf('", B = "')
            fprintf('%d',B_bin(ii,:))
            fprintf('"\n')
            XOR_out = XOR(A,B,model_parameters,plot_info, opt_parameters{:})
            figures = findobj(0,'Type','Figure');
            New_figures = 0;
            for j=1:max(size(figures))-analyzed_figures % for each plot
                ax = figures(j).CurrentAxes;
                ax.Title.String = 'Simulation ' + string(ii);
                ax.Title.FontSize = titleFontSize;
                ax.Legend.FontSize = legendFontSize;
                ax.XAxis.FontSize = axisFontSize;
                ax.YAxis.FontSize = axisFontSize;
                ax.XLabel.FontSize = labelFontSize;
                ax.YLabel.FontSize = labelFontSize;
                New_figures = New_figures + 1;
            end
            analyzed_figures = analyzed_figures + New_figures;
    end
end
% LineWidth modification
lines = findobj('type','line');
for i=1:1:max(size(lines))
    lines(i).LineWidth = line_width;
end
