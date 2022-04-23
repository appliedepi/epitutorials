pacman::p_load(rio, here, scales, flextable, lubridate, tidyverse, janitor)

messy <- import(file.choose(), sheet = "site_coverage_merged")

messy_xlsx <- openxlsx::read.xlsx(file.choose(), sheet = "site_coverage_merged", fillMergedCells = TRUE)


# import long tidy data
sites_tidy <- import(file.choose(), sheet = "Tidy") %>% 
  mutate(Date = ymd(Date))

# take long data and expand to all possible dates, sites, and fill with "No"
sites_clean <- sites_tidy %>% 
  complete(                  
    Date = seq.Date(
      from = min(Date),
      to = max(Date),
      by = "day"),
    Site = seq(1:14),
    fill = list(Status = "No")) %>% 
  mutate(Province = ifelse(Site %in% 1:7, "A", "B"),
         Province = as_factor(Province),
         Site = as_factor(Site)) 
  
  # create heat tile plot
  ggplot(data = sites_clean, mapping = aes(x = Date, y = Site, fill = Status))+
    geom_tile(color = "white")+
    scale_x_date(
      date_breaks = "day",
      labels = label_date_short())+
    scale_fill_manual(
      values = c(
        "Yes" = "darkgreen",
        "No" = "orange"))+
    theme_minimal()+
    labs(title = "Site coverage")

# Analyze
sites_clean %>% 
  tabyl(Status, Province) %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting() %>% 
  adorn_ns("front") %>% 
  qflextable() %>% 
  add_header_row(values = c("Coverage status by province"), colwidths = c(3))  

sites_clean %>% 
  tabyl(Site, Status) %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting() %>% 
  adorn_ns("front") %>% 
  qflextable() %>% 
  add_header_row(values = c("Coverage status by province"), colwidths = c(3))

sites_clean %>% 
  tabyl(Date, Status) %>% 
  select(-No)
  adorn_percentages() %>% 
  adorn_pct_formatting() %>% 
  adorn_ns("front") %>% 
  qflextable() %>% 
  add_header_row(values = c("Coverage status by province"), colwidths = c(3))
