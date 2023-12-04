%% Nombre de la imagen
% Para generar una variable 
% de MATLAB con el barrido, 
% es necesario 
% saber con quÃ© nombre estÃ¡
% archivada la imagen en el hdf.
% La funciÃ³n 
 % Â«hdfinfo('NOMBRE.hdf');Â» 
% se usa para abrir el 
% Ã¡rbol donde estÃ¡ la imagen. 
% Por ejemplo:
h=hdfinfo('AST_L1T_00304162022095531_20220417100754_2246.hdf');
% genera un archivo 
% en workspace, donde puede
% explorarse dando doble click:
% Camino en el Ã¡rbol: 
% h |-> Vgroup |-> VNIR |-> 
% Vgroup |-> Data Fields 
% |-> ImageData(nÃºmero) es el nombre que buscamos.
% Nota: Cada funciÃ³n en MATLAB tiene una pÃ¡gina que describe su uso.
% Basta en Google, escribir:  Mathworks NOMBRE DE LA FUNCIÃ“N.
%% Las matrices
% Para ver la informaciÃ³n 
% contenida en la imagen, 
% es necesario abrirla.
% Esto se hace con la funciÃ³n %Â«hdfread('NOMBRE.hdf','datasetname');Â»
% para .hdf, .hdf4, .hdf-eos. 
% En cambio, para .h5, se usa
%h5read('NOMBRE.h5','datasetname');
I1 = hdfread('AST_L1T_00304162022095531_20220417100754_2246.hdf','ImageData1');
I10 = hdfread('AST_L1T_00304162022095531_20220417100754_2246.hdf','ImageData10');
I11 = hdfread('AST_L1T_00304162022095531_20220417100754_2246.hdf','ImageData11');
I12 = hdfread('AST_L1T_00304162022095531_20220417100754_2246.hdf','ImageData12');
I13 = hdfread('AST_L1T_00304162022095531_20220417100754_2246.hdf','ImageData13');
I14 = hdfread('AST_L1T_00304162022095531_20220417100754_2246.hdf','ImageData14');
 
 
%% La imagen
% Para pasar de la matriz 
% combinada Â«Ima1Â» que se 
% genera, usamos:
figure
Ima2 = imagesc(I1)
%% La imagen
% Para pasar de la matriz 
% combinada Â«Ima1Â» que se 
% genera, usamos:
figure
Ima3 = imagesc(I10)
%% $1.$ Pasar de los valores en la im\'{a}gen a los de radiaci\'{o}n en el sensor al: 
% Multiplicar por el coeficiente de correcci\'{o}n de unidades (UCC)
% correspondiente a la banda de los datos.
format LONG
 
RsenCon00 = (I10 - 1)*(0.006882);                                   % El coeficiente depende de la banda, para la banda 10, UCC(10) = 0.006882. 
RsenCon01 = (I11 - 1)*(0.00678);                                                                              % Las unidades de los nÃºmeros digitales (DN), o 'radiaciÃ³n escalada', son:
RsenCon02 = (I12 - 1)*(0.00659);                                                                              % [(W/sr m^2)/DN] (radiaciÃ³n por nÃºmero digital).
RsenCon03 = (I13 - 1)*(0.005693);                                                                              % Entonces, el resultado tiene unidades de radiaciÃ³n [(W/sr m^2)].
RsenCon04 = (I14 - 1)*(0.005225);                                                                              % UCC(11) = 0.00678,
                                                                            % UCC(12) = 0.00659,
                                                                            % UCC(13) = 0.005693,
                                                                        % UCC(14) = 0.005225.                                                                            % [Fujisada, H., "Terra ASTER Instrument Design and Geometry".
 
%% La imagen
% Para pasar de la matriz 
% combinada Â«Ima1Â» que se 
% genera, usamos:
figure
Ima03 = imagesc(RsenCon00)
figure
Ima8 = imagesc(RsenCon01)
figure
Ima4 = imagesc(RsenCon02)
figure
Ima7 = imagesc(RsenCon03)
figure
Ima9 = imagesc(RsenCon04)

%% $2.$ Extraer los valores que no son los ceros del borde donde no hay informaci\'{o}n (Dummy Pixels) al:
% Cortar la matriz. Generalmente hay renglones vac\'{i}os arriba, abajo y a
% los lados en diagonal, con un \'{a}ngulo positivo o negativo cuyo signo
% depende de si los datos fueron tomados de d\'{i}a o de noche. 
% Los datos en DN tienen valores en un rango determinado por el tipo. 
% En TIR, es $[0,4094]$ (Fujisada). Tomar el m\'{a}ximo y el m\'{i}nimo de la matriz
% es una forma de ver si los datos originales tienen sentido.
 
Rsen = zeros(500,500);                                                      % Preasignamos el espacio en la memoria.
for i = 1:500                                                               % En las imÃ¡genes L1B, hay un tamaÃ±o entre 680 renglones y 670 columnas con informaciÃ³n.                                                            
    for j = 1:500                                                           % En L1T, parecen haber menos pero tambiÃ©n parecen tener resoluciÃ³n de 90 por 90 metros.
        Rsen(i,j) = RsenCon00(159+i,199+j);                                   % Va del rengÃ³n 50 al 650 y de la columna 100 a la 700.
    end
end
Rsen1 = zeros(500,500);                                                      % Preasignamos el espacio en la memoria.
for i = 1:500                                                               % En las imÃ¡genes L1B, hay un tamaÃ±o entre 680 renglones y 670 columnas con informaciÃ³n.                                                            
    for j = 1:500                                                           % En L1T, parecen haber menos pero tambiÃ©n parecen tener resoluciÃ³n de 90 por 90 metros.
        Rsen1(i,j) = RsenCon01(159+i,199+j);                                   % Va del rengÃ³n 50 al 650 y de la columna 100 a la 700.
    end
end
Rsen2 = zeros(500,500);                                                      % Preasignamos el espacio en la memoria.
for i = 1:500                                                               % En las imÃ¡genes L1B, hay un tamaÃ±o entre 680 renglones y 670 columnas con informaciÃ³n.                                                            
    for j = 1:500                                                           % En L1T, parecen haber menos pero tambiÃ©n parecen tener resoluciÃ³n de 90 por 90 metros.
        Rsen2(i,j) = RsenCon02(159+i,199+j);                                   % Va del rengÃ³n 50 al 650 y de la columna 100 a la 700.
    end
end
Rsen3 = zeros(500,500);                                                      % Preasignamos el espacio en la memoria.
for i = 1:500                                                               % En las imÃ¡genes L1B, hay un tamaÃ±o entre 680 renglones y 670 columnas con informaciÃ³n.                                                            
    for j = 1:500                                                           % En L1T, parecen haber menos pero tambiÃ©n parecen tener resoluciÃ³n de 90 por 90 metros.
        Rsen3(i,j) = RsenCon03(159+i,199+j);                                   % Va del rengÃ³n 50 al 650 y de la columna 100 a la 700.
    end
end
Rsen4 = zeros(500,500);                                                      % Preasignamos el espacio en la memoria.
for i = 1:500                                                               % En las imÃ¡genes L1B, hay un tamaÃ±o entre 680 renglones y 670 columnas con informaciÃ³n.                                                            
    for j = 1:500                                                           % En L1T, parecen haber menos pero tambiÃ©n parecen tener resoluciÃ³n de 90 por 90 metros.
        Rsen4(i,j) = RsenCon04(159+i,199+j);                                   % Va del rengÃ³n 50 al 650 y de la columna 100 a la 700.
    end
end
 
%% La imagen
% Para pasar de la matriz 
% combinada Â«Ima1Â» que se 
% genera, usamos:
figure
Ima30 = imagesc(Rsen)
figure
Ima31 = imagesc(Rsen1)
figure
Ima32 = imagesc(Rsen2)
figure
Ima33 = imagesc(Rsen3)
figure
Ima34 = imagesc(Rsen4)
 
%% $3.$ Para estimar la temperatura superficial a partir de la radiaci\'{o}n en el sensor:
% $3.1$ Tenemos una primera aproximaci\'{o}n derivada de la Ecuaci\'{o}n de
% Planck, pero hay que tener mucho cuidado con cada cuenta porque un
% s\'{o}lo d\'{i}gito puede llevar un resultado que tiene sentido a otro
% que no. Y hace falta por una parte, entender porqu\'{e} se da esta
% relaci\'{o}n entre radiaci\'{o}n emitida por el objeto s\'{o}lido y su
% temperatura; por qu\'{e} la tierra emite en TIR y c\'{o}mo es que en
% estas longitudes de onda hay menos error por reflexi\'{o}n como
% consecuencia; y mejorar la aproximaci\'{o}n con los datos que pueden
% conseguirse o trabajo sobre la ecuaci\'{o}n. Para una primera
% exploraci\'{o}n utilizamos $T \tilde{=} \frac{c_2}{\lambda log \left(
% \frac{1}{Rsen \frac{\lambda^5 \pi}{c_1}} + 1 \right)}$ (Lithology art).
lambda = 8.3;                                                                % Tomamos la longitud de onda promedio de la banda.
c2 = 1.439e+04;                                                              % micrometros por Kelvin [\mu m K]
c1 = 3.742e+08;                                                              % W por micrometro a la cuarta potencia / metro cuadrado.
 
a = ((lambda^5)*pi)/c1;
 
 Temp = zeros(500,500);                                                      % Preasignamos el espacio de memoria.
 for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
     for j = 1:500
         Temp(i,j) = a*Rsen(i,j);
         Temp(i,j) = 1/Temp(i,j);
         Temp(i,j) = Temp(i,j)+1;
         Temp(i,j) = log(Temp(i,j));
         Temp(i,j) = lambda*Temp(i,j);
         Temp(i,j) = c2/Temp(i,j);
     end
 end                                                                         % Verificamos con el mÃ¡x y mÃ­n que las temperaturas en K tengan sentido.
 
 max(Temp(:))
 min(Temp(:))

 Temp1 = zeros(500,500);                                                      % Preasignamos el espacio de memoria.
 for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
     for j = 1:500
         Temp1(i,j) = a*Rsen1(i,j);
         Temp1(i,j) = 1/Temp1(i,j);
         Temp1(i,j) = Temp1(i,j)+1;
         Temp1(i,j) = log(Temp1(i,j));
         Temp1(i,j) = lambda*Temp1(i,j);
         Temp1(i,j) = c2/Temp1(i,j);
     end
 end                                                                         % Verificamos con el mÃ¡x y mÃ­n que las temperaturas en K tengan sentido.
 
 max(Temp1(:))
 min(Temp1(:))

 Temp2 = zeros(500,500);                                                      % Preasignamos el espacio de memoria.
 for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
     for j = 1:500
         Temp2(i,j) = a*Rsen2(i,j);
         Temp2(i,j) = 1/Temp2(i,j);
         Temp2(i,j) = Temp2(i,j)+1;
         Temp2(i,j) = log(Temp2(i,j));
         Temp2(i,j) = lambda*Temp2(i,j);
         Temp2(i,j) = c2/Temp2(i,j);
     end
 end                                                                         % Verificamos con el mÃ¡x y mÃ­n que las temperaturas en K tengan sentido.
 
 max(Temp2(:))
 min(Temp2(:))

 Temp3 = zeros(500,500);                                                      % Preasignamos el espacio de memoria.
 for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
     for j = 1:500
         Temp3(i,j) = a*Rsen3(i,j);
         Temp3(i,j) = 1/Temp3(i,j);
         Temp3(i,j) = Temp3(i,j)+1;
         Temp3(i,j) = log(Temp3(i,j));
         Temp3(i,j) = lambda*Temp3(i,j);
         Temp3(i,j) = c2/Temp3(i,j);
     end
 end                                                                         % Verificamos con el mÃ¡x y mÃ­n que las temperaturas en K tengan sentido.
 
 max(Temp3(:))
 min(Temp3(:))

 Temp4 = zeros(500,500);                                                      % Preasignamos el espacio de memoria.
 for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
     for j = 1:500
         Temp4(i,j) = a*Rsen4(i,j);
         Temp4(i,j) = 1/Temp4(i,j);
         Temp4(i,j) = Temp4(i,j)+1;
         Temp4(i,j) = log(Temp4(i,j));
         Temp4(i,j) = lambda*Temp4(i,j);
         Temp4(i,j) = c2/Temp4(i,j);
     end
 end                                                                         % Verificamos con el mÃ¡x y mÃ­n que las temperaturas en K tengan sentido.
 
 max(Temp4(:))
 min(Temp4(:))
 %% Ahora quiero verlas
 
figure, imshow(Temp,[min(Temp(:)),max(Temp(:))])

figure, imshow(Temp1,[min(Temp1(:)),max(Temp1(:))])

figure, imshow(Temp2,[min(Temp2(:)),max(Temp2(:))])

figure, imshow(Temp3,[min(Temp3(:)),max(Temp3(:))])

figure, imshow(Temp4,[min(Temp4(:)),max(Temp4(:))])
 

%% El histograma
% Para calcular estadÃ­sticas de 
% los datos, hay que aplicar las 
% funciones directamente
% sobre cada matriz Â«I#Â» 
% y no sobre la imagen Â«ImaÂ».
figure
HistTemp = histogram(sort(Temp(:)))
figure
HistTemp1 = histogram(sort(Temp1(:)))
figure
HistTemp2 = histogram(sort(Temp2(:)))
figure
HistTemp3 = histogram(sort(Temp3(:)))
figure
HistTemp4 = histogram(sort(Temp4(:)))

%% PAra sacar presión
%documentación
P0 = 1
R = 8.314*10^3
t0 = 295
b =1.405

P = zeros(500,500);
    for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
        for j = 1:500
            P(i,j)= (P0/R)*((t0^b)/Temp(i,j))^(1-b);
        end
    end

P1 = zeros(500,500);
    for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
        for j = 1:500
            P1(i,j)= (P0/R)*((t0^b)/Temp1(i,j))^(1-b);
        end
    end

P2 = zeros(500,500);
    for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
        for j = 1:500
            P2(i,j)= (P0/R)*((t0^b)/Temp2(i,j))^(1-b);
        end
    end
P3 = zeros(500,500);
    for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
        for j = 1:500
            P3(i,j)= (P0/R)*((t0^b)/Temp3(i,j))^(1-b);
        end
    end

P4 = zeros(500,500);
    for i = 1:500                                                               % Y aplicamos la fÃ³rmula con mucho cuidado.
        for j = 1:500
            P4(i,j)= (P0/R)*((t0^b)/Temp4(i,j))^(1-b);
        end
    end

% Define una paleta de colores personalizada, por ejemplo, un mapa de colores de calor (heatmap).
mi_colormap = colormap('parula'); 


figure, imshow(P, [min(P(:)), max(P(:))]);
colormap(mi_colormap);

figure, imshow(P1, [min(P1(:)), max(P1(:))]);
colormap(mi_colormap);

figure, imshow(P2, [min(P2(:)), max(P2(:))]);
colormap(mi_colormap);

figure, imshow(P3, [min(P3(:)), max(P3(:))]);
colormap(mi_colormap);

figure, imshow(P4, [min(P4(:)), max(P4(:))]);
colormap(mi_colormap);

% Puedes usar el comando 'colorbar' para agregar una barra de color a las figuras si lo deseas.
colorbar;
