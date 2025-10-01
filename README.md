# Redshift Database ERD

Interactive Entity Relationship Diagram for the Redshift Database Schema.

## Quick Start

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start the development server:**
   ```bash
   npm run dev
   ```

3. **Open your browser:**
   - The application will automatically open at `http://localhost:5173`
   - Or manually navigate to the URL shown in the terminal

## Features

- **Interactive Diagram**: Click on tables to expand and see all key fields
- **Zoom Controls**: Zoom in/out to focus on different areas
- **Color-coded Groups**: Tables organized by function (Customer, Contact, Transactions, etc.)
- **Key Field Display**: Primary and foreign keys clearly marked
- **Relationship Lines**: Visual connections between related tables

## Project Structure

```
redshift-erd/
├── src/
│   ├── App.jsx          # Main ERD component
│   ├── main.jsx         # Application entry point
│   └── index.css        # Global styles
├── index.html           # HTML template
├── package.json         # Dependencies and scripts
└── vite.config.js       # Vite configuration
```

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build

## Technologies

- React 18
- Vite (build tool)
- SVG for diagram rendering

## Database Schema Groups

- **Customer & Household** - Core customer data tables
- **Contact Information** - Email and phone contact tables
- **Transactions** - Purchase and payment tables
- **Marketing & Promotions** - Campaign and email activity tables
- **Reference Tables** - Lookup, calendar, store, and product tables
- **Analytics & Clickstream** - Web analytics data
- **Salesforce (SFMC)** - Marketing cloud integration tables
