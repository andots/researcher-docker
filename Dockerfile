ARG ELASTIC_VER
FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VER}

ARG SUDACHI_PLUGIN_URL
ARG SUDACHI_DICT_URL
ARG SUDACHI_DICT_DIR_NAME
ARG SUDACHI_DICT_ZIP

# ! Install plugins
# Japanese Analyser
# https://github.com/WorksApplications/elasticsearch-sudachi
# get sudachi dict and unzip it, must rename sytem_full.dic to system_core.dic
# then copy it to /use/share/elasticsearch/config/sudachi/system_core.dic
RUN elasticsearch-plugin install ${SUDACHI_PLUGIN_URL}
RUN curl -Lo ${SUDACHI_DICT_ZIP} ${SUDACHI_DICT_URL} && \
    unzip ${SUDACHI_DICT_ZIP} && \
    mkdir -p /usr/share/elasticsearch/config/sudachi/ && \
    mv ${SUDACHI_DICT_DIR_NAME}/system_full.dic /usr/share/elasticsearch/config/sudachi/system_core.dic && \
    rm -rf ${SUDACHI_DICT_ZIP} ${SUDACHI_DICT_DIR_NAME}/
COPY sudachi.json /usr/share/elasticsearch/config/sudachi/

# Chinese Analyser
# https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html
RUN elasticsearch-plugin install analysis-smartcn

# Korean Analyser
# https://www.elastic.co/guide/en/elasticsearch/plugins/master/analysis-nori.html
RUN elasticsearch-plugin install analysis-nori

# German Dictionary
RUN curl -LO https://raw.githubusercontent.com/uschindler/german-decompounder/master/de_DR.xml && \
    curl -LO https://raw.githubusercontent.com/uschindler/german-decompounder/master/dictionary-de.txt && \
    mkdir -p /usr/share/elasticsearch/config/analysis/de && \
    mv de_DR.xml /usr/share/elasticsearch/config/analysis/de && \
    mv dictionary-de.txt /usr/share/elasticsearch/config/analysis/de

# language detector
# https://github.com/spinscale/elasticsearch-ingest-langdetect
# RUN elasticsearch-plugin install ${INJEST_LANGDETECT_URL}

# ICU Analyser
# https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html
# RUN elasticsearch-plugin install analysis-icu
