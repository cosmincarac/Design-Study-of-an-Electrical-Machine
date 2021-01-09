% Set Up
clc         % Clears the command window
clear all   % Clears the workspace of variables

%%%%%%%%%%%%%%%%%%%%%%%%% DoE Requirements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Torque_pk = 200; %[Nm] [N/A*m]  for 18 sec
Torque_rt = 100; %[Nm] Rated Torque
Torque_out = Torque_pk; %Torque value to be used

Power_pk = 55000; %[W]          for 18 sec
Speed_max = 14000; %[rpm]
Speed_rated = 2800; %[rpm]
Vs = 325; %[V] Rated Voltage %Phase Voltage
Vll = Vs/sqrt(5); %[V]

%%%%%%%%%%%%%%%%%%%%%%%%% Assumed Values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 5;              %Pole Pairs
N_s = 30;          %Nr. of Slots
m = 3;              %Nr. of phases

B_mag = 1.105 %[T]  %Neodimium magnet flux density N30UH Magnet)
u_m = 1.1;          %Magnet Permeability
B_ag = 0.9; %[T]    %Magnetic Flux Density Airgap before - 0.95
B_stat_teeth = 1.8; %[T] before - 1.8
B_back_iron = 1.6;  %[T] before - 1.6
Lg = 0.0007;         %[m] Assume Airgap length
k_slot_opening = 0.2%Slot Opening Factor 

A = 50e3; %[A/m]    %Electrical Loading
%J = 4e6;  %[A/m^2]   %Current Density - Rated Torque
J = 9e6;  %[A/m^2]   %Current Density - Peak Torque
Sff = 0.45;         % Slot Fill Factor (copper area/slot area)
PF = 0.9;           % Power Factor

%%%%%%%%%%%%%%%%%%%%%%%%% Calculations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a_s = n_s*2*pi/60; %Angluar Speed [rad/s]

%Magnet Thickness
Lm = Lg*u_m/(B_mag/B_ag - 1);

%Rotor Diameter from Torque Requirement
D2L = (2*Torque_out)/(pi*B_ag*A); %holds D^2*L value 
%assume L/Dr = 1
Dr = D2L^(1/3);  %[m]
L = Dr; %[m]

%Dimensioning of Stator Slot Laminations 
Lambda_s = pi * Dr / N_s;
Wt = (B_ag/B_stat_teeth) * Lambda_s;    %Tooth Width  
Wslot = Wt; %Slot Width   %because of 50-50 division
Lambda_p = pi * Dr /(2*p);
Wc = (B_ag/(2*B_back_iron)) * Lambda_p; %Back Iron Core Width    

%Calculating Slot area and Inner Diameter Dc
A_slots = A*pi*Dr/(2*J*Sff);    %calculate area of all slots
Dc = sqrt(8*A_slots/pi + (Dr + 2*Lg + 2*Lm)^2);  %calculate Inner Diameter Dc

Stat_bore = Dr + 2*Lg + 2*Lm; % Stator Bore Calculation
Lt = (Dc - Dr - 2*Lg - 2*Lm)/2;   %Tooth Length/ Slot Depth
Dext = Dc + 2*Wc;   %External Diameter

Fr = p* Speed_max /(2*pi); %[Hz]   % Electrical frequency at peak speed 

%Calculating Slot Opening
slot_pitch = Stat_bore*pi/N_s - Wt;         %Slot Pitch distance
W_slot_opening = k_slot_opening * slot_pitch; %Slot opening width

%Calculating Winding Requirement
Pout = Torque_out * Speed_rated*2*pi/60; %Output Power
I_RMS_ph = Pout/(sqrt(3)*Vll*PF);   %RMS Phase Current

N_turns_ph = A*pi*Dr/(2*m*I_RMS_ph);  %Turns per Phase
N_coils_ph = N_s/m;                          %Number of Coils per Phase              
%N_turns_coils=int32(N_turns_ph/N_coils_ph);  %Number of Turns per Coil
N_turns_coils = N_turns_ph/N_coils_ph;  %Number of Turns per Coil
N_tot_turns = N_turns_coils*N_coils_ph*m;      %Number of Total Turns in machine

I_RMS_ph_recalc = A*pi*Dr/(2*m*int32(N_turns_coils*N_coils_ph));   %Can recalculate RMS Phase Current based on winding

SplitRatio = Dr/Dext; %Split Ration btw rotor/stator diam %should be ~ 0.6

%%%%%%%%%%%%%%%%%%%%%%%%% Output Display %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n')
disp('    Stator Dimensions');
disp(['Stator Lam Dia (Dext): ',num2str(Dext),' m']); %External Stator Diameter 
disp(['Stator Bore (Stat_bore): ',num2str(Stat_bore),' m']); %Stator Bore 
disp(['Tooth Width (Wt): ',num2str(Wt),' m']); %Tooth Width 
disp(['Slot Depth (Lt): ',num2str(Lt),' m']); %Tooth Length 
disp(['Slot Opening (W_slot_opening): ',num2str(W_slot_opening),' m']); %Tooth Length 
disp(['Turns per Coil (N_turns_coils): ',num2str(N_turns_coils),' Turns']); %Number of Turns per Coil
fprintf('\n')
disp(['Split Ratio (SplitRatio): ',num2str(SplitRatio),'']); %External Diameter 
disp(['Back Iron (Wc): ',num2str(Wc),' m']); %Back Iron Yoke
disp(['Slot Width (Wslot): ',num2str(Wslot),' m']); %Slot Width 
disp(['Inner Stator Diameter (Dc): ',num2str(Dc),' m']); %Inner Stator Diameter/Yoke  
disp(['Electrical Frequency (f): ',num2str(Fr),' Hz']); %Electrical Frequency fased on speed and poles 
disp(['Motor Length (L): ',num2str(L),' m']); %Motor Length 
fprintf('\n')

disp(['Output Power (Pout): ',num2str(Pout),' W']); %Output Power
disp(['RMS Phase Current (I_RMS_ph): ',num2str(I_RMS_ph),' A']); %RMS Phase Current Required per Phase
disp(['Recalculated RMS Phase Current (I_RMS_ph_recalc): ',num2str(I_RMS_ph_recalc),' A']); %Recalculated RMS Phase Current

fprintf('\n')
disp('    Rotor Dimensions');
disp(['Rotor Diameter (Dr): ',num2str(Dr),' m']); %Rotor Diameter 
disp(['Magnet Thickness (Lm): ',num2str(Lm),' m']); %Magnet Thickness 

%%%%%%%%%%%%%%%%%%%%%%%%%%% Warnings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Split Ratio 0.5 <  > 0.65
SplitRatio = Dr/Dext; %Split Ration btw rotor/stator diam %should be ~ 0.6

fprintf('\n')
disp('    Warnings');

if (SplitRatio < 0.5)  
    disp(['Split Ratio is below 0.5 - ',num2str(SplitRatio)])     
elseif(SplitRatio >0.65)
    disp(['Split Ratio is above 0.65 - ',num2str(SplitRatio)])   
end

%RMS Current
if ( I_RMS_ph > 400)
    disp(['Current Required is over 400 A - ',num2str(I_RMS_ph),' A'])  
end

%Stator Diameter
if ( Dext > 250)
    disp(['Current Required is over 400 A - ',num2str(Dext),' A'])  
end
    
%Rotor Length
if ( L > 130)
    disp(['Current Required is over 400 A - ',num2str(L),' A'])  
end

%Supply Current
if ( I_RMS_ph > 400)
    disp(['Current Required is over 400 A - ',num2str(I_RMS_ph),' A'])  
end
