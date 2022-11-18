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
</head>

<body class="${css_class}">
	<@liferay_util["include"]
		page=body_top_include />
	<@liferay.control_menu />
	<div class="container-fluid position-relative" id="wrapper">
		<header class="d-flex" id="banner" role="banner">
			<div class="header-content">
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
				<#if !is_signed_in>
					<a
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
						<img alt="${logo_description}" height="80px" src="${site_logo}" width="80px" />
						</a>
						<#if show_site_name>
							<span class="site-name" title="<@liferay.language_format arguments=" ${site_name}" key="go-to-x" />">
							${site_name}
							</span>
						</#if>
					</div>
				</div>
				<div class="search-bar">
					<@liferay.search_bar />
				</div>
			</div>
		</header>
		<#if has_navigation && is_setup_complete>
			<#include "${full_templates_path}/navigation.ftl" />
		</#if>
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
		<footer id="footer" role="contentinfo">
			<p class="powered-by">
				<@liferay.language_format
					arguments='<a href="http://www.liferay.com" rel="external">Liferay</a>'
					key="powered-by-x" />
			</p>
		</footer>
	</div>
	<@liferay_util["include"]
		page=body_bottom_include />
	<@liferay_util["include"]
		page=bottom_include />
	<!-- inject:js -->
	<!-- endinject  -->
</body>

</html>