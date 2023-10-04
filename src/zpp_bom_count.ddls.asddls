@AbapCatalog.sqlViewName: 'ZPPBOMCOUNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'count BOM'
define view ZPP_BOM_COUNT as select from mast {
    key matnr,
        werks,
        
        count(*) as countf
}
group by matnr , werks
