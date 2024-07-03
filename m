Return-Path: <bpf+bounces-33773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CEB9262FB
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6471C203F3
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FD1849D7;
	Wed,  3 Jul 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/ZaJTbm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A7184101;
	Wed,  3 Jul 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015702; cv=none; b=AXipp6iH+zMY2frcu8TDf+sOvjt0FYHxjW/KlHIIXGuzioC7SNbvBIKIJyuUSI7hcxYUcpNPqqI8prLEA7bkNwdKX6I1acRmyoEl/Q7LZ4UiNMgIMx+3l7tEtW5jsD+L6LhFKedhhDdtfM0Ld2R0Uc+6/bqyABdoDB+1nMvMhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015702; c=relaxed/simple;
	bh=ML2AEriOnHqO1QXh0j87+85SYqypaQr6iAt1xf7pymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCSjpPAKfjMYH6b2NmfoGpnQRdSrQE/fZPMV5hN7b1aGp5hGRH7x9fFaB88gXninCZwXa0iAt4NHFKh4YpS5FDjUMvfmMEbh+SMKCFDkElPAXfC/ulmXDF5mqW9hCzg8A+XEy6Nozxm8E4vFVhO05e1ubyGePrfo2zOR4cwXSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/ZaJTbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0017CC4AF19;
	Wed,  3 Jul 2024 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720015702;
	bh=ML2AEriOnHqO1QXh0j87+85SYqypaQr6iAt1xf7pymA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j/ZaJTbm+XyN1fiRowPjnCzjA8P+hve726cRrUseYOEkgBjpelsI5ibpyPttVZ3OW
	 HpwMEWhCGSiwXbCvEt0HLD9C4BbKd7NEv7ZRBxI6tgTE9U0MYM5sdEjLbY60WoBFiK
	 2jAE4eGWYIiACmVjNg+ChMF5uHKQgNnSHuZ9uj4MdGyFtKwsy8bblIan0RD0c6FW4f
	 LvuptEzgd4pQG2+jq4VTCG3shuKFMoSvoHf+yLVMBJNzxyiysNzLHSKJflJWvEBHuN
	 SEDU8uRP8JxJuWHwS84dpBxkHQP/Guwe2IOXjTdl2JYSt8MbghBSsxIxm/k2teMl8x
	 SB5MUAOFRTdWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 93CF5CE0BC3; Wed,  3 Jul 2024 07:08:21 -0700 (PDT)
Date: Wed, 3 Jul 2024 07:08:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <6b728325-b628-488f-aabf-dbd9afa388fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
 <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
 <20240703075057.GK11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703075057.GK11386@noisy.programming.kicks-ass.net>

On Wed, Jul 03, 2024 at 09:50:57AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 02, 2024 at 04:56:53PM -0700, Paul E. McKenney wrote:
> 
> > > Paul, isn't this the RCU flavour you created to deal with
> > > !rcu_is_watching()? The flavour that never should have been created in
> > > favour of just cleaning up the mess instead of making more.
> > 
> > My guess is that you are instead thinking of RCU Tasks Rude, which can
> > be eliminated once all architectures get their entry/exit/deep-idle
> > functions either inlined or marked noinstr.
> 
> Would it make sense to disable it for those architectures that have
> already done this work?

It might well.  Any architectures other than x86 at this point?

But this is still used in common code, so let's see...  In that case,
synchronize_rcu_tasks_rude() becomes a no-op, call_rcu_tasks_rude() can be
a wrapper around something like queue_work(), and rcu_barrier_tasks_rude()
can be a wrapper around something like flush_work().

Except that call_rcu_tasks_rude() and rcu_barrier_tasks_rude() are not
actually used outside of testing, so maybe they can be dropped globally.

Let me see what happens when I do this:

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7d18b90356fd..5c8492a054f5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -936,8 +936,8 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.deferred_free	= rcu_tasks_rude_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_rude,
 	.exp_sync	= synchronize_rcu_tasks_rude,
-	.call		= call_rcu_tasks_rude,
-	.cb_barrier	= rcu_barrier_tasks_rude,
+	// .call		= call_rcu_tasks_rude,
+	// .cb_barrier	= rcu_barrier_tasks_rude,
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.get_gp_data	= rcu_tasks_rude_get_gp_data,
 	.cbflood_max	= 50000,

It should be at least mildly amusing...

> > > > I will
> > > > ultimately use it anyway to avoid uprobe taking unnecessary refcount
> > > > and to protect uprobe->consumers iteration and uc->handler() calls,
> > > > which could be sleepable, so would need rcu_read_lock_trace().
> > > 
> > > I don't think you need trace-rcu for that. SRCU would do nicely I think.
> > 
> > From a functional viewpoint, agreed.
> > 
> > However, in the past, the memory-barrier and array-indexing overhead
> > of SRCU has made it a no-go for lightweight probes into fastpath code.
> > And these cases were what motivated RCU Tasks Trace (as opposed to RCU
> > Tasks Rude).
> 
> I'm thinking we're growing too many RCU flavours again :/ I suppose I'll
> have to go read up on rcu/tasks.* and see what's what.

Well, you are in luck.  I am well along with the task of putting together
the 2024 LWN RCU API article, which will include RCU Tasks Trace.  ;-)

And I do sympathize with discomfort with lots of RCU flavors.  After all,
hhad you told me 30 years ago that there would be more than one flavor,
I would have been quite surprised.  Of course, I would also have been
surprised by a great many other things (just how many flavors of locking
and reference counting???), so maybe having three flavors (four if we
cannot drop RCU Tasks RUDE) is not so bad.

Oh, and no one is yet using srcu_down_read() and srcu_up_read(), so
if they stay unused for another year or so...

> > The other rule for RCU Tasks Trace is that although readers are permitted
> > to block, this blocking can be for no longer than a major page fault.
> > If you need longer-term blocking, then you should instead use SRCU.
> 
> I think this would render it unsuitable for uprobes. The whole point of
> having a sleepable handler is to be able to take faults.

???

I said "longer than a major page fault", so it is OK to take a fault,
just not one that potentially blocks forever.  (And those faulting onto
things like NFS filesystems have enough other problems that this would
be in the noise for them, right?)

And yes, RCU Tasks Trace is specialized.  I would expect that unexpected
new uses would get serious scrutiny by those currently using it.

							Thanx, Paul

