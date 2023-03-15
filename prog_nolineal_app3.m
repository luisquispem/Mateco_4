%% Opt.  no lineal - KKT

%Luis Quispe Macavilca

clc;
clear;
%***************************************************************
%Como usa funciones, el código correrá solo si usa F5
%***************************************************************
%% Ejemplo de problema 10.8.d - Lomeli y Rumbos (2001)

% Resuleva:
%   min z = (x)^2 + (y)^2
%   s.a.    xy >= 25
%           x,y >= 0

% En forma de minimización
%   min z = (x)^2 + (y)^2
%   s.a.    -xy <= -25
%           x,y >= 0

%% Usamos la función "fmincon".

% help fmincon

% Necesitamos añadir dos funciones:
% *función que guarde las restricciones no lineales (al final) y reconozca
% si la restricción es activa o no (lambda), ya que es una
% optmización KKT
% *función que guarde la función objetivo

%% Función objetivo
%donde x -> x(1) y y -> x(2), proponemos la función objetivo
f = @(x) (x(1))^2 + (x(2))^2;   % (x)^2 + (y)^2

% Z = fmincon (función objetivo,
%              condicion inicial para cada variable,
%              [],[] desigualdades lineales,
%              [],[] igualdades lineales,
%              [],[] límites inferiores y superiores, 
%              función de restricciones)

%% Aplicamos la función fmincon               

%z = fmincon (f, ...
[z,fval,exitflag,output,lambda,grad,hessian] = fmincon (f, ...
             [0;0], ... %ya que estamos minimizando, agregamos un valor que no pase nuestra restricción
             [], [], ...
             [], [], ...
             [0 0],[Inf Inf], ... 
             @restriccion3);

%% Encontramos las restricciones de KKT y las contamos:
desig = lambda.ineqnonlin; %guarda si la restricción es activa (>0) o no (=0).
n = numel(desig);

%% Guardamos los resultados
x = round(z(1),3);
y = round(z(2),3);

% Valores óptimos
fprintf('El valor de x es %.3f\n' , x);
fprintf('El valor de y es %.3f\n' , y);

%Restricciones

for c = 1:n
    if desig(c) == 0
        fprintf('La restricción #[%d] de KKT es NO activa: lambda = %.3f\n ' ,c , desig(c));
    else
        fprintf('La restricción #[%d] de KKT es activa: lambda = %.3f\n ' ,c , desig(c));
    end
end





%if desig == 0 
%    fprintf('La restricción de KKT es NO activa: lambda = %.3f\n ' , desig);
%else
%    fprintf('La restricción de KKT es activa: lambda = %.3f\n ' , desig);
%end


%% ---- Restricciones
%donde x -> x(1) y y -> x(2)

function [c, ceq] = restriccion3(x)
c = 25 - x(1)*x(2);   % -xy <= -25
ceq = [];
end
