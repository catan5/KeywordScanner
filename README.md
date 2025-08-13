# KeywordScanner

PowerShell script to scan resumes for keyword matches across PDF and text files.

## Requirements

- PowerShell
- Microsoft Office (for PDF support via Word Interop)

## Usage

1. Place your resumes in a folder.
2. Create a `keywords.txt` file with your keywords, one per line.
3. Edit the script if you want to change the folder or keyword file paths, or pass them as parameters if you add parameter support.
4. Run the script:

```powershell
.\KeywordScanner.ps1
```

## Example (excerpt)

```powershell
$patterns = Get-Content $keywordFile | Where-Object { $_ -ne "" }
# ...rest of script logic...
```

See the full script in [KeywordScanner.ps1](KeywordScanner.ps1).
