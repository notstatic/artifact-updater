# FiveM Server Artifact Updater - Guide

This extended guide provides detailed instructions on configuring and understanding the FiveM Server Update Script for Windows. This script automates the process of checking for the latest FiveM server artifact, downloading it, and updating your server with minimal manual intervention.

## Configuration Instructions

Before running the script, it's crucial to ensure your environment is properly set up and the script is correctly configured to match your server's directory structure.

### Setting Up Your Environment

1. **Ensure `curl` is Installed:**
   - The script uses `curl` for downloading files. Verify its installation by typing `curl --version` in a command prompt. If it's not installed, you will need to download and install `curl`.

2. **Check PowerShell Availability:**
   - PowerShell is used for extracting the downloaded server artifact. Confirm its presence by typing `powershell` in the command prompt.

3. **PATH Environment Variable:**
   - Make sure both `curl` and PowerShell are in your system's PATH environment variable to execute them from any directory.

4. **Adding the Server Start Command:**
   - To start your FiveM server automatically after an update, add the server start command at the end of the script. Locate the line that says `echo Update complete, starting FiveM server...` and add your server's start command below it. For example:

```bat
:: add your start command below this echo
echo Update complete, starting FiveM server...
cd /d %SERVER_DIR%\data
%ARTIFACT_DIR%\FXServer.exe +exec server.cfg
```

## Understanding How the Script Works

The script performs several steps to update your FiveM server efficiently:

### Step 1: Initial Setup

Sets up variables for directories and files, and creates a temporary directory for downloads and intermediate files.

### Step 2: Downloading the Artifact Page

Uses `curl` to fetch the page listing available server artifacts from the FiveM repository, saving it to the temporary directory.

### Step 3: Parsing for the Latest Artifact

Searches the downloaded page for the link to the latest server artifact using pattern matching, then prepares the download URL.

### Step 4: Download and Replace the Server Artifact

Downloads the latest artifact and replaces the old server files with the new ones by extracting the downloaded archive.

### Step 5: Clean Up

Removes all temporary files and directories created during the update process to maintain a clean environment.

### Step 6: Server start

After the script completes the update process, it can automatically starts your FiveM server if you've added a start command at the designated spot in the script. If you haven't set up a start command, the script will complete its execution and exit without starting the server.

To ensure your server starts automatically after an update, insert your server's start command as shown below, immediately following the `echo Update complete, starting FiveM server...` message in the script:

```bat
:: add your start command below this echo
echo Update complete, starting FiveM server...
cd /d %SERVER_DIR%\data
%ARTIFACT_DIR%\FXServer.exe +exec server.cfg
```

## Customization and Additional Notes

- **Custom Paths:** Adjust the path variables at the beginning of the script if your server's directory structure is different.
- **Error Handling:** Includes basic error checks, mainly for download failures. Ensure the URLs in the script are correct and your internet connection is stable.

By following these configuration instructions and understanding the script's workflow, you can more effectively use the script to keep your FiveM server up to date with the latest server artifacts.
