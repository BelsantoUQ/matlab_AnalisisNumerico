% createUI
% Función principal para crear la interfaz de usuario (UI)
% calculateRoot:
%Se obtienen los valores ingresados por el usuario en los campos de entrada.
%Se convierte la cadena de texto de la ecuación en una función anónima manejable utilizando str2func.
%Se llama a la función raices_biseccion para calcular la raíz de la ecuación utilizando el método de bisección.
%Se muestra el resultado de la raíz en la etiqueta de resultado.
% raices_biseccion:
%Esta función implementa el método de bisección para encontrar la raíz de la ecuación dentro del intervalo 
% definido por lim_izquierda y lim_derecha con una precisión determinada por tolerancia.
%Se itera hasta que la aproximación de la raíz es suficientemente precisa o se encuentra la raíz exacta.
%Durante cada iteración, se actualizan los límites del intervalo basándose en los valores de la 
% función en los límites y en el punto medio calculado.
%Se devuelve la aproximación final como la raíz encontrada.

function createUI()
    % Crear la figura de la interfaz con un título y tamaño especificado
    fig = uifigure('Name', 'Calculadora de Raíces - Método de Bisección', 'Position', [100 100 400 300]);
    
    % Etiqueta y campo de entrada para la ecuación
    lblEquation = uilabel(fig, 'Text', 'Ecuación:', 'Position', [20 240 100 22]);
    txtEquation = uieditfield(fig, 'text', 'Position', [130 240 250 22]);
    
    % Etiqueta y campo de entrada para el límite izquierdo del intervalo
    lblLeftLimit = uilabel(fig, 'Text', 'Límite Izquierdo:', 'Position', [20 200 100 22]);
    txtLeftLimit = uieditfield(fig, 'numeric', 'Position', [130 200 100 22]);
    
    % Etiqueta y campo de entrada para el límite derecho del intervalo
    lblRightLimit = uilabel(fig, 'Text', 'Límite Derecho:', 'Position', [20 160 100 22]);
    txtRightLimit = uieditfield(fig, 'numeric', 'Position', [130 160 100 22]);
    
    % Etiqueta y campo de entrada para la tolerancia deseada
    lblTolerance = uilabel(fig, 'Text', 'Tolerancia:', 'Position', [20 120 100 22]);
    txtTolerance = uieditfield(fig, 'numeric', 'Position', [130 120 100 22]);
    
    % Botón para iniciar el cálculo de la raíz
    btnCalculate = uibutton(fig, 'push', 'Text', 'Calcular Raíz', 'Position', [130 80 100 22]);
    
    % Etiqueta para mostrar el resultado de la raíz calculada
    lblResult = uilabel(fig, 'Text', 'Raíz:', 'Position', [20 40 360 22], 'FontWeight', 'bold');
    
    % Definir la función que se ejecuta al presionar el botón de cálculo
    btnCalculate.ButtonPushedFcn = @(btn, event) calculateRoot(txtEquation, txtLeftLimit, txtRightLimit, txtTolerance, lblResult);
end

% Función para calcular la raíz utilizando el método de bisección
function calculateRoot(txtEquation, txtLeftLimit, txtRightLimit, txtTolerance, lblResult)
    % Obtener los valores ingresados por el usuario en los campos de entrada
    equationStr = txtEquation.Value;
    leftLimit = txtLeftLimit.Value;
    rightLimit = txtRightLimit.Value;
    tolerance = txtTolerance.Value;
    
    % Convertir la cadena de la ecuación en una función manejable
    ecuacion = str2func(['@(x)' equationStr]);
    
    % Llamar a la función raices_biseccion para calcular la raíz
    raiz = raices_biseccion(ecuacion, leftLimit, rightLimit, tolerance);
    
    % Mostrar el resultado de la raíz en la etiqueta de resultado
    lblResult.Text = ['Raíz: ' num2str(raiz)];
end

% Función para encontrar la raíz de una ecuación usando el método de bisección
function [raiz] = raices_biseccion(ecuacion, lim_izquierda, lim_derecha, tolerancia)
    iterar = 1; % Variable de control para el bucle de iteración
    aproximacion_anterior = nan; % Inicializar la aproximación anterior como no numérico
    aproximacion = nan; % Inicializar la aproximación actual como no numérico

    % Bucle para iterar hasta encontrar la raíz con la precisión deseada
    while (iterar)
        % Calcular el punto medio del intervalo actual
        aproximacion = (lim_izquierda + lim_derecha) / 2;

        % Verificar si la aproximación es suficientemente precisa o si se ha encontrado la raíz exacta
        if (abs(aproximacion - aproximacion_anterior) / aproximacion < tolerancia || ecuacion(aproximacion) == 0)
            iterar = 0; % Detener las iteraciones si se cumple la condición
        end

        % Actualizar los límites del intervalo basándose en el signo del producto de los valores de la función en los límites
        if (ecuacion(lim_izquierda) * ecuacion(lim_derecha) < 0)
            lim_derecha = aproximacion;
        else
            if (ecuacion(lim_izquierda) * ecuacion(lim_derecha) > 0)
                lim_izquierda = aproximacion;
            end
        end

        % Actualizar la aproximación anterior con la aproximación actual
        aproximacion_anterior = aproximacion;
    end

    % Devolver la aproximación como la raíz encontrada
    raiz = aproximacion;
end
