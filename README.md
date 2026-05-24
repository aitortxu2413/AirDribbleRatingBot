# AirDribbleRatingBot

A modern Discord bot written in **C++23** using [D++](https://github.com/brainboxdotcc/DPP) (v10.1.5).

It is designed for the Air Dribble Rating discord server and implements a structured ranking and challenge system.

---

## 🚀 Features

- Challenge-based ranking system
- Role management based on rating
- Moderation workflow via submissions
- Modular command architecture
- Linux, Debian (Makefile) + Windows (CMake) support

---

## Prerequisites

* Git – to clone the repository.
* A C++23‑compatible compiler:
  * Linux: GCC 14 or newer.
  * Windows: Visual Studio 2022/2026 (MSVC) with C++23 support.
* CMake (version ≥ 3.20) – only required on Windows.
* pkg-config – usually already present on Linux.

---

## ⚙️ Setup

```bash
git clone https://github.com/yourusername/AirDribbleRatingBot.git
cd AirDribbleRatingBot
```

## Create config:

```bash
cp config.example.json config.json
```

Edit token.

## Build

### On Linux, Debian (GCC)

No needed instalations.

```bash
make
make release
```

### On Windows (MSVC)

No needed instalations.

Compile the CMakeLists.txt on Visual Studio 2022/2026 and you will be ready to go.

---

## Documentation

* Commands: docs/commands.md
* Contributing: docs/contributing.md
* Roadmap: docs/roadmap.md
* Architecture: docs/architecture.md

## ⚠️ Note

This bot is tailored for a specific Discord server.
Commands and behavior are not generic.

## 📄 License

This project is licensed under the MIT License – see the LICENSE file for details.
