% main.m
%   1. selezionare l'immagine da ridimensionare
%   2. l'immagine viene convertita nel range [0,1](double)
%   3. viene chiamata la funzione che implementa il resizing
%   4. vengono mostrati e salvati i risultati

% Selezione del file immagine
[imgName, path] = uigetfile('./images/*.*', 'Select an image');
img = imread([path imgName]);

% Normalizzazione dell'immagine (range double [0..1])
normalized = normalize( img );

% Parametri della funzione per il resizing
energyMethod = 0;           % metodo da usare nella funzione "imenergy"
num_rows_removed = 100;     % numero di righe da rimuovere
num_cols_removed = 100;     % numero di colonne da rimuovere

% chiamando la funzione "shrink_SeamCarving" viene creata l'immagine ridimensionata
carved = shrink_SeamCarving(normalized,num_rows_removed,num_cols_removed,energyMethod);

% salvo i risultati (si possono visionare via browser aprendo il file "./results/risultati.html")
imwrite(normalized,'./results/last/0_originale.png');
energy = imenergy(normalized,energyMethod);
imwrite(energy,'./results/last/1_energia.png');
imwrite(normalize(horizontal_energy_cost(energy)),'./results/last/2_costo_o.png');
imwrite(normalize(vertical_energy_cost(energy)),'./results/last/2_costo_v.png');
imwrite(carved,'./results/last/4_result.png');

disp('SEAM CARVING COMPLETATO!');
% mostro i risultati attraverso un'interfaccia html
web('./results/risultati.html')

% % Nel caso non funzionasse (o si ritenesse scomoda) l'interfaccia html, decommentare il codice seguente:
    % % viene mostrata l'immagine originale
    % figure;
    % imshow( normalized );
    % title('originale');
    %
    % % viene mostrata l'immagine ridimensionata attraverso il Seam Carving
    % figure;
    % imshow( carved );
    % title([num2str(num_rows_removed) ' righe e ' num2str(num_cols_removed) ' colonne rimosse']);

%%% Per aprire l'interfaccia html per visionare i risultati è possibile
%%% digitare nella Command Window: web('./results/risultati.html')
