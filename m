Return-Path: <bpf+bounces-64183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2DB0F804
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65337A8DF3
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399411F0994;
	Wed, 23 Jul 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6YSQOuz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3301C1AAA;
	Wed, 23 Jul 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287858; cv=none; b=JcG2U8QOFuSu8lZ1/T2phZJK1sbQE4T/zrfeWQ9LYg+3tsMdK7LZ40FTETAGR22kxN4U1K7XxfpV54UTdqPFQObzli7qgpfAquNZ1pWDJ+vFXtszxZN3aqq1aiS1zCTcoikI/NoCHIhwWC3lEDSwqWRot2uJY/KsNLpwxnBTNJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287858; c=relaxed/simple;
	bh=/TS71y3VNFWgP6TWRd6SL9uz/jrouP8/vidq2THQ0mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzZ3nrNH9aEM2FTFbXCwwRpiJQz+Whv989XghDxEHtgR3ptA6cQMYBKtvyIK0l/w8NYT4iodFP9JJKFefGPUV129SfmY8FylLPF29Ae0StAfPojTgg0i6GuqKkT2181KbTb2U5/qNn06ExMujGl8aIRfJ1MQttD11qAE9pe+qWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6YSQOuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CA2C4CEE7;
	Wed, 23 Jul 2025 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287858;
	bh=/TS71y3VNFWgP6TWRd6SL9uz/jrouP8/vidq2THQ0mQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A6YSQOuz+xR9SoGL+89T2UDnhJqmKToHcHnIoccQ18LDaEOaGh5nTPDG9nBY4JhxK
	 BBMFLEKEOGcmAgrFO/BVYUCk8ENIRJ6UjTXJk3r078u3a0vadL98fcHyzdQ8MZO0QK
	 qXCFQr3WymV9DE6qzyIuzXzKH9iVn8/JzQGpQvUuYmcNCrcx85+eibZIP8gdkC5HWH
	 pY6cKjZ43DF3OJw5lozDcg9vd+LWUqUFuBIzKCJAbsJb2FRJ6gpo/nGr9Noun53NJv
	 rzK/DF3yfEY4gsqlZmSNhlVn6zHPds/sI2SfjQ7ODNirL7rxq++W6q90jdLPtSOLJ3
	 XwJmMuXujLXiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CC247CE0AD1; Wed, 23 Jul 2025 09:24:17 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:24:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 5/4] srcu: Document __srcu_read_{,un}lock_fast()
 implicit RCU readers
Message-ID: <ee536672-2846-4174-94d4-3f42ba341324@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ce304859-e258-45e7-b40f-b5cacc968eaf@paulmck-laptop>
 <9FAE52D6-D073-43D9-93D3-3E49006943B2@nvidia.com>
 <fa4fd174-065d-4a04-b080-ffe04d31313f@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa4fd174-065d-4a04-b080-ffe04d31313f@nvidia.com>

On Wed, Jul 23, 2025 at 12:10:46PM -0400, Joel Fernandes wrote:
> 
> 
> On 7/23/2025 9:32 AM, joelagnelf@nvidia.com wrote:
> > 
> > 
> >> On Jul 22, 2025, at 6:17 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>
> >> ﻿This commit documents the implicit RCU readers that are implied by the
> >> this_cpu_inc() and atomic_long_inc() operations in __srcu_read_lock_fast()
> >> and __srcu_read_unlock_fast().  While in the area, fix the documentation
> >> of the memory pairing of atomic_long_inc() in __srcu_read_lock_fast().
> > 
> > Just to clarify, the implication here is since SRCU-fast uses synchronize_rcu on the update side, these operations result in blocking of classical RCU too. So simply using srcu fast is another way of achieving the previously used pre-empt-disabling in the use cases.
> 
> Hi Paul, it was nice sync'ing with you off-list. Following are my suggestions
> and where I am coming from:
> 
> 1. For someone who doesn't know SRCU-fast depends on synchronize_rcu (me after a
> few beers :P), the word 'RCU' in the comment you added to this patch, might come
> across as 'which RCU are we referring to - SRCU or classical RCU or some other'.
> So I would call it 'classical RCU reader' in the comment.
> 
> 2. It would be good to call out specifically that, the SRCU-fast critical
> section is akin to a classical RCU reader, because of its implementation's
> dependence on synchronize_rcu() to overcome the lack of read-side memory barriers.
> 
> 3. I think since the potential size of these code comment suggestions, it may
> make sense to provide a bigger comment suggesting these than providing them
> inline as you did. And also calling out the tracing usecase in the comments for
> additional usecase clarification.
> 
> I could provide a patch to do all this soon, as we discussed, as well (unless
> you're Ok with making this change as well).

Thank you very much for the clarification, and I will make the changes
with attribution.

							Thanx, Paul

> Thanks!
> 
>  - Joel
> 
> 
> 
> 
> > 
> > Or is the rationale for this something else?
> > 
> > I would probably spell this out more in a longer comment above the if/else, than modify the inline comments.
> > 
> > But I am probably misunderstood the whole thing. :-(
> > 
> > -Joel
> > 
> >>
> >> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> Cc: <bpf@vger.kernel.org>
> >>
> >> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> >> index 043b5a67ef71e..78e1a7b845ba9 100644
> >> --- a/include/linux/srcutree.h
> >> +++ b/include/linux/srcutree.h
> >> @@ -245,9 +245,9 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
> >>    struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> >>
> >>    if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> >> -        this_cpu_inc(scp->srcu_locks.counter); /* Y */
> >> +        this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
> >>    else
> >> -        atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  /* Z */
> >> +        atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
> >>    barrier(); /* Avoid leaking the critical section. */
> >>    return scp;
> >> }
> >> @@ -271,9 +271,9 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
> >> {
> >>    barrier();  /* Avoid leaking the critical section. */
> >>    if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> >> -        this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
> >> +        this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
> >>    else
> >> -        atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
> >> +        atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
> >> }
> >>
> >> void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> >>
> 

