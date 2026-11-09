
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'ns' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'ns'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-') -or
                $element.Value -eq $wordToComplete) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'ns' {
            [CompletionResult]::new('--license', '--license', [CompletionResultType]::ParameterName, 'Print license info and exit')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('shell', 'shell', [CompletionResultType]::ParameterValue, 'Start an interactive shell with some packages from nixpkgs')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a program from nixpkgs')
            [CompletionResult]::new('edit', 'edit', [CompletionResultType]::ParameterValue, 'Open the source code for a derivation from nixpkgs in $EDITOR')
            [CompletionResult]::new('homepage', 'homepage', [CompletionResultType]::ParameterValue, 'Open the homepage for the selected package(s)')
            [CompletionResult]::new('source', 'source', [CompletionResultType]::ParameterValue, 'Open the package''s nix declaration')
            [CompletionResult]::new('search', 'search', [CompletionResultType]::ParameterValue, 'Search options (prints to stdout on selection)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ns;shell' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ns;run' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ns;edit' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ns;homepage' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ns;source' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ns;search' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ns;help' {
            [CompletionResult]::new('shell', 'shell', [CompletionResultType]::ParameterValue, 'Start an interactive shell with some packages from nixpkgs')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run a program from nixpkgs')
            [CompletionResult]::new('edit', 'edit', [CompletionResultType]::ParameterValue, 'Open the source code for a derivation from nixpkgs in $EDITOR')
            [CompletionResult]::new('homepage', 'homepage', [CompletionResultType]::ParameterValue, 'Open the homepage for the selected package(s)')
            [CompletionResult]::new('source', 'source', [CompletionResultType]::ParameterValue, 'Open the package''s nix declaration')
            [CompletionResult]::new('search', 'search', [CompletionResultType]::ParameterValue, 'Search options (prints to stdout on selection)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ns;help;shell' {
            break
        }
        'ns;help;run' {
            break
        }
        'ns;help;edit' {
            break
        }
        'ns;help;homepage' {
            break
        }
        'ns;help;source' {
            break
        }
        'ns;help;search' {
            break
        }
        'ns;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
