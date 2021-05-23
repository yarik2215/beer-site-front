FROM node:lts-alpine as build

# делаем каталог 'app' текущим рабочим каталогом
WORKDIR /client
# копируем оба 'package.json' и 'package-lock.json' (если есть)
COPY package*.json ./
# устанавливаем зависимости проекта
RUN npm install
# копируем файлы и каталоги проекта в текущий рабочий каталог (т.е. в каталог 'app')
COPY . .
# собираем приложение для production с минификацией
RUN npm run build


# этап develop
FROM build as develop
EXPOSE 8080
CMD [ "npm", "run", "serve"]


# этап production (production-stage)
FROM nginx:stable-alpine as production
COPY --from=build /client/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]