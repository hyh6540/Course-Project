function r_FSK = add_n0(FSK,var);
%%
%add the white Gaussian noise
%input: FSK:
%       var: variance
%output: r_FSK

l = length(FSK);
r_FSK = FSK + normrnd(0,sqrt(var),1,l);
end
