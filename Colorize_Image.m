function Color_Image = Colorize_Image(Resized_Image, Complemented_Image, Colorspace_Definition)


DEFAULT_COLOR = [1 1 1];

if nargin < 3
    Colorspace_Definition = DEFAULT_COLOR;
end

Complemented_Image = (Complemented_Image ~= 0);

Resized_Uint8 = im2uint8(Resized_Image);
Color_Uint8 = im2uint8(Colorspace_Definition);

if ismatrix(Resized_Uint8)
    
    Red_Channel   = Resized_Uint8;
    Green_Channel = Resized_Uint8;
    Blue_Channel  = Resized_Uint8;
    
else
    
    Red_Channel   = Resized_Uint8(:,:,1);
    Green_Channel = Resized_Uint8(:,:,2);
    Blue_Channel  = Resized_Uint8(:,:,3);
    
end

Red_Channel(Complemented_Image)   = Color_Uint8(1);
Green_Channel(Complemented_Image) = Color_Uint8(2);
Blue_Channel(Complemented_Image)  = Color_Uint8(3);


Color_Image = cat(3, Red_Channel, Green_Channel, Blue_Channel);

end

    
    