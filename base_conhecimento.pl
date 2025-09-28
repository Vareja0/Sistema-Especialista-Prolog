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
perfil(ciencia_de_dados, aprendizado_continuo, 3).

% --- Inteligência Artificial
perfil(inteligencia_artificial, matematica_estatistica, 4).
perfil(inteligencia_artificial, raciocinio_logico, 5).
perfil(inteligencia_artificial, problemas_teoricos, 4).
perfil(inteligencia_artificial, pensamento_abstrato, 4).
perfil(inteligencia_artificial, etica, 3).

% --- Desenvolvimento Web
perfil(desenvolvimento_web, raciocinio_logico, 5).
perfil(desenvolvimento_web, design, 4).
perfil(desenvolvimento_web, problemas_praticos, 4).
perfil(desenvolvimento_web, aprendizado_continuo, 4).
perfil(desenvolvimento_web, trabalho_coletivo, 3).


% --- Seguranca_da_informacao
perfil(seguranca_da_informacao, desenvolvimento, 5).
perfil(seguranca_da_informacao, raciocinio_logico, 5).
perfil(seguranca_da_informacao, trabalho_coletivo, 4).
perfil(seguranca_da_informacao, corporativismo, 3).
perfil(seguranca_da_informacao, etica, 3).

% --- Redes e infraestrutura
perfil(redes_e_infraestrutura, problemas_praticos, 5).
perfil(redes_e_infraestrutura, corporativismo, 5).
perfil(redes_e_infraestrutura, habilidade_manual, 4).
perfil(redes_e_infraestrutura, desenvolvimento, 2).
perfil(redes_e_infraestrutura, trabalho_coletivo, 4).

% --- Devops
perfil(devops, problemas_teoricos, 5).
perfil(devops, trabalho_coletivo, 4).
perfil(devops, raciocinio_logico, 3).
perfil(devops, desenvolvimento, 3).
perfil(devops, aprendizado_continuo, 5).

% --- Robotica
perfil(robotica, problemas_praticos, 5).
perfil(robotica, desenvolvimento, 4).
perfil(robotica, raciocinio_logico, 5).
perfil(robotica, design, 2).
perfil(robotica, habilidade_manual, 4).

% 3. Fatos: Perguntas para identificar as características no usuário
pergunta(1, 'Você tem afinidade com matemática e estatística?', matematica_estatistica).
pergunta(2, 'Você se sente realizado ao aplicar tecnologia para resolver problemas concretos e com resultados visíveis a curto prazo?', problemas_praticos).
pergunta(3, 'Você gosta de pesquisar e se aprofundar em conceitos teóricos, mesmo que eles não tenham uma aplicação prática imediata?', problemas_teoricos).
pergunta(4, 'Você gosta de resolver quebra-cabeças ou desafios que exigem raciocínio lógico?', raciocinio_logico).
pergunta(5, 'Você se considera uma pessoa colaborativa e que gosta de trabalhar em equipe?', trabalho_coletivo).
pergunta(6, 'Você prefere trabalhar em ambientes corporativos com hierarquia e processos bem definidos?', corporativismo).
pergunta(7, 'Você se interessa pela parte visual, como design, estética e experiência do usuário em produtos digitais?', design).
pergunta(8, 'Você tem curiosidade sobre como as empresas funcionam, geram lucro e definem estratégias?', curiosidade_negocio).
pergunta(9, 'Você se sente à vontade analisando planilhas, gráficos e grandes volumes de dados para encontrar padrões?', visualizacao_dados).
pergunta(10, 'Você prefere focar nos conceitos e modelos por trás de um problema a ir direto para a solução prática e imediata?', pensamento_abstrato).
pergunta(11, 'Você tem interesse em montar ou desmontar equipamentos, trabalhando com hardware e componentes físicos?', habilidade_manual).
pergunta(12, 'Você se sente motivado a estudar e aprender constantemente sobre novas ferramentas e tecnologias?', aprendizado_continuo).
pergunta(13, 'Você se preocupa com as implicações éticas e o impacto social da tecnologia?', etica).
pergunta(14, 'Você gosta de escrever código e desenvolver algoritmos para criar soluções de software?', desenvolvimento).



calcula_pontuacao_trilha(Trilha, PontuacaoFinal) :-
    % -> Procura todos os pares [Caracteristica, Peso] para a trilha passada.
    findall([Caracteristica, Peso], perfil(Trilha, Caracteristica, Peso), Perfis),
    % -> Chama o predicado que soma os pontos.
    soma_pontos(Perfis, 0, PontuacaoFinal).

% Caso Base
soma_pontos([], PontuacaoAcumulada, PontuacaoAcumulada). % -> Caso a lista de perfis esteja vazia, a pontuação é o valor acumulado.

soma_pontos([[Caracteristica, Peso] | RestoPerfis], PontuacaoAtual, PontuacaoFinal) :- % -> Pega o primeiro perfil da lista.
    % Verifica se a resposta foi positiva. Se sim, soma o peso, senão, não soma nada.
    (resposta_positiva(Caracteristica) -> NovaPontuacao is PontuacaoAtual + Peso ; NovaPontuacao is PontuacaoAtual),
    % Chama o predicado recursivamente para processar o resto da lista.
    soma_pontos(RestoPerfis, NovaPontuacao, PontuacaoFinal).


resposta_positiva(Caracteristica) :-
    pergunta(_, _, Caracteristica), % -> Procura se existe uma pergunta que possua a característica.
    pergunta(ID, _, Caracteristica), % -> "Pega" o ID da pergunta.
    resposta(ID, s). % -> Verifica se a resposta para essa pergunta foi positiva.


recomenda(RankingOrdenado) :-
    % findall -> Procurará por todas as soluções da consulta, no caso, todas as trilhas.
    findall(Trilha, trilha(Trilha, _), TodasTrilhas), % -> Pega o valor na variável Trilha e o coloca na lista TodasTrilhas.
    % A lista deve ficar parecida com: [ciencia_de_dados, desenvolvimento_web, etc].
    calcula_todas_pontuacoes(TodasTrilhas, Ranking), % -> Chama o predicado para calcular as pontuações.
    sort(0, @>=, Ranking, RankingOrdenado). % -> Ordena de forma decrescente.

calcula_todas_pontuacoes([], []). % -> Caso a lista de trilhas seja vazia, o ranking também será vazio.
calcula_todas_pontuacoes([Trilha | RestoTrilhas], [[Pontuacao, Trilha] | RestoRanking]) :-
    % O predicado pega o primeiro elemento ("Trilha") e calcula a pontuação da trilha.
    calcula_pontuacao_trilha(Trilha, Pontuacao),
    % Chama o predicado recursivamente para fazer o processamento do resto da lista.
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
exibe_resultado([]).
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


% Predicado para carregar o modo teste
testar(ArquivoPerfil) :-
    % Garante que a base de conhecimento e o sistema principal estão carregados.
    %consult('base_conhecimento.pl'),
    retractall(resposta(_, _)), % Limpa respostas antigas.
    consult(ArquivoPerfil), % Carrega as respostas do arquivo.
    format('~n--- Executando teste com o perfil: ~w ---~n', [ArquivoPerfil]),
    recomenda(Ranking),
    exibe_resultado(Ranking),
    nl, write('--- Fim do teste. ---'), nl.
