FROM zheli21/pytorch:1.10.1-cp39-cuda113-2004 AS base
RUN pip install -U h5py scikit-image gym

FROM base as git-repos
RUN mkdir /root/.ssh/
COPY id_ed25519 /root/.ssh/id_ed25519
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone --branch 0.1 git@github.com:lizhe07/c-swm.git

FROM base as final
COPY --from=git-repos /c-swm /c-swm
WORKDIR /c-swm
