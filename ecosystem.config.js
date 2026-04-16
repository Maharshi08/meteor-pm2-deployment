const fs = require("fs");
const path = require("path");

const settingsPath = path.join(__dirname, "config", "settings.production.json");
const meteorSettings = fs.readFileSync(settingsPath, "utf-8");

module.exports = {
  apps: [
    {
      name: "meteor-prod",
      script: "main.js",
      cwd: "/home/alite-148/Task/build/bundle",

      // Cluster mode
      exec_mode: "cluster",
      instances: "max",        // uses all CPU cores automatically

      env_production: {
        NODE_ENV: "production",
        PORT: 50001,
        ROOT_URL: "http://localhost:50001",
        MONGO_URL: "mongodb://localhost:27017/meteor",
        METEOR_SETTINGS: meteorSettings
      }
    }
  ]
};