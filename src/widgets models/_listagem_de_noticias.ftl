<#if entries?has_content>
	<div class="container">
		<#list entries as curEntry>
			<#assign assetRenderer=curEntry.getAssetRenderer() />
			<#assign URL=assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, assetRenderer, curEntry, !stringUtil.equals(assetLinkBehavior, "showFullContent" ))?keep_before_last("?") />
			<#assign docXml=saxReaderUtil.read(assetRenderer.getArticle().getContent()) />
			<#assign titulo=docXml.valueOf("//dynamic-element
				[@name='CampoDeTexto65959945' ]
				/dynamic-content
				[@language-id='pt_BR' ]
				/text()") />
			<#assign chamada=docXml.valueOf("//dynamic-element
				[@name='CampoDeTexto12374219' ]
				/dynamic-content
				[@language-id='pt_BR' ]
				/text()") />
			<#assign FotoXml=docXml.valueOf("//dynamic-element
				[@name='Imagem86922811' ]
				/dynamic-content
				[@language-id='pt_BR' ]
				/text()") />
			<#assign urlImage=getDownloadURL(FotoXml) />
			<a href="${URL}">
				<div class="noticia d-none d-lg-flex d-md-flex row">
					<div class="col-4">
						<img class="imagem-noticia-listada" src="${urlImage}" />
					</div>
					<div class="col-8">
						<h1 class="titulo-noticia-listada">
							${titulo}
						</h1>
						<p class="chamada-noticia-listada">
							${chamada}
						</p>
					</div>
				</div>
			</a>
			<a href="${URL}">
				<div class="noticia-mobile d-lg-none d-md-none row">
					<div class="imagem-noticia-mobile">
						<img class="imagem-noticia-listada" src="${urlImage}" />
					</div>
					<div>
						<h1 class="titulo-noticia-mobile">
							${titulo}
						</h1>
						<p class="chamada-noticia-mobile">
							${chamada}
						</p>
					</div>
				</div>
			</a>
		</#list>
	</div>
</#if>
<#function getDownloadURL xmlValue>
	<#if xmlValue?has_content>
		<#local JSONFactoryUtil=staticUtil["com.liferay.portal.kernel.json.JSONFactoryUtil"] />
		<#local assetEntryLocalService=serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService") />
		<#local DLFileEntryModel="com.liferay.document.library.kernel.model.DLFileEntry" />
		<#local imgJson=JSONFactoryUtil.createJSONObject(xmlValue) />
		<#local assetEntry=assetEntryLocalService.getEntry(DLFileEntryModel, getterUtil.getLong(imgJson.fileEntryId)) />
		<#local assetRenderer=assetEntry.assetRenderer />
		<#return assetRenderer.getURLDownload(themeDisplay) />
		<#else>
			<#return "" />
	</#if>
</#function>