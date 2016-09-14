function N = normalize( I )
%NORMALIZE trasforma matrici di range variabile in matrici di range [0,1](double)
%   per le immagini con range [0..255] basterebbe un I/255, ma questa
%   funzione mi permette di normalizzare a [0..1] qualsiasi matrice (e la converte in double)

    I=double(I);                    % converto i valori della matrice in double
    range = max(I(:))-min(I(:));    % stabilisco l'intervallo tra il valore minimo e quello massimo
    N = (I-min(I(:)))/range;        % porto i valori double della matrice nel range [0..1]
    
end

