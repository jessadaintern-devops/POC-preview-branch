    # Stage 1: Build the Angular application
    FROM node:22-alpine as build
    WORKDIR /app
    COPY package.json package-lock.json ./
    RUN npm install
    COPY . .
    RUN npm run build -- --configuration production

    # Stage 2: Serve the static files with a lightweight web server (e.g., Nginx)
    FROM nginx:stable-alpine
    COPY --from=build /app/dist/preview-branch/browser /usr/share/nginx/html
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]