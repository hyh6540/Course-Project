function base_r= Co_demodulation_FSK(r_FSK,p,f1,f2,phi1,phi2,Tb,Eb,num,space,var);
%%
%demodulation the signal of FSK
%input: FSK
%       p: the probability of $s_1(t)$--1
%       f1: the frequency of $s_2(t)$--0
%       phi1: the phase of $s_1(t)$
%       f2: the frequency of $s_2(t)$--1
%       phi2: the phase of $s_2(t)$
%       num: the number of testing
%       Tb: sampling time
%       Eb: the power of the signal
%       space: Simulation parameters
%       var: variance of the white Gaussian noise
%output: base_r: the result after demodulation

t = Tb*space:Tb*space:Tb;

base_r = [];
for i = 1:num
    Varphi1 = sqrt(2/Tb)*cos(2*pi*f1*t + phi1(i));
    Varphi2 = sqrt(2/Tb)*cos(2*pi*f2*t + phi2(i));
    temp = r_FSK(1+(i-1)/space:i/space);
    %int
    temp_f1 = temp.*Varphi1;
    temp_f2 = temp.*Varphi2;
    y1 = sum(temp_f1)*Tb*space;
    y2 = sum(temp_f2)*Tb*space;
    %judge
    if y1 - y2 > var/(4*sqrt(Eb))*log((1-p)/p)
        base_r(i) = 0;
    else
        base_r(i) = 1;
    end
end
end