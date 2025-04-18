cd $1

# Setup environment
export TUTOR_PLUGINS_ROOT=$(pwd)/plugins/ export TUTOR_ROOT=$(pwd)
python3 -m venv venv && source venv/bin/activate
pip install -r $TUTOR_ROOT/requirements.txt

# Start/init installation
tutor config save
tutor plugins enable k8s_harmony

tutor k8s start

echo "########################################"
echo "#             Pre init                 #"
echo "########################################"

bash ./pre-init.sh

tutor k8s init

echo "########################################"
echo "#             Post init                 #"
echo "########################################"
bash ./post-installation.sh

# Go back
deactivate
cd $CI_ROOT
