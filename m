Return-Path: <bpf+bounces-74522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9967C5E0CA
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 877BB3A4149
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F7333449;
	Fri, 14 Nov 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEzkNrUj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93C333433
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134139; cv=none; b=KLZYBMZUC6MP5L1wZLjYcZxfxesV12An2Jo7gICJxKLAcvyqSa4um/ZijUXhe0ChKfjZYHipTpShmc8/iYy+bOLJP2wRSBT1yagmvQXHTC4adqdKq6hJusjS9M6XNq5RraOFVtoNj7znY/wO4iFv2u0POn4O+5vTF6RZzKH58ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134139; c=relaxed/simple;
	bh=BkiH5i1C/buo+Pujknbw9+FtNagEYS43EmbJKZI147w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hx8Fte5lWK4rYynji2yKILEiTHqB1ECIGgsGFzkXHAErj576UXiSjvLBjEaM8Xg/1oqv1/0N4C4iHqLtnnssGyiDYDIdkhF9UeysAW2fOiq7+CPSXNzKUVwusqum1LPxtGuGW12TtNty12qVI2Rp8X65JtjasMJQKdde8MCN/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEzkNrUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672BAC19422;
	Fri, 14 Nov 2025 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763134138;
	bh=BkiH5i1C/buo+Pujknbw9+FtNagEYS43EmbJKZI147w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oEzkNrUjmQfPFUlancX63ZXlMkdQJk4atVZ7w1gd67mMzn7/O1L36oQ6it22voH9k
	 SXZyhGSyTZXsoAQIhcEDddhzqI+07p1mpnUE7Ko6gE0RE/qYgFogjSDXLCRMngnxQr
	 iZERO3AWOVGdKfm3dEHMBLwBawFfnOj9hhm9LF7kGYccQkgawb5de1KvstUB8BXfoW
	 blsCdQCdMPwLHIrU5dbig2k3x1QwMeVDNQlMjatPF1tavHyOOtu4KUACann/DeNSiQ
	 pqODL38RD/36/IOrLi2XBMVvfZN9noWcNojG6VkEEkkdtTVzVJeiEtgvJIh3o+BgKq
	 mhFpfMwfw7bZg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any
 context safe
In-Reply-To: <b0a8bdc792e9424566da4b764770c86f4af787e6bd714162917163768f2af4b4@mail.kernel.org>
References: <20251114111700.43292-4-puranjay@kernel.org>
 <b0a8bdc792e9424566da4b764770c86f4af787e6bd714162917163768f2af4b4@mail.kernel.org>
Date: Fri, 14 Nov 2025 15:28:54 +0000
Message-ID: <mb61pqzu01vm1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 7fa6e40ab..ca443c113 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
>> @@ -331,12 +355,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>>  	struct page *page;
>>  	long kbase, kaddr;
>> +	unsigned long flags;
>>  	int ret;
>>
>>  	kbase = bpf_arena_get_kern_vm_start(arena);
>>  	kaddr = kbase + (u32)(vmf->address);
>>
>> -	guard(mutex)(&arena->lock);
>> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>> +		/*
>> +		 * This is an impossible case and would only trigger if res_spin_lock is buggy or
>> +		 * due to another kernel bug.
>> +		 */
>> +		return VM_FAULT_RETRY;
>> +
>>  	page = vmalloc_to_page((void *)kaddr);
>>  	if (page)
>>  		/* already have a page vmap-ed */
>> @@ -348,26 +379,30 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>
>>  	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
>>  	if (ret)
>> -		return VM_FAULT_SIGSEGV;
>> +		goto out_unlock_sigsegv;
>>
>>  	struct apply_range_data data = { .pages = &page, .i = 0 };
>>  	/* Account into memcg of the process that created bpf_arena */
>>  	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>>  	if (ret) {
>>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
>> -		return VM_FAULT_SIGSEGV;
>> +		goto out_unlock_sigsegv;
>>  	}
>>
>>  	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
>>  	if (ret) {
>>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
>> -		__free_page(page);
>> -		return VM_FAULT_SIGSEGV;
>> +		free_pages_nolock(page, 0);
>> +		goto out_unlock_sigsegv;
>>  	}
>>  out:
>>  	page_ref_add(page, 1);
>> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>>  	vmf->page = page;
>>  	return 0;
>
> In arena_vm_fault(), there's a path between acquiring the spinlock and
> the new goto labels that doesn't release the lock:
>
>>  	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
>>  		return VM_FAULT_SIGSEGV;
>
> This return statement is reached after raw_res_spin_lock_irqsave()
> succeeds but before any of the unlock paths. If BPF_F_SEGV_ON_FAULT is
> set, subsequent page faults on this arena will deadlock. All other
> return paths in the function properly jump to out_unlock_sigsegv to
> release the lock.

Good catch, this needs to be goto out_unlock_sigsegv;

>> +out_unlock_sigsegv:
>> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +	return VM_FAULT_SIGSEGV;
>>  }
>
> [ ... ]
>
>> @@ -594,42 +633,65 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>>  {
>>  	struct vma_list *vml;
>>
>> +	guard(mutex)(&arena->lock);
>> +	/* iterate link list under lock */
>>  	list_for_each_entry(vml, &arena->vma_list, head)
>>  		zap_page_range_single(vml->vma, uaddr,
>>  				      PAGE_SIZE * page_cnt, NULL);
>>  }
>>
>> -static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
>>  {
>>  	u64 full_uaddr, uaddr_end;
>> -	long kaddr, pgoff, i;
>> +	long kaddr, pgoff;
>>  	struct page *page;
>> +	struct llist_head free_pages;
>> +	struct llist_node *pos, *t;
>> +	struct arena_free_span *s;
>> +	unsigned long flags;
>> +	int ret = 0;
>>
>>  	/* only aligned lower 32-bit are relevant */
>>  	uaddr = (u32)uaddr;
>>  	uaddr &= PAGE_MASK;
>> +	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
>>  	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
>>  	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
>>  	if (full_uaddr >= uaddr_end)
>>  		return;
>>
>>  	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
>> +	pgoff = compute_pgoff(arena, uaddr);
>>
>> -	guard(mutex)(&arena->lock);
>> +	if (!sleepable)
>> +		goto defer;
>> +
>> +	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
>> +	/*
>> +	 * Can't proceed without holding the spinlock so defer the free
>> +	 */
>> +	if (ret)
>> +		goto defer;
>
> [ ... ]
>
>> +	return;
>> +
>> +defer:
>> +	s = kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
>> +	if (!s)
>> +		return;
>
> In arena_free_pages(), when the deferred free path is taken but
> kmalloc_nolock() fails, the function returns silently without freeing
> the pages. These pages remain mapped in the kernel page tables and
> marked as allocated in the range tree, but become unusable.
>
> This can happen when:
> - The function is called from a non-sleepable context (sleepable=false)
> - Lock acquisition fails and falls through to defer
> - kmalloc_nolock() returns NULL (PREEMPT_RT+IRQ, lock contention, or
>   unsupported arch)
>
> The deferred free path is called from arena_alloc_pages() error
> handling and bpf_arena_free_pages_non_sleepable(). In both cases, the
> pages that should be freed will leak.
>
> Should there be a fallback mechanism or at least a warning when
> deferral fails?

Yes, this is expected because if kmalloc_nolock() fails in non-sleepable
context, we don't have another way to get memory for arena_free_span, we
are accepting this trade-off, failing a 24 byte allocation here is
highly unlikely, but we can have a WARN_ONCE here. We had an offline
discussion about having debug counters from arena, maybe we can add a
counter here.

And for failure path of arena_alloc_pages, we could make
arena_alloc_pages get a sleepable parameter and call arena_free_pages()
with this parameter so we don't defer unnecessarily when
arena_alloc_pages() is called in sleepable context.

>> +
>> +	s->page_cnt = page_cnt;
>> +	s->uaddr = uaddr;
>> +	llist_add(&s->node, &arena->free_spans);
>> +	irq_work_queue(&arena->free_irq);
>>  }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19363121319

