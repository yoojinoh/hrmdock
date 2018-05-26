#! /bin/sh

""":" 
exec python $0 ${1+"$@"}
"""


import os, traceback, argparse

def convert(dockerfile_path, destination_path):

    with open(dockerfile_path,"r") as f: content = f.readlines()

    script = ["#! /bin/bash\n\n"]

    ssh_ignore_mode = False
    ssh_only_mode = False

    for line_number,line in enumerate(content):

        line = line.strip()

        if "[SSH IGNORE]" in line:
            if ssh_only_mode : raise Exception(
                "line : "+str(line_number)+" : looks like a a [SSH IGNORE]\
                tag was open while a [SSH ONLY] tag was not closed")
            if ssh_ignore_mode : raise Exception(
                "line : "+str(line_number)+" : looks like a [SSH IGNORE]\
                 tag was not closed")
            ssh_ignore_mode = True
    
        elif "[/SSH IGNORE]" in line:
            if not ssh_ignore_mode : raise Exception(
                "line : "+str(line_number)+" : looks like a [SSH IGNORE]\
                 tag was not open")
            ssh_ignore_mode = False

        elif "[SSH ONLY]" in line:
            if ssh_ignore_mode : raise Exception(
                "line : "+str(line_number)+" : looks like a [SSH ONLY]\
                 tag was open while a [SSH IGNORE] tag was not closed")
            if ssh_only_mode : raise Exception(
                "line : "+str(line_number)+" : looks like a [SSH ONLY]\
                 tag was not closed")
            ssh_only_mode = True
 
        elif "[/SSH ONLY]" in line:
            if not ssh_only_mode : raise Exception(
                "line : "+str(line_number)+" : looks like a [SSH ONLY]\
                 tag was not open")
            ssh_only_mode = False
	
        else : 
            if ssh_ignore_mode : 
                pass
            elif ssh_only_mode : 
                if not line.startswith("#") : raise Exception(
                    "all lines in [SSH IGNORE]\
                     tag expected to start with '#' (line: "+str(line)+")")
                line = line[1:]
                script.append(line)
            else: 
                if line.startswith("RUN"): line = line[4:]
                script.append(line)
            
    script_str = "\n".join(script)

    with open(destination_path,"w+") as f : f.write(script_str)

    print 
    print "generated install script : ",os.path.abspath(destination_path)
    print

    return 


if __name__ == "__main__" : 

    parser = argparse.ArgumentParser(
        description='Generates a bash script to perform the\
        the operation described in a Dockerfile')
    parser.add_argument('dockerfile_path', type=str,
                       help='path to the Dockerfile')
    parser.add_argument('destination_path', type=str,
                       help='filename of the auto generated script')
    args = parser.parse_args()

    print "In  : -- ", args.dockerfile_path
    print "Out : -- ", args.destination_path

    if not os.path.isfile(args.dockerfile_path): 
        print "[ERROR] failed to find",args.dockerfile_path

    else :
        try : convert(args.dockerfile_path, args.destination_path)
        except Exception as e :
            print
            traceback.print_exc()
            print
            print "[ERROR] while parsing ", args.dockerfile_path+": "+str(e)
            print "contact vberenz@tuebingen.mpg.de for debug \
                  (copy/paste trace above)"
            print