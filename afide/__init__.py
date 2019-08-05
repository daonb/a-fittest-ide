from dataclasses import dataclass
import logging
import os
import shutil
import sys

import click

logger = None

BACKUP_FILES_NAME = 'backup_files.txt'

@dataclass
class Config:
    verbose: bool = False
    debug: bool = False
    path: bool = False
    logger: object = None

def link_file(target, link_name):
    """Create a link to a target. Returns the name of the backup file """
    link = os.path.expanduser(link_name)
    ret = ''
    backup = f'{link}.b4afide'
    if os.path.isfile(link) and not os.path.isfile(backup):
        shutil.copy2(link, backup)
        logger.info(f"Backed up {link} => {backup}")
        ret = backup

    if os.path.isfile(link) or os.path.islink(link):
        os.remove(link)


    link_dir = os.path.dirname(link)
    if not os.path.isdir(link_dir):
        os.makedirs(link_dir)

    os.symlink(target, link)
    logger.info(f"Linked {link} => {target}")
    return ret

@click.group()
@click.option('-v', '--verbose', default=False, is_flag=True, help='Be more verbose')
@click.option('--debug', default=False, is_flag=True, help='Debug mode')
@click.option('--path',  default="~/.afide",
              help='Where is the afide? default ~/.afide')
@click.pass_context
def cli(ctx, verbose, debug, path):
    global logger

    logger = logging.getLogger()
    ctx.obj = Config(verbose, debug, os.path.expanduser(path), logger)
    level = logging.WARN
    if verbose:
        level = logging.INFO
    if debug:
        level = logging.DEBUG
    logger.info(f"Setting loglevel - {level}")
    logger.setLevel(level)
    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(level)
    formatter = logging.Formatter('%(asctime)s:AFIDE:%(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    logger.addHandler(handler)
    logger.debug("Setting logLevel to DEBUG")

@cli.command()
@click.pass_context
def install(ctx):
    """Link afide conf files to users'"""
    logger = ctx.obj.logger
    conf_path = os.path.join(ctx.obj.path, 'conf')
    un_file = open(os.path.join(ctx.obj.path, BACKUP_FILES_NAME), 'a')
    for dirpath, dirnames, filenames in os.walk(conf_path):
        for fname in filenames:
            target = os.path.join(dirpath, fname)
            with open(target, 'r') as f:
                first_line = f.readline()
                logger.debug(f"first line: {first_line}")
                link_name = first_line[2:-1] if first_line[1] == '=' else None

            if link_name:
                backup = link_file(target, link_name)
                if backup:
                    un_file.write(backup)
                    un_file.write(os.linesep)
            else:
                logger.info(f"Not linking to {target}")
    un_file.close()



@cli.command()
def run():
    update()
    pass

@cli.command()
def update():
    pass

@cli.command()
def verify():
    pass

@cli.command()
@click.pass_context
def uninstall(ctx):
    logger = ctx.obj.logger
    f =  open(os.path.join(ctx.obj.path, BACKUP_FILES_NAME), 'r')
    for backup in f:
        backup = backup[:-1]
        logger.debug(f"Restoring {backup}")
        shutil.copy2(backup, backup[:-8])
        os.remove(backup)

if __name__ == '__main__':
    cli()

