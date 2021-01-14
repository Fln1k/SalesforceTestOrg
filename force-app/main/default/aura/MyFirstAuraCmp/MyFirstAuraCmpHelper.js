({
    helperMethod : function() {    },
    LogInConsole : function(text) { 
        console.log("--------------------")
        console.log(text)
        console.log("--------------------")
        },
    ChangeText : function(component,text) {
        component.set("v.TestVar",text)
    },
    getData : function(component){
        var action = component.get('c.getContacts');

        action.setCallback(this, $A.getCallback(function (response){
            var state = response.getState();
            if (state === "SUCCESS"){
                component.set('v.mydata', JSON.parse(response.getReturnValue()));
            } else if (state === "Error") {
                var errors = response.getError();
                console.error(errors)
            }
        }));
        $A.enqueueAction(action);
    }
})