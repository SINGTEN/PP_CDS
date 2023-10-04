@AbapCatalog.sqlViewName: 'ZPPPRVCOUNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Production Version Count'
define view ZPP_PRV_COUNT
  as select from mapl
{
  matnr,
  werks,
  count(*) as countf
}
group by
  matnr,
  werks
