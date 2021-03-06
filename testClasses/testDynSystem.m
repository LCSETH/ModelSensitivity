testConstructor()













function passes = testConstructor()
deriv = @(t,x,e,eov) d_phi(t,x,e,eov);
dyn = DynSystem(deriv, 2, [0,0]);
value = dyn.rhs(0, [1., 1.], 0, false);
trueValue = [1., 0.15];
passes = all(value == trueValue);
end
