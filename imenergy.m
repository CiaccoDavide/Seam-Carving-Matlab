function [ E ] = imenergy( I,method )
%IMENERGY restituisce la rappresentazione energetica dell'immagine I
%   Implementazione dell'equazione energetica consigliata nell'articolo:
%   e = |dI/dx| + |dI/dy|
    
    switch method
        case 1
            dim = size(I);
            if length(dim) ==3
                F=energyRGB(I);
            else
                F=energyGrey(I);
            end
            [~, threshold] = edge(rgb2gray(I), 'sobel');
            fudgeFactor = .5;
            se90 = strel('line', 3, 90);
            se0 = strel('line', 3, 0);
            E = edge(rgb2gray(I),'sobel', threshold * fudgeFactor);
            E=(imfill(imdilate(E,[se90 se0]),'holes'));
            E=normalize(normalize(E)+normalize(F)*3);
        case 2
            I=energyGrey(rgb2gray(I));
            G = fspecial('gaussian',[40 40],2);
            E = I+imfilter(I,G,'same');
        case 3
            rgey = rgb2gray(I);
            [Gx, Gy] = imgradientxy(rgey);
            E=normalize((abs(Gy))+(abs(Gx)));
        otherwise
            % METODO 0 (default)
            %   collocato nel "otherwise" nel caso in cui non venga
            %   inserito un metodo valido (o venga scelto il metodo 0)
            dim = size(I);
            if length(dim) ==3
                E=energyRGB(I);
            else
                E=energyGrey(I);
            end
    end
    
    E=normalize(im2double(E));

    % funzione energia
    function res = energyRGB(I)
        res = energyGrey(I(:, :, 1)) + energyGrey(I(:, :, 2)) + energyGrey(I(:, :, 3));
    end
    function res = energyGrey(I)
        % e = |dI/dx| + |dI/dy|
        res = abs(imfilter(I, [-1,0,1], 'replicate')) + abs(imfilter(I, [-1;0;1], 'replicate'));
    end

end