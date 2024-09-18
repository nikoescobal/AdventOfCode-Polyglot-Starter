#!/bin/bash

# Ensure SCRIPT_DIR is the directory where this script resides, not where it's being run from
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Load or prompt for session cookie
load_session_cookie() {
  if [ -f "$SCRIPT_DIR/.env.local" ]; then
    SESSION_COOKIE=$(grep SESSION_COOKIE "$SCRIPT_DIR/.env.local" | cut -d '=' -f2 | tr -d '"')
  elif [ -f "$SCRIPT_DIR/.env" ]; then
    SESSION_COOKIE=$(grep SESSION_COOKIE "$SCRIPT_DIR/.env" | cut -d '=' -f2 | tr -d '"')
  else
    read -p "Enter your Advent of Code session cookie: " SESSION_COOKIE
    echo "SESSION_COOKIE=\"$SESSION_COOKIE\"" > "$SCRIPT_DIR/.env.local"
  fi

  if [ -z "$SESSION_COOKIE" ]; then
    echo "Error: Session cookie not found."
    exit 1
  fi
}

fetch_input() {
  YEAR=$1
  DAY=$2
  FORCE=$3

  load_session_cookie

  INPUT_DIR="$SCRIPT_DIR/inputs/$YEAR"
  mkdir -p "$INPUT_DIR" || { echo "Failed to create directory: $INPUT_DIR"; exit 1; }

  INPUT_FILE="$INPUT_DIR/day$DAY.txt"

  if [ -f "$INPUT_FILE" ]; then
    if [ "$FORCE" = "--force" ] || [ "$FORCE" = "-f" ]; then
      > "$INPUT_FILE"
    else
      read -p "Input file already exists at $INPUT_FILE. Overwrite? [y/N]: " OVERWRITE
      if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        return
      fi
    fi
  fi

  INPUT_URL="https://adventofcode.com/$YEAR/day/$DAY/input"
  RESPONSE=$(curl -s -o "$INPUT_FILE" -w "%{http_code}" --cookie "session=$SESSION_COOKIE" "$INPUT_URL")

  if [ "$RESPONSE" -eq 200 ]; then
    echo "Fetched input file for Day $DAY, $YEAR and saved to $INPUT_FILE"
  else
    echo "Failed to fetch input file. HTTP response code: $RESPONSE"
    cat "$INPUT_FILE"
    exit 1
  fi
}

# Function to create solution files for a given language
create_template() {
  LANG=$1
  EXT=$2
  YEAR=$3
  DAY=$4
  FORCE=$5

  DIR="$SCRIPT_DIR/src/$LANG/aoc/$YEAR"
  FILE="$DIR/day$DAY.$EXT"

  mkdir -p "$DIR"
  TEMPLATE_FILE="$SCRIPT_DIR/templates/$LANG.template"

  if [ -f "$TEMPLATE_FILE" ]; then
    if [ -f "$FILE" ]; then
      if [ "$FORCE" = "--force" ] || [ "$FORCE" = "-f" ]; then
        sed "s/\$YEAR/$YEAR/g; s/\$DAY/$DAY/g" "$TEMPLATE_FILE" > "$FILE"
        echo "Overwritten $LANG solution file at $FILE"
      else
        read -p "$LANG solution file already exists at $FILE. Overwrite? [y/N]: " OVERWRITE
        if [[ "$OVERWRITE" =~ ^[Yy]$ ]]; then
          sed "s/\$YEAR/$YEAR/g; s/\$DAY/$DAY/g" "$TEMPLATE_FILE" > "$FILE"
          echo "Overwritten $LANG solution file at $FILE"
        else
          echo "Skipped $LANG solution file at $FILE"
          return
        fi
      fi
    else
      # Here, replace the placeholders in the template with the actual YEAR and DAY
      sed "s/\$YEAR/$YEAR/g; s/\$DAY/$DAY/g" "$TEMPLATE_FILE" > "$FILE"
      echo "Created $LANG solution file at $FILE"
    fi
  else
    echo "Template file for $LANG not found."
    exit 1
  fi
}

run_solution() {
  LANG=$1
  YEAR=$2
  DAY=$3
  CHAR_LIMIT=10  # Define how many characters to print

  case "$LANG" in
    clojure)
      EXT="clj"
      ;;
    javascript)
      EXT="js"
      ;;
    ruby)
      EXT="rb"
      ;;
    python)
      EXT="py"
      ;;
    *)
      echo "Unsupported language: $LANG"
      exit 1
      ;;
  esac

  FILE="$SCRIPT_DIR/src/$LANG/aoc/$YEAR/day$DAY.$EXT"
  INPUT_FILE="$SCRIPT_DIR/inputs/$YEAR/day$DAY.txt"

  if [ ! -f "$INPUT_FILE" ]; then
    echo "Input file missing for Day $DAY, $YEAR. Please fetch input first."
    exit 1
  fi

  INPUT_SNIPPET=$(head -c $CHAR_LIMIT "$INPUT_FILE")

  case "$LANG" in
    clojure)
      echo "Running Clojure solution for Day $DAY in Year $YEAR..."
      echo "First $CHAR_LIMIT characters of input: $INPUT_SNIPPET"
      echo "Please evaluate the file manually using Calva in VS Code."
      echo "Go to: $FILE"
      ;;
    javascript)
      echo "Running JavaScript solution..."
      echo "First $CHAR_LIMIT characters of input: $INPUT_SNIPPET"
      node "$FILE" || { echo "JavaScript execution failed"; exit 1; }
      ;;
    ruby)
      echo "Running Ruby solution..."
      echo "First $CHAR_LIMIT characters of input: $INPUT_SNIPPET"
      ruby "$FILE" || { echo "Ruby execution failed"; exit 1; }
      ;;
    python)
      echo "Running Python solution..."
      echo "First $CHAR_LIMIT characters of input: $INPUT_SNIPPET"
      python3 "$FILE" || { echo "Python execution failed"; exit 1; }
      ;;
    *)
      echo "Unsupported language: $LANG"
      exit 1
      ;;
  esac
}

COMMAND=$1

if [ "$COMMAND" = "create" ]; then
  YEAR=$2
  DAY=$3
  FORCE=$4

  if ! [[ "$YEAR" =~ ^[0-9]+$ ]] || ! [[ "$DAY" =~ ^[0-9]+$ ]]; then
    echo "Error: YEAR and DAY must be numbers."
    exit 1
  fi

  fetch_input $YEAR $DAY $FORCE

  create_template "clojure" "clj" $YEAR $DAY $FORCE
  create_template "javascript" "js" $YEAR $DAY $FORCE
  create_template "ruby" "rb" $YEAR $DAY $FORCE
  create_template "python" "py" $YEAR $DAY $FORCE

  # Automatically run the solution after creation
  run_solution "clojure" $YEAR $DAY
  run_solution "javascript" $YEAR $DAY
  run_solution "ruby" $YEAR $DAY
  run_solution "python" $YEAR $DAY

elif [ "$COMMAND" = "input" ]; then
  YEAR=$2
  DAY=$3
  FORCE=$4

  fetch_input $YEAR $DAY $FORCE

elif [ "$COMMAND" = "submit" ]; then
  YEAR=$2
  DAY=$3
  load_session_cookie

  if [ -z "$YEAR" ] || [ -z "$DAY" ];then
    echo "Usage: ./aoc_manager.sh submit YEAR DAY"
    exit 1
  fi

  read -p "Enter your answer: " ANSWER

  SUBMIT_URL="https://adventofcode.com/$YEAR/day/$DAY/answer"
  RESPONSE=$(curl -s -X POST -d "answer=$ANSWER" --cookie "session=$SESSION_COOKIE" -w "%{http_code}" "$SUBMIT_URL")

  if [ "$RESPONSE" -eq 200 ]; then
    echo "Solution for Day $DAY, $YEAR submitted successfully!"
  else
    echo "Failed to submit solution. HTTP response code: $RESPONSE"
    exit 1
  fi

else
  echo "Usage:"
  echo "  ./aoc_manager.sh create YEAR DAY [--force]"
  echo "  ./aoc_manager.sh input YEAR DAY [--force]"
  echo "  ./aoc_manager.sh submit YEAR DAY"
  exit 1
fi
