Return-Path: <bpf+bounces-66103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88206B2E50D
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A38F5E3F52
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91C273803;
	Wed, 20 Aug 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OggKacs/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0C24EA90
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714801; cv=none; b=EoZrazHF10AoPsvNdkM3/bFJquVadG4SzITG9pdSrGxNXlV+2B2MppbPdsa5f/VZ2ZfSn3I2DLGER+vpc0VCXKAPk3qG0deLR6kpuXYZ5NCsGRKLfLZtLmo4+MuZQMQm5kypdtIL3meZHKutvUR+qD9mBoCUKmDWo8zf4su/VvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714801; c=relaxed/simple;
	bh=wTrSX4NUpEVg3bMnooB+V0WZZ2pYZI/FYLy4TXO8vqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgdPsnUZ8JgkAQF/81kOld/njtz8veqMwJEgYSTgLujZ7E4c6bY3doNvg1qWCabO9EVg6oX9iS4z31KkFbZ7igqbI/EazjQuPfTT6WBObtWWaDhdzXwbLvI04iqacywqNFlzgqAAcNjHTuVNy5mhwsYi7e0ixnxavOcJJbOHUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OggKacs/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-324e3a0482dso179953a91.2
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755714798; x=1756319598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsQOzqrLO4R4zyG+J42cXUvN/yKvkkXg4uZo/iGma6s=;
        b=OggKacs/YY/YhjD9h+3okfqY7nI/5E/P7A6fSOlV2Jr8d7Fgw5oxEJJpudqIDKLiFO
         p0AI5cHbo3yEui1zbr1Hbh5TppF6vDeDYMc1QBPMRVvBljflJ8qtT0+c75soZaoBlAw2
         kTG4Jzrvdeg7O02DyXmTfEB8VGdrKKTzNP7UdpDOG4qYf0ebNWnhCdkMuwVGChqjfeK6
         O5YRqWVk50OQj8XLH/IrjKA0tCNboVtcYUeMU59briPkRh7U7tRFaMCZO1x8QBDhnErr
         6J3JLbXURV7WsVYLYyHAiC2aUXNgbTs1k0W9lQGhRwb87AmpyAElLTTbK+ITYKDudx2u
         9PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755714798; x=1756319598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsQOzqrLO4R4zyG+J42cXUvN/yKvkkXg4uZo/iGma6s=;
        b=JgIO7BA3fAMSbqOTNqe+LprVjFdOSCTcBnTXjlvCuHTxnhBX4TX1Z/KRENDN7STqoD
         SbCFGQyy810D8ylxFAVlBrKyEpZ7KTEBCAbS33ff+twXhL7wXYkVMrcrYP4+Kf62MVRx
         dPWb5Nh1OB01KJmwGhoToRhR/jWaooFY6ZBevXva3Y1R/JGHlje+rTSZto59JdqJJcn0
         iOAjnq6l1zP+Xm4+mb2YBKGHqXNtRlMoXfkWzQi3vSv69XwSTN7VhZ9H+WVB+sPV/b2q
         2myiMXXEmjCX9bvQY/NIiesSdfmkY93QMDsteApNboUxA+LbS+e9vqfVlBBObKk1XCmv
         lxIA==
X-Forwarded-Encrypted: i=1; AJvYcCUDXwqVmuDDKTfQNpwRzszdQH5grZM426Gy7jgBKTFzm5X441p0ogonTzXWj8ihLYd69/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILhLR2pB/ZHhlVkGaeHg0Z3GVzq3YDWgltjV1SMejW7xF5AF1
	pB3ca/jR+9OdEVIlIA8btAndsG4En7yNXILGQVy7D3w7kyrGb7KI3KQX8Fe85nlxyBF+HWRFJUa
	eyO74qV8yG9FmycoemzOHkUBEr7aYTcadiA==
X-Gm-Gg: ASbGnctEH87gN/dBJayOCxCf36z1HGOlTCXw/+aCgAN2g9cDRzsf//UYYNI0QNMwVvW
	SRGPZrn8PfgzGI1Jny7N7UBYvY3iAL4Rb1A4NmqeX7zZTYUWNci4hfj7eOvaW44qSb8z8z7EcO3
	c9Z/pMtxhINh3lLUpeSx7jXHko8rXSMki9MWLik9e8MklvccoYMu5QaU2OCvDAF5CXUQ7v91+sQ
	76/kBfIH6kJBgp9baek9+eqL6H+5RF4uA==
X-Google-Smtp-Source: AGHT+IGMccKESFUd0FiLuZa/DSlzzTquJJPXSBYxqMiI8A54GxQAvPnt0Jn0epyVooYry3kaFeWpZibJ6C+Dq4X7piE=
X-Received: by 2002:a17:90b:2e0b:b0:31e:3bbc:e9e6 with SMTP id
 98e67ed59e1d1-324e1423f77mr5505161a91.19.1755714798284; Wed, 20 Aug 2025
 11:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
 <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com> <CAP01T74vkbS6yszqe4GjECJq=j5-V7ADde7D6wnTfw=zN8zJyw@mail.gmail.com>
 <CAEf4BzZPcawkrrdd2OoKLT-BWzCYsEpNxw52RKa6dL1B=xvdoA@mail.gmail.com> <CAP01T74gKna6WrgZvkoBBmwsbhrqrv4azeKwfk=frQasc9eaXQ@mail.gmail.com>
In-Reply-To: <CAP01T74gKna6WrgZvkoBBmwsbhrqrv4azeKwfk=frQasc9eaXQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 11:33:03 -0700
X-Gm-Features: Ac12FXy7FT7o6c4qCf7MNIsyOEU3m4HB4HfNgOO3kN-QhJLtfqaB9Ormn7HsmAU
Message-ID: <CAEf4BzZadH9NYkYSrgUvZAynBuG=t2TayhFPxzFzbWHsP8HCUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 9:12=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 19 Aug 2025 at 22:49, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Tue, Aug 19, 2025 at 12:28=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue, 19 Aug 2025 at 20:16, Mykyta Yatsenko
> > > <mykyta.yatsenko5@gmail.com> wrote:
> > > >
> > > > On 8/19/25 15:18, Kumar Kartikeya Dwivedi wrote:
> > > > > On Fri, 15 Aug 2025 at 21:22, Mykyta Yatsenko
> > > > > <mykyta.yatsenko5@gmail.com> wrote:
> > > > >> From: Mykyta Yatsenko <yatsenko@meta.com>
> > > > >>
> > > > >> Implementation of the bpf_task_work_schedule kfuncs.
> > > > >>
> > > > >> Main components:
> > > > >>   * struct bpf_task_work_context =E2=80=93 Metadata and state ma=
nagement per task
> > > > >> work.
> > > > >>   * enum bpf_task_work_state =E2=80=93 A state machine to serial=
ize work
> > > > >>   scheduling and execution.
> > > > >>   * bpf_task_work_schedule() =E2=80=93 The central helper that i=
nitiates
> > > > >> scheduling.
> > > > >>   * bpf_task_work_acquire() - Attempts to take ownership of the =
context,
> > > > >>   pointed by passed struct bpf_task_work, allocates new context =
if none
> > > > >>   exists yet.
> > > > >>   * bpf_task_work_callback() =E2=80=93 Invoked when the actual t=
ask_work runs.
> > > > >>   * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in =
softirq context)
> > > > >> to enqueue task work.
> > > > >>   * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for delete=
d BPF map entries.
> > > > > Can you elaborate on why the bouncing through irq_work context is=
 necessary?
> > > > > I think we should have this info in the commit log.
> > > > > Is it to avoid deadlocks with task_work locks and/or task->pi_loc=
k?
> > > > yes, mainly to avoid locks in NMI.
> > > > >
> > > > >> Flow of successful task work scheduling
> > > > >>   1) bpf_task_work_schedule_* is called from BPF code.
> > > > >>   2) Transition state from STANDBY to PENDING, marks context is =
owned by
> > > > >>   this task work scheduler
> > > > >>   3) irq_work_queue() schedules bpf_task_work_irq().
> > > > >>   4) Transition state from PENDING to SCHEDULING.
> > > > >>   4) bpf_task_work_irq() attempts task_work_add(). If successful=
, state
> > > > >>   transitions to SCHEDULED.
> > > > >>   5) Task work calls bpf_task_work_callback(), which transition =
state to
> > > > >>   RUNNING.
> > > > >>   6) BPF callback is executed
> > > > >>   7) Context is cleaned up, refcounts released, context state se=
t back to
> > > > >>   STANDBY.
> > > > >>
> > > > >> bpf_task_work_context handling
> > > > >> The context pointer is stored in bpf_task_work ctx field (u64) b=
ut
> > > > >> treated as an __rcu pointer via casts.
> > > > >> bpf_task_work_acquire() publishes new bpf_task_work_context by c=
mpxchg
> > > > >> with RCU initializer.
> > > > >> Read under the RCU lock only in bpf_task_work_acquire() when own=
ership
> > > > >> is contended.
> > > > >> Upon deleting map value, bpf_task_work_cancel_and_free() is deta=
ching
> > > > >> context pointer from struct bpf_task_work and releases resources
> > > > >> if scheduler does not own the context or can be canceled (state =
=3D=3D
> > > > >> STANDBY or state =3D=3D SCHEDULED and callback canceled). If tas=
k work
> > > > >> scheduler owns the context, its state is set to FREED and schedu=
ler is
> > > > >> expected to cleanup on the next state transition.
> > > > >>
> > > > >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > >> ---
> > > > > This is much better now, with clear ownership between free path a=
nd
> > > > > scheduling path, I mostly have a few more comments on the current
> > > > > implementation, plus one potential bug.
> > > > >
> > > > > However, the more time I spend on this, the more I feel we should
> > > > > unify all this with the two other bpf async work execution mechan=
isms
> > > > > (timers and wq), and simplify and deduplicate a lot of this under=
 the
> > > > > serialized async->lock. I know NMI execution is probably critical=
 for
> > > > > this primitive, but we can replace async->lock with rqspinlock to
> > > > > address that, so that it becomes safe to serialize in any context=
.
> > > > > Apart from that, I don't see anything that would negate reworking=
 all
> > > > > this as a case of BPF_TASK_WORK for bpf_async_kern, modulo intern=
al
> > > > > task_work locks that have trouble with NMI execution (see later
> > > > > comments).
> > > > >
> > > > > I also feel like it would be cleaner if we split the API into 3 s=
teps:
> > > > > init(), set_callback(), schedule() like the other cases, I don't =
see
> > > > > why we necessarily need to diverge, and it simplifies some of the
> > > > > logic in schedule().
> > > > > Once every state update is protected by a lock, all of the state
> > > > > transitions are done automatically and a lot of the extra races a=
re
> > > > > eliminated.
> > > > >
> > > > > I think we should discuss whether this was considered and why you
> > > > > discarded this approach, otherwise the code is pretty complex, wi=
th
> > > > > little upside.
> > > > > Maybe I'm missing something obvious and you'd know more since you=
've
> > > > > thought about all this longer.
> > > > As for API, I think having 1 function for scheduling callback is cl=
eaner
> > > > then having 3 which are always called in the same order anyway. Mos=
t of
> > > > the complexity
> > > > comes from synchronization, not logic, so not having to do the same
> > > > synchronization in
> > > > init(), set_callback() and schedule() seems like a benefit to me.
> > >
> > > Well, if you were to reuse bpf_async_kern, all of that extra logic is
> > > already taken care of, or can be easily shared.
> > > If you look closely you'll see that a lot of what you're doing is a
> > > repetition of what timers and bpf_wq have.
> > >
> > > > Let me check if using rqspinlock going to make things simpler. We s=
till
> > > > need states to at least know if cancellation is possible and to fla=
g
> > > > deletion to scheduler, but using a lock will make code easier to
> > > > understand.
> > >
> > > Yeah I think for all of this using lockless updates is not really
> > > worth it, let's just serialize using a lock.
> >
> > I don't think it's "just serialize".
> >
> > __bpf_async_init and __bpf_async_set_callback currently have `if
> > (in_nmi()) return -EOPNOTSUPP;`, because of `bpf_map_kmalloc_node`
> > (solvable with bpf_mem_alloc, not a big deal) and then unconditional
> > `__bpf_spin_lock_irqsave(&async->lock);` (and maybe some other things
> > that can't be done in NMI).
> >
> > We can't just replace __bpf_spin_lock_irqsave with rqspinlock, because
> > the latter can fail. So the simplicity of unconditional locking is
> > gone. We'd need to deal with the possibility of lock failing. It's
> > probably not that straightforward in the case of
> > __bpf_async_cancel_and_free.
>
> We discussed converting async_cb to rqspinlock last time, the hold up
> was __bpf_async_cancel_and_free, every other case can propagate error
> upwards since they're already fallible.
>
> The only reason I didn't move ahead was there was no apparent use case
> for timer usage in NMI (to me at least).

Scheduling some time-delayed action from perf_event/kprobe (with both
could be in NMI) seems like a reasonable thing to expect to work. So
I'd say there is a need for NMI support even without task_work.

>
> But I don't see why it's less simpler in other cases, you need to
> return an error in case you fail to take the lock (which should not
> occur in correct usage), yes, but once you take the lock nobody
> is touching the object anymore. And all those paths are already

Either you are oversimplifying or I'm over complicating.. :) Even when
BPF program started the process to schedule task work, which is
multi-step process (STANDBY -> PENDING -> SCHEDULING/SCHEDULED ->
RUNNING -> STANDBY), at each step you need to take lock. Meanwhile,
nothing prevents other BPF program executions to try (and successfully
do) take the same lock (that might be logical bug, or just how user
decided to handle, or rather disregard, locking). While it holds it,
callback might start running, it would need to take lock and won't be
for some time. Maybe that time is short and we won't run into
EDEADLOCK, but maybe it's not (and yes, that wouldn't be expected, but
it's not impossible either).

Similarly with cancel_and_free. That can be triggered by delete/update
which can happen simultaneously on multiple CPUs.

But even thinking through and proving that lock in cancel_and_free
will definitely be successfully taking (while interface itself screams
at you that it might not), is complication enough that I'd rather not
have to think through and deal with.

So I still maintain that atomic state transitions is a simpler model
to prove is working as expected and reliably.

When you think about it, it's really a linear transition through a few
stages (STANDBY -> PENDING -> ... -> RUNNING -> STANDBY), with the
only "interesting" interaction that we can go to FREED at any stage.
But when we do go to FREED, all participating parties know
deterministically where we were and who's responsible for clean up.

So in summary, I think it's good for you to try to switch timer and wq
to rqspinlock and work out all the kinds, but I'd prefer not to block
task_work on this work and proceed with state machine approach.


> fallible, so it's an extra error condition.
>
> It is possible to then focus our effort on understanding failure modes
> where __bpf_async_cancel_and_free's lock acquisition can fail, the
> last time I looked it wasn't possible (otherwise we already have a bug
> with the existing spin lock).
>
> That said, BPF timers cannot be invoked in NMI, and irqsave provides
> interrupt exclusion. We exclude usage of maps with timers in programs
> that may run in NMI context. Things will be different once that restricti=
on is
> lifted for task_work, but it just means if the lock acquisition is failin=
g on a
> single lock, a lower context we interrupted is holding it, which means
> it won the claim to free the object and we don't need to do anything.
> Since we have a single lock the cases we need to actively worry about
> are the reentrant ones.
>
> I can imagine a task context program updating an array map element,
> which invoked bpf_obj_free_fields, and then a perf program attempting
> to do the same thing on the same element from an NMI. Fine, the lock
> acquisition in free will fail, but we understand why it's ok to give up t=
he
> free in such a case.
>

This "fine to give up free" doesn't sound neither obvious, nor simple,
and will require no less thinking and care than what you'd need to
understand that state machine we discussed for task_work, IMO.

> >
> > On the other hand, state machine with cmpxchg means there is always
> > forward progress and there is always determinism of what was the last
> > reached state before we went to FREED state, which means we will know
> > who needs to cancel callback (if at all), and who is responsible for
> > freeing resources.
>
> There is forward progress regardless (now), but with a lockless state
> machine, every state transition needs to consider various edges which
> may have been concurrently activated by some other racing invocation.
> You don't have such concerns with a lock. At least to me, I don't see

We still do have concurrency, lock doesn't magically solve that for
us. While you are cancelling/freeing callback might be running or is
about to run and you can't really cancel it. All that still would need
to be handled and thought through.

> how the latter is worse than the former, it's less cases to think
> about and deal with in the code.
> E.g. all these "state =3D=3D BPF_TW_FREED" would go away at various place=
s
> in the middle of various operations.

I don't think so, see above. You are oversimplifying. But again,
please try to do this conversion for timer and wq, it's worthwhile to
do regardless of task_work.

>
> To me after looking at this code the second time, there seems to be
> little benefit. Things would be different if multiple concurrent
> schedule() calls on the same map value was a real use case, such that
> lock contention would quickly become a performance bottleneck, but I
> don't think that's true.
>
> >
> > I'm actually wondering if this state machine approach could/should be
> > adopted for bpf_async_cb?.. I wouldn't start there, though, and rather
> > finish task_work_add integration before trying to generalize.
>
> Maybe it's just me, but I feel like it's additional complexity that's
> not giving us much benefit.
>
> There are enough things to worry about even when holding a lock and
> excluding NMI, as seen with various bugs over the years.
> E.g. git log --oneline --grep=3D"Fixes: b00628b1c7d5 (\"bpf: Introduce
> bpf timers.\")"
>
> It is impossible to say that we can get it right with all this in the
> 1st attempt, even if we hold a fallible lock to avoid deadlocks, or we
> switch to this state machine approach.
> The best we can do is to at least minimize the set of cases we have to
> worry about.
>
> [
>    As an aside, if we intend on keeping the door open on
> consolidation, we probably should at least mirror the API surface.
>    Maybe we made a mistake with init+set_callback+kick style split in
> existing APIs, but it might be easier for people to understand that
> all async primitives mostly follow this look and feel.
>    It wouldn't be the end of the world, but there's an argument to be
> made for consistency.
> ]

I don't see why we can't consolidate internals of all these async
callbacks while maintaining a user-facing API that makes most sense
for each specific case. For task_work (and yes, I think for timers it
would make more sense as well), we are talking about a single
conceptual operation: just schedule a callback. So it makes sense to
have a single kfunc that expresses that.

Having a split into init, set_callback, kick is unnecessary and
cumbersome. It also adds additional mental overhead to think about
interleave of those three invocations from two or more concurrent BPF
programs (I'm not saying it doesn't work correctly in current
implementation, but it's another thing to think about in three
helpers/kfuncs, rather than in just one: that you can't have init done
by prog A, set_callback by prog B, and kick off be either prog A or B,
or even some other C program execution).

I'm guessing we modeled timer in such a way because we tried to stick
to kernel-internal API (and maybe we were trying to fit into 5
argument limitations, not sure). This makes sense internally in the
kernel, where you have different ways to init timer struct, different
ways to set or update expiration, etc, etc. This is not the case for
the BPF-side API of timer (but what's done is done, we can't just undo
it).

And for task_work_add(), even kernel-internal API is a singular
function, which makes most sense, so I'd like to stick to that
simplicity.

