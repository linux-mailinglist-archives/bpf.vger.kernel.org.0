Return-Path: <bpf+bounces-33729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8049252B6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 06:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A221F22F80
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 04:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AF0482EB;
	Wed,  3 Jul 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx5kahgf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D473B1BC;
	Wed,  3 Jul 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719982498; cv=none; b=Uq/9ZKIOxIJDN/isGiAek8+ZZykZVaGAoRIUqst0igW7iajCKcrHtCugnGuhE2xe0FGgir4JphJEGuFwdVlXj1YVvWNted3YzMBNDf57bszhdXqfPwLGOOvEXq3uhcCys7xDVsqxxuYhewIFPSrAd1zdl4dUsxtMQv8enea0VIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719982498; c=relaxed/simple;
	bh=iXUw4GvNpASMcNbS/qMPqNBslzVg7ZC4vPgOn+6cqso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdNImGfwKXd1s+qZHg8RWnLw59n+1uLCl80F5oAuq1IClCD7BOnr5qxw2tzto0r6xHGz3T9UuVMnIFYv/1IsN3g4JCk+Ve6nMOiz/JgVCUPdurdwcUM3whHMza3HjtWH/SPjYXJx7p4GNLQVd1bKyt4Yok94K6SgAn18WCOCR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx5kahgf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70aeb6e1908so125788b3a.0;
        Tue, 02 Jul 2024 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719982496; x=1720587296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDpaa0dfkI/CTDnvUjwqbRxEtMZIx9LS8sItRX0s7WE=;
        b=Xx5kahgfVhZRe6QE1+3v6alTDnqcrjTPonYkGmuDKppHMx6bCZCwziIOURmKs8U5HP
         eOCqB0QPZB5o/KZ0LZjDnlOyMBq9gKSqrV8wSbGfWX4tSusPGK4ye8la7s47qbUOACPv
         OOsQn7OXSALuTHEw5m0luPg6dCyQKFg3iIxmouBQUJEmnSG4OZXFWNZ6CKm1D3qtw9cT
         n2sI8mqyjT2V8i+VPkI72aYuc7P4LU5uhr/FIyo0SoyV6c6JbsN8nnRB511UNB65HGDJ
         Npt0Ib97kIjPK7v/vKIiSPQo5rcGafsWkPPuvuSHyRv5zmvwvNDM0PqajSyAa9aRWF/9
         hUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719982496; x=1720587296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDpaa0dfkI/CTDnvUjwqbRxEtMZIx9LS8sItRX0s7WE=;
        b=Tbddt34G6ZdE/GayllwhLEu7TRNDZX9kDH2HJ0DPGj7rWruGvtOC80hfmCTNfZYvr8
         cdjiQ89lC+TUIXylCf+p04FF60hlSl313SZKPw6Rp6y4I1G42+Vsq2A7/j+cNPIWwZSU
         U/CYUWpqLhNFNIAkFn9TU9wnwE89sQrIYK365FVReFr/k0XEknuIqsOK53aispiJnb96
         UlQUc0LcYoFhIfxs0L2DoXk1XNZOXho846BQIhAZo5Z4D/J45QYmrxoinNn57nG4SgUn
         uRffn1nO69OkOv9UgFlJwR4bFM2bYGbpt1Gu2L0jbM5kAss3kVOiK4tiZ2c29ON662LC
         XS9A==
X-Forwarded-Encrypted: i=1; AJvYcCX07w/onMiouVVR/sV4JWGPdpnJODnzSG8NNM/EdXDPOD5gfM804DzFQThsA2Z/acD+PelkE+JdwMFJtCjtVCOIcB76qneg0nP/CJa3zlWw9vCfnrFS5JNBSbjsQQMhDedoW4OizNJRJbjr/sdAGDzeh308yZW1icBwYG5+ukveW6p6cXl4
X-Gm-Message-State: AOJu0YwzXsvY8P0Xb782NwpyxvgiJTeGFyssGWZ3I9p/TP8NiPghN1ub
	buzmG81OMWBA8HmlxzrzZDp1l5qP1rPdnoGG1C9IVhWknynR/siYZ+bzuYpRzRM/4vbSI6d8CHY
	dY4UO+2xU7O2UANRvQTNNys1awUU=
X-Google-Smtp-Source: AGHT+IHfKbuu0mDTG8MLd6Z/DkyZRTYRD3A8P4M+CeGmfg6YgH087ZYLSAJvqTtmcFKvuO1LkuMN9oZ/Fz32sQCiAZ0=
X-Received: by 2002:a05:6a00:1d09:b0:706:b179:dc5d with SMTP id
 d2e1a72fcca58-70aaaf1053dmr9916424b3a.25.1719982495542; Tue, 02 Jul 2024
 21:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net> <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net> <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
In-Reply-To: <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 21:54:43 -0700
Message-ID: <CAEf4Bzbz2bXFFB_s=bD+8CFAvMNuRSXxJPQBkRxWjY303v4Caw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	oleg@redhat.com, mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:56=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Tue, Jul 02, 2024 at 09:18:57PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 02, 2024 at 10:54:51AM -0700, Andrii Nakryiko wrote:
> >
> > > > @@ -593,6 +595,12 @@ static struct uprobe *get_uprobe(struct uprobe=
 *uprobe)
> > > >         return uprobe;
> > > >  }
> > > >
> > > > +static void uprobe_free_rcu(struct rcu_head *rcu)
> > > > +{
> > > > +       struct uprobe *uprobe =3D container_of(rcu, struct uprobe, =
rcu);
> > > > +       kfree(uprobe);
> > > > +}
> > > > +
> > > >  static void put_uprobe(struct uprobe *uprobe)
> > > >  {
> > > >         if (refcount_dec_and_test(&uprobe->ref)) {
> > > > @@ -604,7 +612,8 @@ static void put_uprobe(struct uprobe *uprobe)
> > >
> > > right above this we have roughly this:
> > >
> > > percpu_down_write(&uprobes_treelock);
> > >
> > > /* refcount check */
> > > rb_erase(&uprobe->rb_node, &uprobes_tree);
> > >
> > > percpu_up_write(&uprobes_treelock);
> > >
> > >
> > > This writer lock is necessary for modification of the RB tree. And I
> > > was under impression that I shouldn't be doing
> > > percpu_(down|up)_write() inside the normal
> > > rcu_read_lock()/rcu_read_unlock() region (percpu_down_write has
> > > might_sleep() in it). But maybe I'm wrong, hopefully Paul can help to
> > > clarify.
> >
> > preemptible RCU or SRCU would work.
>
> I agree that SRCU would work from a functional viewpoint.  No so for
> preemptible RCU, which permits preemption (and on -rt, blocking for
> spinlocks), it does not permit full-up blocking, and for good reason.
>
> > > But actually what's wrong with RCU Tasks Trace flavor?
> >
> > Paul, isn't this the RCU flavour you created to deal with
> > !rcu_is_watching()? The flavour that never should have been created in
> > favour of just cleaning up the mess instead of making more.
>
> My guess is that you are instead thinking of RCU Tasks Rude, which can
> be eliminated once all architectures get their entry/exit/deep-idle
> functions either inlined or marked noinstr.
>
> > > I will
> > > ultimately use it anyway to avoid uprobe taking unnecessary refcount
> > > and to protect uprobe->consumers iteration and uc->handler() calls,
> > > which could be sleepable, so would need rcu_read_lock_trace().
> >
> > I don't think you need trace-rcu for that. SRCU would do nicely I think=
.
>
> From a functional viewpoint, agreed.
>
> However, in the past, the memory-barrier and array-indexing overhead
> of SRCU has made it a no-go for lightweight probes into fastpath code.
> And these cases were what motivated RCU Tasks Trace (as opposed to RCU
> Tasks Rude).

Yep, and this is a similar case here. I've actually implemented
SRCU-based protection and benchmarked it (all other things being the
same). I see 5% slowdown for the fastest uprobe kind (entry uprobe on
nop) for the single-threaded use case. We go down from 3.15 millions/s
triggerings to slightly below 3 millions/s. With more threads the
difference increases a bit, though numbers vary a bit from run to run,
so I don't want to put out the exact number. But I see that for
SRCU-based implementation total aggregated peak achievable throughput
is about 3.5-3.6 mln/s vs this implementation reaching 4-4.1 mln/s.
Again, some of that could be variability, but I did run multiple
rounds and that's the trend I'm seeing.

>
> The other rule for RCU Tasks Trace is that although readers are permitted
> to block, this blocking can be for no longer than a major page fault.
> If you need longer-term blocking, then you should instead use SRCU.
>

And this is the case here. Right now rcu_read_lock_trace() is
protecting uprobes_treelock, which is only taken for the duration of
RB tree lookup/insert/delete. In my subsequent changes to eliminate
register_rwsem we might be executing uprobe_consumer under this RCU
lock, but those also should be only sleeping for page faults.

On the other hand, hot path (reader side) is quite hot with
millions/second executions and should add as little overhead as
possible (which is why I'm seeing SRCU-based implementation being
slower, as I mentioned above).

>                                                         Thanx, Paul
>
> > > >                 mutex_lock(&delayed_uprobe_lock);
> > > >                 delayed_uprobe_remove(uprobe, NULL);
> > > >                 mutex_unlock(&delayed_uprobe_lock);
> > > > -               kfree(uprobe);
> > > > +
> > > > +               call_rcu(&uprobe->rcu, uprobe_free_rcu);
> > > >         }
> > > >  }
> > > >
> > > > @@ -668,12 +677,25 @@ static struct uprobe *__find_uprobe(struct in=
ode *inode, loff_t offset)
> > > >  static struct uprobe *find_uprobe(struct inode *inode, loff_t offs=
et)
> > > >  {
> > > >         struct uprobe *uprobe;
> > > > +       unsigned seq;
> > > >
> > > > -       read_lock(&uprobes_treelock);
> > > > -       uprobe =3D __find_uprobe(inode, offset);
> > > > -       read_unlock(&uprobes_treelock);
> > > > +       guard(rcu)();
> > > >
> > > > -       return uprobe;
> > > > +       do {
> > > > +               seq =3D read_seqcount_begin(&uprobes_seqcount);
> > > > +               uprobes =3D __find_uprobe(inode, offset);
> > > > +               if (uprobes) {
> > > > +                       /*
> > > > +                        * Lockless RB-tree lookups are prone to fa=
lse-negatives.
> > > > +                        * If they find something, it's good. If th=
ey do not find,
> > > > +                        * it needs to be validated.
> > > > +                        */
> > > > +                       return uprobes;
> > > > +               }
> > > > +       } while (read_seqcount_retry(&uprobes_seqcount, seq));
> > > > +
> > > > +       /* Really didn't find anything. */
> > > > +       return NULL;
> > > >  }
> > >
> > > Honest question here, as I don't understand the tradeoffs well enough=
.
> > > Is there a lot of benefit to switching to seqcount lock vs using
> > > percpu RW semaphore (previously recommended by Ingo). The latter is a
> > > nice drop-in replacement and seems to be very fast and scale well.
> >
> > As you noted, that percpu-rwsem write side is quite insane. And you're
> > creating this batch complexity to mitigate that.
> >
> > The patches you propose are quite complex, this alternative not so much=
.
> >
> > > Right now we are bottlenecked on uprobe->register_rwsem (not
> > > uprobes_treelock anymore), which is currently limiting the scalabilit=
y
> > > of uprobes and I'm going to work on that next once I'm done with this
> > > series.
> >
> > Right, but it looks fairly simple to replace that rwsem with a mutex an=
d
> > srcu.

