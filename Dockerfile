FROM  node:16-alpine as builder

WORKDIR /app
ENV NODE_ENV production
# ARG NPM_TOKEN
# ENV HUSKY=0

COPY yarn.lock package.json ./
# COPY .npmrc.docker .npmrc

RUN set -xeu && \
  yarn install \
  --prefer-offline \
  --frozen-lockfile \
  --non-interactive \
  --production=false \
  --ignore-scripts

COPY . .

RUN yarn build

RUN rm -rf node_modules && \
  NODE_ENV=production yarn install \
  --prefer-offline \
  --pure-lockfile \
  --non-interactive \
  --production=true \
  --ignore-scripts

FROM nginx:alpine
# LABEL org.opencontainers.image.authors="Pre-history Team"
# LABEL org.opencontainers.image.description="Farema Frontend"
# LABEL org.opencontainers.image.source="https://github.com/pre-history/farema-front"

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
WORKDIR /usr/share/nginx/html