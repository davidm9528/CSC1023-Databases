SET time_zone = "+00:00";
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

CREATE TABLE IF NOT EXISTS `Assignment` (
  `ProjectID` bigint(20) NOT NULL,
  `EmployeeID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Contract` (
  `ContractID` bigint(20) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Start` date NOT NULL,
  `DueFinish` date DEFAULT NULL,
  `ActualFinish` date DEFAULT NULL,
  `EmployeeID` bigint(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Employee` (
  `EmployeeID` bigint(20) NOT NULL,
  `Title` varchar(32) DEFAULT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Joined` date DEFAULT NULL,
  `Left` date DEFAULT NULL,
  `Current` tinyint(1) NOT NULL DEFAULT '1',
  `Phone` varchar(32) NOT NULL,
  `GradeID` int(11) NOT NULL,
  `Manager` bigint(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EmployeeSkill` (
  `EmployeeID` bigint(20) NOT NULL,
  `SkillID` bigint(20) NOT NULL,
  `DateAchieved` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Equipment` (
  `EquipmentID` bigint(20) NOT NULL,
  `Type` varchar(255) NOT NULL,
  `Make` varchar(255) DEFAULT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `OperationNotes` text,
  `Damaged` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EquipmentLoan` (
  `EmployeeID` bigint(20) NOT NULL,
  `EquipmentID` bigint(20) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date DEFAULT NULL,
  `Current` tinyint(1) NOT NULL DEFAULT '1',
  `Notes` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Expense` (
  `ExpenseID` bigint(20) NOT NULL,
  `EmployeeID` bigint(20) NOT NULL,
  `ProjectID` bigint(20) DEFAULT NULL,
  `Description` varchar(255) NOT NULL,
  `Amount` double NOT NULL,
  `Paid` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `FileItem` (
  `ItemID` bigint(20) NOT NULL,
  `Title` varchar(255) NOT NULL DEFAULT '',
  `Location` varchar(255) NOT NULL,
  `EmployeeID` bigint(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Grade` (
  `GradeID` int(11) NOT NULL,
  `Title` varchar(128) NOT NULL,
  `Code` varchar(16) NOT NULL,
  `SpineMin` int(11) NOT NULL DEFAULT '1',
  `SpineMax` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Payslip` (
  `PayslipID` bigint(20) NOT NULL,
  `EmployeeID` bigint(20) NOT NULL,
  `Taxable` double NOT NULL DEFAULT '0',
  `NonTaxable` double NOT NULL DEFAULT '0',
  `IncomeTax` double NOT NULL DEFAULT '0',
  `NationalInsurance` double NOT NULL DEFAULT '0',
  `NetPay` double NOT NULL DEFAULT '0',
  `Payday` date NOT NULL,
  `TransferDay` date NOT NULL,
  `TransferRef` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Project` (
  `ProjectID` bigint(20) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Notes` text NULL,
  `Internal` tinyint(1) NOT NULL DEFAULT '0',
  `Sensitive` tinyint(1) NOT NULL DEFAULT '0',
  `Started` date NOT NULL,
  `Ended` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Skill` (
  `SkillID` bigint(20) NOT NULL,
  `Title` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

ALTER TABLE `Assignment`
  ADD KEY `ProjectID` (`ProjectID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

ALTER TABLE `Contract`
  ADD PRIMARY KEY (`ContractID`),
  ADD UNIQUE KEY `ContractID` (`ContractID`),
  ADD KEY `EmployeeID` (`EmployeeID`),
  ADD KEY `ContractID_2` (`ContractID`,`Title`,`EmployeeID`),
  ADD KEY `Title` (`Title`);

ALTER TABLE `Employee`
  ADD PRIMARY KEY (`EmployeeID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `GradeID` (`GradeID`),
  ADD KEY `Manager` (`Manager`),
  ADD KEY `EmployeeID` (`EmployeeID`,`FirstName`,`LastName`,`Email`,`Current`,`Manager`),
  ADD KEY `FirstName` (`FirstName`),
  ADD KEY `LastName` (`LastName`),
  ADD KEY `Current` (`Current`);

ALTER TABLE `EmployeeSkill`
  ADD KEY `SkillID` (`SkillID`),
  ADD KEY `EmployeeID` (`EmployeeID`,`SkillID`);

ALTER TABLE `Equipment`
  ADD PRIMARY KEY (`EquipmentID`),
  ADD KEY `EquipmentID` (`EquipmentID`),
  ADD KEY `Type` (`Type`),
  ADD KEY `Model` (`Model`),
  ADD KEY `Description` (`Description`),
  ADD KEY `Damaged` (`Damaged`);

ALTER TABLE `EquipmentLoan`
  ADD KEY `EquipmentID` (`EquipmentID`),
  ADD KEY `EmployeeID` (`EmployeeID`,`EquipmentID`,`StartDate`,`EndDate`,`Current`),
  ADD KEY `StartDate` (`StartDate`),
  ADD KEY `EndDate` (`EndDate`),
  ADD KEY `Current` (`Current`);

ALTER TABLE `Expense`
  ADD PRIMARY KEY (`ExpenseID`),
  ADD UNIQUE KEY `ExpenseID` (`ExpenseID`),
  ADD KEY `EmployeeID` (`EmployeeID`),
  ADD KEY `ProjectID` (`ProjectID`),
  ADD KEY `ExpenseID_2` (`ExpenseID`,`EmployeeID`,`ProjectID`,`Description`),
  ADD KEY `Description` (`Description`);

ALTER TABLE `FileItem`
  ADD PRIMARY KEY (`ItemID`),
  ADD KEY `EmployeeID` (`EmployeeID`),
  ADD KEY `ItemID` (`ItemID`,`Title`,`EmployeeID`),
  ADD KEY `Title` (`Title`);

ALTER TABLE `Grade`
  ADD PRIMARY KEY (`GradeID`),
  ADD UNIQUE KEY `Code` (`Code`),
  ADD KEY `GradeID` (`GradeID`),
  ADD KEY `Code_2` (`Code`);

ALTER TABLE `Payslip`
  ADD PRIMARY KEY (`PayslipID`),
  ADD KEY `PayslipID` (`PayslipID`,`EmployeeID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

ALTER TABLE `Project`
  ADD PRIMARY KEY (`ProjectID`),
  ADD KEY `ProjectID` (`ProjectID`),
  ADD KEY `Title` (`Title`),
  ADD KEY `Notes` (`Notes`(255));

ALTER TABLE `Skill`
  ADD PRIMARY KEY (`SkillID`),
  ADD UNIQUE KEY `Title` (`Title`),
  ADD KEY `SkillID` (`SkillID`),
  ADD KEY `Title_2` (`Title`);

ALTER TABLE `Contract`
  MODIFY `ContractID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;

ALTER TABLE `Employee`
  MODIFY `EmployeeID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;

ALTER TABLE `Equipment`
  MODIFY `EquipmentID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;

ALTER TABLE `Expense`
  MODIFY `ExpenseID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;

ALTER TABLE `FileItem`
  MODIFY `ItemID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;

ALTER TABLE `Grade`
  MODIFY `GradeID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;

ALTER TABLE `Payslip`
  MODIFY `PayslipID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;

ALTER TABLE `Project`
  MODIFY `ProjectID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;

ALTER TABLE `Skill`
  MODIFY `SkillID` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;

ALTER TABLE `Assignment`
  ADD CONSTRAINT `Assignment_ibfk_1` FOREIGN KEY (`ProjectID`) REFERENCES `Project` (`ProjectID`),
  ADD CONSTRAINT `Assignment_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`);

ALTER TABLE `Contract`
  ADD CONSTRAINT `Contract_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`);

ALTER TABLE `Employee`
  ADD CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`GradeID`) REFERENCES `Grade` (`GradeID`),
  ADD CONSTRAINT `Employee_ibfk_2` FOREIGN KEY (`Manager`) REFERENCES `Employee` (`EmployeeID`);

ALTER TABLE `EmployeeSkill`
  ADD CONSTRAINT `EmployeeSkill_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`),
  ADD CONSTRAINT `EmployeeSkill_ibfk_2` FOREIGN KEY (`SkillID`) REFERENCES `Skill` (`SkillID`);

ALTER TABLE `EquipmentLoan`
  ADD CONSTRAINT `EquipmentLoan_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`),
  ADD CONSTRAINT `EquipmentLoan_ibfk_2` FOREIGN KEY (`EquipmentID`) REFERENCES `Equipment` (`EquipmentID`);

ALTER TABLE `Expense`
  ADD CONSTRAINT `Expense_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`),
  ADD CONSTRAINT `Expense_ibfk_2` FOREIGN KEY (`ProjectID`) REFERENCES `Project` (`ProjectID`);

ALTER TABLE `FileItem`
  ADD CONSTRAINT `FileItem_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`);

ALTER TABLE `Payslip`
  ADD CONSTRAINT `Payslip_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`);