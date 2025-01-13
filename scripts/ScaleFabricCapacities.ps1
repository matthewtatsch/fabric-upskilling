#Requires -Module Az.Fabric

$resourceGroupName = "FabricUpskillingRG"

$sku = "F4" # Set the SKU to scale up or down to

# Define an array of Fabric Capacity names
$fabricCapacities = @(
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

# Loop through each capacity and call the Update-AzFabricCapacity command to scale the capacity
foreach ($capacity in $fabricCapacities) {
    Update-AzFabricCapacity -CapacityName $capacity -ResourceGroupName $resourceGroupName -SkuName $sku
    Write-Output "Scaled capacity: $capacity to SKU: $sku"
}