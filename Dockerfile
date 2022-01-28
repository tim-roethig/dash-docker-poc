FROM dreg-prod.nlbapp.f-i-verbund.de/adap/products/bondai-rfq-listener:base
WORKDIR /bondai-rfq-popup
COPY . /bondai-rfq-popup

# Perform the requirements installation
RUN wget --no-check-certificate -nv https://nlblakappvp08.nlbapp.f-i-verbund.de/python/Miniconda3-py37_4.8.3-Linux-x86_64.sh     && \
    bash Miniconda3-py37_4.8.3-Linux-x86_64.sh -b -p /opt/miniconda3                                                             && \
    rm -f Miniconda3-py37_4.8.3-Linux-x86_64.sh                                                                                  && \
    ln -s /opt/miniconda3/bin/python3 /usr/local/bin/                                                                            && \
    ln -s /opt/miniconda3/bin/pip /usr/local/bin/pip3                                                                            && \
    ln -s /opt/miniconda3/bin/pip /usr/local/bin/                                                                                && \
    wget --no-check-certificate -nv https://nlblakappvp08.nlbapp.f-i-verbund.de/conf/pip.conf                                    && \
    mv pip.conf /etc/pip.conf                                                                                                    && \
    pip3 install -r requirements.txt
    #ln -s /opt/miniconda3/bin/uwsgi /usr/local/bin/

# Run the API inside the container
CMD ["bash", "./entrypoint.sh"]
