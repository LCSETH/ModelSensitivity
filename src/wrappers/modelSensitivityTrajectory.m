function [t, MSsqtraj] = modelSensitivityTrajectory(system, point, timeSpan, timeStep, tolerance, method)
%Wrapper to compute the square of the Model Sensitivity
%Integrates the maximal eigenvalue and trace of the CG strain tensor along
%a trajectory, and returns the time dependence.
%   system is a DynSystem object. Has methods .rhs() and possiply
%   .gradrhs()
%   point is the Initial point for the trajectory, along which we calculate
%   the model sensitivity
%   timespan is [t0,t] : the time interval of the computation

derivative = @(t,x) system.rhs(t,x);  % have to keep this form for compute
derivativeEov = @(t,x) system.gradRhs(t,x);

[t, MSsqtraj] = computeMSAlongTrajectoryGeneral(derivative, derivativeEov, point, timeSpan, timeStep, tolerance, 1, system.deltas, method);
end

