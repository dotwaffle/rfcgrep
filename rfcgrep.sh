#!/bin/bash

store="~/.rfcgrep"
rsyncopts="-v -z --progress --stats"

update()
{
	rsync -a --delete ${rsyncopts} rsync://rfc-editor.org/rfcs-text-only ${store}/rfc
	rsync -a --delete ${rsyncopts} rsync://rfc-editor.org/ids-text-only ${store}/i-d
}

search()
{
	grep -R "$*" ${store}/${type} | ${PAGER}
}

mkdir -p ${store}/rfc/
mkdir -p ${store}/i-d/

case "$1" in
	help|--help|-h)
		usage
		return 0
		;;
	type|--type|-t)
		type="$2"
		shift 2
		;;
	update|--update|-u)
		update
		return 0
		;;
	*)
		search $*
		;;
esac

