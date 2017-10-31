function FSK =modulation_FSK(base,f1,f2,phi1,phi2,Tb,Eb,num,space)
%%
%produce the signal of FSK
%input: 
%       f1: the frequency of $s_1(t)$--0
%       phi1: the phase of $s_1(t)$
%       f2: the frequency of $s_2(t)$--1
%       phi2: the phase of $s_2(t)$
%       num: the number of testing
%       Tb: sampling time
%       Eb: the power of the signal
%       space: Simulation parameters
%output: FSK: the signal

t = Tb*space:Tb*space:Tb;

FSK = [];
for i = 1:num
    if base(i)
        sin_f2 = sqrt(2*Eb/Tb)*cos(2*pi*f2*t + phi2(i));
        FSK = [FSK sin_f2];
    else
        sin_f1 = sqrt(2*Eb/Tb)*cos(2*pi*f1*t + phi1(i));
        FSK = [FSK sin_f1];
    end
end
end


