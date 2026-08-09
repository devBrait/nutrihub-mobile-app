# NutriHub

Assistente de nutrição com IA (Flutter, Material 3) — planeja refeições, adapta o dia,
gera receitas e escaneia rótulos/código de barras, tudo com o mínimo de esforço manual do
usuário.

## Estado atual

Splash nativa (Android/iOS) e tema (claro/escuro, seguindo o sistema operacional) já
implementados. Login com Google via **Supabase Auth** (fluxo OAuth via navegador) está
funcionando de ponta a ponta. A feature `auth` já tem as três camadas completas
(`presentation`/`domain`/`data`) e o app já usa **Riverpod** para gerenciar estado e
injeção de dependência. Existe uma `HomeScreen` placeholder só para validar o fluxo
pós-login — o fluxo de onboarding real (decidir se o usuário precisa completá-lo após o
login) ainda é um `TODO`.

## Estrutura do projeto

```
lib/
  main.dart                        → carrega .env, inicializa Supabase e o ProviderScope
  app/                              → configuração global do app
    app.dart                       → widget raiz (MaterialApp, tema, rotas) + AuthGate
    routes/app_routes.dart         → nomes de rota centralizados
    theme/                         → design tokens (cores, tipografia, espaçamento, ThemeData)
  core/                             → código compartilhado entre features
    widgets/                       → widgets reutilizáveis (App*: AppButton, AppScaffold, AppLogo...)
  features/                        → uma pasta por funcionalidade do produto
    auth/
      presentation/
        login/
          login_screen.dart
          widgets/                 → widgets que só essa tela usa
        providers/
          auth_providers.dart      → providers Riverpod (repository, authState, sign-in)
      domain/
        entities/
          app_user.dart
        repositories/
          auth_repository.dart     (abstract class AuthRepository)
      data/
        datasources/
          auth_remote_datasource.dart   → wrapper fino sobre supabase_flutter
        repositories/
          auth_repository_impl.dart
    home/
      presentation/
        home_screen.dart           → placeholder pós-login
```

- **`app/`** — tudo que é transversal ao app inteiro: tema, rotas, o widget raiz (inclui o
  `AuthGate`, que decide entre `LoginScreen`/`HomeScreen` observando o estado de
  autenticação). Nunca tem lógica de uma feature específica.
- **`core/`** — código genérico reaproveitável entre features (widgets, e futuramente
  networking, error handling, utils — ver seção "Expandindo o `core/`" abaixo).
- **`features/`** — cada funcionalidade do produto isolada na própria pasta (`auth`,
  `home`, futuramente `diary`, `recipes`, `profile`, `chat`...).

Convenção de nomes: widgets compartilhados em `core/widgets/` usam prefixo `App*`
(`AppButton`, `AppScaffold`, `AppLogo`, `AppDivider`). Widgets específicos de uma tela
ficam dentro da própria feature, sem prefixo (`LoginSocialButton`, `LoginFooter`).

## Arquitetura: feature-first + Clean Architecture enxuta

Cada feature evolui para três camadas, com uma regra de dependência única:
**`presentation` → `domain` ← `data`**. `domain` é Dart puro — nunca importa Flutter,
HTTP client ou nada de `data`. Isso é o que permite trocar a fonte de dados (ex.: mockar
em teste, ou trocar Supabase por outro provedor) sem tocar na tela.

```
features/auth/
  presentation/     → telas, widgets, providers Riverpod
  domain/           → entidades + contratos (interfaces)
    entities/           (AppUser)
    repositories/        (abstract class AuthRepository)
  data/             → implementação real — Supabase, mapeamento
    datasources/          (AuthRemoteDataSource, fala direto com supabase_flutter)
    repositories/          (AuthRepositoryImpl, mapeia User do Supabase → AppUser)
```

`auth` é a primeira feature a seguir esse modelo por completo — serve de referência para
as próximas (`home`, `diary`, `recipes`...) quando elas precisarem de fato de uma fonte de
dados real.

**Decisão deliberada: sem camada de `usecases/`.** Numa Clean Architecture "de livro"
cada ação teria uma classe `XyzUseCase`. Para o tamanho atual do app, isso costuma virar
boilerplate que só chama `repository.algo()` sem agregar lógica nenhuma. Só introduzir
`usecases/` quando uma operação combinar múltiplos repositórios ou tiver regra de
negócio real que não é responsabilidade nem da UI nem do repository.

### Gerenciamento de estado: Riverpod

Adotado junto com a feature `auth` (fluxo assíncrono de login via Supabase):

- Resolve state management **e** injeção de dependência ao mesmo tempo (providers) —
  não precisa de `get_it` separado. Ver `authRepositoryProvider` em
  `features/auth/presentation/providers/auth_providers.dart`.
- `AsyncValue`/`AsyncNotifier` mapeiam bem em loading/erro/sucesso — é o padrão usado no
  `signInWithGoogleProvider` e deve se repetir em onboarding/diary/chat conforme forem
  implementados.
- `authStateProvider` (`StreamProvider<AppUser?>`) expõe o estado de sessão do Supabase
  para qualquer parte do app (hoje consumido pelo `AuthGate`).
- Testável sem depender de `BuildContext`.

Alternativa considerada: **Bloc** — mais boilerplate, porém um padrão mais rígido e
previsível, mais comum em times maiores. Não escolhido por ora pelo custo/benefício num
time pequeno.

### Expandindo o `core/`

Quando a integração com API própria (além do Supabase) começar, `core/` provavelmente vai
precisar de:

```
core/
  widgets/        (já existe)
  network/        → cliente HTTP (dio), interceptors
  error/          → Failure/Exception types compartilhados
  utils/          → formatters, validators
```

### Roteamento e autenticação

`Navigator` com rotas nomeadas (`app/routes/app_routes.dart`) segue em uso, mas a tela
inicial não é mais uma rota fixa: `app/app.dart` define `home: const AuthGate()`, um
widget que observa `authStateProvider` (Riverpod) e decide entre `LoginScreen` e
`HomeScreen` com base no estado de sessão do Supabase — sem usuário logado vai para
`LoginScreen`, com usuário logado vai para `HomeScreen`, e enquanto o estado inicial ainda
não resolveu mostra um loading. Rotas nomeadas continuam existindo para navegação
explícita (ex. `AppRoutes.home`).

Quando entrar onboarding + bottom nav com múltiplas abas (Home/Diary/Chat/Recipes/
Profile), vale migrar para **go_router** — deep links, rotas aninhadas e guards de
autenticação ficam mais simples de expressar do que compondo tudo dentro do `AuthGate`.

## Autenticação — Google Sign-In via Supabase

Fluxo OAuth via navegador (`signInWithOAuth`), não Google Sign-In nativo. Deep link de
retorno: `io.supabase.nutrihub://login-callback/`, registrado em
`android/app/src/main/AndroidManifest.xml` e `ios/Runner/Info.plist`.

Configuração necessária (fora do código, feita uma vez por ambiente):

1. Google Cloud Console: OAuth 2.0 Client ID do tipo *Web application*.
2. Supabase Dashboard → Authentication → Providers → Google: habilitar com o Client
   ID/Secret do passo anterior; em Authentication → URL Configuration, registrar a
   redirect URL acima.
3. Copiar `SUPABASE_URL` e a anon/publishable key (Settings → API) para o `.env` local
   (ver `.env.example`).

## Ordem de migração sugerida

Não migrar tudo de uma vez — introduzir `domain/`/`data/` feature por feature, no
momento em que cada uma passar a precisar de verdade:

1. ~~Quando o Google Sign-In for implementado de fato~~ — feito: a feature `auth` já tem
   `domain/` e `data/` completos.
2. ~~Riverpod entra nesse mesmo momento~~ — feito: adotado junto com o login.
3. `core/network` e `core/error` nascem quando o primeiro repository precisar de fato
   chamar uma API própria (além do Supabase) — ex. quando `home`/`diary` ganharem dados
   reais, ou quando o onboarding precisar consultar/gravar estado do usuário.

## Design system

O app segue o design system "NutriHub" (Jungle `#1A4731` + Cream Soda `#FFF4CC` como
cores de marca). Tokens de cor/tipografia/espaçamento já portados 1:1 em
`lib/app/theme/`. Splash nativa e ícone do app gerados via `flutter_native_splash` e
`flutter_launcher_icons` a partir dos assets em `assets/splash/` e `assets/icon/`.

## Getting Started

Projeto Flutter padrão. Antes de rodar, copie `.env.example` para `.env` e preencha
`SUPABASE_URL`/`SUPABASE_ANON_KEY` com as credenciais do seu projeto Supabase (ver seção
"Autenticação" acima para o setup do provider Google). Para rodar:

```
flutter pub get
flutter run
```
