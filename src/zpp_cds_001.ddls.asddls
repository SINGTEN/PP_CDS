@AbapCatalog.sqlViewName: 'ZPPCDSV001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '物料主檔'
define view ZPP_CDS_001
  as select from    mara
    inner join      makt                  on  mara.matnr = makt.matnr
                                          and makt.spras = $session.system_language
    inner join      marc                  on mara.matnr = marc.matnr
    inner join      mbew                  on  marc.matnr = mbew.matnr
                                          and marc.werks = mbew.bwkey
    inner join      ZPP_PRV_COUNT  as _PRV on  marc.matnr = _PRV.matnr
                                           and marc.werks = _PRV.werks

    inner join      ZPP_BOM_COUNT  as _bc  on  marc.matnr = _bc.matnr
                                           and marc.werks = _bc.werks
    inner join      ZPP_ROUT_COUNT as _rc on  marc.matnr = _rc.matnr
                                          and marc.werks = _rc.werks
    inner join      t134t                 on  mara.mtart  = t134t.mtart
                                          and t134t.spras = $session.system_language
    inner join      t023t                 on  mara.matkl  = t023t.matkl
                                          and t023t.spras = $session.system_language
    left outer join t001k                 on marc.werks = t001k.bwkey
    left outer join t001                  on t001k.bukrs = t001.bukrs

{
  key marc.matnr,
  key marc.werks,
      makt.maktx,
      mara.meins,
      mara.mtart,
      t134t.mtbez,
      mara.matkl,
      t023t.wgbez,
      mara.bismt,
      mara.xchpf,
      mara.spart,
      mara.brgew,
      mara.ntgew,
      mara.gewei,
      mara.aeszn,
      mara.groes,
      mara.zeinr,
      mara.zeivr,
      mara.mstae,

      //MARC
      marc.mmsta,
      marc.dismm,
      marc.minbe,
      marc.disgr,
      marc.dispo,
      marc.disls,
      marc.bstfe,
      marc.bstmi,
      marc.bstma,
      marc.bstrf,
      marc.ausss,
      marc.beskz,
      marc.sobsl,

      // BOM檢查
      case marc.beskz
      when 'E' then
          case _bc.countf
          when  0 then '@02@'
          else '@01@'
          end

       when 'F' then
           case marc.sobsl
           when '30' then
               case _bc.countf
               when  0 then '@02@'
               else '@01@'
               end
           end
       end as bom,

      // 途程檢查
      case marc.beskz
      when 'E' then
        case marc.sobsl
        when '' then
            case _rc.countf
            when  0 then '@02@'
            else '@01@'
            end
        end
      end  as routting,


      //檢查生產版本
      case marc.beskz
      when 'E' then
          case _PRV.countf
          when  0 then '@02@'
          else '@01@'
          end

       when 'F' then
           case marc.sobsl
           when '30' then
             case _PRV.countf
               when  0 then '@02@'
               else '@01@'
               end
           end
       end as VERID,


      marc.lgfsb,
      marc.lgpro,
      marc.rgekz,
      marc.schgt,
      marc.dzeit,
      marc.plifz,
      marc.webaz,
      marc.eisbe,
      marc.mtvfp,
      marc.sbdkz,
      marc.kausf,
      marc.kzaus,
      marc.ausdt,
      marc.nfmat,
      marc.uneto,
      marc.ueeto,
      marc.ekgrp,
      marc.insmk,
      marc.kautb,
      marc.kordb,
      marc.prctr,
      marc.ncost,

      //MBEW
      mbew.bklas,
      mbew.mlast,
      mbew.stprs,
      mbew.verpr,
      mbew.peinh,
      mbew.vprsv,
      mbew.eklas,
      //成本計算1檢視
      mbew.ekalr,
      mbew.hkmat,
      //成本計算2檢視
      mbew.zplp1,
      mbew.zpld1,
      mbew.zplp2,
      t001.waers
}
//where
//mara.matnr  = 'R-412'
//   makt.spras  = 'M'
//and t134t.spras = 'M'
//and t023t.spras = 'M'
