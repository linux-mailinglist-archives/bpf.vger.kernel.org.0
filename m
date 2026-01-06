Return-Path: <bpf+bounces-78002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C1CFA959
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 20:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD823506F4B
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D7149C7B;
	Tue,  6 Jan 2026 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imo6Vi6z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265635772D;
	Tue,  6 Jan 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724212; cv=none; b=BGeZJx7vQM7XI7O3Y/TaoK0Y1YkakMdWKphg09FNLZDPGuAWSBSZ4BWZIlTW6GtxgETjw/6DMelzAFJjb8JgTD/ELRfMDmUGMPGZAHZKeVC1Yo/x2W8mHSpsLwHwuN5fCGE8cQUilRlLgVPwdcDium2gQxv9NM2s/p1ih1gsAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724212; c=relaxed/simple;
	bh=Dz2Ym3tEX0RcebBf6gO93gpP/oqEAI8XAzvZV8Sdss0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBUFXcclzfFkuA7ca1kwlPd0qNU5fqrQKIEqN2FzMw5GYaNd/GYqXx74eEdQAhJOSAxyNouywZltSyPh3YYQyoreM1OFlu33QlsGbe2Z3Wb8vPpik0H3fA3Q/nvQoV1FeVb1BhCaIY/btw7AWCYzxaUD/kU8nvaPmYY6EwDNm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imo6Vi6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08574C116C6;
	Tue,  6 Jan 2026 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767724212;
	bh=Dz2Ym3tEX0RcebBf6gO93gpP/oqEAI8XAzvZV8Sdss0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Imo6Vi6zvqA+DeKky0oisrMVTDWZpotrHxiQo5taDd7u3WudO5R1Q8xTu6t167KS/
	 4jldPkQ461Y72oEHbc4u+pEPX7CgR4Es2XqCtj585d/2bdHAGf/zZTR8zLt4EBVydw
	 eFjV5STlTtWWXTU2kVIMVB+8RY27ExryDqPz1ljZqHi3bkJso71efW5KflAHfXMGnn
	 Qkcn/UabvDc8frhG/aAWMqkd8o6G1GaBgcyXNkELcMb5LO2bhTQYmddz1yrItHj+/e
	 ozdGbJo4Tr/g4J5Vo9J2mZHUGgjDIlbLHbRV7YZY84l9RG01ImjnOqIGdYsqAEGq8I
	 0Aa1bwwqbG2tA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 24DF9CE0B06; Tue,  6 Jan 2026 10:30:11 -0800 (PST)
Date: Tue, 6 Jan 2026 10:30:11 -0800
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
Message-ID: <24a769a9-274c-452f-904f-fa1cc8271183@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>
 <2f8bb8bb-320e-480f-9a56-8eb5cbd4438a@paulmck-laptop>
 <42ec09a2-ba39-4277-94ee-faca1540a4c8@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42ec09a2-ba39-4277-94ee-faca1540a4c8@efficios.com>

On Tue, Jan 06, 2026 at 10:08:44AM -0500, Mathieu Desnoyers wrote:
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
> > 
> > Either way, many thanks for digging into this!!!
> Re-reading the comment and your explanation, I think the comments are
> clear enough. One nit I found while reading though:
> 
> include/linux/srcutree.h:
> 
>  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
>  * critical sections either because they disables interrupts, because
> 
> disables -> disable

Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit b3fc7ac622a19fcf921871be097e3536847406cd
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jan 6 10:28:10 2026 -0800

    srcu: Fix s/they disables/they disable/ typo in srcu_read_unlock_fast()
    
    Typo fix in srcu_read_unlock_fast() header comment.
    
    Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index d6f978b50472d..727719a3cbeb9 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -259,7 +259,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * srcu_read_unlock_fast().
  *
  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
- * critical sections either because they disables interrupts, because
+ * critical sections either because they disable interrupts, because
  * they are a single instruction, or because they are read-modify-write
  * atomic operations, depending on the whims of the architecture.
  * This matters because the SRCU-fast grace-period mechanism uses either

