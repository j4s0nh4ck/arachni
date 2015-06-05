=begin
    Copyright 2010-2015 Tasos Laskos <tasos.laskos@arachni-scanner.com>

    This file is part of the Arachni Framework project and is subject to
    redistribution and commercial restrictions. Please see the Arachni Framework
    web site for more information on licensing and terms of use.
=end

class Arachni::Reporters::HTML

# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class PluginFormatters::Metrics  < Arachni::Plugin::Formatter
    include TemplateUtilities

    def run
        ERB.new( tpl ).result( binding )
    end

    def tpl
        <<-HTML
        <div class="row">
            <div class="col-md-3">

                <h3>General</h3>
                <dl class="dl-horizontal">
                    <dt>
                        Egress traffic
                    </dt>
                    <dd>
                        <%= Arachni::Utilities.bytes_to_megabytes results['general']['egress_traffic'] %>MB
                    </dd>

                    <dt>
                        Ingress traffic
                    </dt>
                    <dd>
                        <%= Arachni::Utilities.bytes_to_megabytes results['general']['ingress_traffic'] %>MB
                    </dd>

                    <dt>
                        Uses HTTP
                    </dt>
                    <dd>
                        <%= boolean results['general']['uses_http'] %>
                    </dd>

                    <dt>
                        Uses HTTPS
                    </dt>
                    <dd>
                        <%= boolean results['general']['uses_https'] %>
                    </dd>
                </dl>

                <h3>Scan</h3>
                <dl class="dl-horizontal">
                    <dt>
                        Duration
                    </dt>
                    <dd>
                        <%= Arachni::Utilities.seconds_to_hms results['scan']['duration'] %>
                    </dd>

                    <dt>
                        Authenticated
                    </dt>
                    <dd>
                        <%= boolean results['scan']['authenticated'] %>
                    </dd>
                </dl>

                <h3>HTTP</h3>
                <dl class="dl-horizontal">
                    <dt>
                        Minimum response time
                    </dt>
                    <dd>
                        <%= results['http']['response_time_min'].round( 4 ) %>s
                    </dd>

                    <dt>
                        Maximum response time
                    </dt>
                    <dd>
                        <%= results['http']['response_time_max'].round( 4 ) %>s
                    </dd>


                    <dt>
                        Average response time
                    </dt>
                    <dd>
                        <%= results['http']['response_time_average'].round( 4 ) %>s
                    </dd>
                </dl>

                <h3>Resources</h3>
                <dl class="dl-horizontal">
                    <dt>
                        Binary
                    </dt>
                    <dd>
                        <%= results['resource']['binary'] %>
                    </dd>

                    <dt>
                        Without parameters
                    </dt>
                    <dd>
                        <%= results['resource']['without_parameters'] %>
                    </dd>

                    <dt>
                        With parameters
                    </dt>
                    <dd>
                        <%= results['resource']['with_parameters'] %>
                    </dd>
                </dl>
            </div>

            <div class="col-md-9">
                <h3>Elements</h3>
                <dl class="dl-horizontal">
                    <dt>
                        Links
                    </dt>
                    <dd>
                        <%= results['element']['links'] %>
                    </dd>

                    <dt>
                        Forms
                    </dt>
                    <dd>
                        <small>
                            <%= results['element']['forms'] %>
                        </small>
                    </dd>
                    <dt>
                        <small>
                            &mdash; with nonces
                        </small>
                    </dt>
                    <dd>
                        <small>
                            <%= boolean results['element']['has_forms_with_nonces'] %>
                        </small>
                    </dd>
                    <dt>
                        <small>
                            &mdash; with passwords
                        </small>
                    </dt>
                    <dd>
                        <small>
                            <%= boolean results['element']['has_forms_with_passwords'] %>
                        </small>
                    </dd>

                    <dt>
                        Cookies
                    </dt>
                    <dd>
                        <%= results['element']['cookies'] %>
                    </dd>

                    <dt>
                        Headers
                    </dt>
                    <dd>
                        <%= results['element']['headers'] %>
                    </dd>

                    <dt>
                        XMLs
                    </dt>
                    <dd>
                        <%= results['element']['xmls'] %>
                    </dd>

                    <dt>
                        JSONs
                    </dt>
                    <dd>
                        <%= results['element']['jsons'] %>
                    </dd>

                    <dt>
                        Total input names
                    </dt>
                    <dd>
                        <%= results['element']['input_names_total'] %>
                    </dd>

                    <dt>
                        Unique input names
                    </dt>
                    <dd>
                        <%= results['element']['input_names_unique'] %>
                    </dd>
                </dl>

                <h3>DOM</h3>
                <dl class="dl-horizontal">
                    <dt>
                        Event listeners
                    </dt>
                    <dd>
                        <%= results['dom']['event_listeners'] %>
                    </dd>

                    <dt>
                        SWF objects
                    </dt>
                    <dd>
                        <%= results['dom']['swf_objects'] %>
                    </dd>
                </dl>

                <h3>Platforms</h3>
                <dl class="dl-horizontal">
                    <% results['platforms'].each do |type, platforms|
                        next if platforms.empty? %>

                        <dt>
                            <%= Arachni::Platform::Manager::TYPES[type.to_sym] %>
                        </dt>
                        <dd>
                            <%= platforms.map { |platform| Arachni::Platform::Manager::PLATFORM_NAMES[platform.to_sym] }.join( ', ' ) %>
                        </dd>
                    <% end %>
                </dl>
            </div>
        </div>

        HTML
    end

    def boolean( b )
        <<-EOHTML
        <i class="fa fa-#{b ? 'check' : 'times'}"></i>
        EOHTML
    end

end

end