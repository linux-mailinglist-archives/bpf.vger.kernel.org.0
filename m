Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718A5323F4
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiEXHU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 03:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiEXHU0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 03:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9935080227;
        Tue, 24 May 2022 00:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 387CF61554;
        Tue, 24 May 2022 07:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF41EC385AA;
        Tue, 24 May 2022 07:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653376824;
        bh=2YWf5LxWQDyQyGJemUCiBxpas8j1IUwZLhuvPzte3HM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8zlWKJoM1xCnDH9WqSPWhxWmzwEydonb/vHZc4fHCcpm3Z6HKIjvCRgICxTWICxn
         MLbPJhboH4pqHkQ3C/Cl6V8u9+LgJsuiQyT2iLWNHsLkhMI+fWKebL6pChLJx/6BWU
         LIUwLyYk6GlHcjw1nu9Ei3Tj7PCp6sRjBXhfD3EFc/2Nz3npVb5aOG6ZYWcGDan1ga
         sZcH0LhidrM/i++lVphhY6bzcZaotJr46v6fqOXj/+3Ls8Rg3CrZVzHuLRqK1wSmvy
         6+KQEzV9tSvQfm2+dD8R8cyzNYqAz/iy2kDzi7WIfp3FBW+LCKFaTYPO5rif5fuNRb
         yEbC+p8uVHV+g==
Date:   Tue, 24 May 2022 10:20:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 3/8] bpf: introduce bpf_arch_text_invalidate
 for bpf_prog_pack
Message-ID: <YoyHMXpsGRW2gJ19@kernel.org>
References: <20220520235758.1858153-1-song@kernel.org>
 <20220520235758.1858153-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520235758.1858153-4-song@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 04:57:53PM -0700, Song Liu wrote:
> Introduce bpf_arch_text_invalidate and use it to fill unused part of the
> bpf_prog_pack with illegal instructions when a BPF program is freed.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 5 +++++
>  include/linux/bpf.h         | 1 +
>  kernel/bpf/core.c           | 8 ++++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a2b6d197c226..f298b18a9a3d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -228,6 +228,11 @@ static void jit_fill_hole(void *area, unsigned int size)
>  	memset(area, 0xcc, size);
>  }
>  
> +int bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +	return IS_ERR_OR_NULL(text_poke_set(dst, 0xcc, len));
> +}
> +
>  struct jit_context {
>  	int cleanup_addr; /* Epilogue code offset */
>  
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cc4d5e394031..a9b1875212f6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2365,6 +2365,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>  		       void *addr1, void *addr2);
>  
>  void *bpf_arch_text_copy(void *dst, void *src, size_t len);
> +int bpf_arch_text_invalidate(void *dst, size_t len);
>  
>  struct btf_id_set;
>  bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 2d0c9d4696ad..cacd8684c3c4 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -968,6 +968,9 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
>  	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
>  	pos = ((unsigned long)hdr - (unsigned long)pack_ptr) >> BPF_PROG_CHUNK_SHIFT;
>  
> +	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
> +		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");

Why is this a WARN?

What happens if bpf_arch_text_invalidate() is implemented but returns an error?

> +
>  	bitmap_clear(pack->bitmap, pos, nbits);
>  	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
>  				       bpf_prog_chunk_count(), 0) == 0) {
> @@ -2740,6 +2743,11 @@ void * __weak bpf_arch_text_copy(void *dst, void *src, size_t len)
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> +int __weak bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>  EXPORT_SYMBOL(bpf_stats_enabled_key);
>  
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
