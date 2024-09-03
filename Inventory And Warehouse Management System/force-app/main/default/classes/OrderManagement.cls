public  class OrderManagement {

    @AuraEnabled(cacheable=true)
    public static List<Order__c> getOrderData() {
        return [SELECT Id, Name , Customer_Name__r.Name , Order_Date__c , Total_Amount__c ,Status__c,
                (SELECT Id, Shipment_Status__c FROM Shipments__r)               
                FROM Order__c];
    }
}