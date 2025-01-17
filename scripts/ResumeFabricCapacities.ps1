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
    "student14fabcc"
)

# Loop through each capacity and call the Resume-AzFabricCapacity command to resume the capacity
foreach ($capacity in $fabricCapacities) {
    Resume-AzFabricCapacity -CapacityName $capacity -ResourceGroupName $resourceGroupName
    Write-Output "Resumed capacity: $capacity"
}