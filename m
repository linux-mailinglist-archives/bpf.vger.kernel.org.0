Return-Path: <bpf+bounces-66910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5DB3AD84
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 00:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C23169373
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D926E6FA;
	Thu, 28 Aug 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy3f3WFO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EA7404E
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420191; cv=none; b=MKPuEDzIzkeK1N5ZisJMUHHbjotdfFPPrBd2UpDfnQCSZhIJjBYSkPIpiavIXYOec2aEJMdpMw2oZD/SN0Ohgq/PAYBhmHNBYsb6lhDnUBJ+ZL949DGBAUI1uIsvjzZ61TjUEqD+A7nPFETNfm8B0l2VgkdpV7Yfu300FtDohMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420191; c=relaxed/simple;
	bh=w1DG2GCEDp4f0QOnt+hwoLZSNflkjhOpPPrsfXh27S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIIvZxJVWaT6xAiVHvLAqjSFFfeheWJ4EgaHO9vfWo7Ty+UgoFosI4cZTYVlFY4QmtIV6kvcLEGTu4yElndVlUFyoh6qv9FD8YD7BvClCwuzh2UhXlB/3Zraq8OnPH1qHEO/WrVXOoRpXB6NT56yrodM6c29A678aui3Fs64z9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy3f3WFO; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so1924058a12.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756420187; x=1757024987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX5txqLCJnO9TnArEB5jdxvq5sGMKCQM1y94SabL0dY=;
        b=Yy3f3WFOXYVUYdiO6j4UxPDINNQHzb3/eMQJTcUR1NzSFjJs8+3aVZaBayBDE2tiAK
         epYIMmI80Q3MGDxmQSdO9iYk6SlDGsmP9MKAl8Z9SG1RcqF4hT1zRDtBwcEQZ4K1uOSZ
         vppRCoHk07iiZe13Fsh3PwJH5wQ28FGo0kCXzqtZ7wZvlewmTD4p4KR0GBJR2FRVpq8m
         AhzoFE9PamtD14Z5lhUkwt0hubiIwks+RAHvznpQ6smjNPZwmxAqThgkn+PAA9xbGEpt
         rf5t7j11/5hv4XjxbI853ayZ9WE7VtddkDbQd4voKGWGcmJ95TC6JKtwVC9LzZ/qcSW9
         PmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756420187; x=1757024987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX5txqLCJnO9TnArEB5jdxvq5sGMKCQM1y94SabL0dY=;
        b=P+r1rFn4R8qZS2XSRrW2K4PzP0iZ1CSZ4J+oKGyFBMMlNL2utwc7FleOzBuSVSTjY9
         O95fgAs9VS9vWIAIvJpenD4uGSI6J4eZd3Oo9JCkAztfobjthtIaDj59++yaTan2CT0i
         ge8I43OjWUYyXeM+6Sa1Tk0ti/oJ5ZqQTA7e9keZuJLia+09AVcKv4p9I+aU+Ao0Cfk9
         SmEI5LPOArt4IbYmEBEEH6ta+YHYXIF6Vi/viRpRvm4/nGuqQFo4o7GYwpUFIprL8Maw
         CIcWJ9X4Sw8CJhBAG1yVpvHgG0k5r3EYAyMayLdAiRxoHTcfVWdx/p7ztvKB86KLiML3
         15pA==
X-Forwarded-Encrypted: i=1; AJvYcCWV9kZMyBx9rnJZAUEEtL6cSr2PAp+8eXVSOzcVZGS86a8xYB2z18ej91vIFyszaT/G5+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjcmwrYr3BeFr4l/S+r4IaU8JF6QUKQqm1pu/+TEvCJf59Jnb
	CQPkzJf0awAsYZh/C6QgJfEUvbXblTpP+TxrhScEugoKVIDLoRFcDNwDtrrPzmoSdQVTJ/xv0vy
	+zYhs2+cup9HFZhtjma2E083SHAsf4OM=
X-Gm-Gg: ASbGnctn8ICyJ6Mpr0oh20+LwNqqiTDr/LjqzxkStYDbecteCcrgUL630fpABpB6H1w
	YisW73+4D3Qcr76kgySeUfC+uwdGdxf9fW0Y3hm090dDOlTKTEjCxUsI/YwPm0lC5OCvSsPVUMT
	Bxr1dqJtQZeWj7JOQdYzCYg6r++eQQ4IyKXxM34PXBfW2aXnQ2w/1npDxhpJGGjCx9kykmdH9fo
	wfPVQuU9+1K6jQwcg5y
X-Google-Smtp-Source: AGHT+IEdEWrpK5zRp61Rm5Oqz+Ff9jb5eXg7WRe3quCxfmRXGa63fdVqzd+NlfhXi2/7R49uPtevZqi+MN3aNc7M34w=
X-Received: by 2002:a05:6402:354c:b0:61c:6ab8:574d with SMTP id
 4fb4d7f45d1cf-61c6ab870f5mr12010777a12.11.1756420186929; Thu, 28 Aug 2025
 15:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <CAEf4BzaYGA+6QYr64tEkMb0vcX4TtgMmKMQyqpviE=5OAmirFw@mail.gmail.com>
In-Reply-To: <CAEf4BzaYGA+6QYr64tEkMb0vcX4TtgMmKMQyqpviE=5OAmirFw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 29 Aug 2025 00:29:10 +0200
X-Gm-Features: Ac12FXwm18ivoRkv3KsCU0t4zzmDGZ7uOLZWnLRsi_yzKu2malL2sqd3SF_a99o
Message-ID: <CAP01T77_toZYoXM7GGx0v=VObqZkNnqQ-3Ly-a4UEJuf-uNuGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Aug 2025 at 23:03, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Fri, Aug 15, 2025 at 12:22=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Implementation of the bpf_task_work_schedule kfuncs.
> >
> > Main components:
> >  * struct bpf_task_work_context =E2=80=93 Metadata and state management=
 per task
> > work.
> >  * enum bpf_task_work_state =E2=80=93 A state machine to serialize work
> >  scheduling and execution.
> >  * bpf_task_work_schedule() =E2=80=93 The central helper that initiates
> > scheduling.
> >  * bpf_task_work_acquire() - Attempts to take ownership of the context,
> >  pointed by passed struct bpf_task_work, allocates new context if none
> >  exists yet.
> >  * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_work=
 runs.
> >  * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in softirq =
context)
> > to enqueue task work.
> >  * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BPF ma=
p entries.
> >
> > Flow of successful task work scheduling
> >  1) bpf_task_work_schedule_* is called from BPF code.
> >  2) Transition state from STANDBY to PENDING, marks context is owned by
> >  this task work scheduler
> >  3) irq_work_queue() schedules bpf_task_work_irq().
> >  4) Transition state from PENDING to SCHEDULING.
> >  4) bpf_task_work_irq() attempts task_work_add(). If successful, state
> >  transitions to SCHEDULED.
> >  5) Task work calls bpf_task_work_callback(), which transition state to
> >  RUNNING.
> >  6) BPF callback is executed
> >  7) Context is cleaned up, refcounts released, context state set back t=
o
> >  STANDBY.
> >
> > bpf_task_work_context handling
> > The context pointer is stored in bpf_task_work ctx field (u64) but
> > treated as an __rcu pointer via casts.
> > bpf_task_work_acquire() publishes new bpf_task_work_context by cmpxchg
> > with RCU initializer.
> > Read under the RCU lock only in bpf_task_work_acquire() when ownership
> > is contended.
> > Upon deleting map value, bpf_task_work_cancel_and_free() is detaching
> > context pointer from struct bpf_task_work and releases resources
> > if scheduler does not own the context or can be canceled (state =3D=3D
> > STANDBY or state =3D=3D SCHEDULED and callback canceled). If task work
> > scheduler owns the context, its state is set to FREED and scheduler is
> > expected to cleanup on the next state transition.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  kernel/bpf/helpers.c | 270 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 260 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index d2f88a9bc47b..346ae8fd3ada 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -25,6 +25,8 @@
> >  #include <linux/kasan.h>
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/task_work.h>
> > +#include <linux/irq_work.h>
> >
> >  #include "../../lib/kstrtox.h"
> >
> > @@ -3701,6 +3703,226 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign,=
 const char *s2__ign)
> >
> >  typedef void (*bpf_task_work_callback_t)(struct bpf_map *map, void *ke=
y, void *value);
> >
> > +enum bpf_task_work_state {
> > +       /* bpf_task_work is ready to be used */
> > +       BPF_TW_STANDBY =3D 0,
> > +       /* irq work scheduling in progress */
> > +       BPF_TW_PENDING,
> > +       /* task work scheduling in progress */
> > +       BPF_TW_SCHEDULING,
> > +       /* task work is scheduled successfully */
> > +       BPF_TW_SCHEDULED,
> > +       /* callback is running */
> > +       BPF_TW_RUNNING,
> > +       /* associated BPF map value is deleted */
> > +       BPF_TW_FREED,
> > +};
> > +
> > +struct bpf_task_work_context {
> > +       /* the map and map value associated with this context */
> > +       struct bpf_map *map;
> > +       void *map_val;
> > +       /* bpf_prog that schedules task work */
> > +       struct bpf_prog *prog;
> > +       /* task for which callback is scheduled */
> > +       struct task_struct *task;
> > +       enum task_work_notify_mode mode;
> > +       enum bpf_task_work_state state;
> > +       bpf_task_work_callback_t callback_fn;
> > +       struct callback_head work;
> > +       struct irq_work irq_work;
> > +       struct rcu_head rcu;
> > +} __aligned(8);
> > +
> > +static struct bpf_task_work_context *bpf_task_work_context_alloc(void)
> > +{
> > +       struct bpf_task_work_context *ctx;
> > +
> > +       ctx =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_wo=
rk_context));
> > +       if (ctx)
> > +               memset(ctx, 0, sizeof(*ctx));
> > +       return ctx;
> > +}
> > +
> > +static void bpf_task_work_context_free(struct rcu_head *rcu)
> > +{
> > +       struct bpf_task_work_context *ctx =3D container_of(rcu, struct =
bpf_task_work_context, rcu);
> > +       /* bpf_mem_free expects migration to be disabled */
> > +       migrate_disable();
> > +       bpf_mem_free(&bpf_global_ma, ctx);
> > +       migrate_enable();
> > +}
> > +
> > +static bool task_work_match(struct callback_head *head, void *data)
> > +{
> > +       struct bpf_task_work_context *ctx =3D container_of(head, struct=
 bpf_task_work_context, work);
> > +
> > +       return ctx =3D=3D data;
> > +}
> > +
> > +static void bpf_task_work_context_reset(struct bpf_task_work_context *=
ctx)
> > +{
> > +       bpf_prog_put(ctx->prog);
> > +       bpf_task_release(ctx->task);
> > +}
> > +
> > +static void bpf_task_work_callback(struct callback_head *cb)
> > +{
> > +       enum bpf_task_work_state state;
> > +       struct bpf_task_work_context *ctx;
> > +       u32 idx;
> > +       void *key;
> > +
> > +       ctx =3D container_of(cb, struct bpf_task_work_context, work);
> > +
> > +       /*
> > +        * Read lock is needed to protect map key and value access belo=
w, it has to be done before
> > +        * the state transition
> > +        */
> > +       rcu_read_lock_trace();
> > +       /*
> > +        * This callback may start running before bpf_task_work_irq() s=
witched the state to
> > +        * SCHEDULED so handle both transition variants SCHEDULING|SCHE=
DULED -> RUNNING.
> > +        */
> > +       state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNIN=
G);
> > +       if (state =3D=3D BPF_TW_SCHEDULED)
> > +               state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_TW=
_RUNNING);
> > +       if (state =3D=3D BPF_TW_FREED) {
> > +               rcu_read_unlock_trace();
> > +               bpf_task_work_context_reset(ctx);
> > +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_f=
ree);
> > +               return;
> > +       }
> > +
> > +       key =3D (void *)map_key_from_value(ctx->map, ctx->map_val, &idx=
);
> > +       migrate_disable();
> > +       ctx->callback_fn(ctx->map, key, ctx->map_val);
> > +       migrate_enable();
> > +       rcu_read_unlock_trace();
> > +       /* State is running or freed, either way reset. */
> > +       bpf_task_work_context_reset(ctx);
> > +       state =3D cmpxchg(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
> > +       if (state =3D=3D BPF_TW_FREED)
> > +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_f=
ree);
> > +}
> > +
> > +static void bpf_task_work_irq(struct irq_work *irq_work)
> > +{
> > +       struct bpf_task_work_context *ctx;
> > +       enum bpf_task_work_state state;
> > +       int err;
> > +
> > +       ctx =3D container_of(irq_work, struct bpf_task_work_context, ir=
q_work);
> > +
> > +       state =3D cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULIN=
G);
> > +       if (state =3D=3D BPF_TW_FREED)
> > +               goto free_context;
> > +
> > +       err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> > +       if (err) {
> > +               bpf_task_work_context_reset(ctx);
> > +               state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_T=
W_STANDBY);
> > +               if (state =3D=3D BPF_TW_FREED)
> > +                       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_c=
ontext_free);
> > +               return;
> > +       }
> > +       state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDU=
LED);
> > +       if (state =3D=3D BPF_TW_FREED && task_work_cancel_match(ctx->ta=
sk, task_work_match, ctx))
> > +               goto free_context; /* successful cancellation, release =
and free ctx */
> > +       return;
> > +
> > +free_context:
> > +       bpf_task_work_context_reset(ctx);
> > +       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
> > +}
> > +
> > +static struct bpf_task_work_context *bpf_task_work_context_acquire(str=
uct bpf_task_work *tw,
> > +                                                                  stru=
ct bpf_map *map)
> > +{
> > +       struct bpf_task_work_context *ctx, *old_ctx;
> > +       enum bpf_task_work_state state;
> > +       struct bpf_task_work_context __force __rcu **ppc =3D
> > +               (struct bpf_task_work_context __force __rcu **)&tw->ctx=
;
>
> we discussed this with Mykyta earlier offline, but I'll not it here:
> this looks pretty ugly, we should avoid these casts. We probably need
> struct bpf_task_work with opaque contents for user-visible API, and
> then have bpf_task_work_kern or something like that, where ctx will be
> just a struct bpf_task_work_ctx pointer
>
> > +
> > +       /* ctx pointer is RCU protected */
> > +       rcu_read_lock_trace();
> > +       ctx =3D rcu_dereference(*ppc);
>
> and here it should be enough to do just READ_ONCE(tw->ctx), either way
> rcu_dereference is wrong here because it checks for just classic
> rcu_read_lock() to be "held", while we use RCU Tasks Trace flavor for
> protection of the context struct

Couldn't you use rcu_dereference_check(), with rcu_read_lock_trace_held().

>
> > +       if (!ctx) {
> > +               ctx =3D bpf_task_work_context_alloc();
> > +               if (!ctx) {
> > +                       rcu_read_unlock_trace();
> > +                       return ERR_PTR(-ENOMEM);
> > +               }
> > +               old_ctx =3D unrcu_pointer(cmpxchg(ppc, NULL, RCU_INITIA=
LIZER(ctx)));
>
> similarly here, just `old_ctx =3D cmpxchg(tw->ctx, NULL, ctx);` seems
> much more preferable to me
>
> > +               /*
> > +                * If ctx is set by another CPU, release allocated memo=
ry.
> > +                * Do not fail, though, attempt stealing the work
> > +                */
> > +               if (old_ctx) {
> > +                       bpf_mem_free(&bpf_global_ma, ctx);
> > +                       ctx =3D old_ctx;
> > +               }
> > +       }
> > +       state =3D cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING);
> > +       /*
> > +        * We can unlock RCU, because task work scheduler (this codepat=
h)
> > +        * now owns the ctx or returning an error
> > +        */
> > +       rcu_read_unlock_trace();
> > +       if (state !=3D BPF_TW_STANDBY)
> > +               return ERR_PTR(-EBUSY);
> > +       return ctx;
> > +}
> > +
> > +static int bpf_task_work_schedule(struct task_struct *task, struct bpf=
_task_work *tw,
> > +                                 struct bpf_map *map, bpf_task_work_ca=
llback_t callback_fn,
> > +                                 struct bpf_prog_aux *aux, enum task_w=
ork_notify_mode mode)
> > +{
> > +       struct bpf_prog *prog;
> > +       struct bpf_task_work_context *ctx =3D NULL;
> > +       int err;
> > +
> > +       BTF_TYPE_EMIT(struct bpf_task_work);
> > +
> > +       prog =3D bpf_prog_inc_not_zero(aux->prog);
> > +       if (IS_ERR(prog))
> > +               return -EBADF;
> > +
> > +       if (!atomic64_read(&map->usercnt)) {
> > +               err =3D -EBADF;
> > +               goto release_prog;
> > +       }
>
> Kumar pointed out that race between map_release_uref() and this check.
> It looks like a simple fix would be to perform
> bpf_task_work_context_acquire() first, and only then check for
> map->usercnt, and if it dropped to zero, just clean up and return
> -EPERM?

I believe that should work. As long as we don't create new objects to
be freed once usercnt has already dropped (and parallel racing free
already done).

>
> > +       task =3D bpf_task_acquire(task);
> > +       if (!task) {
> > +               err =3D -EPERM;
> > +               goto release_prog;
> > +       }
> > +       ctx =3D bpf_task_work_context_acquire(tw, map);
> > +       if (IS_ERR(ctx)) {
> > +               err =3D PTR_ERR(ctx);
> > +               goto release_all;
> > +       }
> > +
> > +       ctx->task =3D task;
> > +       ctx->callback_fn =3D callback_fn;
> > +       ctx->prog =3D prog;
> > +       ctx->mode =3D mode;
> > +       ctx->map =3D map;
> > +       ctx->map_val =3D (void *)tw - map->record->task_work_off;
> > +       init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> > +       init_task_work(&ctx->work, bpf_task_work_callback);
> > +
> > +       irq_work_queue(&ctx->irq_work);
> > +
> > +       return 0;
> > +
> > +release_all:
> > +       bpf_task_release(task);
> > +release_prog:
> > +       bpf_prog_put(prog);
> > +       return err;
> > +}
> > +
> >  /**
> >   * bpf_task_work_schedule_signal - Schedule BPF callback using task_wo=
rk_add with TWA_SIGNAL mode
> >   * @task: Task struct for which callback should be scheduled
> > @@ -3711,13 +3933,11 @@ typedef void (*bpf_task_work_callback_t)(struct=
 bpf_map *map, void *key, void *v
> >   *
> >   * Return: 0 if task work has been scheduled successfully, negative er=
ror code otherwise
> >   */
> > -__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task=
,
> > -                                             struct bpf_task_work *tw,
> > +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task=
, struct bpf_task_work *tw,
> >                                               struct bpf_map *map__map,
> > -                                             bpf_task_work_callback_t =
callback,
> > -                                             void *aux__prog)
> > +                                             bpf_task_work_callback_t =
callback, void *aux__prog)
>
> this should have been folded into patch 1?
>
> >  {
> > -       return 0;
> > +       return bpf_task_work_schedule(task, tw, map__map, callback, aux=
__prog, TWA_SIGNAL);
> >  }
> >
> >  /**
> > @@ -3731,19 +3951,47 @@ __bpf_kfunc int bpf_task_work_schedule_signal(s=
truct task_struct *task,
> >   *
> >   * Return: 0 if task work has been scheduled successfully, negative er=
ror code otherwise
> >   */
> > -__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task=
,
> > -                                             struct bpf_task_work *tw,
> > +__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task=
, struct bpf_task_work *tw,
> >                                               struct bpf_map *map__map,
> > -                                             bpf_task_work_callback_t =
callback,
> > -                                             void *aux__prog)
> > +                                             bpf_task_work_callback_t =
callback, void *aux__prog)
> >  {
>
> same, rebasing/refactoring artifacts
>
> > -       return 0;
> > +       enum task_work_notify_mode mode;
> > +
> > +       mode =3D task =3D=3D current && in_nmi() ? TWA_NMI_CURRENT : TW=
A_RESUME;
> > +       return bpf_task_work_schedule(task, tw, map__map, callback, aux=
__prog, mode);
> >  }
> >
> >  __bpf_kfunc_end_defs();
> >
> >  void bpf_task_work_cancel_and_free(void *val)
> >  {
> > +       struct bpf_task_work *tw =3D val;
> > +       struct bpf_task_work_context *ctx;
> > +       enum bpf_task_work_state state;
> > +
> > +       /* No need do rcu_read_lock as no other codepath can reset this=
 pointer */
>
> typo: to do
>
> > +       ctx =3D unrcu_pointer(xchg((struct bpf_task_work_context __forc=
e __rcu **)&tw->ctx, NULL));
> > +       if (!ctx)
> > +               return;
> > +       state =3D xchg(&ctx->state, BPF_TW_FREED);
> > +
> > +       switch (state) {
> > +       case BPF_TW_SCHEDULED:
> > +               /* If we can't cancel task work, rely on task work call=
back to free the context */
> > +               if (!task_work_cancel_match(ctx->task, task_work_match,=
 ctx))
> > +                       break;
> > +               bpf_task_work_context_reset(ctx);
>
> As Kumar pointed out earlier, this can be called from NMI, so we can't
> just cancel here, we need to schedule irq_work to do the cancellation.
>
> Good thing is that if we were in SCHEDULED state, then we can simply
> reuse irq_work struct from task_work_ctx (please contract "context"
> into "ctx", btw), and there is no change to the state machine, it's
> just a slightly delayed clean up (and we'll remain in terminal FREED
> state anyways).
>
> Bad news: that extra irq_work step mean we have to be careful about
> ctx lifetime, because if task_work callback couldn't be cancelled, we
> might have a situation where memory is freed by task_work callback
> itself (when it fails to transition to RUNNING) while we wait for
> irq_work callback to be run, and then we get freed memory dereference.
>
> So I'm thinking that besides RCU protection we should also have a
> simple refcounting protection for bpf_task_work_ctx itself. I don't
> think that's a problem performance wise, and the nice thing is that
> there will be less direct `call_rcu_tasks_trace(&ctx->rcu,
> bpf_task_work_context_free);` sprinkled around. Instead we'll have
> just bpf_task_work_put(ctx), which might call RCU-delayed freeing.
>
> We might want to roll bpf_task_work_context_reset logic into it,
> conditionally (but we need to make sure that we reset prog and task
> pointers to NULL during a non-freeing context reset).

This also sounds workable. I'll take a look in v5.

>
> > +               fallthrough;
> > +       case BPF_TW_STANDBY:
> > +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_f=
ree);
> > +               break;
> > +       /* In all below cases scheduling logic should detect context st=
ate change and cleanup */
> > +       case BPF_TW_SCHEDULING:
> > +       case BPF_TW_PENDING:
> > +       case BPF_TW_RUNNING:
> > +       default:
> > +               break;
> > +       }
> >  }
> >
> >  BTF_KFUNCS_START(generic_btf_ids)
> > @@ -3769,6 +4017,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
> >
> >  #ifdef CONFIG_CGROUPS
> >  BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NU=
LL)
> > --
> > 2.50.1
> >

