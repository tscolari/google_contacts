# Be sure to restart your server when you modify this file.

# GoogleAgenda::Application.config.session_store :cookie_store, key: '_google_agenda_session'
GoogleAgenda::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes
