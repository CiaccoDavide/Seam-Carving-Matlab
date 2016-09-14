function C = horizontal_energy_cost( E )
%HORIZONTAL_ENERGY_COST rappresentazione del costo energetico orizzontale da sinistra a destra
%   Utilizzando la programmazione dinamica questa funzione trova i costi
%   minori di tutti i seam orizzontali che potrebbero attraversare l'immagine.
    
    rows = size(E,1);
    cols = size(E,2);
    
    % per ogni colonna (la prima rimane invariata)
    for x = 2 : cols
        % trovo il costo minimo prima sui lati
        E(1,x)    = E(1,x) + min( E(1:2,x-1) );
        E(rows,x) = E(rows,x) + min( E(rows-1:rows,x-1) );
        % e poi all'interno dell'immagine
        for y = 2 : rows-1
            E(y,x) = E(y,x) + min( E(y-1:y+1,x-1) );
        end
    end
    
    C = E;
        
end

