clc; clear; close all
%b: used for computing the power of signal 
b = 7:0.01:8;
%N0/2: the power of white Gaussian noise
N0 = 10^(-8);
P_e = []; P_e_n = [];
P_e_a = []; P_e_a_n = [];
%p: the probability of $s_1(t)$--0
%1-p : the probability of $s_2(t)$--1
p = 0.5;
%Tb: sampling time
Tb = 0.0001;
k1 = 6; k2 = 10;    
%f1: the frequency of $s_1(t)$--0
%f2: the frequency of $s_2(t)$--1
f1 = k1/(Tb); f2 = k2/(Tb);
%space: Simulation parameters
space = 10^(-3);
%variance: the variance of white Guassian noise
var = N0/Tb/space/2;

l = length(b);
for i = 1:l
    i
    %Eb: the power of the signal
    Eb = 10^(-b(i)); 
    %error rate in theory
    P_e_a_n(i) = 0.5*exp(-Eb/(2*N0));
    P_e_a(i) = 1-normcdf(sqrt(Eb/N0),0,1);
    %num: the number of testing
    num = 100*ceil(1/min(P_e_a_n(i),P_e_a(i)));
    
    %phi1: the phase of $s_1(t)$
    %phi2: the phase of $s_2(t)$
    %they are uniform Distribution.
    phi1 = rand(1,num)*2*pi; phi2 = rand(1,num)*2*pi;
    
    %produce the baseband signal
    base = rand(1,num) > p;
     
    fprintf('modulation...\n');
    FSK = modulation_FSK(base,f1,f2,phi1,phi2,Tb,Eb,num,space);

    fprintf('add...\n');
    r_FSK = add_n0(FSK,var);

    fprintf('coherent demodulation...\n');
    base_r= Co_demodulation_FSK(r_FSK,p,f1,f2,phi1,phi2,Tb,Eb,num,space,var);
    
    fprintf('noncoherent demodulation...\n');
    base_r_n= demodulation_FSK(r_FSK,f1,f2,Tb,Eb,num,space,var);
    fprintf('end\n');
    
    P_e(i) = P_error(base,base_r,num);
    P_e_n(i) = P_error(base,base_r_n,num);
end
figure;
hold on
plot(-b-log10(N0),log10(P_e),'--','Linewidth',1);
plot(-b-log10(N0),log10(P_e_a),'-.','Linewidth',1);
xlabel('log_{10}(E_b/N_0)');
ylabel('log_{10}(P_e)');
legend('Simulation result','Theoretical results');
grid on
axis([0 1 -3.5 -0.5])
title('Coherent Demodulation')

figure;
hold on
plot(-b-log10(N0),log10(P_e_n),'--','Linewidth',1);
plot(-b-log10(N0),log10(P_e_a_n),'-.','Linewidth',1);
xlabel('log_{10}(E_b/N_0)');
ylabel('log_{10}(P_e)');
legend('Simulation result','Theoretical results');
grid on
axis([0 1 -2.5 0])
title('Noncoherent Demodulation');

figure;
hold on
plot(-b-log10(N0),log10(P_e),'--','Linewidth',1);
plot(-b-log10(N0),log10(P_e_a),'-.','Linewidth',1);
plot(-b-log10(N0),log10(P_e_n),'--','Linewidth',1);
plot(-b-log10(N0),log10(P_e_a_n),'-.','Linewidth',1);
xlabel('log_{10}(E_b/N_0)');
ylabel('log_{10}(P_e)');
legend('Coherent--Simulation result','Coherent--Theoretical results',...
    'Noncoherent--Simulation result','Noncoherent--Theoretical results');
axis([0 1 -3.5 0])
title('Comparison')
grid on

save test_2 P_e P_e_a P_e_n P_e_a_n b f1 f2 k1 k2 N0 space Tb var p