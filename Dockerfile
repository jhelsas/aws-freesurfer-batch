FROM amazonlinux:latest

RUN yum update -y \
    && yum -y install which unzip aws-cli \
    && yum install -y tcsh tar wget libgomp bc perl net-tools zip 

ADD fetch_and_run.sh /usr/local/bin/fetch_and_run.sh

WORKDIR /tmp

RUN cd /opt \
    && wget ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

RUN tar -xzvf /opt/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz  -C /opt \
    && mkdir /output

COPY license.txt /opt/freesurfer/

ENV OS Linux
ENV FS_OVERRIDE 0
ENV FIX_VERTEX_AREA= 
ENV SUBJECTS_DIR /output
ENV FSF_OUTPUT_FORMAT nii.gz
ENV MNI_DIR /opt/freesurfer/mni
ENV LOCAL_DIR /opt/freesurfer/local
ENV FREESURFER_HOME /opt/freesurfer
ENV FSFAST_HOME /opt/freesurfer/fsfast
ENV MINC_BIN_DIR /opt/freesurfer/mni/bin
ENV MINC_LIB_DIR /opt/freesurfer/mni/lib
ENV MNI_DATAPATH /opt/freesurfer/mni/data
ENV FMRI_ANALYSIS_DIR /opt/freesurfer/fsfast
ENV PERL5LIB /opt/freesurfer/mni/lib/perl5/5.8.5
ENV MNI_PERL5LIB /opt/freesurfer/mni/lib/perl5/5.8.5
ENV PATH /opt/freesurfer/bin:/opt/freesurfer/fsfast/bin:/opt/freesurfer/tktools:/opt/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN source $FREESURFER_HOME/FreeSurferEnv.sh &>/dev/null

USER nobody
ENTRYPOINT ["/usr/local/bin/fetch_and_run.sh"]

