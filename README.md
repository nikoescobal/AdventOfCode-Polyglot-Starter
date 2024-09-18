# Advent Of Code Polyglot Starter

This repository helps you quickly get started solving Advent of Code challenges in multiple programming languages, such as Clojure, JavaScript, Python, and Ruby. It sets up everything from fetching inputs automatically to generating language-specific solution templates, so you can focus on solving the problems rather than configuring environments.

## Built with

- Clojure
- JavaScript
- Python
- Ruby
- Bash Scripting
- Lots of love :heart:


## Live Demo

*Coming soon!*


## Getting Started

Prerequisites
Ensure the following tools are installed:

Node.js (for JavaScript solutions)
Python 3 (for Python solutions)
Ruby (for Ruby solutions)
Clojure CLI (for Clojure solutions)

## Setup

1. Clone this repository:

```
git clone https://github.com/nikoescobal/aoc-multi-lang-solver.git
cd aoc-multi-lang-solver
```

2. Setting up the Session Cookie

### Create the .env.local file:
To fetch inputs for Advent of Code challenges, you need to store your session cookie in an ``.env.local`` file.

```
SESSION_COOKIE="your-cookie-here"
```

Replace ``"your-cookie-here"`` with the actual session cookie you retrieve from Advent of Code.

### How to retrieve the session cookie:

- Go to Advent of Code and log in.
- Open your browser's developer tools (usually ``F12`` or right-click on the page and select "Inspect").
- Go to the **Application** tab (in Chrome) or **Storage** tab (in Firefox).
- Look for **Cookies** on the left sidebar and find **https://adventofcode.com.***
- Locate the ``session`` cookie and copy its value.
- Paste the session value in your ``.env.local`` file as shown above.

The session cookie is essential for fetching the challenge inputs programmatically.


1. Run the setup script:

```
./setup.sh
```

- This will install necessary dependencies for each language (Node.js packages, Python modules, Ruby gems, Clojure dependencies).
- You’ll be prompted to choose the languages you want to use for solving AoC problems.
- Enter your Advent of Code session cookie to allow input fetching for the challenges.

4. Create templates for a specific challenge:

To fetch the input and create templates for a given day:

```
./aoc_manager.sh create YYYY DD
```

Replace ``YYYY`` with the year and ``DD`` with the day number of the challenge.

5. Run a solution in the desired language:

```
make run LANG=[clojure|javascript|ruby|python] YYYY DD
```

Replace ``LANG``, ``YYYY``, and ``DD`` with the appropriate values for the challenge you want to solve.

**Running Tests**
For JavaScript solutions, you can run linters using:

```nppm run lint```

## Author:

👤 **Nikolas Escobal**

[<code><img height="26" src="https://cdn.iconscout.com/icon/free/png-256/github-153-675523.png"></code>](https://github.com/nikoescobal)
[<code><img height="26" src="https://upload.wikimedia.org/wikipedia/sco/thumb/9/9f/Twitter_bird_logo_2012.svg/1200px-Twitter_bird_logo_2012.svg.png"></code>](https://twitter.com/nikoescobal)
[<code><img height="26" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Linkedin.svg/1200px-Linkedin.svg.png"></code>](https://www.linkedin.com/in/nikolas-escobal/)
 <a href="mailto:niko.escobal@gmail.com?subject=Sup Niko?"><img height="26" src="https://cdn.worldvectorlogo.com/logos/official-gmail-icon-2020-.svg"></a>


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/nikoescobal/members-only/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments
- Advent of Code community
- Open-source contributors

## 📝 License

This project makes use of the MIT license.