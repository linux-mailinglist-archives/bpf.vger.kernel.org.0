Return-Path: <bpf+bounces-44525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E929C41CD
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF2F1F21DFA
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C2B145FE0;
	Mon, 11 Nov 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc93dQ8C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBE49625;
	Mon, 11 Nov 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338810; cv=none; b=nuTFfUizonHAZQAobQWKGklkx3QtfQ7K+8n68AfUTiij0T0N9e+A4DqrjPC1JUFXW8FsCPlVQdnGKfpU5X0rrglLUCnxvXMAYWV18/5CNvQtB9TcN6W+5U0Z9nY29Q/FRBe/ZkNtrnypB9K2ahkRnxXhaM0sQRhpH37AtmjXr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338810; c=relaxed/simple;
	bh=aRpz3GDck8LbCUy52HRyneKWrKaslIMPNIow1APgFFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfyCqz6xwkJKZLkmZIQb1zTGMlB+hhP/OsiZM/zPzmaDdYKju4+/42IJvXKthI1iarf7OrDTxdaOcd3icdCTUdAEdsvE5OGVT6n5NUb2QSHro+CyecZbJMxdcgowPXG1Xo63h8GnoChKzXcaRthHMKXUA6Eb3AQICU4E5Tt3CNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc93dQ8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049D2C4CECF;
	Mon, 11 Nov 2024 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338810;
	bh=aRpz3GDck8LbCUy52HRyneKWrKaslIMPNIow1APgFFw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Kc93dQ8Cmpqrluh3NGcSGYEPERq7TncA7MjZDKNRscM0LjMtJ2A+R4MXGYWWaeZhZ
	 X/nPDhiL+bG0AAJo5QMBiaX0N5ihimzSwoTqdFQLYMSL/lItr+ppiA0v2ZuaA4EhR2
	 fu+4N6o9oQKAA5f+BdCrtHWaKvEfDuzxoVgmoLe2FtrcRrfPwwHFvogw1+wzTcUvbE
	 XajxdV82ap3yabCHrlVbjFAcixkC2//Vz69p5v7YApLWmRyFeZmr5DGa74eqBr1/HH
	 FsHBsNdboXFCzxEtUmNrWp+7ZaiGZml2ZvE9EMZuzc6DEfLZ+2+jYIWnIWrZutH4Rq
	 yCzaHEFI6RTkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CA28CE00C9; Mon, 11 Nov 2024 07:26:49 -0800 (PST)
Date: Mon, 11 Nov 2024 07:26:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 06/12] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <71a72bcc-ba85-4f86-9d41-cccfd433fa09@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-6-paulmck@kernel.org>
 <e46a4c37-47d3-4a02-a7a5-278d047dd7a2@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46a4c37-47d3-4a02-a7a5-278d047dd7a2@amd.com>

On Mon, Nov 11, 2024 at 06:24:58PM +0530, Neeraj Upadhyay wrote:
> 
> >  
> >  /*
> > - * Returns approximate total of the readers' ->srcu_lock_count[] values
> > - * for the rank of per-CPU counters specified by idx.
> > + * Computes approximate total of the readers' ->srcu_lock_count[] values
> > + * for the rank of per-CPU counters specified by idx, and returns true if
> > + * the caller did the proper barrier (gp), and if the count of the locks
> > + * matches that of the unlocks passed in.
> >   */
> > -static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
> > +static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, unsigned long unlocks)
> >  {
> >  	int cpu;
> > +	unsigned long mask = 0;
> >  	unsigned long sum = 0;
> >  
> >  	for_each_possible_cpu(cpu) {
> >  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> >  
> >  		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
> > +		if (IS_ENABLED(CONFIG_PROVE_RCU))
> > +			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
> >  	}
> > -	return sum;
> > +	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
> > +		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
> 
> I am trying to understand the (unlikely) case where synchronize_srcu() is done before any
> srcu reader lock/unlock lite call is done. Can new SRCU readers fail to observe the
> updates?

If a SRCU reader fail to observe the index flip, then isn't it the case
that the synchronize_rcu() invoked from srcu_readers_active_idx_check()
must wait on it?

> > +	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
> > +		return false;
> 
> So, srcu_readers_active_idx_check() can potentially return false for very long
> time, until the CPU executing srcu_readers_active_idx_check() does
> at least one read lock/unlock lite call?

That is correct.  The theory is that until after an srcu_read_lock_lite()
has executed, there is no need to wait on it.  Does the practice match the
theory in this case, or is there some sequence of events that I missed?

> > +	return sum == unlocks;
> >  }
> >  
> >  /*
> > @@ -473,6 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> >   */
> >  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >  {
> > +	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
> 
> sda->srcu_reader_flavor is only set when CONFIG_PROVE_RCU is enabled. But we
> need the reader flavor information for srcu lite variant to work. So, lite
> variant does not work when CONFIG_PROVE_RCU is disabled. Am I missing something
> obvious here?

At first glance, it appears that I am the one who missed something obvious.
Including in testing, which failed to uncover this issue.

Thank you for the careful reviews!

							Thanx, Paul

> - Neeraj
> 
> >  	unsigned long unlocks;
> >  
> >  	unlocks = srcu_readers_unlock_idx(ssp, idx);
> > @@ -482,13 +492,16 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >  	 * unlock is counted. Needs to be a smp_mb() as the read side may
> >  	 * contain a read from a variable that is written to before the
> >  	 * synchronize_srcu() in the write side. In this case smp_mb()s
> > -	 * A and B act like the store buffering pattern.
> > +	 * A and B (or X and Y) act like the store buffering pattern.
> >  	 *
> > -	 * This smp_mb() also pairs with smp_mb() C to prevent accesses
> > -	 * after the synchronize_srcu() from being executed before the
> > -	 * grace period ends.
> > +	 * This smp_mb() also pairs with smp_mb() C (or, in the case of X,
> > +	 * Z) to prevent accesses after the synchronize_srcu() from being
> > +	 * executed before the grace period ends.
> >  	 */
> > -	smp_mb(); /* A */
> > +	if (!did_gp)
> > +		smp_mb(); /* A */
> > +	else
> > +		synchronize_rcu(); /* X */
> >  
> >  	/*
> >  	 * If the locks are the same as the unlocks, then there must have
> > @@ -546,7 +559,7 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >  	 * which are unlikely to be configured with an address space fully
> >  	 * populated with memory, at least not anytime soon.
> >  	 */
> > -	return srcu_readers_lock_idx(ssp, idx) == unlocks;
> > +	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
> >  }
> >  
> 

