Return-Path: <bpf+bounces-66041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E6BB2CE47
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1695A7AAEEA
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B3343202;
	Tue, 19 Aug 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8ofXqNp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6F20A5E5
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636569; cv=none; b=dsK+JxZQqHWv8mBhJX1RNGxxSaYNPtBWIfBI/QoT8a+8C8944kJkhSfIpU4Q3RQbYxKGCj/gfggdVgVLozPxQWuth8dtWkoeyi5qVFx0STPvRY4vTj4EDsxlCgPalkcLcNx3Z8KoFh3oXHcFPpJf911amI/g/UeuBSiP2UHIArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636569; c=relaxed/simple;
	bh=3yp4bGPiUe2Uj5fpteWtVDalOLZXpYYQsI7ry7VKaF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEdZ8rld603VKl/yJ4gefBuYG2TXyZX58BhcPyRcrZYFERya++tOxURGflEdx4W4mA4LeH30sheLPl+hoWFjRNP0DScrqKI4BNm7MfK4vaU0aO9PG+43An709krO5nWfmD/vNzffiJBWaXHZvP36t3yW1gfcrK9iXi1AsW2PF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8ofXqNp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266cdf64so4549623a91.0
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636567; x=1756241367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26xx+b7SpPzpqaqVvQW+hU+Im4N2Yr4H8OQiI5jF3ZQ=;
        b=c8ofXqNpjBQUcSOUZPkPIQZOLBbcx6s0RQ+7eM2eHzIiTAX01E/+BC8qyn2y/nhDwn
         01sSUG3kBTmkQkoKHcU3CYkejurS6E0xtI6DfErjAAV2OYld1MaWrGdJpX9A7TYlFpl9
         7zhD0Op9RSJWGuRv+aYHqICb+fWt3Q4kZI4oh32lac52X5hr7K0TZZto46hvLFp26wzu
         AJ00KQ9R9xJedz2MQPNYJRD0JUb9dV6LJrBHgX/Kmy+wJfeB7mfFGizgBElCRwUXtA8t
         RIetgod8w3up1m41lBiHkfF42acWtvYKpf7L7xd+sEPRS7fwrkCqsgxz9LSquHA/nG5i
         HDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636567; x=1756241367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26xx+b7SpPzpqaqVvQW+hU+Im4N2Yr4H8OQiI5jF3ZQ=;
        b=tkL7x3IhHNAKqDw/fRVDBuDl/QY6oO5MMs0GdLzUUgtDMPLoedZEm6wDLQRXoa3NV/
         F4hXfUy8ewSpcgGGe3LC0m2GxeP7TkL9a8qvfLCVhHnlJUtlLdXPqsB29LuCoQC1s6Zt
         Rha0BigFFUbcHfvHkQswq4YfpvwnlmhqhadKrYMCAisTQc3PnM+8quuSYtP8pmFL8KZ/
         qhMY04r7tx0+MnfaiYt6aOoaU7na0m48niTM75h3uTYAQm1wbdTWGplU+M3TxZSvWd+h
         Ht89xKwT8V9Ew0C1K9WyF1WP7O5loVffMG3KYLPAiz7SFr/b2sbRelNANSx02FimG5j8
         KsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF4fxDhmUgJ2rDT/ZSzVI3u2riMDYGKGmSy1i+8p1HvevC2MIFRE3mZL13fRky01U+SoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu23BeE2UyW+cbeOi7GBruJefPYm/vd3q1WtBtAq3rBzCNBHyn
	kIx465HHCW87mbVq4erxaBnTF6foFb/AM3lT6dhbTrF5no1i5l2Q5W8vpNW8vBGadihmI4aCI+b
	Tqw4eyrtTsqMOH1EO/VgpSDXoXb13+8ibi3/u
X-Gm-Gg: ASbGnctHGH/4qw+xjJN2haNqrCX2tMdv9lqhfQsnPL93L4uhrEKCmh2TzmQB97YUJTy
	g7gllCZ2IUz1iA/HkXIrZA+L6aLFcyXnPRufIfGNTBImp4OyLh++Vbd61M2IoVa+ypopHRpbsMS
	qIAOa0Tp6QVH0ZT77DZrJG4nfveMBruD27zuPNhOnLk8b6sLM1z8VoPeO5Kqn92MZz80wQnU32M
	L3lSj50IEFvgg32LvodbvI=
X-Google-Smtp-Source: AGHT+IEQVy3dYseejJjqHFYW4573xbvXk12KH+CHHrR5z6G2OKcLDsIfN2Ni5xm1iMUq0gJOSQ6N3ZuEy92RKBER6Dk=
X-Received: by 2002:a17:90b:3f46:b0:311:f99e:7f57 with SMTP id
 98e67ed59e1d1-324e143ef31mr692576a91.23.1755636567316; Tue, 19 Aug 2025
 13:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
 <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com> <CAP01T74vkbS6yszqe4GjECJq=j5-V7ADde7D6wnTfw=zN8zJyw@mail.gmail.com>
In-Reply-To: <CAP01T74vkbS6yszqe4GjECJq=j5-V7ADde7D6wnTfw=zN8zJyw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Aug 2025 13:49:12 -0700
X-Gm-Features: Ac12FXwFa0KR5oj5VE7Yq6FAqr71EtCElmi2y4gCQ4k_hrYlaCbsGR2wu6xtlAQ
Message-ID: <CAEf4BzZPcawkrrdd2OoKLT-BWzCYsEpNxw52RKa6dL1B=xvdoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 12:28=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 19 Aug 2025 at 20:16, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > On 8/19/25 15:18, Kumar Kartikeya Dwivedi wrote:
> > > On Fri, 15 Aug 2025 at 21:22, Mykyta Yatsenko
> > > <mykyta.yatsenko5@gmail.com> wrote:
> > >> From: Mykyta Yatsenko <yatsenko@meta.com>
> > >>
> > >> Implementation of the bpf_task_work_schedule kfuncs.
> > >>
> > >> Main components:
> > >>   * struct bpf_task_work_context =E2=80=93 Metadata and state manage=
ment per task
> > >> work.
> > >>   * enum bpf_task_work_state =E2=80=93 A state machine to serialize =
work
> > >>   scheduling and execution.
> > >>   * bpf_task_work_schedule() =E2=80=93 The central helper that initi=
ates
> > >> scheduling.
> > >>   * bpf_task_work_acquire() - Attempts to take ownership of the cont=
ext,
> > >>   pointed by passed struct bpf_task_work, allocates new context if n=
one
> > >>   exists yet.
> > >>   * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_=
work runs.
> > >>   * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in soft=
irq context)
> > >> to enqueue task work.
> > >>   * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BP=
F map entries.
> > > Can you elaborate on why the bouncing through irq_work context is nec=
essary?
> > > I think we should have this info in the commit log.
> > > Is it to avoid deadlocks with task_work locks and/or task->pi_lock?
> > yes, mainly to avoid locks in NMI.
> > >
> > >> Flow of successful task work scheduling
> > >>   1) bpf_task_work_schedule_* is called from BPF code.
> > >>   2) Transition state from STANDBY to PENDING, marks context is owne=
d by
> > >>   this task work scheduler
> > >>   3) irq_work_queue() schedules bpf_task_work_irq().
> > >>   4) Transition state from PENDING to SCHEDULING.
> > >>   4) bpf_task_work_irq() attempts task_work_add(). If successful, st=
ate
> > >>   transitions to SCHEDULED.
> > >>   5) Task work calls bpf_task_work_callback(), which transition stat=
e to
> > >>   RUNNING.
> > >>   6) BPF callback is executed
> > >>   7) Context is cleaned up, refcounts released, context state set ba=
ck to
> > >>   STANDBY.
> > >>
> > >> bpf_task_work_context handling
> > >> The context pointer is stored in bpf_task_work ctx field (u64) but
> > >> treated as an __rcu pointer via casts.
> > >> bpf_task_work_acquire() publishes new bpf_task_work_context by cmpxc=
hg
> > >> with RCU initializer.
> > >> Read under the RCU lock only in bpf_task_work_acquire() when ownersh=
ip
> > >> is contended.
> > >> Upon deleting map value, bpf_task_work_cancel_and_free() is detachin=
g
> > >> context pointer from struct bpf_task_work and releases resources
> > >> if scheduler does not own the context or can be canceled (state =3D=
=3D
> > >> STANDBY or state =3D=3D SCHEDULED and callback canceled). If task wo=
rk
> > >> scheduler owns the context, its state is set to FREED and scheduler =
is
> > >> expected to cleanup on the next state transition.
> > >>
> > >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > >> ---
> > > This is much better now, with clear ownership between free path and
> > > scheduling path, I mostly have a few more comments on the current
> > > implementation, plus one potential bug.
> > >
> > > However, the more time I spend on this, the more I feel we should
> > > unify all this with the two other bpf async work execution mechanisms
> > > (timers and wq), and simplify and deduplicate a lot of this under the
> > > serialized async->lock. I know NMI execution is probably critical for
> > > this primitive, but we can replace async->lock with rqspinlock to
> > > address that, so that it becomes safe to serialize in any context.
> > > Apart from that, I don't see anything that would negate reworking all
> > > this as a case of BPF_TASK_WORK for bpf_async_kern, modulo internal
> > > task_work locks that have trouble with NMI execution (see later
> > > comments).
> > >
> > > I also feel like it would be cleaner if we split the API into 3 steps=
:
> > > init(), set_callback(), schedule() like the other cases, I don't see
> > > why we necessarily need to diverge, and it simplifies some of the
> > > logic in schedule().
> > > Once every state update is protected by a lock, all of the state
> > > transitions are done automatically and a lot of the extra races are
> > > eliminated.
> > >
> > > I think we should discuss whether this was considered and why you
> > > discarded this approach, otherwise the code is pretty complex, with
> > > little upside.
> > > Maybe I'm missing something obvious and you'd know more since you've
> > > thought about all this longer.
> > As for API, I think having 1 function for scheduling callback is cleane=
r
> > then having 3 which are always called in the same order anyway. Most of
> > the complexity
> > comes from synchronization, not logic, so not having to do the same
> > synchronization in
> > init(), set_callback() and schedule() seems like a benefit to me.
>
> Well, if you were to reuse bpf_async_kern, all of that extra logic is
> already taken care of, or can be easily shared.
> If you look closely you'll see that a lot of what you're doing is a
> repetition of what timers and bpf_wq have.
>
> > Let me check if using rqspinlock going to make things simpler. We still
> > need states to at least know if cancellation is possible and to flag
> > deletion to scheduler, but using a lock will make code easier to
> > understand.
>
> Yeah I think for all of this using lockless updates is not really
> worth it, let's just serialize using a lock.

I don't think it's "just serialize".

__bpf_async_init and __bpf_async_set_callback currently have `if
(in_nmi()) return -EOPNOTSUPP;`, because of `bpf_map_kmalloc_node`
(solvable with bpf_mem_alloc, not a big deal) and then unconditional
`__bpf_spin_lock_irqsave(&async->lock);` (and maybe some other things
that can't be done in NMI).

We can't just replace __bpf_spin_lock_irqsave with rqspinlock, because
the latter can fail. So the simplicity of unconditional locking is
gone. We'd need to deal with the possibility of lock failing. It's
probably not that straightforward in the case of
__bpf_async_cancel_and_free.

On the other hand, state machine with cmpxchg means there is always
forward progress and there is always determinism of what was the last
reached state before we went to FREED state, which means we will know
who needs to cancel callback (if at all), and who is responsible for
freeing resources.

I'm actually wondering if this state machine approach could/should be
adopted for bpf_async_cb?.. I wouldn't start there, though, and rather
finish task_work_add integration before trying to generalize.

[...]

> > > This part looks broken to me.
> > > You are calling this path
> > > (update->obj_free_fields->cancel_and_free->cancel_and_match) in
> > > possibly NMI context.
> > > Which means we can deadlock if we hit the NMI context prog in the
> > > middle of task->pi_lock critical section.
> > > That's taken in task_work functions
> > > The task_work_cancel_match takes the pi_lock.
> > Good point, thanks. I think this could be solved in 2 ways:
> >   * Don't cancel, rely on callback dropping the work
> >   * Cancel in another irq_work
> > I'll probably go with the second one.
>
> What about 1? It seems like we can just rely on the existing hunk to
> free the callback on noticing BPF_TW_FREED?
> That seems simpler to me.
>

Callback potentially might not be called for a long time, I'd feel
uneasy relying on it being called soon. Mykyta does irq_work in
scheduling kfunc for the reason that it might need to cancel task work
(because that doesn't support NMI), we can reuse the same approach
(and same irq work struct) here for cancellation, probably?


[...]

