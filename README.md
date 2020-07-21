# pet-estatistica.github.io

[![Netlify Status](https://api.netlify.com/api/v1/badges/02ea8d59-deed-4afb-943e-fc1c475f9f35/deploy-status)](https://app.netlify.com/sites/pet-est/deploys)

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

- [Hugo Future Imperfect Slim wiki][]
- [Configure Hugo][]: configurações básicas
- [Hugo's Lookup Order][]: importante para saber o que é executado
  primeiro
- [Hugo Shortcodes][]: maneiras de incluir *snippets* de código, como
  vídeos do Youtube, tweets, etc
- [Multilingual Mode][]: sobre páginas multi-línguas
- [Image Processing][]: processamento de figuras

[Hugo]: https://gohugo.io/
[Hugo Future Imperfect Slim]: https://themes.gohugo.io/hugo-future-imperfect-slim/
[Hugo Future Imperfect Slim wiki]: https://github.com/pacollins/hugo-future-imperfect-slim/wiki
[Hugo's Lookup Order]: https://gohugo.io/templates/lookup-order/
[Hugo Shortcodes]: https://gohugo.io/content-management/shortcodes/
[Configure Hugo]: https://gohugo.io/getting-started/configuration/#all-configuration-settings
[Multilingual Mode]: https://gohugo.io/content-management/multilingual/
[Image Processing]: https://gohugo.io/content-management/image-processing/#image-processing-config
