Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997B66B50D2
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 20:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCJTTW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 14:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCJTTV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 14:19:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE98C120E8C
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 11:19:19 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so10887066pjg.4
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 11:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678475959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMGAV1zzkicKsBM+CX3FOzZjLEcYw21MNxzmj9UXPqY=;
        b=lSJXJKFoK7+FkUalgIJ41B+JHp3j3SRLjps2eKrMt0aJhSFZUo6xzfc3LtLrbtXfAn
         K+oL7q1usUVMyjri3/BUGbTrfKTYznNROMEhp753diplRFaiivrNaDzLPRCIiG7a1ede
         jhpYel9iMUfOFEes/RYHjln/MgaA0HIxSPrWHASyv2BjPkUxMVRSdodG44/91fhrZBe0
         fyrXA+Odph+hKQJPZhxbiaSayaMZ/K/jaBATNfL9ykZNOXPQlPloQQeatSiSNIMl+QTo
         Z2fyWrlSJxXpo/0GFJcSTSbBv7mWqe4UvEi2kvMRakBA3QVS7krVh2YCz46Tez3KRVSK
         8rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMGAV1zzkicKsBM+CX3FOzZjLEcYw21MNxzmj9UXPqY=;
        b=6clA1kjfoo4vv6rn3RkbdOr42T25pcjNxKL2JIrnP/YB29WYTRDrFLv9i4bzhX1Zar
         SlSwMHWPhVZZPZVF53Crso0ES0gGs/zLKy0hShzH7b1OLp7G2nPVktp2UZBJWN3ECC+I
         nSlt74NqqZmFGvHv6rWtT/20nnCBPIiZOUmGjt9Xn3yNif64Rx5Na5+b6+tl59ymjZJ4
         G85iDpwhyRKjIoXJWWopqr3ahxUkvCe9nWs4yUPuwH90LvDhxM9dCTzp8DndPkA0epIW
         XcULDayGFMmoHNmTB0Qn0GRWML883wWn5kSo7xwpQ5rjGj15RM/3ZFEi7XBh28exaLoH
         KyCw==
X-Gm-Message-State: AO0yUKW7voEPcct0P4lya45Y/66VvUpo5yRW1tjV1Qi6pXx3zwKHRrRw
        fbMQ22+qeTeRfh6N0g7I9+o=
X-Google-Smtp-Source: AK7set8R1fgfr6d+ETc/5Jcn9FhGr9s7yOPxI6eSF1HvWY9mK5VJHCrbdfQHk5IptNEHPW5GVyksTQ==
X-Received: by 2002:a17:903:1d1:b0:19e:6947:3b27 with SMTP id e17-20020a17090301d100b0019e69473b27mr34063199plh.58.1678475959271;
        Fri, 10 Mar 2023 11:19:19 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:5c0c])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b0019c93a9a854sm329155plb.213.2023.03.10.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:19:18 -0800 (PST)
Date:   Fri, 10 Mar 2023 11:19:16 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 12/17] bpf: Add a few bpf mem allocator
 functions
Message-ID: <20230310191916.xz3hxqxl2une2rhq@macbook-pro-6.dhcp.thefacebook.com>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
 <20230308065936.1550103-13-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308065936.1550103-13-martin.lau@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 07, 2023 at 10:59:31PM -0800, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This patch adds a few bpf mem allocator functions which will
> be used in the bpf_local_storage in a later patch.
> 
> bpf_mem_cache_alloc_flags(..., gfp_t flags) is added. When the
> flags == GFP_KERNEL, it will fallback to __alloc(..., GFP_KERNEL).
> bpf_local_storage knows its running context is sleepable (GFP_KERNEL)
> and provides a better guarantee on memory allocation.
> 
> bpf_local_storage has some uncommon cases that its selem
> cannot be reused immediately. It handles its own
> rcu_head and goes through a rcu_trace gp and then free it.
> bpf_mem_cache_raw_free() is added for direct free purpose
> without leaking the LLIST_NODE_SZ internal knowledge.
> During free time, the 'struct bpf_mem_alloc *ma' is no longer
> available. However, the caller should know if it is
> percpu memory or not and it can call different raw_free functions.
> bpf_local_storage does not support percpu value, so only
> the non-percpu 'bpf_mem_cache_raw_free()' is added in
> this patch.
> 
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  include/linux/bpf_mem_alloc.h |  2 ++
>  kernel/bpf/memalloc.c         | 42 +++++++++++++++++++++++++++--------
>  2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> index a7104af61ab4..3929be5743f4 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -31,5 +31,7 @@ void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
>  /* kmem_cache_alloc/free equivalent: */
>  void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
>  void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
> +void bpf_mem_cache_raw_free(void *ptr);
> +void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
>  
>  #endif /* _BPF_MEM_ALLOC_H */
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 5fcdacbb8439..2b78eed27c9c 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -121,15 +121,8 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
>  	return entry;
>  }
>  
> -static void *__alloc(struct bpf_mem_cache *c, int node)
> +static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
>  {
> -	/* Allocate, but don't deplete atomic reserves that typical
> -	 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
> -	 * will allocate from the current numa node which is what we
> -	 * want here.
> -	 */
> -	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
> -
>  	if (c->percpu_size) {
>  		void **obj = kmalloc_node(c->percpu_size, flags, node);
>  		void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
> @@ -185,7 +178,12 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>  		 */
>  		obj = __llist_del_first(&c->free_by_rcu);
>  		if (!obj) {
> -			obj = __alloc(c, node);
> +			/* Allocate, but don't deplete atomic reserves that typical
> +			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
> +			 * will allocate from the current numa node which is what we
> +			 * want here.
> +			 */
> +			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
>  			if (!obj)
>  				break;
>  		}
> @@ -676,3 +674,29 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
>  
>  	unit_free(this_cpu_ptr(ma->cache), ptr);
>  }
> +
> +void bpf_mem_cache_raw_free(void *ptr)
> +{
> +	kfree(ptr - LLIST_NODE_SZ);
> +}

I think this needs a big comment explaining when it's ok to use it.
The tradeoffs of missing free list and what it means.

Also it needs if (!ptr) return; for consistency.

The rest of the patches look fine. I've applied all except 12, 13, 14.
