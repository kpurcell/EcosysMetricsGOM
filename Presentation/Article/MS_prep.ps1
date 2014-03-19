#  Powershell script to collate the manuscript.

# Render the bibliography in markdown
pandoc --biblio comm_ms.bib --csl ecology.csl EcosysMetricsGOM.md -o EcosysMetricsGOM.docx

# merge the FigsTables.md file with the manuscript+references
cat SpatialEffortStudy_PLoS_bib.md, SpatialEffortStudy_FigTables.md > manuscript.md

# convert manuscript.md to .docx
pandoc manuscript.md -o Purcell_etal_PLoS.docx

