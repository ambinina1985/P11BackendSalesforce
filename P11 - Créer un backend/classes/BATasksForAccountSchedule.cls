/*
----------------------------------------------------------------------
-- - Author        : AAN
-- - Description   : Classe permettant le schedule de la classe apex 
--                   BATasksForAccount en traitant les enregistrements
--                   par paquet de 200 enregistrements
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  ---------------------------------------
-- 30-JUL-2019  AAN   1.0      Version Initial
----------------------------------------------------------------------
*/
global class BATasksForAccountSchedule implements Schedulable {
  
  public BATasksForAccountSchedule(){
  }

  global void execute(SchedulableContext sc) { 
     BATasksForAccount b = new BATasksForAccount();       
     Database.executeBatch(b,200); 
  }  
}