Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BA46328A8
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKUPwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUPwf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:52:35 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD2D5FFC
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 07:52:33 -0800 (PST)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ox95t-0005Ge-HV; Mon, 21 Nov 2022 16:52:25 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ox95t-0008La-7S; Mon, 21 Nov 2022 16:52:25 +0100
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, rick.p.edgecombe@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
References: <20221117202322.944661-1-song@kernel.org>
 <20221117202322.944661-2-song@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net>
Date:   Mon, 21 Nov 2022 16:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221117202322.944661-2-song@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26727/Mon Nov 21 09:50:51 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/22 9:23 PM, Song Liu wrote:
> execmem_alloc is used to allocate memory to host dynamic kernel text
> (modules, BPF programs, etc.) with huge pages. This is similar to the
> proposal by Peter in [1].
[...]

Looks like the series needs a rebase, meanwhile just few nits:

> diff --git a/mm/nommu.c b/mm/nommu.c
> index 214c70e1d059..e3039fd4f65b 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -371,6 +371,18 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
>   }
>   EXPORT_SYMBOL(vm_map_pages_zero);
>   
> +void *execmem_alloc(unsigned long size, unsigned long align)
> +{
> +	return NULL;
> +}
> +
> +void *execmem_fill(void *dst, void *src, size_t len)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}

Don't they need EXPORT_SYMBOL_GPL, too?

> +
> +void execmem_free(const void *addr) { }
> +
>   /*
>    *  sys_brk() for the most part doesn't need the global kernel
>    *  lock, except when an application is doing something nasty
[...]
> +
> +/**
> + * execmem_alloc - allocate virtually contiguous RO+X memory
> + * @size:    allocation size

nit: @align missing in kdoc

> + *
> + * This is used to allocate dynamic kernel text, such as module text, BPF
> + * programs, etc. User need to use text_poke to update the memory allocated
> + * by execmem_alloc.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
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
> +		goto again;
> +	}
> +
> +	addr = roundup(tmp->va_start, align);
> +	type = classify_va_fit_type(tmp, addr, size);
> +	if (WARN_ON_ONCE(type == NOTHING_FIT))
> +		goto err_out_unlock;

Isn't this already covered in adjust_va_to_fit_type()?

> +	ret = adjust_va_to_fit_type(&free_text_area_root, &free_text_area_list,
> +				    tmp, addr, size);

nit:

	spin_unlock(&free_text_area_lock);
	if (ret)
		goto err_out;

> +	if (ret)
> +		goto err_out_unlock;
> +
> +	spin_unlock(&free_text_area_lock);
> +
> +	va->va_start = addr;
> +	va->va_end = addr + size;
> +	va->vm = NULL;
> +
> +	spin_lock(&vmap_area_lock);
> +	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> +	spin_unlock(&vmap_area_lock);
> +
> +	return (void *)addr;
> +
> +err_out_unlock:
> +	spin_unlock(&free_text_area_lock);
> +err_out:
> +	kmem_cache_free(vmap_area_cachep, va);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(execmem_alloc);
> +
> +void __weak *arch_fill_execmem(void *dst, void *src, size_t len)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +int __weak arch_invalidate_execmem(void *ptr, size_t len)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +/**
> + * execmem_fill - Copy text to RO+X memory allocated by execmem_alloc()
> + * @dst:  pointer to memory allocated by execmem_alloc()
> + * @src:  pointer to data being copied from
> + * @len:  number of bytes to be copied
> + *
> + * execmem_fill() will only update memory allocated by a single execmem_fill()
> + * call. If dst + len goes beyond the boundary of one allocation,
> + * execmem_fill() is aborted.
> + *
> + * If @addr is NULL, no operation is performed.
> + */
> +void *execmem_fill(void *dst, void *src, size_t len)
> +{
> +	struct vmap_area *va;
> +
> +	spin_lock(&vmap_area_lock);
> +	va = __find_vmap_area((unsigned long)dst, &vmap_area_root);
> +
> +	/*
> +	 * If no va, or va has a vm attached, this memory is not allocated
> +	 * by execmem_alloc().
> +	 */
> +	if (WARN_ON_ONCE(!va))
> +		goto err_out;
> +	if (WARN_ON_ONCE(va->vm))
> +		goto err_out;
> +
> +	/* Disallow filling across execmem_alloc boundaries */
> +	if (WARN_ON_ONCE((unsigned long)dst + len > va->va_end))
> +		goto err_out;
> +
> +	spin_unlock(&vmap_area_lock);
> +
> +	return arch_fill_execmem(dst, src, len);
> +
> +err_out:
> +	spin_unlock(&vmap_area_lock);
> +	return ERR_PTR(-EINVAL);
> +}
> +EXPORT_SYMBOL_GPL(execmem_fill);
> +
> +static struct vm_struct *find_and_unlink_text_vm(unsigned long start, unsigned long end)
> +{
> +	struct vm_struct *vm, *prev_vm;
> +
> +	lockdep_assert_held(&free_text_area_lock);
> +
> +	vm = all_text_vm;
> +	while (vm) {
> +		unsigned long vm_addr = (unsigned long)vm->addr;
> +
> +		/* vm is within this free space, we can free it */
> +		if ((vm_addr >= start) && ((vm_addr + vm->size) <= end))
> +			goto unlink_vm;
> +		vm = vm->next;
> +	}
> +	return NULL;
> +
> +unlink_vm:
> +	if (all_text_vm == vm) {
> +		all_text_vm = vm->next;
> +	} else {
> +		prev_vm = all_text_vm;
> +		while (prev_vm->next != vm)
> +			prev_vm = prev_vm->next;
> +		prev_vm->next = vm->next;
> +	}
> +	return vm;
> +}
> +
[...]
