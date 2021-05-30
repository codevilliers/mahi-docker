import os

bind = '0.0.0.0:8000'

reload = True

accesslog = f'/web_server_logs/gunicorn_logs/prod-access.log'
errorlog = f'/web_server_logs/gunicorn_logs/prod-error.log'
