@AbapCatalog.sqlViewName: 'ZPPROUTCOUNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'routing count'
define view ZPP_ROUT_COUNT
  as select from mapl
{
  key matnr,
  key werks,
      count(*) as countf
}
where
      plnty = 'N'
  and loekz = ''
group by
  matnr,
  werks
