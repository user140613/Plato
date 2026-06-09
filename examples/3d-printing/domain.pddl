(define (domain printing_domain)
   (:requirements :negative-preconditions :numeric-fluents :typing)
   (:types
      Boolean - root
      Material - root
      Minutes - root
      Printer - ProductionMachine
      PrintingMaterial - Material
      PrintingService - ProductionService
      PrintingWorkpiece - Workpiece
      ProductionMachine - root
      ProductionService - root
      Temperature - root
      Workpiece - root
      root - object
   )
   (:constants
      ABS - PrintingMaterial
      AnetA8v2 - Printer
      EstimatedPrintTime_120 - Minutes
      EstimatedPrintTime_150 - Minutes
      EstimatedPrintTime_180 - Minutes
      EstimatedPrintTime_210 - Minutes
      EstimatedPrintTime_240 - Minutes
      EstimatedPrintTime_270 - Minutes
      EstimatedPrintTime_30 - Minutes
      EstimatedPrintTime_300 - Minutes
      EstimatedPrintTime_330 - Minutes
      EstimatedPrintTime_360 - Minutes
      EstimatedPrintTime_390 - Minutes
      EstimatedPrintTime_420 - Minutes
      EstimatedPrintTime_450 - Minutes
      EstimatedPrintTime_480 - Minutes
      EstimatedPrintTime_510 - Minutes
      EstimatedPrintTime_540 - Minutes
      EstimatedPrintTime_570 - Minutes
      EstimatedPrintTime_60 - Minutes
      EstimatedPrintTime_600 - Minutes
      EstimatedPrintTime_630 - Minutes
      EstimatedPrintTime_660 - Minutes
      EstimatedPrintTime_690 - Minutes
      EstimatedPrintTime_720 - Minutes
      EstimatedPrintTime_750 - Minutes
      EstimatedPrintTime_780 - Minutes
      EstimatedPrintTime_810 - Minutes
      EstimatedPrintTime_840 - Minutes
      EstimatedPrintTime_870 - Minutes
      EstimatedPrintTime_90 - Minutes
      EstimatedPrintTime_900 - Minutes
      NozzleTemperature_0 - Temperature
      NozzleTemperature_10 - Temperature
      NozzleTemperature_100 - Temperature
      NozzleTemperature_110 - Temperature
      NozzleTemperature_120 - Temperature
      NozzleTemperature_130 - Temperature
      NozzleTemperature_140 - Temperature
      NozzleTemperature_150 - Temperature
      NozzleTemperature_160 - Temperature
      NozzleTemperature_170 - Temperature
      NozzleTemperature_180 - Temperature
      NozzleTemperature_190 - Temperature
      NozzleTemperature_20 - Temperature
      NozzleTemperature_200 - Temperature
      NozzleTemperature_210 - Temperature
      NozzleTemperature_220 - Temperature
      NozzleTemperature_230 - Temperature
      NozzleTemperature_240 - Temperature
      NozzleTemperature_250 - Temperature
      NozzleTemperature_30 - Temperature
      NozzleTemperature_40 - Temperature
      NozzleTemperature_50 - Temperature
      NozzleTemperature_60 - Temperature
      NozzleTemperature_70 - Temperature
      NozzleTemperature_80 - Temperature
      NozzleTemperature_90 - Temperature
      PLA - PrintingMaterial
      PrusaMK3001 - Printer
      PrusaMK3002 - Printer
   )
   (:predicates
      (canReachNozzleTemperature ?Printer - Printer ?NozzleTemperature - Temperature)
      (HeatedBedIsPreheated ?Printer - Printer)
      (isPrinted ?Workpiece - PrintingWorkpiece)
   )
   (:functions
      (EnergyCost)
      (EnergyEfficiency ?Machine - ProductionMachine)
      (MachineUsage ?Machine - ProductionMachine)
      (MaterialCost)
      (MaterialEquationValue_CostMap ?Material - PrintingMaterial)
      (NumericValuesFunction ?discreteConstant - root)
   )
   (:action PreheatBed
      :parameters (?Printer - Printer)
      :precondition (and
         (not
            (HeatedBedIsPreheated ?Printer)
         )
      )
      :effect (and
         (HeatedBedIsPreheated ?Printer)
         (increase (EnergyCost) 1.5)
      )
   )
   (:action PrintWorkpiece
      :parameters (?Workpiece - PrintingWorkpiece ?Printer - Printer ?Material - PrintingMaterial ?NozzleTemperature - Temperature ?EstimatedPrintTime - Minutes)
      :precondition (and
         (not
            (isPrinted ?Workpiece)
         )
         (HeatedBedIsPreheated ?Printer)
         (canReachNozzleTemperature ?Printer ?NozzleTemperature)
      )
      :effect (and
         (isPrinted ?Workpiece)
         (not
            (HeatedBedIsPreheated ?Printer)
         )
         (increase (EnergyCost) (* (NumericValuesFunction ?EstimatedPrintTime) (EnergyEfficiency ?Printer)))
         (increase (MachineUsage ?printer) (NumericValuesFunction ?EstimatedPrintTime))
         (increase (MaterialCost) (* (NumericValuesFunction ?EstimatedPrintTime) (MaterialEquationValue_CostMap ?Material)))
      )
   )


)