module.exports = {
  apps: [
    {
      name: "meteor-app",
      script: "main.js",
      cwd: "/home/alite-148/Task/build/bundle",
      env: {
        PORT: 5000,
        ROOT_URL: "http://localhost:5000",
        MONGO_URL: "mongodb://localhost:27017/meteor"
      }
    }
  ]
};
