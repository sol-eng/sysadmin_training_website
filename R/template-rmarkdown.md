---
title: {{hugo_session}} {{Topic}}
weight: {{weight + 5}}
tags: ["exercise"]
---

source: <a href="https://colorado.rstudio.com/rsc/{{vanity_url}}" target="_blank">colorado.rstudio.com/rsc/{{vanity_url}}</a>

<script src="/js/iframeResizer.min.js" type="text/javascript"></script>

<div class="responsive-container-rmarkdown">

  <div class="animated-r-wrapper">
    <div class="animated-r-vertical">
      <div class="animated-r-circle"></div>
    </div>
    <div class="animated-r-diagonal"></div>
  </div>

  <iframe id="rmd_iframe"
    src="https://colorado.rstudio.com/rsc/{{vanity_url}}" 
    gesture="media"  allowfullscreen
    scrolling="yes">
  </iframe>
</div>

<!-- <script>
  iFrameResize({ checkOrigin: 'https://colorado.rstudio.com/rsc/' , log: true }, '#rmd_iframe')
</script> -->



