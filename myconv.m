


function [t1,y] = myconv(t,x,h)

    %t=[0,1,2,3,4,5];
    %x=[0 , 3 , 1.5 , 1 , 0.7 , 0.5];
    %h=[0,0,1,2,2,1];
    
    %Mostrar tamaño del vector
    %display('Tamaño del vector')
    %size(t,2)
    
    %Función h relfejada
    h_inver = fliplr(h);
    t_inver = fliplr(t)*-1;
    
    s1=size(t_inver)-1;
    
    t_total=[t_inver(1:s1(2)) t];
    
    ind_ini=1
    ind_ter=1
    
    %Posicion del vector donde comienza a tener valor la funciòn X
    for i=1 : size(x,2)
        
        if x(1,i)~=0
            ind_ini_x=i;
            break
        end
    end
    
    %N de inicio para X
    ind_ini_x_n=t(1,ind_ini_x)
    
    %Posicion del vector donde comienza a tener valor la funciòn H
    for i=1 : size(h,2)
        
        if h(1,i)~=0
            ind_ini_h=i;
            break
        end
    end
    
    %N de inicio para H
    ind_ini_h_n=t(1,ind_ini_h);
    
    ind_ini=ind_ini_x_n+ind_ini_h_n
    
    %Posicion del vector donde finaliza la funcion X
    for i=size(x,2):-1:1
        
        if x(1,i)~=0
            ind_fin_x=i;
            break
        end
    end
    
    %N de inicio para X
    ind_fin_x_n=t(1,ind_fin_x);
    
    %Posicion del vector donde finaliza la funciòn H
    for i=size(h,2):-1:1
        
        if h(1,i)~=0
            ind_fin_h=i;
            break
        end
    end
    
    %N de inicio para H
    ind_fin_h_n=t(1,ind_fin_h);
    
    display('Vectores sin ceros');
    x_nZ=x(ind_ini_x:ind_fin_x);
    h_nZ=h(ind_ini_h:ind_fin_h);
    
    ind_fin=ind_fin_x_n+ind_fin_h_n;
    
    %Longitud
    Lx=size(x_nZ,2);
    Ly=size(h_nZ,2);
    L=Lx+Ly-1;
    
    %Calculo de Y
    
    if ind_ini<ind_fin
    
        Y=(ind_ini:ind_fin);
    else
        disp('Los valores del termino son incorrectos');
    end
    
    display(Y);
    
    disp('Tamaño matriz');
    tam_matriz=size(h_nZ,2)*(size(x_nZ,2)+(size(h_nZ,2)-1));
    
    
    matriz_conv=zeros(size(h_nZ,2),(size(x_nZ,2)+(size(h_nZ,2)-1)));
    
    
    %calculo de la matriz para realizar 
    % la convulución por tabulación
    cont_fila=1;
    cont_col=1;
    for i=1:1:size(h_nZ,2)
        cont_col=1;
        for j=1:1:size(x_nZ,2)+(size(h_nZ,2)-1)
            if(i~=1)
                if (j+cont_fila-1)<=size(x_nZ,2) & j==1 & i<=size(h_nZ,2)   
                    matriz_conv(i,j+cont_fila-1)=h_nZ(1,i)*x_nZ(1,j);
                    cont_col=cont_fila;
                elseif j<=size(x_nZ,2) & i<=size(h_nZ,2)
                    
                    matriz_conv(i,cont_col)=h_nZ(1,i)*x_nZ(1,j);
                end
            else
                if j<=size(x_nZ,2)
                    matriz_conv(i,j)=h_nZ(1,i)*x_nZ(1,j);
                end
            end
            cont_col=cont_col+1;
        end
    
        cont_fila=cont_fila+1;
        % Contador indicador de la fila en qu va
        %disp('Contador de fila: ');
        %disp(cont_fila);
    end
    
    disp(L);
    Y_s=zeros(1,L);
    
    %Proceso para realizar la sumatoria y 
    % obtener la convolución
    suma_col=0;
    for j=1:1:size(x_nZ,2)+(size(h_nZ,2)-1)
        suma_col=0;
        for i=1:1:size(h_nZ,2)
            suma_col=suma_col+matriz_conv(i,j);
            Y_s(j)=suma_col;
        end
    end
    
    %resultados de la convulucion de la operacion
    %disp(Y);
    %disp(Y_s);

    t1=Y;

    y=Y_s;
    
    result=[Y;Y_s];
    
    disp(result);
    
    %Grafica de la función x
    %figure(1)
    f_1=figure('Name','Función x','NumberTitle','off');
    g_x=stem(t,x); 
    
    %Grafica de la función h
    %figure(2)
    f_2=figure('Name','Función h','NumberTitle','off');
    g_h=stem(t,h);
    
    %Grafica de la convolución
    %figure(3)
    f_3=figure('Name','Función x*h','NumberTitle','off');
    g_C=stem(Y,Y_s);
    
    
    %Varias Graficas
    f_4=figure('Name','Funciones','NumberTitle','off');
    subplot(3,1,1),stem(t,x,Color='red'),title('Función x');
    subplot(3,1,2),stem(t,h,Color='magenta'),title('Función h');
    subplot(3,1,3),stem(Y,Y_s,Color='blue'),title('Función y=x*h');

end






