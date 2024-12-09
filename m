Return-Path: <bpf+bounces-46388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2E9E93DE
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FABC162B0A
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E238A223711;
	Mon,  9 Dec 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfvzxyNh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568732236E5;
	Mon,  9 Dec 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747216; cv=none; b=Ahf5qLqzvDuToi9rEbwyD0cDSd9h3ESs0BWfrM18kFoBp7dmnFBmD94j7GxN2igF0AbemTd8tF1Iq3yorplmv8yE3J/BkSEOJPZ1WKjDYM5aNhl7JuTSsCyvl6xuUTVB8mJYy3Q5YI8sReLmSAylEIdPcQ+RAr6/4VQxSIXZO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747216; c=relaxed/simple;
	bh=4JauUlaauwuNUBq73sXeBrsFuFTH+ZeTne9Ec2pQWyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8exUGFLLtC7QN0EMWKk9950FltM48eyK5y0eiAG2mClaNkXBgoHCklppOu8bqWjd+j5SEGGQX7OyI+YMN4Zv9KZrHyw4FRGbnrhX6ADBL3U/D3xd05xEzPrr8k90aC9ERN51W00KWJDJBX7+TL1Bp3RxBsEgLzIvoRh06f+1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfvzxyNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A5FC4CED1;
	Mon,  9 Dec 2024 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747215;
	bh=4JauUlaauwuNUBq73sXeBrsFuFTH+ZeTne9Ec2pQWyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qfvzxyNhhMJx0OVwZWoYDm3WmhapNfBdVuE+T3rGNKsfJcFcrrOycdEneT32x/IWz
	 8d5ik0ZcJuSV7buBdgpCH6rxM9xtKheobH+2uPbJt0X/GHABXptgAjAPiTVwACL9iQ
	 d4Zi0G9KKy+QtuM4bOLnNQHRUitRjQDaz/TyBKtgqWCPF18bfmi3k0ZVUro1nYn7ze
	 yCi6xlefH5ImyiR6EMvLjuds7kpRLGaB75odXniY04SiT87bxJaIbaD8iWJplEWUaB
	 HcEDj2/70fD9zPno9Edx1ngQcfmW0RSIVBc4nYXwmLucFPBjKUg+Sc6FKbqBZQJRXC
	 Jz3xmpAkdFOTw==
Message-ID: <92b28250-acd8-4ca7-8a0e-09e1338113f0@kernel.org>
Date: Mon, 9 Dec 2024 12:26:50 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: btf: Support dumping a single type
 from file
To: Daniel Xu <dxu@dxuuu.xyz>, hawk@kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, ast@kernel.org, davem@davemloft.net, daniel@iogearbox.net,
 andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, antony@phenome.org,
 toke@kernel.org
References: <c8e6a2dfb64d76e61a20b1e2470fccbddf167499.1733613798.git.dxu@dxuuu.xyz>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <c8e6a2dfb64d76e61a20b1e2470fccbddf167499.1733613798.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/12/2024 23:24, Daniel Xu wrote:
> Some projects, for example xdp-tools [0], prefer to check in a minimized
> vmlinux.h rather than the complete file which can get rather large.
> 
> However, when you try to add a minimized version of a complex struct (eg
> struct xfrm_state), things can get quite complex if you're trying to
> manually untangle and deduplicate the dependencies.
> 
> This commit teaches bpftool to do a minimized dump of a single type by
> providing an optional root_id argument.
> 
> Example usage:
> 
>     $ ./bpftool btf dump file ~/dev/linux/vmlinux | rg "STRUCT 'xfrm_state'"
>     [12643] STRUCT 'xfrm_state' size=912 vlen=58
> 
>     $ ./bpftool btf dump file ~/dev/linux/vmlinux root_id 12643 format c
>     #ifndef __VMLINUX_H__
>     #define __VMLINUX_H__
> 
>     [..]
> 
>     struct xfrm_type_offload;
> 
>     struct xfrm_sec_ctx;
> 
>     struct xfrm_state {
>             possible_net_t xs_net;
>             union {
>                     struct hlist_node gclist;
>                     struct hlist_node bydst;
>             };
>             union {
>                     struct hlist_node dev_gclist;
>                     struct hlist_node bysrc;
>             };
>             struct hlist_node byspi;
>     [..]
> 
> [0]: https://github.com/xdp-project/xdp-tools/blob/master/headers/bpf/vmlinux.h
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> Changes in v2:
> * Add early error check for invalid BTF ID
> 
>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  5 +++--
>  tools/bpf/bpftool/btf.c                       | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index 3f6bca03ad2e..5abd0e99022f 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -27,7 +27,7 @@ BTF COMMANDS
>  | **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
>  | **bpftool** **btf help**
>  |
> -| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> +| *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* [**root_id** *ROOT_ID*] }


Thanks for this!

root_id is not part of the BTF_SRC, I think it should be an option on
the command line itself (3 lines above), after "format". And the change
should also be repeated below in the description (the "format" option is
missing, by the way, let's fix it too).

Can you please also update the interactive help message at the end of
btf.c?

Can you please also update the bash completion file? I think it should
look like this:


------
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 0c541498c301..097d406ee21f 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -930,6 +930,9 @@ _bpftool()
                         format)
                             COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
                             ;;
+                        root_id)
+                            return 0;
+                            ;;
                         c)
                             COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
                             ;;
@@ -937,13 +940,13 @@ _bpftool()
                             # emit extra options
                             case ${words[3]} in
                                 id|file)
-                                    _bpftool_once_attr 'format'
+                                    _bpftool_once_attr 'format root_id'
                                     ;;
                                 map|prog)
                                     if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
                                         COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
                                     fi
-                                    _bpftool_once_attr 'format'
+                                    _bpftool_once_attr 'format root_id'
                                     ;;
                                 *)
                                     ;;
------


>  | *FORMAT* := { **raw** | **c** [**unsorted**] }
>  | *MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
>  | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
> @@ -60,7 +60,8 @@ bpftool btf dump *BTF_SRC*
>  
>      When specifying *FILE*, an ELF file is expected, containing .BTF section
>      with well-defined BTF binary format data, typically produced by clang or
> -    pahole.
> +    pahole. You can choose to dump a single type and all its dependent types
> +    by providing an optional *ROOT_ID*.
>  
>      **format** option can be used to override default (raw) output format. Raw
>      (**raw**) or C-syntax (**c**) output formats are supported. With C-style
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index d005e4fd6128..a75e17efaf5e 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -953,6 +953,8 @@ static int do_dump(int argc, char **argv)
>  		NEXT_ARG();
>  	} else if (is_prefix(src, "file")) {
>  		const char sysfs_prefix[] = "/sys/kernel/btf/";
> +		__u32 root_id;
> +		char *end;


I think we could move these declarations to a lower scope, under your
"if (argc && is_prefix(...))".


>  
>  		if (!base_btf &&
>  		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
> @@ -967,6 +969,23 @@ static int do_dump(int argc, char **argv)
>  			goto done;
>  		}
>  		NEXT_ARG();
> +
> +		if (argc && is_prefix(*argv, "root_id")) {
> +			NEXT_ARG();
> +			root_id = strtoul(*argv, &end, 0);
> +			if (*end) {
> +				err = -1;
> +				p_err("can't parse %s as root ID", *argv);
> +				goto done;
> +			}
> +			if (root_id >= btf__type_cnt(btf)) {
> +				err = -EINVAL;
> +				p_err("invalid root ID: %u", root_id);
> +				goto done;
> +			}
> +			root_type_ids[root_type_cnt++] = root_id;
> +			NEXT_ARG();
> +		}
>  	} else {
>  		err = -1;
>  		p_err("unrecognized BTF source specifier: '%s'", src);


Same comment as above, it seems to be that the root_id controls the
output for the command rather than the source, and I'd rather move this
to the "while (argc)" loop where we process the "format" option rather
than when parsing the source.


pw-bot: cr

