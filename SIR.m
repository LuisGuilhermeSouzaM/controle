function [ret] = SIR(Beta,r)
    ret = sim("SimulacaoSIR.slx", Beta, r)
    return ret
end