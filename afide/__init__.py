from dataclasses import dataclass
import logging
import os
import shutil
import sys

import click


@dataclass
class Config:
    verbose: bool = False
    debug: bool = False
    path: bool = False
    logger: object = None


@click.group()
@click.option('-v', '--verbose', default=False, is_flag=True, help='Be more verbose')
@click.option('--debug', default=False, is_flag=True, help='Debug mode')
@click.option('--path',  default="~/.afide",
              help='Where is the afide? default ~/.afide')
@click.pass_context
def cli(ctx, verbose, debug, path):
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
            logger.debug(f">>> {dirpath}/{fname}")
            filepath = os.path.join(dirpath, fname)
            with open(filepath, 'r') as f:
                first_line = f.read()
                logger.debug(f"    first line: {first_line}")
                if first_line[1] != '=':
                    logger.error(f"ERROR: File {filepath} is missing a SHEQU")
                    ctx.invoke(uninstall)
                    exit(1)
                target = first_line[2:]
            try:
                shutil.move(target, f'{target}.b4afide')
            except FileNotFoundError:
                continue
            os.symlink(filepath, target)

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

