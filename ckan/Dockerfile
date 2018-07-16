FROM quay.io/okfn/python2:1.0.0

ENV APP_WSGI=ckan.wsgi

ENV GIT_BRANCH=release-v2.6-latest
ENV GIT_URL=https://github.com/ckan/ckan.git

ENV CKAN_INI=production.ini
ENV SRC_DIR=${APP_DIR}/src

RUN mkdir ${WORKSPACE} ${SRC_DIR} && cd ${SRC_DIR} && \
    git clone -b ${GIT_BRANCH} --depth=1 --single-branch \
    ${GIT_URL}  ckan && \
    cd ckan && \
    cp who.ini ${APP_DIR} && \
    python setup.py develop && \
    pip install --upgrade -r requirements.txt

COPY ${SETUP}/${APP_CONF} ${SUPERVISOR_DIR}/${APP_CONF}
COPY ${SETUP} ${APP_DIR}
ENV APP_WSGI ckan.wsgi

COPY ${SETUP}/dump_env.conf ${SUPERVISOR_DIR}/dump_env.conf
COPY ${SETUP}/dump_env.py ${APP_DIR}/dump_env.py

WORKDIR ${APP_DIR}

# Add ckan command
RUN ln -s ${APP_DIR}/ckan /usr/bin/ckan

# We need setuptools<19.4, otherwise ckanext-oauth2 can not be installed because of
# https://bitbucket.org/pypa/setuptools/issues/491/setuptools-194-breaks-pip-install-builds
# This can be removed once this is merged:
# https://github.com/conwetlab/ckanext-oauth2/pull/7
RUN pip install setuptools==19.3
