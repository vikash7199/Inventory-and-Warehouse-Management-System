@isTest
public class OrderTriggerHandlerTest {

    @testSetup
    static void setupData() {
        // Create a Warehouse
        Warehouse__c warehouse = new Warehouse__c();
        warehouse.Name = 'Test Warehouse';
        insert warehouse;

        // Create Products with associated warehouse
        List<Product__c> products = new List<Product__c>();
        for (Integer i = 0; i < 10; i++) {
            Product__c prd = new Product__c();
            prd.Name = 'Product ' + i;
            prd.Warehouse__c = warehouse.Id;
            products.add(prd);
        }
        insert products;
        
        // Create Orders without Warehouse__c and Status__c
        List<Order__c> orders = new List<Order__c>();
        for (Product__c product : products) {
                Order__c ord = new Order__c();
                ord.Product__c = product.Id ; 
                orders.add(ord);         
        }
        insert orders;
    }

    @isTest
    static void testPopulateWarehouse() {
        // Retrieve the Orders
        List<Order__c> orders = [SELECT Id, Product__c, Warehouse__c, Status__c FROM Order__c];

        Test.startTest();
        OrderTriggerHandler.populateWarehouse(orders);
        Test.stopTest();

        // Verify
        for (Order__c order : orders) {
            Product__c product = [SELECT Quantity_Available__c FROM Product__c WHERE Id = :order.Product__c];
            if (product.Quantity_Available__c > 0) {
                System.assertEquals('Processing', order.Status__c, ' Quantity is greater than 0 then Processing for available products');
            } else {
                System.assertEquals('Pending', order.Status__c, 'Quantity is 0 then,it is  Pending for unavailable products');
            }
        }
    }
}