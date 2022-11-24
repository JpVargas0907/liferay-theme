<#if entries?has_content>
	<div class="container">
		<#list entries as curEntry>
			<#assign assetRenderer=curEntry.getAssetRenderer() />
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
			<div class="noticia row">
				<div class="col-4">
					<img class="imagem-noticia-listada" src="${urlImage}" />
				</div>
				<div class="col-8">
					<h1 class="titulo-noticia-listada">
						${titulo}
					</h1>
					<p class="chamada">
						${chamada}
					</p>
				</div>
			</div>
		</#list>
	</div>
</#if>
<style>
.noticia {
	margin-bottom: 20px;
	width: 100%;
	border-bottom: 1px solid #c8c8c8;
	padding: 10px 0px 10px 0px;
}

.titulo-noticia-listada {
	color: #94112D;
	font-family: 'Open Sans', sans-serif;
	font-weight: bold;
	font-size: 40px;
}

.chamada {
	color: rgb(158, 157, 157);
	font-family: 'Open Sans', sans-serif;
	font-size: 14px;
}

.imagem-noticia-listada {
	height: 100%;
	width: 100%;
	border-radius: 10px;
}
</style>
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