%% Opt.  no lineal

%Luis Quispe Macavilca

clc;
clear;
%***************************************************************
%Como usa funciones, el código correrá solo si usa F5
%***************************************************************

%% Ejemplo de problema 10.8.a - Lomeli y Rumbos (2001)

% max z = 50*(x^0.5)*y^2
% s.a.    x + y = 80000

% Convertimos a forma de minimización
% min z = -50*(x^0.5)*y^2
% s.a.    x + y = 80000

%% Planteamos la función objetivo
f = @(x) -50*(x(1)^0.5) * x(2)^2;    %-50*(x^0.5)*y^2

%% Aplicamos la función fmincon   
% Z = fmincon (función objetivo,
%              condicion inicial para cada variable,
%              [],[] desigualdades lineales,
%              [],[] igualdades lineales,
%              [],[] límites inferiores y superiores, 
%              función de restricciones)

%% Aplicamos la función fmincon               
z = fmincon (f, ...
             [0;0], ... 
             [], [], ...
             [1 1], [80000]); ...% x + y = 80000

%% Guardamos los resultados
x = round(z(1),3);
y = round(z(2),3);

%Resultado
fprintf('El valor de x es %.3f\n' , x);
fprintf('El valor de y es %.3f\n' , y);

             