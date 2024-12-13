Return-Path: <bpf+bounces-46865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714259F10AB
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FB2819C2
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AABE1E25F1;
	Fri, 13 Dec 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyPk+qYP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5351DFE08;
	Fri, 13 Dec 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103062; cv=none; b=RoK6+3rXXHxX+JGg7nuYISxLmHFmczxCq9wLZkOnVnCkVSg+U9eAgDeyfhFP/rYMpcHOeD/8/W8PuJ3fJFtUvUA8eyGa4dHSa28oYZB85BFNQUaW05KyPLMHu6SeU+/7Pt91BFSpOAm9Ly+GTyhgQlcTodohBS+//yjbjkEYdQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103062; c=relaxed/simple;
	bh=NiDfmXtW+uz6UI4KoebVo4W4iFF81SHUU7f57O7/WlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3G4Vu1AReyfKgsyJxsu/tbZGrEEnmfgO8u/7fMdvh9DSu3sRRVjtt4SnrGOX0+dwvbu2Wprf9yYKPHoWqajvPn1ORj9my3JtD3eQQu9LE4FeA7Y74S+XEGAXMZwxinxgXYsYaUkwrzCx0UwDY0kXyKGLO5BCEyucmlR6VKn3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyPk+qYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5340FC4CED0;
	Fri, 13 Dec 2024 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103062;
	bh=NiDfmXtW+uz6UI4KoebVo4W4iFF81SHUU7f57O7/WlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CyPk+qYPhrrRkKRa8SO1JC2T0u/u4WMi3valxYwWnbohsJJGc67pRQvnRAkPEVudV
	 pHzsNRpbUmpLXyp5uPBOPMk84vf97JaR7sZ0RWcXjU2Nn388hzqVE3qrqrGGBQs56t
	 LGAtaWgdBltGsAPDrMh9QO5Nv9gH/ENWQIj4cK4yQ0v8gKVw/iaqEh7MbdgVPHNZ7Q
	 /Q8sbY5PVubIk080Ba2+pyv0l83Uf9+RnI0qdCtv6/pVzB6eGxd/tbtT1ByitPqjiE
	 VmVd0Ymqqxw4A/MNCiQr8d1OzGYeEym7PsSNG4WC7NCcXqwJ/rnZESHHTykVnWn8SA
	 BIRIBr5GgBTlA==
Message-ID: <7fa902e5-0916-4bc9-b1e0-2729903d3de0@kernel.org>
Date: Fri, 13 Dec 2024 15:17:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/4] bpftool: btf: Support dumping a specific
 types from file
To: Daniel Xu <dxu@dxuuu.xyz>, hawk@kernel.org, kuba@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrii.nakryiko@gmail.com, antony@phenome.org, toke@kernel.org
References: <cover.1734052995.git.dxu@dxuuu.xyz>
 <5ec7617fd9c28ff721947aceb80937dc10fca770.1734052995.git.dxu@dxuuu.xyz>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <5ec7617fd9c28ff721947aceb80937dc10fca770.1734052995.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-12 18:24 UTC-0700 ~ Daniel Xu <dxu@dxuuu.xyz>
> Some projects, for example xdp-tools [0], prefer to check in a minimized
> vmlinux.h rather than the complete file which can get rather large.
> 
> However, when you try to add a minimized version of a complex struct (eg
> struct xfrm_state), things can get quite complex if you're trying to
> manually untangle and deduplicate the dependencies.
> 
> This commit teaches bpftool to do a minimized dump of a specific types by
> providing a optional root_id argument(s).
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
>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  8 +++-
>  tools/bpf/bpftool/btf.c                       | 39 ++++++++++++++++++-
>  2 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index 245569f43035..dbe6d6d94e4c 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -24,7 +24,7 @@ BTF COMMANDS
>  =============
>  
>  | **bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
> -| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
> +| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** *ROOT_ID*]
>  | **bpftool** **btf help**
>  |
>  | *BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> @@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
>      that hold open file descriptors (FDs) against BTF objects. On such kernels
>      bpftool will automatically emit this information as well.
>  
> -bpftool btf dump *BTF_SRC* [format *FORMAT*]
> +bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
>      Dump BTF entries from a given *BTF_SRC*.
>  
>      When **id** is specified, BTF object with that ID will be loaded and all
> @@ -67,6 +67,10 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
>      formatting, the output is sorted by default. Use the **unsorted** option
>      to avoid sorting the output.
>  
> +    **root_id** option can be used to filter a dump to a single type and all
> +    its dependent types. It cannot be used with any other types of filtering.
> +    It can be passed multiple times to dump multiple types.
> +
>  bpftool btf help
>      Print short help message.
>  
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 3e995faf9efa..2636655ac180 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -27,6 +27,8 @@
>  #define KFUNC_DECL_TAG		"bpf_kfunc"
>  #define FASTCALL_DECL_TAG	"bpf_fastcall"
>  
> +#define MAX_ROOT_IDS		16
> +
>  static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_UNKN]		= "UNKNOWN",
>  	[BTF_KIND_INT]		= "INT",
> @@ -880,7 +882,8 @@ static int do_dump(int argc, char **argv)
>  {
>  	bool dump_c = false, sort_dump_c = true;
>  	struct btf *btf = NULL, *base = NULL;
> -	__u32 root_type_ids[2];
> +	__u32 root_type_ids[MAX_ROOT_IDS];
> +	bool have_id_filtering;
>  	int root_type_cnt = 0;
>  	__u32 btf_id = -1;
>  	const char *src;
> @@ -974,6 +977,8 @@ static int do_dump(int argc, char **argv)
>  		goto done;
>  	}
>  
> +	have_id_filtering = !!root_type_cnt;
> +
>  	while (argc) {
>  		if (is_prefix(*argv, "format")) {
>  			NEXT_ARG();
> @@ -993,6 +998,36 @@ static int do_dump(int argc, char **argv)
>  				goto done;
>  			}
>  			NEXT_ARG();
> +		} else if (is_prefix(*argv, "root_id")) {
> +			__u32 root_id;
> +			char *end;
> +
> +			if (have_id_filtering) {
> +				p_err("cannot use root_id with other type filtering");
> +				err = -EINVAL;
> +				goto done;
> +			} else if (root_type_cnt == MAX_ROOT_IDS) {
> +				p_err("only %d root_id are supported", MAX_ROOT_IDS);


I doubt users will often reach this limit, but if they do, the message
can be confusing, because MAX_ROOT_IDS also accounts for root_type_ids[]
cells used when we pass map arguments ("key" or "value" or "kv"), so you
could pass 15 "root_id" on the command line and get a message telling
only 16 are supported.

Maybe add a counter to tell how many were defined from the rest of the
command line, and adjust the value in the error message?


> +				err = -E2BIG;
> +				goto done;
> +			}
> +
> +			NEXT_ARG();
> +			root_id = strtoul(*argv, &end, 0);
> +			if (*end) {
> +				err = -1;
> +				p_err("can't parse %s as root ID", *argv);
> +				goto done;
> +			}
> +			for (i = 0; i < root_type_cnt; i++) {
> +				if (root_type_ids[i] == root_id) {
> +					err = -EINVAL;
> +					p_err("duplicate root_id %d supplied", root_id);
> +					goto done;
> +				}
> +			}
> +			root_type_ids[root_type_cnt++] = root_id;
> +			NEXT_ARG();
>  		} else if (is_prefix(*argv, "unsorted")) {
>  			sort_dump_c = false;
>  			NEXT_ARG();
> @@ -1403,7 +1438,7 @@ static int do_help(int argc, char **argv)
>  
>  	fprintf(stderr,
>  		"Usage: %1$s %2$s { show | list } [id BTF_ID]\n"
> -		"       %1$s %2$s dump BTF_SRC [format FORMAT]\n"
> +		"       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id ROOT_ID]\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"


