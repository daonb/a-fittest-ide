from dataclasses import dataclass
import logging
import os
import shutil
import sys

import click

logger = None

@dataclass
class Config:
    verbose: bool = False
    debug: bool = False
    path: bool = False
    logger: object = None

def link_file(target, link_name):
    link = os.path.expanduser(link_name)
    backup = f'{link}.b4afide'

    if os.path.isfile(link) and not os.path.isfile(backup):
        shutil.copy2(link, backup)
        logger.info(f"    Backed up {link} => {backup}")

    if os.path.isfile(link) or os.path.islink(link):
        os.remove(link)


    link_dir = os.path.dirname(link)
    if not os.path.isdir(link_dir):
        os.makedirs(link_dir)

    os.symlink(target, link)
    logger.info(f"    Linked {link} => {target}")

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
    if verbose:
        logger.setLevel(logging.INFO)
    if debug:
        print('setting as debug')
        logger.setLevel(logging.DEBUG)
        handler = logging.StreamHandler(sys.stdout)
        handler.setLevel(logging.DEBUG)
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
    for dirpath, dirnames, filenames in os.walk(conf_path):
        for fname in filenames:
            target = os.path.join(dirpath, fname)
            logger.debug(f">>> {target}")
            with open(target, 'r') as f:
                first_line = f.readline()
                logger.debug(f"    first line: {first_line}")
                if first_line[1] != '=':
                    logger.info(f"     Skipping")
                    continue
                link_name = first_line[2:-1]

            if link_name:
                link_file(target, link_name)

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
def uninstall():
    pass

if __name__ == '__main__':
    cli()

