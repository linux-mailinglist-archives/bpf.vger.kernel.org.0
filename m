Return-Path: <bpf+bounces-66015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B07B2C6E6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B81582CA9
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A69258EEA;
	Tue, 19 Aug 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARrM7pOc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAD255F52
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613141; cv=none; b=T/5gjkp9BtX8kSZNqO2wGGeUq6WCqNjKmRr8eZNIfO3CRe0npwU/vJWzMbgDRIc7KtHuBCDO6QEX1T0nnT4H6t/rGnojuWRV7hT47GAbb0k+L1UBWBZfrhoHRBj19O8tYYAsxDoBTbNaXlefY9qL1vd7tlkgFKycima26kqRwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613141; c=relaxed/simple;
	bh=Xr20xAZQjptVKKr3FNbWzKP+51JBgiGk8z95EL3h3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APXqb80aoN7YYNKNdh57CCNFXBVaMCIltixaNhn6n2Ue3oDoG9PT69Z7oGNApyPwPkoDubyJRRzpeAp6lHApqW7ySUs/h74FSj1SbjCGKmlOZMlLkvwevKOgTQfzIo/LaZd1v98U/a6gJ2OYIpsC3yKZQIvC0qCXO1pYsXmAEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARrM7pOc; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so7265464a12.0
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755613137; x=1756217937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ5WXse9ty65I9oxbQRX5ud7kK53JoEvKmQbA9RoznM=;
        b=ARrM7pOcerCeOqdseeDBt/3BNQdO9nlR733lDGPPTBmvTGceqhfRc5OyE5yMKBvG5W
         nB4qVLuQ5s/6+k05ljffZ9tvX++XAXDLlrKQa3sL+QFCC97YhXfEcbrlKEM3QF2N2n/Y
         R3xyvWsm4YXMNJEM75HZXf1PclYqZdXSAsP+FGzaZpl316vh7Pk7dUqN6bBzs/PGDgEv
         z31j/0U7F7SZkOCRT73WaLqFH3OGi+vAt3vsOUJG36CMaJun2WIAk/ECUajzcRMqs95j
         EKuJNS/vcIN4SlLKH/RrLk0vqX7Nw3KK1Z4ava9xV0iqtvSqiqL8lGLca+twVf7ZQIK5
         4lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613137; x=1756217937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ5WXse9ty65I9oxbQRX5ud7kK53JoEvKmQbA9RoznM=;
        b=U7lwu6OYXzkD2yXtEOotdVSL0ZkkU6uUBpzPYSW118b6FyZNlG643CaMqk8lie0i+G
         m0ypOLa4zYzkHHJGkgLCaiW6gEL3GecrWWKyH+zTlkUw2OQtd+N4h54NegKLx+mizlYy
         1fp0oF2LKdJ7eGnsQvymob/OxxaKDlF2m+qmraPE76af+UmTzYcqgli5Cv95UT9JI7SH
         ZD+iaFmFPC7f0bTJUkoOI7bX9JJpe8dZvMr7WvMRNWCL+wnnQMTvumfUAr2QJhiRDtOh
         JSg9wOJKn4qw63WkhGfdvu9P0IOKp/Khs52nCCSMaWnvslJc2p0XyvFGL1JPnp8sz2pC
         Y3Yw==
X-Gm-Message-State: AOJu0YxmeyJ3x3z3YJ4d5iPfb5lyF4yyNUO5lzlCLos4X5S3ubCMGdlA
	uurwrHDZqZ0wR0Fu0kYhu2aB6SsmI1z/L8jwKY7KbRTLGY9IfPpKAJSx8wlYzjntWvEGK4sY94Y
	2GjWVq6WCcCLpOaDlf9DCmeuTGQx/4+w=
X-Gm-Gg: ASbGnctNbwTRga1bNTn0oCw8eI37MuWqx/FbLUn3QTeWgIUYZV9um29OgGCJXSPfvCo
	FVUIu62vp5bG2+t3uoewszqhPtw3jpJstX07NsLkd5VujcexpOnXNqtl/r5/ob9CG8fWLnWIlLK
	vnv/pLcchMWrFWh7vAF9PKWhvyZIqp3Eh+UMeFgB8MFrpv5VP4uRq3YZf8uanEbY6cQSM5cFJod
	dFMv6W0gw==
X-Google-Smtp-Source: AGHT+IH6CJ3daRZEEkpIcoX+YHw+LYQIuzLviP/VXeAe3Asx2HYWOCZCx18w9YoDXTlPJSjAhP+UxGCFesyd2OW28rA=
X-Received: by 2002:a05:6402:1d4a:b0:618:5833:c86d with SMTP id
 4fb4d7f45d1cf-61a7e6ddfbcmr2104396a12.10.1755613136908; Tue, 19 Aug 2025
 07:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com> <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 19 Aug 2025 16:18:19 +0200
X-Gm-Features: Ac12FXwDdOs6uRmXsdIelaLiw_4OcT9CIljm_YV8n4Yr034GSKBCfJdyE7Uj42w
Message-ID: <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Aug 2025 at 21:22, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Implementation of the bpf_task_work_schedule kfuncs.
>
> Main components:
>  * struct bpf_task_work_context =E2=80=93 Metadata and state management p=
er task
> work.
>  * enum bpf_task_work_state =E2=80=93 A state machine to serialize work
>  scheduling and execution.
>  * bpf_task_work_schedule() =E2=80=93 The central helper that initiates
> scheduling.
>  * bpf_task_work_acquire() - Attempts to take ownership of the context,
>  pointed by passed struct bpf_task_work, allocates new context if none
>  exists yet.
>  * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_work r=
uns.
>  * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in softirq co=
ntext)
> to enqueue task work.
>  * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BPF map =
entries.

Can you elaborate on why the bouncing through irq_work context is necessary=
?
I think we should have this info in the commit log.
Is it to avoid deadlocks with task_work locks and/or task->pi_lock?

>
> Flow of successful task work scheduling
>  1) bpf_task_work_schedule_* is called from BPF code.
>  2) Transition state from STANDBY to PENDING, marks context is owned by
>  this task work scheduler
>  3) irq_work_queue() schedules bpf_task_work_irq().
>  4) Transition state from PENDING to SCHEDULING.
>  4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>  transitions to SCHEDULED.
>  5) Task work calls bpf_task_work_callback(), which transition state to
>  RUNNING.
>  6) BPF callback is executed
>  7) Context is cleaned up, refcounts released, context state set back to
>  STANDBY.
>
> bpf_task_work_context handling
> The context pointer is stored in bpf_task_work ctx field (u64) but
> treated as an __rcu pointer via casts.
> bpf_task_work_acquire() publishes new bpf_task_work_context by cmpxchg
> with RCU initializer.
> Read under the RCU lock only in bpf_task_work_acquire() when ownership
> is contended.
> Upon deleting map value, bpf_task_work_cancel_and_free() is detaching
> context pointer from struct bpf_task_work and releases resources
> if scheduler does not own the context or can be canceled (state =3D=3D
> STANDBY or state =3D=3D SCHEDULED and callback canceled). If task work
> scheduler owns the context, its state is set to FREED and scheduler is
> expected to cleanup on the next state transition.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

This is much better now, with clear ownership between free path and
scheduling path, I mostly have a few more comments on the current
implementation, plus one potential bug.

However, the more time I spend on this, the more I feel we should
unify all this with the two other bpf async work execution mechanisms
(timers and wq), and simplify and deduplicate a lot of this under the
serialized async->lock. I know NMI execution is probably critical for
this primitive, but we can replace async->lock with rqspinlock to
address that, so that it becomes safe to serialize in any context.
Apart from that, I don't see anything that would negate reworking all
this as a case of BPF_TASK_WORK for bpf_async_kern, modulo internal
task_work locks that have trouble with NMI execution (see later
comments).

I also feel like it would be cleaner if we split the API into 3 steps:
init(), set_callback(), schedule() like the other cases, I don't see
why we necessarily need to diverge, and it simplifies some of the
logic in schedule().
Once every state update is protected by a lock, all of the state
transitions are done automatically and a lot of the extra races are
eliminated.

I think we should discuss whether this was considered and why you
discarded this approach, otherwise the code is pretty complex, with
little upside.
Maybe I'm missing something obvious and you'd know more since you've
thought about all this longer.

>  kernel/bpf/helpers.c | 270 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 260 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d2f88a9bc47b..346ae8fd3ada 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -25,6 +25,8 @@
>  #include <linux/kasan.h>
>  #include <linux/bpf_verifier.h>
>  #include <linux/uaccess.h>
> +#include <linux/task_work.h>
> +#include <linux/irq_work.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -3701,6 +3703,226 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, c=
onst char *s2__ign)
>
>  typedef void (*bpf_task_work_callback_t)(struct bpf_map *map, void *key,=
 void *value);
>
> +enum bpf_task_work_state {
> +       /* bpf_task_work is ready to be used */
> +       BPF_TW_STANDBY =3D 0,
> +       /* irq work scheduling in progress */
> +       BPF_TW_PENDING,
> +       /* task work scheduling in progress */
> +       BPF_TW_SCHEDULING,
> +       /* task work is scheduled successfully */
> +       BPF_TW_SCHEDULED,
> +       /* callback is running */
> +       BPF_TW_RUNNING,
> +       /* associated BPF map value is deleted */
> +       BPF_TW_FREED,
> +};
> +
> +struct bpf_task_work_context {
> +       /* the map and map value associated with this context */
> +       struct bpf_map *map;
> +       void *map_val;
> +       /* bpf_prog that schedules task work */
> +       struct bpf_prog *prog;
> +       /* task for which callback is scheduled */
> +       struct task_struct *task;
> +       enum task_work_notify_mode mode;
> +       enum bpf_task_work_state state;
> +       bpf_task_work_callback_t callback_fn;
> +       struct callback_head work;
> +       struct irq_work irq_work;
> +       struct rcu_head rcu;
> +} __aligned(8);
> +
> +static struct bpf_task_work_context *bpf_task_work_context_alloc(void)
> +{
> +       struct bpf_task_work_context *ctx;
> +
> +       ctx =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work=
_context));
> +       if (ctx)
> +               memset(ctx, 0, sizeof(*ctx));
> +       return ctx;
> +}
> +
> +static void bpf_task_work_context_free(struct rcu_head *rcu)
> +{
> +       struct bpf_task_work_context *ctx =3D container_of(rcu, struct bp=
f_task_work_context, rcu);
> +       /* bpf_mem_free expects migration to be disabled */
> +       migrate_disable();
> +       bpf_mem_free(&bpf_global_ma, ctx);
> +       migrate_enable();
> +}
> +
> +static bool task_work_match(struct callback_head *head, void *data)
> +{
> +       struct bpf_task_work_context *ctx =3D container_of(head, struct b=
pf_task_work_context, work);
> +
> +       return ctx =3D=3D data;
> +}
> +
> +static void bpf_task_work_context_reset(struct bpf_task_work_context *ct=
x)
> +{
> +       bpf_prog_put(ctx->prog);
> +       bpf_task_release(ctx->task);
> +}
> +
> +static void bpf_task_work_callback(struct callback_head *cb)
> +{
> +       enum bpf_task_work_state state;
> +       struct bpf_task_work_context *ctx;
> +       u32 idx;
> +       void *key;
> +
> +       ctx =3D container_of(cb, struct bpf_task_work_context, work);
> +
> +       /*
> +        * Read lock is needed to protect map key and value access below,=
 it has to be done before
> +        * the state transition
> +        */
> +       rcu_read_lock_trace();
> +       /*
> +        * This callback may start running before bpf_task_work_irq() swi=
tched the state to
> +        * SCHEDULED so handle both transition variants SCHEDULING|SCHEDU=
LED -> RUNNING.
> +        */
> +       state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNING)=
;
> +       if (state =3D=3D BPF_TW_SCHEDULED)

... and let's say we have concurrent cancel_and_free here, we mark
state BPF_TW_FREED.

> +               state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_R=
UNNING);
> +       if (state =3D=3D BPF_TW_FREED) {

... and notice it here now ...

> +               rcu_read_unlock_trace();
> +               bpf_task_work_context_reset(ctx);
> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_fre=
e);

... then I presume this is ok, because the cancel of tw in
cancel_and_free will fail?
Maybe add a comment here that it's interlocked with the free path.

> +               return;
> +       }
> +
> +       key =3D (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
> +       migrate_disable();
> +       ctx->callback_fn(ctx->map, key, ctx->map_val);
> +       migrate_enable();
> +       rcu_read_unlock_trace();
> +       /* State is running or freed, either way reset. */
> +       bpf_task_work_context_reset(ctx);
> +       state =3D cmpxchg(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
> +       if (state =3D=3D BPF_TW_FREED)
> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_fre=
e);
> +}
> +
> +static void bpf_task_work_irq(struct irq_work *irq_work)
> +{
> +       struct bpf_task_work_context *ctx;
> +       enum bpf_task_work_state state;
> +       int err;
> +
> +       ctx =3D container_of(irq_work, struct bpf_task_work_context, irq_=
work);
> +
> +       state =3D cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING)=
;
> +       if (state =3D=3D BPF_TW_FREED)
> +               goto free_context;
> +
> +       err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> +       if (err) {
> +               bpf_task_work_context_reset(ctx);
> +               state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_=
STANDBY);
> +               if (state =3D=3D BPF_TW_FREED)
> +                       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_con=
text_free);
> +               return;
> +       }
> +       state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULE=
D);
> +       if (state =3D=3D BPF_TW_FREED && task_work_cancel_match(ctx->task=
, task_work_match, ctx))
> +               goto free_context; /* successful cancellation, release an=
d free ctx */
> +       return;
> +
> +free_context:
> +       bpf_task_work_context_reset(ctx);
> +       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
> +}
> +
> +static struct bpf_task_work_context *bpf_task_work_context_acquire(struc=
t bpf_task_work *tw,
> +                                                                  struct=
 bpf_map *map)
> +{
> +       struct bpf_task_work_context *ctx, *old_ctx;
> +       enum bpf_task_work_state state;
> +       struct bpf_task_work_context __force __rcu **ppc =3D
> +               (struct bpf_task_work_context __force __rcu **)&tw->ctx;
> +
> +       /* ctx pointer is RCU protected */
> +       rcu_read_lock_trace();
> +       ctx =3D rcu_dereference(*ppc);
> +       if (!ctx) {
> +               ctx =3D bpf_task_work_context_alloc();
> +               if (!ctx) {
> +                       rcu_read_unlock_trace();
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +               old_ctx =3D unrcu_pointer(cmpxchg(ppc, NULL, RCU_INITIALI=
ZER(ctx)));
> +               /*
> +                * If ctx is set by another CPU, release allocated memory=
.
> +                * Do not fail, though, attempt stealing the work
> +                */
> +               if (old_ctx) {
> +                       bpf_mem_free(&bpf_global_ma, ctx);
> +                       ctx =3D old_ctx;
> +               }
> +       }
> +       state =3D cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING);
> +       /*
> +        * We can unlock RCU, because task work scheduler (this codepath)
> +        * now owns the ctx or returning an error
> +        */
> +       rcu_read_unlock_trace();
> +       if (state !=3D BPF_TW_STANDBY)
> +               return ERR_PTR(-EBUSY);
> +       return ctx;
> +}
> +
> +static int bpf_task_work_schedule(struct task_struct *task, struct bpf_t=
ask_work *tw,
> +                                 struct bpf_map *map, bpf_task_work_call=
back_t callback_fn,
> +                                 struct bpf_prog_aux *aux, enum task_wor=
k_notify_mode mode)
> +{
> +       struct bpf_prog *prog;
> +       struct bpf_task_work_context *ctx =3D NULL;
> +       int err;
> +
> +       BTF_TYPE_EMIT(struct bpf_task_work);
> +
> +       prog =3D bpf_prog_inc_not_zero(aux->prog);
> +       if (IS_ERR(prog))
> +               return -EBADF;
> +
> +       if (!atomic64_read(&map->usercnt)) {
> +               err =3D -EBADF;
> +               goto release_prog;
> +       }

Please add a comment on why lack of ordering between load of usercnt
and load of tw->ctx is safe, in presence of a parallel usercnt
dec_and_test and ctx xchg.
See __bpf_async_init for similar race.

> +       task =3D bpf_task_acquire(task);
> +       if (!task) {
> +               err =3D -EPERM;
> +               goto release_prog;
> +       }
> +       ctx =3D bpf_task_work_context_acquire(tw, map);
> +       if (IS_ERR(ctx)) {
> +               err =3D PTR_ERR(ctx);
> +               goto release_all;
> +       }
> +
> +       ctx->task =3D task;
> +       ctx->callback_fn =3D callback_fn;
> +       ctx->prog =3D prog;
> +       ctx->mode =3D mode;
> +       ctx->map =3D map;
> +       ctx->map_val =3D (void *)tw - map->record->task_work_off;
> +       init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> +       init_task_work(&ctx->work, bpf_task_work_callback);
> +
> +       irq_work_queue(&ctx->irq_work);
> +
> +       return 0;
> +
> +release_all:
> +       bpf_task_release(task);
> +release_prog:
> +       bpf_prog_put(prog);
> +       return err;
> +}
> +
>  /**
>   * bpf_task_work_schedule_signal - Schedule BPF callback using task_work=
_add with TWA_SIGNAL mode
>   * @task: Task struct for which callback should be scheduled
> @@ -3711,13 +3933,11 @@ typedef void (*bpf_task_work_callback_t)(struct b=
pf_map *map, void *key, void *v
>   *
>   * Return: 0 if task work has been scheduled successfully, negative erro=
r code otherwise
>   */
> -__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
> -                                             struct bpf_task_work *tw,
> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, =
struct bpf_task_work *tw,
>                                               struct bpf_map *map__map,
> -                                             bpf_task_work_callback_t ca=
llback,
> -                                             void *aux__prog)
> +                                             bpf_task_work_callback_t ca=
llback, void *aux__prog)
>  {
> -       return 0;
> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux__=
prog, TWA_SIGNAL);
>  }
>
>  /**
> @@ -3731,19 +3951,47 @@ __bpf_kfunc int bpf_task_work_schedule_signal(str=
uct task_struct *task,
>   *
>   * Return: 0 if task work has been scheduled successfully, negative erro=
r code otherwise
>   */
> -__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task,
> -                                             struct bpf_task_work *tw,
> +__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, =
struct bpf_task_work *tw,
>                                               struct bpf_map *map__map,
> -                                             bpf_task_work_callback_t ca=
llback,
> -                                             void *aux__prog)
> +                                             bpf_task_work_callback_t ca=
llback, void *aux__prog)
>  {
> -       return 0;
> +       enum task_work_notify_mode mode;
> +
> +       mode =3D task =3D=3D current && in_nmi() ? TWA_NMI_CURRENT : TWA_=
RESUME;
> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux__=
prog, mode);
>  }
>
>  __bpf_kfunc_end_defs();
>
>  void bpf_task_work_cancel_and_free(void *val)
>  {
> +       struct bpf_task_work *tw =3D val;
> +       struct bpf_task_work_context *ctx;
> +       enum bpf_task_work_state state;
> +
> +       /* No need do rcu_read_lock as no other codepath can reset this p=
ointer */
> +       ctx =3D unrcu_pointer(xchg((struct bpf_task_work_context __force =
__rcu **)&tw->ctx, NULL));
> +       if (!ctx)
> +               return;
> +       state =3D xchg(&ctx->state, BPF_TW_FREED);
> +
> +       switch (state) {
> +       case BPF_TW_SCHEDULED:
> +               /* If we can't cancel task work, rely on task work callba=
ck to free the context */
> +               if (!task_work_cancel_match(ctx->task, task_work_match, c=
tx))

This part looks broken to me.
You are calling this path
(update->obj_free_fields->cancel_and_free->cancel_and_match) in
possibly NMI context.
Which means we can deadlock if we hit the NMI context prog in the
middle of task->pi_lock critical section.
That's taken in task_work functions
The task_work_cancel_match takes the pi_lock.

> +                       break;
> +               bpf_task_work_context_reset(ctx);
> +               fallthrough;
> +       case BPF_TW_STANDBY:
> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_fre=
e);
> +               break;
> +       /* In all below cases scheduling logic should detect context stat=
e change and cleanup */
> +       case BPF_TW_SCHEDULING:
> +       case BPF_TW_PENDING:
> +       case BPF_TW_RUNNING:
> +       default:
> +               break;
> +       }
>  }
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3769,6 +4017,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
>
>  #ifdef CONFIG_CGROUPS
>  BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL=
)
> --
> 2.50.1
>

