require 'csv'
require 'json'
require 'HTTParty'


class StocksController < ApplicationController
    def recommendations
        @winners = []
        Stock.all.each do |i|
            if !i.pe_v_ind.nil? && !i.pe.nil?
                if (i.peg < i.peg_v_ind) && (i.eps > i.eps_v_ind)
                    @winners << i
                end
            end
        end
        render 'recommendations'
    end

	def populate_data
        url = 'http://finance.yahoo.com/d/quotes.csv?s='
        connect = "&f="
        eps = "e"
        pe = "r"
        peg = "r5"
        pbook = "p6"
        psales = "p5"
        markcap = "j1"
        ask = "a"
        bid = "b"
        book_value = "b4"

        Stock.all.each do |symbol|
          full_url = url + symbol.ticker + connect + eps + pe + pbook + psales + markcap + ask + bid + peg + book_value
          response = HTTParty.get(full_url)
          parsed = CSV.parse(response)[0]
          symbol.update_attributes(eps: parsed[0].to_f,
            pe: parsed[1].to_f,
            pbook: parsed[2].to_f,
            psales: parsed[3].to_f,
            markcap: parsed[4].to_f * 1000000000,
            ask: parsed[5].to_f,
            bid: parsed[6].to_f,
            peg: parsed[7].to_f,
            book_value: parsed[8].to_f * 1000000000
            )

          shares = symbol.markcap/((symbol.ask + symbol.bid)/2)

          if symbol.eps >= 0 && symbol.book_value >= 0 && shares >= 0
            gnum = Math.sqrt(22.5 * symbol.eps * (symbol.book_value/shares))
        else
            gnum = 0
        end
        symbol.update_attributes(graham_number: gnum, shares: shares)
    end
end

def index
    if !Stock.find_by(id: 1)
      make_dict
  end
  if !Stock.find_by(id: 2).pe
      populate_data
  else
    update_versus_index
  end
  @stocks = Stock.all
  render 'index'
end

def update_versus_index
  Stock.all.each do |symbol|
    if !Industry.find_by(name: symbol.industry).nil?
      industry = Industry.find_by(name: symbol.industry)
      symbol.update_attributes(
        eps_v_ind: (symbol.eps - industry.eps),
        pe_v_ind: (symbol.pe - industry.pe),
        pbook_v_ind: (symbol.pbook - industry.pbook),
        psales_v_ind: (symbol.psales - industry.psales),
        markcap_v_ind: (symbol.markcap - industry.markcap),
        peg_v_ind: (symbol.peg - industry.peg),
        book_value_v_ind: (symbol.book_value - industry.book_value),
        shares_v_ind: (symbol.shares - industry.shares),
        graham_number_v_ind: (symbol.graham_number - industry.graham_number)
        )
    end
  end
end

def make_dict
    sandp = ["MMM+3M Company+Industrial Conglomerates",
        "ABT+Abbott Laboratories+Health Care Equipment & Services",
        "ABBV+AbbVie+Pharmaceuticals",
        "ACN+Accenture plc+IT Consulting & Other Services",
        "ACE+ACE Limited+Property & Casualty Insurance",
        "ADBE+Adobe Systems Inc+Application Software",
        "ADT+ADT Corp+Diversified Commercial Services",
        "AAP+Advance Auto Parts+Automotive Retail",
        "AES+AES Corp+Independent Power Producers & Energy Traders",
        "AET+Aetna Inc+Managed Health Care",
        "AFL+AFLAC Inc+Life & Health Insurance",
        "AMG+Affiliated Managers Group Inc+Asset Management & Custody Banks",
        "A+Agilent Technologies Inc+Health Care Equipment & Services",
        "GAS+AGL Resources Inc.+Gas Utilities",
        "APD+Air Products & Chemicals Inc+Industrial Gases",
        "ARG+Airgas Inc+Industrial Gases",
        "AKAM+Akamai Technologies Inc+Internet Software & Services",
        "AA+Alcoa Inc+Aluminum",
        "AGN+Allergan plc+Pharmaceuticals",
        "ALXN+Alexion Pharmaceuticals+Biotechnology",
        "ALLE+Allegion+Building Products",
        "ADS+Alliance Data Systems+Data Processing & Outsourced Services",
        "ALL+Allstate Corp+Property & Casualty Insurance",
        "ALTR+Altera Corp+Semiconductors",
        "MO+Altria Group Inc+Tobacco",
        "AMZN+Amazon.com Inc+Internet Retail",
        "AEE+Ameren Corp+MultiUtilities",
        "AAL+American Airlines Group+Airlines",
        "AEP+American Electric Power+Electric Utilities",
        "AXP+American Express Co+Consumer Finance",
        "AIG+American International Group, Inc.+Property & Casualty Insurance",
        "AMT+American Tower Corp A+Specialized REITs",
        "AMP+Ameriprise Financial+Diversified Financial Services",
        "ABC+AmerisourceBergen Corp+Health Care Distribution & Services",
        "AME+Ametek+Electrical Components & Equipment",
        "AMGN+Amgen Inc+Biotechnology",
        "APH+Amphenol Corp A+Electrical Components & Equipment",
        "APC+Anadarko Petroleum Corp+Oil & Gas Exploration & Production",
        "ADI+Analog Devices, Inc.+Semiconductors",
        "AON+Aon plc+Insurance Brokers",
        "APA+Apache Corporation+Oil & Gas Exploration & Production",
        "AIV+Apartment Investment & Mgmt+REITs",
        "AAPL+Apple Inc.+Computer Hardware",
        "AMAT+Applied Materials Inc+Semiconductor Equipment",
        "ADM+Archer-Daniels-Midland Co+Agricultural Products",
        "AIZ+Assurant Inc+Multi-line Insurance",
        "T+AT&T Inc+Integrated Telecommunications Services",
        "ADSK+Autodesk Inc+Application Software",
        "ADP+Automatic Data Processing+Internet Software & Services",
        "AN+AutoNation Inc+Specialty Stores",
        "AZO+AutoZone Inc+Specialty Stores",
        "AVGO+Avago Technologies+Semiconductors",
        "AVB+AvalonBay Communities, Inc.+Residential REITs",
        "AVY+Avery Dennison Corp+Paper Packaging",
        "BHI+Baker Hughes Inc+Oil & Gas Equipment & Services",
        "BLL+Ball Corp+Metal & Glass Containers",
        "BAC+Bank of America Corp+Banks",
        "BK+The Bank of New York Mellon Corp.+Banks",
        "BCR+Bard (C.R.) Inc.+Health Care Equipment & Services",
        "BXLT+Baxalta+Biotechnology",
        "BAX+Baxter International Inc.+Health Care Equipment & Services",
        "BBT+BB&T Corporation+Banks",
        "BDX+Becton Dickinson+Health Care Equipment & Services",
        "BBBY+Bed Bath & Beyond+Specialty Stores",
        "BRK-B+Berkshire Hathaway+Multi-Sector Holdings",
        "BBY+Best Buy Co. Inc.+Computer & Electronics Retail",
        "BIIB+BIOGEN IDEC Inc.+Biotechnology",
        "BLK+BlackRock+Asset Management & Custody Banks",
        "HRB+Block H&R+Consumer Finance",
        "BA+Boeing Company+Aerospace & Defense",
        "BWA+BorgWarner+Auto Parts & Equipment",
        "BXP+Boston Properties+REITs",
        "BSX+Boston Scientific+Health Care Equipment & Services",
        "BMY+Bristol-Myers Squibb+Health Care Distributors & Services",
        "BRCM+Broadcom Corporation+Semiconductors",
        "BF-B+Brown-Forman Corporation+Distillers & Vintners",
        "CHRW+C. H. Robinson Worldwide+Air Freight & Logistics",
        "CA+CA, Inc.+Systems Software",
        "CVC+Cablevision Systems Corp.+Broadcasting & Cable TV",
        "COG+Cabot Oil & Gas+Oil & Gas Exploration & Production",
        "CAM+Cameron International Corp.+Oil & Gas Equipment & Services",
        "CPB+Campbell Soup+Packaged Foods & Meats",
        "COF+Capital One Financial+Consumer Finance",
        "CAH+Cardinal Health Inc.+Health Care Distributors & Services",
        "HSIC+Henry Schein+Health Care Distributors",
        "KMX+Carmax Inc+Specialty Stores",
        "CCL+Carnival Corp.+Hotels, Resorts & Cruise Lines",
        "CAT+Caterpillar Inc.+Construction & Farm Machinery & Heavy Trucks",
        "CBG+CBRE Group+Real Estate Services",
        "CBS+CBS Corp.+Broadcasting & Cable TV",
        "CELG+Celgene Corp.+Biotechnology",
        "CNP+CenterPoint Energy+MultiUtilities",
        "CTL+CenturyLink Inc+Integrated Telecommunications Services",
        "CERN+Cerner+Health Care Distributors & Services",
        "CF+CF Industries Holdings Inc+Fertilizers & Agricultural Chemicals",
        "SCHW+Charles Schwab Corporation+Investment Banking & Brokerage",
        "CHK+Chesapeake Energy+Integrated Oil & Gas",
        "CVX+Chevron Corp.+Integrated Oil & Gas",
        "CMG+Chipotle Mexican Grill+Restaurants",
        "CB+Chubb Corp.+Property & Casualty Insurance",
        "CI+CIGNA Corp.+Managed Health Care",
        "XEC+Cimarex Energy+Oil & Gas Exploration & Production",
        "CINF+Cincinnati Financial+Property & Casualty Insurance",
        "CTAS+Cintas Corporation+Diversified Support Services",
        "CSCO+Cisco Systems+Networking Equipment",
        "C+Citigroup Inc.+Banks",
        "CTXS+Citrix Systems+Internet Software & Services",
        "CLX+The Clorox Company+Household Products",
        "CME+CME Group Inc.+Diversified Financial Services",
        "CMS+CMS Energy+MultiUtilities",
        "COH+Coach Inc.+Apparel, Accessories & Luxury Goods",
        "KO+The Coca Cola Company+Soft Drinks",
        "CCE+Coca-Cola Enterprises+Soft Drinks",
        "CTSH+Cognizant Technology Solutions+IT Consulting & Services",
        "CL+Colgate-Palmolive+Household Products",
        "CPGX+Columbia Pipeline Group Inc+Oil & Gas Storage & Transportation",
        "CMCSA+Comcast Corp.+Broadcasting & Cable TV",
        "CMA+Comerica Inc.+Banks",
        "CSC+Computer Sciences Corp.+IT Consulting & Services",
        "CAG+ConAgra Foods Inc.+Packaged Foods & Meats",
        "COP+ConocoPhillips+Oil & Gas Exploration & Production",
        "CNX+CONSOL Energy Inc.+Coal & Consumable Fuels",
        "ED+Consolidated Edison+Electric Utilities",
        "STZ+Constellation Brands+Distillers & Vintners",
        "GLW+Corning Inc.+Construction & Engineering",
        "COST+Costco Co.+Hypermarkets & Super Centers",
        "CCI+Crown Castle International Corp.+REITs",
        "CSX+CSX Corp.+Railroads",
        "CMI+Cummins Inc.+Industrial Machinery",
        "CVS+CVS Caremark Corp.+Drug Retail",
        "DHI+D. R. Horton+Homebuilding",
        "DHR+Danaher Corp.+Industrial Machinery",
        "DRI+Darden Restaurants+Restaurants",
        "DVA+DaVita Inc.+Health Care Facilities",
        "DE+Deere & Co.+Construction & Farm Machinery & Heavy Trucks",
        "DLPH+Delphi Automotive+Auto Parts & Equipment",
        "DAL+Delta Air Lines+Airlines",
        "XRAY+Dentsply International+Health Care Supplies",
        "DVN+Devon Energy Corp.+Oil & Gas Exploration & Production",
        "DO+Diamond Offshore Drilling+Oil & Gas Drilling",
        "DFS+Discover Financial Services+Consumer Finance",
        "DISCA+Discovery Communications-A+Broadcasting & Cable TV",
        "DISCK+Discovery Communications-C+Broadcasting & Cable TV",
        "DG+Dollar General+General Merchandise Stores",
        "DLTR+Dollar Tree+General Merchandise Stores",
        "D+Dominion Resources+Electric Utilities",
        "DOV+Dover Corp.+Industrial Machinery",
        "DOW+Dow Chemical+Diversified Chemicals",
        "DPS+Dr Pepper Snapple Group+Soft Drinks",
        "DTE+DTE Energy Co.+MultiUtilities",
        "DD+Du Pont (E.I.)+Diversified Chemicals",
        "DUK+Duke Energy+Electric Utilities",
        "DNB+Dun & Bradstreet+Data Processing Services",
        "ETFC+E*Trade+Investment Banking & Brokerage",
        "EMN+Eastman Chemical+Diversified Chemicals",
        "ETN+Eaton Corporation+Industrial Conglomerates",
        "EBAY+eBay Inc.+Internet Software & Services",
        "ECL+Ecolab Inc.+Specialty Chemicals",
        "EIX+Edison Int'l+Electric Utilities",
        "EW+Edwards Lifesciences+Health Care Equipment & Services",
        "EA+Electronic Arts+Home Entertainment Software",
        "EMC+EMC Corp.+IT Consulting & Services",
        "EMR+Emerson Electric Company+Industrial Conglomerates",
        "ENDP+Endo International+Pharmaceuticals",
        "ESV+Ensco plc+Oil & Gas Drilling",
        "ETR+Entergy Corp.+Electric Utilities",
        "EOG+EOG Resources+Oil & Gas Exploration & Production",
        "EQT+EQT Corporation+Oil & Gas Exploration & Production",
        "EFX+Equifax Inc.+Diversified Financial Services",
        "EQIX+Equinix+Internet Software & Services",
        "EQR+Equity Residential+REITs",
        "ESS+Essex Property Trust Inc+Residential REITs",
        "EL+Estee Lauder Cos.+Personal Products",
        "ES+Eversource Energy+MultiUtilities",
        "EXC+Exelon Corp.+MultiUtilities",
        "EXPE+Expedia Inc.+Hotels, Resorts & Cruise Lines",
        "EXPD+Expeditors Int'l+Air Freight & Logistics",
        "ESRX+Express Scripts+Health Care Distributors & Services",
        "XOM+Exxon Mobil Corp.+Integrated Oil & Gas",
        "FFIV+F5 Networks+Networking Equipment",
        "FB+Facebook+Internet Software & Services",
        "FAST+Fastenal Co+Building Products",
        "FDX+FedEx Corporation+Air Freight & Logistics",
        "FIS+Fidelity National Information Services+Internet Software & Services",
        "FITB+Fifth Third Bancorp+Banks",
        "FSLR+First Solar Inc+Semiconductors",
        "FE+FirstEnergy Corp+Electric Utilities",
        "FISV+Fiserv Inc+Internet Software & Services",
        "FLIR+FLIR Systems+Aerospace & Defense",
        "FLS+Flowserve Corporation+Industrial Machinery",
        "FLR+Fluor Corp.+Diversified Commercial Services",
        "FMC+FMC Corporation+Diversified Chemicals",
        "FTI+FMC Technologies Inc.+Oil & Gas Equipment & Services",
        "F+Ford Motor+Automobile Manufacturers",
        "FOSL+Fossil, Inc.+Apparel, Accessories & Luxury Goods",
        "BEN+Franklin Resources+Asset Management & Custody Banks",
        "FCX+Freeport-McMoran Cp & Gld+Diversified Metals & Mining",
        "FTR+Frontier Communications+Integrated Telecommunications Services",
        "GME+GameStop Corp.+Computer & Electronics Retail",
        "GPS+Gap (The)+Apparel Retail",
        "GRMN+Garmin Ltd.+Consumer Electronics",
        "GD+General Dynamics+Aerospace & Defense",
        "GE+General Electric+Industrial Conglomerates",
        "GGP+General Growth Properties Inc.+REITs",
        "GIS+General Mills+Packaged Foods & Meats",
        "GM+General Motors+Automobile Manufacturers",
        "GPC+Genuine Parts+Specialty Stores",
        "GNW+Genworth Financial Inc.+Life & Health Insurance",
        "GILD+Gilead Sciences+Biotechnology",
        "GS+Goldman Sachs Group+Investment Banking & Brokerage",
        "GT+Goodyear Tire & Rubber+Tires & Rubber",
        "GOOGL+Google Inc Class A+Internet Software & Services",
        "GOOG+Google Inc Class C+Internet Software & Services",
        "GWW+Grainger (W.W.) Inc.+Industrial Materials",
        "HAL+Halliburton Co.+Oil & Gas Equipment & Services",
        "HBI+Hanesbrands Inc+Apparel, Accessories & Luxury Goods",
        "HOG+Harley-Davidson+Motorcycle Manufacturers",
        "HAR+Harman Int'l Industries+Consumer Electronics",
        "HRS+Harris Corporation+Telecommunications Equipment",
        "HIG+Hartford Financial Svc.Gp.+Property & Casualty Insurance",
        "HAS+Hasbro Inc.+Leisure Products",
        "HCA+HCA Holdings+Health Care Facilities",
        "HCP+HCP Inc.+REITs",
        "HCN+Health Care REIT, Inc.+REITs",
        "HP+Helmerich & Payne+Oil & Gas Drilling",
        "HES+Hess Corporation+Integrated Oil & Gas",
        "HPQ+Hewlett-Packard+Computer Hardware",
        "HD+Home Depot+Home Improvement Retail",
        "HON+Honeywell Int'l Inc.+Industrial Conglomerates",
        "HRL+Hormel Foods Corp.+Packaged Foods & Meats",
        "HSP+Hospira Inc.+Health Care Equipment & Services",
        "HST+Host Hotels & Resorts+REITs",
        "HCBK+Hudson City Bancorp+Thrifts & Mortgage Finance",
        "HUM+Humana Inc.+Managed Health Care",
        "HBAN+Huntington Bancshares+Banks",
        "ITW+Illinois Tool Works+Industrial Machinery",
        "IR+Ingersoll-Rand PLC+Industrial Conglomerates",
        "INTC+Intel Corp.+Semiconductors",
        "ICE+Intercontinental Exchange+Diversified Financial Services",
        "IBM+International Bus. Machines+IT Consulting & Services",
        "IP+International Paper+Paper Products",
        "IPG+Interpublic Group+Advertising",
        "IFF+Intl Flavors & Fragrances+Specialty Chemicals",
        "INTU+Intuit Inc.+Internet Software & Services",
        "ISRG+Intuitive Surgical Inc.+Health Care Equipment & Services",
        "IVZ+Invesco Ltd.+Asset Management & Custody Banks",
        "IRM+Iron Mountain Incorporated+Data Processing Services",
        "JEC+Jacobs Engineering Group+Industrial Conglomerates",
        "JBHT+J. B. Hunt Transport Services+Trucking",
        "JNJ+Johnson & Johnson+Health Care Equipment & Services",
        "JCI+Johnson Controls+Auto Parts & Equipment",
        "JOY+Joy Global Inc.+Industrial Machinery",
        "JPM+JPMorgan Chase & Co.+Banks",
        "JNPR+Juniper Networks+Networking Equipment",
        "KSU+Kansas City Southern+Railroads",
        "K+Kellogg Co.+Packaged Foods & Meats",
        "KEY+KeyCorp+Banks",
        "GMCR+Keurig Green Mountain+Packaged Foods & Meats",
        "KMB+Kimberly-Clark+Household Products",
        "KIM+Kimco Realty+REITs",
        "KMI+Kinder Morgan+Oil & Gas Refining & Marketing & Transportation",
        "KLAC+KLA-Tencor Corp.+Semiconductor Equipment",
        "KSS+Kohl's Corp.+General Merchandise Stores",
        "KHC+Kraft Heinz Co+Packaged Foods & Meats",
        "KR+Kroger Co.+Food Retail",
        "LB+L Brands Inc.+Apparel Retail",
        "LLL+L-3 Communications Holdings+Industrial Conglomerates",
        "LH+Laboratory Corp. of America Holding+Health Care Facilities",
        "LRCX+Lam Research+Semiconductor Equipment",
        "LM+Legg Mason+Asset Management & Custody Banks",
        "LEG+Leggett & Platt+Industrial Conglomerates",
        "LEN+Lennar Corp.+Homebuilding",
        "LVLT+Level 3 Communications+Alternative Carriers",
        "LUK+Leucadia National Corp.+Multi-Sector Holdings",
        "LLY+Lilly (Eli) & Co.+Pharmaceuticals",
        "LNC+Lincoln National+Multi-line Insurance",
        "LLTC+Linear Technology Corp.+Semiconductors",
        "LMT+Lockheed Martin Corp.+Aerospace & Defense",
        "L+Loews Corp.+Multi-Sector Holdings",
        "LOW+Lowe's Cos.+Home Improvement Retail",
        "LYB+LyondellBasell+Diversified Chemicals",
        "MTB+M&T Bank Corp.+Banks",
        "MAC+Macerich+Retail REITs",
        "M+Macy's Inc.+Department Stores",
        "MNK+Mallinckrodt Plc+Pharmaceuticals",
        "MRO+Marathon Oil Corp.+Oil & Gas Exploration & Production",
        "MPC+Marathon Petroleum+Oil & Gas Refining & Marketing & Transportation",
        "MAR+Marriott Int'l.+Hotels, Resorts & Cruise Lines",
        "MMC+Marsh & McLennan+Insurance Brokers",
        "MLM+Martin Marietta Materials+Construction Materials",
        "MAS+Masco Corp.+Building Products",
        "MA+Mastercard Inc.+Internet Software & Services",
        "MAT+Mattel Inc.+Leisure Products",
        "MKC+McCormick & Co.+Packaged Foods & Meats",
        "MCD+McDonald's Corp.+Restaurants",
        "MHFI+McGraw Hill Financial+Diversified Financial Services",
        "MCK+McKesson Corp.+Health Care Distributors & Services",
        "MJN+Mead Johnson+Packaged Foods & Meats",
        "WRK+Westrock Co+Paper Packaging",
        "MDT+Medtronic plc+Health Care Equipment & Services",
        "MRK+Merck & Co.+Pharmaceuticals",
        "MET+MetLife Inc.+Life & Health Insurance",
        "KORS+Michael Kors Holdings+Apparel, Accessories & Luxury Goods",
        "MCHP+Microchip Technology+Semiconductors",
        "MU+Micron Technology+Semiconductors",
        "MSFT+Microsoft Corp.+Systems Software",
        "MHK+Mohawk Industries+Home Furnishings",
        "TAP+Molson Coors Brewing Company+Brewers",
        "MDLZ+Mondelez International+Packaged Foods & Meats",
        "MON+Monsanto Co.+Fertilizers & Agricultural Chemicals",
        "MNST+Monster Beverage+Soft Drinks",
        "MCO+Moody's Corp+Diversified Financial Services",
        "MS+Morgan Stanley+Investment Banking & Brokerage",
        "MOS+The Mosaic Company+Fertilizers & Agricultural Chemicals",
        "MSI+Motorola Solutions Inc.+Telecommunications Equipment",
        "MUR+Murphy Oil+Integrated Oil & Gas",
        "MYL+Mylan N.V.+Pharmaceuticals",
        "NDAQ+NASDAQ OMX Group+Diversified Financial Services",
        "NOV+National Oilwell Varco Inc.+Oil & Gas Equipment & Services",
        "NAVI+Navient+Consumer Finance",
        "NTAP+NetApp+Internet Software & Services",
        "NFLX+Netflix Inc.+Internet Software & Services",
        "NWL+Newell Rubbermaid Co.+Housewares & Specialties",
        "NFX+Newfield Exploration Co+Oil & Gas Exploration & Production",
        "NEM+Newmont Mining Corp. (Hldg. Co.)+Gold",
        "NWSA+News Corp.+Publishing",
        "NEE+NextEra Energy+MultiUtilities",
        "NLSN+Nielsen Holdings+Research & Consulting Services",
        "NKE+Nike+Apparel, Accessories & Luxury Goods",
        "NI+NiSource Inc.+MultiUtilities",
        "NBL+Noble Energy Inc+Oil & Gas Exploration & Production",
        "JWN+Nordstrom+Department Stores",
        "NSC+Norfolk Southern Corp.+Railroads",
        "NTRS+Northern Trust Corp.+Asset Management & Custody Banks",
        "NOC+Northrop Grumman Corp.+Aerospace & Defense",
        "NRG+NRG Energy+Independent Power Producers & Energy Traders",
        "NUE+Nucor Corp.+Steel",
        "NVDA+Nvidia Corporation+Semiconductors",
        "ORLY+O'Reilly Automotive+Specialty Stores",
        "OXY+Occidental Petroleum+Oil & Gas Exploration & Production",
        "OMC+Omnicom Group+Advertising",
        "OKE+ONEOK+Oil & Gas Exploration & Production",
        "ORCL+Oracle Corp.+Application Software",
        "OI+Owens-Illinois Inc+Metal & Glass Containers",
        "PCAR+PACCAR Inc.+Construction & Farm Machinery & Heavy Trucks",
        "PLL+Pall Corp.+Industrial Conglomerates",
        "PH+Parker-Hannifin+Industrial Conglomerates",
        "PDCO+Patterson Companies+Health Care Supplies",
        "PAYX+Paychex Inc.+Internet Software & Services",
        "PYPL+PayPal+Data Processing & Outsourced Services Oil",
        "PNR+Pentair Ltd.+Industrial Conglomerates",
        "PBCT+People's United Financial+Thrifts & Mortgage Finance",
        "POM+Pepco Holdings Inc.+Electric Utilities",
        "PEP+PepsiCo Inc.+Soft Drinks",
        "PKI+PerkinElmer+Health Care Equipment & Services",
        "PRGO+Perrigo+Pharmaceuticals",
        "PFE+Pfizer Inc.+Pharmaceuticals",
        "PCG+PG&E Corp.+MultiUtilities",
        "PM+Philip Morris International+Tobacco",
        "PSX+Phillips 66+Oil & Gas Refining & Marketing & Transportation",
        "PNW+Pinnacle West Capital+MultiUtilities",
        "PXD+Pioneer Natural Resources+Oil & Gas Exploration & Production",
        "PBI+Pitney-Bowes+Office Services & Supplies",
        "PCL+Plum Creek Timber Co.+REITs",
        "PNC+PNC Financial Services+Banks",
        "RL+Polo Ralph Lauren Corp.+Apparel, Accessories & Luxury Goods",
        "PPG+PPG Industries+Diversified Chemicals",
        "PPL+PPL Corp.+Electric Utilities",
        "PX+Praxair Inc.+Industrial Gases",
        "PCP+Precision Castparts+Industrial Conglomerates",
        "PCLN+Priceline.com Inc+Hotels, Resorts & Cruise Lines",
        "PFG+Principal Financial Group+Diversified Financial Services",
        "PG+Procter & Gamble+Personal Products",
        "PGR+Progressive Corp.+Property & Casualty Insurance",
        "PLD+Prologis+Diversified Financial Services",
        "PRU+Prudential Financial+Diversified Financial Services",
        "PEG+Public Serv. Enterprise Inc.+Electric Utilities",
        "PSA+Public Storage+REITs",
        "PHM+Pulte Homes Inc.+Homebuilding",
        "PVH+PVH Corp.+Apparel, Accessories & Luxury Goods",
        "QRVO+Qorvo+Semiconductors",
        "PWR+Quanta Services Inc.+Industrial Conglomerates",
        "QCOM+QUALCOMM Inc.+Semiconductors",
        "DGX+Quest Diagnostics+Health Care Facilities",
        "RRC+Range Resources Corp.+Oil & Gas Exploration & Production",
        "RTN+Raytheon Co.+Aerospace & Defense",
        "O+Realty Income Corporation+Office REITs",
        "RHT+Red Hat Inc.+Systems Software",
        "REGN+Regeneron+Biotechnology",
        "RF+Regions Financial Corp.+Diversified Financial Services",
        "RSG+Republic Services Inc+Industrial Conglomerates",
        "RAI+Reynolds American Inc.+Tobacco",
        "RHI+Robert Half International+Human Resource & Employment Services",
        "ROK+Rockwell Automation Inc.+Industrial Conglomerates",
        "COL+Rockwell Collins+Industrial Conglomerates",
        "ROP+Roper Industries+Industrial Conglomerates",
        "ROST+Ross Stores+Apparel Retail",
        "RCL+Royal Caribbean Cruises Ltd+Hotel, Resorts and Cruise Lines",
        "R+Ryder System+Industrial Conglomerates",
        "CRM+Salesforce.com+Internet Software & Services",
        "SNDK+SanDisk Corporation+Computer Storage & Peripherals",
        "SCG+SCANA Corp+MultiUtilities",
        "SLB+Schlumberger Ltd.+Oil & Gas Equipment & Services",
        "SNI+Scripps Networks Interactive Inc.+Broadcasting & Cable TV",
        "STX+Seagate Technology+Computer Storage & Peripherals",
        "SEE+Sealed Air Corp.(New)+Paper Packaging",
        "SRE+Sempra Energy+MultiUtilities",
        "SHW+Sherwin-Williams+Specialty Chemicals",
        "SIAL+Sigma-Aldrich+Diversified Chemicals",
        "SIG+Signet Jewelers+Specialty Stores",
        "SPG+Simon Property Group Inc+REITs",
        "SWKS+Skyworks Solutions+Semiconductors",
        "SLG+SL Green Realty+Office REITs",
        "SJM+Smucker (J.M.)+Packaged Foods & Meats",
        "SNA+Snap-On Inc.+Household Appliances",
        "SO+Southern Co.+Electric Utilities",
        "LUV+Southwest Airlines+Airlines",
        "SWN+Southwestern Energy+Oil & Gas Exploration & Production",
        "SE+Spectra Energy Corp.+Oil & Gas Refining & Marketing & Transportation",
        "STJ+St Jude Medical+Health Care Equipment & Services",
        "SWK+Stanley Black & Decker+Household Appliances",
        "SPLS+Staples Inc.+Specialty Stores",
        "SBUX+Starbucks Corp.+Restaurants",
        "HOT+Starwood Hotels & Resorts+Hotels, Resorts & Cruise Lines",
        "STT+State Street Corp.+Diversified Financial Services",
        "SRCL+Stericycle Inc+Industrial Conglomerates",
        "SYK+Stryker Corp.+Health Care Equipment & Services",
        "STI+SunTrust Banks+Banks",
        "SYMC+Symantec Corp.+Application Software",
        "SYY+Sysco Corp.+Food Distributors",
        "TROW+T. Rowe Price Group+Diversified Financial Services",
        "TGT+Target Corp.+General Merchandise Stores",
        "TEL+TE Connectivity Ltd.+Electronic Equipment & Instruments",
        "TE+TECO Energy+Electric Utilities",
        "TGNA+Tegna+Publishing",
        "THC+Tenet Healthcare Corp.+Health Care Facilities",
        "TDC+Teradata Corp.+Application Software",
        "TSO+Tesoro Petroleum Co.+Oil & Gas Refining & Marketing & Transportation",
        "TXN+Texas Instruments+Semiconductors",
        "TXT+Textron Inc.+Industrial Conglomerates",
        "HSY+The Hershey Company+Packaged Foods & Meats",
        "TRV+The Travelers Companies Inc.+Property & Casualty Insurance",
        "TMO+Thermo Fisher Scientific+Health Care Equipment & Services",
        "TIF+Tiffany & Co.+Apparel, Accessories & Luxury Goods",
        "TWX+Time Warner Inc.+Broadcasting & Cable TV",
        "TWC+Time Warner Cable Inc.+Broadcasting & Cable TV",
        "TJX+TJX Companies Inc.+Apparel Retail",
        "TMK+Torchmark Corp.+Life & Health Insurance",
        "TSS+Total System Services+Internet Software & Services",
        "TSCO+Tractor Supply Company+Specialty Retail",
        "RIG+Transocean+Oil & Gas Drilling",
        "TRIP+TripAdvisor+Internet Retail",
        "FOXA+Twenty-First Century Fox+Publishing",
        "TSN+Tyson Foods+Packaged Foods & Meats",
        "TYC+Tyco International+Industrial Conglomerates",
        "USB+U.S. Bancorp+Banks",
        "UA+Under Armour+Apparel, Accessories & Luxury Goods",
        "UNP+Union Pacific+Railroads",
        "UNH+United Health Group Inc.+Managed Health Care",
        "UPS+United Parcel Service+Air Freight & Logistics",
        "URI+United Rentals, Inc.+Trading Companies & Distributors",
        "UTX+United Technologies+Industrial Conglomerates",
        "UHS+Universal Health Services, Inc.+Health Care Facilities",
        "UNM+Unum Group+Diversified Financial Services",
        "URBN+Urban Outfitters+Apparel Retail",
        "VFC+V.F. Corp.+Apparel, Accessories & Luxury Goods",
        "VLO+Valero Energy+Oil & Gas Refining & Marketing & Transportation",
        "VAR+Varian Medical Systems+Health Care Equipment & Services",
        "VTR+Ventas Inc+Diversified Financial Services",
        "VRSN+Verisign Inc.+Internet Software & Services",
        "VZ+Verizon Communications+Integrated Telecommunications Services",
        "VRTX+Vertex Pharmaceuticals Inc+Biotechnology",
        "VIAB+Viacom Inc.+Broadcasting & Cable TV",
        "V+Visa Inc.+Internet Software & Services",
        "VNO+Vornado Realty Trust+REITs",
        "VMC+Vulcan Materials+Construction Materials",
        "WMT+Wal-Mart Stores+Hypermarkets & Super Centers",
        "WBA+Walgreens Boots Alliance+Drug Retail",
        "DIS+The Walt Disney Company+Broadcasting & Cable TV",
        "WM+Waste Management Inc.+Environmental Services",
        "WAT+Waters Corporation+Health Care Distributors & Services",
        "ANTM+Anthem Inc.+Managed Health Care",
        "WFC+Wells Fargo+Banks",
        "WDC+Western Digital+Computer Storage & Peripherals",
        "WU+Western Union Co+Internet Software & Services",
        "WY+Weyerhaeuser Corp.+REITs",
        "WHR+Whirlpool Corp.+Household Appliances",
        "WFM+Whole Foods Market+Food Retail",
        "WMB+Williams Cos.+Oil & Gas Exploration & Production",
        "WEC+Wisconsin Energy Corporation+Electric Utilities",
        "WYN+Wyndham Worldwide+Hotels, Resorts & Cruise Lines",
        "WYNN+Wynn Resorts Ltd+Casinos & Gaming",
        "XEL+Xcel Energy Inc+MultiUtilities",
        "XRX+Xerox Corp.+IT Consulting & Services",
        "XLNX+Xilinx Inc+Semiconductors",
        "XL+XL Capital+Property & Casualty Insurance",
        "XYL+Xylem Inc.+Industrial Conglomerates",
        "YHOO+Yahoo Inc.+Internet Software & Services",
        "YUM+Yum! Brands Inc+Restaurants",
        "ZBH+Zimmer Biomet Holdings+Health Care Equipment & Services",
        "ZION+Zions Bancorp+Banks",
        "ZTS+Zoetis+Pharmaceuticals"]

        sandp.each do |i|
          j = i.split("+")
          Stock.create(ticker: j[0], name: j[1], industry: j[2])
      end

  end

end



