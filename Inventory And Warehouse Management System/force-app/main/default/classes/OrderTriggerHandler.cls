public class OrderTriggerHandler {

    public static void populateWarehouse(List<Order__c> orderList) {
        Set<Id> productIds = new Set<Id>();
        for (Order__c order : orderList) {
            if (order.Product__c != null) {
                productIds.add(order.Product__c);
            }
        }
        Map<Id, Product__c> productMap = new Map<Id, Product__c>(
            [SELECT Id, Warehouse__c,Quantity_Available__c FROM Product__c WHERE Id IN :productIds]
        );
        for (Order__c order : orderList) {
            if (order.Product__c != null && productMap.containsKey(order.Product__c)) {
                Product__c product = productMap.get(order.Product__c);
                order.Warehouse__c = product.Warehouse__c;

               // check availability
               if (product.Quantity_Available__c > 0) {
                order.Status__c = 'Processing';                
               } else {
                order.Status__c = 'Pending';
               }
            }
        }
    }

    // //Shipment Status change
    // public static void updateorderListtatusToShipped(List<Shipment__c> shipments) {
    //     Set<Id> orderIds = new Set<Id>();
    //     for (Shipment__c shipment : shipments) {
    //         if (shipment.Order__c != null) {
    //             orderIds.add(shipment.Order__c);
    //         }
    //     }
        
    //     List<Order__c> orderListToUpdate = [SELECT Id, Status__c FROM Order__c WHERE Id IN :orderIds];
        
    //     for (Order__c order : orderListToUpdate) {
    //         order.Status__c = 'Shipped';
    //     }
        
    //     update orderListToUpdate;
    // }
}
