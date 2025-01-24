#Requires -Module Az.Fabric

$resourceGroupName = "FabricUpskillingRG"

# Define an array of Fabric Capacity names
$fabricCapacities = @(
    "adminfabcc",
    "student01fabcc",
    "student02fabcc",
    "student03fabcc",
    "student04fabcc",
    "student05fabcc",
    "student06fabcc",
    "student07fabcc",
    "student08fabcc",
    "student09fabcc",
    "student10fabcc",
    "student11fabcc",
    "student12fabcc",
    "student13fabcc",
    "student14fabcc",
    "student15fabcc"
)

# Loop through each capacity and call the Suspend-AzFabricCapacity command to pause the capacity
foreach ($capacity in $fabricCapacities) {
    Suspend-AzFabricCapacity -CapacityName $capacity -ResourceGroupName $resourceGroupName
    Write-Output "Paused capacity: $capacity"
}