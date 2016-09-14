function J = shrink_SeamCarving( I, num_rows_removed, num_cols_removed, energyMethod )
%SHRINK_SEAMCARVING Funzione che gestisce il processo di resizing
%   Questa funzione accetta in ingresso 4 parametri: l'immagine da
%   ridimensionare, il numero di righe da rimuovere, il numero di colonne
%   da rimuovere e il metodo da usare nella funzione "imenergy".
%   In base agli input forniti verranno eliminate progressivamente righe
%   e/o colonne dall'immagine usando la tecnica del Seam Carving

    % controllo sulla dimensione dell'immagine (se è possibile rimuovere il numero di righe/colonne desiderato)
    if num_rows_removed >= size(I,1) || num_cols_removed >= size(I,2)
        error('Il numero delle righe/colonne da rimuovere non può essere maggiore del numero di righe/colonne esistenti!');
    end

    % inizializzazione della maschera da sovrapporre all'immagine originale
    % per visualizzare i seam rimossi
    removedSeamsMask = false(size(I,1),size(I,2));
    R_orizzontali = I;    % i seam rimossi saranno visualizzati sull'immagine originale
    
    % rimozione delle righe (seam orizzontali)
    while num_rows_removed > 0
        
        disp(['Rows to be removed: ' num2str(num_rows_removed)]);
        
        % trovo il seam orizzontale dal costo energetico minore
        HorizontalSeam = horizontal_seam(I,energyMethod);
        % aggiungo il seam da rimuovere alla maschera dei seam rimossi
        removedSeamsMask = addSeamToMask(removedSeamsMask,HorizontalSeam);
        % rimuovo il seam dall'immagine
        I = remove_horizontal_seam(I,HorizontalSeam);
        
        num_rows_removed = num_rows_removed - 1;
        
    end
    
    % sovrappongo i seam orizzontali rimossi all'immagine originale
    R_orizzontali(removedSeamsMask) = 1;
    
    % reset della removedSeamsMask
    removedSeamsMask = false(size(I,1),size(I,2));
    R_verticali = I;    % i seam verticali rimossi saranno visualizzati sull'immagine ridimensionata in altezza
    
    % rimozione delle colonne (seam verticali)
    while num_cols_removed > 0
        
        disp(['Columns to be removed: ' num2str(num_cols_removed)]);
        
        % trovo il seam verticale dal costo energetico minore
        VerticalSeam = vertical_seam(I,energyMethod);
        % aggiungo il seam da rimuovere alla maschera dei seam rimossi
        removedSeamsMask = addSeamToMask(removedSeamsMask',VerticalSeam)';
        % rimuovo il seam dall'immagine
        I = remove_vertical_seam(I,VerticalSeam);
        
        num_cols_removed = num_cols_removed - 1;
        
    end

    J = I;
    
    
    % sovrappongo i seam verticali rimossi all'immagine ridimensionata in altezza
    R_verticali(removedSeamsMask) = 1;
    
    
    % salvo le sovrapposizioni (verranno mostrate attraverso l'interfaccia html alla fine dell'esecuzione)
    imwrite(R_orizzontali,'./results/last/3_seam_o.png');
    imwrite(R_verticali,'./results/last/3_seam_v.png');
    
    % Per visualizzare i seam rimossi alla fine dell'esecuzione,
    % decommentare il codice seguente:
%     figure;
%     % mostra i seams orizzontali sovrapposti all'immagine originale
%     subplot(1,2,1);
%     imshow(R_orizzontali);
%     % e quelli verticali (sull'immagine ridimensionata in altezza)
%     subplot(1,2,2);
%     imshow(R_verticali);

end