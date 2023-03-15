%% Opt.  no lineal


%Luis Quispe Macavilca

clc;
clear;

%***************************************************************
%Como usa funciones, el código correrá solo si usa F5
%***************************************************************

%Resuleva:
%   max z = -2x^2- y^3 + 3xy
%   s.a.    2x -  y  >= -1
%             xy     <=  1
%       x^2*y + xy^2  =  2

%Primero, se ordena de forma de MINIMIZACIÓN
%   min z =  2x^2 + y^2 - 3xy
%   s.a.    -2x + y <=1
%            xy     <=  1
%           x^2*y + xy^2  =  2

%% Usamos la función "fmincon"

help fmincon

% Necesitamos añadir dos funciones:
% *función que guarde las restricciones no lineales (al final)
% *función que guarde la función objetivo

%% Función objetivo
%donde x -> x(1) y y -> x(2), proponemos la función objetivo
f = @(x) 2*x(1)^2 + x(2)^2 - 3*x(1)*x(2)   %2x^2 + y^2 - 3xy


% Z = fmincon (función objetivo,
%              condicion inicial para cada variable,
%              [],[] desigualdades lineales,
%              [],[] igualdades lineales,
%              [],[] límites inferiores y superiores, 
%              función de restricciones)

%% Aplicamos la función fmincon               
z = fmincon (f, ...
             [1;1], ... %dada la segunda restricción
             [], [], ...
             [], [], ...
             [],[], ...
             @restricciones);

%% Guardamos los resultados
x = round(z(1),3);
y = round(z(2),3);

%Resultado
fprintf('El valor de x es %.3f\n' , x);
fprintf('El valor de y es %.3f\n' , y);



%% ---- Restricciones
%donde x -> x(1) y y -> x(2)

function [desig ig] = restricciones(x)
desig(1) = -2*x(1) + x(2) - 1;            % -2x+y<=1
desig(2) = x(1)*x(2) - 1;                 % xy<=1
ig (1)   = x(1)^2*x(2) + x(1)*x(2)^2 - 2; % x^2*y+xy^2=2
end