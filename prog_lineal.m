%% Opt. lineal

%Luis Quispe Macavilca

clc;
clear;

%% Resuleva:
%   max z = 2x -  4y
%   s.a.    -x +  y  <=  3
%           -x +  2y >= -4
%           2x +  y   = 4
%            x,y >=0

%Primero, se ordena de forma de MINIMIZACIÓN
%   min z = -2x + 4y
%   s.a.     -x+y <=3
%            x-2y <=4
%            2x+y=4
%            -x <= 0
%            -y <=0

%% Usamos la función "linprog"

help linprog

% z = funcion ( [funcion objetivo], 
%               [desigualdades_variables], [desigualdades_dígito], 
%               [igualdades_variables], [igualdades_dígito] )

%% Aplicamos la función linprog

z=linprog ( [-2 4], ...
    [-1 1; 1 -2; -1 0; 0 -1], [3; 4; 0; 0], ...
    [2 1], [4]);

%% Guardamos los resultados
x = z(1);
y = z(2);

%Resultado
fprintf('El valor de x es %d. \n' , x);
fprintf('El valor de y es %d. \n' , y);