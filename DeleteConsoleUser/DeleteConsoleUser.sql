Begin Transaction 
declare @@useridn int  
-- set @@useridn =
set @@useridn = (select consoleuser_idn from consoleuser where UserName = 'username')   --Change username to the username, or use the above line to set the ID directly
delete from osdsettings where script_idn in (select script_idn from script where consoleuser_idn = @@useridn) 
delete from script where consoleuser_idn = @@useridn
delete from Report where consoleuser_idn = @@useridn
delete from QuerySort where query_idn in (select query_idn from query where consoleuser_idn = @@useridn)
delete from QueryFields where query_idn in (select query_idn from query where consoleuser_idn = @@useridn) 
delete from CustomGroupQuery where member_idn in (select query_idn from query where consoleuser_idn = @@useridn) 
delete from CustomGroupReport where member_idn in (select report_idn from report where query_idn in (select query_idn from query where consoleuser_idn = @@useridn)) 
delete from CustomGroupColumnSet where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from Report where query_idn in (select query_idn from query where  consoleuser_idn = @@useridn) 
delete from Query where consoleuser_idn = @@useridn  
delete from Pwm_Record_Group_Rel where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from Pwm_User_Record where consoleuser_idn = @@useridn
delete from Package_Relationships where package_idn in (select package_idn from package where consoleuser_idn = @@useridn) 
delete from Package_Files where package_idn in (select package_idn from package where consoleuser_idn = @@useridn) 
delete from CustomGroupPackage where member_idn in (select package_idn from package where consoleuser_idn = @@useridn) 
delete from Package where consoleuser_idn = @@useridn
delete from LP_GUILink where consoleuser_idn = @@useridn 
delete from TaskPolicy where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from TaskFiles where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from TaskContent where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from TaskBnfMacros where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from TaskAllowedMachines where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from ScheduledQueries where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from LD_Task_User where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from DistributionTaskLog where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from LD_Task_Machine where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from ApmTaskObjects where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from ApmCommandLines where ld_task_idn in (select ld_task_idn from ld_task where consoleuser_idn = @@useridn) 
delete from LD_Task where consoleuser_idn = @@useridn  
delete from Layout where consoleuser_idn = @@useridn  
delete from Prov_Template_Grouping where prov_template_def_idn in (select prov_template_def_idn from Prov_Template_Def where owning_user_idn = 11) 
delete from Prov_History_Variable where Prov_History_Task_idn in (select Prov_History_Task_idn from Prov_History_Task where prov_template_def_idn in (select prov_template_def_idn from Prov_Template_Def where owning_user_idn = 11)) 
delete from Prov_History_Entry where Prov_History_Task_idn in (select Prov_History_Task_idn from Prov_History_Task where prov_template_def_idn in (select prov_template_def_idn from Prov_Template_Def where owning_user_idn = 11)) 
delete from Prov_History_Task where prov_template_def_idn in (select prov_template_def_idn from Prov_Template_Def where owning_user_idn = 11) 
delete from Prov_Action_Order where prov_template_def_idn in (select prov_template_def_idn from Prov_Template_Def where owning_user_idn = 11) 
delete from Prov_Template_Rel where parent_template_def_idn in (select prov_template_def_idn from Prov_Template_Def where owning_user_idn = 11) 
delete from Prov_Template_Rel where prov_template_def_idn in (select prov_template_def_idn from Prov_Template_Def where owning_user_idn = 11) 
delete from Prov_Template_Def where owning_user_idn = 11
delete from DashboardCfg where consoleuser_idn = @@useridn 
delete from DashboardWidget where consoleuser_idn = @@useridn  
delete from CustomGroupZone where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupVuln where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupScript where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupReport where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupQuery where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupDynamic where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupComputer where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupColumnSet where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from CustomGroupClientConfig where customgroup_idn in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn) 
delete from customgroupdashboard where customgroup_idn  in (select customgroup_idn from customgroup where consoleuser_idn = @@useridn)
delete from CustomGroup where consoleuser_idn = @@useridn   
delete from ConsoleUserScope where consoleuser_idn = @@useridn 
delete from customgroupconsoleuser where member_idn = @@useridn
delete from consoleuser where consoleuser_idn = @@useridn 
COMMIT
CHECKPOINT