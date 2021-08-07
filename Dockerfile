# syntax=docker/dockerfile:1

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# https://docs.docker.com/develop/develop-images/multistage-build/

FROM node:12.18.1
ENV NODE_ENV=production

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --production

COPY . .

CMD [ "npm", "start" ]
