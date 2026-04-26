# AgorIA — pages publiques (preformation, quiz-email, questionnaire, followup)
# Servies par nginx, parlent directement a https://supabase.evidencai.com
FROM nginx:1.27-alpine

# Conf nginx personnalisee pour gerer les rewrites de Vercel
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Pages HTML + assets
COPY preformation.html /usr/share/nginx/html/
COPY quiz-email.html /usr/share/nginx/html/
COPY questionnaire.html /usr/share/nginx/html/
COPY followup.html /usr/share/nginx/html/
COPY quizzes_email.json /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets

# Pas de HEALTHCHECK Docker : Coolify gere via Traefik (external HTTP check)
# Le wget BusyBox de nginx:alpine ne supporte pas tous les flags ce qui faisait
# echouer le healthcheck malgre nginx fonctionnel.

EXPOSE 80
