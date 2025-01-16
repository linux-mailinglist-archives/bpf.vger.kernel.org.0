Return-Path: <bpf+bounces-49125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F1A144EF
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3B77A130D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417A1DE2CC;
	Thu, 16 Jan 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF7FCVx9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1351DDC3A;
	Thu, 16 Jan 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068260; cv=none; b=ZkAPeC2zzdtflr/RH10MiBnwhI7Zg1G2rYR744QaEabONgdzWLa4KqzM1rdPCbzhjsMfsGCr9f17C9Lmg5kd6hhjzykys4RIa2QcIZZVB3X+KFYqkpk8ntW3hvNgS2en3cYUEXGJUbBiYJw/mCneDcZQmvOMxrhaqZawyRr1fXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068260; c=relaxed/simple;
	bh=dy5Af1gJs4OJVKqpre7SCuaNszIHuDUb25pFaIf0OEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vl2XhxxnccHqZ0TqVfKe34e/EKVrDXGFg4RnSR5nKqsFjLk6OrUvR32PwgeTJx2orngceWjC+u6jIRcFmJmj8hcGEDkfDp4FrRQXtJHpQvJyse2bvg8Yv52ylwJ/PKca1lntqJSTrPAy+MiAooOLcOzNEw8bSmA5qBCw3NFVbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF7FCVx9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so4278114a91.0;
        Thu, 16 Jan 2025 14:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737068258; x=1737673058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMKoNBT3jg3r2TYI0CT+Kf+FalpxL1Zl6Q2hQ4+WUIY=;
        b=lF7FCVx9GnumIbKcoje1tePsiTAtHQwPOnYuRSOb3K51Uofvvo83auaxly3EEUTNbx
         UsUzvTue+sPATFnwUdDbn8RG2cJ+3PQBU3TslHKGNHedyRePEUVe5vzplcH1tfxeqn5j
         6qxGl7sVpOurQp10P0jrwest+B97j5igo8n/uRJvEYx3Nb29ZDjQWmj5Fhd+mOMlrmmD
         1CgHut7mIlacLbGl0XnPpGudfBRO51ZwGB2UFlFvYVebfw4do5xEFxzdGOUk07BiNgYE
         fjOQRAFXNYiJBfpaNoX0zSRzS313KDXrFiiXoDkUDNIUm/9D/TBbHd3QWZMO6bgcD35H
         CUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737068258; x=1737673058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMKoNBT3jg3r2TYI0CT+Kf+FalpxL1Zl6Q2hQ4+WUIY=;
        b=Gf4yK3giT+tBUngCiGOKWBs1SaCLtHHUGxA8a+mOWgZsZEBFQE9Dzt45hHb27jjyBB
         cVJXxQhOfs/XCpDvBl+1w08HxDzxU8+iKLWzLnT7rg7H+Chiewx1XlcFFu369qtvwZY5
         fEP8mqwQYmblCp+yGLQqiWMPExFSM6VZYtqF9PqXgaTCF35vyimWvTSwMvtchq+sfS3F
         i6WgZHivAFyWzqtkLR9cL+dkwb7uuT9yKX5RffqupHnWl8G/1T69QDh+3Bhe0rv2pQaB
         CzOGpSdDQw1tKGzftcx9NTxCZufKbtc6r60GiWSRXIwtED9l42EflyBLLp6FZsasYlJm
         qrtg==
X-Forwarded-Encrypted: i=1; AJvYcCWKNIdT0FmbG3EaEUJdKWhjhG/ewgA7jUg6EEFm69UNKMrIHt75VOdyX3wwK2h0fonoYMg=@vger.kernel.org, AJvYcCX9LvGITRxxnebKaGRhweocfRWfzXs/K8tbkPoK3nsr53lFRB/Gp1UG2sDkLcFRVc+JlDeRL+4aR34ssOBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzDeE6pGE7YCo7g5msa/HKkOy+vrfoB8G2ntfvVPUkDbcRhyni+
	/RjfJl9ZlSLvyHvC4d/8XeOOdXQoRBRvUpUHGgJMU8AxNeQUzoAWnDbsL5azlXIdM38knjQ3nwy
	AugwxhS1dHwtoTNQ3T2T+cI1gwDE=
X-Gm-Gg: ASbGnctu2kULXr9VGS9vQ9+YIZwyb/kMPJwY20TTI64JEIQjMTtiSurb6G/5RObE9JC
	hap83btsZgMCMV9qfCsgy7dj88d0QDZFhjOh5
X-Google-Smtp-Source: AGHT+IFOhwgxC8WRMPLdgVluXIJskryUaGT4EmP509MzRR2rMphv3bgzedFm6ty2CvKx+PLbqqxPIV5sMAOZgl1pIcU=
X-Received: by 2002:a17:90b:2e44:b0:2f7:4c7a:b5f with SMTP id
 98e67ed59e1d1-2f74c7a0c32mr8365966a91.2.1737068257945; Thu, 16 Jan 2025
 14:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
 <20250116202112.3783327-13-paulmck@kernel.org> <CAEf4BzYqAVuX1nP20qVaY8_CnDom699vzAjm7ZLaMx+oz8vceQ@mail.gmail.com>
 <5dc925b6-2faf-4788-9c8c-9387d04417ee@paulmck-laptop>
In-Reply-To: <5dc925b6-2faf-4788-9c8c-9387d04417ee@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 14:57:25 -0800
X-Gm-Features: AbW1kva2z2ORb3ekbmEFy7dF0GWvl5rZYqzlcy5ETDbOukJKrA3s0AwMXTUC4dQ
Message-ID: <CAEf4BzZhJU+Q3qVyhqKjSRtGt=+3VY=N14ZOqqxYmCOQPnKnWw@mail.gmail.com>
Subject: Re: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 2:54=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Jan 16, 2025 at 01:52:53PM -0800, Andrii Nakryiko wrote:
> > On Thu, Jan 16, 2025 at 12:21=E2=80=AFPM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > >
> > > This commit adds srcu_read_{,un}lock_fast(), which is similar
> > > to srcu_read_{,un}lock_lite(), but avoids the array-indexing and
> > > pointer-following overhead.  On a microbenchmark featuring tight
> > > loops around empty readers, this results in about a 20% speedup
> > > compared to RCU Tasks Trace on my x86 laptop.
> > >
> > > Please note that SRCU-fast has drawbacks compared to RCU Tasks
> > > Trace, including:
> > >
> > > o       Lack of CPU stall warnings.
> > > o       SRCU-fast readers permitted only where rcu_is_watching().
> > > o       A pointer-sized return value from srcu_read_lock_fast() must
> > >         be passed to the corresponding srcu_read_unlock_fast().
> > > o       In the absence of readers, a synchronize_srcu() having _fast(=
)
> > >         readers will incur the latency of at least two normal RCU gra=
ce
> > >         periods.
> > > o       RCU Tasks Trace priority boosting could be easily added.
> > >         Boosting SRCU readers is more difficult.
> > >
> > > SRCU-fast also has a drawback compared to SRCU-lite, namely that the
> > > return value from srcu_read_lock_fast()-fast is a 64-bit pointer and
> > > that from srcu_read_lock_lite() is only a 32-bit int.
> > >
> > > [ paulmck: Apply feedback from Akira Yokosawa. ]
> > >
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > > Cc: <bpf@vger.kernel.org>
> > > ---
> > >  include/linux/srcu.h     | 47 ++++++++++++++++++++++++++++++++++++++=
--
> > >  include/linux/srcutiny.h | 22 +++++++++++++++++++
> > >  include/linux/srcutree.h | 38 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 105 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > index 2bd0e24e9b554..63bddc3014238 100644
> > > --- a/include/linux/srcu.h
> > > +++ b/include/linux/srcu.h
> > > @@ -47,9 +47,10 @@ int init_srcu_struct(struct srcu_struct *ssp);
> > >  #define SRCU_READ_FLAVOR_NORMAL        0x1             // srcu_read_=
lock().
> > >  #define SRCU_READ_FLAVOR_NMI   0x2             // srcu_read_lock_nmi=
safe().
> > >  #define SRCU_READ_FLAVOR_LITE  0x4             // srcu_read_lock_lit=
e().
> > > +#define SRCU_READ_FLAVOR_FAST  0x8             // srcu_read_lock_fas=
t().
> > >  #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_=
FLAVOR_NMI | \
> > > -                               SRCU_READ_FLAVOR_LITE) // All of the =
above.
> > > -#define SRCU_READ_FLAVOR_SLOWGP        SRCU_READ_FLAVOR_LITE
> > > +                               SRCU_READ_FLAVOR_LITE | SRCU_READ_FLA=
VOR_FAST) // All of the above.
> > > +#define SRCU_READ_FLAVOR_SLOWGP        (SRCU_READ_FLAVOR_LITE | SRCU=
_READ_FLAVOR_FAST)
> > >                                                 // Flavors requiring =
synchronize_rcu()
> > >                                                 // instead of smp_mb(=
).
> > >  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases=
(ssp);
> > > @@ -253,6 +254,33 @@ static inline int srcu_read_lock(struct srcu_str=
uct *ssp) __acquires(ssp)
> > >         return retval;
> > >  }
> > >
> > > +/**
> > > + * srcu_read_lock_fast - register a new reader for an SRCU-protected=
 structure.
> > > + * @ssp: srcu_struct in which to register the new reader.
> > > + *
> > > + * Enter an SRCU read-side critical section, but for a light-weight
> > > + * smp_mb()-free reader.  See srcu_read_lock() for more information.
> > > + *
> > > + * If srcu_read_lock_fast() is ever used on an srcu_struct structure=
,
> > > + * then none of the other flavors may be used, whether before, durin=
g,
> > > + * or after.  Note that grace-period auto-expediting is disabled for=
 _fast
> > > + * srcu_struct structures because auto-expedited grace periods invok=
e
> > > + * synchronize_rcu_expedited(), IPIs and all.
> > > + *
> > > + * Note that srcu_read_lock_fast() can be invoked only from those co=
ntexts
> > > + * where RCU is watching, that is, from contexts where it would be l=
egal
> > > + * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
> > > + */
> > > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct s=
rcu_struct *ssp) __acquires(ssp)
> > > +{
> > > +       struct srcu_ctr __percpu *retval;
> > > +
> > > +       srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> > > +       retval =3D __srcu_read_lock_fast(ssp);
> > > +       rcu_try_lock_acquire(&ssp->dep_map);
> > > +       return retval;
> > > +}
> > > +
> > >  /**
> > >   * srcu_read_lock_lite - register a new reader for an SRCU-protected=
 structure.
> > >   * @ssp: srcu_struct in which to register the new reader.
> > > @@ -356,6 +384,21 @@ static inline void srcu_read_unlock(struct srcu_=
struct *ssp, int idx)
> > >         __srcu_read_unlock(ssp, idx);
> > >  }
> > >
> > > +/**
> > > + * srcu_read_unlock_fast - unregister a old reader from an SRCU-prot=
ected structure.
> > > + * @ssp: srcu_struct in which to unregister the old reader.
> > > + * @scp: return value from corresponding srcu_read_lock_fast().
> > > + *
> > > + * Exit a light-weight SRCU read-side critical section.
> > > + */
> > > +static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, st=
ruct srcu_ctr __percpu *scp)
> > > +       __releases(ssp)
> > > +{
> > > +       srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> > > +       srcu_lock_release(&ssp->dep_map);
> > > +       __srcu_read_unlock_fast(ssp, scp);
> > > +}
> > > +
> > >  /**
> > >   * srcu_read_unlock_lite - unregister a old reader from an SRCU-prot=
ected structure.
> > >   * @ssp: srcu_struct in which to unregister the old reader.
> > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > index 07a0c4489ea2f..380260317d98b 100644
> > > --- a/include/linux/srcutiny.h
> > > +++ b/include/linux/srcutiny.h
> > > @@ -71,6 +71,28 @@ static inline int __srcu_read_lock(struct srcu_str=
uct *ssp)
> > >         return idx;
> > >  }
> > >
> > > +struct srcu_ctr;
> > > +
> > > +static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct=
 srcu_ctr __percpu *scpp)
> > > +{
> > > +       return (int)(intptr_t)(struct srcu_ctr __force __kernel *)scp=
p;
> > > +}
> > > +
> > > +static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct src=
u_struct *ssp, int idx)
> > > +{
> > > +       return (struct srcu_ctr __percpu *)(intptr_t)idx;
> > > +}
> > > +
> > > +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct=
 srcu_struct *ssp)
> > > +{
> > > +       return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
> > > +}
> > > +
> > > +static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, =
struct srcu_ctr __percpu *scp)
> > > +{
> > > +       __srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
> > > +}
> > > +
> > >  #define __srcu_read_lock_lite __srcu_read_lock
> > >  #define __srcu_read_unlock_lite __srcu_read_unlock
> > >
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index ef3065c0cadcd..bdc467efce3a2 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -226,6 +226,44 @@ static inline struct srcu_ctr __percpu *__srcu_c=
tr_to_ptr(struct srcu_struct *ss
> > >         return &ssp->sda->srcu_ctrs[idx];
> > >  }
> > >
> > > +/*
> > > + * Counts the new reader in the appropriate per-CPU element of the
> > > + * srcu_struct.  Returns a pointer that must be passed to the matchi=
ng
> > > + * srcu_read_unlock_fast().
> > > + *
> > > + * Note that this_cpu_inc() is an RCU read-side critical section eit=
her
> > > + * because it disables interrupts, because it is a single instructio=
n,
> > > + * or because it is a read-modify-write atomic operation, depending =
on
> > > + * the whims of the architecture.
> > > + */
> > > +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct=
 srcu_struct *ssp)
> > > +{
> > > +       struct srcu_ctr __percpu *scp =3D READ_ONCE(ssp->srcu_ctrp);
> > > +
> > > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching sr=
cu_read_lock_fast().");
> > > +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> > > +       barrier(); /* Avoid leaking the critical section. */
> > > +       return scp;
> > > +}
> > > +
> > > +/*
> > > + * Removes the count for the old reader from the appropriate
> > > + * per-CPU element of the srcu_struct.  Note that this may well be a
> > > + * different CPU than that which was incremented by the correspondin=
g
> > > + * srcu_read_lock_fast(), but it must be within the same task.
> >
> > hm... why the "same task" restriction? With uretprobes we take
> > srcu_read_lock under a traced task, but we can "release" this lock
> > from timer interrupt, which could be in the context of any task.
>
> A kneejerk reaction on my part?  ;-)
>
> But the good news is that this restriction is easy for me to relax.
> I adjust the comments and remove the rcu_try_lock_acquire()
> from srcu_read_lock_fast() and the srcu_lock_release() from
> srcu_read_unlock_fast().
>
> But in that case, I should rename this to srcu_down_read_fast() and
> srcu_up_read_fast() or similar, as these names would clearly indicate
> that they can be used cross-task.  (And from interrupt handlers, but
> not from NMI handlers.)
>
> Also, srcu_read_lock() and srcu_read_unlock() have srcu_lock_acquire() an=
d
> srcu_lock_release() calls, so I am surprised that lockdep didn't complain
> when you invoked srcu_read_lock() from task context and srcu_read_unlock(=
)
> from a timer interrupt.

That's because I'm using __srcu_read_lock and __srcu_read_unlock ;)
See this part in kernel/events/uprobes.c:

/* __srcu_read_lock() because SRCU lock survives switch to user space */
srcu_idx =3D __srcu_read_lock(&uretprobes_srcu);

>
>                                                         Thanx, Paul
>
> > > + *
> > > + * Note that this_cpu_inc() is an RCU read-side critical section eit=
her
> > > + * because it disables interrupts, because it is a single instructio=
n,
> > > + * or because it is a read-modify-write atomic operation, depending =
on
> > > + * the whims of the architecture.
> > > + */
> > > +static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, =
struct srcu_ctr __percpu *scp)
> > > +{
> > > +       barrier();  /* Avoid leaking the critical section. */
> > > +       this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
> > > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching sr=
cu_read_unlock_fast().");
> > > +}
> > > +
> > >  /*
> > >   * Counts the new reader in the appropriate per-CPU element of the
> > >   * srcu_struct.  Returns an index that must be passed to the matchin=
g
> > > --
> > > 2.40.1
> > >

