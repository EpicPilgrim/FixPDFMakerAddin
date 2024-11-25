# Summary
Why does this exist?

Many organisations use Intune or Group Policies to disable Macros in the Office suite, as they present security risks. In Australia, doing so is a prerequisite for the first maturity level of the ASD Essential Eight security baseline.

Adobe Acrobat seems to rely on Macros in some way for their PDFMaker add-in that comes with Acrobat to function. Often, this means that users opening documents with the add-in activated may be prompted over and over again about macros.

This Powershell script can be deployed with Intune or GP to restrict permissions to the Add-In folder that Adobe use, so that the SYSTEM user can still read/write (for upgrades), but no other users (so the add-in cannot activate). Others have tried renaming the folders, but the folders come back after repair/upgrade. This fixes that problem.

# Usage
These instructions are for those using Intune. For those using Group Policies or some other deployment/management technology, adjust accordingly.

1. Download the .ps1 script.
2. Verify the paths in the script match your environment.
3. In Intune, go to Devices... Manage Devices... Scripts and Remediations.
4. Tap Platform Scripts at the top.
5. Add a new Windows 10+ script.
6. Give it a name and click Next.
7. Upload the file. Set "Run this script using the logged on credentials" to "No" (so it then runs in the computer context, with full privs). Set "Enforce script signature check" to "No" (since this script is not signed). Set "Run script in 64 bit PowerShell Host" to "Yes" (assuming you are using 64-bit architecture). Click Next.
8. Assign to a test group. This must be a group of Devices, not Users. When you're happy it works, come back to the script and "Add all devices" instead. Click Next.
9. Click Add

You may now monitor deployment. For some reason, it shows as Failed for me, even though the script does what it needs to successfully. I have not looked further into this.
