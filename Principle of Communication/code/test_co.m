clc; clear; close all

%b: used for testing
b = 0.1:0.01:0.9;

%Eb: the power of the signal
Eb = 10^(-7.5); 
%N0/2: the power of white Gaussian noise
N0 = 10^(-8);
P_e = []; P_e_n = [];
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
    %p: the probability of $s_1(t)$--0
    %1-p : the probability of $s_2(t)$--1
    p = b(i);
    %error rate in theory
    temp = sqrt(N0/Eb)/4*log((1-p)/p);
    P_e_a(i) = p*(1-normcdf(sqrt(Eb/N0)-temp,0,1))...
        + (1-p)*(1-normcdf(sqrt(Eb/N0)+temp,0,1));
    %num: the number of testing
    num = 10000*ceil(1/P_e_a(i));

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
    base_r= Co_demodulation_FSK(r_FSK,p,f1,f2,phi1,phi2,Tb,Eb,num,space,N0);
    fprintf('end\n');
    
    P_e(i) = P_error(base,base_r,num);
end
figure;
hold on
plot(b,log10(P_e),'--','Linewidth',1);
plot(b,log10(P_e_a),'-.','Linewidth',1);
xlabel('P_1');
ylabel('log_{10}(P_e)');
legend('Simulation result','Theoretical results');
grid on
axis([0 1 -1.7 -1.4])
title('Coherent Demodulation')

save test_co P_e P_e_a Eb b f1 f2 k1 k2 N0 space Tb var