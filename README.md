# URL SHORTENER

Projeto criado como complemento ao post **"[Aplicações mais performáticas com DBLess Architecture](http://blog.renanmacs.com/aplicacoes-mais-performaticas-com-dbless-architecture)"**.

Com ele, é possível ver de forma prática, como conseguimos utilizar um Banco de Dados como o Redis como o Banco de dados principal de uma aplicação web.

Para isso, temos uma API simples responsável por gerenciar links encurtados :)

## Instruções

Para rodar o projeto basta executar:

```bash
docker-compose up
```

Com isso, subiremos a aplicação e também um conteiner com o Redis.

## Rotas

Abaixo você pode visualizar as rotas disponíveis na API e uma breve descrição sobre cada uma:

|METHOD | PATH                | OBS                                                                        |
|-------|---------------------|----------------------------------------------------------------------------|
|GET	  | /	                  | Lista todos os links cadastrados                                           |
|POST	  | /links	            | Cadastra um novo Link body: `{ slug: string, url: string, user_id: integer }`|
|GET	  | /links/search/:slug | Busca um link correspondente ao slug informado                             |
|POST	  | /users	            | Cadastra um novo usuário body: `{ name: string }`                            |
|POST	  | /seed	              | Rota de teste, adiciona 1 mil links para cada usuário cadastrado           |
