FROM eclipse-temurin:11-jre

ARG SAXON_HE_REPOSITORY=pl-strflt/Saxon-HE
ARG SAXON_HE_SHA=392d705f7d603b0cfdd4c95fddd3c0a80590a21b

ARG ANT_REPOSITORY=pl-strflt/ant
ARG ANT_SHA=d0b3d9e8c9a975568a6d9efa8884f5db69cb76f3

RUN apt-get update && apt-get install -y unzip jq

RUN curl -L --max-redirs 5 --retry 5 --no-progress-meter --output "SaxonHE11-5J.zip" "https://raw.githubusercontent.com/${SAXON_HE_REPOSITORY}/${SAXON_HE_SHA}/11/Java/SaxonHE11-5J.zip" && \
  unzip "SaxonHE11-5J.zip" -d "/opt/SaxonHE11-5J" && \
  rm "SaxonHE11-5J.zip"
RUN for file in gotest.xsl junit-frames-saxon.xsl junit-noframes-saxon.xsl junit-summary.xsl; do \
  curl -L --max-redirs 5 --retry 5 --no-progress-meter --output "/etc/${file}" "https://raw.githubusercontent.com/${ANT_REPOSITORY}/${ANT_SHA}/src/etc/${file}"; \
  done

ENTRYPOINT ["java", "-jar", "/opt/SaxonHE11-5J/saxon-he-11.5.jar"]
