SELECT 
    t.LD_TASK_IDN, 
    t.TASK_NAME, 
    tm.COMPUTER_IDN, 
    c.DeviceName
FROM [landesk06].[dbo].[LD_TASK] t
INNER JOIN [landesk06].[dbo].[LD_TASK_MACHINE] tm
    ON t.LD_TASK_IDN = tm.LD_TASK_IDN
INNER JOIN [landesk06].[dbo].[Computer] c
    ON tm.COMPUTER_IDN = c.Computer_Idn
ORDER BY t.LD_TASK_IDN, tm.COMPUTER_IDN;
