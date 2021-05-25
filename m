Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFCC390A22
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhEYT7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 15:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233037AbhEYT7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 15:59:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EA9A6124C;
        Tue, 25 May 2021 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621972705;
        bh=Meb9fHb3cskKYSqvNm4niTiFoKH3HRKPqKs6sNi+ehE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmK8dqVIfYG86VyswdRWAYQBiKJW1uLi7K6dACnVnit0bz1bTBbsc/UsVOC6oY4pO
         YV/TWurygReCKU79DazYRRJLx5o4NuFg/baRcZHumblOAq3bYetOfz+M9DGyfDJVjG
         PRYbsTHerJWcfBnnH3W0LcXB6zUEUGoXwEWlEY/rRYNVaaY7zoOWXRmB9dp/Woh3p0
         U1Dy4Rg4wDTr18nHlSKUI8dcoPJG/6kBb9WxIQI+TZqFMpWvExEUPcOzCL6vtqWqAf
         KTGuoMDz8g0LiN0mce+eSLQuQqJXkUn+RqyfOPXxE5Djmea+k1BLxgvyETZ7Ugv/XE
         X6ZMxI9CXo0Vw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D56624011C; Tue, 25 May 2021 16:58:22 -0300 (-03)
Date:   Tue, 25 May 2021 16:58:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: fix and complete filtering out
 zero-sized per-CPU variables
Message-ID: <YK1W3gpVp0m2LSvb@kernel.org>
References: <20210524234222.278676-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524234222.278676-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, May 24, 2021 at 04:42:22PM -0700, Andrii Nakryiko escreveu:
> btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the same has to be
> done for DWARF variables when matching them with ELF symbols. This is due to
> zero-sized DWARF variables matching unrelated (non-zero-sized) variable that
> happens to be allocated at the exact same address, leading to a lot of
> confusion in BTF.

I've been following this, just didn't got to process it, will do it
soon.

- Arnaldo
 
> See [0] for when this causes big problems.
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfNxycHRZYXcoj8OYb=wA@mail.gmail.com/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  btf_encoder.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c711f124b31e..672b9943a4e2 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -538,6 +538,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  	cu__for_each_variable(cu, core_id, pos) {
>  		uint32_t size, type, linkage;
>  		const char *name, *dwarf_name;
> +		const struct tag *tag;
>  		uint64_t addr;
>  		int id;
>  
> @@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  
>  		/* addr has to be recorded before we follow spec */
>  		addr = var->ip.addr;
> +		dwarf_name = variable__name(var, cu);
>  
>  		/* DWARF takes into account .data..percpu section offset
>  		 * within its segment, which for vmlinux is 0, but for kernel
> @@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		 *  modules per-CPU data section has non-zero offset so all
>  		 *  per-CPU symbols have non-zero values.
>  		 */
> -		if (var->ip.addr == 0) {
> -			dwarf_name = variable__name(var, cu);
> +		if (var->ip.addr == 0)
>  			if (!dwarf_name || strcmp(dwarf_name, name))
>  				continue;
> -		}
>  
>  		if (var->spec)
>  			var = var->spec;
> @@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  			break;
>  		}
>  
> +		tag = cu__type(cu, var->ip.tag.type);
> +		if (tag__size(tag, cu) == 0) {
> +			if (btf_elf__verbose)
> +				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
> +			continue;
> +		}
> +
>  		type = var->ip.tag.type + type_id_off;
>  		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
>  
> -- 
> 2.30.2
> 

-- 

- Arnaldo
