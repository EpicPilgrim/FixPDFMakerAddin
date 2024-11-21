# Change to relevant directory
cd "c:\Program Files\Adobe\Acrobat DC\PDFMaker"

### OFFICE SUBFOLDER
# Fix any broken permissions
icacls Office /t /q /c /reset

# Recursively change owner first before we remove all permissions
Set-OwnershipRecursive -path "Office" -owner "Administrators"

# Now add SYSTEM as only user that can read/write
$ACL = Get-ACL -Path "Office"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("SYSTEM","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path "Office"

# Remove all permissions and inheritance from folder
$ACL = Get-Acl -Path "Office"
$ACL.SetAccessRuleProtection($true,$false)
$ACL | Set-Acl -Path "Office"

### MAIL SUBFOLDER
# Fix any broken permissions
icacls Mail /t /q /c /reset

# Recursively change owner first before we remove all permissions
Set-OwnershipRecursive -path "Mail" -owner "Administrators"

# Now add SYSTEM as only user that can read/write
$ACL = Get-ACL -Path "Mail"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("SYSTEM","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path "Mail"

# Remove all permissions and inheritance from folder
$ACL = Get-Acl -Path "Mail"
$ACL.SetAccessRuleProtection($true,$false)
$ACL | Set-Acl -Path "Mail"

# Function to recursively set ownership
function Set-OwnershipRecursive {
    param (
        [string]$path,
        [string]$owner
    )

    # Get ACL and set the owner for the current item
    $ACL = Get-Acl -Path $path
    $User = New-Object System.Security.Principal.Ntaccount($owner)
    $ACL.SetOwner($User)
    Set-Acl -Path $path -AclObject $ACL

    # If the item is a directory, recurse into its contents
    if ((Get-Item $path).PSIsContainer) {
        Get-ChildItem -Path $path -Recurse | ForEach-Object {
            try {
                # Apply ownership to each item
                $itemACL = Get-Acl -Path $_.FullName
                $itemACL.SetOwner($User)
                Set-Acl -Path $_.FullName -AclObject $itemACL
            } catch {
                Write-Host "Failed to set owner on $_.FullName: $_" -ForegroundColor Red
            }
        }
    }
}