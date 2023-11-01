@AbapCatalog.sqlViewName: 'ZCANBERKZ_CDS_03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Canberk ZOR CDS Edu-3'
define view ZCANBERKZ_DDL_003
  as select from ZCANBERKZ_DDL_002 as _cds02
{
  _cds02.vbeln,
  sum( _cds02.conversion_netwr )             as total_netwr,
  _cds02.kunnrAd,
  count(*)                                   as Toplam_Fatura_Adedi,
  division(cast( sum(conversion_netwr) as abap.curr( 10, 3 ) ),
           cast( count(*) as abap.int1 ), 3) as Ortalama_Miktar,

  left(fkdat,4)                              as Faturalama_Yili,

  substring(_cds02.fkdat,5,2)                as Faturalama_Ayi,

  substring(_cds02.fkdat,7,2)                as Faturalama_Gunu,

  substring(_cds02.inco2_l , 1 , 3)          as Incoterm_Yeri


}
group by
  _cds02.vbeln,
  _cds02.kunnrAd,
  _cds02.fkdat ,
  _cds02.inco2_l
