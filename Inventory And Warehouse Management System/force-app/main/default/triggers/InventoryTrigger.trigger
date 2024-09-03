trigger InventoryTrigger on Inventory__c (before insert,after insert,before update,after update) {
    if (trigger.isInsert) {
        if(trigger.isBefore ){
            InventoryTriggerHandler.updateReorderStatusAndDate(Trigger.new, Trigger.oldMap);
        }
    }
    if (trigger.isUpdate) {
        if(trigger.isBefore){
            InventoryTriggerHandler.updateReorderStatusAndDate(Trigger.new, Trigger.oldMap);      
        }    
    }  
}   
