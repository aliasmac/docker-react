# Everything from this line is part of the builder phase - obj to isntall deps and build app
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
# Copy from current source to app
COPY . . 
RUN npm run build

# Second FROM statement says prev block complete start next phase, each block can only have one FROM   
FROM nginx 
# I want to copy from builder phase '/app/buid' to location specific to nginx
COPY --from=builder /app/build /usr/share/nginx/html 
#d efault CMD for nginx starts it up for us