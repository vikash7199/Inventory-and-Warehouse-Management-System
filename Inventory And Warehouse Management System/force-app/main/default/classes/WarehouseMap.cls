public with sharing class WarehouseMap {
    @AuraEnabled(cacheable=true)
    public static List<Warehouse__c> getWarehouses() {
        return [SELECT Id, Name, Capacity__c, Latitude__c, Longitude__c, 
                       (SELECT Id, Quantity_in_Stock__c, Product__r.Name FROM Inventories__r) 
                FROM Warehouse__c];
    }
}