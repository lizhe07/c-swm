FROM zheli21/pytorch:1.10.1-cp37-cuda113-1804 AS base
RUN pip install -U h5py scikit-image==0.15.0 gym==0.12.0

FROM base as git-repos
RUN mkdir /root/.ssh/
COPY id_ed25519 /root/.ssh/id_ed25519
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone --branch 0.1 git@github.com:lizhe07/c-swm.git

FROM base as final
COPY --from=git-repos /c-swm /c-swm
WORKDIR /c-swm
