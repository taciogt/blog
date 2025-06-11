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
every once in a while we clone a new project and go through the dreadful process of reading a README file and hoping for the setup process to be as painless as it promises. 
Best case scenario, it is a painless and boring time that every contributor of this project have been through. 
Unfortunately, it is not unlikely that the best case scenario evolves to a worst case situation: the project changes and this README quietly becomes outdated. 
That's the first place I see the Makefile being able to help: whenever its possible, the steps to setup the environment can be easily put in a executable target:

```Makefile
setup:
    brew install whatever
    go install something
    npm install -g another-thing
  
# For the purpose of this examples, I'm assuming a similar OS across all contributors. 
# When it is not the case, some adaptations would be required.
```

When the setup can be easily executed with a `make setup` command, 
it is easier to be updated because everyone is executing from the same source. 
As the project setup changes, it is much easier to tell everyone just to rerun `make setup` than to give a list of detail steps to take and to make the README longer each time.       

Even better, you can get by with not having to tell anyone about that. 
That's where seamless actions and caching strategies come in hand to make the setup updates transparent for whoever is contributing to it.
But since I mentioned the README a lot, it is worth mentioning how the Makefile can be an extension of it.

### Brief Documentation

We've all had the feeling that a project can only be as good as its documentation, 
be it an application, a full featured framework, or even a small library.
The same principle can be extended to the Makefile, and the good news is that it isn't hard to apply it.
With a simple help target the Makefile can be self-documented. It eliminates the need to leave the terminal and open the Makefile or the README for remembering how to run the integration tests.  

The implementation of this isn't hard, but relies on some not so frequently used tools. 
In the past I would search for some Stackoverflow answer to help with that, but now a simple prompt for an AI Agent can handle creating something like it:

```makefile
.DEFAULT_GOAL := help

help:	## Show this help
	@grep -E '^[a-zA-Z_/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
```

Then all you need to do is adding this `## ...` comments after any target to get a help message like that:

```
❯ make
build                Build the blog project
build/ci             Builds the application using the same parameters as the production environment
help                 Show this help
run                  Starts the local development server
setup                Setups the local environment for development
```


### Seamless Updates and Caching Strategies 

To talk about caching strategies, 
I want to talk about my impressions working with Go and Typescript projects regarding its dependency management systems.

When switching projects, I noticed that Go handles this with a seamless elegance that feels cumbersome in the standard Node solutions. 
I rarely need to manually download the dependencies when someone adds or upgrades a package in a Go project.
Go just knows when something have changed and downloads it on the fly. 
I only have to know about that if I'm the one reviewing the PR. 

But when I switch back to a Typescript repository, 
I'll just run a `git pull` and try to run the project. 
If I'm lucky, I'll immediately get some error due to a missing package when starting the application. 
If I'm not so lucky, I'll get a runtime error and wonder for a while until I remember the `npm install` I have forgotten. Every single time.

Should I learn something from it?
Yes.
Did I?
No. 
But I found a solution, for this problem and a few more. 
To implement this solution, first I put my standard commands in a set of Makefile targets. 
I'll simulate a generic Node based application for this example, but it can be done with any type of project. 

```Makefile
setup:
    npm install
    
start:
    npm start
```

To make my life easier, I want to customize these targets so they work like this:
* When I execute `make start`, it should run the setup instructions automatically  
* When I execute `make setup`, it should only do something if:
  * It's the first time I'm calling it;
  * Something have changed with `package.json` or `package.lock.json`;
  * Something have changed with the `Makefile` itself.

To achieve that, the Makefile becomes something like this:

```Makefile
.setup.timestamp: Makefile package.json package.lock.json
    npm install
    @touch .setup.timestamp 

setup: .setup.timestamp

start: setup
    npm start
```

Now it doesn't matter if it the first time cloning the project or if you're pulling some changes that with some minor dependency upgrades,
running `make start` is always enough and no one needs to run `npm install` anymore.

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
