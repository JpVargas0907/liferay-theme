<#if entries?has_content>
  <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
      <#list entries as curEntry>
        <#assign assetRenderer = curEntry.getAssetRenderer() />
        <#assign docXml = saxReaderUtil.read(assetRenderer.getArticle().getContent()) />
        <#assign chamada = docXml.valueOf("//dynamic-element[@name='CampoDeTexto12374219']/dynamic-content[@language-id='pt_BR']/text()") />
        <#assign FotoXml= docXml.valueOf("//dynamic-element[@name='Imagem86922811']/dynamic-content[@language-id='pt_BR']/text()") />
        <#assign urlImage = getDownloadURL(FotoXml) />

        <div class="carousel-item ${curEntry?is_first?then('active', '')}">
          <img class="d-block w-100" src="${urlImage}" alt="Primeiro Slide">
          <div class="carousel-caption d-none d-md-block">
            <h5>${curEntry.getTitle(locale)}</h5>
            <p>${chamada}</p>
          </div>
        </div>
      </#list>
    </div>
  </div>
</#if>

<#function getDownloadURL xmlValue>
  <#if xmlValue?has_content>
    <#local JSONFactoryUtil = staticUtil["com.liferay.portal.kernel.json.JSONFactoryUtil"] />
    <#local assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService") />
    <#local DLFileEntryModel = "com.liferay.document.library.kernel.model.DLFileEntry" />
    <#local imgJson = JSONFactoryUtil.createJSONObject(xmlValue) />
    <#local assetEntry = assetEntryLocalService.getEntry(DLFileEntryModel, getterUtil.getLong(imgJson.fileEntryId)) />
    <#local assetRenderer = assetEntry.assetRenderer />
    <#return assetRenderer.getURLDownload(themeDisplay) />
  <#else>
    <#return "" />
  </#if>
</#function>