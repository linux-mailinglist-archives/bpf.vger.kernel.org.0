Return-Path: <bpf+bounces-33611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA00923B52
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105591C22890
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F38157E84;
	Tue,  2 Jul 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byDL4QTf"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEA154449;
	Tue,  2 Jul 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915787; cv=none; b=lg90qQe1/9SqltALwa/qAF87PH5jcCpYL27LFfHulRsSivYmp6G0FwjpuLsKwG3gORcgnmW1+w27uohV0DL1Wh6MGHbmahXej6jMqYKgFRwxAZhP9j8Gjeh/RzZWpM0yaxeR221aaVTG0DcL2q/3XMB87bKg7giVKIve/TULPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915787; c=relaxed/simple;
	bh=bFjuzJ295uJimSFa8xCMyegxRKXHOfDHP87kW0xW+LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXKpT0/dEyruR+uU1+l0S8J9j1M9atTR+C/4QG6VBSBBFX9/VH4wTfRjylnv8/rmRQIkW9NzDkhyFBjKq/XqNLBh2Cq/mJXsdtogiQPzMqO3cy28MNcFpCAfSbXJbqkVecAmtsKmaT1dhjMa7mNX/I+E/GWxMLe+Vh/FrgHpBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byDL4QTf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M1hpvyL+mQoOpfMwMhftwcClDsPopz7FwsJCl2tQTdA=; b=byDL4QTfHEpsCvoIhoGYzFnKgr
	kg10R1n+S0iX+L/93AzGvjlgze5EGYRn0mdHuFBoiLDoE1k+iKv0r+dzR7m8nj7ufuRIplm1mZej5
	r+aR7gkL44vQVghYWb49hd9Wmh3TsCa0w+yUkuu5JjfJKy+LvfIol9q5J5pXFQejE+oWe7cz5NAe1
	ywjY1bUdPTvsh92a8rTD4Ptll7kCqCrQ0Y9McddqvJ1l2Ff+JJEM5NUNjc4c7khS9s7aNJfplQQOr
	Gy8YQC7WlrG2txluJQJ5MBYdnb9MATbUu3Z/x26i0FAuOjqJn/K8UIx6lUadvrv742IXWJnYNVYSC
	eFzDqc2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaf3-00000009o3U-25Np;
	Tue, 02 Jul 2024 10:22:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9BC4F300694; Tue,  2 Jul 2024 12:22:54 +0200 (CEST)
Date: Tue, 2 Jul 2024 12:22:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240702102254.GF11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-5-andrii@kernel.org>

On Mon, Jul 01, 2024 at 03:39:27PM -0700, Andrii Nakryiko wrote:

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 23449a8c5e7e..560cf1ca512a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -53,9 +53,10 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
>  
>  struct uprobe {
>  	struct rb_node		rb_node;	/* node in the rb tree */
> -	refcount_t		ref;
> +	atomic64_t		ref;		/* see UPROBE_REFCNT_GET below */
>  	struct rw_semaphore	register_rwsem;
>  	struct rw_semaphore	consumer_rwsem;
> +	struct rcu_head		rcu;
>  	struct list_head	pending_list;
>  	struct uprobe_consumer	*consumers;
>  	struct inode		*inode;		/* Also hold a ref to inode */
> @@ -587,15 +588,138 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
>  			*(uprobe_opcode_t *)&auprobe->insn);
>  }
>  
> -static struct uprobe *get_uprobe(struct uprobe *uprobe)
> +/*
> + * Uprobe's 64-bit refcount is actually two independent counters co-located in
> + * a single u64 value:
> + *   - lower 32 bits are just a normal refcount with is increment and
> + *   decremented on get and put, respectively, just like normal refcount
> + *   would;
> + *   - upper 32 bits are a tag (or epoch, if you will), which is always
> + *   incremented by one, no matter whether get or put operation is done.
> + *
> + * This upper counter is meant to distinguish between:
> + *   - one CPU dropping refcnt from 1 -> 0 and proceeding with "destruction",
> + *   - while another CPU continuing further meanwhile with 0 -> 1 -> 0 refcnt
> + *   sequence, also proceeding to "destruction".
> + *
> + * In both cases refcount drops to zero, but in one case it will have epoch N,
> + * while the second drop to zero will have a different epoch N + 2, allowing
> + * first destructor to bail out because epoch changed between refcount going
> + * to zero and put_uprobe() taking uprobes_treelock (under which overall
> + * 64-bit refcount is double-checked, see put_uprobe() for details).
> + *
> + * Lower 32-bit counter is not meant to over overflow, while it's expected

So refcount_t very explicitly handles both overflow and underflow and
screams bloody murder if they happen. Your thing does not.. 

> + * that upper 32-bit counter will overflow occasionally. Note, though, that we
> + * can't allow upper 32-bit counter to "bleed over" into lower 32-bit counter,
> + * so whenever epoch counter gets highest bit set to 1, __get_uprobe() and
> + * put_uprobe() will attempt to clear upper bit with cmpxchg(). This makes
> + * epoch effectively a 31-bit counter with highest bit used as a flag to
> + * perform a fix-up. This ensures epoch and refcnt parts do not "interfere".
> + *
> + * UPROBE_REFCNT_GET constant is chosen such that it will *increment both*
> + * epoch and refcnt parts atomically with one atomic_add().
> + * UPROBE_REFCNT_PUT is chosen such that it will *decrement* refcnt part and
> + * *increment* epoch part.
> + */
> +#define UPROBE_REFCNT_GET ((1LL << 32) + 1LL) /* 0x0000000100000001LL */
> +#define UPROBE_REFCNT_PUT ((1LL << 32) - 1LL) /* 0x00000000ffffffffLL */
> +
> +/*
> + * Caller has to make sure that:
> + *   a) either uprobe's refcnt is positive before this call;
> + *   b) or uprobes_treelock is held (doesn't matter if for read or write),
> + *      preventing uprobe's destructor from removing it from uprobes_tree.
> + *
> + * In the latter case, uprobe's destructor will "resurrect" uprobe instance if
> + * it detects that its refcount went back to being positive again inbetween it
> + * dropping to zero at some point and (potentially delayed) destructor
> + * callback actually running.
> + */
> +static struct uprobe *__get_uprobe(struct uprobe *uprobe)
>  {
> -	refcount_inc(&uprobe->ref);
> +	s64 v;
> +
> +	v = atomic64_add_return(UPROBE_REFCNT_GET, &uprobe->ref);

Distinct lack of u32 overflow testing here..

> +
> +	/*
> +	 * If the highest bit is set, we need to clear it. If cmpxchg() fails,
> +	 * we don't retry because there is another CPU that just managed to
> +	 * update refcnt and will attempt the same "fix up". Eventually one of
> +	 * them will succeed to clear highset bit.
> +	 */
> +	if (unlikely(v < 0))
> +		(void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63));
> +
>  	return uprobe;
>  }

>  static void put_uprobe(struct uprobe *uprobe)
>  {
> -	if (refcount_dec_and_test(&uprobe->ref)) {
> +	s64 v;
> +
> +	/*
> +	 * here uprobe instance is guaranteed to be alive, so we use Tasks
> +	 * Trace RCU to guarantee that uprobe won't be freed from under us, if

What's wrong with normal RCU?

> +	 * we end up being a losing "destructor" inside uprobe_treelock'ed
> +	 * section double-checking uprobe->ref value below.
> +	 * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> +	 */
> +	rcu_read_lock_trace();
> +
> +	v = atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);

No underflow handling... because nobody ever had a double put bug.

> +	if (unlikely((u32)v == 0)) {
> +		bool destroy;
> +
> +		write_lock(&uprobes_treelock);
> +		/*
> +		 * We might race with find_uprobe()->__get_uprobe() executed
> +		 * from inside read-locked uprobes_treelock, which can bump
> +		 * refcount from zero back to one, after we got here. Even
> +		 * worse, it's possible for another CPU to do 0 -> 1 -> 0
> +		 * transition between this CPU doing atomic_add() and taking
> +		 * uprobes_treelock. In either case this CPU should bail out
> +		 * and not proceed with destruction.
> +		 *
> +		 * So now that we have exclusive write lock, we double check
> +		 * the total 64-bit refcount value, which includes the epoch.
> +		 * If nothing changed (i.e., epoch is the same and refcnt is
> +		 * still zero), we are good and we proceed with the clean up.
> +		 *
> +		 * But if it managed to be updated back at least once, we just
> +		 * pretend it never went to zero. If lower 32-bit refcnt part
> +		 * drops to zero again, another CPU will proceed with
> +		 * destruction, due to more up to date epoch.
> +		 */
> +		destroy = atomic64_read(&uprobe->ref) == v;
> +		if (destroy && uprobe_is_active(uprobe))
> +			rb_erase(&uprobe->rb_node, &uprobes_tree);
> +		write_unlock(&uprobes_treelock);
> +
> +		/*
> +		 * Beyond here we don't need RCU protection, we are either the
> +		 * winning destructor and we control the rest of uprobe's
> +		 * lifetime; or we lost and we are bailing without accessing
> +		 * uprobe fields anymore.
> +		 */
> +		rcu_read_unlock_trace();
> +
> +		/* uprobe got resurrected, pretend we never tried to free it */
> +		if (!destroy)
> +			return;
> +
>  		/*
>  		 * If application munmap(exec_vma) before uprobe_unregister()
>  		 * gets called, we don't get a chance to remove uprobe from
> @@ -604,8 +728,21 @@ static void put_uprobe(struct uprobe *uprobe)
>  		mutex_lock(&delayed_uprobe_lock);
>  		delayed_uprobe_remove(uprobe, NULL);
>  		mutex_unlock(&delayed_uprobe_lock);
> -		kfree(uprobe);
> +
> +		call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
> +		return;
>  	}
> +
> +	/*
> +	 * If the highest bit is set, we need to clear it. If cmpxchg() fails,
> +	 * we don't retry because there is another CPU that just managed to
> +	 * update refcnt and will attempt the same "fix up". Eventually one of
> +	 * them will succeed to clear highset bit.
> +	 */
> +	if (unlikely(v < 0))
> +		(void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63));
> +
> +	rcu_read_unlock_trace();
>  }

