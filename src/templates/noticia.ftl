<div class="noticia">
    <div class="container">
        <h1 class="titulo-noticia">
            <#if (titulo.getData())??>
                ${titulo.getData()}
            </#if>
        </h1>
        <p class="chamada-noticia">
            <#if (chamada.getData())??>
                ${chamada.getData()}
            </#if>
        </p>
        <#if (imagem_destaque.getData())?? && imagem_destaque.getData() !="">
            <img class="imagem-noticia" alt="${imagem_destaque.getAttribute("alt")}" data-fileentryid="${imagem_destaque.getAttribute("fileEntryId")}" src="${imagem_destaque.getData()}" />
        </#if>
        <p class="conteudo-noticia">
            <#if (texto.getData())??>
                ${texto.getData()}
            </#if>
        </p>
    </div>
</div>