# Deploy LLM Frontend

A modern React application built with TypeScript, Vite, and HeroUI for deploying and managing large language models.

## Tech Stack

- **React 19** with TypeScript for the frontend framework
- **Vite** for fast development and building
- **HeroUI** for beautiful, accessible UI components
- **Tailwind CSS 4** for utility-first styling
- **Wouter** for lightweight client-side routing
- **Framer Motion** for smooth animations
- **ESLint + Prettier** for code quality and formatting

## Project Structure

```
src/
├── App.tsx          # Main app component with HeroUI provider
├── Home.tsx         # Home page component
├── hero.ts          # HeroUI configuration
├── main.tsx         # App entry point
├── index.css        # Global styles with Tailwind imports
└── assets/          # Static assets
```

## Getting Started

### Prerequisites

- Node.js (version 18 or higher recommended)
- npm, yarn, or bun

### Installation

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint
```

## Development

The app uses:
- **HeroUI components** - Pre-built accessible UI components (see [`Home.tsx`](src/Home.tsx))
- **Tailwind CSS** - Configured via [`vite.config.ts`](vite.config.ts) with the new Vite plugin
- **TypeScript** - Strict type checking enabled across the project
- **ESLint + Prettier** - Automated code formatting and linting

### Key Configuration Files

- [`vite.config.ts`](vite.config.ts) - Vite configuration with React and Tailwind plugins
- [`hero.ts`](src/hero.ts) - HeroUI theme configuration
- [`eslint.config.js`](eslint.config.js) - ESLint configuration with React and TypeScript rules
- [`tsconfig.json`](tsconfig.json) - TypeScript project references setup

## Styling

This project uses Tailwind CSS 4 with HeroUI components. Global styles are defined in [`src/index.css`](src/index.css) with Tailwind imports and HeroUI theme integration.

## Routing

Client-side routing is handled by Wouter, a lightweight alternative to React Router (currently imported but not yet implemented in [`App.tsx`](src/App.tsx)).

## Building

The build process runs TypeScript compilation followed by Vite bundling:

```bash
npm run build
```

This generates optimized static files in the `dist` directory ready for deployment.

# React + TypeScript + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

## Expanding the ESLint configuration

If you are developing a production application, we recommend updating the configuration to enable type-aware lint rules:

```js
export default tseslint.config([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...

      // Remove tseslint.configs.recommended and replace with this
      ...tseslint.configs.recommendedTypeChecked,
      // Alternatively, use this for stricter rules
      ...tseslint.configs.strictTypeChecked,
      // Optionally, add this for stylistic rules
      ...tseslint.configs.stylisticTypeChecked,

      // Other configs...
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```

You can also install [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) and [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) for React-specific lint rules:

```js
// eslint.config.js
import reactX from 'eslint-plugin-react-x'
import reactDom from 'eslint-plugin-react-dom'

export default tseslint.config([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...
      // Enable lint rules for React
      reactX.configs['recommended-typescript'],
      // Enable lint rules for React DOM
      reactDom.configs.recommended,
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```
