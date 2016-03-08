# Slack To Esa

前日分の特定のSlackチャンネルの履歴（最大1000件）を、esaに保存します

# Setup

## Bundler

```
$ bundle install
```

## Config

- `.env.sample` を参考に、適宜値を入れてください

```
$ cp .env.sample .env
```

# Usage

```
$ bundle exec ruby slack_to_esa.rb
```