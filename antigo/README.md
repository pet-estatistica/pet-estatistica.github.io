# pet-estatistica.github.io

[![Netlify Status](https://api.netlify.com/api/v1/badges/02ea8d59-deed-4afb-943e-fc1c475f9f35/deploy-status)](https://app.netlify.com/sites/pet-est/deploys)

## Como usar

O site foi construído com o pacote [blogdown][], que permite escrever
com documentos do Rmarkdown. O mecanismo por trás do site é o [Hugo][],
que transforma em HTML páginas escritas em Markdown (`*.md`). Portanto,
nós escrevemos em Rmarkdown (`*.Rmd*`), o pacote **blogdown** converte
para Markdown (`*md`) e o Hugo converte para HTML.

A primeira coisa a fazer é clonar este repositório com
```bash
git clone https://github.com/pet-estatistica/pet-estatistica.github.io.git
```
ou usando a interface do RStudio.

Depois basta abrir o R neste diretório e rodar
```r
blogdown::serve_site()
```
que uma página irá abrir no seu navegador com o conteúdo do site já
renderizado.

No RStudio, basta clicar no botão "Addins > Serve Site" que o mesmo
acontecerá automaticamente.

### O que alterar

Só altere arquivos quando você realmente souber aonde deve mexer.
Qualquer modificação errada pode quebrar todo o site!

**IMPORTANTE!** NUNCA altere arquivos diretamente da pasta
`themes/hugo-future-imperfect-slim`. Este diretório é onde ficam
armazenados os templates de páginas e demais configurações internas do
site. Se realmente for necessário alterar algum arquivo que está aqui,
então você deve primieiro fazer uma cópio desse arquivo para a raíz do
site, e alterar essa cópia do arquivo. Veja a ordem de execução doa
arquivos nesta [página](https://gohugo.io/templates/lookup-order/).

### Criando posts no blog

Para criar um novo post no blog siga estes passos (supondo que está no
RStudio):

1. Crie um novo branch
2. Clique em "Addins > New Post"
3. Na janela que irá se avrir, preencha as informações sobre seu post
4. Edite o arquivo e salve
5. Faça um push para o GitHub
6. No GitHub, crie um *pull request* e marque alguém para revisar o post

Depois de finalizadas estas etapas, o responsável deverá fazer o *merge*
do post no ramo principal.

### Editando páginas estáticas

As páginas estáticas podem ser editadas diretamente em `content`. Por
exemplo, para editar a página "Integrantes", abra e edite o arquivo
`content/integrantes/index.md`.

Se as alterações forem grandes, crie um *branch* e faça um *pull
request* (similar ao processo de criação de posts).

## Publicando o site

O site está configurado para ser publicado automaticamente quando
qualquer *push* for dado para o repositório (no ramo *master*), por meio
do [Netlify][]. O arquivo `netlify.toml` já possui as informações
necessárias para gerar o site.

O *custom domain* `pet.leg.ufpr.br` foi configurado no Netlify e as
entradas apropriadas foram inseridas no DNS do servidor do LEG.

## Criação do site

O site foi criado usando a plataforma [Hugo][] com o tema [Hugo Future
Imperfect Slim][], com os seguintes comandos

```bash
hugo new site pet-estatistica.github.io
```

Inicialmente, o tema foi inserido como um submódulo

```bash
cd themes
git submodule add https://github.com/pacollins/hugo-future-imperfect-slim.git
cd ..
## Copia o template de exemplo do site
cp -av themes/hugo-future-imperfect-slim/exampleSite/* .
```

Depois de algum tempo de uso, resolve-se remover o tema do submódulo,
uma vez que cada pessoa que fosse clonar o repositórioteria que
manualmente iniciar o submódulo (e não tem uma forma automática de fazer
isso, e nem tem como fazer na interface do RStudio). Dessa forma, o
diretório `themes/hugo-future-imperfect-slim` passoua fazer parte do
repositório principal.

## Configuração do site

A configuração incial seguiu o que está no arquivo `config.toml`.
Algumas modificações importantes estão descritas abaixo

### `baseurl = "http://pet.leg.ufpr.br/"`

A `baseurl` deve ser a página inicial onde o site ficará hospedado. Para
informações de configuração do servidor, veja abaixo.

### `DefaultContentLanguage = "pt"`

O tema utilizado suporta um site multi-línguas, por isso ele veio com
diversas línguas habilitadas. O `DefaultContentLanguage` e o
`disableLanguages` serviram para manter apenas o português.

No `config.toml` também haviam seções específicas com os termos do menu
superior para cada língua. Tudo isso foi apagado, e manteve-se somente o
padrão.

### `publishDir = "docs"`

`publishDir = "docs"` significa que o site será gerado no diretório
`docs`, e não no `public` (que é o padrão). Isso foi feito para ficar
mais compatível com hospedagens no GithUb.

### `[params.meta]` > `favicon`

Para incluir um favicon, foi criado um diretório `static/favicon` com
todos os arquivos gerados pelo site https://realfavicongenerator.net/.

### `[params.sidebar]`

Aqui não foi feita nenhuma modificação direta, mas o botão "Saiba mais"
aparecia como "Aprenda mais". Estas traduções estão no arquivo
`i18n/pt.toml`, e este termo foi modificado lá.

NOTE que o diretório `i18n` originalmente está em
`themes/hugo-future-imperfect-slim/i18n`. Este diretório foi **copiado**
integralmente para a raíz e as modificações feitas aqui. NUNCA altere
arquivos diretamente em `themes/hugo-future-imperfect-slim`.

### `[[menu.main]]`

As entradas `name`, `identifier` e `url` foram traduzidas.

No caso de uma página já existente, como `about` por exemplo, foi
necessário copiar `content/about/index.md` para
`content/sobre/index.md`, para que o caminho ficasse em português.

Páginas novas foram criadas com `layout = "about"` por ser mais simples.
Por exemplo, `content/integrantes/index.md` foi criada do zero.

A página de contato `content/contato/index.md` teve que ser modificada
internamente para poder exibir o Google Maps. Isso foi feito copiando-se
o arquivo
`themes/hugo-future-imperfect-slim/layouts/_default/contact.html` para
`layouts/_default/contact.html` (lembre-se que nunca deve-se editar
arquivos diretamente em `themes/`). Esse arquivo foi então editado para
incluir um `iframe` com o mapa. Por isso, o arquivo
`content/contato/index.md` possui `layout = "contact"` para usar esse
template.

## Configurações extras

### Mathjax

Para que o tema renderize equações em LaTeX, foi necessário criar o
arquivo `layouts/partials/mathjax.html` com o conteúdo

```html
<script src="//yihui.name/js/math-code.js"></script>
<script async
        src="//cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
```

Depois, copiei
`themes/hugo-future-imperfect-slim/layouts/partial/head.html` para
`layouts/partials/head.html` (lembre-se que nunca deve-se editar
arquivos diretamente em `themes/`) e somente adicionei a seguinte linha
(no começo do arquivo)

```html
...
{{ partial "mathjax.html" . }}
...
```

Veja também https://bookdown.org/yihui/blogdown/templates.html.

## Links e referências

### Configurações

- [Hugo Future Imperfect Slim wiki][]
- [Configure Hugo][]: configurações básicas
- [Hugo's Lookup Order][]: importante para saber o que é executado
  primeiro
- [Hugo Shortcodes][]: maneiras de incluir *snippets* de código, como
  vídeos do Youtube, tweets, etc
- [Multilingual Mode][]: sobre páginas multi-línguas
- [Image Processing][]: processamento de figuras

### Tutoriais

- [A Blogdown New Post Workflow with Github and Netlify][]
- [Fun blogdown in R to design a personal website][]
- [Blogdown Tutorial (in Portuguese)][]
- [How to build a website with Blogdown in R][]
- [How Not To Knit All Rmd Files With Blogdown][]

[How Not To Knit All Rmd Files With Blogdown]: https://yutani.rbind.io/post/2017-10-25-blogdown-custom/
[How to build a website with Blogdown in R]: https://www.storybench.org/how-to-build-a-website-with-blogdown-in-r/
[Blogdown Tutorial (in Portuguese)]: https://diegopftrindade.netlify.app/post/blogdown-tutorial-in-portuguese/
[Fun blogdown in R to design a personal website]: https://annielyu.com/2020/01/12/blogdown-website/
[A Blogdown New Post Workflow with Github and Netlify]: https://www.garrickadenbuie.com/blog/blogdown-netlify-new-post-workflow/
[blogdown]: https://bookdown.org/yihui/blogdown/
[Hugo]: https://gohugo.io/
[Netlify]: https://www.netlify.com/
[Hugo Future Imperfect Slim]: https://themes.gohugo.io/hugo-future-imperfect-slim/
[Hugo Future Imperfect Slim wiki]: https://github.com/pacollins/hugo-future-imperfect-slim/wiki
[Hugo's Lookup Order]: https://gohugo.io/templates/lookup-order/
[Hugo Shortcodes]: https://gohugo.io/content-management/shortcodes/
[Configure Hugo]: https://gohugo.io/getting-started/configuration/#all-configuration-settings
[Multilingual Mode]: https://gohugo.io/content-management/multilingual/
[Image Processing]: https://gohugo.io/content-management/image-processing/#image-processing-config
