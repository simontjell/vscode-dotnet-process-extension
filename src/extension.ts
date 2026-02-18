import * as vscode from 'vscode';
import * as path from 'path';

export function activate(context: vscode.ExtensionContext) {
    let disposable = vscode.commands.registerCommand('extension.findDotnetProcess', async () => {
        const activeEditor = vscode.window.activeTextEditor;
        if (!activeEditor) {
            vscode.window.showWarningMessage('No active editor found.');
            return;
        }

        const filePath = activeEditor.document.fileName;
        const scriptPath = path.join(context.extensionPath, 'src', 'utils', 'find_dotnet_process.sh');

        const terminal = vscode.window.createTerminal('Find .NET Process');
        terminal.show();
        terminal.sendText(`bash "${scriptPath}" "${filePath}"`);
    });

    context.subscriptions.push(disposable);
}

export function deactivate() {}