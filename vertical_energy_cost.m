function C = vertical_energy_cost( E )
%VERTICAL_ENERGY_COST rappresentazione del costo energetico verticale dall'alto verso il basso
%   Utilizzando la programmazione dinamica questa funzione trova i costi
%   minori di tutti i seam verticali che potrebbero attraversare l'immagine.
    
    rows = size(E,1);
    cols = size(E,2);
    
    % per ogni riga (la prima rimane invariata)
    for y = 2 : rows
        % trovo il costo minimo prima sui lati
        E(y,1)    = E(y,1) + min( E(y-1,1:2) );
        E(y,cols) = E(y,cols) + min( E(y-1,cols-1:cols) );
        % e poi all'interno dell'immagine
        for x = 2 : cols-1
            E(y,x) = E(y,x) + min( E(y-1,x-1:x+1) );
        end
    end
    
    C = E;
    
end

