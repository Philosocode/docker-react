FROM node:alpine AS builder

WORKDIR "/app"

# Copy package.json -> container/app
COPY package.json .
RUN npm install
COPY . .

# Move files into /app/build
RUN npm run build

# Starting another block
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html