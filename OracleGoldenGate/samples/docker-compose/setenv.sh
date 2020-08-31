export OGG_SCHEMA="ggadmin"
export OGG_ADMIN="oggadmin"
export OGG_ADMIN_PWD="ENTER_PASSWORD_HERE"

export SOURCE_IMAGE="oracle/goldengate-microservices:oradb12"
export SOURCE_OGG_DEPLOYMENT="Source"
export SOURCE_HTTPS_PORT="7443"
export SOURCE_LOCALDIR="/scratch/ogg_src"

export TARGET_IMAGE="oracle/goldengate-microservices:oradb18"
export TARGET_OGG_DEPLOYMENT="Target"
export TARGET_OGG_PORT_BASE="12000"
export TARGET_LOCALDIR="/scratch/ogg_tgt"

export TRAILS_LOCALDIR="/scratch/ogg_src/trails"
