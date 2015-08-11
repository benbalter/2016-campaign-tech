class CampaignTech
  class Candidate

    attr_reader :name, :domain, :party

    def initialize(hash)
      @name   = hash[:name]
      @domain = hash[:domain]
      @party  = hash[:party].upcase
    end

    def inspector
      @inspector||= SiteInspector.inspect domain
    end

    def republican?
      party == "R"
    end

    def democrat?
      party == "D"
    end

    def crawl
      @crawl ||= crawl!
    end

    def inspect
      "#<CampaignTech::Candidate name=\"#{name}\">"
    end

    def method_missing(method_sym, *arguments, &block)
      if crawl.keys.any? { |key| key == method_sym }
        crawl[method_sym]
      else
        super
      end
    end

    def respond_to?(method_sym, include_private = false)
      if crawl.keys.any? { |key| key == method_sym }
        true
      else
        super
      end
    end

    private

    def crawl!

      #Speed up crawl by prefetching potential endpoints in parallel
      inspector.prefetch

      {
        :name               => name,
        :party              => party,
        :domain             => inspector.host,
        :www?               => inspector.www?,
        :non_www?           => inspector.root?,
        :https?             => inspector.https?,
        :enforces_https?    => inspector.enforces_https?,
        :downgrades_https?  => inspector.downgrades_https?,
        :canonically_www?   => inspector.canonically_www?,
        :canonically_https? => inspector.canonically_https?,
        :hsts?              => inspector.hsts?,
        :hsts_preload?      => inspector.canonical_endpoint.hsts.preload?,
        :sitemap?           => inspector.canonical_endpoint.content.sitemap_xml?,
        :robots_txt?        => inspector.canonical_endpoint.content.robots_txt?,
        :humans_txt?        => inspector.canonical_endpoint.content.humans_txt?,
        :proper_404s?       => inspector.canonical_endpoint.content.proper_404s?,
        :dnssec?            => inspector.canonical_endpoint.dns.dnssec?,
        :ipv6?              => inspector.canonical_endpoint.dns.ipv6?,
        :cloud_provider     => inspector.canonical_endpoint.dns.cloud_provider,
        :google_apps?       => inspector.canonical_endpoint.dns.google_apps?,
        :server             => inspector.canonical_endpoint.headers.server,
        :open_source?       => inspector.canonical_endpoint.sniffer.open_source?,
        :framework          => inspector.canonical_endpoint.sniffer.framework,
      }
    end
  end
end
