import os
from flask import Flask, flash, request, redirect, url_for, render_template
import subprocess
from werkzeug.utils import secure_filename

from jinja2 import Template
import codecs
# setup the qiime folder structure
# run clean?
snakemake_setup_cmd = 'snakemake --cores all --snakefile snakemake-qiime-edna/Snakefile --directory ./snakemake-qiime-edna/ setup'.split()
subprocess.run(snakemake_setup_cmd, shell=False)

# Setting up Flask
FASTQ_FOLDER = os.path.join(os.getcwd(), 'snakemake-qiime-edna','fastq_data')
print(FASTQ_FOLDER)

app = Flask(__name__, static_url_path=FASTQ_FOLDER, static_folder=FASTQ_FOLDER)
app.secret_key = "secret_key"
app.config["FASTQ_FOLDER"] = FASTQ_FOLDER

# home page
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/infer', methods=['POST'])
def upload_image():
    print("called POST")
    file = request.files['file']
    file_list = request.files.getlist('file')
    if len(file_list)>0: #and allowed_file(file.filename):
        for file in file_list:
            filename = secure_filename(file.filename)
            print(filename)
            file.save(os.path.join(app.config['FASTQ_FOLDER'], filename))
        #return render_template('inference.html', name=FASTQ_FOLDER)
        return redirect(url_for('edit_config'))

    else:
        flash('please select a dir')
        return redirect(request.url)

# config
@app.route('/config', methods=['GET', 'POST'])
def edit_config():
    if request.method == 'POST':
        data = {
                'name':request.form['name'],
                'fprimer':request.form['fprimer'],
                'rprimer':request.form['rprimer'],
                'tlf':request.form['tlf'],
                'tlr':request.form['tlr'],
                'maxef':request.form['maxef'],
                'maxer':request.form['maxer'],
                'truncq':request.form['truncq'],
                'chimera':request.form['chimera'],
                'classifier':request.form['classifier'],
                }

        with open('./snakemake-qiime-edna/config-template.yaml') as rf:
            template = Template(rf.read(), trim_blocks=True)
        render_file = template.render(data)
        outfile = codecs.open('./snakemake-qiime-edna/config.yaml', 'w', 'utf-8')
        outfile.write(render_file)
        outfile.close()
    print('called edit config')
    return render_template('config.html')


if __name__ == "__main__":
	app.debug = True
	port = 5000
	app.run(host="0.0.0.0", debug=True, port=port)
