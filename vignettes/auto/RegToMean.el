(TeX-add-style-hook
 "RegToMean"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "scrartcl"
    "scrartcl10"
    "preamb"
    "texab")
   (LaTeX-add-labels
    "sec:example"
    "eq:4"
    "eq:6"
    "eq:7"
    "sec:reliability-as-upper"
    "sec:assuming-no-true"
    "sec:two-extreme-cases"
    "sec:important-relations"
    "eq:1"
    "eq:2"))
 :latex)

