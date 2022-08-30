
%Leer archivo csv
run script_data.m

t=transpose(n_imp);
x=transpose(x_t_imp);
h=transpose(h_t_imp);

[t1,y]=myconv(t,x,h);

%Punto 6

A = [0 0 1 2 3 5 8 0 0 0 0];
B = [0 0 0 0 0 4 2 4 0 0 0];
N = [-5 -4 -3 -2 -1 0 1 2 3 4 5];

[N1,Y]=myconv(N,A,B);
