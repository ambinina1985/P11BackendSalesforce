/*
----------------------------------------------------------------------
-- - Author        : AAN
-- - Description   : Classe de test pour le batch apex BATasksForAccount
--                   et la classe permettant de la scheduler BATasksForAccountSchedule
--                   
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  ---------------------------------------
-- 30-JUL-2019  AAN   1.0      Version Initial
----------------------------------------------------------------------
*/
@isTest
private class BATasksForAccount_Test{
  //Method pour le schedule
  @isTest
  static void BATasksForAccountSchedule_test(){
    
    BATasksForAccountSchedule mySchedule = new BATasksForAccountSchedule();
    System.schedule('BATasksForAccountSchedule', '0 0 0 * * ?',mySchedule );

  }

  //methode pour le batch apex
  @isTest
  static void BATasksForAccount_test(){

    Account a = new Account ( Name='test');
    insert a;
    
    BATasksForAccount mybatch = new BATasksForAccount();
    Database.executeBatch(mybatch,200);

  }
  
}