function S = horizontal_seam( I ,energyMethod)
%HORIZONTAL_SEAM restituisce il seam orizzontale di costo minore
%   attraverso la mappatura energetica dell'immagine e il calcolo del costo
%   energetico dei seam orizzontali, questa funzione restituisce un vettore
%   lungo quanto la larghezza dell'immagine e contenente le coordinate
%   verticali del seam orizzontale

    % si potrebbe la funzione verticale con la trasposta dell'immagine per
    % ottenere lo stesso risultato: S = horizontal_seam(I',energyMethod)'
    
    altezza = size(I,1);
    larghezza = size(I,2);
    
    % calcola il valore energetico di ogni pixel dell'immagine
    E = imenergy(I,energyMethod);
    % ottieni la rappresentazione dei costi energetici dei seam orizzontali
    C = horizontal_energy_cost(E);
    
    % trova l'index del minor costo nell'ultima colonna
    [costo,index] = min(C(:,larghezza));
    x = larghezza;
    y = index;
    
    % partendo dal pixel di cui si è trovato l'index verticale ricostruisco
    % il seam orizzontale meno costoso usando la programmazione dinamica
    S = zeros(larghezza,1);
    S(larghezza) = y;
    
    while x > 1
        
        x = x-1;
        
        minore = C(y,x);
        i = y;
        
        if y ~= 1
            if C(y-1,x) < minore
                minore = C(y-1,x);
                i = y-1;
            end
        end
        if y ~= altezza
            if C(y+1,x) < minore
                i = y+1;
            end
        end
        
        S(x) = i;
        y = i;
        
    end
    
end