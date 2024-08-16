#/bin/sh

sed -i "s#https://s.ops.ci#https://${MYURLS_DOMAIN}#g" /app/public/index.html

exec /app/myurls -domain "${MYURLS_DOMAIN}" -conn "${REDIS_IP}":"${REDIS_PORT}" -password "${REDIS_PASSWORD}"
