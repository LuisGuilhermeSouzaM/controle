function [EQ] = ErroQuadraticoSIR(X,Rd,Id, Sd)
% Esta função determina o erro quadrático
% entre a saída real e a saída do modelo.
% u - entrada real
% y - saída real
% t - tempo real
% X = [Km pm];

%% Tamanho da população - N

beta = X(1);
r = X(2);

%%% Modelo
mdl = 'SimulacaoSIR';
load_system(mdl)
cs = getActiveConfigSet(mdl);
mdl_cs = cs.copy;
set_param(mdl_cs,'AbsTol','1e-5',...
         'SaveState','on','StateSaveName','xoutNew',...
         'SaveOutput','on','OutputSaveName','youtNew');
simOut = sim(mdl, mdl_cs);

%%% Saida do modelo
S = simOut.logsout{1}.Values.Data; % Saída I
I = simOut.logsout{2}.Values.Data; % Saída I
R = simOut.logsout{3}.Values.Data; % Saída R

S = resample(S,length(S),length(Sd));
I = resample(I,length(I),length(Id));
R = resample(R,length(R),length(Rd));

%%% Erro quadrático

% Eq = sum((I - Id).^2) + sum((R - Rd).^2); %% cálculo do erro
erroS = S - Sd;
erroI = I - Id;
erroR = R - Rd;
EQ = horzcat(erroS,erroI,erroR);

% plot(t,y,t,ym,"linewidth", 2)

end