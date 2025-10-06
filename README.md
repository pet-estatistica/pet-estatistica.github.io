# pet-estatistica.github.io

[![Netlify
Status](https://api.netlify.com/api/v1/badges/02ea8d59-deed-4afb-943e-fc1c475f9f35/deploy-status)](https://app.netlify.com/sites/pet-est/deploys)

## Requisitos

-   Git
-   R
-   Pacote RBlogdown     `install.packages("blogdown")`
-   Hugo versão 0.121.2  `blogdown::install_hugo(version="0.121.2")`

## Contexto

O site foi construído com o pacote
[blogdown](https://bookdown.org/yihui/blogdown/), que permite escrever
com documentos do Rmarkdown. O mecanismo por trás do site é o
[Hugo](https://gohugo.io/), que transforma em HTML páginas escritas em
Markdown (`*.md`).

Entretanto nós escrevemos diretamente em Markdown (`*.md*`), e o Hugo
converte para HTML, pois a dinâmica do site não está mais focada em
blogs, e sim em conteúdo das matérias do curso de Estatística e Ciência
de Dados e em informações sobre o PET Estastística UFPR.

## Começando

A primeira coisa a fazer é clonar este repositório com

``` bash
git clone https://github.com/pet-estatistica/pet-estatistica.github.io.git
```

ou usando a interface do RStudio.

Depois basta abrir o R neste diretório e instalar o Hugo na versão
`'0.121.2'`, para garantir a compatibilidade com a versão do
repositório.

``` r
blogdown::install_hugo(version="0.121.2")
```

Após a instalação rode o comando `blogdown::serve_site()` para iniciar
um servidor do hugo, a fim de verificarmos se o site vai abrir sem
nenhum problema.

``` r
blogdown::serve_site()
```

Obs.: Se estiver rodando o R em um container Docker na sua máquina
local, use:

``` r
blogdown::serve_site(host="0.0.0.0")
```

Em seguinda uma página irá abrir no seu navegador com o conteúdo do site
já renderizado.

No RStudio, basta clicar no botão "Addins \> Serve Site" que o mesmo
acontecerá automaticamente.

### O que alterar

Não altere a versão do Hugo, deixe na versão `0.121.2`, a fim de
garantir a compatibilidade com os scripts da Netlify e o domínio do
<https://pet.leg.ufpr.br>

Só altere se você sabe o que está fazendo, e tem um backup de como
voltar antes da alteração.

### Estrutura do Site

O site utiliza a estrutura padrão do hugo, com excessão que não temos o
diretório `content/blog` e ou `content/postagens`, ao invés possuímos
uma estrutura que atende as demandas atuais do PET.

Abaixo estão as pastas no diretório raiz do site:

``` bash
tree -L 1
.
├── antigo/
├── config.toml
├── content/
├── data/
├── deploy.sh
├── layouts/
├── netlify.toml
├── public/
├── static/
└── themes/

11 directories, 6 files
```

Breve explicação dos diretórios:

-   *`antigo`*: é onde está o site antigo do PET
-   *`config.toml`*: é o arquivo de configuração do Hugo, mais
    informações em [All settings](https://gohugo.io/configuration/all/)
-   *`content`*: é onde fica os arquivos de conteúdo do site.
-   *`data`*: é onde fica os arquivos com informações dos petianos
-   *`deploy.sh`*: é o arquivo de deploy para o Netlify.
-   *`layouts`*: é onde ficam os templates de layouts das páginas.
-   *`netlify.toml`*: é o arquivo de configuração do Netlify.
-   *`public`*: é o diretório onde o site estático é gerado e salvo por
    padrão.
-   *`static`*: é o diretório onde estão todos os arquivos PDF e Imagens
    do site, sempre que precisar salvar algum arquivo estático, salve
    nele.
-   *`themes`*: é o diretório onde está o tema que estamos usando.

Abaixo estão as pastas do diretório `content`

``` bash
.
├── 404.md
├── atividades\
├── contato\
├── integrantes\
├── materiais\
├── obrigado\
├── processos\
├── redessociais\
├── selecao\
└── sobre\
```

### Alterando conteúdo do site

Para criar um novo post no blog siga estes passos (supondo que está no
RStudio):

1.  Crie um novo branch
2.  Nevegue até a pasta correspondente com a página que deseja alterar
    dentro de *`content`*
3.  Abra o arquivo correspondente, ou crie um novo arquivo *`.md`* no
    caso de processos
4.  Edite o arquivo e salve
5.  Faça um commit e push para o GitHub
6.  No GitHub, crie um *pull request* e marque alguém para revisar o
    post

Depois de finalizadas estas etapas, o responsável deverá fazer o *merge*
do post no ramo principal.

### Alterando informações dos Petianos

As informações podem ser alteradas dentro do arquivo *`data/team.yml`*

Se as alterações forem grandes, crie um *branch* e faça um *pull
request* (similar ao processo de criação de posts).

### Adicionando materiais da página materiais/disciplinas/

As informações devem ser alteradas dentro do arquivo *`data/disciplinas.yml`*

No arquivo elas estão sendo escritas utilizando a sintaxe [yaml](https://yaml.org/spec/1.2.2/), começando sempre pelo curso, conforme abaixo:
```yml
disciplinas:
  - codigo: "CE301"
    nome: "Estatística Básica"
    emoji: "📊"
```

Em seguida temos a separação por Anos, e em cada ano temos a estrutura que salva os arquivos:
```yml
disciplinas:
  - codigo: "CE301"
    nome: "Estatística Básica"
    emoji: "📊"
    anos:
      - ano: 2025
        professores: "Dra. Amanda Merian Freitas Mendes, Dra. Sílvia Emiko Shimakura, Dr. Paulo Justiniano Ribeiro Junior"
        semestre: "1"
        materiais:
          - categoria: "🌐 Atividades Online"
            itens:
              - descricao: "Respostas Atividade online 1"
                arquivo: "/pdfs/CE301/2025/Respostas-Atividade-Online-1.pdf"
                tipo: "PDF"
                autor: "Júlia Zorzo Ferreira"
                url_autor: "/integrantes/#julia-zorzo-ferreira"
              - descricao: "Respostas Atividade online 2"
                arquivo: "/pdfs/CE301/2025/Respostas-Atividade-Online-2.pdf"
                tipo: "PDF"
                autor: "Júlia Zorzo Ferreira"
                url_autor: "/integrantes/#julia-zorzo-ferreira"
```

Sempre se atentar a escrever corretamente o nome dos professores, o semestre e principalmente o caminho dos arquivos, senão eles mão irão funcionar, abaixo está a configuração atual da matéria CE301 Estatística Básica

```yml
disciplinas:
  - codigo: "CE301"
    nome: "Estatística Básica"
    emoji: "📊"
    anos:
      - ano: 2025
        professores: "Dra. Amanda Merian Freitas Mendes, Dra. Sílvia Emiko Shimakura, Dr. Paulo Justiniano Ribeiro Junior"
        semestre: "1"
        materiais:
          - categoria: "🌐 Atividades Online"
            itens:
              - descricao: "Respostas Atividade online 1"
                arquivo: "/pdfs/CE301/2025/Respostas-Atividade-Online-1.pdf"
                tipo: "PDF"
                autor: "Júlia Zorzo Ferreira"
                url_autor: "/integrantes/#julia-zorzo-ferreira"
              - descricao: "Respostas Atividade online 2"
                arquivo: "/pdfs/CE301/2025/Respostas-Atividade-Online-2.pdf"
                tipo: "PDF"
                autor: "Júlia Zorzo Ferreira"
                url_autor: "/integrantes/#julia-zorzo-ferreira"
      - ano: 2024
        professores: "Dra. Sílvia Emiko Shimakura, Me. Lineu Alberto Cavazani de Freitas"
        semestre: "1"
        materiais:
          - categoria: "📚 Listas de exercícios"
            itens:
              - descricao: "Todas as listas"
                arquivo: "/pdfs/CE301/2024/listas.zip"
                tipo: "ZIP"
          - categoria: "📋️ Resumos"
            itens:
              - descricao: "Resumo P1"
                arquivo: "/pdfs/CE301/2024/resumo_P1.jpg"
                tipo: "JPG"
                autor: "Júlia Zorzo Ferreira"
                url_autor: "/integrantes/#julia-zorzo-ferreira"
              - descricao: "Resumo P2"
                arquivo: "/pdfs/CE301/2024/resumo_p2.jpg"
                tipo: "JPG"                   
                autor: "Júlia Zorzo Ferreira"
                url_autor: "/integrantes/#julia-zorzo-ferreira"
```

Se as alterações forem grandes, crie um *branch* e faça um *pull
request* (similar ao processo de criação de posts).

## Publicando o site

O site está configurado para ser publicado automaticamente quando
qualquer *push* for dado para o repositório (no ramo *master*), por meio
do [Netlify](https://www.netlify.com/). O arquivo `netlify.toml` já
possui as informações necessárias para gerar o site.

O *custom domain* `pet.leg.ufpr.br` foi configurado no Netlify e as
entradas apropriadas foram inseridas no DNS do servidor do LEG.

## Links e referências

### Configurações

-   [Hugo Future Imperfect Slim
    wiki](https://github.com/pacollins/hugo-future-imperfect-slim/wiki)
-   [Configure
    Hugo](https://gohugo.io/getting-started/configuration/#all-configuration-settings):
    configurações básicas
-   [Hugo's Lookup Order](https://gohugo.io/templates/lookup-order/):
    importante para saber o que é executado primeiro
-   [Hugo Shortcodes](https://gohugo.io/content-management/shortcodes/):
    maneiras de incluir *snippets* de código, como vídeos do Youtube,
    tweets, etc
-   [Multilingual
    Mode](https://gohugo.io/content-management/multilingual/): sobre
    páginas multi-línguas
-   [Image
    Processing](https://gohugo.io/content-management/image-processing/#image-processing-config):
    processamento de figuras

### Tutoriais

-   [A Blogdown New Post Workflow with Github and
    Netlify](https://www.garrickadenbuie.com/blog/blogdown-netlify-new-post-workflow/)
-   [Fun blogdown in R to design a personal
    website](https://annielyu.com/2020/01/12/blogdown-website/)
-   [Blogdown Tutorial (in
    Portuguese)](https://diegopftrindade.netlify.app/post/blogdown-tutorial-in-portuguese/)
-   [How to build a website with Blogdown in
    R](https://www.storybench.org/how-to-build-a-website-with-blogdown-in-r/)
-   [How Not To Knit All Rmd Files With
    Blogdown](https://yutani.rbind.io/post/2017-10-25-blogdown-custom/)
