+++
date = '2025-05-25T19:40:58-03:00'
draft = true
title = 'Makefile Ftw'
+++

# Makefile FTW

## Introduction

Early in my career I met a wise engineer (thanks Tony!) that cared about providing not only a decent README for the project we've worked, 
but also a pretty good CLI to help with everyday tasks. 
It was way before DevEx became a buzzword. We were a small start up with scarce resources, 
not much time to spare with complex onboardings and how to standardize the development process. 

For a young engineer that struggled with almost everything, 
it was enough to imprint in my engineering-related values the importance of making my life easier.
Easier by not having to think all the time about every detail about the job, easier by not having to explain for newcomers stuff that I didn't remember anymore. 
It didn't hurt that the life of my peers became easier as a byproduct and it added a compound effect to the results.

After a few years I joined another company that chose a Makefile to scratch the same itch. 
Since then, I learn a new Makefile feature or trick once in a while and haven't started a project without it anymore.
These are the Whys and Hows to use this tool. 

## What

Before diving into the Whys and Hows, it might be more reasonable to start with the What. 
And what is a Makefile?
Makefile is a compilation recipe. Not much more than that. 
It is language agnostic and can call shell commands alongside with anything available in the terminal.
And it also has its own set of functions and helper tools.
One of its magics is that it knows to only compile source code that is newer than its dependencies. 
 
From all forums and examples I've seen,
it is popular with the C/C++ engineer and the folks that deal with this kind of low level stuff
(seems like a smart crowd). 
Its roots go all the way to the early days of Unix, and it became the standard solution to managing complex compilation steps.
Jump five decades into the future and the Makefiles are known as general purposes tools that can be used from development environment setup to deployment scripts.
I'll cover some of its features and how they can be used in some different scenarios


## Useful resources

### Development Environment Setup

As developers, 
every once in a while we clone a new project and goes to the dreadful process of reading a README file and hoping for the setup process to be as painless as it promises. 
Best case scenario, it is a painless and boring time that every contributor of this project have been through. 
And it is not unlikely that the best case scenario slowly evolves to a worst case situation, as the project changes and this README quietly becomes outdated. 
That's the first place I see the Makefile being able to help: whenever its possible, the steps to setup the environment can be easily put in a executable target:

```Makefile
setup: ## Setups the local environment for development
    brew install whatever
    go install something
    npm install -g another-thing
```

For the purpose of this examples, I'm assuming a similar OS across all contributors. 
When it is not the case, some adaptations would be required. 

### Brief Documentation

### Built in caching strategies 

### Seamless Updates

### Language Agnostic

### CI Reusability

### Customization

Setting default variables with the possibility of overwrite them if there's an equal environment variable already set.

### Flexibility

Use the name of the target to do something

## Conclusions


Here are additional compelling reasons to include in your blog post about Makefiles:
Project Standardization & Onboarding

Creates a consistent interface across all projects (make test, make build, make deploy)
New team members can immediately understand how to work with any project
Reduces cognitive load when switching between different codebases

Dependency Management & Orchestration

Automatically handles complex build dependencies and prerequisites
Can manage external tool installations and version checks
Orchestrates multi-step processes (build → test → package → deploy)

Development Environment Consistency

Ensures all developers run commands with identical parameters
Eliminates "works on my machine" problems
Encapsulates environment-specific configurations

Task Composition & Reusability

Break complex workflows into smaller, composable targets
Share common tasks across different projects via includes
Create task hierarchies that build upon each other

Performance Optimization

Built-in parallelization with -j flag for independent tasks
Intelligent rebuilding based on file timestamps
Skip unnecessary work when outputs are already up-to-date

Cross-Platform Compatibility

Works identically on Linux, macOS, and Windows (with proper setup)
Abstracts away OS-specific command differences
Single source of truth for all platforms

Integration Simplicity

No additional runtime dependencies beyond make
Works with any existing toolchain or framework
Minimal learning curve for basic usage

Debugging & Transparency

Easy to see exactly what commands are being executed
Built-in dry-run capability with -n flag
Clear error reporting when tasks fail

Legacy & Stability

Battle-tested tool that's been around for decades
Won't become obsolete or require migration
Minimal maintenance overhead
