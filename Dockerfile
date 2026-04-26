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

# Healthcheck compatible BusyBox (wget --spider est buggy dans nginx:alpine).
# Coolify exige une cle .State.Health pour son rolling update, donc on definit
# un check minimal qui telecharge la page de pre-inscription (200 = OK).
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD wget -q -O /dev/null http://localhost/preformation.html || exit 1

EXPOSE 80
