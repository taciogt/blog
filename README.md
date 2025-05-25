# Software Engineering

This repository contains a Hugo-powered blog focused on software engineering topics. The site is automatically deployed to GitHub Pages when changes are pushed to the main branch.

## Development Setup

### Prerequisites

- [Homebrew](https://brew.sh/) (for macOS users)
- Git

### Local Setup

```shell
# Install dependencies and set up the environment
make setup
```

This command will install Hugo using Homebrew and set up your local environment.

### Running Locally

```shell
# Start the Hugo development server with draft posts enabled
make run
```

The site will be available at http://localhost:1313/software-engineering/

## Build and Deployment

### Local Build

```shell
# Build the site locally with production settings
make ci/build
```

### Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the main branch using GitHub Actions. The deployment workflow:

1. Builds the site using Hugo with garbage collection and minification
2. Deploys the built site to GitHub Pages

## Project Structure

- `software-engineering/` - Main Hugo project directory
  - `content/` - Blog content (Markdown files)
    - `posts/` - Blog posts
  - `themes/ananke/` - The Ananke theme
  - `hugo.toml` - Hugo configuration file

## Content Creation

### Creating New Posts

Posts should be created in the `software-engineering/content/posts/` directory with the following front matter format:

```
+++
date = 'YYYY-MM-DDThh:mm:ss-03:00'
draft = false
title = 'Post Title'
+++

Content in Markdown format
```

## Additional Information

- The site uses the [Ananke theme](https://github.com/theNewDynamic/gohugo-theme-ananke)
- Hugo extended version is used for the build process
- Base URL: https://taciogt.github.io/software-engineering/
