@isTest
public with sharing class LeadProcessorTest {
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(lastname='11'+i, company='11'+i));
        }
        insert leads;
    }
    @isTest static void test() {
        Test.startTest();
        LeadProcessor LeadP = new LeadProcessor();
        Database.executeBatch(LeadP);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from lead where LeadSource = 'Dreamforce']);
    }
}