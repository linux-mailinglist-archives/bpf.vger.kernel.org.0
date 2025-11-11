Return-Path: <bpf+bounces-74242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE00C4F2AC
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8223A6200
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDAC36CE03;
	Tue, 11 Nov 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/+0HpBH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445103AA199
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880477; cv=none; b=U26inMNg//J5qkY0EpLllAQ57OYgQWPqLn8VJX0fviSslpMX3ks8CvH+F8pi3v9IdLbEUaY/SyPbfj7fQ7OYtjnAiSaUpXgsPQZA7IaueCfA+u2nH+Y5NvCVPSv54rD447Wl630p6mEJ3XC8hnSSzPvqkvmGjZO5427pMBgZlWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880477; c=relaxed/simple;
	bh=2M7Kiqqp6JvuxmSTKMLwU80+lhK6UtCwApu7ENHWizw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FyM6UGeaydVsoWQfXTJl3nh9NpL8Wsxd4A7OvB6H5aG2P4ZC/+jt/1fJlN01YyHN/6miXOuUNIK8SBeTSfsGepbFgTLvCiVxm8q55X+0jDiXSdcxczVY7/UiqQhCeYW9al3aQoiScr5iBiimQCQC3EVzJdgDTMIG0c4Rdt8s91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/+0HpBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8024FC4CEF5;
	Tue, 11 Nov 2025 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880476;
	bh=2M7Kiqqp6JvuxmSTKMLwU80+lhK6UtCwApu7ENHWizw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=b/+0HpBHLJReghVo5NNUrCHQJwOBzAba78VL/jHf/gPcL1ZayDKg1wk8XbBmDB/KQ
	 rr6L7t0XuNL7J8GBMaRg74w5ymgBGs1+rHIzqLhgz53e9ZDbjeWvWSFx8YxswmX63W
	 I0sXOvmPuyLXbn2ny9dqBstBhgsswupekBawTPZrFNoHVQvI2P91FViP0UIN4I43wa
	 VMDUybQk2ZLzN2qPngdM1wfUQOsptvFbsf25tVq6F1RBDW49mMdeH4dEiIzCWwd1wx
	 8qyxrcbGxa9RJGitiVR7eT0IPV5VnuhvlJkxu95W9mRDKZ8v5h/Ee+dzlzS1Ykabri
	 owVO7+agCb6mA==
Content-Type: multipart/mixed; boundary="===============4258684505079270332=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <868fe984f4c96d9fa12fb5aedeec6acdcb97339f9ba59e7900761dfed697e65e@mail.kernel.org>
In-Reply-To: <20251111163424.16471-4-puranjay@kernel.org>
References: <20251111163424.16471-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 3/4] bpf: arena: make arena kfuncs any context safe
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Nov 2025 17:01:16 +0000 (UTC)

--===============4258684505079270332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 09d5dc541..527921269 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 9d8a8eb44..f330b51de 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -327,12 +351,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>  	struct page *page;
>  	long kbase, kaddr;
> +	unsigned long flags;
>  	int ret;
>
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>
> -	guard(mutex)(&arena->lock);
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +		/*
> +		 * This is an impossible case and would only trigger if res_spin_lock is buggy or
> +		 * due to another kernel bug.
> +		 */
> +		return VM_FAULT_RETRY;
> +
>  	page = vmalloc_to_page((void *)kaddr);
>  	if (page)
>  		/* already have a page vmap-ed */
> @@ -344,26 +375,30 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>
>  	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
>  	if (ret)
> -		return VM_FAULT_SIGSEGV;
> +		goto out_unlock_sigsegv;
>
>  	struct apply_range_data data = { .pages = &page, .i = 0 };
>  	/* Account into memcg of the process that created bpf_arena */
>  	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		return VM_FAULT_SIGSEGV;
> +		goto out_unlock_sigsegv;
>  	}
>
>  	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		__free_page(page);
> -		return VM_FAULT_SIGSEGV;
> +		free_pages_nolock(page, 0);
> +		goto out_unlock_sigsegv;
>  	}
>  out:
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	page_ref_add(page, 1);
>  	vmf->page = page;
>  	return 0;
> +out_unlock_sigsegv:
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	return VM_FAULT_SIGSEGV;
>  }

Can the page reference race with arena_free_pages()? The sequence:

  Thread A (arena_vm_fault):
    bpf_map_alloc_pages() -> page refcount=1
    apply_to_page_range() -> maps PTE
    raw_res_spin_unlock_irqrestore()
    page_ref_add(page, 1) -> tries to increment to 2

  Thread B (arena_free_pages):
    raw_res_spin_lock_irqsave()
    apply_to_existing_page_range()->apply_range_clear_cb() -> clears PTE
    raw_res_spin_unlock_irqrestore()
    __free_page(page) -> refcount 1->0, page freed

Between Thread A's unlock and page_ref_add(), Thread B can acquire the
lock, clear the PTE, and free the page. Then Thread A's page_ref_add()
operates on freed memory.

Should page_ref_add() happen before releasing the spinlock, or should
the initial allocation start with refcount=2?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19272481461

--===============4258684505079270332==--

