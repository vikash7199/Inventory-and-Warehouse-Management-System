public  class InventoryDashboard {
    @AuraEnabled(cacheable=true)
    public static List<Inventory__c> getInventoryData() {
        return [SELECT Id, Product__r.Name, Warehouse__r.Name, Quantity_in_Stock__c,Name, Reorder_Status__c
                FROM Inventory__c];
          
    }
}