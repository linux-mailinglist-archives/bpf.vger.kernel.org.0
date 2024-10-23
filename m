Return-Path: <bpf+bounces-42953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E99AD554
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 22:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC31C21893
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 20:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520261E2304;
	Wed, 23 Oct 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IegbwoeX"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A024142623;
	Wed, 23 Oct 2024 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714244; cv=none; b=TqY82+HT91ezdsZDRZ7Ihk4JfJ1Rn40p9JikTaZOvj6O5pSyZ5sTbw/QkpCybzf8WZVmUAAg2pu3yzzXXkewhPB2Zcz8RHK6NxINcBUCgeELtirhMazNy3CH800DZj4w6vUkUjuXxQiNgNoWFwvOvu4lejN0zy1lPvfYGAix0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714244; c=relaxed/simple;
	bh=wjzY5hlWokJZJqyCtoM63iivGkyHT750Iiaq8dtTlDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0LX+nx2n/Mh59PXcdZX4C7apaJ0it5KzdRPCGVeN9+bTg0VX7FxuElKQI6RTznznPJmlezEDiIcKBkBJvv8F8fmi6sHUrbe6hfsH6Sqa0CMdJt0HWAI+tN4I26JDBK7xWe3cTUU17TkT5jDvlVo6GJFJrZ4MCDUf/5sbGUzjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IegbwoeX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k0kAR5oFjFmERcfAhxKq77ZBkdV3j2tk6jq69iAXIpk=; b=IegbwoeXWLDI9S3bJ1Edwr1HxX
	DfFu7/Gy9o9gQOxI+Ks2lINBvVQXlt5al9v8StJjEFc+iSal5hFl98T8J6xYCu308FBuDnHpD9Szg
	ATQLIROpIUwzU2hYvNGxqy+womlZ8R13BfBHphc5+cZtm8YNQh6o6VK75mqudL3XBoMGXK/8JmIFN
	YGZUDj7fln1t2Sl23QYY3JER5PpJDjO/1Erk7TWSMDcNeMpLUdrrfeK5G/K05RGASlM4M07R/+f3b
	yoglMgVd6MsUCSKdxsxqtGfE8u0Wb41puKCDs1avWmNHL+7LBRULgnwFwRM1ormRjBfhohfm4eSed
	w4uWKSQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hgd-00000003JY4-3N8d;
	Wed, 23 Oct 2024 20:10:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 756DE30073F; Wed, 23 Oct 2024 22:10:31 +0200 (CEST)
Date: Wed, 23 Oct 2024 22:10:31 +0200
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
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce
 mmap_lock_speculation_{start|end}
Message-ID: <20241023201031.GF11151@noisy.programming.kicks-ass.net>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010205644.3831427-2-andrii@kernel.org>

On Thu, Oct 10, 2024 at 01:56:41PM -0700, Andrii Nakryiko wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@google.com
> ---
>  include/linux/mm_types.h  |  3 ++
>  include/linux/mmap_lock.h | 72 ++++++++++++++++++++++++++++++++-------
>  kernel/fork.c             |  3 --
>  3 files changed, 63 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6e3bdf8e38bc..5d8cdebd42bc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -887,6 +887,9 @@ struct mm_struct {
>  		 * Roughly speaking, incrementing the sequence number is
>  		 * equivalent to releasing locks on VMAs; reading the sequence
>  		 * number can be part of taking a read lock on a VMA.
> +		 * Incremented every time mmap_lock is write-locked/unlocked.
> +		 * Initialized to 0, therefore odd values indicate mmap_lock
> +		 * is write-locked and even values that it's released.
>  		 *
>  		 * Can be modified under write mmap_lock using RELEASE
>  		 * semantics.
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..9d23635bc701 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,39 +71,84 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
>  }
>  
>  #ifdef CONFIG_PER_VMA_LOCK
> +static inline void init_mm_lock_seq(struct mm_struct *mm)
> +{
> +	mm->mm_lock_seq = 0;
> +}
> +
>  /*
> - * Drop all currently-held per-VMA locks.
> - * This is called from the mmap_lock implementation directly before releasing
> - * a write-locked mmap_lock (or downgrading it to read-locked).
> - * This should normally NOT be called manually from other places.
> - * If you want to call this manually anyway, keep in mind that this will release
> - * *all* VMA write locks, including ones from further up the stack.
> + * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE semantics)
> + * or write-unlocked (RELEASE semantics).
>   */
> -static inline void vma_end_write_all(struct mm_struct *mm)
> +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
>  {
>  	mmap_assert_write_locked(mm);
>  	/*
>  	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
>  	 * mmap_lock being held.
> -	 * We need RELEASE semantics here to ensure that preceding stores into
> -	 * the VMA take effect before we unlock it with this store.
> -	 * Pairs with ACQUIRE semantics in vma_start_read().
>  	 */
> -	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +
> +	if (acquire) {
> +		WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +		/*
> +		 * For ACQUIRE semantics we should ensure no following stores are
> +		 * reordered to appear before the mm->mm_lock_seq modification.
> +		 */
> +		smp_wmb();

Strictly speaking this isn't ACQUIRE, nor do we care about ACQUIRE here.
This really is about subsequent stores, loads are irrelevant.

> +	} else {
> +		/*
> +		 * We need RELEASE semantics here to ensure that preceding stores
> +		 * into the VMA take effect before we unlock it with this store.
> +		 * Pairs with ACQUIRE semantics in vma_start_read().
> +		 */

Again, not strictly true. We don't care about loads. Using RELEASE here
is fine and probably cheaper on a few platforms, but we don't strictly
need/care about RELEASE.

> +		smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +	}
> +}

Also, it might be saner to stick closer to the seqcount naming of
things and use two different functions for these two different things.

/* straight up copy of do_raw_write_seqcount_begin() */
static inline void mm_write_seqlock_begin(struct mm_struct *mm)
{
	kcsan_nestable_atomic_begin();
	mm->mm_lock_seq++;
	smp_wmb();
}

/* straigjt up copy of do_raw_write_seqcount_end() */
static inline void mm_write_seqcount_end(struct mm_struct *mm)
{
	smp_wmb();
	mm->mm_lock_seq++;
	kcsan_nestable_atomic_end();
}

Or better yet, just use seqcount...

> +
> +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq)
> +{
> +	/* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> +	*seq = smp_load_acquire(&mm->mm_lock_seq);
> +	/* Allow speculation if mmap_lock is not write-locked */
> +	return (*seq & 1) == 0;
> +}
> +
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq)
> +{
> +	/* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
> +	smp_rmb();
> +	return seq == READ_ONCE(mm->mm_lock_seq);
>  }

Because there's nothing better than well known functions with a randomly
different name and interface I suppose...


Anyway, all the actual code proposed is not wrong. I'm just a bit
annoyed its a random NIH of seqcount.

