# Pong Game

A classic Pong implementation using LÖVE2D framework. This is a two-player game where each player controls a paddle to hit the ball back and forth.

## Game Features

- Two-player local gameplay
- Classic retro graphics
- Score tracking
- First to 10 points wins
- Increasing difficulty (ball speeds up after each hit)

## Controls

- **Player 1 (Left):**

  - `W` - Move paddle up
  - `S` - Move paddle down

- **Player 2 (Right):**

  - `Up Arrow` - Move paddle up
  - `Down Arrow` - Move paddle down

- **Other Controls:**
  - `Enter` - Start game/Serve ball
  - `Escape` - Quit game

## Installation

### Prerequisites

You need to have LÖVE2D installed on your system.

#### Windows

1. Download LÖVE2D from https://love2d.org/
2. Add LÖVE2D to your system PATH

#### macOS

```bash
brew install love
```

#### Linux (Ubuntu/Debian)

```bash
sudo apt-get install love
```

### Running the Game

#### Windows

1. Clone this repository
2. Navigate to the game directory
3. Either:
   - Drag the folder onto `love.exe`
   - Or run from command prompt: `love path/to/game/folder`

#### macOS/Linux

1. Clone this repository
2. Open terminal and navigate to the game directory
3. Run:

```bash
love .
```

## License

This project uses code from:

- push.lua by Ulysse Ramage (MIT License)
- class.lua by Matthias Richter (MIT License)
