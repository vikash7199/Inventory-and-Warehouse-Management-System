public  class InventoryTriggerHandler {
    public static void  updateReorderStatusAndDate(List<Inventory__c> invList,Map<Id, Inventory__c> oldMap ){
        //update reorder status
        for (Inventory__c inv : invList) {
            Integer reorderThreshold = 10;
            if (inv.Quantity_in_Stock__c < reorderThreshold) {
                inv.Reorder_Status__c = 'Reorder Needed';
            }
            
            // When inventory is restocked, update the Last Restock Date and 
            //reset the Reorder Status.           
            else if (oldMap != null && oldMap.containsKey(inv.Id)) {
                Inventory__c oldInv = oldMap.get(inv.Id);
                if (inv.Quantity_in_Stock__c > oldInv.Quantity_in_Stock__c) {
                    inv.Last_Restock_Date__c = Date.today();
                    inv.Reorder_Status__c = 'Sufficient Stock';
                }
            }
        }
    } 
}