# NutriHub

Assistente de nutrição com IA (Flutter, Material 3) — planeja refeições, adapta o dia,
gera receitas e escaneia rótulos/código de barras, tudo com o mínimo de esforço manual do
usuário.

## Estado atual

Projeto em estágio inicial: só existem splash nativa (Android/iOS) e a tela de Login
(Google Sign-In ainda não integrado, é um `TODO`). O tema (claro/escuro) já está
implementado e segue o sistema operacional.

## Estrutura do projeto

```
lib/
  main.dart
  app/                          → configuração global do app
    app.dart                    → widget raiz (MaterialApp, tema, rotas)
    routes/app_routes.dart      → nomes de rota centralizados
    theme/                      → design tokens (cores, tipografia, espaçamento, ThemeData)
  core/                         → código compartilhado entre features
    widgets/                    → widgets reutilizáveis (App*: AppButton, AppScaffold, AppLogo...)
  features/                     → uma pasta por funcionalidade do produto
    auth/
      presentation/
        login/
          login_screen.dart
          widgets/              → widgets que só essa tela usa
```

- **`app/`** — tudo que é transversal ao app inteiro: tema, rotas, o widget raiz. Nunca
  tem lógica de uma feature específica.
- **`core/`** — código genérico reaproveitável entre features (widgets, e futuramente
  networking, error handling, utils — ver seção "Expandindo o `core/`" abaixo).
- **`features/`** — cada funcionalidade do produto isolada na própria pasta (`auth`,
  futuramente `diary`, `recipes`, `profile`, `chat`...).

Convenção de nomes: widgets compartilhados em `core/widgets/` usam prefixo `App*`
(`AppButton`, `AppScaffold`, `AppLogo`, `AppDivider`). Widgets específicos de uma tela
ficam dentro da própria feature, sem prefixo (`LoginSocialButton`, `LoginFooter`).

## Arquitetura alvo: feature-first + Clean Architecture enxuta

O objetivo é evoluir cada feature para três camadas, com uma regra de dependência
única: **`presentation` → `domain` ← `data`**. `domain` é Dart puro — nunca importa
Flutter, HTTP client ou nada de `data`. Isso é o que permite trocar a fonte de dados
(ex.: mockar em teste) sem tocar na tela.

```
features/auth/
  presentation/     → telas, widgets, state (única camada que existe hoje)
  domain/           → entidades + contratos (interfaces)
    entities/
    repositories/         (abstract class AuthRepository)
  data/             → implementação real — API, storage, mapeamento
    datasources/
    models/                (DTOs, com fromJson/toJson)
    repositories/          (AuthRepositoryImpl)
```

**Decisão deliberada: sem camada de `usecases/`.** Numa Clean Architecture "de livro"
cada ação teria uma classe `XyzUseCase`. Para o tamanho atual do app, isso costuma virar
boilerplate que só chama `repository.algo()` sem agregar lógica nenhuma. Só introduzir
`usecases/` quando uma operação combinar múltiplos repositórios ou tiver regra de
negócio real que não é responsabilidade nem da UI nem do repository.

### Gerenciamento de estado — recomendação: Riverpod

Hoje tudo é `StatefulWidget`/`setState`. Conforme entrarem fluxos assíncronos (login,
plano de refeições, chat com IA, câmera), a recomendação é **Riverpod**:

- Resolve state management **e** injeção de dependência ao mesmo tempo (providers) —
  não precisa de `get_it` separado.
- `AsyncValue` mapeia bem em loading/erro/sucesso, que é o padrão que login/onboarding/
  diary vão precisar.
- Testável sem depender de `BuildContext`.

Alternativa considerada: **Bloc** — mais boilerplate, porém um padrão mais rígido e
previsível, mais comum em times maiores. Não escolhido por ora pelo custo/benefício num
time pequeno.

### Expandindo o `core/`

Quando a integração com API real começar, `core/` provavelmente vai precisar de:

```
core/
  widgets/        (já existe)
  network/        → cliente HTTP (dio), interceptors
  error/          → Failure/Exception types compartilhados
  utils/          → formatters, validators
```

### Roteamento

`Navigator` com rotas nomeadas (`app/routes/app_routes.dart`) é suficiente para as duas
telas atuais. Quando entrar onboarding + bottom nav com múltiplas abas (Home/Diary/Chat/
Recipes/Profile), vale migrar para **go_router** — deep links, rotas aninhadas e guards
de autenticação ficam mais simples de expressar.

## Ordem de migração sugerida

Não migrar tudo de uma vez — introduzir `domain/`/`data/` feature por feature, no
momento em que cada uma passar a precisar de verdade:

1. Quando o Google Sign-In for implementado de fato (hoje é só um `TODO` em
   `login_screen.dart`), essa é a deixa natural para a feature `auth` ganhar `domain/` e
   `data/` completos.
2. Riverpod entra nesse mesmo momento — sem ele fica difícil expressar loading/erro do
   login só com `setState`.
3. `core/network` e `core/error` nascem junto, quando o primeiro `AuthRepositoryImpl`
   precisar de fato chamar uma API.

## Design system

O app segue o design system "NutriHub" (Jungle `#1A4731` + Cream Soda `#FFF4CC` como
cores de marca). Tokens de cor/tipografia/espaçamento já portados 1:1 em
`lib/app/theme/`. Splash nativa e ícone do app gerados via `flutter_native_splash` e
`flutter_launcher_icons` a partir dos assets em `assets/splash/` e `assets/icon/`.

## Getting Started

Projeto Flutter padrão. Para rodar:

```
flutter pub get
flutter run
```
