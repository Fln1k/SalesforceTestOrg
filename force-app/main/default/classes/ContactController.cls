public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            //throw new AuraHandledException('Forced error');
            return [SELECT Id, FirstName, LastName, Email FROM Contact WITH SECURITY_ENFORCED];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
