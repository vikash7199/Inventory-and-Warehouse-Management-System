@isTest
public class InventoryTriggerHandlerTest {
    @isTest
    static void testUpdateReorderStatusAndDate() {
        List<Product__c> productList = new List<Product__c>();
        Product__c prod1 = new Product__c();
        prod1.Name = 'Test Product 1';
        prod1.Reorder_Level__c = 20;

        Product__c prod2 = new Product__c();
        prod2.Name = 'Test Product 2';
        prod2.Reorder_Level__c = 15;

        productList.add(prod1);
        productList.add(prod2); 
        insert productList;
        
        List<Warehouse__c>warehouseList = new List<Warehouse__c>();
        Warehouse__c ware1 = new Warehouse__c();
        ware1.Name = 'warehouse 1';

        Warehouse__c ware2 = new Warehouse__c();
        ware2.Name = 'warehouse 2';
        warehouseList.add(ware1);
        warehouseList.add(ware2);
        insert warehouseList;
        
        List<Inventory__c> invList = new List<Inventory__c>();
        Inventory__c inv1 = new Inventory__c();
        inv1.Product__c = prod1.Id;
        inv1.Warehouse__c = ware1.Id;
        inv1.Quantity_in_Stock__c = 5;

        Inventory__c inv2 = new Inventory__c();
        inv2.Product__c = prod2.Id;
        inv2.Warehouse__c = ware2.Id;
        inv2.Quantity_in_Stock__c = 25;
        invList.add(inv1);
        invList.add(inv2);
        insert invList;
        
        //Threshold value 
        Integer reorderThreshold = 10;
        
        //update Quantity
        inv1.Quantity_in_Stock__c = 15; 
        inv2.Quantity_in_Stock__c = 9;       
        update invList;
        // Query
        Inventory__c updatedInv1 = [SELECT Reorder_Status__c, Last_Restock_Date__c 
                                    FROM Inventory__c 
                                    WHERE Id = :inv1.Id];
        Inventory__c updatedInv2 = [SELECT Reorder_Status__c, Last_Restock_Date__c 
                                    FROM Inventory__c 
                                    WHERE Id = :inv2.Id];

        // Verify results
        System.assertEquals('Sufficient Stock', updatedInv1.Reorder_Status__c, ' status should be updated to "Sufficient Stock"');       
        System.assertEquals('Reorder Needed', updatedInv2.Reorder_Status__c, ' status should be updated to "Reorder Needed"');
    }
}