Skyline Version Migration
=========================

General update recipe
---------------------

After every Skyline update make sure that:

* You have updated your `Gemfile`
* Run `rake skyline:db:migrate` to update your Skyline tables.
* Run `rake skyline:db:seed` to update roles/rights and other important data updates.
* The assets (`RAILS_ROOT/public/skyline`) are from the new version. If they are symlinked, Skyline will 
  take care of them for you.


Version 3.1.0 -> Version 3.2.0
------------------------------

**Important**: Skyline now is Rails 3.0.x only!!

**Important**: Read the changelog for Skyline 3.2.0!!

Skyline is now a fully-fledged Rails 3.0.x engine and should be used as such. 

## For custom sections ##

* Skyline no longer enforces it's own FormBuilder, so instead of `form_for` / `fields_for` use
  `skyline_form_for` and `skyline_fields_for` in your edit interface.

## For custom Artciles ##

The following things have changed and may have effect on your implementation:

* [Articles] Remove Article#enable_publishing? in favour of the documented Article.publishable?
* [Articles] Remove Article#enable_locking? in favour of Article#lockable? and Article.lockable?
* [Articles] Remove Article#enable_multiple_variants? in favour of Article.can_have_multiple_variants? and Article#can_have_multiple_variants?
* [Articles] Remove unused Article#rollbackable?


Version 3.0.8 -> Version 3.1.0
------------------------------

**Important**: Read the changelog for Skyline 3.1.0!!

The main change in Skyline 3.1.0 is that we switched to Bundler 1.x. This means that you have to change some of the initialization files.

### Files to change ###

**Gemfile**

Remove the lines:

    bundle_path "vendor/bundler_gems"
    disable_system_gems

**config/environment.rb**

Update the Rails version:

    RAILS_GEM_VERSION = '2.3.10' unless defined? RAILS_GEM_VERSION
    
**config/boot.rb**
See the Bundler docuemntation (/doc/Bundler.md)

**config/preinitializer.rb**
See the Bundler docuemntation (/doc/Bundler.md)


### Deprecations ###

A couple of classes and methods have been deprecated/removed in Skyline 3.1. This is by no means a complete overview of things that changed
so YMMV. No specific functionality has been removed, but the interfaces have changed a bit. See below for a list of deprecations.

**Important** : Some functionality has been deprecated in Skyline 3.1 you can still use the deprecation-layer if you are updating from an older version.

* [Deprecations] Deprecations for 3.0.8 aren't loaded automatically anymore: require skyline/lib/deprecated/version3_0_8 manually to enable them.
* [Deprecations] Removed all of Solr search, it will be put in a plugin.
* [Deprecations] Refactor Renderer and RenderableScope* to the Rendering module.
* [Deprecations] Deprecate Skyline::Renderer in favour of Skyline::Rendering::Renderer 
* [Deprecations] Deprecate Skyline::UrlValidation in favour of vendored UrlValidation
* [Deprecations] Deprecate Skyline::Renderer::SettingsHelper#get and Skyline::Renderer::SettingsHelper#get_page
* [Deprecations] Deprecate Skyline::FormBuilderWithErrors in favour of Skyline::FormBuilder
* [Deprecations] Deprecate SectionItem in favour of Sections::Interface.
* [Deprecations] Deprecate Referable in favour of HasManyReferablesIn.
* [Deprecations] Deprecate ContentItem in favour of BelongsToReferable.


Version 3.0.7 -> Version 3.0.8
------------------------------

There are no pressing changes you need to make to your implementation. Keep in mind however
that we deprecated some methods. The deprecated methods will be removed in version 3.1.0

**page\_sections\_per_column** in templates. Use `sections_per_column` instead. The old method
is still available as an alias.

**setting and page\_from\_settings** in templates. These two helpers are deprecated
in favour of `Settings.get` for `setting` and `Settings.get_page` for `page_from_setting`. The
method signatures are identical was merly a restructuring.

First OS release -> Version 3.0.7
---------------------------------

**1. Template changes: render.peek_until** Peek until doesn't skip forward in the collection 
anymore. The old behaviour was inconsistent with peek. All peek functions now only look forward.
Replace all occurences of `var = peek_until...` and make sure they manually do `skip!(var.size)`
a better sollution is to use `render_until`.

**2. Template changes: @Page\_class** `@Page_class` is no longer accesible in the renderer. Use
`site.root` if you need to access the root class.

**3. Template changes: Renderer partials** You no longer need to pass the currently rendererd object
to partials. You can access the currently rendered object by using `renderer.object`.

**3. Custom sections: Buttons are no longer images** The helpers `button_image` has been removed
and the syntax of `submit_button` and `submit_button_to` has changed. Search for occurences of one 
of these three helpers and replace them accordingly:

**button_image**

    link_to button_image("small/delete.gif", :alt => :delete), ...
    
to

    link_to button_text(:delete), ..., :class => "button small red"
    
**submit\_button\_to**

    submit_button_to "small/delete.gif", ..., :value => :delete
    
to

    submit_button_to :delete, ..., :class => "small red"
    
**submit\_button**

    submit_button "small/delete.gif", ..., :value => :delete

to

    submit_button :delete, ..., :class => "small red"
    
