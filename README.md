# vscode-dotnet-process-extension

This extension allows you to run a shell script that finds .NET processes related to the currently active file in Visual Studio Code and copies the output to your clipboard.

## Features

- Executes a shell script located at `~/src/61/only_backend/backend/Scripts/find_dotnet_process.sh`.
- Automatically retrieves the full path of the currently active file and passes it as a parameter to the script.
- Copies the output of the script to the system clipboard for easy access.

## Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```
   cd vscode-dotnet-process-extension
   ```

3. Install the dependencies:
   ```
   npm install
   ```

4. Open the project in Visual Studio Code.

5. Press `F5` to run the extension in the Extension Development Host.

## Usage

- Open a file in Visual Studio Code.
- Run the command associated with the extension (you can find it in the Command Palette with `Ctrl+Shift+P`).
- The output of the shell script will be copied to your clipboard.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bugs.

## License

This project is licensed under the MIT License. See the LICENSE file for details.