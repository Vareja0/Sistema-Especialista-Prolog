# Sistema-Especialista-Prolog

| | |
| :--- | :--- |
| **Instituição** | `Pontifícia Universidade Católica do Paraná` |
| **Disciplina** | `Programação lógica e funcional` |
| **Professor(a)** | `Frank Coelho De Alcantara` |


### 👥 Equipe

| Nome Completo| Usuário do GitHub |
| :--- | :--- |
| `Pedro Senes Velloso Ribeiro` | `prussianmaster1871 ` |
| `Ricardo Lucas Kucek` | `Ricardo-LK` |
| `Riscala Miguel Fadel Neto` | `Vareja0` |


## 🚀 Instalação e Execução

Para executar este projeto, você precisa ter o **SWI-Prolog** instalado em seu sistema. Você pode baixá-lo no site oficial:
[https://www.swi-prolog.org/download/stable](https://www.swi-prolog.org/download/stable)

### Passo a Passo

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/Vareja0/Sistema-Especialista-Prolog.git
    ```

2.  **Navegue até a pasta do projeto:**
    ```bash
    cd Sistema-Especialista-Prolog
    ```

3.  **Abra o SWI-Prolog:**
    Inicie o terminal do SWI-Prolog (`swipl`).

4.  **Carregue os arquivos do sistema:**
    Dentro do terminal do Prolog, consulte (carregue) os arquivos principais. O `sistema.pl` já deve consultar a base de conhecimento.
    ```prolog
    ?- ['sistema.pl']. 
    ```    
    
### Modos de Execução

#### 1. Modo Interativo

Este modo fará as perguntas diretamente a você.

-   Após carregar os arquivos, execute a consulta:
    ```prolog
    ?- iniciar.
    ```
-   Responda a cada pergunta com `s.` (sim) ou `n.` (não), sempre seguido de um ponto final (`.`).

#### 2. Modo de Teste Automatizado

Este modo utiliza um dos arquivos de perfil (`perfil_teste_X.pl`) para simular as respostas de um usuário.

-   Após carregar os arquivos, execute a consulta `testar/1`, passando o nome do arquivo de teste como argumento (entre aspas simples).

-   **Exemplo com o primeiro perfil de teste:**
    ```prolog
    ?- testar('perfil_teste_1.pl').
    ```

-   **Exemplo com o segundo perfil de teste:**
    ```prolog
    ?- testar('perfil_teste_2.pl').
    ```    
