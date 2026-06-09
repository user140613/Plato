(define (domain shared_production_domain)
   (:requirements :negative-preconditions :numeric-fluents :typing)
   (:types
      Boolean - root
      Camera - Machine
      Factory - root
      Machine - root
      Material - root
      Printer - Machine
      Robot - Machine
      Warehouse - Machine
      Workpiece - root
      root - object
   )
   (:constants
      ABS - Material
      CameraKL - Camera
      CameraLemgo - Camera
      CustomerLocation - Warehouse
      PLA - Material
      PrusaKL - Printer
      PrusaLemgo - Printer
      SmartFactoryKL - Factory
      SmartFactoryOWL - Factory
      UR5eKL - Robot
      UR5eLemgo - Robot
      WarehouseKL - Warehouse
      WarehouseLemgo - Warehouse
   )
   (:predicates
      (At ?Workpiece - Workpiece ?Machine - Machine)
      (CanPrint ?Machine - Printer ?Material - Material)
      (CanTransportBetween ?Robot - Robot ?Machine - Machine ?Machine2 - Machine)
      (InFactory ?Machine - Machine ?Factory - Factory)
      (IsAvailable ?Factory - Factory)
      (IsMadeOf ?Workpiece - Workpiece ?Material - Material)
      (IsPrinted ?Workpiece - Workpiece)
      (IsReady ?Machine - Machine)
      (QualityChecked ?Workpiece - Workpiece)
   )
   (:functions
      (CO2Efficiency ?Factory - Factory)
      (CO2EfficiencyWeight)
      (CostEfficiency ?Factory - Factory)
      (CostEfficiencyWeight)
      (DeliveryCostWeight)
      (DeliveryDelayCost)
      (DeliveryTimeWeight)
      (Distance ?Warehouse - Warehouse ?Warehouse2 - Warehouse)
      (total-cost)
   )
   (:action Check_Workpiece_Quality
      :parameters (?Factory - Factory ?Workpiece - Workpiece ?Camera - Camera)
      :precondition (and
         (At ?Workpiece ?Camera)
         (IsAvailable ?Factory)
         (IsReady ?Camera)
         (InFactory ?Camera ?Factory)
      )
      :effect (and
         (QualityChecked ?Workpiece)
         (increase (total-cost) (* (CostEfficiency ?Factory) (CostEfficiencyWeight)))
         (increase (total-cost) (* (CO2Efficiency ?Factory) (CO2EfficiencyWeight)))
      )
   )
   (:action Print_Workpiece
      :parameters (?Factory - Factory ?Workpiece - Workpiece ?Machine - Printer ?Material - Material)
      :precondition (and
         (CanPrint ?Machine ?Material)
         (IsAvailable ?Factory)
         (IsReady ?Machine)
         (not
            (IsPrinted ?Workpiece)
         )
         (InFactory ?Machine ?Factory)
      )
      :effect (and
         (At ?Workpiece ?Machine)
         (IsMadeOf ?Workpiece ?Material)
         (IsPrinted ?Workpiece)
         (increase (total-cost) (* (CO2Efficiency ?Factory) (CO2EfficiencyWeight)))
         (increase (total-cost) (* (CostEfficiency ?Factory) (CostEfficiencyWeight)))
      )
   )
   (:action Transport_Workpiece
      :parameters (?Factory - Factory ?Workpiece - Workpiece ?Machine - Machine ?Machine2 - Machine ?Robot - Robot)
      :precondition (and
         (At ?Workpiece ?Machine)
         (CanTransportBetween ?Robot ?Machine ?Machine2)
         (InFactory ?Machine ?Factory)
         (InFactory ?Machine2 ?Factory)
         (InFactory ?Robot ?Factory)
         (IsAvailable ?Factory)
         (IsPrinted ?Workpiece)
         (IsReady ?Robot)
      )
      :effect (and
         (At ?Workpiece ?Machine2)
         (not
            (At ?Workpiece ?Machine)
         )
         (increase (total-cost) (* (CostEfficiency ?Factory) (CostEfficiencyWeight)))
         (increase (total-cost) (* (CO2Efficiency ?Factory) (CO2EfficiencyWeight)))
      )
   )
   (:action Transport_Workpiece_Between_Warehouses
      :parameters (?Workpiece - Workpiece ?Warehouse - Warehouse ?Warehouse2 - Warehouse)
      :precondition (and
         (At ?Workpiece ?Warehouse)
      )
      :effect (and
         (At ?Workpiece ?Warehouse2)
         (not
            (At ?Workpiece ?Warehouse)
         )
         (increase (total-cost) (* (DeliveryCostWeight) (Distance ?Warehouse ?Warehouse2)))
      )
   )
   (:action Wait_For_Factory_Availability
      :parameters ()
      :precondition (and
      )
      :effect (and
         (forall (?Factory - Factory)
            (IsAvailable ?Factory)
         )
         (increase (total-cost) (* (DeliveryTimeWeight) (DeliveryDelayCost)))
      )
   )


)