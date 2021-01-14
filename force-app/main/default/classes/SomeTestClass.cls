public class SomeTestClass {
    public String default_email = '';
    public String default_prefix = '';

    public SomeTestClass(String email, String prefix) {
        this.default_email = email;
        this.default_prefix = prefix;
    }

    public Account create_new_account()
    {
        Account acc = new Account(name=this.default_prefix+'_account');
        try{
            insert  acc;
            return acc;
        } catch (DmlException e) {
            System.debug(e.getMessage());
            return acc;
        }
    }

    public List<Contact> get_all_contacts(){
        return [SELECT Id, Name, Email FROM Contact];
    }

    public List<Contact> contact_factory(Integer num_of_contacts,String account_id)
    {
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 1; i<num_of_contacts; ++i)
        {
            contacts.Add(new Contact(
                Email = this.default_prefix+'_'+i+'@'+this.default_email,
                FirstName= this.default_prefix+' Joe',
                LastName= 'Smith '+i,
                AccountId= account_id
            ));
        }
        return contacts;
    }

    
    public void PrintEmails(List<Contact> contacts)
    {
        for(Contact contact: contacts)
        {
            System.debug(contact.Email);
        } 
    }
}

/*
SomeTestClass stc = new SomeTestClass('example.com','test');

stc.PrintEmails(stc.get_all_contacts());

Account acc = stc.create_new_account();
try{
    List<Contact> contacts = stc.contact_factory(1000,acc.id);
    insert  contacts;
} catch (DmlException e) {
    System.debug(e.getMessage());
}

delete [SELECT Id, Name
FROM Account
WHERE Name LIKE 'test%'];

delete [SELECT Id, Name
FROM Contact
WHERE Name LIKE 'test%'];
*/