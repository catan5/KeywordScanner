# KeywordScanner
PowerShell script to scan resumes for keyword matches across PDF and text files.
# 🔍 KeywordScanner.ps1

A PowerShell script designed to scan resume files for specific keywords, supporting both `.txt` and `.pdf` formats. Ideal for recruiters, career coaches, or workforce development professionals looking to automate resume analysis.

## 🚀 Features
- Recursively scans a folder of resumes
- Supports PDF parsing via Microsoft Word Interop
- Matches lines against a customizable keyword list
- Outputs matched lines with file name, line number, and keyword hits

## 📂 Input Requirements
- **Resume Folder**: Update `$folderPath` to the directory containing resumes
- **Keyword File**: A plain text file (`keywords.txt`) with one keyword per line

## 🛠️ Usage
```powershell
.\KeywordScanner.ps1
