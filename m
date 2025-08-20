Return-Path: <bpf+bounces-66097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C4B2E218
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 18:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4A818839C2
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B7322DBE;
	Wed, 20 Aug 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD1xYEjK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EBE322A06
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706324; cv=none; b=EAZJvXseafljZ7BcR0hyWTwmMQf6bwIEqQLS6kdcY+sDLYLPiYHfBR90y0jbSoaVwcpSXScul70osXycMAhAu10wLVhGmG0bsWDlRGG38QtbeLqcgjCgVU4fzyDZj3vIgzWwynk6qYKa3sqATLk3L6YPD02jaweEwqVUog8eguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706324; c=relaxed/simple;
	bh=MY0Hd3y6NdvzdkZb/NFTSD3EBgdYJkMvqCSsjm27ghc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3OXiBs3cwCaDZmi25ewDxp3a3n2AJeRVVSnrzdGClQ9YV0h4tC7wajpkhwoHBzIcH9XerCbTxylLkbexmNk9xPivNRDAmxhYZMcav4xIMOuUiwoImnEP78OZ5OSfQ0NT7Zvd7N70fOu54EytyiRNyj2RJ2uDpS64abj2Hgl1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD1xYEjK; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb7ace3baso4914266b.3
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755706321; x=1756311121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbo7Ez0Us3zOEQ+9DRj2z+nsDLGB4mQVsw7vtdDL2js=;
        b=dD1xYEjKob3FpDs8GxK1z3/cTn1LNj12ohGyTpatiLRZ0lb+8+xqoglKvm1Q1l4/0w
         rtWhzSvc+WO6fh0NxZgoTnuE9E3gwybf1b2zY+2Klr54xyCKGqKBm6QgCxASXJhHQ4cq
         ovX43UMeVUInhSMWvtmkexKQglgbPv+3A+3pB2QKS2+mmYZP18GsPC0rkQVBebKmArkB
         8gxeHKeItGBh2YcR5bVqYoT7xJ3tkedVUHrSR8HWty1fi1Hu+Kq7eGyre6EFsAJKYmvv
         sqLbczETPBL4ml054cuiJjhk52czmLamQ/6f/eKnOtSmU0h9Js4WzI02T0Gb/AU9rNQW
         524w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706321; x=1756311121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbo7Ez0Us3zOEQ+9DRj2z+nsDLGB4mQVsw7vtdDL2js=;
        b=jeNFjiUnOmWPK7Zdr1TpZ55GiyVVvZHsjVHk3jkyLGN++P0j0jvWL6Hvdiu3oOo6av
         phyFUKCkU9gSB+/maFI1ARgzbIXctPTKxpoSiSd1E+AYM3fobzs4c0gdCjZydpOojf7m
         ZxbfSWVHJRXuwt/bO6lKj3frv5TWPRGFvBAoZR7DygW2j3WMPG4bdMbPLjHDCvJeuGfq
         +FTj3NzY+aPDnpXRblrMGLHYsVJ/sXlCHbMG4QGOxKdUQSFLhBhT8/7yMqKD/o8CUkxB
         JCDe9BlwcUrUk2UBAV9/ipeF+jgkZNXBfo9v1bLzIxtP1ldOKcTwcqgYyG6lO6Dzi6/O
         3qlg==
X-Forwarded-Encrypted: i=1; AJvYcCWnUrdVKyVLhGMuDCqg1paQGwM9zdNfEbu9obdyyoboF6mMMhEindCxkr6asIN7Jy/fciQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHoYj1YwZ5ku0vYlMcol3isfHiV0+KQdIyA+nAwEb62mMlDLVQ
	BEdI8AYG/z8hfrfyHPAo90MDIkdSfVz2G+hBdmHlm8HuN05eu3r93wlShZHsRO7K0+Jp+U4g4nO
	S96oYhYW2P4ZlCN3RCW9oGScCkxtte+Rvai9H
X-Gm-Gg: ASbGncvF8fOd4rP77eqf0FLaOqzUUnD7Cbtq7JIXDHcFjk85FrzkB40JZE45shsAdtp
	YOqCvyN6PW3/m5tKUHiV2YPRZji4LkfPp6R+stPwim5ZxxNz+Z9Aexy4MOpEl3CvuPWM7aLXrT0
	9Jjp5JPi2M9UiI+5D+AUYHoWS7uZyhIz2ZYorNxQm72F1eDdZ8fyxad3UDzvaFVkvTySIHCQNxo
	u3u/yO3Vk5/lOJM0imh
X-Google-Smtp-Source: AGHT+IE93kgfaozC4PKNjupZst6foS/SrtkMxQFIaElXndaz5rwEq/KN5/6rivE0IRwhIVlZdoRDKl/5AO/rRmc5mqQ=
X-Received: by 2002:a17:907:2daa:b0:afa:1453:6635 with SMTP id
 a640c23a62f3a-afdf01d1c75mr312967266b.41.1755706320335; Wed, 20 Aug 2025
 09:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
 <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com> <CAP01T74vkbS6yszqe4GjECJq=j5-V7ADde7D6wnTfw=zN8zJyw@mail.gmail.com>
 <CAEf4BzZPcawkrrdd2OoKLT-BWzCYsEpNxw52RKa6dL1B=xvdoA@mail.gmail.com>
In-Reply-To: <CAEf4BzZPcawkrrdd2OoKLT-BWzCYsEpNxw52RKa6dL1B=xvdoA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 20 Aug 2025 18:11:23 +0200
X-Gm-Features: Ac12FXzEVAVKhZNHZ80LekLU-zzETBZFf8jt0bt3VsnmG-PM3hjiKPvYNVwQbwc
Message-ID: <CAP01T74gKna6WrgZvkoBBmwsbhrqrv4azeKwfk=frQasc9eaXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Aug 2025 at 22:49, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Tue, Aug 19, 2025 at 12:28=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, 19 Aug 2025 at 20:16, Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > On 8/19/25 15:18, Kumar Kartikeya Dwivedi wrote:
> > > > On Fri, 15 Aug 2025 at 21:22, Mykyta Yatsenko
> > > > <mykyta.yatsenko5@gmail.com> wrote:
> > > >> From: Mykyta Yatsenko <yatsenko@meta.com>
> > > >>
> > > >> Implementation of the bpf_task_work_schedule kfuncs.
> > > >>
> > > >> Main components:
> > > >>   * struct bpf_task_work_context =E2=80=93 Metadata and state mana=
gement per task
> > > >> work.
> > > >>   * enum bpf_task_work_state =E2=80=93 A state machine to serializ=
e work
> > > >>   scheduling and execution.
> > > >>   * bpf_task_work_schedule() =E2=80=93 The central helper that ini=
tiates
> > > >> scheduling.
> > > >>   * bpf_task_work_acquire() - Attempts to take ownership of the co=
ntext,
> > > >>   pointed by passed struct bpf_task_work, allocates new context if=
 none
> > > >>   exists yet.
> > > >>   * bpf_task_work_callback() =E2=80=93 Invoked when the actual tas=
k_work runs.
> > > >>   * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in so=
ftirq context)
> > > >> to enqueue task work.
> > > >>   * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted =
BPF map entries.
> > > > Can you elaborate on why the bouncing through irq_work context is n=
ecessary?
> > > > I think we should have this info in the commit log.
> > > > Is it to avoid deadlocks with task_work locks and/or task->pi_lock?
> > > yes, mainly to avoid locks in NMI.
> > > >
> > > >> Flow of successful task work scheduling
> > > >>   1) bpf_task_work_schedule_* is called from BPF code.
> > > >>   2) Transition state from STANDBY to PENDING, marks context is ow=
ned by
> > > >>   this task work scheduler
> > > >>   3) irq_work_queue() schedules bpf_task_work_irq().
> > > >>   4) Transition state from PENDING to SCHEDULING.
> > > >>   4) bpf_task_work_irq() attempts task_work_add(). If successful, =
state
> > > >>   transitions to SCHEDULED.
> > > >>   5) Task work calls bpf_task_work_callback(), which transition st=
ate to
> > > >>   RUNNING.
> > > >>   6) BPF callback is executed
> > > >>   7) Context is cleaned up, refcounts released, context state set =
back to
> > > >>   STANDBY.
> > > >>
> > > >> bpf_task_work_context handling
> > > >> The context pointer is stored in bpf_task_work ctx field (u64) but
> > > >> treated as an __rcu pointer via casts.
> > > >> bpf_task_work_acquire() publishes new bpf_task_work_context by cmp=
xchg
> > > >> with RCU initializer.
> > > >> Read under the RCU lock only in bpf_task_work_acquire() when owner=
ship
> > > >> is contended.
> > > >> Upon deleting map value, bpf_task_work_cancel_and_free() is detach=
ing
> > > >> context pointer from struct bpf_task_work and releases resources
> > > >> if scheduler does not own the context or can be canceled (state =
=3D=3D
> > > >> STANDBY or state =3D=3D SCHEDULED and callback canceled). If task =
work
> > > >> scheduler owns the context, its state is set to FREED and schedule=
r is
> > > >> expected to cleanup on the next state transition.
> > > >>
> > > >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > >> ---
> > > > This is much better now, with clear ownership between free path and
> > > > scheduling path, I mostly have a few more comments on the current
> > > > implementation, plus one potential bug.
> > > >
> > > > However, the more time I spend on this, the more I feel we should
> > > > unify all this with the two other bpf async work execution mechanis=
ms
> > > > (timers and wq), and simplify and deduplicate a lot of this under t=
he
> > > > serialized async->lock. I know NMI execution is probably critical f=
or
> > > > this primitive, but we can replace async->lock with rqspinlock to
> > > > address that, so that it becomes safe to serialize in any context.
> > > > Apart from that, I don't see anything that would negate reworking a=
ll
> > > > this as a case of BPF_TASK_WORK for bpf_async_kern, modulo internal
> > > > task_work locks that have trouble with NMI execution (see later
> > > > comments).
> > > >
> > > > I also feel like it would be cleaner if we split the API into 3 ste=
ps:
> > > > init(), set_callback(), schedule() like the other cases, I don't se=
e
> > > > why we necessarily need to diverge, and it simplifies some of the
> > > > logic in schedule().
> > > > Once every state update is protected by a lock, all of the state
> > > > transitions are done automatically and a lot of the extra races are
> > > > eliminated.
> > > >
> > > > I think we should discuss whether this was considered and why you
> > > > discarded this approach, otherwise the code is pretty complex, with
> > > > little upside.
> > > > Maybe I'm missing something obvious and you'd know more since you'v=
e
> > > > thought about all this longer.
> > > As for API, I think having 1 function for scheduling callback is clea=
ner
> > > then having 3 which are always called in the same order anyway. Most =
of
> > > the complexity
> > > comes from synchronization, not logic, so not having to do the same
> > > synchronization in
> > > init(), set_callback() and schedule() seems like a benefit to me.
> >
> > Well, if you were to reuse bpf_async_kern, all of that extra logic is
> > already taken care of, or can be easily shared.
> > If you look closely you'll see that a lot of what you're doing is a
> > repetition of what timers and bpf_wq have.
> >
> > > Let me check if using rqspinlock going to make things simpler. We sti=
ll
> > > need states to at least know if cancellation is possible and to flag
> > > deletion to scheduler, but using a lock will make code easier to
> > > understand.
> >
> > Yeah I think for all of this using lockless updates is not really
> > worth it, let's just serialize using a lock.
>
> I don't think it's "just serialize".
>
> __bpf_async_init and __bpf_async_set_callback currently have `if
> (in_nmi()) return -EOPNOTSUPP;`, because of `bpf_map_kmalloc_node`
> (solvable with bpf_mem_alloc, not a big deal) and then unconditional
> `__bpf_spin_lock_irqsave(&async->lock);` (and maybe some other things
> that can't be done in NMI).
>
> We can't just replace __bpf_spin_lock_irqsave with rqspinlock, because
> the latter can fail. So the simplicity of unconditional locking is
> gone. We'd need to deal with the possibility of lock failing. It's
> probably not that straightforward in the case of
> __bpf_async_cancel_and_free.

We discussed converting async_cb to rqspinlock last time, the hold up
was __bpf_async_cancel_and_free, every other case can propagate error
upwards since they're already fallible.

The only reason I didn't move ahead was there was no apparent use case
for timer usage in NMI (to me at least).

But I don't see why it's less simpler in other cases, you need to
return an error in case you fail to take the lock (which should not
occur in correct usage), yes, but once you take the lock nobody
is touching the object anymore. And all those paths are already
fallible, so it's an extra error condition.

It is possible to then focus our effort on understanding failure modes
where __bpf_async_cancel_and_free's lock acquisition can fail, the
last time I looked it wasn't possible (otherwise we already have a bug
with the existing spin lock).

That said, BPF timers cannot be invoked in NMI, and irqsave provides
interrupt exclusion. We exclude usage of maps with timers in programs
that may run in NMI context. Things will be different once that restriction=
 is
lifted for task_work, but it just means if the lock acquisition is failing =
on a
single lock, a lower context we interrupted is holding it, which means
it won the claim to free the object and we don't need to do anything.
Since we have a single lock the cases we need to actively worry about
are the reentrant ones.

I can imagine a task context program updating an array map element,
which invoked bpf_obj_free_fields, and then a perf program attempting
to do the same thing on the same element from an NMI. Fine, the lock
acquisition in free will fail, but we understand why it's ok to give up the
free in such a case.

>
> On the other hand, state machine with cmpxchg means there is always
> forward progress and there is always determinism of what was the last
> reached state before we went to FREED state, which means we will know
> who needs to cancel callback (if at all), and who is responsible for
> freeing resources.

There is forward progress regardless (now), but with a lockless state
machine, every state transition needs to consider various edges which
may have been concurrently activated by some other racing invocation.
You don't have such concerns with a lock. At least to me, I don't see
how the latter is worse than the former, it's less cases to think
about and deal with in the code.
E.g. all these "state =3D=3D BPF_TW_FREED" would go away at various places
in the middle of various operations.

To me after looking at this code the second time, there seems to be
little benefit. Things would be different if multiple concurrent
schedule() calls on the same map value was a real use case, such that
lock contention would quickly become a performance bottleneck, but I
don't think that's true.

>
> I'm actually wondering if this state machine approach could/should be
> adopted for bpf_async_cb?.. I wouldn't start there, though, and rather
> finish task_work_add integration before trying to generalize.

Maybe it's just me, but I feel like it's additional complexity that's
not giving us much benefit.

There are enough things to worry about even when holding a lock and
excluding NMI, as seen with various bugs over the years.
E.g. git log --oneline --grep=3D"Fixes: b00628b1c7d5 (\"bpf: Introduce
bpf timers.\")"

It is impossible to say that we can get it right with all this in the
1st attempt, even if we hold a fallible lock to avoid deadlocks, or we
switch to this state machine approach.
The best we can do is to at least minimize the set of cases we have to
worry about.

[
   As an aside, if we intend on keeping the door open on
consolidation, we probably should at least mirror the API surface.
   Maybe we made a mistake with init+set_callback+kick style split in
existing APIs, but it might be easier for people to understand that
all async primitives mostly follow this look and feel.
   It wouldn't be the end of the world, but there's an argument to be
made for consistency.
]



>
> [...]
>
> > > > This part looks broken to me.
> > > > You are calling this path
> > > > (update->obj_free_fields->cancel_and_free->cancel_and_match) in
> > > > possibly NMI context.
> > > > Which means we can deadlock if we hit the NMI context prog in the
> > > > middle of task->pi_lock critical section.
> > > > That's taken in task_work functions
> > > > The task_work_cancel_match takes the pi_lock.
> > > Good point, thanks. I think this could be solved in 2 ways:
> > >   * Don't cancel, rely on callback dropping the work
> > >   * Cancel in another irq_work
> > > I'll probably go with the second one.
> >
> > What about 1? It seems like we can just rely on the existing hunk to
> > free the callback on noticing BPF_TW_FREED?
> > That seems simpler to me.
> >
>
> Callback potentially might not be called for a long time, I'd feel
> uneasy relying on it being called soon. Mykyta does irq_work in
> scheduling kfunc for the reason that it might need to cancel task work
> (because that doesn't support NMI), we can reuse the same approach
> (and same irq work struct) here for cancellation, probably?
>
>
> [...]

