(define (domain shared_production_domain)
   (:requirements :action-costs :negative-preconditions :typing)
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
      (Check_Workpiece_Quality_Cost_0 ?Factory - Factory ?Workpiece - Workpiece ?Camera - Camera)
      (Check_Workpiece_Quality_Cost_1 ?Factory - Factory ?Workpiece - Workpiece ?Camera - Camera)
      (CO2Efficiency ?Factory - Factory)
      (CO2EfficiencyWeight)
      (CostEfficiency ?Factory - Factory)
      (CostEfficiencyWeight)
      (DeliveryCostWeight)
      (DeliveryDelayCost)
      (DeliveryTimeWeight)
      (Distance ?Warehouse - Warehouse ?Warehouse2 - Warehouse)
      (Print_Workpiece_Cost_0 ?Factory - Factory ?Workpiece - Workpiece ?Machine - Printer ?Material - Material)
      (Print_Workpiece_Cost_1 ?Factory - Factory ?Workpiece - Workpiece ?Machine - Printer ?Material - Material)
      (total-cost)
      (Transport_Workpiece_Between_Warehouses_Cost_0 ?Workpiece - Workpiece ?Warehouse - Warehouse ?Warehouse2 - Warehouse)
      (Transport_Workpiece_Cost_0 ?Factory - Factory ?Workpiece - Workpiece ?Machine - Machine ?Machine2 - Machine ?Robot - Robot)
      (Transport_Workpiece_Cost_1 ?Factory - Factory ?Workpiece - Workpiece ?Machine - Machine ?Machine2 - Machine ?Robot - Robot)
      (Wait_For_Factory_Availability_Cost_0)
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
         (increase (total-cost) (Check_Workpiece_Quality_Cost_0 ?Factory ?Workpiece ?Camera))
         (increase (total-cost) (Check_Workpiece_Quality_Cost_1 ?Factory ?Workpiece ?Camera))
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
         (increase (total-cost) (Print_Workpiece_Cost_0 ?Factory ?Workpiece ?Machine ?Material))
         (increase (total-cost) (Print_Workpiece_Cost_1 ?Factory ?Workpiece ?Machine ?Material))
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
         (increase (total-cost) (Transport_Workpiece_Cost_0 ?Factory ?Workpiece ?Machine ?Machine2 ?Robot))
         (increase (total-cost) (Transport_Workpiece_Cost_1 ?Factory ?Workpiece ?Machine ?Machine2 ?Robot))
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
         (increase (total-cost) (Transport_Workpiece_Between_Warehouses_Cost_0 ?Workpiece ?Warehouse ?Warehouse2))
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
         (increase (total-cost) (Wait_For_Factory_Availability_Cost_0))
      )
   )


)