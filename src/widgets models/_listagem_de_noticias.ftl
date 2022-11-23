<#if entries?has_content>
	<#list entries as curEntry>
		<#assign assetRenderer = curEntry.getAssetRenderer() />
        <#assign docXml = saxReaderUtil.read(assetRenderer.getArticle().getContent()) />
		<#assign titulo =  docXml.valueOf("//dynamic-element[@name='CampoDeTexto65959945']/dynamic-content[@language-id='pt_BR']/text()") />
		<#assign chamada = docXml.valueOf("//dynamic-element[@name='CampoDeTexto12374219']/dynamic-content[@language-id='pt_BR']/text()") />
		
		<div class="card">
			<h1 class="title">${titulo}</h1>
			<p class="chamada">${chamada}</p>
		</div>
	</#list>
</#if>