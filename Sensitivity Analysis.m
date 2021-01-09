% Set Up
clc         % Clears the command window
clear all   % Clears the workspace of variables

mcad = actxserver('MotorCAD.AppAutomation');        % Connects to MotorCAD and gives it the name 'mcad'


 %% 1- Vary Stator Bore

%M=[200,195,190,185,180,175,170,165,160];        % Array of Pole Numbers
%M=[1.5,1.6,1.7,1.8,1.9,2.0,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4.0] %airgap
%M=[100,105,110,115,120,125,130] %Rotor Length
%M=[1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7] %Magnet Thickness
%M=[6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11,11.5,12] %Tooth Width
M=[2.5,3,3.5,4,4.5,5] %Slot Opening
%M=[26,28,30,32,34,36,38,40,42] %Slot Depth
%M=[120,125,130,135,140,145,150,155,160] %Stat Bore
%M=[246,244,242,240,238,236,234,232,230,228] %Stat Bore
%M=[0,1,1.2,1.4,1.6,1.8,2.0,2.2,2.4,2.6,2.8,3.0,3.2,3.4,3.6,3.8,4.0] %Magnet Reduction
%M=[130,132,134,136,138,140,142,144,146,148,150,151,152,153,154,156,158,160]
%C=[79.81,79.55,79.27,78.97,78.66,78.33,77.98,77.61,77.21];
%Set initial values
%invoke(mcad, 'SetVariable','Magnet_Arc_[ED]' ,M(1));                % Setting variables in MotorCAD

i=1                 % 'i' to be used as counter
while i<=numel(M)       % While loop to count through nr of array elements tests
                                                    % same as above, but i increases each loop and refers to a position in the array
    %invoke(mcad, 'SetVariable','Magnet_Arc_[ED]' ,M(i));   % Magnetic Arc     
    %invoke(mcad, 'SetVariable','Stator_Bore' ,M(i));   %Stator Bore
    %invoke(mcad, 'SetVariable','RMSCurrent' ,M(i)); %RMS Current
    %invoke(mcad, 'SetVariable','PhaseAdvance' ,C(i));
    %invoke(mcad, 'SetVariable','Airgap' ,M(i));   %Airgap
    %invoke(mcad, 'SetVariable','Magnet_Length' ,M(i)); 
    %invoke(mcad, 'SetVariable','Stator_Lam_Length' ,M(i)); 
    %invoke(mcad, 'SetVariable','Rotor_Lam_Length' ,M(i)); 
    invoke(mcad, 'SetVariable','Slot_Opening' ,M(i)); 
    %invoke(mcad, 'SetVariable','Magnet_Thickness' ,M(i));
    %invoke(mcad, 'SetVariable','MagnetReduction' ,M(i));
    %invoke(mcad, 'SetVariable','Tooth_Width' ,M(i));
    %invoke(mcad, 'SetVariable','Slot_Depth' ,M(i));
    %invoke(mcad, 'SetVariable','Stator_Bore' ,M(i));
    %invoke(mcad, 'SetVariable','Stator_Lam_Dia' ,M(i));
      
    
    
    
    
    %invoke(mcad, 'SetVariable','Slot_Depth' ,M(i));  %Slot Depth
    %invoke(mcad, 'SetVariable','Tooth_Width' ,M(i));    
    %invoke(mcad, 'SetVariable','RMSCurrent' ,M(i));
    invoke(mcad, 'DoMagneticCalculation');                      % solve MotorCAD EMag model
  
   [funcresult, J_1(i)]=invoke(mcad, 'GetVariable', 'StatorCopperCurrentDensity'); 
   [funcresult, Tmax_1(i)]=invoke(mcad, 'GetVariable', 'MaxTorque'); 
   [funcresult, Tavg_1(i)]=invoke(mcad, 'GetVariable', 'AvTorqueVW');      %Output torque from MotorCAD and store in an array 
   [funcresult, Tripple_1(i)]=invoke(mcad, 'GetVariable', 'TorqueRippleMsVwPerCent (MsVw)');   
   [funcresult, SpeedLim_1(i)]=invoke(mcad, 'GetVariable', 'SpeedForZeroTorque'); 
   [funcresult, TermVolt_1(i)]=invoke(mcad, 'GetVariable', 'RmsLineLineVoltage'); 
   [funcresult, BEmf_1(i)]=invoke(mcad, 'GetVariable', 'PeakBackEMFLine'); 
   [funcresult, Effic_1(i)]=invoke(mcad, 'GetVariable', 'Efficiency'); 

    disp(M(i))  %displays current Magnetic Arc
    
    i=i+1       % increase counter 
end

plot(M,Tripple_1,M,BEmf_1,M,Tavg_1)       % Plots Tripple againt M 
xlabel('Magnetic Arc');      % titles on graph
ylabel('Outputs') 
title ('Relationship Between Outputs and Magnetic Arc');

%% 2- Vary Magnetic Arc

%%%%%%%%%%%%%% Vary Second value %%%%%%%%%%%%%%%%%%
% M=[130,132,134,136,138,140,142,144,146,148,150,152,154,156,158,160]
% 
% P=[14000,55,52];                  
% invoke(mcad, 'SetVariable','Shaft_Speed_[RPM]' ,P(1));
% invoke(mcad, 'SetVariable','RMSCurrent' ,P(2));
% invoke(mcad, 'SetVariable','PhaseVoltage' ,P(3));
% 
% i=1                 % 'i' to be used as counter
% while i<=numel(M)       % While loop to count through nr of array elements tests
%                                                     % same as above, but i increases each loop and refers to a position in the array
%     invoke(mcad, 'SetVariable','Magnet_Arc_[ED]' ,M(i));   % Magnetic Arc  
%     invoke(mcad, 'DoMagneticCalculation');                      % solve MotorCAD EMag model
%   
%    [funcresult, J_2(i)]=invoke(mcad, 'GetVariable', 'StatorCopperCurrentDensity'); 
%    [funcresult, Tmax_2(i)]=invoke(mcad, 'GetVariable', 'MaxTorque'); 
%    [funcresult, Tavg_2(i)]=invoke(mcad, 'GetVariable', 'loopTorque');      %Output torque from MotorCAD and store in an array 
%    [funcresult, Tripple_2(i)]=invoke(mcad, 'GetVariable', 'TorqueRippleMsVwPerCent (MsVw)');   
%    [funcresult, SpeedLim_2(i)]=invoke(mcad, 'GetVariable', 'SpeedForZeroTorque'); 
%    [funcresult, TermVolt_2(i)]=invoke(mcad, 'GetVariable', 'RmsLineLineVoltage'); 
%    [funcresult, BEmf_2(i)]=invoke(mcad, 'GetVariable', 'PeakBackEMFLine'); 
%    [funcresult, Effic_2(i)]=invoke(mcad, 'GetVariable', 'Efficiency'); 
% 
%     disp(M(i))  %displays current Magnetic Arc
%     
%     i=i+1       % increase counter 
% end

%% Plot Results in Graph

% plot(B,Tripple_2,B,BEmf_2,B,Tavg_2)       % Plots Tripple againt M 
% xlabel('Magnetic Arc');      % titles on graph
% ylabel('Outputs') 
% title ('Relationship Between Outputs and Magnetic Arc');
