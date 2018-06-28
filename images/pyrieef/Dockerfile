FROM hrm_cuda:latest
RUN pip install --upgrade pip
# RUN apt-get update && \
#    apt-get install -y \
RUN pip install --upgrade --ignore-installed \
    testresources \
    tensorflow-gpu==1.9.0rc1 \
    scikit-image \
    pydot
    