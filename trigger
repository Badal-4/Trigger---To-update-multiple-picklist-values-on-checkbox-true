trigger trg1 on Account(before Insert)
{
    if(trigger.isBefore && trigger.isInsert)
    {
     
      for (Account obj : Trigger.new) 
      {  
        if (obj.Test_Checkbox__c  == true && obj.Multi_Picklist_Field__c == null) 
        {
            Schema.DescribeSObjectResult objSchema = Account.sObjectType.getDescribe();
            Map<String, Schema.SObjectField> fieldMap = objSchema.fields.getmap();
            List<Schema.Picklistentry>fld =fieldmap.get('Multi_Picklist_Field__c').getDescribe().getpicklistValues();     
            List<String> pickList = new List<String>();
        
            for(Schema.Picklistentry pl : fld)
            {
                System.debug('Picklist Values-->'+pl);
                
                pickList.add(pl.getLabel());
            }
              
            
                obj.Multi_Picklist_Field__c = String.join(pickList,';');
            /*for (String value : pickList) 
            {
               //obj.Multi_Picklist_Field__c += value+';';
               //obj.Multi_Picklist_Field__c =     String.join(value, '";"');
            }*/
            
        }
      }
    }
}
