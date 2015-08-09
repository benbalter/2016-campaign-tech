require 'csv'
require 'logger'
require 'parallel'
require 'site-inspector'
require 'terminal-table'
require_relative "./campaign_tech/candidate"

class CampaignTech

  def candidates
    @candidates ||= candidates_from_csv.map do |candidate|
      Candidate.new({
        :name   => candidate["name"],
        :domain => candidate["domain"],
        :party  => candidate["party"]
      })
    end
  end

  def republicans
    candidates_by_party("R")
  end

  def democrats
    candidates_by_party("D")
  end

  def crawl
    Parallel.each(candidates, :progress => "Crawling", :in_threads => 2) do |candidate|
      candidate.crawl
    end
    candidates
  end

  def overview
    options = {
      :headings => ["Check", "Overall", "Republicans", "Democrats"],
      :style    => { :border_i => "|" },
    }
    Terminal::Table.new(options) do |table|
      headings.each do |check|
        next unless check =~ /\?$/
        table.add_row count_row(check)
      end
      table.add_row average_row(:"508_errors")
    end.to_s.split("\n")[1...-1].join("\n")
  end

  def write_to_csv
    CSV.open(csv, "wb") do |csv|
      csv << headings
      crawl.each do |candidate|
        csv << candidate.crawl.values
      end
    end
  end

  private

  def headings
    @headings ||= candidates.first.crawl.keys
  end

  def csv
    @csv ||= File.expand_path "../candidates.csv", File.dirname(__FILE__)
  end

  def candidates_by_party(party)
    candidates.select { |c| c.party == party }
  end

  def candidates_from_csv
    CSV.read(csv, :headers => true)
  end

  # Returns the number of candidates where value of key is truthy
  def count(candidates, key)
    candidates.select { |c| c.crawl[key] }.count
  end

  def average(candidates, key)
    candidates = candidates.map { |c| c.crawl[key] }.compact
    candidates.inject{ |sum, el| sum + el }.to_f / candidates.count.to_f
  end

  def format_fraction(numerator, denominator)
    percent = (100 * numerator.to_f / denominator.to_f).round(2)
    "#{numerator}/#{denominator} (#{percent}%)"
  end

  def count_row(check)
    output = [check]
    [candidates, republicans, democrats].each do |group|
      output.push format_fraction(count(group, check), group.count)
    end
    output
  end

  def average_row(check)
    output = ["#{check} (avg)"]
    [candidates, republicans, democrats].each do |group|
      output.push average(group, check).round(2)
    end
    output
  end
end
