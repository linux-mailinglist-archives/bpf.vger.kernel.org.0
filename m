Return-Path: <bpf+bounces-21425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E435784D154
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBB6288BAA
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED083CBE;
	Wed,  7 Feb 2024 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRCQtFWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4D7CF05
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331249; cv=none; b=cw6kgHKagX/XM3MgGIBxA5cEZRmHlPeXVwBj0a3Zp0PLliH87yql+HXcO74VWlmOnIvtNgHgngzOwHbibopH10oFmDbE1z+mTAccMhDdsF+FI/FEPgNg5Oku5Kppr3k/CQtjeArfue9UhmC98vOagMRzOKzAluQvoGspYKYRuuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331249; c=relaxed/simple;
	bh=Aj7L6ls1+MSVwmjBjKGVoquh+HZsSFz7gx7kBViHl20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgBnkFSLqX0W9e06JjskTReAnvyqOCtvKltr2G3W/H3roTFJVv8eHvotaL24WXxqfhbDnqEWTX41M1XbeddQQignbsoPXO0wVIp3ne95vRX2pJcC/zfQ0EPcgEdBaG0Nh0ZUEuHDekDqR1qS4d4xO28m7ca6Hn35Em1SJtyQrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRCQtFWs; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42c44a3e49dso1115631cf.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707331247; x=1707936047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMKYHEGO8OGFfMZIK6TAH+I7Ps3mXGWjstBs6/KrTMw=;
        b=rRCQtFWsD9rhTtrE92T9q9Bi0ndUaxPqEPZ0sjh+5RnKG3r/JtjPAjQEOcL8tFBDI0
         plrGGgmLLUEh/YPYolFKwHPoHhou0wK12hYZiBbd0dyn7KrpDZtuT4eEPyT2BUS/L7cF
         qtud+DRRHX/s97/i9GBnEN1tZNdB8FE+LNQmHDES9vBA1K+Y+wfebkoETIB1oAzyzXny
         P1tcIhSLYVh53dWkJwzETNEXio3oVLpIWue3uW9b4cieeIFwlvSz7tK69RERGs+ga5m4
         qGEyTQRAgCIGYMJJCnhTqpfcUJoVtMI24HesWjMkpRQMeQbizTgIKXn5GnLMA6DTEBJU
         wXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331247; x=1707936047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMKYHEGO8OGFfMZIK6TAH+I7Ps3mXGWjstBs6/KrTMw=;
        b=p7Wm4XfwLSyRPvyNfTv9DIg1OfdTqUWkM4Lgi1eIFa69WIaJQwL3qpyXTGYouNeDfm
         zCRkxzjy7CJX/638eEqI4wIqT4vSXn+ew6KusPVCx7QmrNFGvlG+6MPhkqBm7WAY2Ywo
         88xvb7MCeBuA/evaCSaK0BsVLOmQ/z+Ro/UVKcG55ZPS8as6+SLFl7EIcbKPWOCamRJV
         57i4ITXhWDH9jVMtSO9KBugTWnH/ugXkb+U6AaqXraB1ClWNJhJsQj0qai24Rcn3i7Pk
         4H7NzCshWn7/N98k28iVL98ei27m0j3dKalr4gz13lIKwtnHX+H38NO2MWp+FdVBiMHc
         q5lQ==
X-Gm-Message-State: AOJu0YzEUdXi6JQqCGUm2/6QChdV3E0Tkl1tdUHwwvpseEHmek5klRyu
	8lylKlZUssXTsPKNh1VX3A16oDoS2ypKZg336uO3uZrSKOXwdVM3fv03jHXoiA==
X-Google-Smtp-Source: AGHT+IHeJdUqhpXNx+1GYLxUb/1MU/X0KY56JZaROgzSIPvD99ja5LmdL3d57h+zrTZlZmc/QGkcLg==
X-Received: by 2002:a05:6214:4012:b0:68c:b640:287b with SMTP id kd18-20020a056214401200b0068cb640287bmr525539qvb.16.1707331246457;
        Wed, 07 Feb 2024 10:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9oRGyvdogq920O2+LVS2XJduV6CcBk5gRf3xDq/jJQUICKsqfRGbh2cqRkZft7N9Y4v/MtUXNwZECG+IiIiY5coj4BqXmEAScvMT/d3YDQA2eRkJrzDs3Z0pw0vZ9DK+J8cBYAySHq4ak1ZgmYsaisxZTEuSN7XwmyA2I24e0UDu0ddbqZ1gr6pCJCaXB3x3JKEf2D8xjrKRpkU0HAuiQH6CQ9Ghh0pTYr7DxtZz8pP+f3aXTrTc32tdC4oIWs1dCVBSsJRjC4iyl1KFsmLBl0OGYctUhENpJ9CPwxA4=
Received: from [192.168.1.8] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id om30-20020a0562143d9e00b0068cc1bba1d6sm438515qvb.145.2024.02.07.10.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 10:40:45 -0800 (PST)
Message-ID: <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
Date: Wed, 7 Feb 2024 13:40:44 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/16] bpf: Introduce bpf_arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org,
 hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-5-alexei.starovoitov@gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <20240206220441.38311-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 17:04, Alexei Starovoitov wrote:
> +
> +static long compute_pgoff(struct bpf_arena *arena, long uaddr)
> +{
> +	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> +}
> +
> +#define MT_ENTRY ((void *)&arena_map_ops) /* unused. has to be valid pointer */
> +
> +/*
> + * Reserve a "zero page", so that bpf prog and user space never see
> + * a pointer to arena with lower 32 bits being zero.
> + * bpf_cast_user() promotes it to full 64-bit NULL.
> + */
> +static int reserve_zero_page(struct bpf_arena *arena)
> +{
> +	long pgoff = compute_pgoff(arena, 0);
> +
> +	return mtree_insert(&arena->mt, pgoff, MT_ENTRY, GFP_KERNEL);
> +}
> +

this is pretty tricky, and i think i didn't understand it at first.

you're punching a hole in the arena, such that BPF won't allocate it via 
arena_alloc_pages().  thus BPF won't 'produce' an object with a pointer 
ending in 0x00000000.

depending on where userspace mmaps the arena, that hole may or may not 
be the first page in the array.  if userspace mmaps it to a 4GB aligned 
virtual address, it'll be page 0.  but it could be at some arbitrary 
offset within the 4GB arena.

that arbitrariness makes it harder for a BPF program to do its own 
allocations within the arena.  i'm planning on carving up the 4GB arena 
for my own purposes, managed by BPF, with the expectation that i'll be 
able to allocate any 'virtual address' within the arena.  but there's a 
magic page that won't be usable.

i can certainly live with this.  just mmap userspace to a 4GB aligned 
address + PGSIZE, so that the last page in the arena is page 0.  but 
it's a little weird.

though i think we'll have more serious issues if anyone accidentally 
tries to use that zero page.  BPF would get an EEXIST if they try to 
allocate it directly, but then page fault and die if they touched it, 
since there's no page.  i can live with that, if we force it to be the 
last page in the arena.

however, i think you need to add something to the fault handler (below) 
in case userspace touches that page:

[snip]
> +static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
> +{
> +	struct bpf_map *map = vmf->vma->vm_file->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	struct page *page;
> +	long kbase, kaddr;
> +	int ret;
> +
> +	kbase = bpf_arena_get_kern_vm_start(arena);
> +	kaddr = kbase + (u32)(vmf->address & PAGE_MASK);
> +
> +	guard(mutex)(&arena->lock);
> +	page = vmalloc_to_page((void *)kaddr);
> +	if (page)
> +		/* already have a page vmap-ed */
> +		goto out;
> +
> +	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> +		/* User space requested to segfault when page is not allocated by bpf prog */
> +		return VM_FAULT_SIGSEGV;
> +
> +	ret = mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERNEL);
> +	if (ret == -EEXIST)
> +		return VM_FAULT_RETRY;

say this was the zero page.  vmalloc_to_page() failed, so we tried to 
insert.  we get EEXIST, since the slot is reserved.  we retry, since we 
were expecting the case where "no page, yet slot reserved" meant that 
BPF was in the middle of filling this page.

though i think you can fix this by just treating this as a SIGSEGV 
instead of RETRY.  when i made the original suggestion of making this a 
retry (in an email off list), that was before you had the arena mutex. 
now that you have the mutex, you shouldn't have the scenario where two 
threads are concurrently trying to fill a page.  i.e. mtree_insert + 
page_alloc + vmap are all atomic w.r.t. the mutex.


> +	if (ret)
> +		return VM_FAULT_SIGSEGV;
> +
> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!page) {
> +		mtree_erase(&arena->mt, vmf->pgoff);
> +		return VM_FAULT_SIGSEGV;
> +	}
> +
> +	ret = vmap_pages_range(kaddr, kaddr + PAGE_SIZE, PAGE_KERNEL, &page, PAGE_SHIFT);
> +	if (ret) {
> +		mtree_erase(&arena->mt, vmf->pgoff);
> +		__free_page(page);
> +		return VM_FAULT_SIGSEGV;
> +	}
> +out:
> +	page_ref_add(page, 1);
> +	vmf->page = page;
> +	return 0;
> +}

[snip]

> +static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
> +{
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	int err;
> +
> +	if (arena->user_vm_start && arena->user_vm_start != vma->vm_start)
> +		/*
> +		 * 1st user process can do mmap(NULL, ...) to pick user_vm_start
> +		 * 2nd user process must pass the same addr to mmap(addr, MAP_FIXED..);
> +		 *   or
> +		 * specify addr in map_extra at map creation time and
> +		 * use the same addr later with mmap(addr, MAP_FIXED..);
> +		 */
> +		return -EBUSY;
> +
> +	if (arena->user_vm_end && arena->user_vm_end != vma->vm_end)
> +		/* all user processes must have the same size of mmap-ed region */
> +		return -EBUSY;
> +
> +	if (vma->vm_end - vma->vm_start > 1ull << 32)
> +		/* Must not be bigger than 4Gb */
> +		return -E2BIG;
> +
> +	if (remember_vma(arena, vma))
> +		return -ENOMEM;
> +
> +	if (!arena->user_vm_start) {
> +		arena->user_vm_start = vma->vm_start;
> +		err = reserve_zero_page(arena);
> +		if (err)
> +			return err;
> +	}
> +	arena->user_vm_end = vma->vm_end;
> +	/*
> +	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
> +	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
> +	 * potential change of user_vm_start.
> +	 */
> +	vm_flags_set(vma, VM_DONTEXPAND);
> +	vma->vm_ops = &arena_vm_ops;
> +	return 0;
> +}

i think this whole function needs to be protected by the mutex, or at 
least all the stuff relate to user_vm_{start,end}.  if you have to 
threads mmapping the region for the first time, you'll race on the 
values of user_vm_*.


[snip]

> +/*
> + * Allocate pages and vmap them into kernel vmalloc area.
> + * Later the pages will be mmaped into user space vma.
> + */
> +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id)

instead of uaddr, can you change this to take an address relative to the 
arena ("arena virtual address"?)?  the caller of this is in BPF, and 
they don't easily know the user virtual address.  maybe even just pgoff 
directly.

additionally, you won't need to call compute_pgoff().  as it is now, i'm 
not sure what would happen if BPF did an arena_alloc with a uaddr and 
user_vm_start wasn't set yet.  actually, i guess it'd just be 0, so 
uaddr would act like an arena virtual address, up until the moment where 
someone mmaps, then it'd suddenly change to be a user virtual address.

either way, making uaddr an arena-relative addr would make all that moot.


> +{
> +	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;

any time you compute_pgoff() or look at user_vm_{start,end}, maybe 
either hold the mutex, or only do it from mmap faults (where we know 
user_vm_start is already set).  o/w there might be subtle races where 
some other thread is mmapping the arena for the first time.


> +	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
> +	long pgoff = 0, kaddr, nr_pages = 0;
> +	struct page **pages;
> +	int ret, i;
> +
> +	if (page_cnt >= page_cnt_max)
> +		return 0;
> +
> +	if (uaddr) {
> +		if (uaddr & ~PAGE_MASK)
> +			return 0;
> +		pgoff = compute_pgoff(arena, uaddr);
> +		if (pgoff + page_cnt > page_cnt_max)
> +			/* requested address will be outside of user VMA */
> +			return 0;
> +	}
> +
> +	/* zeroing is needed, since alloc_pages_bulk_array() only fills in non-zero entries */
> +	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return 0;
> +
> +	guard(mutex)(&arena->lock);
> +
> +	if (uaddr)
> +		ret = mtree_insert_range(&arena->mt, pgoff, pgoff + page_cnt,
> +					 MT_ENTRY, GFP_KERNEL);
> +	else
> +		ret = mtree_alloc_range(&arena->mt, &pgoff, MT_ENTRY,
> +					page_cnt, 0, page_cnt_max, GFP_KERNEL);
> +	if (ret)
> +		goto out_free_pages;
> +
> +	nr_pages = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_ZERO, node_id, page_cnt, pages);
> +	if (nr_pages != page_cnt)
> +		goto out;
> +
> +	kaddr = kern_vm_start + (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);

adding user_vm_start here is pretty subtle.

so far i've been thinking that the mtree is the "address space" of the 
arena, in units of pages instead of bytes.  and pgoff is an address 
within the arena.  so mtree slot 0 is the 0th page of the 4GB region. 
and that "arena address space" is mapped at a kernel virtual address and 
a user virtual address (the same for all processes).

to convert user addresses (uaddr et al.) to arena addresses, we subtract 
user_vm_start, which makes sense.  that's what compute_pgoff() does.

i was expecting kaddr = kern_vm_start + pgoff * PGSIZE, essentially 
converting from arena address space to kernel virtual address.

instead, by adding user_vm_start and casting to u32, you're converting 
or shifting arena addresses to *another* arena address (user address, 
truncated to 4GB to keep it in the arena), and that is the one that the 
kernel will use.

is that correct?

my one concern is that there's some subtle wrap-around going on, and due 
to the shifting, kaddr can be very close to the end of the arena and 
page_cnt can be big enough to go outside the 4GB range.  we'd want it to 
wrap around.  e.g.

user_start_va = 0x1,fffff000
user_end_va =   0x2,fffff000
page_cnt_max = 0x100000 or whatever.  full 4GB range.

say we want to alloc at pgoff=0 (uaddr 0x1,fffff000), page_cnt = X.  you 
can get this pgoff either by doing mtree_insert_range or 
mtree_alloc_range on an arena with no allocations.

kaddr = kern_vm_start + 0xfffff000

the size of the vm area is 4GB + guard stuff, and we're right up against 
the end of it.

if page_cnt > the guard size, vmap_pages_range() would be called on 
something outside the vm area we reserved, which seems bad.  and even if 
it wasn't, what we want is for later page maps to start at the beginning 
of kern_vm_start.

the fix might be to just only map a page at a time - maybe a loop.  or 
detect when we're close to the edge and break it into two vmaps.  i feel 
like the loop would be easier to understand, but maybe less efficient.

> +	ret = vmap_pages_range(kaddr, kaddr + PAGE_SIZE * page_cnt, PAGE_KERNEL,
> +			       pages, PAGE_SHIFT);
> +	if (ret)
> +		goto out;
> +	kvfree(pages);
> +	return clear_lo32(arena->user_vm_start) + (u32)(kaddr - kern_vm_start);
> +out:
> +	mtree_erase(&arena->mt, pgoff);
> +out_free_pages:
> +	if (pages)
> +		for (i = 0; i < nr_pages; i++)
> +			__free_page(pages[i]);
> +	kvfree(pages);
> +	return 0;
> +}

thanks,
barret



> +
> +/*
> + * If page is present in vmalloc area, unmap it from vmalloc area,
> + * unmap it from all user space vma-s,
> + * and free it.
> + */
> +static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
> +{
> +	struct vma_list *vml;
> +
> +	list_for_each_entry(vml, &arena->vma_list, head)
> +		zap_page_range_single(vml->vma, uaddr,
> +				      PAGE_SIZE * page_cnt, NULL);
> +}
> +
> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
> +{
> +	u64 full_uaddr, uaddr_end;
> +	long kaddr, pgoff, i;
> +	struct page *page;
> +
> +	/* only aligned lower 32-bit are relevant */
> +	uaddr = (u32)uaddr;
> +	uaddr &= PAGE_MASK;
> +	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
> +	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
> +	if (full_uaddr >= uaddr_end)
> +		return;
> +
> +	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> +
> +	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
> +
> +	guard(mutex)(&arena->lock);
> +
> +	pgoff = compute_pgoff(arena, uaddr);
> +	/* clear range */
> +	mtree_store_range(&arena->mt, pgoff, pgoff + page_cnt, NULL, GFP_KERNEL);
> +
> +	if (page_cnt > 1)
> +		/* bulk zap if multiple pages being freed */
> +		zap_pages(arena, full_uaddr, page_cnt);
> +
> +	for (i = 0; i < page_cnt; i++, kaddr += PAGE_SIZE, full_uaddr += PAGE_SIZE) {
> +		page = vmalloc_to_page((void *)kaddr);
> +		if (!page)
> +			continue;
> +		if (page_cnt == 1 && page_mapped(page)) /* mapped by some user process */
> +			zap_pages(arena, full_uaddr, 1);
> +		vunmap_range(kaddr, kaddr + PAGE_SIZE);
> +		__free_page(page);
> +	}
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
> +					int node_id, u64 flags)
> +{
> +	struct bpf_map *map = p__map;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	if (map->map_type != BPF_MAP_TYPE_ARENA || !arena->user_vm_start || flags)
> +		return NULL;
> +
> +	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id);
> +}
> +
> +__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
> +{
> +	struct bpf_map *map = p__map;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	if (map->map_type != BPF_MAP_TYPE_ARENA || !arena->user_vm_start)
> +		return;
> +	arena_free_pages(arena, (long)ptr__ign, page_cnt);
> +}



