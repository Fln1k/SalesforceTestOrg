public with sharing class SecurityFLSCheck {
    private static Map<Operation, Map<SObjectType,List<String>>> cachedRestrictedFields = new Map<Operation, Map<SObjectType,List<String>>>();
    private static Set<String> exceptionValues = new Set<String>{
        'id',
        'isdeleated',
        'createddate',
        'systemmodstamp',
        'lastmodyfiedbyid',
        'createdbyid',
        'lastmodifieddate'
    };
    public SecurityFLSCheck() {

    }

    private static void ensureResrtictedFields(Sobject obj, Operation dmlOperation){
        Map<SObjectType,List<String>> operationRestrictedFields = cachedRestrictedFields.get(dmlOperation);
        if(operationRestrictedFields == null){
            operationRestrictedFields = new Map<SObjectType,List<String>>();
            cachedRestrictedFields.put(dmlOperation,operationRestrictedFields);
        }

        if(!operationRestrictedFields.containsKey(obj.getSObjectType())){
            DescribeSObjectResult describeObject = obj.getSObjectType().getDescribe();
            Map<String, Schema.SObjectField> objectFields = describeObject.fields.getMap();
            List<String> restrictedFields = new List<String>();

            for(String field: objectFields.keyset()){
                if(!exceptionValues.contains(field.toLowerCase())){
                    DescribeSObjectResult fieldDescribe = objectFields.get(field).getDescribe();
                    if(
                        !fieldDescribe.isCalculated() && (
                            (dmlOperation == Operation.DML_INSERT && !describeObject.isCreateable()) ||
                            (dmlOperation == Operation.DML_UPDATE && !describeObject.isUpdateable())
                            )
                        )
                        {
                            restrictedFields.add(fieldDescribe.getName());
                        }
                    )
                }
            }
        }
        operationRestrictedFields.put(obj.getSObjectType(), restrictedFields);
    }

    private static void checkAction (Sobject obj, Operation dmlOperation){
        List<String> restrictedFields = cachedRestrictedFields.get(dmlOperation).get(obj.getSObjectType());
        if(restrictedFields == null || restrictedFields.isEmpty()){
            return;
        }

        Map<String,Object> fieldsMap = getFieldMapFromExistingSobject(obj);
        for(String fieldName : restrictedFields){
            if(fieldsMap.get(fieldName) != null) {
                throw new FLSExeption(
                    obj.getSObjectType(),
                    obj.getSObjectType().getDescribe().fields.getMap().get(fieldName), dmlOperation
                );
            }
        }
    }

    private static Map<String,Object> getFieldFromExistingSObject(SObject obj){
        return obj.getPopulatedFiedsAsMap();
    }
}
