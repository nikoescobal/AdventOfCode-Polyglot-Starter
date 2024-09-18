#!/bin/bash

# Prompt user to select languages
echo "Please select the languages you want to install:"
echo "1) Clojure"
echo "2) JavaScript"
echo "3) Ruby"
echo "4) Python"
echo "5) All of the above"
read -p "Enter your choice (e.g., 1, 2, 3, or 5 for all): " choice

install_clojure() {
  echo "Installing Clojure..."
  # Check for Clojure or provide installation instructions
}

install_javascript() {
  echo "Installing Node.js for JavaScript..."
  # Node.js installation
  if command -v node &> /dev/null; then
    echo "Node.js is already installed"
  else
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      sudo apt install nodejs
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      brew install node
    elif [[ "$OSTYPE" == "cygwin" ]]; then
      echo "For Windows, please install Node.js manually from https://nodejs.org"
    fi
  fi
}

install_ruby() {
  echo "Installing Ruby..."
  # Ruby installation
  if command -v ruby &> /dev/null; then
    echo "Ruby is already installed"
  else
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      sudo apt install ruby
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      brew install ruby
    elif [[ "$OSTYPE" == "cygwin" ]]; then
      echo "For Windows, please install Ruby manually from https://rubyinstaller.org/"
    fi
  fi
}

install_python() {
  echo "Installing Python..."
  if command -v python3 &> /dev/null; then
    echo "Python is already installed"
  else
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      sudo apt install python3
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      brew install python3
    elif [[ "$OSTYPE" == "cygwin" ]]; then
      echo "For Windows, please install Python manually from https://www.python.org/"
    fi
  fi
}

# Based on user selection, install languages
case $choice in
  1)
    install_clojure
    ;;
  2)
    install_javascript
    ;;
  3)
    install_ruby
    ;;
  4)
    install_python
    ;;
  5)
    install_clojure
    install_javascript
    install_ruby
    install_python
    ;;
  *)
    echo "Invalid choice. Exiting."
    ;;
esac

echo "Setup complete!"
