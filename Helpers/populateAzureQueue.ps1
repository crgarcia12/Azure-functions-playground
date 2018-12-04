function Get-Queue {
    param(
        $SubscriptionId = '930c11b0-5e6d-458f-b9e3-f3dda0734110',
        $StorageAccountName = 'funcpyqueue2storage',
        $QueueName = 'fibonaccicalculatorqueue'
    )

    Connect-AzureRmAccount
    Select-AzureRmSubscription -SubscriptionId $SubscriptionId
    $sa = Get-AzureRmStorageAccount
    $sa = $sa | ? {$_.StorageAccountName -eq $StorageAccountName}
    $context = $sa.Context
    $queue = Get-AzureStorageQueue -Name $QueueName -Context $context
    return $queue
}

function Push-QueueMessages {
    param(
        $Queue,
        $NumberOfMessages
    )
    1..$NumberOfMessages | % { 
        $date = [DateTime]::UtcNow.ToString('yyyy-MM-dd HH:mm:ss')
        $Queue.CloudQueue.AddMessage($date) 
    }
}

