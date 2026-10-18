<#
.SYNOPSIS
  Install or remove the agent-guidelines blocks and skills for Claude Code,
  Codex and GitHub Copilot CLI.

.DESCRIPTION
  Idempotent. Skills under .\skills\ are linked (directory junction) into each
  tool's skills directory. Every block in AGENTS.md wrapped in
  <!-- agent-guidelines:<name>:start --> ... <!-- agent-guidelines:<name>:end -->
  is upserted into each tool's global instruction file. Text outside the
  markers is never touched.

.PARAMETER Uninstall
  Remove the junctions and the marked blocks.
#>
[CmdletBinding()]
param(
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'
$repo = $PSScriptRoot
$agentsFile = Join-Path $repo 'AGENTS.md'
$skillsSrc = Join-Path $repo 'skills'

$targets = @(
    @{ Name = 'Claude Code'; Instructions = "$HOME\.claude\CLAUDE.md";               Skills = "$HOME\.claude\skills" },
    @{ Name = 'Codex';       Instructions = "$HOME\.codex\AGENTS.md";                Skills = "$HOME\.codex\skills" },
    @{ Name = 'Copilot CLI'; Instructions = "$HOME\.copilot\copilot-instructions.md"; Skills = "$HOME\.copilot\skills" }
)

function Read-Utf8([string]$path) {
    if (Test-Path -LiteralPath $path) { return [IO.File]::ReadAllText($path, [Text.UTF8Encoding]::new($false)) }
    return ''
}

function Write-Utf8([string]$path, [string]$content) {
    $dir = Split-Path -Parent $path
    if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    [IO.File]::WriteAllText($path, $content, [Text.UTF8Encoding]::new($false))
}

# Returns an ordered list of @{ Name; Text } for every marked block in AGENTS.md.
function Get-Blocks {
    $src = Read-Utf8 $agentsFile
    $pattern = '(?s)<!-- agent-guidelines:(?<name>[a-z0-9-]+):start -->.*?<!-- agent-guidelines:\k<name>:end -->'
    $found = [regex]::Matches($src, $pattern)
    if ($found.Count -eq 0) { throw "No marked blocks found in $agentsFile" }
    foreach ($m in $found) { @{ Name = $m.Groups['name'].Value; Text = $m.Value } }
}

function Set-Block([string]$file, [hashtable]$block) {
    $text = Read-Utf8 $file
    $pattern = "(?s)<!-- agent-guidelines:$($block.Name):start -->.*?<!-- agent-guidelines:$($block.Name):end -->"
    if ([regex]::IsMatch($text, $pattern)) {
        $new = [regex]::Replace($text, $pattern, { param($m) $block.Text }, 1)
        $action = 'updated'
    } else {
        $sep = if ($text.Length -eq 0) { '' } elseif ($text.EndsWith("`n`n")) { '' } elseif ($text.EndsWith("`n")) { "`n" } else { "`n`n" }
        $new = $text + $sep + $block.Text + "`n"
        $action = 'added'
    }
    if ($new -eq $text) { return 'current' }
    Write-Utf8 $file $new
    return $action
}

function Remove-Block([string]$file, [hashtable]$block) {
    if (-not (Test-Path -LiteralPath $file)) { return 'absent' }
    $text = Read-Utf8 $file
    $pattern = "(?s)\n*<!-- agent-guidelines:$($block.Name):start -->.*?<!-- agent-guidelines:$($block.Name):end -->\n?"
    if (-not [regex]::IsMatch($text, $pattern)) { return 'absent' }
    $new = [regex]::Replace($text, $pattern, "`n", 1)
    Write-Utf8 $file $new
    return 'removed'
}

function Set-SkillLink([string]$skillsDir, [IO.DirectoryInfo]$skill) {
    if (-not (Test-Path -LiteralPath $skillsDir)) { New-Item -ItemType Directory -Path $skillsDir | Out-Null }
    $link = Join-Path $skillsDir $skill.Name
    if (Test-Path -LiteralPath $link) {
        $item = Get-Item -LiteralPath $link -Force
        $isLink = ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
        if ($isLink) {
            if ($item.Target -eq $skill.FullName -or $item.Target -eq "\\?\$($skill.FullName)") { return 'linked' }
            # Points somewhere else: replace. Removing a junction never touches the target.
            [IO.Directory]::Delete($link)
        } else {
            $backup = "$link.bak-$(Get-Date -Format yyyyMMdd-HHmmss)"
            Move-Item -LiteralPath $link -Destination $backup
            Write-Warning "  $link was a real directory; moved to $backup"
        }
    }
    New-Item -ItemType Junction -Path $link -Target $skill.FullName | Out-Null
    return 'linked'
}

function Remove-SkillLink([string]$skillsDir, [IO.DirectoryInfo]$skill) {
    $link = Join-Path $skillsDir $skill.Name
    if (-not (Test-Path -LiteralPath $link)) { return 'absent' }
    $item = Get-Item -LiteralPath $link -Force
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0) { return 'kept (real directory, not ours)' }
    [IO.Directory]::Delete($link)
    return 'removed'
}

$blocks = @(Get-Blocks)
$skills = @(Get-ChildItem -LiteralPath $skillsSrc -Directory | Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') })

foreach ($t in $targets) {
    Write-Host "== $($t.Name)"
    foreach ($b in $blocks) {
        $r = if ($Uninstall) { Remove-Block $t.Instructions $b } else { Set-Block $t.Instructions $b }
        Write-Host ("  block {0,-24} {1,-8} {2}" -f $b.Name, $r, $t.Instructions)
    }
    foreach ($s in $skills) {
        $r = if ($Uninstall) { Remove-SkillLink $t.Skills $s } else { Set-SkillLink $t.Skills $s }
        Write-Host ("  skill {0,-24} {1,-8} {2}" -f $s.Name, $r, (Join-Path $t.Skills $s.Name))
    }
}
