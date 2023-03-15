%% Opt.  no lineal - KKT

%Luis Quispe Macavilca

clc;
clear;
%***************************************************************
%Como usa funciones, el código correrá solo si usa F5
%***************************************************************
%% Ejemplo de problema 10.8.e - Lomeli y Rumbos (2001)

% Resuleva:
%   max z = x*y*z
%   s.a.    x+y+z <= 4
%           x <= 1
%           y >= 2
%           x,y,z >= 0 

% En forma de minimización
%   min z = -(x*y*z)
%   s.a.    x+y+z <= 4
%           x  <= 1
%           -y <= -2
%           x,y,z >= 0 

%% Usamos la función "fmincon"

% help fmincon

% Necesitamos añadir dos funciones:
% *función que guarde las restricciones no lineales (al final) y reconozca
% si la restricción es activa o no (lambda), ya que es una
% optmización KKT
% *función que guarde la función objetivo

%% Función objetivo
%donde x -> x(1) y y -> x(2), proponemos la función objetivo
f = @(x) -(x(1)*x(2)*x(3));   % -(x*y*z)

% Z = fmincon (función objetivo,
%              condicion inicial para cada variable,
%              [],[] desigualdades lineales,
%              [],[] igualdades lineales,
%              [],[] límites inferiores y superiores, 
%              función de restricciones)

%% Aplicamos la función fmincon               

%z = fmincon (f, ...
[z,fval,exitflag,output,lambda,grad,hessian] = fmincon (f, ...
             [0;0;0], ... %ya que estamos minimizando, agregamos un valor que no pase nuestra restricción
             [], [], ...
             [], [], ...
             [0 0 0],[Inf Inf Inf], ... 
             @restriccion4);

%% Encontramos las restricciones de KKT y las contamos:
desig = lambda.ineqnonlin; %guarda si la restricción es activa (>0) o no (=0).
n = numel(desig);

%% Guardamos los resultados
x = round(z(1),3);
y = round(z(2),3);
a = round(z(3),3);

%Resultado
fprintf('El valor de x es %.3f\n' , x);
fprintf('El valor de y es %.3f\n' , y);
fprintf('El valor de z es %.3f\n' , a);

%Restricciones

for c = 1:n
    if desig(c) == 0
        fprintf('La restricción #[%d] de KKT es NO activa: lambda = %.3f\n ' ,c , desig(c));
    else
        fprintf('La restricción #[%d] de KKT es activa: lambda = %.3f\n ' ,c , desig(c));
    end
end

%% ---- Restricciones
%donde x -> x(1) , y -> x(2) , z -> x(3)

function [c, ceq] = restriccion4(x)
c(1) = x(1)+x(2)+x(3)-4;   % x+y+z <= 4
c(2) = x(1)-1;             % x<=1
c(3) = -x(2)+2;             % -y-<=-2
ceq = [];
end
