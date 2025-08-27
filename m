Return-Path: <bpf+bounces-66726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A3B38B36
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DED7A4512
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69B30C35B;
	Wed, 27 Aug 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDX/qRei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF03081AD
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328633; cv=none; b=DfekGLlQ1T30cHDp8kWP8T0szEKEHuZXRzG3je6WUOoEgi94m46fCri8Ke50SZIGkPCR1S56A98Wl+aT7gJ7BeKWECC6Y7po2ksqjdEW8aQAsitFIxwMdNxlY2bKMlWBKnlboln93NpXrmggEMKV5VKojaw7qAX3oz/9Qe/4CdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328633; c=relaxed/simple;
	bh=8cFjIR070wctOTTLbC+vOGAQ8x+pSM048g5Fytf87rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH6gs9g2FLshuD5VBymMPwg9N4nIguYBEYu3O12IgKSG1xspT4T72frYV4TgOl6RW0BtTakke68EO2VcyMirUDhhQ8NVb2Ce9EcyT7cNi6Ll7cCeMEqV7Ii9/bDUvt5FfvU26fZyoKDmnTZGJLsiN28gmjdmqKJPD7aNvBz6UZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDX/qRei; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3253f2a7679so326199a91.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756328630; x=1756933430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0/TExYXv6QiomkaRILZYkFfk5jrREJtMIFIh9UsX9g=;
        b=iDX/qReiOpw4FDv5xl4fiZVodXFzIdn6FAxuYcM8AYQ6hO3xyTdYelouhWvFzFywtH
         ellCDL/ase5SoSdNZWAeyefBNlebqRaJsRbE1JME+HN6hPkOfY3mAMfN/AiQCoEXS5dO
         W1Ffl88xj3UGadXVEMtih+HAUt1S43v3V8Dz5H7IYGVIxfdqYgliMpWtMAwjXwNhCTpg
         WNdGvBTTw6zO13KVJdEvhLppbA4WGQKppQJFRNBb2xP6tvLVq7zDG9XMRRlCEYaqlkfM
         xhKy+GDBFO0GRQtUDD2oSBL5ycARODGTuW4XEWbJbj+/sVOUNntO8jMEU0uHD0mqPbIE
         Lq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756328630; x=1756933430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0/TExYXv6QiomkaRILZYkFfk5jrREJtMIFIh9UsX9g=;
        b=E9hChGPztbez9SoIENH+nB5C6ryseNoxwyWLmJtaU8oeHLNVoYQlSNOvvUt/HvoX4B
         qaH+rMuZPKpQOSKmZOQz0P1Y/ho1wzQAEZju62OsK4Z/6hfuOLOx9a8mlDVm7VLGD0oF
         TcuSq6hTLq/pD9O0fjuj3JTW5jEPyewvJANtElcrdtPHDjAj2Jez1ibkE8zxaXUfkXKP
         UUDTUMPknAbnWdqdOylz5knW8JJpEWvOq9hjZOJzjMuOnZRL9cjkGuFLxkyV1x4ewNKU
         PzXGY/z5g/h2JCMwTQlCuCJbC5pDjps7jxoPY1jPPZCmKQ/wFTeJozpBkTIVmE+qokBn
         /GzQ==
X-Gm-Message-State: AOJu0YxT24SIkTMrFvWTAjJV6OQF6k3CihYzX77GhwOvFGB3KwQPM+fc
	8Ez3PpbPARMsrHmDhpD4cbRCnIWELO4YkYK37tnm7y1kI7lVDjmcjjGZtVwy2LVz/bniaRUnlOF
	Q40VEx5/pSIXtIGNqB1mgpOHcu892Cfg=
X-Gm-Gg: ASbGncuhuwSqtmbtx0Sauckwmhik7FxodR0KEjUO2Eni+v37RAXIA810SZUlonyzYji
	oUhBDrQTe2KH3BswgvKXSpmws0DQI5ZR/qLSrgUpWRrV3zDXPt/OW9/8MmLl5w+DUr3voxcToZA
	WdHynpO459GAe3gZGTJXxZY4cWsPBlyLx9ZLjDvuU6w655EAZ6/2hZ9HFqaygotHbucnGRUGhA8
	XONv2I8ChxUt/0oBkK2xfs=
X-Google-Smtp-Source: AGHT+IGIyjsxKFrsjqwcMR/Oj1FV/pkB6TZ6Mp+wG8YgveD3r4hPW3K2tZ97RL76p+7/LoByxazMK0c+u80W8YaWbLk=
X-Received: by 2002:a17:90b:2883:b0:327:76e3:d06 with SMTP id
 98e67ed59e1d1-32776e30df2mr4931063a91.12.1756328630112; Wed, 27 Aug 2025
 14:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com> <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 14:03:35 -0700
X-Gm-Features: Ac12FXwwUAiPrUA7kDRkDFqx21OIXHR11ItuyU4c0FUqR6OaInPY4NpJFTB4lCA
Message-ID: <CAEf4BzaYGA+6QYr64tEkMb0vcX4TtgMmKMQyqpviE=5OAmirFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 12:22=E2=80=AFPM Mykyta Yatsenko
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
> +               state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_R=
UNNING);
> +       if (state =3D=3D BPF_TW_FREED) {
> +               rcu_read_unlock_trace();
> +               bpf_task_work_context_reset(ctx);
> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_fre=
e);
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

we discussed this with Mykyta earlier offline, but I'll not it here:
this looks pretty ugly, we should avoid these casts. We probably need
struct bpf_task_work with opaque contents for user-visible API, and
then have bpf_task_work_kern or something like that, where ctx will be
just a struct bpf_task_work_ctx pointer

> +
> +       /* ctx pointer is RCU protected */
> +       rcu_read_lock_trace();
> +       ctx =3D rcu_dereference(*ppc);

and here it should be enough to do just READ_ONCE(tw->ctx), either way
rcu_dereference is wrong here because it checks for just classic
rcu_read_lock() to be "held", while we use RCU Tasks Trace flavor for
protection of the context struct

> +       if (!ctx) {
> +               ctx =3D bpf_task_work_context_alloc();
> +               if (!ctx) {
> +                       rcu_read_unlock_trace();
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +               old_ctx =3D unrcu_pointer(cmpxchg(ppc, NULL, RCU_INITIALI=
ZER(ctx)));

similarly here, just `old_ctx =3D cmpxchg(tw->ctx, NULL, ctx);` seems
much more preferable to me

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

Kumar pointed out that race between map_release_uref() and this check.
It looks like a simple fix would be to perform
bpf_task_work_context_acquire() first, and only then check for
map->usercnt, and if it dropped to zero, just clean up and return
-EPERM?

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

this should have been folded into patch 1?

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

same, rebasing/refactoring artifacts

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

typo: to do

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
> +                       break;
> +               bpf_task_work_context_reset(ctx);

As Kumar pointed out earlier, this can be called from NMI, so we can't
just cancel here, we need to schedule irq_work to do the cancellation.

Good thing is that if we were in SCHEDULED state, then we can simply
reuse irq_work struct from task_work_ctx (please contract "context"
into "ctx", btw), and there is no change to the state machine, it's
just a slightly delayed clean up (and we'll remain in terminal FREED
state anyways).

Bad news: that extra irq_work step mean we have to be careful about
ctx lifetime, because if task_work callback couldn't be cancelled, we
might have a situation where memory is freed by task_work callback
itself (when it fails to transition to RUNNING) while we wait for
irq_work callback to be run, and then we get freed memory dereference.

So I'm thinking that besides RCU protection we should also have a
simple refcounting protection for bpf_task_work_ctx itself. I don't
think that's a problem performance wise, and the nice thing is that
there will be less direct `call_rcu_tasks_trace(&ctx->rcu,
bpf_task_work_context_free);` sprinkled around. Instead we'll have
just bpf_task_work_put(ctx), which might call RCU-delayed freeing.

We might want to roll bpf_task_work_context_reset logic into it,
conditionally (but we need to make sure that we reset prog and task
pointers to NULL during a non-freeing context reset).

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

