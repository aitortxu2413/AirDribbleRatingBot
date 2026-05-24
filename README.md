# AirDribbleRatingBot

A modern Discord bot written in **C++23** using [D++](https://dpp.dev) (v10.1.5) and [nlohmann/json](https://github.com/nlohmann/json).
It features a modular architecture, clean error handling with `std::expected`, and separate build modes for development and release.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting the dependencies](#getting-the-dependencies)
  - [On Linux (GCC)](#on-linux-gcc)
  - [On Windows (MSVC)](#on-windows-msvc)
- [Configuration](#configuration)
- [Building and running](#building-and-running)
  - [Linux (Makefile)](#linux-makefile)
  - [Windows (CMake)](#windows-cmake)
- [Project structure](#project-structure)
- [Adding a new command](#adding-a-new-command)
- [Contributing](#contributing)
- [License](#license)

---

## Prerequisites

- **Git** – to clone the repository.
- A **C++23‑compatible compiler**:
  - **Linux**: GCC 14 or newer.
  - **Windows**: Visual Studio 2022 (MSVC) with C++23 support.
- **CMake** (version ≥ 3.20) – only required on Windows.
- **vcpkg** – recommended package manager on Windows.
- **pkg-config** – usually already present on Linux.

---

## Getting the dependencies

### On Linux (GCC)

#### No manual installation is needed

The project automatically donwload D++ 10.1.5 (precompiled for GCC, Debian) when you first build with Make. D++ itself includes nlohmann/json headers. All depencdencies are placed inside the build folder and linked statically in release mode.

### On Windows (MSVC)

#### No manual installation is needed.

The project uses CMake’s FetchContent to automatically download D++ 10.1.5 (precompiled for MSVC) when you first build. D++ itself includes nlohmann/json headers. All dependencies are placed inside the out/build folder and linked statically in release mode.

Just ensure you have Visual Studio 2022 or Visual Studio 2026 with the Desktop development with C++ workload installed.

## Configuration

Clone the repository:

```bash
git clone https://github.com/yourusername/AirDribbleRatingBot.git
cd AirDribbleRatingBot
```

Create a config.json in the project root (it’s already provided with a placeholder):

```json
{
    "token": "bot token",
    "color": "0xFFD700"
}
```

* Replace "bot token" with the actual token of your Discord bot.
* `color` is used for the color of the embeds or containers for each response of the bot.

> ⚠️ Never commit your real token. The placeholder file is safe to push.
> Consider adding config.json to your .gitignore after you have filled it.

## Building and running

### Linux (Makefile)

The Makefile provides four build modes. All binaries are placed inside build/.


| Command                   | What it does                                                             |
| ------------------------- | ------------------------------------------------------------------------ |
| `make` / `make debug-run` | Compile in debug mode (-g -O0 -march=native + warnings) and run the bot. |
| `make compile`            | Only compile in debug mode (no execution).                               |
| `make release`            | Compile in release mode (-O3 -flto -static, portable) and run the bot.   |
| `make compile-release`    | Only compile in release mode (no execution).                             |
| `make clean`              | Remove build/ directory.                                                 |

#### Examples:

```bash
# Quick test (debug)
make

# Full optimization, ready to distribute (static binary)
make release
```

### Windows (Visual Studio)

1. Open the project folder in Visual Studio 2022 (it will detect the CMakeLists.txt automatically).

2. Visual Studio will configure and download D++ and nlohmann_json the first time. Wait for the CMake generation to finish.

3. Select the configuration (Debug or Release) from the toolbar.

4. Build the project (Build → Build All).

5. Run the bot:
  * For Debug: use the `x64-Debug` target
  * For Release: use the `x64-Release` target.

## Project structure

```text
.
├── config.json              # Bot token (placeholder)
├── Makefile                 # For Linux / GCC
├── CMakeLists.txt           # For Windows / MSVC
├── README.md
└── src/
    ├── main.cpp             # Entry point: loads config, starts the bot
    ├── handlers/
    │   ├── event_handler.h/.cpp    # Global events (ready, log)
    │   ├── command_handler.h/.cpp  # Centralised command management
    │   └── interactionCreate_handler.h/.cpp # TODO
    └── commands/
        ├── ping.h            # Example command (inherits from ICommand)
        └── ...
```

## Adding a new command

1. Create a new class that inherits from `ICommand` (defined in `command_handler.h`).
2. Implement the three pure virtual methods:

```cpp
std::string get_name() const override;                       // e.g. "ping"
dpp::slashcommand definition(dpp::snowflake bot_id) const override;
std::expected<std::string, std::string> execute(const dpp::slashcommand_t& event) const override;
```

3. Register the command in `CommandHandler::load_commands()`:

```cpp
commands.push_back(std::make_unique<YourCommand>());
```

4. Recompile.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a feature branch (git checkout -b feature/my-feature).
3. Make your changes. Ensure the code compiles without warnings in both debug and release modes.
4. Test your changes thoroughly.
5. Submit a pull request with a clear description of what you’ve done.

### Code style:

* Follow the existing indentation and naming conventions.
* Use modern C++23 features where appropriate (std::expected, std::println, …).
* Keep header dependencies minimal.

For any questions or suggestions, open an issue.

## License

This project is licensed under the MIT License – see the LICENSE file for details.
