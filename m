Return-Path: <bpf+bounces-78026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF8CFB971
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 02:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8994D3041F70
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118501EB9F2;
	Wed,  7 Jan 2026 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="c86vtffC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F791ADC7E
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749225; cv=none; b=ZVBBXWADPq92ugz6ds/pWdUblIATLdl/L+V7/sHhOW6fCrtuVgBXzmvzFAgDO6nviIOvJvWRFsNP3/f8XP2r/QBXJGZ7JnLw2jspLGEkDxDFCWSzqjg8leQkZGkZisoWWrOliDCyopGuxYvJTIw8e8PGzfIGZJAUk4mmeM1IbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749225; c=relaxed/simple;
	bh=6qXjRweWr5OFMI1uMaCKHIO4u+FEgaxRzVd236c9p1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdr5XyQNpkpBN1NlaoLl2Y2CUQM2Qer7LbUWrUqd+2TpoVjnpZ8gcfXr/j7mw8RlwqahfJ88VRKO+fgh6R0vc+N8Kn7UFmzfsC73dXw2gDmGri/rbRtjd6gvd5U2UgcThFf+OSuO3PzeAefls0U5yVeT2/VJ//wuwmPMVC2bFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=c86vtffC; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-11f3e3f0cacso1231029c88.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 17:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767749222; x=1768354022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GeAh2oKmLRqPafqLvM6s5CboOQWCOtACKHcMjuL8GSI=;
        b=c86vtffCHLHXwIrywDsalGXIjQ1WcXBhMKsHf+GGVrlkaR6rQ9ahnCDIFWswYq+FD4
         6REYdbMgUkXHIRbWAuDTS/f5nR5fZXA9IUNUI5/SwNa1QRJ6SpktRbte5YkLTFUx1qKV
         ufqDAX0Oa8ZonUtIZCD6WU7ndr5Y2x2S2Y6r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749222; x=1768354022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeAh2oKmLRqPafqLvM6s5CboOQWCOtACKHcMjuL8GSI=;
        b=tfBVs1QIxEsdoZh9GXkNwiqoTLpSvG/nrp2ToypCK4118j+A/ku5RhSNXJfjSLAncx
         9RdpMB1JEMrgIGYW4vpycCzYaw+tzAfDzK8IW7pZ6EkICJ3GzTY7Py0b2Rtmjo63kRgU
         msZz1bM+k9k5ll6GXjaMO6FOEqf0s4JitGwEp/ZK0zHHFGN4YyKAABscuAZ2HI0xwwJx
         mhNDn9AIBJq148BWX8CSxRBxyiV9rvWL29MRabd2XquA1j7GGkkWABi2tDRcnC+AYwpv
         JC5N6D221VZ47E3nFP4SgduQrE0smY4nAZODi/ZQYBrlNw8FPZ35Fz8KXYIxIfqUSAds
         4/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgcAuE6B3EwC5+jCrL2buNanD8YRJJGibA6HgrtCCdrAtt1RjigZLohZDYHdVNIYFoDso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFINPFXKu6HAZ/wgYWnaoG/kzvS77FCiCH5CXhCdZPPcPUl5w
	j+prESn7SYH/1KPJNZf+GAIYYBLoLhobbrDTw+WUwSsFI3OmeNKnPwLXKSm18igoMX8=
X-Gm-Gg: AY/fxX6v/Hex/PodX67l1IrNE9aLrUnC7IU+QxDuMTjAptLlqUoF4PsRShmVbJy44tz
	TL5GwEHsURiYYrHU5Ieb4koH2/4JxmY5BViy4ETOch+Njxbd5CzEqqE2n3Yl5if8A0yzcdfMsfX
	05BFmLJCv5PhKmmtmmJIFlVQ/9i07DbA5PkHa4L9nx43aiuHAbukywuxJghePp1T6KjKaov1Ltc
	FzdiPjaj4fDeVuW4qgRQsNgzl9jG7Py3Q3ogUoKyyfKGsWT07yHb4EvQUrFTXaRDUbjYnpTXee0
	B6ZOfUtd2VrAqRXWveJqaTNO0uxbi0hHZVZJr2gVeO+cfT+aSpsCl4Zesf2tPmEXTdtqkFj8wDN
	qHm7dHGvSuEZJfcmRBJbSlAvpK/EMcTvbtvSFEnO67XfsbxVzW+dsqHMDrYZiCgVF9A/cFpgawh
	HFnI/4Sqkc
X-Google-Smtp-Source: AGHT+IHZQx7+l7Sc5UZXM50GfCbv4DjIAmwjloCxQW/7xarVJPvutxwydUwZqJ/IhGEhunEvC26rIw==
X-Received: by 2002:a05:7022:2385:b0:11b:c2fd:3960 with SMTP id a92af1059eb24-121f8b46199mr642850c88.28.1767749221848;
        Tue, 06 Jan 2026 17:27:01 -0800 (PST)
Received: from localhost ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm6792347c88.9.2026.01.06.17.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:27:01 -0800 (PST)
Date: Tue, 6 Jan 2026 20:26:59 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <20260107012659.GA3677916@joelbox2>
References: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>
 <2f8bb8bb-320e-480f-9a56-8eb5cbd4438a@paulmck-laptop>
 <5dc49f5a-ddda-422b-a8af-c662ee53d503@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dc49f5a-ddda-422b-a8af-c662ee53d503@efficios.com>

On Thu, Jul 17, 2025 at 03:36:46PM -0400, Mathieu Desnoyers wrote:
> On 2025-07-17 11:18, Paul E. McKenney wrote:
> > On Thu, Jul 17, 2025 at 10:46:46AM -0400, Mathieu Desnoyers wrote:
> > > On 2025-07-17 09:14, Mathieu Desnoyers wrote:
> > > > On 2025-07-16 18:54, Paul E. McKenney wrote:
> > > [...]
> > > > 
> > > > 2) I think I'm late to the party in reviewing srcu-fast, I'll
> > > >      go have a look :)
> > > 
> > > OK, I'll bite. :) Please let me know where I'm missing something:
> > > 
> > > Looking at srcu-lite and srcu-fast, I understand that they fundamentally
> > > depend on a trick we published here https://lwn.net/Articles/573497/
> > > "The RCU-barrier menagerie" that allows turning, e.g. this Dekker:
> > > 
> > > volatile int x = 0, y = 0
> > > 
> > > CPU 0              CPU 1
> > > 
> > > x = 1              y = 1
> > > smp_mb             smp_mb
> > > r2 = y             r4 = x
> > > 
> > > BUG_ON(r2 == 0 && r4 == 0)
> > > 
> > > into
> > > 
> > > volatile int x = 0, y = 0
> > > 
> > > CPU 0            CPU 1
> > > 
> > > rcu_read_lock()
> > > x = 1              y = 1
> > >                     synchronize_rcu()
> > > r2 = y             r4 = x
> > > rcu_read_unlock()
> > > 
> > > BUG_ON(r2 == 0 && r4 == 0)
> > > 
> > > So looking at srcu-fast, we have:
> > > 
> > >   * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
> > >   * critical sections either because they disables interrupts, because they
> > >   * are a single instruction, or because they are a read-modify-write atomic
> > >   * operation, depending on the whims of the architecture.
> > > 
> > > It appears to be pairing, as RCU read-side:
> > > 
> > > - irq off/on implied by this_cpu_inc
> > > - atomic
> > > - single instruction
> > > 
> > > with synchronize_rcu within the grace period, and hope that this behaves as a
> > > smp_mb pairing preventing the srcu read-side critical section from leaking
> > > out of the srcu read lock/unlock.
> > > 
> > > I note that there is a validation that rcu_is_watching() within
> > > __srcu_read_lock_fast, but it's one thing to have rcu watching, but
> > > another to have an actual read-side critical section. Note that
> > > preemption, irqs, softirqs can very well be enabled when calling
> > > __srcu_read_lock_fast.
> > > 
> > > My understanding of the how memory barriers implemented with RCU
> > > work is that we need to surround the memory accesses on the fast-path
> > > (where we turn smp_mb into barrier) with an RCU read-side critical
> > > section to make sure it does not spawn across a synchronize_rcu.
> > > 
> > > What I am missing here is how can a RCU side-side that only consist
> > > of the irq off/on or atomic or single instruction cover all memory
> > > accesses we are trying to order, namely those within the srcu
> > > critical section after the compiler barrier() ? Is having RCU
> > > watching sufficient to guarantee this ?
> > 
> > Good eyes!!!
> > 
> > The trick is that this "RCU read-side critical section" consists only of
> > either this_cpu_inc() or atomic_long_inc(), with the latter only happening
> > in systems that have NMIs, but don't have NMI-safe per-CPU operations.
> > Neither this_cpu_inc() nor atomic_long_inc() can be interrupted, and
> > thus both act as an interrupts-disabled RCU read-side critical section.
> > 
> > Therefore, if the SRCU grace-period computation fails to see an
> > srcu_read_lock_fast() increment, its earlier code is guaranteed to
> > happen before the corresponding critical section.  Similarly, if the SRCU
> > grace-period computation sees an srcu_read_unlock_fast(), its subsequent
> > code is guaranteed to happen after the corresponding critical section.
> > 
> > Does that help?  If so, would you be interested and nominating a comment?
> > 
> > Or am I missing something subtle here?
> 
> Here is the root of my concern: considering a single instruction
> as an RCU-barrier "read-side" for a classic Dekker would not work,
> because the read-side would not cover both memory accesses that need
> to be ordered.

I had similar questions, so let me share, assuming I even got your question
correct. I think what might help is to note that for synchronize_rcu(), any
transition to and from RCU watching is a full memory barrier. And if I
understand correctly, because SRCU fast is not allowed when RCU is not
watching, the memory ordering Required for RCU correctness is automatically
taken care of because the update side uses synchronize_rcu(). 

That is my understanding. Could you clarify how your question is related to the
single instruction thing? I think if you apply the
classical RCU reasoning where RCU (regular RCU) read-side critical sections
do not have any memory barriers, then you will see the similarity of that
with srcu-fast.

thanks,

 - Joel

> 
> I cannot help but notice the similarity between this pattern of
> barrier vs synchronize_rcu and what we allow userspace to do with
> barrier vs sys_membarrier, which has one implementation
> based on synchronize_rcu (except for TICK_NOHZ_FULL). Originally
> when membarrier was introduced, this was based on synchronize_sched(),
> and I recall that this was OK because userspace execution acted as
> a read-side critical section from the perspective of synchronize_sched().
> As commented in kernel v4.10 near synchronize_sched():
> 
>  * Note that this guarantee implies further memory-ordering guarantees.
>  * On systems with more than one CPU, when synchronize_sched() returns,
>  * each CPU is guaranteed to have executed a full memory barrier since the
>  * end of its last RCU-sched read-side critical section whose beginning
>  * preceded the call to synchronize_sched().  In addition, each CPU having
>  * an RCU read-side critical section that extends beyond the return from
>  * synchronize_sched() is guaranteed to have executed a full memory barrier
>  * after the beginning of synchronize_sched() and before the beginning of
>  * that RCU read-side critical section.  Note that these guarantees include
>  * CPUs that are offline, idle, or executing in user mode, as well as CPUs
>  * that are executing in the kernel.
> 
> So even though I see how synchronize_rcu() nowadays is still a good
> choice to implement sys_membarrier, it only apply to RCU read side
> critical sections, which covers userspace code and the specific
> read-side critical sections in the kernel.
> 
> But what I don't get is how synchronize_rcu() can help us promote
> the barrier() in SRCU-fast to smp_mb when outside of any RCU read-side
> critical section tracked by the synchronize_rcu grace period,
> mainly because unlike the sys_membarrier scenario, this is *not*
> userspace code.
> 
> And what we want to order here on the read-side is the lock/unlock
> increments vs the memory accesses within the critical section, but
> there is no RCU read-side that contain all those memory accesses
> that match those synchronize_rcu calls, so the promotion from barrier
> to smp_mb don't appear to be valid.
> 
> But perhaps there is something more that is specific to the SRCU
> algorithm that I missing here ?
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Either way, many thanks for digging into this!!!
> > 
> > 							Thanx, Paul
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > -- 
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

