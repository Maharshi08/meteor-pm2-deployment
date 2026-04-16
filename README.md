# Meteor App

A modern full-stack web application built with **Meteor**, **React 18**, and **Rspack**. This project demonstrates a complete Meteor application with server-side and client-side code, MongoDB integration, and production-ready deployment configuration.


## Prerequisites

- **Node.js** v18 or higher
- **Meteor** - Install from [meteor.com](https://www.meteor.com/install)
- **MongoDB** - Install from [mongodb.com](https://www.mongodb.com/try/download/community) or use a MongoDB Atlas instance
- **npm** or **yarn** - Node package manager

## Installation

1. **Clone or navigate to the project directory:**
   ```bash
   cd meteor-app
   ```

2. **Install dependencies:**
   ```bash
   meteor npm install
   ```

3. **Ensure MongoDB is running:**
   ```bash
   mongod
   ```

## Development

### Start the development server:

```bash
npm start
```

This will start the Meteor development server, typically accessible at `http://localhost:3000`.

The development environment includes:
- Hot module reloading for instant updates
- Full source maps for debugging
- Development MongoDB instance

### Project Structure

```
meteor-app/
├── client/                 # Client-side entry point and styles
│   ├── main.jsx           # React root component
│   ├── main.html          # HTML template
│   └── main.css           # Global styles
├── imports/               # Shared code (client & server)
│   ├── api/               # Database collections and methods
│   │   └── links.js       # Links collection definition
│   └── ui/                # React components
│       ├── App.jsx        # Main app component
│       ├── Counter.jsx    # Counter component
│       ├── Header.jsx     # Header component
│       ├── Info.jsx       # Info component
│       └── styles.css     # Component styles
├── server/                # Server-side only code
│   └── main.js            # Server startup logic
├── tests/                 # Test files
│   └── main.js            # Test configuration
├── config/                # Configuration files
│   ├── settings.development.json
│   └── settings.production.json
├── private/               # Private files (not bundled)
├── public/                # Public files (served as-is)
├── scripts/               # Utility scripts
│   ├── dev.sh             # Development script
│   └── deploy-prod.sh     # Production deployment script
├── _build/                # Build outputs (dev/prod/test)
├── rspack.config.js       # Rspack bundler configuration
├── ecosystem.config.js    # PM2 production configuration
└── package.json           # Dependencies and scripts
```

## Available Scripts

```bash
# Start development server
npm start

# Run tests once
npm test

# Run tests in watch mode (full app)
npm run test-app

# Visualize bundle size (production mode)
npm run visualize
```

## Testing

The project uses **Mocha** with Meteor's testing driver.

### Run tests once:
```bash
npm test
```

### Run tests in watch mode:
```bash
npm run test-app
```

Test files should be located in the `tests/` directory.

## Building for Production

### Create a production build:

```bash
meteor build ../build --directory
```

This generates an optimized bundle ready for deployment.

### Visualize bundle size:

```bash
npm run visualize
```

This helps you understand and optimize bundle size for production.

## Production Deployment

This project includes a **PM2 ecosystem configuration** for production deployment with clustering.

### Configuration Details

The production setup is defined in `ecosystem.config.js`:
- **Cluster mode**: Uses all available CPU cores for better performance
- **Port**: 50001
- **Database**: MongoDB at `mongodb://localhost:27017/meteor`
- **Environment**: Node.js production environment

### Deploy with PM2:

```bash
# Install PM2 globally
npm install -g pm2

# Start the application with PM2
pm2 start ecosystem.config.js --env production

# Monitor the application
pm2 monit

# View logs
pm2 logs
```

### Production settings

Update `config/settings.production.json` with your production environment variables before deployment.

## Environment Configuration

### Development Settings
- File: `config/settings.development.json`
- Used automatically when running `npm start`

### Production Settings
- File: `config/settings.production.json`
- Used when PM2 deploys the app

Edit these files to configure your application's environment-specific settings.

## Database

The application uses **MongoDB** for data persistence. The default connection string is:

- Development: `mongodb://localhost:27017/meteor`
- Production: Configured in `ecosystem.config.js`

### Data Collections

- **Links**: Stores links with title, URL, and creation timestamp

## Technologies Used

- **Meteor** - Full-stack JavaScript framework
- **React 18** - UI library
- **Rspack** - Fast JavaScript bundler
- **MongoDB** - NoSQL database
- **Mocha** - Testing framework
- **PM2** - Process manager for production
- **Babel/SWC** - JavaScript transpilation

## Troubleshooting

### MongoDB connection fails
- Ensure MongoDB is running: `mongod`
- Check the `MONGO_URL` environment variable

### Port already in use
- Change the default port in `ecosystem.config.js` or use: `PORT=3001 meteor run`

### Build errors
- Clear Meteor's cache: `meteor reset`
- Reinstall dependencies: `meteor npm install`

## Scripts Directory

- `dev.sh` - Development helper script
- `deploy-prod.sh` - Production deployment helper script

Run these scripts with: `bash scripts/dev.sh` or `bash scripts/deploy-prod.sh`

