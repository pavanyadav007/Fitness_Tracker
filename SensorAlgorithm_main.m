
%% Objectives & Team Contribution:

   % 1. User stats and traffic Analysis - Vootla Lahari(99004489)
   % 2. User tracking and HeartBeat Analysis - Pavan Yadav A(99004494)
   %% IMPORTING FILES 
%%[latitude1] = xlsread('D:\MSD(model based design)\Algorithm_SensorLog\Algorithm_Travel Tracker Sample\Sensor_record_20210313_182822_AndroSensor.csv','V2:V1248');
%%[longitude1] = xlsread('D:\MSD(model based design)\Algorithm_SensorLog\Algorithm_Travel Tracker Sample\Sensor_record_20210313_182822_AndroSensor.csv','W2:W1248');
%%[raw0_0] = xlsread('D:\MSD(model based design)\Algorithm_SensorLog\Algorithm_Travel Tracker Sample\Sensor_record_20210313_182822_AndroSensor.csv','V2:W1239');
%%[raw0_1] = xlsread('D:\MSD(model based design)\Algorithm_SensorLog\Algorithm_Travel Tracker Sample\Sensor_record_20210313_182822_AndroSensor.csv','Z2:Z1239');
%%[raw0_2] = xlsread('D:\MSD(model based design)\Algorithm_SensorLog\Algorithm_Travel Tracker Sample\Sensor_record_20210313_182822_AndroSensor.csv','AD2:AD1239');
%%[raw0_3] = xlsread('D:\MSD(model based design)\Algorithm_SensorLog\Algorithm_Travel Tracker Sample\Sensorrecord.csv','U2:U3000');
%%[raw0_4] = xlsread('D:\MSD(model based design)\Algorithm_SensorLog\Algorithm_Travel Tracker Sample\Sensorrecord.csv','AD2:AD3000');
[ECG_DATA] = xlsread('C:\Users\pavan\OneDrive\Desktop\Team_integration\Sensor_record_20210313_182822_AndroSensor.csv','AH2:AH6000');
%%rawtracing = [raw0_0,raw0_1,raw0_2];

%{
%% Create output variable
data = rawtracing;

%% Create table
displacementdata = table;

%% Allocate imported array to column variable names
displacementdata.LATITUDE = data(:,1);
displacementdata.LONGITUDE = data(:,2);
displacementdata.SPEED = data(:,3);
displacementdata.Timesincestartinms = data(:,4);

disp(" ** USER STATS DURING COMMUTE ** ");
%% *Calculation of displacement*
clearvars data raw raw0_0 raw0_1 R;
latitude = displacementdata.LATITUDE;
longitude = displacementdata.LONGITUDE;
speed = displacementdata.SPEED;
time = displacementdata.Timesincestartinms;
% Calculate Distance
Radius_of_earth = 637*exp(3);
initial_latitude = latitude(1)*pi/180;
final_latitude = latitude(length(latitude)-1)*pi/180;
initial_longitude = longitude(1)*pi/180;
final_longitude = longitude(length(longitude)-1)*pi/180;
latitude_difference = abs(initial_latitude-final_latitude);
longitude_difference = abs(initial_longitude-final_longitude);
% Calculate Speed
average_speed = mean(speed);
total_distance = total_time*average_speed;
disp("distance covered during the trip :" + total_distance+"km");
disp("average speed :" + average_speed+"kmph");
disp("current location :" + final_latitude + "  " + final_longitude);
geoplot([initial_latitude final_latitude],[initial_longitude final_longitude])
fprintf("\n");

%% *Traffic information during commute*
disp("** TRAFFIC INFO **");
raw8 = [raw0_3,raw0_4];
data = raw8;
stepdata1 = table;

stepdata1.SOUNDLEVEL  = data(:,1);
stepdata1.Timesincestartinms  = data(:,2);

s = stepdata1.SOUNDLEVEL;
t=stepdata1.Timesincestartinms;

sum=0;
for i = 1:2999
    if(s(i)<38)
        sum=sum+1;
        if(sum==500)
        disp("NO traffic at : " + (t(i)+ "ms during commute"));
        sum=0;
        end
    elseif(s(i)>38 && s(i)<48)
        sum=sum+1;
        if(sum==500)
        disp("LOW traffic at : " + (t(i) + "ms during commute"));
        sum=0;
        end
    elseif(s(i)>49 && s(i)< 61)  
        sum=sum+1;
        if(sum==500)
        disp("MEDIUM traffic at : " + (t(i) + "ms during commute"));
        sum=0;
        end
    elseif (s(i)> 62 && s(i)<79)
        sum=sum+1;
        if(sum==500)
        disp("HEAVY traffic at : " + (t(i) + "ms during commute"));
        sum=0;
        end
    end
end
fprintf("\n");
fprintf("\n");
%}

%%User tracking and HeartBeat Analysis
plot(ECG_DATA)
xlabel('samples');
ylabel('Electrical Activity');
title('ECG signal sampled at 100Hz');
hold on
plot(ECG_DATA,'ro')
%%program to determine the BPM of an ECG signal, adviseing device
%% count the dominant peaks in the signal (these correspond to heart beats)
%% - peaks are defined to be sample greater than their two nearst and greater than 1
beat_count=0;
for k = 2 : length(ECG_DATA)-1
    if( ECG_DATA(k) > ECG_DATA(k-1) && ECG_DATA(k) > ECG_DATA(k+1) && ECG_DATA(k) > 1)
        %k
        %disp('peak found');
        beat_count = beat_count + 1;
    end
end
fs =100;
N =length(ECG_DATA);
duration_in_second = N/fs;
duration_in_minutes = duration_in_second /60;
BPM = beat_count/duration_in_minutes
if(BPM>=60&&BPM<=100)
    disp('Normal, your health condition is great!');
elseif(BPM>0&&BPM<60)
    disp('Very Low!, reach near by hospital');
else
    disp('Very High!, reach near by hospital' );
end







