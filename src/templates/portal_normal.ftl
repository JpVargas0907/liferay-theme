<!DOCTYPE html>
<#include init />
<html class="${root_css_class}" dir="<@liferay.language key=" lang.dir" />" lang="${w3c_language_id}">

<head>
	<title>
		${html_title}
	</title>
	<meta content="initial-scale=1.0, width=device-width" name="viewport" />
	<@liferay_util["include"]
		page=top_head_include />
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet" />
	<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
</head>

<body class="${css_class}">
	<@liferay_util["include"]
		page=body_top_include />
	<@liferay.control_menu />
	<div class="corpo container-fluid position-relative" id="wrapper">
		<header class="d-flex" id="banner" role="banner">
			<div class="container header-content">
				<#if !is_signed_in>
					<a
						class="entrar"
						data-redirect="${is_login_redirect_required?string}"
						href="/c/portal/login"
						id="sign-in"
						rel="nofollow">
						${languageUtil.get(locale, "sign-in")}
					</a>
				</#if>
				<div id="heading">
					<div aria-level="1" class="site-title" role="heading">
						<a class="${logo_css_class}" href="${site_default_url}" title="<@liferay.language_format arguments=" ${site_name}" key="go-to-x" />">
						<img alt="${logo_description}" height="80px" src="${site_logo}" />
						</a>
						<#if show_site_name>
							<span class="site-name" title="<@liferay.language_format arguments=" ${site_name}" key="go-to-x" />">
							${site_name}
							</span>
						</#if>
					</div>
				</div>
				<button
					class="d-lg-none navbar-toggler navbar-dark collapsed"
					type="button"
					data-toggle="collapse"
					data-target="#navbarToggle"
					aria-controls="navbarTogglerDemo02"
					aria-expanded="false"
					aria-label="Alterna navegação">
					<span class="navbar-toggler-icon" style="color:#fff; font-size:28px;"></span>
				</button>
				<div class="d-none d-lg-block search-bar">
					<@liferay.search_bar />
				</div>
			</div>
		</header>
		<div>
			<#if has_navigation && is_setup_complete>
				<#include "${full_templates_path}/navigation.ftl" />
			</#if>
		</div>
		<div class="container">
			<div class="d-flex justify-content-end" onClick="darkFunction()">
				<input type="checkbox" data-toggle="toggle" data-on="ON" data-off="OFF" data-onstyle="dark" data-offstyle="light">
			</div>
		</div>
		<div class="content">
			<section id="content">
				<h2 class="hide-accessible sr-only" role="heading" aria-level="1">
					${the_title}
				</h2>
				<#if selectable>
					<@liferay_util["include"]
						page=content_include />
					<#else>
						${portletDisplay.recycle()}
						${portletDisplay.setTitle(the_title)}
						<@liferay_theme["wrap-portlet"]
							page="portlet.ftl">
							<@liferay_util["include"]
								page=content_include />
							</@>
				</#if>
			</section>
		</div>
		<footer id="footer" role="contentinfo">
			<div class="container d-flex justify-content-between align-items-center">
				<a class="${logo_css_class}" href="${site_default_url}" title="<@liferay.language_format arguments=" ${site_name}" key="go-to-x" />">
				<img alt="${logo_description}" height="80px" src="${site_logo}" />
				</a>
				<p class="powered-by">
					© Copyright Fifa
				</p>
			</div>
		</footer>
		<div vw class="enabled">
			<div vw-access-button class="active"></div>
			<div vw-plugin-wrapper>
				<div class="vw-plugin-top-wrapper"></div>
			</div>
		</div>
	</div>
	<@liferay_util["include"]
		page=body_bottom_include />
	<@liferay_util["include"]
		page=bottom_include />
	<!-- inject:js -->
	<!-- endinject  -->
	<script src="https://vlibras.gov.br/app/vlibras-plugin.js"></script>
	<script>
	new window.VLibras.Widget('https://vlibras.gov.br/app');
	</script>
	<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
	<script>
	function darkFunction() {
		let element = document.body;
		element.classList.toggle("dark-mode");
	}
	</script>
</body>

</html>