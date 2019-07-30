/*
----------------------------------------------------------------------
-- - Author        : AAN
-- - Description   : Trigger avec déclencheur sur la suppression d un Order
--                   Récupère les accounts liés aux order supprimés
--                   
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  ---------------------------------------
-- 30-JUL-2019  AAN   1.0      Version Initial
----------------------------------------------------------------------
*/

trigger OrderBeforeDelete on Order (before delete) {

    Set<Id> SId = new Set<Id>();
    for (Order o:trigger.old){   
        sId.add(o.AccountId);        
    }
    
    if(SId.size()>0)
        TROrder.InactivateAccount(SId);
}