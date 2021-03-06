module StocksHelper
  def asi_component_industry(name)
    risk_profile = {
      "Accident & Health Insurance" => 1.39333333333333,
      "Advertising Agencies" => 1.73625,
      "Aerospace/Defense - Major Diversified" => 1.548,
      "Aerospace/Defense Products & Services" => 1.14605263157895,
      "Agricultural Chemicals" => 1.22692307692308,
      "Air Delivery & Freight Services" => 1.19272727272727,
      "Air Services, Other" => 1.50571428571429,
      "Aluminum" => 2.13,
      "Apparel Stores" => 1.49238095238095,
      "Appliances" => 1.23333333333333,
      "Application Software" => 1.28308823529412,
      "Asset Management" => 1.5638,
      "Auto Dealerships" => 1.744,
      "Auto Manufacturers - Major" => 1.53285714285714,
      "Auto Parts" => 1.99818181818182,
      "Auto Parts Stores" => 0.86,
      "Auto Parts Wholesale" => 0.444,
      "Basic Materials Wholesale" => 1.538,
      "Beverages - Brewers" => 0.837142857142857,
      "Beverages - Soft Drinks" => 0.929375,
      "Beverages - Wineries & Distillers" => 1.15666666666667,
      "Biotechnology" => 1.35624161073825,
      "Broadcasting - Radio" => 1.958,
      "Broadcasting - TV" => 2.23142857142857,
      "Building Materials Wholesale" => 1.71,
      "Business Equipment" => 1.248,
      "Business Services" => 1.27717647058824,
      "Business Software & Services" => 1.17377358490566,
      "Catalog & Mail Order Houses" => 1.41230769230769,
      "CATV Systems" => 1.366875,
      "Cement" => 1.712,
      "Chemicals - Major Diversified" => 1.25357142857143,
      "Cigarettes" => 0.731428571428571,
      "Cleaning Products" => 0.834,
      "Closed-End Fund - Debt" => 0.346964285714286,
      "Closed-End Fund - Equity" => 1.00355769230769,
      "Closed-End Fund - Foreign" => 1.23636363636364,
      "Communication Equipment" => 1.27132352941177,
      "Computer Based Systems" => 0.948571428571429,
      "Computer Peripherals" => 1.4525,
      "Computers Wholesale" => 0.6325,
      "Confectioners" => 0.7,
      "Conglomerates" => 1.2125,
      "Consumer Services" => 0.508571428571429,
      "Copper" => 1.95333333333333,
      "Credit Services" => 1.48,
      "Dairy Products" => 1.1575,
      "Data Storage Devices" => 1.55823529411765,
      "Department Stores" => 1.82888888888889,
      "Diagnostic Substances" => 1.13058823529412,
      "Discount, Variety Stores" => 0.895,
      "Diversified Communication Services" => 1.26192307692308,
      "Diversified Computer Systems" => 1.168,
      "Diversified Electronics" => 1.38042553191489,
      "Diversified Investments" => 0.928275862068966,
      "Diversified Machinery" => 1.43711538461538,
      "Diversified Utilities" => 0.597,
      "Drug Delivery" => 1.28933333333333,
      "Drug Manufacturers - Major" => 1.10681818181818,
      "Drug Manufacturers - Other" => 1.24860465116279,
      "Drug Related Products" => 1.06777777777778,
      "Drug Stores" => 1.19714285714286,
      "Drugs - Generic" => 1.14416666666667,
      "Drugs Wholesale" => 0.776666666666667,
      "Education & Training Services" => 0.86448275862069,
      "Electric Utilities" => 0.696274509803921,
      "Electronic Equipment" => 1.12692307692308,
      "Electronics Stores" => 1.254,
      "Electronics Wholesale" => 1.31733333333333,
      "Entertainment - Diversified" => 1.496,
      "Exchange Traded Fund" => 1.09656346749226,
      "Farm & Construction Machinery" => 1.91214285714286,
      "Farm Products" => 1.22666666666667,
      "Food - Major Diversified" => 0.648181818181818,
      "Food Wholesale" => 0.63,
      "Foreign Money Center Banks" => 1.75727272727273,
      "Foreign Regional Banks" => 1.70875,
      "Foreign Utilities" => 0.956666666666667,
      "Gaming Activities" => 1.38,
      "Gas Utilities" => 0.672307692307692,
      "General Building Materials" => 1.60590909090909,
      "General Contractors" => 1.36333333333333,
      "General Entertainment" => 1.4,
      "Gold" => 0.845555555555556,
      "Grocery Stores" => 0.765294117647059,
      "Health Care Plans" => 1.20866666666667,
      "Healthcare Information Services" => 0.834,
      "Heavy Construction" => 1.4195,
      "Home Furnishing Stores" => 1.908,
      "Home Furnishings & Fixtures" => 1.934375,
      "Home Health Care" => 0.73,
      "Home Improvement Stores" => 1.2575,
      "Hospitals" => 1.35222222222222,
      "Housewares & Accessories" => 1.5,
      "Independent Oil & Gas" => 1.38784946236559,
      "Industrial Electrical Equipment" => 1.414,
      "Industrial Equipment & Components" => 1.59772727272727,
      "Industrial Equipment Wholesale" => 1.19583333333333,
      "Industrial Metals & Minerals" => 1.78237288135593,
      "Information & Delivery Services" => 1.089,
      "Information Technology Services" => 1.30692307692308,
      "Insurance Brokers" => 0.9,
      "Internet Information Providers" => 1.48807692307692,
      "Internet Service Providers" => 1.32,
      "Internet Software & Services" => 1.265,
      "Investment Brokerage - National" => 1.29058823529412,
      "Investment Brokerage - Regional" => 1.05615384615385,
      "Jewelry Stores" => 1.88,
      "Life Insurance" => 1.9296,
      "Lodging" => 1.98083333333333,
      "Long Distance Carriers" => 0.78,
      "Long-Term Care Facilities" => 1.69923076923077,
      "Lumber, Wood Production" => 1.40166666666667,
      "Machine Tools & Accessories" => 1.74,
      "Major Airlines" => 1.685,
      "Major Integrated Oil & Gas" => 1.07625,
      "Management Services" => 1.08875,
      "Manufactured Housing" => 0.85,
      "Marketing Services" => 1.49454545454545,
      "Meat Products" => 1.36875,
      "Medical Appliances & Equipment" => 1.07986842105263,
      "Medical Equipment Wholesale" => 1.00571428571429,
      "Medical Instruments & Supplies" => 0.895322580645161,
      "Medical Laboratories & Research" => 0.8375,
      "Medical Practitioners" => 1.54333333333333,
      "Metal Fabrication" => 1.621875,
      "Money Center Banks" => 1.13833333333333,
      "Mortgage Investment" => 1.38214285714286,
      "Movie Production, Theaters" => 0.926,
      "Multimedia & Graphics Software" => 1.34625,
      "Music & Video Stores" => 0.72,
      "Networking & Communication Devices" => 1.2835,
      "Nonmetallic Mineral Mining" => 1.61,
      "Office Supplies" => 1.795,
      "Oil & Gas Drilling & Exploration" => 1.53694915254237,
      "Oil & Gas Equipment & Services" => 1.68931818181818,
      "Oil & Gas Pipelines" => 0.668125,
      "Oil & Gas Refining & Marketing" => 1.19923076923077,
      "Packaging & Containers" => 1.285,
      "Paper & Paper Products" => 2.02823529411765,
      "Personal Computers" => 1.31,
      "Personal Products" => 1.11388888888889,
      "Personal Services" => 0.78,
      "Photographic Equipment & Supplies" => 1.03666666666667,
      "Pollution & Treatment Controls" => 1.496,
      "Printed Circuit Boards" => 1.71411764705882,
      "Processed & Packaged Goods" => 0.903823529411765,
      "Processing Systems & Products" => 1.44666666666667,
      "Property & Casualty Insurance" => 0.936578947368421,
      "Property Management" => 1.36892857142857,
      "Publishing - Books" => 1.02571428571429,
      "Publishing - Newspapers" => 2.37,
      "Publishing - Periodicals" => 1.08333333333333,
      "Railroads" => 1.502,
      "Real Estate Development" => 1.225,
      "Recreational Goods, Other" => 1.86272727272727,
      "Recreational Vehicles" => 2.08,
      "Regional - Mid-Atlantic Banks" => 0.832471910112359,
      "Regional - Midwest Banks" => 0.96,
      "Regional - Northeast Banks" => 0.627619047619047,
      "Regional - Pacific Banks" => 1.00269230769231,
      "Regional - Southeast Banks" => 0.667837837837838,
      "Regional - Southwest  Banks" => 0.7948,
      "Regional Airlines" => 1.02166666666667,
      "REIT - Diversified" => 1.39222222222222,
      "REIT - Healthcare Facilities" => 1.014,
      "REIT - Hotel/Motel" => 2.282,
      "REIT - Industrial" => 1.31615384615385,
      "REIT - Office" => 1.28733333333333,
      "REIT - Residential" => 1.13380952380952,
      "REIT - Retail" => 1.54055555555556,
      "Rental & Leasing Services" => 1.71666666666667,
      "Research Services" => 0.913846153846154,
      "Residential Construction" => 1.75588235294118,
      "Resorts & Casinos" => 1.92130434782609,
      "Restaurants" => 1.34674418604651,
      "Rubber & Plastics" => 1.20230769230769,
      "Savings & Loans" => 0.725619047619048,
      "Scientific & Technical Instruments" => 1.29320754716981,
      "Security & Protection Services" => 1.0775,
      "Security Software & Services" => 1.22625,
      "Semiconductor - Broad Line" => 1.60636363636364,
      "Semiconductor - Integrated Circuits" => 1.63264150943396,
      "Semiconductor - Specialized" => 1.52181818181818,
      "Semiconductor Equipment & Materials" => 1.69875,
      "Semiconductor- Memory Chips" => 2.06571428571429,
      "Shipping" => 1.48714285714286,
      "Silver" => 1.34666666666667,
      "Small Tools & Accessories" => 1.19375,
      "Specialized Health Services" => 1.046875,
      "Specialty Chemicals" => 1.59576923076923,
      "Specialty Eateries" => 1.11,
      "Specialty Retail, Other" => 1.58612903225806,
      "Sporting Activities" => 1.32166666666667,
      "Sporting Goods" => 1.243,
      "Sporting Goods Stores" => 1.4525,
      "Staffing & Outsourcing Services" => 1.44772727272727,
      "Steel & Iron" => 1.82965517241379,
      "Surety & Title Insurance" => 1.27333333333333,
      "Synthetics" => 1.025,
      "Technical & System Software" => 1.25105263157895,
      "Technical Services" => 1.10722222222222,
      "Telecom Services - Domestic" => 0.863684210526316,
      "Telecom Services - Foreign" => 0.982631578947369,
      "Textile - Apparel Clothing" => 1.51444444444444,
      "Textile - Apparel Footwear & Accessories" => 1.11285714285714,
      "Textile Industrial" => 1.88,
      "Tobacco Products, Other" => 0.89,
      "Toy & Hobby Stores" => 1.65,
      "Toys & Games" => 1.33857142857143,
      "Trucking" => 1.27,
      "Trucks & Other Vehicles" => 1.77857142857143,
      "Waste Management" => 1.00473684210526,
      "Water Utilities" => 0.481818181818182,
      "Wholesale, Other" => 1.39,
      "Wireless Communications" => 1.12921052631579
    }
    if risk_profile[name].to_f >= 0.346964286 && risk_profile[name].to_f <= 0.549267857 #decile 1
            return 1
      elsif risk_profile[name].to_f > 0.549267857 && risk_profile[name].to_f < 0.751571429 #declie 2
            return 2
      elsif risk_profile[name].to_f > 0.751571429 && risk_profile[name].to_f < 0.953875 #declie 3
            return 3
      elsif risk_profile[name].to_f > 0.953875 && risk_profile[name].to_f < 1.156178571 #declie 4
            return 4
      elsif risk_profile[name].to_f > 1.156178571 && risk_profile[name].to_f < 1.358482143 #declie 5
            return 5
      elsif risk_profile[name].to_f > 1.358482143 && risk_profile[name].to_f < 1.560785714 #declie 6
            return 6
      elsif risk_profile[name].to_f > 1.560785714 && risk_profile[name].to_f < 1.763089286 #declie 7
            return 7
      elsif risk_profile[name].to_f > 1.763089286 && risk_profile[name].to_f < 1.965392857 #declie 8
            return 8
      elsif risk_profile[name].to_f > 1.965392857 && risk_profile[name].to_f < 2.167696429 #declie 9
            return 9
      else  #declie 10
            return 10
      end
  end

  # def beta_to_asi(beta)
  #     if beta >= 0.346964286 && beta <= 0.549267857 #decile 1
  #           return 1
  #     elsif beta > 0.549267857 && beta < 0.751571429 #declie 2
  #           return 2
  #     elsif beta > 0.751571429 && beta < 0.953875 #declie 3
  #           return 3
  #     elsif beta > 0.953875 && beta < 1.156178571 #declie 4
  #           return 4
  #     elsif beta > 1.156178571 && beta < 1.358482143 #declie 5
  #           return 5
  #     elsif beta > 1.358482143 && beta < 1.560785714 #declie 6
  #           return 6
  #     elsif beta > 1.560785714 && beta < 1.763089286 #declie 7
  #           return 7
  #     elsif beta > 1.763089286 && beta < 1.965392857 #declie 8
  #           return 8
  #     elsif beta > 1.965392857 && beta < 2.167696429 #declie 9
  #           return 9
  #     else  #declie 10
  #           return 10
  #     end
  # end

end


