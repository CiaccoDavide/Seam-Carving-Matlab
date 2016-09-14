function [ S ] = vertical_seam( I ,energyMethod)
%VERTICAL_SEAM restituisce il seam verticale di costo minore
%   attraverso la mappatura energetica dell'immagine e il calcolo del costo
%   energetico dei seam verticali, questa funzione restituisce un vettore
%   lungo quanto l'altezza dell'immagine e contenente le coordinate
%   orizzontali del seam verticale

    altezza = size(I,1);
    larghezza = size(I,2);
    
    % calcola il valore energetico di ogni pixel dell'immagine
    E = imenergy(I,energyMethod);
    % ottieni la rappresentazione dei costi energetici dei seam verticali
    C = vertical_energy_cost(E);
    
    % trova l'index del minor costo nell'ultima riga
    [costo,index] = min(C(altezza,:));
    x = index;
    y = altezza;
    
    % partendo dal pixel di cui si è trovato l'index verticale ricostruisco
    % il seam orizzontale meno costoso usando la programmazione dinamica
    S = zeros(altezza,1);
    S(altezza)=x;
    
    while y > 1
        
        y = y-1;
        
        minore = C(y,x);
        i = x;
        
        if x ~= 1
            if C(y,x-1) < minore
                minore = C(y,x-1);
                i = x-1;
            end
        end
        if x ~= larghezza
            if C(y,x+1) < minore
                i = x+1;
            end
        end
        
        S(y) = i;
        x = i;
        
    end
    
end