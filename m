Return-Path: <bpf+bounces-42949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF429AD4A1
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F302838EE
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE551D14E4;
	Wed, 23 Oct 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O3c+kedm"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043961CF5C4;
	Wed, 23 Oct 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711377; cv=none; b=q57vHUwegqYwGSuFOZqNZficSJpiWPBQUB418sg3LIY7wxTToeC6LWrY4WELx/USG52Dat+xvlHKToWNtSnJBtSEi4YbL1xSitpXIHLYRzJWX5OkXOnCJyOkKtBvoncjYlTfRLgooEZT5j6vzZ+M4urKD5fI3KInG1tW4pH5rM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711377; c=relaxed/simple;
	bh=dPf+AQ3s92xAb2BgedYsfVpbwXVL7KotyN+oowhouFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaC0cjoxCNw0tC+c9L+UnSb4GFAaMllFut14EPfIJC4rX23zZF23iBIq9V13coaAeaL6FxmTX1+OrYqb53aYd36wLWtamb8fB4vIzzwRrjAUZjYMufyebshwEtueO71LpuDjh0ui8m2hhsHGBRUzQM63bljeTamXSwvYMmHcQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O3c+kedm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bjpn07mKWG+e5cbzYSiLKd9EMhYvYVJFmfG6/l792so=; b=O3c+kedmaSZ7Rp4kq5v5gUlLVp
	zKtp6aac143tFKnwtEa9TBUsucVA8PowqlTmJQMkKtZSJdCKWEs9DH6QNb9ZPqTuIWVsikoEwTVXG
	bGgnmDeh8PvEjVo/uh/U2k4WHQOC70FwvRuDimBiOWbyc9+UcaCCVu4JsGYQ7xZ2Rx5dIRTyZNQHr
	GeejDHk10mDt4XqUbN+DkiY5IbisPuldQrkbJN/Gcr2T3H0bYjr0lKTApfRgCvRhX7o/Je/o2FHlG
	4/BUN0+tqSTUBb0rpvImyV0EaRW3P9N4HaLFvRJmqXI976b+rhZkxHMthXQYZoSwi1TgEba0vGc4X
	yHwLAp1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3gwH-00000008X5h-3iez;
	Wed, 23 Oct 2024 19:22:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3B6A30073F; Wed, 23 Oct 2024 21:22:36 +0200 (CEST)
Date: Wed, 23 Oct 2024 21:22:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com,
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev,
	hannes@cmpxchg.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 4/4] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20241023192236.GB11151@noisy.programming.kicks-ass.net>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010205644.3831427-5-andrii@kernel.org>

On Thu, Oct 10, 2024 at 01:56:44PM -0700, Andrii Nakryiko wrote:

> Suggested-by: Matthew Wilcox <willy@infradead.org>

I'm fairly sure I've suggested much the same :-)

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 50 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index fa1024aad6c4..9dc6e78975c9 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2047,6 +2047,52 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>  	return is_trap_insn(&opcode);
>  }
>  
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct uprobe *uprobe = NULL;
> +	struct vm_area_struct *vma;
> +	struct file *vm_file;
> +	struct inode *vm_inode;
> +	unsigned long vm_pgoff, vm_start;
> +	loff_t offset;
> +	long seq;
> +
> +	guard(rcu)();
> +
> +	if (!mmap_lock_speculation_start(mm, &seq))
> +		return NULL;

So traditional seqcount assumed non-preemptible lock sides and would
spin-wait for the LSB to clear, but for PREEMPT_RT we added preemptible
seqcount support and that takes the lock to wait, which in this case is
exactly the same as returning NULL and doing the lookup holding
mmap_lock, so yeah.

> +
> +	vma = vma_lookup(mm, bp_vaddr);
> +	if (!vma)
> +		return NULL;
> +
> +	/* vm_file memory can be reused for another instance of struct file,

Comment style nit.

> +	 * but can't be freed from under us, so it's safe to read fields from
> +	 * it, even if the values are some garbage values; ultimately
> +	 * find_uprobe_rcu() + mmap_lock_speculation_end() check will ensure
> +	 * that whatever we speculatively found is correct
> +	 */
> +	vm_file = READ_ONCE(vma->vm_file);
> +	if (!vm_file)
> +		return NULL;
> +
> +	vm_pgoff = data_race(vma->vm_pgoff);
> +	vm_start = data_race(vma->vm_start);
> +	vm_inode = data_race(vm_file->f_inode);

So... seqcount has kcsan annotations other than data_race(). I suppose
this works, but it all feels like a bad copy with random changes.

> +
> +	offset = (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_start);
> +	uprobe = find_uprobe_rcu(vm_inode, offset);
> +	if (!uprobe)
> +		return NULL;
> +
> +	/* now double check that nothing about MM changed */
> +	if (!mmap_lock_speculation_end(mm, seq))
> +		return NULL;

Typically seqcount does a re-try here.

> +
> +	return uprobe;
> +}

