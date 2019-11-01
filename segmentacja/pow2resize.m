function I = pow2resize(I)
[u,v]=size(I);
minSize = min([u,v]);
minSize = 2^(nextpow2(minSize)-1);
I=imresize(I,[minSize,minSize]);

end

