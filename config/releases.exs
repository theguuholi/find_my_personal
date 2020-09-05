import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :find_my_personal, FindMyPersonal.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

config :find_my_personal, FindMyPersonal.Mail.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SERVER_HOST_MAIL"),
  hostname: System.get_env("SERVER_HOST_MAIL"),
  port: System.get_env("PORT_MAIL"),
  username: System.get_env("USER_NAME_MAIL"),
  password: System.get_env("PASSWORD_MAIL"),
  tls: :if_available,
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  ssl: false,
  retries: 1,
  no_mx_lookups: false,
  auth: :cram_md5

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :find_my_personal, FindMyPersonalWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

config :find_my_personal, FindMyPersonalWeb.Endpoint, server: true
#
