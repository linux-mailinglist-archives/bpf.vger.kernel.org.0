Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD225025A5
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 08:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbiDOGfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 02:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDOGfW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 02:35:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE0A88A7;
        Thu, 14 Apr 2022 23:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uB3a3+iOsc4hcX22sdyRU/EflMs9pIkR11qeoFCVFz8=; b=vamvTJCHSRHthjO0sjJBLfqtyJ
        M6vl0HQAec4r130Y1TAoJgIEbrf6lZbL/cBEp9YDLKZgbKcBi2COKcTogCrWXLYKtl1UXJnKmaecX
        RE/0dwMGYiTvEZkvUpvhNIU/S7fPztEmyvDLLQ8BmuJuQs73BwcgG5NMhhycrRuOjXrS9lVGXF/lt
        XobrJoxkP9AwtIoTJFgEabM2yHamEe+NsRCGOnjhhhsiajxPDvOAYCXCtW844w1IhAiEvl48i1ODf
        3x3Hsj6nMYDmbenOHN/fT+xSXnRwSG4VFTLVfmZRY14L7v891QqIuHDI8EjPTkYmznMWisgn5/YmW
        E8s0fk0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfFVm-00919W-JO; Fri, 15 Apr 2022 06:32:54 +0000
Date:   Thu, 14 Apr 2022 23:32:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org
Subject: Re: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
Message-ID: <YlkRlm6rrxcMAupN@infradead.org>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414195914.1648345-4-song@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 12:59:13PM -0700, Song Liu wrote:
> Introduce module_alloc_huge, which allocates huge page backed memory in
> module memory space. The primary user of this memory is bpf_prog_pack
> (multiple BPF programs sharing a huge page).
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  arch/x86/kernel/module.c     | 21 +++++++++++++++++++++
>  include/linux/moduleloader.h |  5 +++++
>  kernel/module.c              |  5 +++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index b98ffcf4d250..63f6a16c70dc 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -86,6 +86,27 @@ void *module_alloc(unsigned long size)
>  	return p;
>  }
>  
> +void *module_alloc_huge(unsigned long size)
> +{
> +	gfp_t gfp_mask = GFP_KERNEL;
> +	void *p;
> +
> +	if (PAGE_ALIGN(size) > MODULES_LEN)
> +		return NULL;
> +
> +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> +				 MODULES_VADDR + get_module_load_offset(),
> +				 MODULES_END, gfp_mask, PAGE_KERNEL,
> +				 VM_DEFER_KMEMLEAK | VM_ALLOW_HUGE_VMAP,
> +				 NUMA_NO_NODE, __builtin_return_address(0));
> +	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	return p;
> +}
> +
>  #ifdef CONFIG_X86_32
>  int apply_relocate(Elf32_Shdr *sechdrs,
>  		   const char *strtab,
> diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
> index 9e09d11ffe5b..d34743a88938 100644
> --- a/include/linux/moduleloader.h
> +++ b/include/linux/moduleloader.h
> @@ -26,6 +26,11 @@ unsigned int arch_mod_section_prepend(struct module *mod, unsigned int section);
>     sections.  Returns NULL on failure. */
>  void *module_alloc(unsigned long size);
>  
> +/* Allocator used for allocating memory in module memory space. If size is
> + * greater than PMD_SIZE, allow using huge pages. Returns NULL on failure.
> + */
> +void *module_alloc_huge(unsigned long size);
> +
>  /* Free memory returned from module_alloc. */
>  void module_memfree(void *module_region);
>  
> diff --git a/kernel/module.c b/kernel/module.c
> index 6cea788fd965..b2c6cb682a7d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2839,6 +2839,11 @@ void * __weak module_alloc(unsigned long size)
>  			NUMA_NO_NODE, __builtin_return_address(0));
>  }
>  
> +void * __weak module_alloc_huge(unsigned long size)
> +{
> +	return vmalloc_huge(size);
> +}

Umm.  This should use the same parameters as module_alloc except for
also passing the new huge page flag.
