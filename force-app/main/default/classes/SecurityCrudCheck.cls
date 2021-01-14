public with sharing class SecurityCrudCheck {
    public SecurityCrudCheck() {

    }

    public CheckCrud(Set<SObjectType> objectTypes, Operation dmlOperation){
        for (SObjectType typeItem: objectTypes) {
            DescribeSObjectResult describeObject = typeItem.getDescribe();
            if(
                (dmlOperation == Operation.DML_INSERT && !describeObject.isCreateable()) ||
                (dmlOperation == Operation.DML_UPDATE && !describeObject.isUpdateable()) ||
                (dmlOperation == Operation.DML_DELETE && !describeObject.isDeleatable()) ||
                (dmlOperation == Operation.DML_UPSERT && !describeObject.isCreateable() && describeObject.isUpdateable()))
            ){
                throw new CRUDException(typeItem, dmlOperation);
            }
        }
    }
}
