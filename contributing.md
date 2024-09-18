# Contributing to AoC Multi-Language Solver

Thank you for considering contributing to AoC Multi-Language Solver! We welcome contributions that improve the tool, add support for new languages, optimize workflows, or fix bugs. Follow the guidelines below to ensure a smooth collaboration.

## How to Contribute

1. Fork the Repo
- Fork the repository by clicking the "Fork" button at the top right of this page.
- Clone your fork to your local machine:

```
git clone https://github.com/your-username/aoc-multi-lang-solver.git
cd aoc-multi-lang-solver
```

2. Create a Branch

Create a new branch for your feature or bugfix:

```
git checkout -b feature/new-awesome-feature
```

Make sure your branch name is descriptive. Example: ``fix/input-bug``, ``feature/add-python-support``.

3. Install Dependencies

Run the setup script to install all required dependencies:

```./setup.sh```

This script will install dependencies for each supported language and set up the project environment.

4. Make Your Changes
- Add features, fix bugs, or optimize code.
- Make sure you have unit tests where applicable, especially for new language support.
- Ensure that you follow the code style for each language (e.g., ESLint for JavaScript, RuboCop for Ruby).

5. Test Your Changes

Before submitting your changes, make sure that everything works as expected.

- Run language-specific tests (e.g., JavaScript linter):

```npm run lint```

- Run the manager script to ensure your changes work across different languages:

```./aoc_manager.sh create YYYY DD```

Replace ``YYYY`` and ``DD`` with any year and day to test template creation and running solutions.

6. Commit and Push Your Changes
- Commit your changes with a clear and concise commit message:

```
git commit -m "Add support for Go language"
```

- Push your branch to your forked repository:

```
git push origin feature/new-awesome-feature
```

7. Create a Pull Request
- Once your changes are pushed, create a pull request (PR) from your branch to the main branch of this repository.
- In the PR description, provide a clear explanation of your changes.
- Reference any relevant issues (e.g., ``Fixes #23``).

## Code of Conduct

We are committed to fostering a welcoming and respectful environment. By participating, you agree to adhere to our Code of Conduct.
