<#--  
  Modelo de Modelo de Publicador de Conteúdos e Mídias
-->

<#assign JSONFactoryUtil = staticUtil["com.liferay.portal.kernel.json.JSONFactoryUtil"] />
<#assign AssetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService") />
<#assign JournalArticleLocalService = serviceLocator.findService("com.liferay.journal.service.JournalArticleLocalService") />

<#function isLastVersion e>
		<#return JournalArticleLocalService.getLatestArticle(e.resourcePrimKey).getVersion() == e.getVersion() && !e.isInTrash() />
</#function>

<#function pageMap e>
	<#return AssetEntryLocalService.getEntry(e.getModelClassName(), e.resourcePrimKey)>
</#function>

<#assign paginas = JournalArticleLocalService.getStructureArticles(themeDisplay.getScopeGroupId(), "597895") />
<#assign paginas = paginas?filter(e -> isLastVersion(e)) />
<#assign paginas = paginas?map(e -> pageMap(e)) />
<#assign entries = paginas + entries />

<#if entries?has_content>
  <div 
    id="carousel_${portletDisplay.getInstanceId()}" 
    class="carousel slide" 
    data-ride="carousel"
    data-interval="false"
  >
    <div class="carousel-inner pb-4">
      <#list entries?chunk(3) as carousel_item>
        <div class="carousel-item ${carousel_item?is_first?then('active','')}">
          <div class="row">
            <#list carousel_item as curEntry>
              <div class="col-md-4 mb-md-0 mb-4">
                <#assign journalArticle = JournalArticleLocalService.getLatestArticle(curEntry.classPK) />
                <#assign docXml = saxReaderUtil.read(journalArticle.getContent()) />            
                <#assign capa_url = "" />
                
                <#if journalArticle.getStructureId() == "597895">
                  <#assign viewURL = docXml.valueOf("//dynamic-element[@name='CampoDeTexto30577646']/dynamic-content[@language-id='${locale}']/text()") />
                  <#assign chamada = curEntry.getDescription(locale) />
                  <#assign imagem_estrutura_url = docXml.valueOf("//dynamic-element[@name='Imagem68130484']/dynamic-content[@language-id='${locale}']/text()") />
                <#else>	
                  <#assign assetRenderer = curEntry.getAssetRenderer() />
                  <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, assetRenderer, curEntry, !stringUtil.equals(assetLinkBehavior, "showFullContent"))?keep_before("?redirect=") />
                  <#assign chamada = docXml.valueOf("//dynamic-element[@name='CampoDeTexto66815902']/dynamic-content[@language-id='${locale}']/text()") />
                  <#assign imagem_estrutura_url = docXml.valueOf("//dynamic-element[@name='Imagem11933159']/dynamic-content[@language-id='${locale}']/text()") />
                </#if>

                <#if journalArticle.isSmallImage()>
                  <#if journalArticle.getSmallImageURL()?has_content>
                    <#assign capa_url = journalArticle.getSmallImageURL() />
                  <#else>
                    <#assign capa_url = "/image/journal/article?img_id=" + journalArticle.getSmallImageId() />
                  </#if>
                <#else>
                  <#if imagem_estrutura_url?has_content>
                    <#assign imgJson = JSONFactoryUtil.createJSONObject(imagem_estrutura_url) />

                    <#if !imgJson.url??>
                      <#assign dlUtil = objectUtil("com.liferay.document.library.kernel.util.DLUtil") />
                      <#assign DLFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService") />

                      <#if imgJson.fileEntryId??>
                        <#assign fileEntry = DLFileEntryLocalService.getFileEntry(imgJson.fileEntryId?number) />
                        <#assign url = "/documents/" + fileEntry.getGroupId() + "/" + fileEntry.getFolderId() + "/" + fileEntry.getFileName() + "/" + fileEntry.getUuid() + "?download=true" />
                        <#assign imgJson = {"url": url} />
                      </#if>
                    </#if>
                    
                    <#if imgJson.url??>
                      <#assign capa_url = imgJson.url />
                    </#if>
                  </#if>
                </#if>

                <a 
                  class="card card-rounded h-100"
                  href="${viewURL}"
                >
                  <div class="aspect-ratio card-item-first aspect-ratio-16-to-9">
                    <img
                      alt="thumbnail"
                      class="aspect-ratio-item aspect-ratio-item-fluid h-100 w-100"
                      src="${capa_url}"
                    />
                  </div>
                  <div class="card-body">
										<#if curEntry.getTagNames()?has_content>
										  <span class="news-badge badge badge-success">${curEntry.getTagNames()[0]?upper_case}</span>
										</#if>
                    
                    <h4>${curEntry.getTitle(locale)}</h4>

                    <#if curEntry.getDescription(locale)?has_content && curEntry.getDescription(locale) != "">
                      ${curEntry.getDescription(locale)}
                    <#else>
                      <#if chamada != "">
                        <p class="card-text">${chamada}</p>
                      <#else>
                        <#assign docXml = saxReaderUtil.read(journalArticle.getContent()) />
                        <#assign xmlValue = docXml.valueOf("//dynamic-element[@type='rich_text']/dynamic-content[@language-id='${locale}']/text()") />
                        <#assign descriptionFiltered = xmlValue?replace('<[^>]+>','','r') />
                        ${descriptionFiltered?truncate(113)}
                      </#if>
                    </#if>
                  </div>
                </a>
              </div>
            </#list>
          </div>
        </div>
      </#list>
    </div>
    
    <div class="controls">
      <a 
        class="carousel-control-prev" 
        onclick="handleControlClick(event)" 
        role="button" 
        data-slide="prev"
      >
        <
        <span class="sr-only">Anterior</span>
      </a>

      <ol class="carousel-indicators">
        <#list entries?chunk(3) as carousel_item>
          <li 
            data-target="#carousel_${portletDisplay.getInstanceId()}" 
            data-slide-to="${carousel_item?index}"
            class="${carousel_item?is_first?then('active','')}"
          ></li>
        </#list>
      </ol>

      <a 
        class="carousel-control-next" 
        onclick="handleControlClick(event)" 
        role="button" 
        data-slide="next"
      >
        >
        <span class="sr-only">Próximo</span>
      </a>
    </div>
  </div>

  <a 
    class="btn btn-see-more" 
    href="/noticias" 
    target="_blank"
  >
    <span class="inline-item inline-item-before">
      <i class="las la-plus-circle"></i>
    </span>
    Veja todos as notícias
  </a>
<#else>
  <p><em>Ainda não há arquivos a ser exibido.</em></p>
</#if>

<style>
.card-body{
	position: relative;
}
.news-badge{
	position: absolute;
	top: 0;
	transform: translateY(-50%);
}
</style>

<script>
function handleControlClick(e){
  const clicked = ($(e.target).hasClass("carousel-control-prev") || $(e.target).hasClass("carousel-control-next")) 
    ? e.target 
    : $(e.target).parents(".carousel-control-next,.carousel-control-prev");
  const carousel = $(clicked).parents(".carousel");
  const action = $(clicked).data("slide");
  $(carousel).carousel(action)
};
</script>