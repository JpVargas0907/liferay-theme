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
<style>
.noticia {
    width: 100vw;
    display: flex;
    justify-content: center;

    .container {
        width: 60%;
        display: flex;
        flex-direction: column;

        picture {
            width: 100%;
        }
    }

    .titulo-noticia {
        width: 100%;
        font-family: 'Open Sans', sans-serif;
        font-weight: bold;
        font-size: 44px;
        color: #000;
    }

    .chamada-noticia {
        width: 100%;
        font-family: 'Open Sans', sans-serif;
        font-size: 20px;
        color: rgb(158, 157, 157);
    }

    .imagem-noticia {
        width: 100%;
        margin-bottom: 24px;
        border-radius: 10px;
    }

    .conteudo-noticia {
        font-family: 'Open Sans', sans-serif;
        text-align: left;
    }
}

@include media-breakpoint-down(md) {
    .noticia {
        .container {
            width: 90%;
        }
    }
}

</sytle>