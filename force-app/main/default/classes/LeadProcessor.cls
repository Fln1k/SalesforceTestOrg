public with sharing class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    public Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID, LeadSource FROM Lead');
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> leads = new List<Lead>();
        for (Lead lead : scope) {
            lead.LeadSource = 'Dreamforce';
            leads.add(lead);
            recordsProcessed = recordsProcessed + 1;
        }
        update leads;
    }

    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        EmailManager.sendMail('sergeitrigubovfleps@gmail.com','Batch notification', recordsProcessed + ' records processed. Shazam!');
    }
}
