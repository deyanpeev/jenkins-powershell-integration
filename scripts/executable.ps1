<#
   The purpose of this file is to generate other files.
   This file could be as complex as invoking and integrating
   with other systems, comparing, traversing responses, 
   combining multiple statements to a single or multiple files.
   Matter of fact the UC for my client is similar - we compose
   a dozen of integrations and then compose a set of CSV files.
   
   For simplicity this script is only going to generate a simple .txt file.
#>

Param(
    [Parameter(Mandatory=$False)]
    [string]
    $FilePrefix = ""
)

$MIN_FILE_LENGTH = 100
$MAX_FILE_LENGTH = 255
$FILE_OUTPUT_DIR = "output-files/"
$FILE_EXTENSION = ".txt"

function Get-UniqueFileName {
    Param([string]$Prefix)

    if($Prefix) {
        $Prefix += '-'
    }
    $generatedDate = [System.DateTime]::Now.ToString("yyyy-MM-dd_HH-mm-ss.fff")

    return "${Prefix}${generatedDate}"
}

function Get-RandomFileContent {
    Param([Int32]$MinLength, [Int32]$MaxLength)
    $fileSize = Get-Random -Minimum $MinLength -Maximum $MaxLength
    $fileContent = -join ((97..122) * $fileSize | Get-Random -Count $fileSize | %{[char]$_})
    return $fileContent
}

$fileName = Get-UniqueFileName -Prefix $FilePrefix
$fileContent = Get-RandomFileContent -MinLength $MIN_FILE_LENGTH -MaxLength $MAX_FILE_LENGTH
New-Item -Name "${FILE_OUTPUT_DIR}${filename}${FILE_EXTENSION}" -Value $fileContent