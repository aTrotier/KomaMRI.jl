plt = Observable{Any}(plot_seq(seq; darkmode, range=[0 30]))
ui = dom"div"(plt)
map!(p->plot_seq(p; darkmode, range=[0 30]), plt, seq_obs)
@js_ w document.getElementById("content").dataset.content = "sequence"
content!(w, "div#content", ui)
