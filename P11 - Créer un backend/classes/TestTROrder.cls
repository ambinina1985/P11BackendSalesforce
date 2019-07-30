/*
----------------------------------------------------------------------
-- - Author        : AAN
-- - Description   : Classe de test couvrant la classe apex TROrder
--                   avec les deux trigger OrderBeforeUpdate et
--                   OrderBeforeDelete
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  ---------------------------------------
-- 30-JUL-2019  AAN   1.0      Version Initial
----------------------------------------------------------------------
*/

@isTest
private class TestTROrder {
    
    static testMethod void test(){
        Account a = new Account(Name='test',actif__c = true);
        insert a;
        
        Order o = new Order (AccountId = a.Id, EffectiveDate= System.today(),Status='Draft');
        insert o;
        
        o.status='Active';
        try{
			//couvre le trigger OrderBeforeUpdate
            update o;
        }catch(exception e){
            System.assert(e.getMessage().contains('VALIDATION'));
        }
		//couvre le trigger OrderBeforeDelete
        delete o;
    }
}