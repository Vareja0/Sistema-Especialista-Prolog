
:- discontiguous trilha/2.
:- discontiguous perfil/3.
:- discontiguous pergunta/3.
    
    
% 1. Fatos: Definição das trilhas de especialização
trilha(ciencia_de_dados, 'Análise e interpretação de grandes volumes de dados para extrair conhecimento.').
trilha(inteligencia_artificial, 'Desenvolvimento de sistemas que simulam a capacidade humana de raciocinar e aprender.').
trilha(desenvolvimento_web, 'Criação de sites, aplicações e sistemas que rodam na web, do visual (front-end) à lógica (back-end).').
trilha(seguranca_da_informacao, 'Proteção de sistemas, redes e dados contra ataques e acessos não autorizados.').
trilha(redes_e_infraestrutura, 'Gerenciamento e manutenção de toda a infraestrutura física e lógica que suporta os sistemas.').
trilha(devops, 'Implementacao pipelines de integração contínua e entrega contínua (CI/CD), automatizacao de infraestruturas, geracao de bases de dados e redes e monitoracao de sistemas.').
trilha(robotica, 'Desenvolvimento de sistemas, combinando engenharia para realizar tarefas de forma autonoma e semi-autonoma').

% 2. Fatos: Características de perfil para cada trilha com seu peso
% --- Ciência de Dados
perfil(ciencia_de_dados, matematica_estatistica, 5).
perfil(ciencia_de_dados, raciocinio_logico, 5).
perfil(ciencia_de_dados, visualizacao_dados, 4).
perfil(ciencia_de_dados, curiosidade_negocio, 3).

% --- Inteligência Artificial
perfil(inteligencia_artificial, matematica_estatistica, 5).
perfil(inteligencia_artificial, raciocinio_logico, 5).
perfil(inteligencia_artificial, problemas_teoricos, 4).
perfil(inteligencia_artificial, pensamento_abstrato, 4).

% --- Desenvolvimento Web
perfil(desenvolvimento_web, raciocinio_logico, 5).
perfil(desenvolvimento_web, design, 3).
perfil(desenvolvimento_web, resolucao_problemas_praticos, 4).
perfil(desenvolvimento_web, aprendizado_continuo, 4).

% --- Seguranca_da_informacao
perfil(seguranca_da_informacao, desenvolvimento, 5).
perfil(seguranca_da_informacao, raciocinio_logico, 5).
perfil(seguranca_da_informacao, trabalho_coletivo, 4).
perfil(seguranca_da_informacao, corporativismo, 3).

% --- Redes e infraestrutura
perfil(redes_e_infraestrutura, problemas_praticos, 5).
perfil(redes_e_infraestrutura, corporativismo, 5).
perfil(redes_e_infraestrutura, design, 4).
perfil(redes_e_infraestrutura, desenvolvimento, 2).

% --- Devops
perfil(devops, problemas_teoricos, 5).
perfil(devops, trabalho_coletivo, 4).
perfil(devops, raciocinio_logico, 3).
perfil(devops, desenvolvimento, 2).

% --- Robotica
perfil(robotica, problemas_praticos, 5).
perfil(robotica, desenvolvimento, 3).
perfil(robotica, raciocinio_logico, 4).
perfil(robotica, design, 2).

% 3. Fatos: Perguntas para identificar as características no usuário
pergunta(1, 'Você tem afinidade com matemática e estatística?', matematica_estatistica).
pergunta(2, 'Voce prefere problemas praticos a problemas teoricos?', problemas_praticos).
pergunta(3, 'Voce prefere problemas teoricos a problemas praticos?', problemas_teoricos).
pergunta(4, 'Voce tem facilidade na resolucao de problemas logicos?', raciocinio_logico).
pergunta(5, 'Voce tem facilidade em se comunicar em equipe?', trabalho_coletivo).
pergunta(6, 'Voce tem interesse em trabalhar para uma empresa hierarquisada?', corporativismo).
pergunta(7, 'Voce tem interesse na area de desing?', design).
pergunta(8, 'Voce tem interesse em trabalhar no ramo de negocios?', curiosidade_negocio).
pergunta(9, 'Pergunta visualizacao dados?', visualizacao_dados).
pergunta(10, 'Pergunta pensamento abstrato?', pensamento_abstrato).



calcula_pontuacao_trilha(Trilha, PontuacaoFinal) :-
    % -> procura todos os pares [Caracteristica, Peso] para a trilha passada
    findall([Caracteristica, Peso], perfil(Trilha, Caracteristica, Peso), Perfis),
    % -> chama o predicado que conta os pontos
    soma_pontos(Perfis, 0, PontuacaoFinal).

% Caso Base
soma_pontos([], PontuacaoAcumulada, PontuacaoAcumulada). % -> caso a lista de perfis esteja vazio, a pontuacao 'e o acumulado

soma_pontos([[Caracteristica, Peso] | RestoPerfis], PontuacaoAtual, PontuacaoFinal) :- % -> pega o primeiro perfil da lista
    % verifica se a resposta foi positiva, se sim, soma o peso. Senao, nao soma nada
    (resposta_positiva(Caracteristica) -> NovaPontuacao is PontuacaoAtual + Peso ; NovaPontuacao is PontuacaoAtual),
    % chama o predicado recursivamente para fazer o processamento do resto da lista
    soma_pontos(RestoPerfis, NovaPontuacao, PontuacaoFinal).


resposta_positiva(Caracteristica) :-
    pergunta(_, _, Caracteristica), % -> procure se existe uma pergunta que possua a caracteristica
    pergunta(ID, _, Caracteristica), % -> "pega" o id da pergunta
    resposta(ID, s). % -> verifica se a resposta para a pergunta foi positiva


recomenda(RankingOrdenado) :-
    % findal -> procurara por todas as solucoes da consulta, no caso, todas as trilhas
    findall(Trilha, trilha(Trilha, _), TodasTrilhas), % -> pegue o valor na variavel, ou seja, o segundo elemento de trilha(Trilha, _), e coloque na lista TodasTrilhas
    % A lista deve ficar parecida com: [ciencia_de_dados, desenvolvimento_web, etc]
    calcula_todas_pontuacoes(TodasTrilhas, Ranking), % -> chama o predicado para calcular a pontuacao
    sort(0, @>=, Ranking, RankingOrdenado). % -> ordena de forma decrescente

calcula_todas_pontuacoes([], []). % -> caso a lista de trilhas for vazia, o ranking tambem sera vazio
calcula_todas_pontuacoes([Trilha | RestoTrilhas], [[Pontuacao, Trilha] | RestoRanking]) :-
 	% o predicado pega o primeiro elemento ("Trilha"), e calcula a pontuacao da trilha
    calcula_pontuacao_trilha(Trilha, Pontuacao),
    % chama o predicado recursivamente para fazer o processamento do resto da lista
    calcula_todas_pontuacoes(RestoTrilhas, RestoRanking).

% Predicado para salvar as respostas do usuario dinamicamente
:- dynamic resposta/2.

% Inicia o programa
iniciar :-
    % Limpa respostas das execuçoes anteriores
    retractall(resposta(_, _)),
    write('Sistema Especialista para Recomendação de Trilha Acadêmica:'), nl,
    write('Responda as seguintes perguntas com s (sim) ou n (nao)'), nl, nl,
    
    % Inicia o questionario
    faz_perguntas,
    
    % Gera e mostra o resultado
    recomenda(Ranking),
    exibe_resultado(Ranking),
    nl, write('--- Fim da recomendação. ---'), nl.

faz_perguntas :-
    % Encontra todas as perguntas
    findall([ID, Texto], pergunta(ID, Texto, _), Perguntas), % Perguntas [id, pergunta]
    percorre_perguntas(Perguntas).

percorre_perguntas([]). % Caso base lista de perguntas vazia
percorre_perguntas([[ID, Texto] | Resto]) :- % Tira primeira pergunta da lista 
    pergunta_usuario(ID, Texto),
    percorre_perguntas(Resto).

pergunta_usuario(ID, Texto) :-
    write(Texto), write(' (s/n): '),
    read(Resposta), % Le input e guarda em Resposta
    ( (Resposta == s ; Resposta == n) ->
        assertz(resposta(ID, Resposta))
    ;
        write('Resposta invalida. Por favor, responda com s ou n.'), nl,
        pergunta_usuario(ID, Texto) % Pede novamente em caso de erro.
    ).

% Mostra rank de afinidade
exibe_resultado([[Pontuacao, Trilha] | Resto]) :-
    trilha(Trilha, Descricao),
    format('~n--- Trilha Recomendada: ~w (Pontuação: ~w) ---~n', [Trilha, Pontuacao]),
    format('~w~n', [Descricao]),
    justifica_recomendacao(Trilha),
    exibe_resultado(Resto).

% Justifica a recomendação mostrando quais respostas contribuiram.
justifica_recomendacao(Trilha) :-
    write('Esta trilha foi recomendada porque você respondeu ''sim'' a perguntas relacionadas a:'), nl,
    perfil(Trilha, Caracteristica, Peso),
    resposta_positiva(Caracteristica),
    pergunta(_, TextoPergunta, Caracteristica),
    format('- ~w (relevância: ~w/5)~n', [TextoPergunta, Peso]),
    fail. % Força o backtracking para encontrar todas as justificativas.
    
justifica_recomendacao(_). % Impede que o predicado falhe no final.
