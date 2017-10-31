function base_r= demodulation_FSK(r_FSK,f1,f2,Tb,Eb,num,space,var);
%%
%demodulation the signal of FSK (only usd when p1 = p2 = 0.5)
%input: FSK
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

Varphi1c = sqrt(2/Tb)*cos(2*pi*f1*t);
Varphi1s = sqrt(2/Tb)*sin(2*pi*f1*t);
Varphi2c = sqrt(2/Tb)*cos(2*pi*f2*t);
Varphi2s = sqrt(2/Tb)*sin(2*pi*f2*t);

base_r = [];
for i = 1:num
    temp = r_FSK(1+(i-1)/space:i/space);
    %int
    temp_f1_c = temp.*Varphi1c;
    temp_f1_s = temp.*Varphi1s;
    temp_f2_c = temp.*Varphi2c;
    temp_f2_s = temp.*Varphi2s;
    y1c = sum(temp_f1_c)*Tb*space;
    y1s = sum(temp_f1_s)*Tb*space;
    y2c = sum(temp_f2_c)*Tb*space;
    y2s = sum(temp_f2_s)*Tb*space;
    %judge
    if y1c^2+y1s^2 > y2c^2+y2s^2
        base_r(i) = 0;
    else
        base_r(i) = 1;
    end
end
end