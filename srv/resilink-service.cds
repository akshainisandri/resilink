using { resilink as db } from '../db/schema';

service ResilinkService @(path: '/odata/v4/resilink') {
  
  entity Nodes as projection on db.Nodes;
  entity Disruptions as projection on db.Disruptions;
  entity Scenarios as projection on db.Scenarios;
  entity AuditLogs as projection on db.AuditLogs;
  entity ResilienceRuns as projection on db.ResilienceRuns;

  /**
   * Action: executeRecoveryPlan
   * Dispatched by VP Pia or autonomous agents to execute recovery in SAP S/4HANA & HANA Cloud
   */
  action executeRecoveryPlan(
    scenarioId   : String,
    targetPlant  : String,
    volumeUnits  : Integer,
    carrier      : String
  ) returns {
    status              : String;
    transactionId       : String;
    reallocatedCapacity : Integer;
    targetPlant         : String;
    projectedSLA        : Decimal(5,2);
    message             : String;
    vectorEmbeddingId   : String;
  };

  /**
   * Function: resetSimulation
   * Resets nodes and disruptions back to initial critical state for demo purposes
   */
  action resetSimulation() returns String;
}
