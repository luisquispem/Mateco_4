%% Opt.  no lineal - KKT

%Luis Quispe Macavilca

clc;
clear;
%***************************************************************
%Como usa funciones, el código correrá solo si usa F5
%***************************************************************

%Resuleva:
%   min z = (x-1)^2 + (y-1)^2
%   s.a.    x + y - 4 <= 0
%           x - y - 2 <= 0

%% Usamos la función "fmincon"

% help fmincon

% Necesitamos añadir dos funciones:
% *función que guarde las restricciones no lineales (al final)
% *función que guarde la función objetivo

%% Función objetivo
%donde x -> x(1) y y -> x(2), proponemos la función objetivo
f = @(x) (x(1)-1)^2 + (x(2)-1)^2;   % (x-1)^2 + (y-1)^2 

% Z = fmincon (función objetivo,
%              condicion inicial para cada variable,
%              [],[] desigualdades lineales,
%              [],[] igualdades lineales,
%              [],[] límites inferiores y superiores, 
%              función de restricciones)

%% Aplicamos la función fmincon               
%z = fmincon (f, ...
[z,fval,exitflag,output,lambda,grad,hessian] = fmincon (f, ...
             [-4;-4], ...  %aplicando la restricción de minimización
             [], [], ...
             [], [], ...
             [],[], ...
             @restriccion2);

desig = lambda.ineqnonlin; %guarda si la restricción es activa (>0) o no (=0).
n = numel(desig);

%% Guardamos los resultados
x = round(z(1),3);
y = round(z(2),3);

%Resultado
fprintf('El valor de x es %.3f\n' , x);
fprintf('El valor de y es %.3f\n' , y);

%Restricciones

for c = 1:n
    if desig(c) == 0
        fprintf('\n')
        fprintf('La restricción #%d de KKT es NO activa: lambda = %.1f\n ' ,c , desig(c));
        fprintf('\n')
    else
        fprintf('La restricción #%d de KKT es activa: lambda = %.1f\n ' ,c , desig(c));
    end
end

%% ---- Restricciones
%donde x -> x(1) y y -> x(2)

function [desig, ig] = restriccion2(x)
desig(1) = x(1)+x(2)-4;   % x + y - 4 <= 0
desig(2) = x(1)-x(2)-2;   % x - y - 2 <= 0
ig = [];
end