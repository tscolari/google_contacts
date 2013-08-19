README
=======

Simpel app to test rails and google contacts integration.

Requirements
-------

* Ruby version: 2.0.0
* Database: PostgreSQL

Instalation
----------

```shell
bundle install
rake db:create
rake db:migrate
export GOOGLE_KEY=ZZZZZ
export GOOGLE_SECRET=YYYYYY
rails s
```

Then point your browser to: http://localhost:3000/contacts


How to run the test suite:
----------
```shell
  bundle exec rspec spec
```
