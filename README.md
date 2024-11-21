# Summary
Why does this exist?

Many organisations use Intune or Group Policies to disable Macros in the Office suite, as they present security risks.

Adobe Acrobat seems to rely on Macros in some way for their PDFMaker add-in that comes with Acrobat to function. Often, this means that users opening documents with the add-in activated will be prompted over and over again about macros.

This Powershell script can be deployed with Intune or GP to restrict permissions to the Add-In folder that Adobe use, so that the SYSTEM user can still read/write (for upgrades), but no other users (so the add-in cannot activate). Others have tried renaming the folders, but the folders come back after repair/upgrade. This fixes that problem.
