global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [Select Id, LeadSource from Lead where LeadSource = null];
        
        if(!leads.isEmpty()) {
			for(Lead lead: leads) {
				lead.LeadSource = 'Dreamforce';
			}
			update leads;
		}
    }
}