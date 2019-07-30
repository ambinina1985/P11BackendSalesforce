/*
----------------------------------------------------------------------
-- - Author        : AAN
-- - Description   : Batch récupérant tous les comptes n'ayant pas 
--                   d'order pour créer une tâche de rappel s'il n'en
--                   existe pas déjà
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  ---------------------------------------
-- 30-JUL-2019  AAN   1.0      Version Initial
----------------------------------------------------------------------
*/

global with sharing class BATasksForAccount implements Database.Batchable<sObject>,  Database.Stateful  {

    global String Query;
    
    global BATasksForAccount (){
			//Récupération de tous les comptes n'ayant pas d'oder avec les tâches "Rappel"
            query = 'Select id,OwnerId,(select Id from tasks where type =\'Appel\') from account where id not in (select AccountId from Order)';     
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
       
        List<Task> l = new List<Task>();
        for(Account a : scope){  
			//Si le compte ne possède pas de tâche "Rappel", il faut lui en créer une
            if ( a.tasks.size() == 0){
                l.add(new Task(type='Appel',whatId=a.Id,Status='Nouvelle',Priority='Normale',ReminderDateTime = System.today()+5),OwnerId=a.OwnerId);
            }       
        }
        
        insert l;
        
    }
    
    
    
    global void finish(Database.BatchableContext BC){
       
    }