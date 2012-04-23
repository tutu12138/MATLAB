function wout=resamplePowerW(w,nx,ny,resampleFactor,pow,makeImage)
% Resamples (by resampleFactor) resutlts W of NMF (res.w), makes their power (by pow) and normalizes
% them to sum to 1. If pow is a vector (1 X ncomp) then i'th component is
% raised to the pow(i). (allows different components to be raised to
% different powers.)
% makeImage = 1 results in wout being stack of images (nx X ny X ncomp)
% rather then a nx*ny X ncomp matrix (default)
%
% wout=resamplePowerW(w,nx,ny,resampleFactor,pow,makeImage)
%
% example: 
% wout=resamplePowerW(res.w, peval.nx, peval.ny, 4,2,1);
% figure; imstiled(wout)

if ~exist('makeImage','var')
    makeImage = 0; 
end
ncomp=size(w,2); 
% wr=resampleImageStack(reshape(w, nx, ny, ncomp),resampleFactor).^pow;
% wout=normcSum(reshape(wr,resampleFactor^2*nx*ny,ncomp)); % normalized to sum to 1
wr=resampleImageStack(reshape(w, nx, ny, ncomp),resampleFactor);
wout=normcSum(bsxfun(@power,reshape(wr,resampleFactor^2*nx*ny,ncomp),pow')); % normalized to sum to 1
if makeImage
    wout = reshape(wout, resampleFactor*nx, resampleFactor*ny, ncomp); 
end