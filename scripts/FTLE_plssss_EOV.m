addPath;

ndof = 16;  %16 degree of freedom Timoshenko beam
ndof_spv = 2*ndof;

dy = @(t,x) TIMOSHENKODE(t,x.');
dygrad = @(t,x) TIMOSHENKODE_GRAD(t,x.');


dyMASS = @(t,x) TIMOSHENKODEWithMass(t,x.');
l = load('MMtx.mat');
MassMtx = l.MassMtx;

domain = [-3,3; -3, 3];
resolution = [100,100];
timeSpan = [0,8];
vars = [ndof, 2*ndof];
init = Grid(ndof_spv, vars, resolution, domain, 1e-8);
icGrid = init.points;
pool = parpool('local', 64);
tolerance = 1e-12;
[ft1, ~] = computeCGInvariantsode45EOV(dy, dygrad, icGrid, timeSpan, false, 1e-6);
ft1 = reshape(ft1, resolution);

save('FTLETimoshenko_EOV_only.mat',  'ft1', 'timeSpan', 'resolution', 'domain', 'vars');
pool.delete();