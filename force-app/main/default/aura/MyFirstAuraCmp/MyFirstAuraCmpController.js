({
    myAction : function(component, event, helper) {},
    handleNewClick : function(component, event, helper) {
        helper.LogInConsole("new clicked")
        helper.ChangeText(component,"new clciked")
    },
    handleCancelClick : function(component, event, helper) {
        helper.LogInConsole("cancel clicked")
        helper.ChangeText(component, "cancel clicked")
    },
    handleCloseClick : function(component, event, helper) {
        helper.LogInConsole("edit clicked")
        helper.ChangeText(component,"edit clicked")
    },
    init : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Contact Name', fieldName: "Name", type: "text"},
            {label: 'Phone', fieldName: "Phone", type: "phone"},
            {label: 'Email', fieldName: "Email", type: "email"}
        ]);
        helper.getData(component)
    }
})