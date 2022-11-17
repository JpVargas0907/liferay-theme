<nav 
	class="menu-principal navbar navbar-expand-lg navbar-dark bg-dark" 
	aria-label="<@liferay.language key="site-pages" />" class="${nav_css_class}" id=",navigation" role="navigation">

	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#toogle" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Alterna navegação">
    <span class="navbar-toggler-icon"></span>
  	</button>

	<div 
		id="toogle" 
		class="collapse navbar-collapse">	
		<ul role="navbar-nav mr-auto">
			<#list nav_items as nav_item>
				<#assign
					nav_item_attr_has_popup = ""
					nav_item_css_class = ""
					nav_item_layout = nav_item.getLayout()
				/>

				<#if nav_item.isSelected()>
					<#assign
						nav_item_attr_has_popup = "aria-haspopup='true'"
						nav_item_css_class = "selected"
					/>
				</#if>

				<li class="nav-item active nav-item ${nav_item_css_class}" id="layout_${nav_item.getLayoutId()}" role="presentation">
					<a class="nav-link text-decoration-none" ${nav_item_attr_has_popup} href="${nav_item.getURL()}" ${nav_item.getTarget()} role="menuitem"><span><@liferay_theme["layout-icon"] layout=nav_item_layout /> ${nav_item.getName()}</span></a>

					<#if nav_item.hasChildren()>
						<ul class="dropdown-menu child-menu" role="menu">
							<#list nav_item.getChildren() as nav_child>
								<#assign
									nav_child_css_class = ""
								/>

								<#if nav_item.isSelected()>
									<#assign
										nav_child_css_class = "selected"
									/>
								</#if>

								<li class="${nav_child_css_class}" id="layout_${nav_child.getLayoutId()}" role="presentation">
									<a class="nav-link text-decoration-none" href="${nav_child.getURL()}" ${nav_child.getTarget()} role="menuitem">${nav_child.getName()}</a>
								</li>
							</#list>
						</ul>
					</#if>
				</li>
			</#list>
		</ul>
	</div>
</nav>