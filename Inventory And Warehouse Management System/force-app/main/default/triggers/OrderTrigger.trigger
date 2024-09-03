
trigger OrderTrigger on Order__c (before insert, after insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            OrderTriggerHandler.populateWarehouse(Trigger.new);
        }
    }
}





