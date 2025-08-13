# KeywordScanner
PowerShell script to scan resumes for keyword matches across PDF and text files.

```powershell
$folderPath = "C:\Users\setup\OneDrive\Desktop\Res Updates"
$keywordFile = "C:\Users\setup\OneDrive\Desktop\keywords.txt"
$patterns = Get-Content $keywordFile | Where-Object { $_ -ne "" }
try {
    Add-Type -AssemblyName "Microsoft.Office.Interop.Word"
    $wordApp = New-Object -ComObject Word.Application
    $wordApp.Visible = $false
    $pdfSupport = $true
} catch {
    $pdfSupport = $false
}
$results = Get-ChildItem -Path $folderPath -Recurse -File | ForEach-Object {
    $file = $_
    $content = $null
    if ($file.Extension.ToLower() -eq ".pdf" -and $pdfSupport) {
        try {
            $doc = $wordApp.Documents.Open($file.FullName)
            $content = $doc.Content.Text
            $doc.Close()
        } catch {
            $content = $null
        }
    } else {
        $content = Get-Content -Path $file.FullName -Raw -ErrorAction SilentlyContinue
    }
    if ($null -ne $content) {
        if ($file.Extension.ToLower() -eq ".pdf") {
            $lines = $content -split "`n"
            for ($i = 0; $i -lt $lines.Count; $i++) {
                $lineText = $lines[$i].ToLower()
                $matched = ($patterns | Where-Object { $lineText -like "*$($_.ToLower())*" }) -join ", "
                if ($matched) {
                    [PSCustomObject]@{
                        Folder = Split-Path $file.FullName -Parent
                        File = $file.Name
                        FileType = "PDF"
                        LastModified = $file.LastWriteTime.ToString("yyyy-MM-dd HH:mm")
                        LineNumber = $i + 1
                        MatchedKeyword = $matched
                    }
                }
            }
        } else {
            Select-String -Path $file.FullName -Pattern $patterns | ForEach-Object {
                $lineText = $_.Line.ToLower()
                $matched = ($patterns | Where-Object { $lineText -like "*$($_.ToLower())*" }) -join ", "
                [PSCustomObject]@{
                    Folder = Split-Path $file.FullName -Parent
                    File = $file.Name
                    FileType = $file.Extension
                    LastModified = $file.LastWriteTime.ToString("yyyy-MM-dd HH:mm")
                    LineNumber = $_.LineNumber
                    MatchedKeyword = $matched
                }
            }
        }
    }
}
if ($pdfSupport) { $wordApp.Quit() }
$results | Export-Csv -Path "C:\Users\setup\OneDrive\Desktop\SearchResults.csv" -NoTypeInformation
```
