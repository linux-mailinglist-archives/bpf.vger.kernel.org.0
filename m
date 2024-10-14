Return-Path: <bpf+bounces-41872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7899D4F4
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD46A1C21104
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033BC1AB510;
	Mon, 14 Oct 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnPdVIk3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594214AA9;
	Mon, 14 Oct 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924593; cv=none; b=SVepjxjnRQvEP43s0dluRTLOiT5dVjSzIPGyDCbWMLN1eZhhib0bcIECSOVqYU1w1ynDnWrTxlawhIjC3kZpuloRxScT3I8e0297LHIKY5p2yhmYjGuruVGW4Izkm2Df3lWRJ/2I74/xjqcXY58+YuB9rI/e2pveUWmQvJSV9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924593; c=relaxed/simple;
	bh=fA9m5ly6ClTa1NQ2ffi9oCuhS3aFmCWo59+WfWtIysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soDN/1wepuTh7k0bTOEf9gDVeLxH1qEhP5n6LLG27CICxBnQdMFqp2hf8FUJqmDz8bDTRRmc/yGHM21Wx4d1bsTCfxMtG08dT4JprI8NzN5x4fxYXRMHVWKRdCBbpy4wNdcIQqzcfPKawYn4iSxrsfkYSqtc70dLdFDhpPeIJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnPdVIk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44667C4CEC3;
	Mon, 14 Oct 2024 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728924593;
	bh=fA9m5ly6ClTa1NQ2ffi9oCuhS3aFmCWo59+WfWtIysw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QnPdVIk3ZkxFn5p5gpnPiN1IdNGb/0qMy48sAty1fJ1aBuQNRAHTmB2kQcHAS2r8L
	 stBkoQ8a4KXtIlW4uePI/37nZG1YERU+zfg2CshZDZNO/EnF7hRuURdZZ6XKelHCB+
	 hxfGXFopPWpcW/a58ynYxLzoDvA6cVFf8Fjy5eYFFnDww254KtxSVrrBhpYJAaDVqB
	 BWS0zn3I6nkSt1ugRfbr+AS42Zu3uqPjqMb0k6XeifsP3bth4woOcZmBFpjroiCzjP
	 ILx6M/rFUyhWA4EiD72lEcV7NLM/qN++tr0T47plIWGlZ7331hepboxPHd897oRTk5
	 EhxvHf1qZDS1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CE858CE0B68; Mon, 14 Oct 2024 09:49:52 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:49:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 05/12] srcu: Standardize srcu_data pointers to "sdp"
 and similar
Message-ID: <25cd96f1-6d4d-4dba-b57b-da63d228ba97@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-5-paulmck@kernel.org>
 <d0ec401f-f857-4fbb-89f3-f2d13eb34b5d@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ec401f-f857-4fbb-89f3-f2d13eb34b5d@amd.com>

On Mon, Oct 14, 2024 at 02:45:50PM +0530, Neeraj Upadhyay wrote:
> On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
> > This commit changes a few "cpuc" variables to "sdp" to align wiht usage
> > elsewhere.
> > 
> 
> s/wiht/with/

Good eyes!

> This commit is doing a lot more than renaming "cpuc".

Indeed, it does look like I forgot to commit between two changes.

It looks like this commit log goes with the changes to the
functions srcu_readers_lock_idx(), srcu_readers_unlock_idx(), and
srcu_readers_active().  With the exception of the change from "NMI-safe"
to "reader flavors in the WARN_ONCE() string in srcu_readers_unlock_idx().

How would you suggest that I split up the non-s/cpuc/sdp/ changes?

							Thanx, Paul

> - Neeraj
> 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  include/linux/srcu.h     | 35 ++++++++++++++++++----------------
> >  include/linux/srcutree.h |  4 ++++
> >  kernel/rcu/srcutree.c    | 41 ++++++++++++++++++++--------------------
> >  3 files changed, 44 insertions(+), 36 deletions(-)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 06728ef6f32a4..84daaa33ea0ab 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -176,10 +176,6 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
> >  
> >  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> >  
> > -#define SRCU_NMI_UNKNOWN	0x0
> > -#define SRCU_NMI_UNSAFE		0x1
> > -#define SRCU_NMI_SAFE		0x2
> > -
> >  #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
> >  void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> >  #else
> > @@ -235,16 +231,19 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
> >   * a mutex that is held elsewhere while calling synchronize_srcu() or
> >   * synchronize_srcu_expedited().
> >   *
> > - * Note that srcu_read_lock() and the matching srcu_read_unlock() must
> > - * occur in the same context, for example, it is illegal to invoke
> > - * srcu_read_unlock() in an irq handler if the matching srcu_read_lock()
> > - * was invoked in process context.
> > + * The return value from srcu_read_lock() must be passed unaltered
> > + * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> > + * the matching srcu_read_unlock() must occur in the same context, for
> > + * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> > + * if the matching srcu_read_lock() was invoked in process context.  Or,
> > + * for that matter to invoke srcu_read_unlock() from one task and the
> > + * matching srcu_read_lock() from another.
> >   */
> >  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
> >  {
> >  	int retval;
> >  
> > -	srcu_check_read_flavor(ssp, false);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
> >  	retval = __srcu_read_lock(ssp);
> >  	srcu_lock_acquire(&ssp->dep_map);
> >  	return retval;
> > @@ -256,12 +255,16 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
> >   *
> >   * Enter an SRCU read-side critical section, but in an NMI-safe manner.
> >   * See srcu_read_lock() for more information.
> > + *
> > + * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
> > + * then none of the other flavors may be used, whether before, during,
> > + * or after.
> >   */
> >  static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
> >  {
> >  	int retval;
> >  
> > -	srcu_check_read_flavor(ssp, true);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
> >  	retval = __srcu_read_lock_nmisafe(ssp);
> >  	rcu_try_lock_acquire(&ssp->dep_map);
> >  	return retval;
> > @@ -273,7 +276,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
> >  {
> >  	int retval;
> >  
> > -	srcu_check_read_flavor(ssp, false);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
> >  	retval = __srcu_read_lock(ssp);
> >  	return retval;
> >  }
> > @@ -302,7 +305,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
> >  static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
> >  {
> >  	WARN_ON_ONCE(in_nmi());
> > -	srcu_check_read_flavor(ssp, false);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
> >  	return __srcu_read_lock(ssp);
> >  }
> >  
> > @@ -317,7 +320,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >  	__releases(ssp)
> >  {
> >  	WARN_ON_ONCE(idx & ~0x1);
> > -	srcu_check_read_flavor(ssp, false);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
> >  	srcu_lock_release(&ssp->dep_map);
> >  	__srcu_read_unlock(ssp, idx);
> >  }
> > @@ -333,7 +336,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
> >  	__releases(ssp)
> >  {
> >  	WARN_ON_ONCE(idx & ~0x1);
> > -	srcu_check_read_flavor(ssp, true);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
> >  	rcu_lock_release(&ssp->dep_map);
> >  	__srcu_read_unlock_nmisafe(ssp, idx);
> >  }
> > @@ -342,7 +345,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
> >  static inline notrace void
> >  srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
> >  {
> > -	srcu_check_read_flavor(ssp, false);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
> >  	__srcu_read_unlock(ssp, idx);
> >  }
> >  
> > @@ -359,7 +362,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
> >  {
> >  	WARN_ON_ONCE(idx & ~0x1);
> >  	WARN_ON_ONCE(in_nmi());
> > -	srcu_check_read_flavor(ssp, false);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
> >  	__srcu_read_unlock(ssp, idx);
> >  }
> >  
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index ab7d8d215b84b..79ad809c7f035 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -43,6 +43,10 @@ struct srcu_data {
> >  	struct srcu_struct *ssp;
> >  };
> >  
> > +/* Values for ->srcu_reader_flavor. */
> > +#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
> > +#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
> > +
> >  /*
> >   * Node in SRCU combining tree, similar in function to rcu_data.
> >   */
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index abe55777c4335..4c51be484b48a 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -438,9 +438,9 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
> >  	unsigned long sum = 0;
> >  
> >  	for_each_possible_cpu(cpu) {
> > -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
> > +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> >  
> > -		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
> > +		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
> >  	}
> >  	return sum;
> >  }
> > @@ -456,14 +456,14 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> >  	unsigned long sum = 0;
> >  
> >  	for_each_possible_cpu(cpu) {
> > -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
> > +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> >  
> > -		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
> > +		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
> >  		if (IS_ENABLED(CONFIG_PROVE_RCU))
> > -			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
> > +			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
> >  	}
> >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
> > -		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
> > +		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
> >  	return sum;
> >  }
> >  
> > @@ -564,12 +564,12 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
> >  	unsigned long sum = 0;
> >  
> >  	for_each_possible_cpu(cpu) {
> > -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
> > +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> >  
> > -		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
> > -		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
> > -		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
> > -		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
> > +		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
> > +		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
> > +		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
> > +		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
> >  	}
> >  	return sum;
> >  }
> > @@ -703,20 +703,21 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
> >   */
> >  void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
> >  {
> > -	int reader_flavor_mask = 1 << read_flavor;
> > -	int old_reader_flavor_mask;
> > +	int old_read_flavor;
> >  	struct srcu_data *sdp;
> >  
> > -	/* NMI-unsafe use in NMI is a bad sign */
> > -	WARN_ON_ONCE(!read_flavor && in_nmi());
> > +	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
> > +	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
> > +	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
> > +
> >  	sdp = raw_cpu_ptr(ssp->sda);
> > -	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
> > -	if (!old_reader_flavor_mask) {
> > -		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
> > -		if (!old_reader_flavor_mask)
> > +	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
> > +	if (!old_read_flavor) {
> > +		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
> > +		if (!old_read_flavor)
> >  			return;
> >  	}
> > -	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
> > +	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
> >  }
> >  EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
> >  #endif /* CONFIG_PROVE_RCU */
> 

