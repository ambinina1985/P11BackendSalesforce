/*
----------------------------------------------------------------------
-- - Author        : AAN
-- - Description   : Trigger avec déclencheur sur la modification
--                   et passage du statut de l order à Actif
--                   
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  ---------------------------------------
-- 30-JUL-2019  AAN   1.0      Version Initial
----------------------------------------------------------------------
*/

trigger OrderBeforeUpdate on Order (before update) {

    List<Order> lorder = new List<Order>();
    for (Order o:trigger.new){
    
        if(o.status!= trigger.oldmap.get(o.Id).status && o.status =='Actif')
            lorder.add(o);
        
    }
    
    if(lorder.size()>0)
        TROrder.CheckOrder(lorder);
}
