FROM node:12
WORKDIR /usr/src/app
COPY package.json app.js /usr/src/app/
COPY lib /usr/src/app/lib/
COPY tests tests

ENV NODE_ENV production

RUN npm update && \
    npm install -g mocha && \
    npm install supertest --save-dev && \
    npm install mocha-sonarqube-reporter --save-dev

CMD ["node", "app.js", "mocha", "tests/test.js", "--reporter", "spec", "supertest", "mocha-sonarqube-reporter", "--reporter-options", "output=coverage/test_results.xml"]
