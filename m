Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962162D0AF
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 02:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiKQBgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 20:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiKQBgX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 20:36:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15055D689
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 17:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KgdSixELcD01KTtZwC87lYpf/UiRXAzRRNHLwpM4pFw=; b=1UeQXkf8h/lUY9LATNVCf1tt/N
        4h5tUCij8ckaTmOJBdPFWkOMSahkhpCPdlkO2xRxieM43ny6C/S8BTc7tJzmTrGnuzWTNZJxdYlgq
        832s9S4FRcgmKtUnDc0Zl3QaThsEQSmoUZB6mwoEEjTHIiv3Q5AJUG9RIT4t6hAga/n8MT60+KoMD
        zZilFVI+ZF101fP9wuXz0V2FsiVWd/D5BjrSHVEka7zKL1fkyoHMloZAnhq3s9vDRUh7KXlSeRr8/
        Gi60LRmD9NldV+Al+InyslkGjn0NW7SM163BoMI5ekQ45Cs9PyyiVlmV/dCRB9OOIPG+7B0Z5jrgI
        De7/+bYQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovTpA-009L1x-VG; Thu, 17 Nov 2022 01:36:16 +0000
Date:   Wed, 16 Nov 2022 17:36:16 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v3 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
Message-ID: <Y3WQEPB6FaHRXidp@bombadil.infradead.org>
References: <20221117010621.1891711-1-song@kernel.org>
 <20221117010621.1891711-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117010621.1891711-2-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 05:06:16PM -0800, Song Liu wrote:
> +static void move_vmap_to_free_text_tree(void *addr)
> +{
> +	struct vmap_area *va;
> +
> +	/* remove from vmap_area_root */
> +	spin_lock(&vmap_area_lock);
> +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> +	if (WARN_ON_ONCE(!va)) {
> +		spin_unlock(&vmap_area_lock);
> +		return;
> +	}
> +	unlink_va(va, &vmap_area_root);
> +	spin_unlock(&vmap_area_lock);
> +
> +	/* make the memory RO+X */
> +	memset(addr, 0, va->va_end - va->va_start);
> +	set_memory_ro(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
> +	set_memory_x(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
> +
> +	/* add to all_text_vm */
> +	va->vm->next = all_text_vm;
> +	all_text_vm = va->vm;
> +
> +	/* add to free_text_area_root */
> +	spin_lock(&free_text_area_lock);
> +	merge_or_add_vmap_area_augment(va, &free_text_area_root, &free_text_area_list);
> +	spin_unlock(&free_text_area_lock);
> +}

<-- snip -->

> +void *execmem_alloc(unsigned long size, unsigned long align)
> +{
> +	struct vmap_area *va, *tmp;
> +	unsigned long addr;
> +	enum fit_type type;
> +	int ret;
> +
> +	va = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, NUMA_NO_NODE);
> +	if (unlikely(!va))
> +		return NULL;
> +
> +again:
> +	preload_this_cpu_lock(&free_text_area_lock, GFP_KERNEL, NUMA_NO_NODE);
> +	tmp = find_vmap_lowest_match(&free_text_area_root, size, align, 1, false);
> +
> +	if (!tmp) {
> +		unsigned long alloc_size;
> +		void *ptr;
> +
> +		spin_unlock(&free_text_area_lock);
> +
> +		/*
> +		 * Not enough continuous space in free_text_area_root, try
> +		 * allocate more memory. The memory is first added to
> +		 * vmap_area_root, and then moved to free_text_area_root.
> +		 */
> +		alloc_size = roundup(size, PMD_SIZE * num_online_nodes());
> +		ptr = __vmalloc_node_range(alloc_size, PMD_SIZE, EXEC_MEM_START,
> +					   EXEC_MEM_END, GFP_KERNEL, PAGE_KERNEL,
> +					   VM_ALLOW_HUGE_VMAP | VM_NO_GUARD,
> +					   NUMA_NO_NODE, __builtin_return_address(0));
> +		if (unlikely(!ptr))
> +			goto err_out;
> +
> +		move_vmap_to_free_text_tree(ptr);

It's not perfectly clear to me how we know for sure nothing can take
this underneath our noses.

  Luis
