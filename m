Return-Path: <bpf+bounces-33661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB3924806
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06496B24780
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B41C9ED9;
	Tue,  2 Jul 2024 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FwHHpTTq"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552D1EB25;
	Tue,  2 Jul 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947949; cv=none; b=OZxgXwo727nah7jUJmiBeoP3W8cv16j11KaQKg/Cwb5CpUtkFEqZ6Sfc8Yf7RDnCDF4duW98XWS7WMX0qg8LPio+OUd1aC9/lM8eMFNkUv1gdsOIIJS2MOdkIE1Y8HQJu1HBA0BCKHGLMclWsWnxrSzTbju3t5hKJ4piaZuTjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947949; c=relaxed/simple;
	bh=qE5auNhai9dGV9LtL6KaE2P0rxgrR5aQwmk1i1Ie/T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn28i5ZhP0Zp72F6gTP4g3597iQwAxnx7Ld9VPHD868RhfeueXffq3OJTViwV3+GOGOvowb6rQjQlXqJ64LKSnc00OVFxuT61AqF9CUPEsxVq3AHfNT71uc1XAPpJpUOcOdESmQBdacOyIW2gTU+oG/qiGnZN1KgCe/qa7QNeww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FwHHpTTq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=652kzr90UlMHK6R7AjCXVbHKXbDJFiJb4ijYez+VQrI=; b=FwHHpTTqbKxtFPHHu7y62KH28K
	W/tKXaL3YLfeSHOooxkTjPD+dtFtxlpYnJ6wV/aqI81osSBtkgMEyXOFLeulxKtp4GHNQHxLQ9X36
	nvHNi51FhRnKuMY9ZXDHSUVbyTNt802rzFU1xi2n0L0uuM5nzJqmeO7saplQ+PYRxShFF2IvTuw4J
	j6AvM8Dboj5FBUAfU7SwQIBaZNtJvfffOVW1ODLTUEWlDTmc3qpvoQgNsf+DzIZDo2VI4vbW2LrFi
	PdrsK4lNSQr7pF1lduxA+sPfeErOr8B0eKrNPIaymXkmoXBucxDodmKTiFXjYjUooRh+bcB4stP/t
	RxqtkUZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOj1p-00000009rOm-0csw;
	Tue, 02 Jul 2024 19:19:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EDFFD300694; Tue,  2 Jul 2024 21:18:57 +0200 (CEST)
Date: Tue, 2 Jul 2024 21:18:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>

On Tue, Jul 02, 2024 at 10:54:51AM -0700, Andrii Nakryiko wrote:

> > @@ -593,6 +595,12 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
> >         return uprobe;
> >  }
> >
> > +static void uprobe_free_rcu(struct rcu_head *rcu)
> > +{
> > +       struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
> > +       kfree(uprobe);
> > +}
> > +
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> >         if (refcount_dec_and_test(&uprobe->ref)) {
> > @@ -604,7 +612,8 @@ static void put_uprobe(struct uprobe *uprobe)
> 
> right above this we have roughly this:
> 
> percpu_down_write(&uprobes_treelock);
> 
> /* refcount check */
> rb_erase(&uprobe->rb_node, &uprobes_tree);
> 
> percpu_up_write(&uprobes_treelock);
> 
> 
> This writer lock is necessary for modification of the RB tree. And I
> was under impression that I shouldn't be doing
> percpu_(down|up)_write() inside the normal
> rcu_read_lock()/rcu_read_unlock() region (percpu_down_write has
> might_sleep() in it). But maybe I'm wrong, hopefully Paul can help to
> clarify.

preemptible RCU or SRCU would work.

> 
> But actually what's wrong with RCU Tasks Trace flavor? 

Paul, isn't this the RCU flavour you created to deal with
!rcu_is_watching()? The flavour that never should have been created in
favour of just cleaning up the mess instead of making more.

> I will
> ultimately use it anyway to avoid uprobe taking unnecessary refcount
> and to protect uprobe->consumers iteration and uc->handler() calls,
> which could be sleepable, so would need rcu_read_lock_trace().

I don't think you need trace-rcu for that. SRCU would do nicely I think.

> >                 mutex_lock(&delayed_uprobe_lock);
> >                 delayed_uprobe_remove(uprobe, NULL);
> >                 mutex_unlock(&delayed_uprobe_lock);
> > -               kfree(uprobe);
> > +
> > +               call_rcu(&uprobe->rcu, uprobe_free_rcu);
> >         }
> >  }
> >
> > @@ -668,12 +677,25 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
> >  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> >  {
> >         struct uprobe *uprobe;
> > +       unsigned seq;
> >
> > -       read_lock(&uprobes_treelock);
> > -       uprobe = __find_uprobe(inode, offset);
> > -       read_unlock(&uprobes_treelock);
> > +       guard(rcu)();
> >
> > -       return uprobe;
> > +       do {
> > +               seq = read_seqcount_begin(&uprobes_seqcount);
> > +               uprobes = __find_uprobe(inode, offset);
> > +               if (uprobes) {
> > +                       /*
> > +                        * Lockless RB-tree lookups are prone to false-negatives.
> > +                        * If they find something, it's good. If they do not find,
> > +                        * it needs to be validated.
> > +                        */
> > +                       return uprobes;
> > +               }
> > +       } while (read_seqcount_retry(&uprobes_seqcount, seq));
> > +
> > +       /* Really didn't find anything. */
> > +       return NULL;
> >  }
> 
> Honest question here, as I don't understand the tradeoffs well enough.
> Is there a lot of benefit to switching to seqcount lock vs using
> percpu RW semaphore (previously recommended by Ingo). The latter is a
> nice drop-in replacement and seems to be very fast and scale well.

As you noted, that percpu-rwsem write side is quite insane. And you're
creating this batch complexity to mitigate that.

The patches you propose are quite complex, this alternative not so much.

> Right now we are bottlenecked on uprobe->register_rwsem (not
> uprobes_treelock anymore), which is currently limiting the scalability
> of uprobes and I'm going to work on that next once I'm done with this
> series.

Right, but it looks fairly simple to replace that rwsem with a mutex and
srcu.

