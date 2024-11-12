Return-Path: <bpf+bounces-44559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B589C4BB1
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993C31F236B7
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF25520494B;
	Tue, 12 Nov 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMwblpTM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D7204921;
	Tue, 12 Nov 2024 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374925; cv=none; b=ZyLmLLkc+1u4pPr+m4+K6m/2gj7969YuGoAlh2hNGTQ8Sh4vcxpFrbYfTzk/975llafFgssdpTT+2Lg+4zOgtMjlnQDAbHqNFf+0DFbOosQuVbghBtg7XbxggE17bVM5ex7Ti2ALj29LbXVPPAzWidNet/b1QVZdkOirsJUYUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374925; c=relaxed/simple;
	bh=1ESE2VPKTU3JRaOnmP+kg3oYTLo3tW6IyA6ZD5e5zkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftHEv4ljnNI4nsFY2oWbhugRsi6aSrx9XgvS5TGnGHAYSb63JkwbFAG4V8OtVgN6xXAA/mX5O/bZrzuPnseZr9pZoz3jPHDz8m6Q3rV/RMRXbbfNMlGiwbShti2idAUjAmHPWt7qSq0pH07E12xJpphSPnj4GgKXBxmGL+06gDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMwblpTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE9DC4CECF;
	Tue, 12 Nov 2024 01:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731374924;
	bh=1ESE2VPKTU3JRaOnmP+kg3oYTLo3tW6IyA6ZD5e5zkY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EMwblpTMywyOAmQx+gEq4VIAgtOo1sO6ctCD/gLfKTNtWdd7MiURwNWm8DgE/Epq6
	 t2Lqgaa7zGlvEGSGit7DSRHisR1UFqyVstjnDhFIvvVUXZB/XN0pquQmYIum4pJhrz
	 u5L+QZlLskTmm76ZHvp7ntFaQ4k7im9FLn+579wcK5mApymZHVHbySNmkqwe5JGNV4
	 LIDjb4qs7LlFt65xwDSAJWiziPw8IcAhTKGEQMdhTiJxs2ASCGha1rMtYcKXRaokYG
	 G2NDl1z/JFkL6cMenrTJ5+ToQcOghmCN886rFR+BMOjD43BqqimZUMBtqHoJiNe383
	 iMZ3qobwEE9Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 70619CE0BA3; Mon, 11 Nov 2024 17:28:44 -0800 (PST)
Date: Mon, 11 Nov 2024 17:28:44 -0800
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
Message-ID: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-6-paulmck@kernel.org>
 <e46a4c37-47d3-4a02-a7a5-278d047dd7a2@amd.com>
 <71a72bcc-ba85-4f86-9d41-cccfd433fa09@paulmck-laptop>
 <c15d4a80-2f27-4588-af87-9cf7cf3ad79e@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c15d4a80-2f27-4588-af87-9cf7cf3ad79e@amd.com>

On Mon, Nov 11, 2024 at 10:21:58PM +0530, Neeraj Upadhyay wrote:
> On 11/11/2024 8:56 PM, Paul E. McKenney wrote:
> > On Mon, Nov 11, 2024 at 06:24:58PM +0530, Neeraj Upadhyay wrote:
> >>>  /*
> >>> - * Returns approximate total of the readers' ->srcu_lock_count[] values
> >>> - * for the rank of per-CPU counters specified by idx.
> >>> + * Computes approximate total of the readers' ->srcu_lock_count[] values
> >>> + * for the rank of per-CPU counters specified by idx, and returns true if
> >>> + * the caller did the proper barrier (gp), and if the count of the locks
> >>> + * matches that of the unlocks passed in.
> >>>   */
> >>> -static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
> >>> +static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, unsigned long unlocks)
> >>>  {
> >>>  	int cpu;
> >>> +	unsigned long mask = 0;
> >>>  	unsigned long sum = 0;
> >>>  
> >>>  	for_each_possible_cpu(cpu) {
> >>>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> >>>  
> >>>  		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
> >>> +		if (IS_ENABLED(CONFIG_PROVE_RCU))
> >>> +			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
> >>>  	}
> >>> -	return sum;
> >>> +	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
> >>> +		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
> >>
> >> I am trying to understand the (unlikely) case where synchronize_srcu() is done before any
> >> srcu reader lock/unlock lite call is done. Can new SRCU readers fail to observe the
> >> updates?
> > 
> > If a SRCU reader fail to observe the index flip, then isn't it the case
> > that the synchronize_rcu() invoked from srcu_readers_active_idx_check()
> > must wait on it?
> 
> Below is the sequence of operations I was thinking of, where at step 4 CPU2
> reads old pointer
> 
> ptr = old
> 
> 
> CPU1                                         CPU2
> 
> 1. Update ptr = new
> 
> 2. synchronize_srcu()
> 
> <Does not use synchronize_rcu()
>  as SRCU_READ_FLAVOR_LITE is not
>  set for any sdp as srcu_read_lock_lite()
>  hasn't been called by any CPU>
> 
>                                       3. srcu_read_lock_lite()
>                                         <No smp_mb() ordering>
> 
>                                       4.  Can read ptr == old ?

As long as the kernel was built with CONFIG_PROVE_RCU=y and given a fix
to the wrong-CPU issue you quite rightly point out below, no it cannot.
The CPU's first call to srcu_read_lock_lite() will use cmpxchg() to update
->srcu_reader_flavor, which will place full ordering between that update
and the later read from "ptr".

So if the synchronize_srcu() is too early to see the SRCU_READ_FLAVOR_LITE
bit, then the reader must see the new value of "ptr".  Similarly,
if the reader can see the old value of "ptr", then synchronize_srcu()
must see the reader's setting of the SRCU_READ_FLAVOR_LITE bit.

But both the CONFIG_PROVE_RCU=n and the wrong-CPU issue must be fixed
for this to work.  Please see the upcoming patches to be posted as a
reply to this email.

> >>> +	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
> >>> +		return false;
> >>
> >> So, srcu_readers_active_idx_check() can potentially return false for very long
> >> time, until the CPU executing srcu_readers_active_idx_check() does
> >> at least one read lock/unlock lite call?
> > 
> > That is correct.  The theory is that until after an srcu_read_lock_lite()
> > has executed, there is no need to wait on it.  Does the practice match the
> > theory in this case, or is there some sequence of events that I missed?
> 
> Below sequence
> 
> CPU1                     CPU2     
>                        1. srcu_read_lock_lite()
>                        
>                        
>                        2. srcu_read_unlock_lite()
> 
> 3. synchronize_srcu()
> 
> 3.1 srcu_readers_lock_idx() is
> called with gp = false as
> srcu_read_lock_lite() was never
> called on this CPU for this
> srcu_struct. So
> ssp->sda->srcu_reader_flavor is not
> set for CPU1's sda.

Good eyes!  Yes, the scan that sums the ->srcu_unlock_count[] counters
must also OR together the ->srcu_reader_flavor fields.

> 3.2 Inside srcu_readers_lock_idx()
> "mask" contains SRCU_READ_FLAVOR_LITE
> as CPU2's sdp->srcu_reader_flavor has it.
> 
> 3.3 CPU1 keeps returning false from
> below check until CPU1 does at least
> one srcu_read_lock_lite() call or
> the thread migrates.
> 
> if (mask & SRCU_READ_FLAVOR_LITE && !gp)
>   return false;

This is also fixed by the OR of the ->srcu_reader_flavor fields, correct?

I guess I could claim that this bug prevents the wrong-CPU bug above
from resulting in a too-short SRCU grace period, but it is of course
better to just fix the bugs.  ;-)

> >>> +	return sum == unlocks;
> >>>  }
> >>>  
> >>>  /*
> >>> @@ -473,6 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> >>>   */
> >>>  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >>>  {
> >>> +	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
> >>
> >> sda->srcu_reader_flavor is only set when CONFIG_PROVE_RCU is enabled. But we
> >> need the reader flavor information for srcu lite variant to work. So, lite
> >> variant does not work when CONFIG_PROVE_RCU is disabled. Am I missing something
> >> obvious here?
> > 
> > At first glance, it appears that I am the one who missed something obvious.
> > Including in testing, which failed to uncover this issue.
> > 
> > Thank you for the careful reviews!
> 
> Sure thing, no problem!

And again, thank you!

							Thanx, Paul

> >>>  	unsigned long unlocks;
> >>>  
> >>>  	unlocks = srcu_readers_unlock_idx(ssp, idx);
> >>> @@ -482,13 +492,16 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >>>  	 * unlock is counted. Needs to be a smp_mb() as the read side may
> >>>  	 * contain a read from a variable that is written to before the
> >>>  	 * synchronize_srcu() in the write side. In this case smp_mb()s
> >>> -	 * A and B act like the store buffering pattern.
> >>> +	 * A and B (or X and Y) act like the store buffering pattern.
> >>>  	 *
> >>> -	 * This smp_mb() also pairs with smp_mb() C to prevent accesses
> >>> -	 * after the synchronize_srcu() from being executed before the
> >>> -	 * grace period ends.
> >>> +	 * This smp_mb() also pairs with smp_mb() C (or, in the case of X,
> >>> +	 * Z) to prevent accesses after the synchronize_srcu() from being
> >>> +	 * executed before the grace period ends.
> >>>  	 */
> >>> -	smp_mb(); /* A */
> >>> +	if (!did_gp)
> >>> +		smp_mb(); /* A */
> >>> +	else
> >>> +		synchronize_rcu(); /* X */
> >>>  
> >>>  	/*
> >>>  	 * If the locks are the same as the unlocks, then there must have
> >>> @@ -546,7 +559,7 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >>>  	 * which are unlikely to be configured with an address space fully
> >>>  	 * populated with memory, at least not anytime soon.
> >>>  	 */
> >>> -	return srcu_readers_lock_idx(ssp, idx) == unlocks;
> >>> +	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
> >>>  }
> >>>  
> >>

