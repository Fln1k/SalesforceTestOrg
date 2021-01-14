trigger SomeTestTrigger on Contact (before insert) {
    Integer recordCount = Trigger.New.size();
    EmailManager.sendMail('sergeitrigubovfleps@gmail.com', 'Trailhead Trigger before Contact insert', 
                    recordCount + ' contact(s) were inserted.');
}