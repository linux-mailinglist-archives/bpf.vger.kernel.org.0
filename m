Return-Path: <bpf+bounces-33706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0132F924C75
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 01:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4E1F22E73
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500D17DA03;
	Tue,  2 Jul 2024 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYkiTOq2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455481DA32A;
	Tue,  2 Jul 2024 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964614; cv=none; b=BXnQyPseKnqPDG89dgqzcbVLSiT5sxuB1QscLrY5Q+nFbFWu9I8CgsbxLtGbHiewkccK7PssUdHzJ/hH0DsIWAi49RapL/jo1vjIQhpsjQpNKJsgop6IqdLmUBFiCkW487nGIACksrBellKDyq+kdJpuebunZlR5HqPnpDBmhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964614; c=relaxed/simple;
	bh=/u+NT7gZlV7JM/3SqAiqA14tPU21QGJcXgMdMkFdSaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF+pAkqNndn7sKVGBXumxsHjN/n+vCgBcYRmQNTVnAUCU1BuMS0o4PC4z+WK4Wak6lXfP5dISHjDFvyzExIKwokEIGKjDIdble3C4mYzt13U2t5S2L1cOOCCGFLnaYTr3rLAE2ZhLwYeUQvo3QFU0yuOAQIxm53Ndig79cgTr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYkiTOq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E464C116B1;
	Tue,  2 Jul 2024 23:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964614;
	bh=/u+NT7gZlV7JM/3SqAiqA14tPU21QGJcXgMdMkFdSaY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hYkiTOq2Q16q8EYqT5DEL5bPis6Txv2cNl/WmKQ9svP2VNOO/SUG4ZEtF0CRSdEuW
	 yl8z8oJR/dLfwGvj3zk4NfBgpElNeBAIURafxtis6WQ9HuOYgQn38CkyxVrIA4LCaS
	 S9x46m9LhpgG/JFUqfTKv4+pfrxVUFLKdl4EvolmtW5CmELZcNLaC7/dOgotwEsjKq
	 ld5YKIziU1ckWmOVKxA/UwlTTL3gb3ncFrS/OEIeZcRUdEikCa8L0Nbig9NOZvYTS9
	 1p1E0XXnuDHSHzmhodiftI6CbCkH9sdgqwp0YbgsQLkgVSGZ6ULwMDO9AIoTH7XTD0
	 vEc0blplBhkUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A947BCE03D3; Tue,  2 Jul 2024 16:56:53 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:56:53 -0700
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
Message-ID: <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702191857.GJ11386@noisy.programming.kicks-ass.net>

On Tue, Jul 02, 2024 at 09:18:57PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 02, 2024 at 10:54:51AM -0700, Andrii Nakryiko wrote:
> 
> > > @@ -593,6 +595,12 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
> > >         return uprobe;
> > >  }
> > >
> > > +static void uprobe_free_rcu(struct rcu_head *rcu)
> > > +{
> > > +       struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
> > > +       kfree(uprobe);
> > > +}
> > > +
> > >  static void put_uprobe(struct uprobe *uprobe)
> > >  {
> > >         if (refcount_dec_and_test(&uprobe->ref)) {
> > > @@ -604,7 +612,8 @@ static void put_uprobe(struct uprobe *uprobe)
> > 
> > right above this we have roughly this:
> > 
> > percpu_down_write(&uprobes_treelock);
> > 
> > /* refcount check */
> > rb_erase(&uprobe->rb_node, &uprobes_tree);
> > 
> > percpu_up_write(&uprobes_treelock);
> > 
> > 
> > This writer lock is necessary for modification of the RB tree. And I
> > was under impression that I shouldn't be doing
> > percpu_(down|up)_write() inside the normal
> > rcu_read_lock()/rcu_read_unlock() region (percpu_down_write has
> > might_sleep() in it). But maybe I'm wrong, hopefully Paul can help to
> > clarify.
> 
> preemptible RCU or SRCU would work.

I agree that SRCU would work from a functional viewpoint.  No so for
preemptible RCU, which permits preemption (and on -rt, blocking for
spinlocks), it does not permit full-up blocking, and for good reason.

> > But actually what's wrong with RCU Tasks Trace flavor? 
> 
> Paul, isn't this the RCU flavour you created to deal with
> !rcu_is_watching()? The flavour that never should have been created in
> favour of just cleaning up the mess instead of making more.

My guess is that you are instead thinking of RCU Tasks Rude, which can
be eliminated once all architectures get their entry/exit/deep-idle
functions either inlined or marked noinstr.

> > I will
> > ultimately use it anyway to avoid uprobe taking unnecessary refcount
> > and to protect uprobe->consumers iteration and uc->handler() calls,
> > which could be sleepable, so would need rcu_read_lock_trace().
> 
> I don't think you need trace-rcu for that. SRCU would do nicely I think.

From a functional viewpoint, agreed.

However, in the past, the memory-barrier and array-indexing overhead
of SRCU has made it a no-go for lightweight probes into fastpath code.
And these cases were what motivated RCU Tasks Trace (as opposed to RCU
Tasks Rude).

The other rule for RCU Tasks Trace is that although readers are permitted
to block, this blocking can be for no longer than a major page fault.
If you need longer-term blocking, then you should instead use SRCU.

							Thanx, Paul

> > >                 mutex_lock(&delayed_uprobe_lock);
> > >                 delayed_uprobe_remove(uprobe, NULL);
> > >                 mutex_unlock(&delayed_uprobe_lock);
> > > -               kfree(uprobe);
> > > +
> > > +               call_rcu(&uprobe->rcu, uprobe_free_rcu);
> > >         }
> > >  }
> > >
> > > @@ -668,12 +677,25 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
> > >  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > >  {
> > >         struct uprobe *uprobe;
> > > +       unsigned seq;
> > >
> > > -       read_lock(&uprobes_treelock);
> > > -       uprobe = __find_uprobe(inode, offset);
> > > -       read_unlock(&uprobes_treelock);
> > > +       guard(rcu)();
> > >
> > > -       return uprobe;
> > > +       do {
> > > +               seq = read_seqcount_begin(&uprobes_seqcount);
> > > +               uprobes = __find_uprobe(inode, offset);
> > > +               if (uprobes) {
> > > +                       /*
> > > +                        * Lockless RB-tree lookups are prone to false-negatives.
> > > +                        * If they find something, it's good. If they do not find,
> > > +                        * it needs to be validated.
> > > +                        */
> > > +                       return uprobes;
> > > +               }
> > > +       } while (read_seqcount_retry(&uprobes_seqcount, seq));
> > > +
> > > +       /* Really didn't find anything. */
> > > +       return NULL;
> > >  }
> > 
> > Honest question here, as I don't understand the tradeoffs well enough.
> > Is there a lot of benefit to switching to seqcount lock vs using
> > percpu RW semaphore (previously recommended by Ingo). The latter is a
> > nice drop-in replacement and seems to be very fast and scale well.
> 
> As you noted, that percpu-rwsem write side is quite insane. And you're
> creating this batch complexity to mitigate that.
> 
> The patches you propose are quite complex, this alternative not so much.
> 
> > Right now we are bottlenecked on uprobe->register_rwsem (not
> > uprobes_treelock anymore), which is currently limiting the scalability
> > of uprobes and I'm going to work on that next once I'm done with this
> > series.
> 
> Right, but it looks fairly simple to replace that rwsem with a mutex and
> srcu.

