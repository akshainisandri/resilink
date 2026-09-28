using { resilink as db } from '../db/schema';

service ResilinkService @(path: '/odata/v4/resilink') {
  
  entity Nodes as projection on db.Nodes;
  entity Disruptions as projection on db.Disruptions;
  entity Scenarios as projection on db.Scenarios;
  entity AuditLogs as projection on db.AuditLogs;
  entity ResilienceRuns as projection on db.ResilienceRuns;

  // BUILD Module Projections
  entity NetworkDesigns as projection on db.NetworkDesigns;
  entity DesignSuppliers as projection on db.DesignSuppliers;
  entity DesignPlants as projection on db.DesignPlants;
  entity DesignWarehouses as projection on db.DesignWarehouses;
  entity DesignRoutes as projection on db.DesignRoutes;
  entity DesignMarkets as projection on db.DesignMarkets;
  entity DesignScenarios as projection on db.DesignScenarios;
  entity AIRecommendations as projection on db.AIRecommendations;

  /**
   * Action: saveNetworkDesign
   * Commits the AI-optimized network design as operational baseline in SAP HANA Cloud
   */
  action saveNetworkDesign(
    productName       : String,
    demandVolume      : Integer,
    targetMarkets     : String,
    budget            : Decimal(12,2),
    scenarioId        : String,
    supplierSelection : String,
    productionPlant   : String,
    distributionHub   : String,
    routeCorridor     : String,
    resilienceScore   : Decimal(5,2)
  ) returns {
    status            : String;
    baselineId        : String;
    message           : String;
    handoffStatus     : String;
    timestamp         : String;
  };

  /**
   * Action: executeRecoveryPlan
   * Dispatched by VP Pia or autonomous agents to execute recovery in SAP S/4HANA & HANA Cloud
   * All parameters explicitly typed to satisfy SAP CAP OData v4 strict validation
   */
  action executeRecoveryPlan(
    scenarioId         : String,
    recoveryType       : String,
    originPlant        : String,
    targetPlant        : String,
    volumeUnits        : Integer,
    carrier            : String,
    expressCarrier     : String,
    sapTransactionType : String,
    executedBy         : String,
    timestamp          : String
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
   * Action: resetSimulation
   * Resets nodes and disruptions back to initial critical state for demo purposes
   */
  action resetSimulation() returns String;
}

