/*
----------------------------------------------------------------------
-- - Author        : AAN
-- - Description   : Classe Apex gérant les modifications sur les oder
--                   
--                   
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  ---------------------------------------
-- 30-JUL-2019  AAN   1.0      Version Initial
----------------------------------------------------------------------
*/


public with sharing class TROrder{


	/*
	**                   Méthode appelée par le trigger OrderBeforeUpdate
	**                   pour afficher une erreur si un order passe à Actif
	**                   alors que l'order ne possède pas d'Order Item
	*/
    public static void CheckOrder(List<Order> l){
    
    map<Id,Order> morder = new map<Id,Order>([select Id,(select Id from orderitems limit 1) from order where Id in:l]);
    
        for (Order o:l){
            if (morder.get(o.Id).OrderItems.size()==0){
                    o.addError('test');               
            }
        }
    }
    
	
	/*
	**                   Méthode appelée par le trigger OrderBeforeDelete
	**                   pour mettre à jour la case "Active" du compte à faux
	**                   lors qu'il n'y a plus d'order sur le compte
	*/
    public static void InactivateAccount(Set<Id> l){
        
        List<Account> lacc = [select Id, (select Id from orders) from account where Id in:l];
        for (Account a:lacc){
            if (a.orders.size() ==0)
                a.active__c = false;
        }    
        
        update lacc;
    }
}