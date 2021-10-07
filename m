Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6A4256A1
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhJGPes (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 11:34:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45496 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJGPer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 11:34:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC7041FE5D;
        Thu,  7 Oct 2021 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633620772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6B1VO+DAyC0SNt7AIeINO89Y01c7kiMHh/J/8X3K/8g=;
        b=EXhzSbJpJrTL4FOchfh0da/gwXR8mST5Kuv4U4Dcy2y8v/Kl/NmPDMULfluACAgJJDrUNi
        UQMcPzGHj0mO/Oxmf1Hhlqoapd/7B4fXamGoz8Lbub2iqL/QRMOA7hgv4eiA004ixW8OtG
        2uWAj8PQCugzThuNpVRPSW8k+l2ynzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633620772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6B1VO+DAyC0SNt7AIeINO89Y01c7kiMHh/J/8X3K/8g=;
        b=CyQ4yNgz1MUmR/R2AHC0yG55AEMOZGP7q7SuSqu3LZehv81fVnKbHDSeHwUWmOWzsUiKVO
        RDZRXIxEknKNJLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AEBD13EB7;
        Thu,  7 Oct 2021 15:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c+BDHSQTX2FVfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Oct 2021 15:32:52 +0000
Message-ID: <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>
Date:   Thu, 7 Oct 2021 17:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Howard McLauchlan <hmclauchlan@fb.com>
References: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
From:   Vlastimil Babka <vbabka@suse.cz>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
In-Reply-To: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/5/21 17:31, Jens Axboe wrote:
> Allocations can be a very hot path, and this out-of-line function
> call is noticeable.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

It used to be inline b4 (hi, Konstantin!) and then was converted to be like
this intentionally :/

See 4f6923fbb352 ("mm: make should_failslab always available for fault
injection")

And now also kernel/bpf/verifier.c contains:
BTF_ID(func, should_failslab)

I think either your or Andrew's version will break this BTF_ID thing, at the
very least.

But I do strongly agree that putting unconditionally a non-inline call into
slab allocator fastpath sucks. Can we make it so that bpf can only do these
overrides when CONFIG_FAILSLAB is enabled?
I don't know, perhaps putting this BTF_ID() in #ifdef as well, or providing
a dummy that is always available (so that nothing breaks), but doesn't
actually affect slab_pre_alloc_hook() unless CONFIG_FAILSLAB has been enabled?

> ---
> 
> diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
> index e525f6957c49..3128d2c8b3b4 100644
> --- a/include/linux/fault-inject.h
> +++ b/include/linux/fault-inject.h
> @@ -64,8 +64,8 @@ static inline struct dentry *fault_create_debugfs_attr(const char *name,
>  
>  struct kmem_cache;
>  
> -int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  #ifdef CONFIG_FAILSLAB
> +int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  #else
>  static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> diff --git a/mm/slab.h b/mm/slab.h
> index 58c01a34e5b8..92fd6fe01877 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -491,8 +491,10 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  
>  	might_alloc(flags);
>  
> +#ifdef CONFIG_FAILSLAB
>  	if (should_failslab(s, flags))
>  		return NULL;
> +#endif
>  
>  	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
>  		return NULL;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ec2bb0beed75..c21bd447f237 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1323,6 +1323,7 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
>  
> +#ifdef CONFIG_FAILSLAB
>  int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  {
>  	if (__should_failslab(s, gfpflags))
> @@ -1330,3 +1331,4 @@ int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  	return 0;
>  }
>  ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
> +#endif
> 

