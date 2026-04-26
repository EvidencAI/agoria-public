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

# Healthcheck simple
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/preformation.html || exit 1

EXPOSE 80
