function P_e = P_error(base,base_r,num);
%%
%compute the error rate
%input: base: the regional signal
%       base_r: the signal after demodulation
%ouput: P_e: error rate

num_e = sum(abs(base-base_r));
P_e = num_e/num;
end
