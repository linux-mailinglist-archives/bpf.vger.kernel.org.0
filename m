Return-Path: <bpf+bounces-20567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1B8404A4
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8591F22802
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F55FEFC;
	Mon, 29 Jan 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6wKXxjv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544D5FEEF;
	Mon, 29 Jan 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530283; cv=none; b=pOaP2vs50dJfrcl1muTO0HkdWBihthQNn4M7g1iacoYcWo6/p1HyH+JXc5cipxNg6GSu39Lta4kab5+4XEi6YR+adS43M7NB5+aHqqFiyjcxgUdbfZEJ+/igpzo0okPOOIZYefs31FOTlSw7Xs5uwxa76pEz+LDIDGj8aCDpLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530283; c=relaxed/simple;
	bh=3HXv7ujLDgrTBiqeBH1Zh1gasFpPnJjS8mOzaSRaOxg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2J3rniMYKC1vpxR0TO3mO5Beo+ZFcxZ+dRMSfZDH78tj1ahOvgrLJV/uoaty3ZCpMcQpCdYdRvA6maW9b07EGrA0Bd1db77KdiVfXMZ52/HRUddE5TzMZPihrUUd3vu4Qq1bMQU75933DTa8RxWZNmj2Jtuskfea8tdx4TKOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6wKXxjv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33926ccbc80so1669669f8f.0;
        Mon, 29 Jan 2024 04:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706530280; x=1707135080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TzIZ9R/V0HNVE/S36s2KAS/ZU9CXXNU9hBqNDTs4zEI=;
        b=A6wKXxjvHoL0G1x3Td7ND1DVPEaB8/JS9emYMJBavFaY8J9XtNsOOk/y/90SdAmnl1
         2jSCTFDjcRHFEPiE3YrtgJlydlAaH4P2DTTJtbFXMTLPnY5HZ5eP2Y5+NGR0T/unUKqZ
         gTQpvKqszTI7/WHzByOHCOoxNvBcUSEFN/ntGwX5tq0N4NcwAojTRHj2ZIIM7sIPEb/C
         nGatU2ACWVGv0sNu6tfaDkR9qCTpB/KdBYsYdKCFdHYTKtAYFNyou8sRShuGh8fECnqq
         XtwSqZVgXvs58FclwF2lBCb45aLv+njK9EYIvypHP1aUHY38XGP3MvkgNORfybYRvm7d
         Tu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706530280; x=1707135080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzIZ9R/V0HNVE/S36s2KAS/ZU9CXXNU9hBqNDTs4zEI=;
        b=SYgkQ9YkRLShaB0a+jGyjtRSpWPblxIdfJxKYoAdZi20noaRL65vZ8bWn7hTanmtdp
         0s/+azuq0a29itAJGtPujQjZLeKhCLrkfpFMmDWdjqRhGALd/C3iQa3WfRWPYLcz4YKT
         PMQ8Y9Ddylo8ek42+W+CL5LNa0ABhMV//EZptX6mrGhadtj8QF4y5zG59ZTV8etddTc0
         xaDD/17cv3j9J4cvtBc/fEayfq8QVsE4nqX+W5U3BFM6VhzBmHKpaZm9u2sCxunEovon
         ZnZFZanO22QKbsAVnCtC7wyGtsmMuyXPaJFZwTCNMHZXgrHkI5rP+0KYvCZiNnepTtKg
         1nrw==
X-Gm-Message-State: AOJu0YwByIebIV9XRML/f7K/4Qkt42tQuAbZEORt2rPtKot/9/j9oUrV
	oCpslUvE3ua5HL+oJxTRSueY16t2pDQ+suoinZouEFdgSZ4ZQ16z
X-Google-Smtp-Source: AGHT+IGyJji2iVSlxAaFnqBZylft2bnUaCP2g4DWYidkR/TVWQ2kHDuCjk9xkApnUcbYHLZnjkYitQ==
X-Received: by 2002:a5d:6646:0:b0:33a:d2d4:959 with SMTP id f6-20020a5d6646000000b0033ad2d40959mr4560673wrw.11.1706530279891;
        Mon, 29 Jan 2024 04:11:19 -0800 (PST)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id k14-20020adff28e000000b003392172fd60sm7902441wro.51.2024.01.29.04.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:11:19 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Jan 2024 13:11:17 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: quentin@isovalent.com, daniel@iogearbox.net, ast@kernel.org,
	andrii@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
	alan.maguire@oracle.com, memxor@gmail.com, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpftool: Support dumping kfunc prototypes from
 BTF
Message-ID: <ZbeV5adWhiNZu5xj@krava>
References: <373d86f4c26c0ebf5046b6627c8988fa75ea7a1d.1706492080.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373d86f4c26c0ebf5046b6627c8988fa75ea7a1d.1706492080.git.dxu@dxuuu.xyz>

On Sun, Jan 28, 2024 at 06:35:33PM -0700, Daniel Xu wrote:
> This patch enables dumping kfunc prototypes from bpftool. This is useful
> b/c with this patch, end users will no longer have to manually define
> kfunc prototypes. For the kernel tree, this also means we can drop
> kfunc prototypes from:
> 
>         tools/testing/selftests/bpf/bpf_kfuncs.h
>         tools/testing/selftests/bpf/bpf_experimental.h
> 
> Example usage:
> 
>         $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux
> 
>         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
>         extern void cgroup_rstat_updated(struct cgroup * cgrp, int cpu) __ksym;
>         extern void cgroup_rstat_flush(struct cgroup * cgrp) __ksym;
>         extern struct bpf_key * bpf_lookup_user_key(u32 serial, u64 flags) __ksym;

hi,
I'm getting following declaration for bpf_rbtree_add_impl:

	extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym; 

and it fails to compile with:

	In file included from skeleton/pid_iter.bpf.c:3:
	./vmlinux.h:164511:141: error: expected ')'
	 164511 | extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym;
		|                                                                                                                                             ^
	./vmlinux.h:164511:31: note: to match this '('
	 164511 | extern int bpf_rbtree_add_impl(struct bpf_rb_root * root, struct bpf_rb_node * node, bool (struct bpf_rb_node *, const struct bpf_rb_node *)* less, void * meta__ign, u64 off) __ksym;

looks like the btf_dumper_type_only won't dump function pointer argument
properly.. I guess we should fix that, but looking at the other stuff in
vmlinux.h like *_ops struct we can print function pointers properly, so
perhaps another way around is to use btf_dumper interface instead

jirka

> 
> Note that this patch is only effective after enabling pahole [0]
> and kernel [1] changes are merged.
> 
> [0]: https://lore.kernel.org/bpf/0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz/
> [1]: https://lore.kernel.org/bpf/cover.1706491398.git.dxu@dxuuu.xyz/
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/bpf/bpftool/btf.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..9ab26ed12733 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -20,6 +20,8 @@
>  #include "json_writer.h"
>  #include "main.h"
>  
> +#define KFUNC_DECL_TAG		"bpf_kfunc"
> +
>  static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_UNKN]		= "UNKNOWN",
>  	[BTF_KIND_INT]		= "INT",
> @@ -454,6 +456,28 @@ static int dump_btf_raw(const struct btf *btf,
>  	return 0;
>  }
>  
> +static void dump_btf_kfuncs(const struct btf *btf)
> +{
> +	int cnt = btf__type_cnt(btf);
> +	int i;
> +
> +	for (i = 1; i < cnt; i++) {
> +		const struct btf_type *t = btf__type_by_id(btf, i);
> +		char kfunc_sig[1024];
> +		const char *name;
> +
> +		if (!btf_is_decl_tag(t))
> +			continue;
> +
> +		name = btf__name_by_offset(btf, t->name_off);
> +		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)))
> +			continue;
> +
> +		btf_dumper_type_only(btf, t->type, kfunc_sig, sizeof(kfunc_sig));
> +		printf("extern %s __ksym;\n\n", kfunc_sig);


> +	}
> +}
> +
>  static void __printf(2, 0) btf_dump_printf(void *ctx,
>  					   const char *fmt, va_list args)
>  {
> @@ -476,6 +500,9 @@ static int dump_btf_c(const struct btf *btf,
>  	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>  	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
>  	printf("#endif\n\n");
> +	printf("#ifndef __ksym\n");
> +	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
> +	printf("#endif\n\n");
>  
>  	if (root_type_cnt) {
>  		for (i = 0; i < root_type_cnt; i++) {
> @@ -491,6 +518,8 @@ static int dump_btf_c(const struct btf *btf,
>  			if (err)
>  				goto done;
>  		}
> +
> +		dump_btf_kfuncs(btf);
>  	}
>  
>  	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> -- 
> 2.42.1
> 

