Return-Path: <bpf+bounces-66032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA5FB2CCF8
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D61C24474
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F4326D5A;
	Tue, 19 Aug 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAwV2+PV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B26258ECE
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631693; cv=none; b=MCdvB2+pn/zcEfNwqGmvpOT96L+Pdd7V0UqWFEx4KNjYN2qYAae4wSBY7ZbJhvhykkQfIPRhhh/yBPtozOu55PmKiXlCtJMkSNo4Jamubb/DLvCr/tVKWNquHDMaUycHlqJqbI8uWy+vrP6F2Q6vbdkKXc0FdOYC3zc7wq004As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631693; c=relaxed/simple;
	bh=HKbJWfvJD9ZSBcsjPljGnIW+ocTrcxS1RipkYNP6yzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beF1wMAuEISpx/yCx9gGw5hBtH5UsKnP8IY5WrOLxtt1zFZxlDvwp34PHDHxoeUeh+fGxZs8mlu0RCUvK/d689vJyUBmuko/xgShnbz4P5UVjxpQms+yMZX0WgeOTszHjGCxqDs9YjadNY3Ogs94nU8ffnhGGU3GD1R5fvuQQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAwV2+PV; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-61a2a5b06cdso5388860a12.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755631688; x=1756236488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vHYVbQUYtx2SlBoSMUVPO3BNheimiz0l2deDweRqfo=;
        b=SAwV2+PVMv6pboCOgGA1HEjE6onAWvYLhdJbCaBwjPL/O6GgGW9IwIOnQ3hfy8bcAS
         qj22oc6OwvMhHhIyZwwoHei2qUZHtItPlO6m/YiHSODVWibNK3C9iR4uExqL1ODoNAGQ
         pHFJ7R4LOfs4TCjRinTTwA/o9Gs5N/wGgKVxnt/BcSlBYgBFRanCXJuA4xTInM7uL3I0
         jzuCjitRsKOjYr10S7F5U6MysDfXaMo5acxFsAPZ0HB1QmxeTnOwXRFVOJIt/tCQ55sD
         DF1ZHYJ6b1Lq64vJTNA1rZ7MtL+jtziDeqKytJ1JP3MTFEIiJRiv/9dxC0Igz+Lrn0KS
         gc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755631688; x=1756236488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vHYVbQUYtx2SlBoSMUVPO3BNheimiz0l2deDweRqfo=;
        b=wolEfQ5S7OPqogQ0jAHv46BfLMHI6S2BWorCZAqJPIHMFeb2EsEaamonWe00NYlkIB
         39ZkT71Gvik5ZVWEl/JliaSc+qfyi8XmD6KG1To30bgBqzwg5QNCskMSVO9DzbiGNSF1
         fFKkXIDkCiEZ03z3BT0suqwNCX04P225G7H/tagBI07aMD1YplrZNqeCO9hF+5uTLxoC
         Uf6uUzEomSUUgfVo+G53e2HhcU29qBmKiANiqIdk778BLSCmRt+UKS0fk2fc35SGW0LK
         PtP/Y1+haG86QRoaLKIv/JpQ7ApeMGv6OfhhSPyhy6d63/4pPHBBs9t1a2wfb9o+yh1H
         EPxg==
X-Gm-Message-State: AOJu0YwZuRcDlX6tNUdDuUR9CBPMefn8+7GrqVbzp8AzfVdtTJ5s9CuX
	5eLcyUgEAobh63CKnZqZLrtfn9jSKwDsA9dvp4XJVX4ErE9DzSl9TgfBezrBTevF1UcVJfIDE+T
	52ppvQLCnI5wH1OEa7xeoqqlWNeNztoE=
X-Gm-Gg: ASbGncs4WM7TeWvmQytC5FvyxR9K2tGzglNc3flO2ws4bwTF70lmblUujlqePwbDHPs
	aIRkCh8kOgNUdnKgeOYdBT7zPUg5PPXczD4v0pSppp7JzKvEVby6Ijw5zR0b0axLijNJLK1sxBh
	swT8z/QFe23dWoFrLZ7/A61L+mSfK6nfEw4VSStmIzCTb/gNAK1XrLEekBj0ejVsSuSv9n2Id1M
	2IXHNoZ
X-Google-Smtp-Source: AGHT+IHjq6qWMkMZ26U6+Z8+8lQl3JgC3BuHJQjqn747nEpDWeXN3wszP38iRLZjlLDD5R+lFv66D8poOiiehArOaak=
X-Received: by 2002:a05:6402:13c1:b0:61a:8c7c:a1f0 with SMTP id
 4fb4d7f45d1cf-61a97544f7emr419691a12.11.1755631687574; Tue, 19 Aug 2025
 12:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
 <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com>
In-Reply-To: <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 19 Aug 2025 21:27:31 +0200
X-Gm-Features: Ac12FXxY3gliUIMSFoetHkPU7yxPQgliIyF6fPHQvg6RS6Vf7Q5-kfLTCDLbiw8
Message-ID: <CAP01T74vkbS6yszqe4GjECJq=j5-V7ADde7D6wnTfw=zN8zJyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Aug 2025 at 20:16, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 8/19/25 15:18, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 15 Aug 2025 at 21:22, Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Implementation of the bpf_task_work_schedule kfuncs.
> >>
> >> Main components:
> >>   * struct bpf_task_work_context =E2=80=93 Metadata and state manageme=
nt per task
> >> work.
> >>   * enum bpf_task_work_state =E2=80=93 A state machine to serialize wo=
rk
> >>   scheduling and execution.
> >>   * bpf_task_work_schedule() =E2=80=93 The central helper that initiat=
es
> >> scheduling.
> >>   * bpf_task_work_acquire() - Attempts to take ownership of the contex=
t,
> >>   pointed by passed struct bpf_task_work, allocates new context if non=
e
> >>   exists yet.
> >>   * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_wo=
rk runs.
> >>   * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in softir=
q context)
> >> to enqueue task work.
> >>   * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BPF =
map entries.
> > Can you elaborate on why the bouncing through irq_work context is neces=
sary?
> > I think we should have this info in the commit log.
> > Is it to avoid deadlocks with task_work locks and/or task->pi_lock?
> yes, mainly to avoid locks in NMI.
> >
> >> Flow of successful task work scheduling
> >>   1) bpf_task_work_schedule_* is called from BPF code.
> >>   2) Transition state from STANDBY to PENDING, marks context is owned =
by
> >>   this task work scheduler
> >>   3) irq_work_queue() schedules bpf_task_work_irq().
> >>   4) Transition state from PENDING to SCHEDULING.
> >>   4) bpf_task_work_irq() attempts task_work_add(). If successful, stat=
e
> >>   transitions to SCHEDULED.
> >>   5) Task work calls bpf_task_work_callback(), which transition state =
to
> >>   RUNNING.
> >>   6) BPF callback is executed
> >>   7) Context is cleaned up, refcounts released, context state set back=
 to
> >>   STANDBY.
> >>
> >> bpf_task_work_context handling
> >> The context pointer is stored in bpf_task_work ctx field (u64) but
> >> treated as an __rcu pointer via casts.
> >> bpf_task_work_acquire() publishes new bpf_task_work_context by cmpxchg
> >> with RCU initializer.
> >> Read under the RCU lock only in bpf_task_work_acquire() when ownership
> >> is contended.
> >> Upon deleting map value, bpf_task_work_cancel_and_free() is detaching
> >> context pointer from struct bpf_task_work and releases resources
> >> if scheduler does not own the context or can be canceled (state =3D=3D
> >> STANDBY or state =3D=3D SCHEDULED and callback canceled). If task work
> >> scheduler owns the context, its state is set to FREED and scheduler is
> >> expected to cleanup on the next state transition.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> > This is much better now, with clear ownership between free path and
> > scheduling path, I mostly have a few more comments on the current
> > implementation, plus one potential bug.
> >
> > However, the more time I spend on this, the more I feel we should
> > unify all this with the two other bpf async work execution mechanisms
> > (timers and wq), and simplify and deduplicate a lot of this under the
> > serialized async->lock. I know NMI execution is probably critical for
> > this primitive, but we can replace async->lock with rqspinlock to
> > address that, so that it becomes safe to serialize in any context.
> > Apart from that, I don't see anything that would negate reworking all
> > this as a case of BPF_TASK_WORK for bpf_async_kern, modulo internal
> > task_work locks that have trouble with NMI execution (see later
> > comments).
> >
> > I also feel like it would be cleaner if we split the API into 3 steps:
> > init(), set_callback(), schedule() like the other cases, I don't see
> > why we necessarily need to diverge, and it simplifies some of the
> > logic in schedule().
> > Once every state update is protected by a lock, all of the state
> > transitions are done automatically and a lot of the extra races are
> > eliminated.
> >
> > I think we should discuss whether this was considered and why you
> > discarded this approach, otherwise the code is pretty complex, with
> > little upside.
> > Maybe I'm missing something obvious and you'd know more since you've
> > thought about all this longer.
> As for API, I think having 1 function for scheduling callback is cleaner
> then having 3 which are always called in the same order anyway. Most of
> the complexity
> comes from synchronization, not logic, so not having to do the same
> synchronization in
> init(), set_callback() and schedule() seems like a benefit to me.

Well, if you were to reuse bpf_async_kern, all of that extra logic is
already taken care of, or can be easily shared.
If you look closely you'll see that a lot of what you're doing is a
repetition of what timers and bpf_wq have.

> Let me check if using rqspinlock going to make things simpler. We still
> need states to at least know if cancellation is possible and to flag
> deletion to scheduler, but using a lock will make code easier to
> understand.

Yeah I think for all of this using lockless updates is not really
worth it, let's just serialize using a lock.

> >
> >>   kernel/bpf/helpers.c | 270 +++++++++++++++++++++++++++++++++++++++++=
--
> >>   1 file changed, 260 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index d2f88a9bc47b..346ae8fd3ada 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -25,6 +25,8 @@
> >>   #include <linux/kasan.h>
> >>   #include <linux/bpf_verifier.h>
> >>   #include <linux/uaccess.h>
> >> +#include <linux/task_work.h>
> >> +#include <linux/irq_work.h>
> >>
> >>   #include "../../lib/kstrtox.h"
> >>
> >> @@ -3701,6 +3703,226 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign=
, const char *s2__ign)
> >>
> >>   typedef void (*bpf_task_work_callback_t)(struct bpf_map *map, void *=
key, void *value);
> >>
> >> +enum bpf_task_work_state {
> >> +       /* bpf_task_work is ready to be used */
> >> +       BPF_TW_STANDBY =3D 0,
> >> +       /* irq work scheduling in progress */
> >> +       BPF_TW_PENDING,
> >> +       /* task work scheduling in progress */
> >> +       BPF_TW_SCHEDULING,
> >> +       /* task work is scheduled successfully */
> >> +       BPF_TW_SCHEDULED,
> >> +       /* callback is running */
> >> +       BPF_TW_RUNNING,
> >> +       /* associated BPF map value is deleted */
> >> +       BPF_TW_FREED,
> >> +};
> >> +
> >> +struct bpf_task_work_context {
> >> +       /* the map and map value associated with this context */
> >> +       struct bpf_map *map;
> >> +       void *map_val;
> >> +       /* bpf_prog that schedules task work */
> >> +       struct bpf_prog *prog;
> >> +       /* task for which callback is scheduled */
> >> +       struct task_struct *task;
> >> +       enum task_work_notify_mode mode;
> >> +       enum bpf_task_work_state state;
> >> +       bpf_task_work_callback_t callback_fn;
> >> +       struct callback_head work;
> >> +       struct irq_work irq_work;
> >> +       struct rcu_head rcu;
> >> +} __aligned(8);
> >> +
> >> +static struct bpf_task_work_context *bpf_task_work_context_alloc(void=
)
> >> +{
> >> +       struct bpf_task_work_context *ctx;
> >> +
> >> +       ctx =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_w=
ork_context));
> >> +       if (ctx)
> >> +               memset(ctx, 0, sizeof(*ctx));
> >> +       return ctx;
> >> +}
> >> +
> >> +static void bpf_task_work_context_free(struct rcu_head *rcu)
> >> +{
> >> +       struct bpf_task_work_context *ctx =3D container_of(rcu, struct=
 bpf_task_work_context, rcu);
> >> +       /* bpf_mem_free expects migration to be disabled */
> >> +       migrate_disable();
> >> +       bpf_mem_free(&bpf_global_ma, ctx);
> >> +       migrate_enable();
> >> +}
> >> +
> >> +static bool task_work_match(struct callback_head *head, void *data)
> >> +{
> >> +       struct bpf_task_work_context *ctx =3D container_of(head, struc=
t bpf_task_work_context, work);
> >> +
> >> +       return ctx =3D=3D data;
> >> +}
> >> +
> >> +static void bpf_task_work_context_reset(struct bpf_task_work_context =
*ctx)
> >> +{
> >> +       bpf_prog_put(ctx->prog);
> >> +       bpf_task_release(ctx->task);
> >> +}
> >> +
> >> +static void bpf_task_work_callback(struct callback_head *cb)
> >> +{
> >> +       enum bpf_task_work_state state;
> >> +       struct bpf_task_work_context *ctx;
> >> +       u32 idx;
> >> +       void *key;
> >> +
> >> +       ctx =3D container_of(cb, struct bpf_task_work_context, work);
> >> +
> >> +       /*
> >> +        * Read lock is needed to protect map key and value access bel=
ow, it has to be done before
> >> +        * the state transition
> >> +        */
> >> +       rcu_read_lock_trace();
> >> +       /*
> >> +        * This callback may start running before bpf_task_work_irq() =
switched the state to
> >> +        * SCHEDULED so handle both transition variants SCHEDULING|SCH=
EDULED -> RUNNING.
> >> +        */
> >> +       state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNI=
NG);
> >> +       if (state =3D=3D BPF_TW_SCHEDULED)
> > ... and let's say we have concurrent cancel_and_free here, we mark
> > state BPF_TW_FREED.
> >
> >> +               state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_T=
W_RUNNING);
> >> +       if (state =3D=3D BPF_TW_FREED) {
> > ... and notice it here now ...
> >
> >> +               rcu_read_unlock_trace();
> >> +               bpf_task_work_context_reset(ctx);
> >> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_=
free);
> > ... then I presume this is ok, because the cancel of tw in
> > cancel_and_free will fail?
> yes, if cancellation succeeds, callback will not be called.
> If it fails, cancel_and_free does not do anything, except changing
> the state and callback does the cleanup.
> > Maybe add a comment here that it's interlocked with the free path.
> >
> >> +               return;
> >> +       }
> >> +
> >> +       key =3D (void *)map_key_from_value(ctx->map, ctx->map_val, &id=
x);
> >> +       migrate_disable();
> >> +       ctx->callback_fn(ctx->map, key, ctx->map_val);
> >> +       migrate_enable();
> >> +       rcu_read_unlock_trace();
> >> +       /* State is running or freed, either way reset. */
> >> +       bpf_task_work_context_reset(ctx);
> >> +       state =3D cmpxchg(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY)=
;
> >> +       if (state =3D=3D BPF_TW_FREED)
> >> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_=
free);
> >> +}
> >> +
> >> +static void bpf_task_work_irq(struct irq_work *irq_work)
> >> +{
> >> +       struct bpf_task_work_context *ctx;
> >> +       enum bpf_task_work_state state;
> >> +       int err;
> >> +
> >> +       ctx =3D container_of(irq_work, struct bpf_task_work_context, i=
rq_work);
> >> +
> >> +       state =3D cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULI=
NG);
> >> +       if (state =3D=3D BPF_TW_FREED)
> >> +               goto free_context;
> >> +
> >> +       err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> >> +       if (err) {
> >> +               bpf_task_work_context_reset(ctx);
> >> +               state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_=
TW_STANDBY);
> >> +               if (state =3D=3D BPF_TW_FREED)
> >> +                       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_=
context_free);
> >> +               return;
> >> +       }
> >> +       state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHED=
ULED);
> >> +       if (state =3D=3D BPF_TW_FREED && task_work_cancel_match(ctx->t=
ask, task_work_match, ctx))
> >> +               goto free_context; /* successful cancellation, release=
 and free ctx */
> >> +       return;
> >> +
> >> +free_context:
> >> +       bpf_task_work_context_reset(ctx);
> >> +       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
> >> +}
> >> +
> >> +static struct bpf_task_work_context *bpf_task_work_context_acquire(st=
ruct bpf_task_work *tw,
> >> +                                                                  str=
uct bpf_map *map)
> >> +{
> >> +       struct bpf_task_work_context *ctx, *old_ctx;
> >> +       enum bpf_task_work_state state;
> >> +       struct bpf_task_work_context __force __rcu **ppc =3D
> >> +               (struct bpf_task_work_context __force __rcu **)&tw->ct=
x;
> >> +
> >> +       /* ctx pointer is RCU protected */
> >> +       rcu_read_lock_trace();
> >> +       ctx =3D rcu_dereference(*ppc);
> >> +       if (!ctx) {
> >> +               ctx =3D bpf_task_work_context_alloc();
> >> +               if (!ctx) {
> >> +                       rcu_read_unlock_trace();
> >> +                       return ERR_PTR(-ENOMEM);
> >> +               }
> >> +               old_ctx =3D unrcu_pointer(cmpxchg(ppc, NULL, RCU_INITI=
ALIZER(ctx)));
> >> +               /*
> >> +                * If ctx is set by another CPU, release allocated mem=
ory.
> >> +                * Do not fail, though, attempt stealing the work
> >> +                */
> >> +               if (old_ctx) {
> >> +                       bpf_mem_free(&bpf_global_ma, ctx);
> >> +                       ctx =3D old_ctx;
> >> +               }
> >> +       }
> >> +       state =3D cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING)=
;
> >> +       /*
> >> +        * We can unlock RCU, because task work scheduler (this codepa=
th)
> >> +        * now owns the ctx or returning an error
> >> +        */
> >> +       rcu_read_unlock_trace();
> >> +       if (state !=3D BPF_TW_STANDBY)
> >> +               return ERR_PTR(-EBUSY);
> >> +       return ctx;
> >> +}
> >> +
> >> +static int bpf_task_work_schedule(struct task_struct *task, struct bp=
f_task_work *tw,
> >> +                                 struct bpf_map *map, bpf_task_work_c=
allback_t callback_fn,
> >> +                                 struct bpf_prog_aux *aux, enum task_=
work_notify_mode mode)
> >> +{
> >> +       struct bpf_prog *prog;
> >> +       struct bpf_task_work_context *ctx =3D NULL;
> >> +       int err;
> >> +
> >> +       BTF_TYPE_EMIT(struct bpf_task_work);
> >> +
> >> +       prog =3D bpf_prog_inc_not_zero(aux->prog);
> >> +       if (IS_ERR(prog))
> >> +               return -EBADF;
> >> +
> >> +       if (!atomic64_read(&map->usercnt)) {
> >> +               err =3D -EBADF;
> >> +               goto release_prog;
> >> +       }
> > Please add a comment on why lack of ordering between load of usercnt
> > and load of tw->ctx is safe, in presence of a parallel usercnt
> > dec_and_test and ctx xchg.
> > See __bpf_async_init for similar race.
> I think I see what you mean, let me double check this.
> >
> >> +       task =3D bpf_task_acquire(task);
> >> +       if (!task) {
> >> +               err =3D -EPERM;
> >> +               goto release_prog;
> >> +       }
> >> +       ctx =3D bpf_task_work_context_acquire(tw, map);
> >> +       if (IS_ERR(ctx)) {
> >> +               err =3D PTR_ERR(ctx);
> >> +               goto release_all;
> >> +       }
> >> +
> >> +       ctx->task =3D task;
> >> +       ctx->callback_fn =3D callback_fn;
> >> +       ctx->prog =3D prog;
> >> +       ctx->mode =3D mode;
> >> +       ctx->map =3D map;
> >> +       ctx->map_val =3D (void *)tw - map->record->task_work_off;
> >> +       init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> >> +       init_task_work(&ctx->work, bpf_task_work_callback);
> >> +
> >> +       irq_work_queue(&ctx->irq_work);
> >> +
> >> +       return 0;
> >> +
> >> +release_all:
> >> +       bpf_task_release(task);
> >> +release_prog:
> >> +       bpf_prog_put(prog);
> >> +       return err;
> >> +}
> >> +
> >>   /**
> >>    * bpf_task_work_schedule_signal - Schedule BPF callback using task_=
work_add with TWA_SIGNAL mode
> >>    * @task: Task struct for which callback should be scheduled
> >> @@ -3711,13 +3933,11 @@ typedef void (*bpf_task_work_callback_t)(struc=
t bpf_map *map, void *key, void *v
> >>    *
> >>    * Return: 0 if task work has been scheduled successfully, negative =
error code otherwise
> >>    */
> >> -__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *tas=
k,
> >> -                                             struct bpf_task_work *tw=
,
> >> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *tas=
k, struct bpf_task_work *tw,
> >>                                                struct bpf_map *map__ma=
p,
> >> -                                             bpf_task_work_callback_t=
 callback,
> >> -                                             void *aux__prog)
> >> +                                             bpf_task_work_callback_t=
 callback, void *aux__prog)
> >>   {
> >> -       return 0;
> >> +       return bpf_task_work_schedule(task, tw, map__map, callback, au=
x__prog, TWA_SIGNAL);
> >>   }
> >>
> >>   /**
> >> @@ -3731,19 +3951,47 @@ __bpf_kfunc int bpf_task_work_schedule_signal(=
struct task_struct *task,
> >>    *
> >>    * Return: 0 if task work has been scheduled successfully, negative =
error code otherwise
> >>    */
> >> -__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *tas=
k,
> >> -                                             struct bpf_task_work *tw=
,
> >> +__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *tas=
k, struct bpf_task_work *tw,
> >>                                                struct bpf_map *map__ma=
p,
> >> -                                             bpf_task_work_callback_t=
 callback,
> >> -                                             void *aux__prog)
> >> +                                             bpf_task_work_callback_t=
 callback, void *aux__prog)
> >>   {
> >> -       return 0;
> >> +       enum task_work_notify_mode mode;
> >> +
> >> +       mode =3D task =3D=3D current && in_nmi() ? TWA_NMI_CURRENT : T=
WA_RESUME;
> >> +       return bpf_task_work_schedule(task, tw, map__map, callback, au=
x__prog, mode);
> >>   }
> >>
> >>   __bpf_kfunc_end_defs();
> >>
> >>   void bpf_task_work_cancel_and_free(void *val)
> >>   {
> >> +       struct bpf_task_work *tw =3D val;
> >> +       struct bpf_task_work_context *ctx;
> >> +       enum bpf_task_work_state state;
> >> +
> >> +       /* No need do rcu_read_lock as no other codepath can reset thi=
s pointer */
> >> +       ctx =3D unrcu_pointer(xchg((struct bpf_task_work_context __for=
ce __rcu **)&tw->ctx, NULL));
> >> +       if (!ctx)
> >> +               return;
> >> +       state =3D xchg(&ctx->state, BPF_TW_FREED);
> >> +
> >> +       switch (state) {
> >> +       case BPF_TW_SCHEDULED:
> >> +               /* If we can't cancel task work, rely on task work cal=
lback to free the context */
> >> +               if (!task_work_cancel_match(ctx->task, task_work_match=
, ctx))
> > This part looks broken to me.
> > You are calling this path
> > (update->obj_free_fields->cancel_and_free->cancel_and_match) in
> > possibly NMI context.
> > Which means we can deadlock if we hit the NMI context prog in the
> > middle of task->pi_lock critical section.
> > That's taken in task_work functions
> > The task_work_cancel_match takes the pi_lock.
> Good point, thanks. I think this could be solved in 2 ways:
>   * Don't cancel, rely on callback dropping the work
>   * Cancel in another irq_work
> I'll probably go with the second one.

What about 1? It seems like we can just rely on the existing hunk to
free the callback on noticing BPF_TW_FREED?
That seems simpler to me.

> >
> >> +                       break;
> >> +               bpf_task_work_context_reset(ctx);
> >> +               fallthrough;
> >> +       case BPF_TW_STANDBY:
> >> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_=
free);
> >> +               break;
> >> +       /* In all below cases scheduling logic should detect context s=
tate change and cleanup */
> >> +       case BPF_TW_SCHEDULING:
> >> +       case BPF_TW_PENDING:
> >> +       case BPF_TW_RUNNING:
> >> +       default:
> >> +               break;
> >> +       }
> >>   }
> >>
> >>   BTF_KFUNCS_START(generic_btf_ids)
> >> @@ -3769,6 +4017,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL=
)
> >>   BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
> >>   BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
> >>   BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
> >> +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
> >>
> >>   #ifdef CONFIG_CGROUPS
> >>   BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_=
NULL)
> >> --
> >> 2.50.1
> >>
>

