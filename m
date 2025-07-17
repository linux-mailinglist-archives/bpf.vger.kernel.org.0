Return-Path: <bpf+bounces-63614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED33B09065
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4960217430F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D91E8322;
	Thu, 17 Jul 2025 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Mjz8N8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF027E107;
	Thu, 17 Jul 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765505; cv=none; b=HaORC/ozX+KDR3KrdPwjmV6LmvMmFxLhwo6Hz0EH5BJ16BWyywmFzB6Rjvnk61x2J2iv3F8YcVcElUha27L57d4JZFBPohFTBRm/kCsuU+h86rH+G+bWuKaVZyqhwJC+dX9g6y8iWYcuCl78Tlq3LQgghWEFJrBt9iZVsDhaB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765505; c=relaxed/simple;
	bh=tRboDQsJ5JM93kjNC6bgN2KgDzfrJvfH+DqeB39GWcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOq8EqMMbUzPVxGLR4/MRA1RUkiikjjhrG2wy3WKABJriBbHvso0CubQgEDLFWo5mswTamWzabRFnaVZ64pUnvzbY3Junna0lNy/MgBpH283ITK67maNOXTUgEOHC5gLMsseQOiXaQES5OdtaWJ2KW5sdag4kSmddj0G5B7qEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/Mjz8N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D877C4CEE3;
	Thu, 17 Jul 2025 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752765505;
	bh=tRboDQsJ5JM93kjNC6bgN2KgDzfrJvfH+DqeB39GWcI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=B/Mjz8N8398vnpqxR1Zs2h91k/JdpgSMflzaLDrK44MpO6jG5Dp/apCe8rqC2FY2S
	 a958rFhmovVeQaJFTN7pE5Oe26SQzXG+5iGo3PD2XiHD7KsMF+l8jNJmgIiflSgdLS
	 zhBw5WqCWA1aGOLGNog9eLK0AAO4Cr0c1VD9SyajTJO2WzmPzcBNivMIS37YMYiovu
	 KDaK8n4Y9aOzIu6KZwSZaHxE7dcs2TNE50ijGsp4ulrnlJyaKDxvXKApBgI99anAo3
	 awynQ17OrP+iE/y4H/zzjmZuaBpwQTCcRXx+Fh3puMCt//92afakaEi4NXpBCcdnfO
	 W6LbgWVvhQSXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA9F7CE09F5; Thu, 17 Jul 2025 08:18:24 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:18:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <2f8bb8bb-320e-480f-9a56-8eb5cbd4438a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>

On Thu, Jul 17, 2025 at 10:46:46AM -0400, Mathieu Desnoyers wrote:
> On 2025-07-17 09:14, Mathieu Desnoyers wrote:
> > On 2025-07-16 18:54, Paul E. McKenney wrote:
> [...]
> > 
> > 2) I think I'm late to the party in reviewing srcu-fast, I'll
> >     go have a look :)
> 
> OK, I'll bite. :) Please let me know where I'm missing something:
> 
> Looking at srcu-lite and srcu-fast, I understand that they fundamentally
> depend on a trick we published here https://lwn.net/Articles/573497/
> "The RCU-barrier menagerie" that allows turning, e.g. this Dekker:
> 
> volatile int x = 0, y = 0
> 
> CPU 0              CPU 1
> 
> x = 1              y = 1
> smp_mb             smp_mb
> r2 = y             r4 = x
> 
> BUG_ON(r2 == 0 && r4 == 0)
> 
> into
> 
> volatile int x = 0, y = 0
> 
> CPU 0            CPU 1
> 
> rcu_read_lock()
> x = 1              y = 1
>                    synchronize_rcu()
> r2 = y             r4 = x
> rcu_read_unlock()
> 
> BUG_ON(r2 == 0 && r4 == 0)
> 
> So looking at srcu-fast, we have:
> 
>  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
>  * critical sections either because they disables interrupts, because they
>  * are a single instruction, or because they are a read-modify-write atomic
>  * operation, depending on the whims of the architecture.
> 
> It appears to be pairing, as RCU read-side:
> 
> - irq off/on implied by this_cpu_inc
> - atomic
> - single instruction
> 
> with synchronize_rcu within the grace period, and hope that this behaves as a
> smp_mb pairing preventing the srcu read-side critical section from leaking
> out of the srcu read lock/unlock.
> 
> I note that there is a validation that rcu_is_watching() within
> __srcu_read_lock_fast, but it's one thing to have rcu watching, but
> another to have an actual read-side critical section. Note that
> preemption, irqs, softirqs can very well be enabled when calling
> __srcu_read_lock_fast.
> 
> My understanding of the how memory barriers implemented with RCU
> work is that we need to surround the memory accesses on the fast-path
> (where we turn smp_mb into barrier) with an RCU read-side critical
> section to make sure it does not spawn across a synchronize_rcu.
> 
> What I am missing here is how can a RCU side-side that only consist
> of the irq off/on or atomic or single instruction cover all memory
> accesses we are trying to order, namely those within the srcu
> critical section after the compiler barrier() ? Is having RCU
> watching sufficient to guarantee this ?

Good eyes!!!

The trick is that this "RCU read-side critical section" consists only of
either this_cpu_inc() or atomic_long_inc(), with the latter only happening
in systems that have NMIs, but don't have NMI-safe per-CPU operations.
Neither this_cpu_inc() nor atomic_long_inc() can be interrupted, and
thus both act as an interrupts-disabled RCU read-side critical section.

Therefore, if the SRCU grace-period computation fails to see an
srcu_read_lock_fast() increment, its earlier code is guaranteed to
happen before the corresponding critical section.  Similarly, if the SRCU
grace-period computation sees an srcu_read_unlock_fast(), its subsequent
code is guaranteed to happen after the corresponding critical section.

Does that help?  If so, would you be interested and nominating a comment?

Or am I missing something subtle here?

Either way, many thanks for digging into this!!!

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

