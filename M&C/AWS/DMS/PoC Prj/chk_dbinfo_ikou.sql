/*******************************************************************************
 FILE_NAME: chk_dbinfo.sql
 NOTICE   :
*******************************************************************************/

clear col
clear breaks
ttitle        off
set veri      off
set feed      off
set head      on
set lines     2000
set pages     50000
set trimspool on
set pause     off
set colsep    '|'
set echo      off
set term      off
set tab       off

---------------------------------------------------------------------------
---  Set logfile name
---------------------------------------------------------------------------
COLUMN system_date NEW_VALUE YYMMDD
SELECT to_char(sysdate,'YYYYMMDDHH24MISS') system_date FROM DUAL;
COLUMN dbname NEW_VALUE dbname
select name as dbname from v$database;
-- COLUMN instname NEW_VALUE instname
-- select instance_name as instname from v$instance;

---------------------------------------------------------------------------
---  Set Default Schema
---------------------------------------------------------------------------
define def_schema_all_1 = "'ANONYMOUS','CTXSYS','DBSNMP','EXFSYS','LBACSYS','MDSYS','MGMT_VIEW','OLAPSYS','ORDDATA','OWBSYS','ORDPLUGINS','ORDSYS','OUTLN','SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM','WK_TEST','WKSYS'"
define def_schema_all_2 = "'WKPROXY','WMSYS','XDB','APEX_PUBLIC_USER','DIP','DVF','FLOWS_30000','FLOWS_FILES','DBSFWUSER','MDDATA','ORACLE_OCM','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','BI','HR','OE','PM','IX','SH','TSMSYS'"
define def_schema_all_3 = "'APPQOSSYS','AURORA$JIS$UTILITY$','AURORA$ORB$UNAUTHENTICATED','OSE$HTTP$ADMIN','DMSYS','OAS_PUBLIC','ODM','ODM_MTR','PERFSTAT','RMAN','TRACESVR','WEBSYS','QS','QS_ES'"
define def_schema_all_4 = "'QS_WS','QS_OS','QS_CB','QS_CS','QS_ADM','QS_CBADM','OWBSYS_AUDIT','DVSYS','APEX_030200','OJVMSYS','REMOTE_SCHEDULER_AGENT'"
define def_schema_all_5 = "'XS$NULL','SCOTT','PUBLIC','SYS$UMF','SYSBACKUP','SYSDG','SYSKM','SYSRAC','AUDSYS','GSMADMIN_INTERNAL','GSMUSER','GSMCATUSER','GGSYS'"
define def_schema_all_6 = "'XS$NULL','SCOTT','SYSBACKUP','SYSDG','SYSKM','SYSRAC','AUDSYS','GSMADMIN_INTERNAL','GSMUSER','GSMCATUSER','GGSYS'"
-- not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)

---------------------------------------------------------------------------
---  Set Default Role
---------------------------------------------------------------------------
define def_role_all_1 = "'ADM_PARALLEL_EXECUTE_TASK','AQ_ADMINISTRATOR_ROLE','AQ_USER_ROLE','AUTHENTICATEDUSER','CAPI_USER_ROLE','CONNECT','CSW_USR_ROLE','CTXAPP','CWM_USER','DATAPUMP_EXP_FULL_DATABASE'"
define def_role_all_2 = "'DATAPUMP_IMP_FULL_DATABASE','DBA','DELETE_CATALOG_ROLE','EJBCLIENT','EXECUTE_CATALOG_ROLE','EXP_FULL_DATABASE','GATHER_SYSTEM_STATISTICS','GLOBAL_AQ_USER_ROLE','HS_ADMIN_EXECUTE_ROLE'"
define def_role_all_3 = "'HS_ADMIN_ROLE','HS_ADMIN_SELECT_ROLE','IMP_FULL_DATABASE','JAVADEBUGPRIV','JAVAIDPRIV','JAVASYSPRIV','JAVAUSERPRIV','JAVA_ADMIN','JAVA_DEPLOY','JMXSERVER','LBAC_DBA','EM_EXPRESS_BASIC'"
define def_role_all_4 = "'LOGSTDBY_ADMINISTRATOR','MGMT_USER','OEM_ADVISOR','OEM_MONITOR','OLAP_DBA','OLAP_USER','OLAP_XS_ADMIN','ORDADMIN','OWB$CLIENT','OWB_DESIGNCENTER_VIEW','OWB_USER','RECOVERY_CATALOG_OWNER'"
define def_role_all_5 = "'RESOURCE','SCHEDULER_ADMIN','SELECT_CATALOG_ROLE','SNMPAGENT','SPATIAL_CSW_ADMIN','SPATIAL_WFS_ADMIN','WFS_USR_ROLE','WM_ADMIN_ROLE','XDBADMIN','XDB_SET_INVOKER','XDB_WEBSERVICES','GSMADMIN_ROLE'"
define def_role_all_6 = "'XDB_WEBSERVICES_OVER_HTTP','XDB_WEBSERVICES_WITH_PUBLIC','OLAPI_TRACE_USER','WKUSER','SALES_HISTORY_ROLE','AUDIT_ADMIN','CDB_DBA','DV_ACCTMGR','DV_REALM_OWNER','DV_REALM_RESOURCE','EM_EXPRESS_ALL'"
define def_role_all_7 = "'RECOVERY_CATALOG_OWNER_VPD','XS_CONNECT','DV_ADMIN','DV_OWNER','GSMUSER_ROLE','GSM_POOLADMIN_ROLE','SYSUMF_ROLE'"
-- not in (&&DEF_ROLE_ALL_1, &&DEF_ROLE_ALL_2, &&DEF_ROLE_ALL_3, &&DEF_ROLE_ALL_4, &&DEF_ROLE_ALL_5, &&DEF_ROLE_ALL_6)

---------------------------------------------------------------------------
---  Set Date Format
---------------------------------------------------------------------------
alter session set nls_date_format = 'yyyy/mm/dd hh24:mi:ss';

---------------------------------------------------------------------------
---  spool
---------------------------------------------------------------------------
spool chk_dbinfo_&&dbname._&&YYMMDD..log

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Execute Time(Start)
prompt #------------------------------------------------------------#
select sysdate "Execute Time(Start)" from dual;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Information
prompt #------------------------------------------------------------#
select dbid,name,created,log_mode from v$database;


prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Database REGISTRY
prompt #------------------------------------------------------------#
column ACTION_TIME for a30
column ACTION for a15
column NAMESPACE for a10
column VERSION for a10
column BUNDLE_SERIES for a10
column COMMENTS for a50
select * from dba_registry_history;


prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Database Parameters
prompt #------------------------------------------------------------#
column property_name for a30
column property_value for a35
column description for a100
select * from database_properties order by property_name;

prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Instance Information
prompt #------------------------------------------------------------#
column instance_name for a10
column host_name for a20
column version for a10
select instance_name,host_name,version,status from v$instance;
    
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Oracle Version
prompt #------------------------------------------------------------#
column product format a50
column version format a30
select product,version from product_component_version;



prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Oracle Option
prompt #------------------------------------------------------------#
column parameter format a40
column value format a20
select * from v$option order by parameter;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Component
prompt #------------------------------------------------------------#

column status format a10
column comp_name format a50
column version format a20
column modified format a30
select
    COMP_NAME,VERSION,STATUS,MODIFIED
from
    dba_registry order by comp_name;
    
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  GLOBAL_NAME
prompt #------------------------------------------------------------#
column global_name format a50
select * from global_name;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  SGA
prompt #------------------------------------------------------------#
show sga;

col COMPONENT for a40
col LAST_OPER_TYPE for a14
col LAST_OPER_MODE for a14
select * from V$SGA_DYNAMIC_COMPONENTS;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  MEMORY ADVICE ( V$SGA_TARGET_ADVICE )
prompt #------------------------------------------------------------#
select * from V$SGA_TARGET_ADVICE;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  MEMORY ADVICE ( V$SHARED_POOL_ADVICE )
prompt #------------------------------------------------------------#
select * from V$SHARED_POOL_ADVICE;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  MEMORY ADVICE ( V$DB_CACHE_ADVICE )
prompt #------------------------------------------------------------#
select * from V$DB_CACHE_ADVICE;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  MEMORY ADVICE ( V$PGA_TARGET_ADVICE )
prompt #------------------------------------------------------------#
select * from V$PGA_TARGET_ADVICE;


-- V$PGA_TARGET_ADVICE_HISTOGRAM
-- V$PGASTAT
-- DBA_HIST_PGASTAT
-- DBA_HIST_PGA_TARGET_ADVICE
-- V$MEMORY_TARGET_ADVICE
-- V$SGA_TARGET_ADVICE
-- V$SHARED_POOL_ADVICE
-- V$DB_CACHE_ADVICE
-- V$PGA_TARGET_ADVICE

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  PARAMETER ( ALL )
prompt #------------------------------------------------------------#
column name format a40
column value format a200
select name,isdefault,value from v$parameter order by name;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  PARAMETER ( Not Default )
prompt #------------------------------------------------------------#
column name format a40
column value format a200
select name,value from v$parameter where isdefault='FALSE' order by name;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  NLS Parameters
prompt #------------------------------------------------------------#
column value format a60
select parameter,value from v$nls_parameters order by parameter;

---------------------------------------------------------------------------
---  Database Files Information
---------------------------------------------------------------------------
prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Database Files Information
prompt #------------------------------------------------------------#
column tablespace_name format a30 heading "Tablespace"
column file_name format a62 heading "File Name"
column file_size format 9,999,999.99 heading "File Size|(MB)"
column increment_by format 9999999999 heading "increment_by|(Block)"
column initial_extent format 9999999999 heading "Initial Extent|(KB)"
column next_extent format 9999999999 heading "Next Extent|(KB)"
column min_extents format 9999 heading "Minimum|Extents"
column max_extents format 9999999999 heading "Max|Extents"
select
    ts.tablespace_name,
    df.file_name,
    df.bytes/(1024*1024) file_size,
    df.autoextensible,
    df.increment_by,
    df.maxbytes/(1024*1024) "max_size(MB)",
    ts.SEGMENT_SPACE_MANAGEMENT,
    ts.EXTENT_MANAGEMENT,
    ts.ALLOCATION_TYPE,
    ts.initial_extent/1024 initial_extent,
    ts.next_extent/1024 next_extent,
    ts.pct_increase,
    ts.min_extents,
    ts.max_extents,
    ts.CONTENTS,
--    ts.BIGFILE,
    ts.BLOCK_SIZE
from
    dba_tablespaces ts,
    dba_data_files df
where
    ts.tablespace_name = df.tablespace_name
order by df.file_id;

---------------------------------------------------------------------------
---  Temp files Information
---------------------------------------------------------------------------
column name format a62 heading "Temp file name"
prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Temp files Information
prompt #------------------------------------------------------------#
select
    ts.tablespace_name,
    df.file_name,
    df.bytes/(1024*1024) file_size,
    df.autoextensible,
    df.increment_by,
    df.maxbytes/(1024*1024) "max_size(MB)",
    ts.SEGMENT_SPACE_MANAGEMENT,
    ts.EXTENT_MANAGEMENT,
    ts.ALLOCATION_TYPE,
    ts.initial_extent/1024 initial_extent,
    ts.next_extent/1024 next_extent,
    ts.pct_increase,
    ts.min_extents,
    ts.max_extents,
    ts.CONTENTS,
--    ts.BIGFILE,
    ts.BLOCK_SIZE
from
    dba_tablespaces ts,
    dba_temp_files df
where
    ts.tablespace_name = df.tablespace_name
order by df.file_id;

prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Tablespace Information
prompt #------------------------------------------------------------#
select * from dba_tablespaces order by 1;

---------------------------------------------------------------------------
-- Checking Freespace
---------------------------------------------------------------------------
prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Freespace Summary
prompt #------------------------------------------------------------#
comp SUM of nfrags totsiz avasiz on report 
break on report 

column tsname  format     a30 justify c heading 'Tablespace' 
column nfrags  format 999,990 justify c heading 'Free|Frags' 
column mxfrag  format 999,999,999 justify c heading 'Largest|Frag (MB)' 
column totsiz  format 999,999,999 justify c heading 'Total|(MB)' 
column avasiz  format 999,999,999 justify c heading 'Available|(MB)' 
column pctusd  format     990 justify c heading 'Pct|Used' 

select total.TABLESPACE_NAME tsname,
       D nfrags,
       C/1024/1024 mxfrag,
       A/1024/1024 totsiz,
       B/1024/1024 avasiz,
       (1-nvl(B,0)/A)*100 pctusd
from
    (select sum(bytes) A,
            tablespace_name
            from dba_data_files
            group by tablespace_name) TOTAL,
    (select sum(bytes) B,
            max(bytes) C,
            count(bytes) D, 
            tablespace_name
            from dba_free_space
            group by tablespace_name) FREE
where 
      total.TABLESPACE_NAME=free.TABLESPACE_NAME(+)
order by 1;


SELECT d.tablespace_name "name", 
   TO_CHAR((a.bytes / 1024 /1024),'99,999,990') "size(MB)",
   TO_CHAR(((a.bytes - DECODE(f.bytes, NULL, 0, f.bytes)) /
   1024 /1024),'99,999,990') "Using(MB)" ,
   TO_CHAR((f.bytes / 1024 / 1024),'999,999,990') "free(MB)",
   TO_CHAR((a.bytes - f.bytes) / a.bytes * 100,'990.0') "Using(%)"
FROM  sys.dba_tablespaces d, sys.sm$ts_avail a, sys.sm$ts_free f
WHERE  d.tablespace_name = a.tablespace_name
AND f.tablespace_name (+)= d.tablespace_name
order by d.tablespace_name;


SELECT 
  d.tablespace_name "name", 
  TO_CHAR(NVL(a.bytes / 1024 / 1024, 0),'99,999,990.900')"size (MB)", 
  TO_CHAR(NVL(t.hwm, 0)/1024/1024,'99999999.999')  "HWM (MB)",
  TO_CHAR(NVL(t.hwm / a.bytes * 100, 0), '990.00') "HWM % " ,
  TO_CHAR(NVL(t.bytes/1024/1024, 0),'99999999.999') "Using (MB)", 
  TO_CHAR(NVL(t.bytes / a.bytes * 100, 0), '990.00') "Using %" 
FROM 
  sys.dba_tablespaces d, 
  (select tablespace_name, sum(bytes) bytes from
  dba_temp_files group by tablespace_name) a,
  (select tablespace_name, sum(bytes_cached) hwm,
  sum(bytes_used) bytes from v$temp_extent_pool group by tablespace_name) t
WHERE d.tablespace_name = a.tablespace_name(+) 
  AND d.tablespace_name = t.tablespace_name(+) 
  AND d.extent_management like 'LOCAL'
  AND d.contents like 'TEMPORARY';


prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Freespace Datafile
prompt #------------------------------------------------------------#
SELECT d.file_name, d.tablespace_name, v.status, 
         TO_CHAR((d.bytes / 1024 / 1024), '99999990.000') "SIZE(M)", 
         NVL(TO_CHAR(((d.bytes - SUM(s.bytes)) / 1024 / 1024),'99999990.000'),
         TO_CHAR((d.bytes / 1024 / 1024), '99999990.000')) "USED(M)" 
FROM sys.dba_data_files d, sys.dba_free_space s, sys.v_$datafile v
WHERE (s.file_id (+)= d.file_id) AND (d.file_name = v.name) 
GROUP BY d.file_name,d.tablespace_name, v.status, d.bytes
order by 2, 1;


prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Tablespace Quotas Information
prompt #------------------------------------------------------------#

select * from dba_ts_quotas order by 1;


---------------------------------------------------------------------------
---  Database Redo log files Information
---------------------------------------------------------------------------
column thread# format 99 heading "Thread#"
column group# format 999 heading "Group#"
column members format 99 heading "Members"
column member format a62 heading "File Name"
column sequence# format 9999999999 heading "Sequence#"
column file_size format 999,999.99 heading "File Size(MB)"
column status format a12 heading "Status"
prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Database Redo log files Information
prompt #------------------------------------------------------------#
select
    l.thread#,
    l.group#,
    l.members,
        f.member,
    l.bytes/(1024*1024) file_size,
    l.sequence#,
    l.status
from
    v$log l,
    v$logfile f
where
    l.group#=f.group#
order by 
    l.thread#,l.group#,l.members;

---------------------------------------------------------------------------
---  Database Control files Information
---------------------------------------------------------------------------
column name format a62 heading "Controlfile name"
prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Database Control files Information
prompt #------------------------------------------------------------#
select
    *
from
    v$controlfile order by name;

---------------------------------------------------------------------------
---  Database Rollback Segments Information
---------------------------------------------------------------------------
column segment_name format a30 heading "Rollback|Segment name"
column tablespace_name format a30 heading "Tablespace"
column status format a10
column initial_extent format 9999999999 heading "Initial|Extent"
column next_extent format 9999999999 heading "Next|Extent"


prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Database Rollback Segments Information
prompt #------------------------------------------------------------#
select
    segment_name,
    tablespace_name,
    gets,
    waits,
    extents,
    shrinks,
    optsize,
    hwmsize,
    initial_extent,
    next_extent,
    min_extents,
    max_extents,
    r.status
from
    dba_rollback_segs r,
    v$rollstat s
where
    segment_id=usn;


---------------------------------------------------------------------------
---  Database ASM Information
---------------------------------------------------------------------------
prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  ASM DiskGroup Information
prompt #------------------------------------------------------------#

column group_number format 99999 heading "GROUP_NO"
column name format a20 heading "DG_NAME"

select group_number,name,block_size,allocation_unit_size,state,type,
total_mb,free_mb,usable_file_mb
from v$asm_diskgroup order by 1;

prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  ASM Disk Information
prompt #------------------------------------------------------------#

column group_number format 99999 heading "GROUP_NO"
column disk_number format 99999 heading "DISK_NO"
column mount_status format a10 heading "MOUNT_STAT"
column redundancy format a15
column os_mb format 99,999,999
column total_mb format 99,999,999
column free_mb format 99,999,999
column name format a30
column failgroup format a30
column label format a10
column path format a30
column create_date format a25 heading "CREATED"

select group_number,disk_number,mount_status,state,redundancy,
total_mb,free_mb,name,failgroup,label,path,create_date
from v$asm_disk order by 1,2;

prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  ASM File Information
prompt #------------------------------------------------------------#
set trims on
col FULL_ALIAS_PATH for a120
col GNAME for a20
select gname,concat('+'||gname, sys_connect_by_path(aname, '/')) full_alias_path
from (select g.name gname, a.parent_index pindex,a.name aname,
a.reference_index rindex from v$asm_alias a, v$asm_diskgroup g
where a.group_number = g.group_number
)
start with (mod(pindex, power(2, 24))) = 0
connect by prior rindex = pindex order by 2; 


---------------------------------------------------------------------------
---  Database User Information
---------------------------------------------------------------------------

column username format a30 heading "Username"
column default_tablespace format a30 heading "Default|Tablespace"
column temporary_tablespace format a30 heading "Temporary|Tablespace"
column profile format a20 heading "Profile"
column account_status format a17 heading "Status"
prompt 
prompt 
prompt #------------------------------------------------------------#
prompt #  Database User Information
prompt #------------------------------------------------------------#
select
    username,
    default_tablespace,
    temporary_tablespace,
    profile,
    created,
    account_status
from
    dba_users
order by username;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Segments Information
prompt #------------------------------------------------------------#
col SEGMENT_NAME for a50
col PARTITION_NAME for a50
col TABLESPACE_NAME for a15
col SEGMENT_TYPE for a15
select SEGMENT_NAME,PARTITION_NAME,SEGMENT_TYPE,TABLESPACE_NAME,
INITIAL_EXTENT,NEXT_EXTENT,BYTES,MAX_SIZE from user_segments
where SEGMENT_TYPE ='TABLE PARTITION'; 


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Segments Information (Not Default)
prompt #------------------------------------------------------------#
select SEGMENT_NAME,PARTITION_NAME,SEGMENT_TYPE,TABLESPACE_NAME,
INITIAL_EXTENT,NEXT_EXTENT,BYTES,MAX_SIZE from user_segments
where SEGMENT_TYPE ='TABLE PARTITION' 
and TABLESPACE_NAME not in ('SYSTEM','SYSAUX');


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Instance Information
prompt #------------------------------------------------------------#
column instance_name for a16
column host_name for a64
column version for a17
select instance_name,host_name,version,status from v$instance;

---------------------------------------------------------------------------
---  Database User Information
---------------------------------------------------------------------------

column username format a30 heading "Username"
column default_tablespace format a30 heading "Default|Tablespace"
column temporary_tablespace format a30 heading "Temporary|Tablespace"
column profile format a20 heading "Profile"
column account_status format a17 heading "Status"
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database User Information (Not Default)
prompt #------------------------------------------------------------#
select
    username,
    default_tablespace,
    temporary_tablespace,
    profile,
    created,
    account_status
from
    dba_users
WHERE username not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by username;

prompt #------------------------------------------------------------#
prompt #  Database User Information
prompt #------------------------------------------------------------#
select
    username,
    default_tablespace,
    temporary_tablespace,
    profile,
    created,
    account_status
from
    dba_users
order by username;


prompt
prompt
---------------------------------------------------------------------------
---  Database Objects Information
---------------------------------------------------------------------------
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Count )
prompt #------------------------------------------------------------#
col owner format a30
col object_type format a30
select
    owner,object_type,count(*)
from
    dba_objects
where
     owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
     and object_name not like 'BIN$%'
group by
    owner,
    object_type
order by 1,2;


---------------------------------------------------------------------------
-- Checking Invalid Objects
---------------------------------------------------------------------------
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( INVALID OBJECT )
prompt #------------------------------------------------------------#
col object_name format a60
select owner,object_type,object_name from dba_objects where status != 'VALID'
order by owner,object_type,object_name;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database All Objects Information
prompt #------------------------------------------------------------#
col object_name format a60
col subobject_name format a30
select
    owner,object_type,object_name,subobject_name
from
    dba_objects
where
     owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
and object_name not like 'BIN$%'
order by 1,2,3,4;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database All Segments Information
prompt #------------------------------------------------------------#
col PARTITION_NAME format a30
column segment_name format a60 heading "Segment name"
column tablespace_name format a30 heading "Tablespace"

select
     owner,SEGMENT_TYPE,SEGMENT_NAME,PARTITION_NAME,bytes,TABLESPACE_NAME
from
     dba_segments
where
     owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
and SEGMENT_NAME not like 'BIN$%'
order by 1,2,3,4;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Recyclebin Objects Information ( DBA_SEGMENTS )
prompt #------------------------------------------------------------#
column owner       format a30 heading "Owner"
column segment_type format a18 heading "Segment Type"
column segment_name format a60 heading "Segment Name"
column tablespace_name format a30

select
    owner,
    segment_type,
    segment_name,
    tablespace_name,
    blocks
from
    dba_segments
where
    owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
and segment_name like 'BIN$%'
order by 1,2,3;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Recyclebin Objects Information ( DBA_RECYCLEBIN )
prompt #------------------------------------------------------------#
select * from dba_recyclebin order by OWNER, ORIGINAL_NAME, OBJECT_NAME;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Partition Table )
prompt #------------------------------------------------------------#
col table_owner format a30
col table_name format a30
col partition_name format a30
col tablespace_name format a30
col high_value format a100

select table_owner,table_name,partition_name,tablespace_name,high_value
from dba_tab_partitions
where table_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2,3;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Partition Index )
prompt #------------------------------------------------------------#
col index_owner format a30
col index_name format a50
col table_name format a50
col partition_name format a30
col tablespace_name format a30
col high_value format a100

select index_owner,index_name,partition_name,tablespace_name,high_value
from dba_ind_partitions
where index_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2,3;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Trigger )
prompt #------------------------------------------------------------#
column status     format a8  heading "Status"
column table_name format a30
column trigger_name format a30

select
    owner,
    table_name,
    trigger_name,
    status
from
    dba_triggers
where
    owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by
    owner,
    table_name,trigger_name;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Sequence )
prompt #------------------------------------------------------------#

column SEQUENCE_OWNER format a30
select
    *
from
    dba_sequences
order by
    sequence_owner,SEQUENCE_NAME;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Sequence Not Default)
prompt #------------------------------------------------------------#

column SEQUENCE_OWNER format a30
select
    *
from
    dba_sequences
where
    SEQUENCE_OWNER not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by
    sequence_owner,SEQUENCE_NAME;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Database Link )
prompt #------------------------------------------------------------#

column owner     format a30 heading "Owner"
column db_link   format a60 heading "Database Link Name"
column username  format a30 heading "Create User"
column host      format a60 heading "Host"
column "Created" format a20

select
    owner,
    db_link,
    username,
    host,
    to_char(created,'yyyy/mm/dd hh24:mi:ss') "Created"
from
    dba_db_links
order by 1,2,3;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Mview )
prompt #------------------------------------------------------------#

column mview_name format a30 heading "MV_Name"
column updatable format a5 heading "UPDT"
column master_link format a60 heading "master_link"
column refresh_mode format a7 heading "REFmode"
column last_refresh_type format a11 heading "lastREFtype"
column compile_state format a30 heading "compile_state"

select
    owner,
    mview_name,
    updatable,
    master_link,
    refresh_mode,
    last_refresh_type,
    last_refresh_date,
    compile_state
from
    dba_mviews
order by
    owner,mview_name;

prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( MVIEW Information )
prompt #------------------------------------------------------------#

col MASTER_LINK for a40
col compile_state for a30

select * from dba_mviews
order by OWNER,MVIEW_NAME;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( MVIEW_LOG )
prompt #------------------------------------------------------------#
column LOG_OWNER format a30
column MASTER format a40
column LOG_TABLE format a40
column LOG_TRIGGER format a15
column ROWIDS format a3
column PRIMARY_KEY format a3
column OBJECT_ID format a3
column FILTER_COLUMNS format a3
column SEQUENCE format a3
column INCLUDE_NEW_VALUES format a3

select LOG_OWNER,MASTER,LOG_TABLE,LOG_TRIGGER,ROWIDS,PRIMARY_KEY,OBJECT_ID,FILTER_COLUMNS,SEQUENCE,INCLUDE_NEW_VALUES
from dba_mview_logs
order by LOG_OWNER,LOG_TABLE;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( MVIEW_REFRESH_TIME )
prompt #------------------------------------------------------------#

col NAME for a35
col MASTER_OWNER for a15
select * from dba_mview_refresh_times
order by OWNER,NAME,MASTER_OWNER,MASTER;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( View )
prompt #------------------------------------------------------------#

select
    owner,
    view_name
from
    dba_views
where
     owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by
    owner,view_name;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Index )
prompt #------------------------------------------------------------#

column index_owner format a25 heading "Index Owner"
column table_name format a50 heading "Table Name"
column index_name format a50 heading "Index Name"
column column_name format a30 heading "Column Name"
column column_position format 9999 heading "Column Position"

select
    idxc.index_owner,
    idxc.table_name,
    idxc.index_name,
    idxc.column_name,
    idxc.column_position,
    idx.leaf_blocks,
    idx.tablespace_name,
    idx.uniqueness
from
    dba_ind_columns idxc,
    dba_indexes idx
where
    idxc.index_name = idx.index_name
and idxc.index_owner = idx.owner
and index_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by
    index_owner,
    table_name,
    index_name,
    column_position;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Constrants )
prompt #------------------------------------------------------------#
column owner format a30
column table_name for a50
column constraint_name for a50
column column_name for a50
column R_CONSTRAINT_NAME for a35
select
    c.owner,c.table_name, c.constraint_name, c.constraint_type, cc.position, cc.column_name, c.status, c.r_constraint_name, c.index_name
from
    dba_constraints c, all_cons_columns cc
where
    c.owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
    and c.owner      = cc.owner
    and c.constraint_name = cc.constraint_name
order by
    c.owner, c.table_name, c.constraint_name, cc.position;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Constrants Count )
prompt #------------------------------------------------------------#

select
    owner,constraint_type,count(*)
from
    dba_constraints
where
    owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
    and table_name not like 'BIN$%'
group by
    owner,constraint_type
order by
    owner,constraint_type;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( SYNONYM )
prompt #------------------------------------------------------------#
COLUMN OWNER format a30
COLUMN SYNONYM_NAME format a30
COLUMN TABLE_OWNER format a30
COLUMN TABLE_NAME format a30

SELECT owner,
       synonym_name,
       table_owner,
       table_name
FROM   dba_synonyms
WHERE  table_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_6)
ORDER BY owner,synonym_name,table_owner,table_name;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( LOB )
prompt #------------------------------------------------------------#

col column_name for a30
col tablespace_name for a30

select OWNER,
       TABLE_NAME,
       COLUMN_NAME,
       SEGMENT_NAME,
       TABLESPACE_NAME,
       INDEX_NAME,
       FORMAT
from dba_lobs
where owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
ORDER BY OWNER,TABLE_NAME,COLUMN_NAME,TABLESPACE_NAME;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( LOB for 9i)
prompt #------------------------------------------------------------#

col column_name for a30
col tablespace_name for a30

select OWNER,
       TABLE_NAME,
       COLUMN_NAME,
       SEGMENT_NAME,
--       TABLESPACE_NAME,
       INDEX_NAME
--       FORMAT
from dba_lobs
where owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
ORDER BY OWNER,TABLE_NAME,COLUMN_NAME;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Database Objects Information ( Directory )
prompt #------------------------------------------------------------#

col directory_path format a80
col directory_name format a40
select * from dba_directories order by 1,2,3;

---------------------------------------------------------------------------
---  Database privs Information
---------------------------------------------------------------------------
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  ROLE LIST
prompt #------------------------------------------------------------#
col ROLE for a40
select * from dba_roles order by role;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Sys Privs Information ( Not Default )
prompt #------------------------------------------------------------#
col grantee format a30
col privilege format a50
SELECT *
FROM   dba_sys_privs
WHERE  grantee NOT IN (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5, &&DEF_ROLE_ALL_1, &&DEF_ROLE_ALL_2, &&DEF_ROLE_ALL_3, &&DEF_ROLE_ALL_4, &&DEF_ROLE_ALL_5, &&DEF_ROLE_ALL_6, &&DEF_ROLE_ALL_7)
ORDER BY grantee,privilege;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Sys Privs Information ( ALL )
prompt #------------------------------------------------------------#
col GRANTEE format a30
col PRIVILEGE format a50
SELECT *
FROM   dba_sys_privs
ORDER BY grantee,PRIVILEGE;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Role Privs Information  ( Not Default )
prompt #------------------------------------------------------------#
col GRANTED_ROLE format a40
select grantee,granted_role,ADMIN_OPTION from dba_role_privs
WHERE  grantee NOT IN (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5, &&DEF_ROLE_ALL_1, &&DEF_ROLE_ALL_2, &&DEF_ROLE_ALL_3, &&DEF_ROLE_ALL_4, &&DEF_ROLE_ALL_5, &&DEF_ROLE_ALL_6, &&DEF_ROLE_ALL_7)
order by 1,2;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Role Privs Information ( ALL )
prompt #------------------------------------------------------------#
select grantee,granted_role,ADMIN_OPTION from dba_role_privs order by 1,2;


prompt
prompt
prompt #----------------------------------------------------#
prompt #  Check the Privilege ( ROLE_ROLE_PRIVS )
prompt #----------------------------------------------------#

select * from role_role_privs order by 1,2;

prompt
prompt
prompt #----------------------------------------------------#
prompt #  Check the Privilege ( ROLE_SYS_PRIVS )
prompt #----------------------------------------------------#

select * from role_sys_privs order by 1,2;

prompt
prompt #----------------------------------------------------#
prompt #  Check the Privilege ( ROLE_TAB_PRIVS )
prompt #----------------------------------------------------#

select * from role_tab_privs order by 1,2,3,4,5;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Obj Privs Information ( Table privileges )
prompt #------------------------------------------------------------#
col pr format a20
col tn format a45
col tn2 format a40
col gr format a20
col gr2 format a40

SELECT
privilege pr,
'ON',
owner||'.'||table_name tn,
'FROM',
grantor gr,
'TO',
grantee gr2,
decode(grantable,'YES','+GRANT OPT')
FROM
sys.dba_tab_privs
WHERE grantor not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
and table_name not like 'BIN$%'
ORDER BY grantor,grantee,owner,table_name,privilege;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Obj Privs Information ( Column privileges )
prompt #------------------------------------------------------------#

SELECT
privilege pr,
'ON',
owner||'.'||table_name||'('||column_name||')' tn2,
'FROM',
grantor gr,
'TO',
grantee gr2,
decode(grantable,'YES','+GRANT OPT')
FROM
sys.dba_col_privs
WHERE grantor not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
and table_name not like 'BIN$%'
ORDER BY grantor,grantee,owner,table_name,column_name,privilege;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Obj Privs Information ( Count )
prompt #------------------------------------------------------------#
col grantor format a20
select grantor, grantee, count(*) from dba_tab_privs
WHERE grantor not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5, &&DEF_ROLE_ALL_1, &&DEF_ROLE_ALL_2, &&DEF_ROLE_ALL_3, &&DEF_ROLE_ALL_4, &&DEF_ROLE_ALL_5, &&DEF_ROLE_ALL_6, &&DEF_ROLE_ALL_7)
and table_name not like 'BIN$%'
group by grantor, grantee
ORDER BY grantor, grantee;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Oracle Text Information ( thesauri )
prompt #------------------------------------------------------------#

select * from ctx_thesauri order by ths_owner;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Oracle Text Information ( preferences )
prompt #------------------------------------------------------------#

select * from ctx_preferences order by pre_owner;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Oracle Text Information ( stoplists )
prompt #------------------------------------------------------------#

select * from ctx_stoplists order by spl_owner;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Oracle Text Information ( section_groups )
prompt #------------------------------------------------------------#

select * from ctx_section_groups order by sgp_owner;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Oracle Text Information ( index_sets )
prompt #------------------------------------------------------------#

select * from ctx_index_sets order by ixs_owner;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  DBMS_JOB PACKAGE LIST
prompt #------------------------------------------------------------#
col log_user for a20
col next_sec for a20
col interval for a50
col what for a100
select job, log_user, next_date, next_sec, interval, broken, what from dba_jobs order by log_user;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  DBMS_SCHEDULER PACKAGE LIST
prompt #------------------------------------------------------------#
col owner for a30
col job_name for a30
col job_type for a30
col repeat_interval for a80
col state for a20
col start_date for a40
col next_run_date for a40
col job_action for a100
select owner,job_name, job_type, enabled, state, start_date, next_run_date, repeat_interval, job_action
from dba_scheduler_jobs
order by 1, 2;

---------------------------------------------------------------------------
---  Database Statistics Information
---------------------------------------------------------------------------
col TABLE_NAME for a35
col OWNER  for a30
col TABLE_OWNER for a30
col DEGREE for a6
col INDEX_NAME for a35
col INDEX_TYPE for a15
col INDEX_OWNER for a30
col PARTITION_NAME for a35
col SUBPARTITION_NAME for a35

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( DBA_TABLES )
prompt #------------------------------------------------------------#
select
OWNER,
TABLE_NAME,
NUM_ROWS,
BLOCKS,
EMPTY_BLOCKS,
AVG_SPACE,
CHAIN_CNT,
AVG_ROW_LEN,
AVG_SPACE_FREELIST_BLOCKS,
NUM_FREELIST_BLOCKS,
DEGREE,
SAMPLE_SIZE,
LAST_ANALYZED,
GLOBAL_STATS,
USER_STATS
from DBA_TABLES
where owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( DBA_TAB_PARTITIONS )
prompt #------------------------------------------------------------#
select
TABLE_OWNER,
TABLE_NAME,
NUM_ROWS,
BLOCKS,
EMPTY_BLOCKS,
AVG_SPACE,
CHAIN_CNT,
AVG_ROW_LEN,
SAMPLE_SIZE,
LAST_ANALYZED,
GLOBAL_STATS,
USER_STATS
from DBA_TAB_PARTITIONS
where table_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( DBA_TAB_SUBPARTITIONS )
prompt #------------------------------------------------------------#
select
TABLE_OWNER,
TABLE_NAME,
NUM_ROWS,
BLOCKS,
EMPTY_BLOCKS,
AVG_SPACE,
CHAIN_CNT,
AVG_ROW_LEN,
SAMPLE_SIZE,
LAST_ANALYZED,
GLOBAL_STATS,
USER_STATS
from DBA_TAB_SUBPARTITIONS
where table_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( DBA_INDEXES )
prompt #------------------------------------------------------------#
col INDEX_TYPE for a30
select
OWNER,
INDEX_NAME,
INDEX_TYPE,
TABLE_OWNER,
TABLE_NAME,
BLEVEL,
LEAF_BLOCKS,
DISTINCT_KEYS,
AVG_LEAF_BLOCKS_PER_KEY,
AVG_DATA_BLOCKS_PER_KEY,
CLUSTERING_FACTOR,
DEGREE,
SAMPLE_SIZE,
LAST_ANALYZED,
USER_STATS,
PCT_DIRECT_ACCESS,
GLOBAL_STATS
from DBA_INDEXES
where owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( DBA_IND_PARTITIONS )
prompt #------------------------------------------------------------#
select
INDEX_OWNER,
INDEX_NAME,
PARTITION_NAME,
BLEVEL,
LEAF_BLOCKS,
DISTINCT_KEYS,
AVG_LEAF_BLOCKS_PER_KEY,
AVG_DATA_BLOCKS_PER_KEY,
CLUSTERING_FACTOR,
SAMPLE_SIZE,
LAST_ANALYZED,
USER_STATS,
PCT_DIRECT_ACCESS,
GLOBAL_STATS
from DBA_IND_PARTITIONS
where index_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2,3;

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( DBA_IND_SUBPARTITIONS )
prompt #------------------------------------------------------------#
select
INDEX_OWNER,
INDEX_NAME,
PARTITION_NAME,
SUBPARTITION_NAME,
BLEVEL,
LEAF_BLOCKS,
DISTINCT_KEYS,
AVG_LEAF_BLOCKS_PER_KEY,
AVG_DATA_BLOCKS_PER_KEY,
CLUSTERING_FACTOR,
SAMPLE_SIZE,
LAST_ANALYZED,
USER_STATS,
GLOBAL_STATS
from DBA_IND_SUBPARTITIONS
where index_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
order by 1,2,3,4;


prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( LOCKED TABLE STATISTICS )
prompt #------------------------------------------------------------#
select
OWNER,
TABLE_NAME,
PARTITION_NAME,
SUBPARTITION_NAME,
OBJECT_TYPE,
STATTYPE_LOCKED,
STALE_STATS
from DBA_TAB_STATISTICS
where STATTYPE_LOCKED is not null
  and table_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
:

prompt
prompt
prompt #------------------------------------------------------------#
prompt #  STATISTICS Information ( LOCKED INDEX STATISTICS )
prompt #------------------------------------------------------------#
select
OWNER,
INDEX_NAME,
TABLE_OWNER,
TABLE_NAME,
PARTITION_NAME,
SUBPARTITION_NAME,
OBJECT_TYPE,
STATTYPE_LOCKED,
STALE_STATS
from DBA_IND_STATISTICS
where STATTYPE_LOCKED is not null
  and table_owner not in (&&DEF_SCHEMA_ALL_1, &&DEF_SCHEMA_ALL_2, &&DEF_SCHEMA_ALL_3, &&DEF_SCHEMA_ALL_4, &&DEF_SCHEMA_ALL_5)
;

---------------------------------------------------------------------------
---  Execute Time
---------------------------------------------------------------------------
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Execute Time ( End )
prompt #------------------------------------------------------------#
select sysdate "Execute Time(End)" from dual;


set echo on 
set tab off verify on colsep "|"
set lines 10000 pages 10000 trims on

REM #__________________________________________________________
REM #
REM # instance
REM #__________________________________________________________
select instance_name,status from v$instance
;

REM #__________________________________________________________
REM #
REM # database_properties
REM #__________________________________________________________
col property_value for a40
col PROPERTY_NAME for a40

select * from v$version
;

select property_name,property_value
from database_properties
;

REM #__________________________________________________________
REM #
REM # dba_registry
REM #__________________________________________________________
col COMP_ID for a20
col COMP_NAME for a35
col VERSION for a15
col STATUS for a20
col MODIFIED for a35
select COMP_ID,COMP_NAME,VERSION,STATUS,MODIFIED from dba_registry
;

REM #__________________________________________________________
REM #
REM # controlfile
REM #__________________________________________________________
select name from v$controlfile
;

REM #__________________________________________________________
REM #
REM # logfile
REM #__________________________________________________________
col thread# for 999
col group#  for 999
col members for 999
col member for a100
col MB for 999,999,999

select l.thread#, l.group#, l.members, lf.member
     , l.bytes/1024/1024 MB
from v$log l, v$logfile lf
where l.group# = lf.group#
order by 1,2,4
;

REM #__________________________________________________________
REM #
REM # database_properties
REM #__________________________________________________________
col tablespace_name for a20
col inc_mb for 999,990.000
col max_mb for 999,999,999
col min_extlen_MB for 999.0
col file_name for a100

select ts.contents,ts.tablespace_name,df.file_id,ts.bigfile,df.bytes/1024/1024 MB, df.autoextensible
     , df.increment_by*(select value from v$parameter2 where name='db_block_size')/1024/1024 INC_MB
     , df.maxbytes/1024/1024 MAX_MB,ts.segment_space_management
     , ts.extent_management,ts.allocation_type, ts.min_extlen/1024/1024 min_extlen_MB
     , df.file_name
from dba_tablespaces ts, dba_data_files df
where ts.tablespace_name = df.tablespace_name
union all
select ts.contents,ts.tablespace_name,df.file_id,ts.bigfile,df.bytes/1024/1024 MB, df.autoextensible
     , df.increment_by*(select value from v$parameter2 where name='db_block_size')/1024/1024 INC_MB
     , df.maxbytes/1024/1024 MAX_MB,ts.segment_space_management
     , ts.extent_management,ts.allocation_type, ts.min_extlen/1024/1024 min_extlen_MB
     , df.file_name
from dba_tablespaces ts, dba_temp_files df
where ts.tablespace_name = df.tablespace_name
order by 1,2,3
;

col PROPERTY_NAME for a30
col PROPERTY_VALUE for a30

select PROPERTY_NAME, PROPERTY_VALUE
from database_properties
where PROPERTY_NAME in ('DEFAULT_TEMP_TABLESPACE','DEFAULT_PERMANENT_TABLESPACE')
order by 1
;

REM #__________________________________________________________
REM #
REM # dba_segments
REM #__________________________________________________________
select TABLESPACE_NAME,sum(bytes)/1024/1024 mb from dba_segments
group by TABLESPACE_NAME
;

REM #__________________________________________________________
REM #
REM # parameter
REM #__________________________________________________________
col name for a40
col value for a60

select p.name,p.value,sp.name,sp.value,p.isdefault
from v$parameter p, v$spparameter sp
where p.name = sp.name
order by 1
;

REM #__________________________________________________________
REM #
REM # archive log list
REM #__________________________________________________________
archive log list

REM #__________________________________________________________
REM #
REM # archived_log
REM #__________________________________________________________
col RECID for 9999999999
col SEQUENCE# for 9999999999
col BLOCKS for 9999999999
col BLOCK_SIZE for 9999999999
col CREATOR for a5
col ARCHIVED for a5
col DELETED for a5
col STATUS for a5

select recid,dest_id,sequence#,to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time
     , to_char(next_time,'yyyy-mm-dd hh24:mi:ss') next_time
     , blocks,block_size,creator,archived,deleted ,status
from v$archived_log order by 1,3
;

REM #__________________________________________________________
REM #
REM # Database Objects Information ( DBA_Profile )
REM #__________________________________________________________
col profile for a20
col resource_name for a30
col limit for a30

select profile,resource_name,resource_type,limit
from dba_profiles
order by 1,3,2
;

REM #__________________________________________________________
REM #
REM # Database Objects Information ( dba_users )
REM #__________________________________________________________
col username for a20
col account_status for a20
col default_tablespace for a20
col temporary_tablespace for a20
col profile for a15

select username,account_status,default_tablespace,
       temporary_tablespace,to_char(created,'yyyy/mm/dd hh24:mi:ss'),profile
from dba_users where ACCOUNT_STATUS='OPEN'
;

REM #__________________________________________________________
REM #
REM # AWR
REM #__________________________________________________________
col SNAP_INTERVAL for a30
col RETENTION for a30

select dbid, snap_interval, retention, topnsql
from DBA_HIST_WR_CONTROL
;

REM #__________________________________________________________
REM #
REM # dba_scheduler_jobs
REM #__________________________________________________________
col job_name for a30
col schedule_name for a30
col job_type for a20
col job_action for a30
col job_class for a15
col start_date for a20
col last_start_date for a20
col next_run_date for a20
col last_run_duration for a30
col repeat_interval for a100
col comments for a30

select owner,job_name,schedule_name,schedule_type,to_char(start_date,'yyyy/mm/dd hh24:mi:ss') start_date
     , repeat_interval,job_class,enabled
     , auto_drop,restartable,state,run_count,to_char(last_start_date,'yyyy/mm/dd hh24:mi:ss') last_start_date
     , last_run_duration,to_char(next_run_date,'yyyy/mm/dd hh24:mi:ss') next_run_date
     , stop_on_window_close
from dba_scheduler_jobs
order by 1,2
;

REM #__________________________________________________________
REM #
REM # dba_scheduler_job_log
REM #__________________________________________________________
col log_date for a30
col owner for a15
col job_name for a30
col status for a15


select to_char(log_date,'yyyy/mm/dd hh24:mi:ss') log_date,owner,job_name,status from dba_scheduler_job_log
where log_date > sysdate-7 order by log_date
;

REM #__________________________________________________________
REM #
REM # DBA_SCHEDULER_WINDOWS
REM #__________________________________________________________
col window_name for a20
col resource_plan for a20
col duration for a20
col REPEAT_INTERVAL for a70

select window_name,resource_plan,repeat_interval,duration,enabled from DBA_SCHEDULER_WINDOWS
;

REM #__________________________________________________________
REM #
REM # Database Objects Information ( audit )
REM #__________________________________________________________
col TABLE_NAME for a15
col TABLESPACE_NAME for a17
col username for a20
col proxy_name for a10
col user_name for a20
col AUDIT_OPTION for a40
col PRIVILEGE for a40
col SUCCESS for a12
col FAILURE for a12

select table_name, tablespace_name
from dba_tables
where table_name IN ('AUD$', 'FGA_LOG$') order by table_name
;

select * from dba_obj_audit_opts order by 1,2,3
;

select * from dba_stmt_audit_opts order by 1,2,3
;

select * from dba_priv_audit_opts order by 1,2,3
;

REM #__________________________________________________________
REM #
REM # dba_objects
REM #__________________________________________________________
col owner for a15
col object_name for a30

select owner,object_name,object_type,to_char(created,'yyyy/mm/dd hh24:mi:ss') created,status
from dba_objects where status != 'VALID'
;

---------------------------------------------------------------------------
---  Execute Time
---------------------------------------------------------------------------
prompt
prompt
prompt #------------------------------------------------------------#
prompt #  Execute Time ( End )
prompt #------------------------------------------------------------#
select sysdate "Execute Time(End)" from dual;
spool off

