Return-Path: <bpf+bounces-29635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3FC8C3F88
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669811F2199A
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 11:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0814B95F;
	Mon, 13 May 2024 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok1FnV98"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338F1C683
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598729; cv=none; b=TLKFkoCSSbVbp14l06RrM88VLCGwlSawQjkPe4VdSAgvaAqp/RCXVcoMQlWzQ+uPhhTNUdNROB5ACRBWqBEubUF5dFpzWWzmFV5oS9K6myLOL/OjS/i0WRXc1kJrxWQQJ7qiNrczeF050k7VmRSUXxsNW3Im8rsiNsm0dxL+iYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598729; c=relaxed/simple;
	bh=sl0t339P2aYNgm6UQJvDBXbFCtbKK6Ay08CMJkxHbQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpqJiMMljXyGCX9+jsNCfrBh0Vdk5cvAIRAFwzAu+2BC4V6yyh9ZLXYvI6Jh/ccgxpZ9PZ99cf0smXgs1O9sA9TK8E+2dh4PPX5gviWCzskDGhUgNWD1QFh3W+groajUrA1iseZHnc9YVhHqFuIJ+H17gjenJeoBOWvvwlyz7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok1FnV98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2693DC113CC;
	Mon, 13 May 2024 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715598728;
	bh=sl0t339P2aYNgm6UQJvDBXbFCtbKK6Ay08CMJkxHbQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ok1FnV98/hhLYjNGlMBfujGUmruDevisaEjACgu8Qzc4cFxwPgRoODRIKFCyA+8Yq
	 vMjP+5Pd9YqNmUZwY8N0lUyVjPN6jMBjOG6ugziwESOfYvc8pSL/VQWap0harfkBQr
	 mNIwLbdFa0dUsbO7vL3fpHEDdOpPUzuiroOFPTZJ8/S8pyrpuOBsb6XIut67xe6VHG
	 jTvGuHI+ihZLwOORWLSB6uXIIoIM/MJoxkhKCcxYKdowMW9da5+J8DPTPYzo661clw
	 tZiIs4V/qgNiXSoCJ6e9ITXrVYaIjbfq9vQHh5uHwKuxXnsiKaYaSem6vpv9Km88JT
	 eS0zcJny94/jg==
Message-ID: <25c2e677-1191-448c-a42c-7268748bd7c1@kernel.org>
Date: Mon, 13 May 2024 12:12:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 11/11] bpftool: support displaying
 relocated-with-base split BTF
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org, acme@redhat.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
References: <20240510103052.850012-1-alan.maguire@oracle.com>
 <20240510103052.850012-12-alan.maguire@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240510103052.850012-12-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-05-10 11:32 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> If the -R <base_btf> option is used, we can display BTF that has been
> generated with distilled base BTF in its relocated form.  For example
> for bpf_testmod.ko (which is built as an out-of-tree module, so has
> a distilled .BTF.base section:
> 
> bpftool btf dump file bpf_testmod.ko
> 
> Alternatively, we can display content relocated with
> (a possibly changed) base BTF via
> 
> bpftool btf dump -R /sys/kernel/btf/vmlinux bpf_testmod.ko
> 
> The latter mirrors how the kernel will handle such split
> BTF; it relocates its representation with the running
> kernel, and if successful, renumbers BTF ids to reference
> the current vmlinux BTF.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-btf.rst | 15 ++++++++++++++-
>  tools/bpf/bpftool/bash-completion/bpftool       |  7 ++++---
>  tools/bpf/bpftool/btf.c                         | 11 ++++++++++-
>  tools/bpf/bpftool/main.c                        | 14 +++++++++++++-
>  tools/bpf/bpftool/main.h                        |  2 ++
>  5 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index eaba24320fb2..fd6bb1280e7b 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **btf** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
> +*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } { **-R** | **relocate-base-btf** } }


The double-dash is missing at the beginning of --relocate-base-btf.


>  
>  *COMMANDS* := { **dump** | **help** }
>  
> @@ -85,6 +85,19 @@ OPTIONS
>      BTF object is passed through other handles, this option becomes
>      necessary.
>  
> +-R, --relocate-base-btf *FILE*
> +    When split BTF is generated with distilled base BTF for relocation,
> +    the latter is stored in a .BTF.base section and allows us to later
> +    relocate split BTF and a potentially-changed base BTF by using
> +    information in the .BTF.base section about the base types referenced
> +    from split BTF.  Relocation is carried out against the split BTF
> +    supplied via this parameter and the split BTF will then refer to
> +    the base types supplied in *FILE*.
> +
> +    If this option is not used, split BTF is shown relative to the
> +    .BTF.base, which contains just enough information to support later
> +    relocation.
> +
>  EXAMPLES
>  ========
>  **# bpftool btf dump id 1226**
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 04afe2ac2228..878cf3d49a76 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -262,7 +262,7 @@ _bpftool()
>      # Deal with options
>      if [[ ${words[cword]} == -* ]]; then
>          local c='--version --json --pretty --bpffs --mapcompat --debug \
> -            --use-loader --base-btf'
> +            --use-loader --base-btf --relocate-base-btf'
>          COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
>          return 0
>      fi
> @@ -283,7 +283,7 @@ _bpftool()
>              _sysfs_get_netdevs
>              return 0
>              ;;
> -        file|pinned|-B|--base-btf)
> +        file|pinned|-B|-R|--base-btf|--relocate-base-btf)
>              _filedir
>              return 0
>              ;;
> @@ -297,7 +297,8 @@ _bpftool()
>      local i pprev
>      for (( i=1; i < ${#words[@]}; )); do
>          if [[ ${words[i]::1} == - ]] &&
> -            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]]; then
> +            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]] &&
> +            [[ ${words[i]} != "-R" ]] && [[ ${words[i]} != "--relocate-base-btf" ]]; then
>              words=( "${words[@]:0:i}" "${words[@]:i+1}" )
>              [[ $i -le $cword ]] && cword=$(( cword - 1 ))
>          else
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 0ca1f2417801..34f60d9e433d 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -638,6 +638,14 @@ static int do_dump(int argc, char **argv)
>  			base_btf = btf__parse_opts(*argv, &optp);
>  			if (base_btf)
>  				btf = btf__parse_split(*argv, base_btf);
> +			if (btf && relocate_base_btf) {
> +				err = btf__relocate(btf, relocate_base_btf);
> +				if (err) {
> +					p_err("could not relocate BTF from '%s' with base BTF '%s': %s\n",
> +					      *argv, relocate_base_btf_path, strerror(-err));
> +					goto done;
> +				}
> +			}
>  		}
>  		if (!btf) {
>  			err = -errno;
> @@ -1075,7 +1083,8 @@ static int do_help(int argc, char **argv)
>  		"       " HELP_SPEC_MAP "\n"
>  		"       " HELP_SPEC_PROGRAM "\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
> -		"                    {-B|--base-btf} }\n"
> +		"                    {-B|--base-btf} |\n"
> +		"                    {-R|--relocate-base-btf} }\n"
>  		"",
>  		bin_name, "btf");
>  
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 08d0ac543c67..69d4906bec5c 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -32,6 +32,8 @@ bool verifier_logs;
>  bool relaxed_maps;
>  bool use_loader;
>  struct btf *base_btf;
> +struct btf *relocate_base_btf;
> +const char *relocate_base_btf_path;
>  struct hashmap *refs_table;
>  
>  static void __noreturn clean_and_exit(int i)
> @@ -448,6 +450,7 @@ int main(int argc, char **argv)
>  		{ "debug",	no_argument,	NULL,	'd' },
>  		{ "use-loader",	no_argument,	NULL,	'L' },
>  		{ "base-btf",	required_argument, NULL, 'B' },
> +		{ "relocate-base-btf", required_argument, NULL, 'R' },

Nit: The lines above yours use tabs to visually align the different
fields, would you mind (optionally) re-aligning them, or at least using
tabs in your own line, please?

Other than these, the changes look good to me, thank you

Reviewed-by: Quentin Monnet <qmo@kernel.org>

