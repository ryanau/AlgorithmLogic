class IndustriesController < ApplicationController
  def index
    if !Industry.find_by(id: 1)
      make_dict
    end
    if !Industry.find_by(id: 1).eps
      make_industry_averages
    end
    render 'index'
  end

  def make_industry_averages
    Industry.all.each do |ind|
      ind.update_attributes(
          eps:
          pe:
          pbook:
          psales:
          markcap:
          peg:
          book_value:
          shares:
          graham_number:

        )
    end
  end

  def make_dict
    industries = ["Oil & Gas Drilling", "Oil & Gas Equipment & Services", "Integrated Oil & Gas", "Oil & Gas Exploration & Production", "Oil & Gas Refining & Marketing", "Oil & Gas Storage & Transportation", "Coal & Consumable Fuels", "Commodity Chemicals", "Diversified Chemicals", "Fertilizers & Agricultural Chemicals", "Industrial Gases", "Specialty Chemicals", "Construction Materials", "Metal & Glass Containers", "Paper Packaging", "Aluminum", "Diversified Metals & Mining", "Gold", "Precious Metals & Minerals", "Steel", "Forest Products", "Paper Products", "Aerospace & Defense", "Building Products", "Construction & Engineering", "Electrical Components & Equipment", "Heavy Electrical Equipment", "Industrial Conglomerates", "Construction & Farm Machinery & Heavy Trucks", "Industrial Machinery", "Trading Companies & Distributors", "Commercial Printing", "Environmental & Facilities Services", "Office Services & Supplies", "Diversified Support Services", "Security & Alarm Services", "Human Resource & Employment Services", "Research & Consulting Services", "Air Freight & Logistics", "Airlines", "Marine", "Railroads", "Trucking", "Airport Services", "Highways & Railtracks", "Marine Ports & Services", "Auto Parts & Equipment", "Tires & Rubber", "Automobile Manufacturers", "Motorcycle Manufacturers", "Consumer Electronics", "Home Furnishings", "Homebuilding", "Household Appliances", "Housewares & Specialties", "Leisure Products", "Photographic Products", "Apparel,Acessories & Luxury Goods", "Footwear", "Textiles", "Casinos & Gaming", "Hotels,Rsorts & Cruise Lines", "Leisure Facilities", "Restaurants", "Education Services", "Specialized Consumer Services", "Advertising", "Broadcasting", "Cable & Satellite", "Movies & Entertainment", "Publishing", "Distributors", "Catalog Retail", "Internet Retail", "Department Stores", "General Merchandise Stores", "Apparel Retail", "Computer & Electronics Retail", "Home Improvement Retail", "Specialty Stores", "Automotive Retail", "Homefurnishing Retail", "Drug Retail", "Food Distributors", "Food Retail", "Hypermarkets & Super Centers", "Brewers", "Distillers & Vintners", "Soft Drinks", "Agricultural Products", "Packaged Foods & Meats", "Tobacco", "Household Products", "Personal Products", "Health Care Equipment", "Health Care Supplies", "Health Care Distributors", "Health Care Services", "Health Care Facilities", "Managed Health Care", "Health Care Technology", "Biotechnology", "Pharmaceuticals", "Life Sciences Tools & Services", "Diversified Banks", "Regional Banks", "Thrifts & Mortgage Finance", "Other Diversified Financial Services", "Multi-Sector Holdings", "Specialized Finance", "Consumer Finance", "Asset Management & Custody Banks", "Investment Banking & Brokerage", "Diversified Capital Markets", "Insurance Brokers", "Life & Health Insurance", "Multi-line Insurance", "Property & Casualty Insurance", "Reinsurance", "Diversified REITs", "Industrial REITs", "Mortgage REITs", "Office REITs", "Residential REITs", "Retail REITs", "Specialized REITs", "Diversified Real Estate Activities", "Real Estate Operating Companies", "Real Estate Development", "Real Estate Services", "Internet Software & Services", "IT Consulting & Other Services", "Data Processing & Outsourced Services", "Application Software", "Systems Software", "Home Entertainment Software", "Communications Equipment", "Computer Hardware", "Computer Storage & Peripherals", "Electronic Equipment & Instruments", "Electronic Components", "Electronic Manufacturing Services", "Technology Distributors", "Office Electronics", "Semiconductor Equipment", "Semiconductors", "Alternative Carriers", "Integrated Telecommunication Services", "Wireless Telecommunication Services", "Electric Utilities", "Gas Utilities", "Multi-Utilities", "Water Utilities", "Independent Power Producers & Energy Traders"]

    industries.each do |name|
      Industry.create(name: name)
    end
  end
end

