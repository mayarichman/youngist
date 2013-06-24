module Jekyll
  class ContributorIndex < Page
    def initialize(site, base, dir, contributor)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'contributor_index.html')
      self.data['contributor'] = contributor
      contributor_title_prefix = site.config['contributor_title_prefix'] || 'Posts Tagged &ldquo;'
      contributor_title_suffix = site.config['contributor_title_suffix'] || '&rdquo;'
      self.data['title'] = "#{contributor_title_prefix}#{contributor}#{contributor_title_suffix}"
    end
  end
  class ContributorGenerator < Generator
    safe true
    def generate(site)
      contribs = {}
      if site.layouts.key? 'contributor_index'
        dir = site.config['contributor_dir'] || 'contributor'
        
        for post in site.posts
        #   print post.contributor
        # end
        # print site.contributors
        # site.categories.keys.each do |contributor| # makes seperate html pages for tags not contributors, has no problem with categories or tags as key identifier but doesn't like contributors
        #instead of accessing each contributor through keys each look through posts and search for contributor variable
        # site.posts.each do |post|
          # print post.tagline
          # print post.contributors
          # print post.contributors #still not accessible, must update site.rb
        #   if contribs.has_key?(post.contributors)
        #     contribs[post.contributors] << {"url"=>post.url, "title"=>post.data["title"]}
        #   else
        #     contribs[post.contributors] = [{"url"=>post.url, "title"=>post.data["title"]}]
        #   end
        #   write_contributor_index(site, File.join(dir, contribs), contribs)
        end
      end
    end
    def write_contributor_index(site, dir, contributor)
      index = ContributorIndex.new(site, site.source, dir, contributor)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
  	end