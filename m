Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8D375482
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhEFNQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 09:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233657AbhEFNQU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 May 2021 09:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620306921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSykd6n/65Sjb55CSej9S2o/ufmOt8gnzMkL6wg4Mek=;
        b=NU3YgyLroJjXcsUJsI2RVddRYwTTsNsHEzmFg4KRCZB/MuzCJAEQ1WY+boSfe2u1+kNUNq
        t1P+wt6FOx1k3PhzrNnOHC/A/qc1qo+ArHuP8aOmd8vJTfqivU/R/0FfRIwd0lMFtHE54W
        6p/GfI3wl87p1lGXWTW01sT3Jy+LbVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-WdcQisQaNEqlPYJespYRzQ-1; Thu, 06 May 2021 09:15:19 -0400
X-MC-Unique: WdcQisQaNEqlPYJespYRzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED05FEC1A0;
        Thu,  6 May 2021 13:15:17 +0000 (UTC)
Received: from krava (unknown [10.40.193.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 56F7460C25;
        Thu,  6 May 2021 13:15:16 +0000 (UTC)
Date:   Thu, 6 May 2021 15:15:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] btf: Remove ftrace filter
Message-ID: <YJPr4ykRPCCQ4s0P@krava>
References: <20210506015824.2335125-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506015824.2335125-1-kafai@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 05, 2021 at 06:58:24PM -0700, Martin KaFai Lau wrote:
> BTF is currently generated for functions that are in ftrace list
> or extern.
> 
> A recent use case also needs BTF generated for functions included in
> allowlist.  In particular, the kernel
> commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> allows bpf program to directly call a few tcp cc kernel functions. Those
> kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> is set to ensure they are in the ftrace list but this kconfig dependency
> is unnecessary.
> 
> Those kernel functions are specified under an ELF section .BTF_ids.
> There was an earlier attempt [0] to add another filter for the functions in
> the .BTF_ids section.  That discussion concluded that the ftrace filter
> should be removed instead.
> 
> This patch is to remove the ftrace filter and its related functions.
> 
> Number of BTF FUNC with and without is_ftrace_func():
> My kconfig in x86: 40643 vs 46225
> Jiri reported on arm: 25022 vs 55812
> 
> [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> 
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  btf_encoder.c | 272 +-------------------------------------------------
>  1 file changed, 5 insertions(+), 267 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 80e896961d4e..55c5f8e30cac 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -27,17 +27,8 @@
>   */
>  #define KSYM_NAME_LEN 128
>  
> -struct funcs_layout {
> -	unsigned long mcount_start;
> -	unsigned long mcount_stop;
> -	unsigned long mcount_sec_idx;
> -};
> -
>  struct elf_function {
>  	const char	*name;
> -	unsigned long	 addr;
> -	unsigned long	 size;
> -	unsigned long	 sh_addr;
>  	bool		 generated;
>  };
>  
> @@ -98,250 +89,11 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
>  	}
>  

we could also remove sym_sec_idx/last_idx right?
it's there for the sh.sh_addr, which got removed

jirka

>  	functions[functions_cnt].name = name;
> -	functions[functions_cnt].addr = elf_sym__value(sym);
> -	functions[functions_cnt].size = elf_sym__size(sym);
> -	functions[functions_cnt].sh_addr = sh.sh_addr;
>  	functions[functions_cnt].generated = false;
>  	functions_cnt++;
>  	return 0;
>  }
>  

SNIP

