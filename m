Return-Path: <bpf+bounces-78415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E985AD0C71F
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F083300EDAE
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538433D6CE;
	Fri,  9 Jan 2026 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzTVmm4v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272662ED846
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997175; cv=none; b=TWJR4y8G1ljMlcitqTaUHnfqpy6YWFsQ4mTj/5quhnYT13R6fbzukPlpTauzumcdDqzYpOn/eZDEXFVeOzdkTiQAMoZ6TNq9Xgu8EtYU0dfs+A7dwEU/ECHJ/xeULHoBAHzsQwFUVSZwLt+6bQ4TJ8r6zHekonSsOg/GY805zEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997175; c=relaxed/simple;
	bh=0TkQIfSFtSPhltDOt4XZjBYsUInVtVH25EKuZG7Eumo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPiMrPx7NMaudsPvgLJcgO/ABWii/+16eghQ15SodFonPI10pOHMduCqOcogbwas6BSbwS7E6+L0/8ilNw2djjcjp9pPIjQmgqZ83x5W0zRMHd4rJW9Z+F0WwjNqkYA7kppb34UAo9I4rOwAe+UlaXA3dnBA6Qm67zO3lPvqO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzTVmm4v; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso1914664a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997173; x=1768601973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir9B1dI/t+AyB8d3Dum0eQSZ4HfLMtAgDPC/yneM914=;
        b=LzTVmm4vKsQHKQ1/+82YHyW8R1T56ucZv9TdzUVPZzOyOUilp7GWUIMu0p24dCuYI5
         FvrPjmztvc9PYuPIDQLpA96cglQJJRP0UuxbC5OaZdeZzIp/TtH9MuHH4HgyT92TRouo
         NFV1v1W9R+yLJAuQpu6VXCTLLRU0BIXmF0ue2gSoX7/q5LrYn8D6wWHE8PPa5zvok7Hu
         LAz3EALni49YVhZiiXs+kIrc9tGO/EWhAmwdU+Gw0JN2Ec/Q60ksLEUwFrsoO7QbXWVz
         ODsgM276d4nlncjxQBP1ehGUE51BZw1AAAJBH4irNbr+lQPYx0gtQp1ldFqyUYPMT5hD
         dAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997173; x=1768601973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ir9B1dI/t+AyB8d3Dum0eQSZ4HfLMtAgDPC/yneM914=;
        b=fnMAVv1ZF5zJ6vQZ4kwjmg+gQtG4oEJPaR823YbMo52CLBGnBGRbPQtlaWyqqdwQ9n
         zpoO37lZ2/IpSK4a99GeY23XdxDrVNcQVC9STTA2Km8du2jJ8bFt8A5Ez7yg44srNYqT
         /9fGiBn7aRwWpeJn49BfHkaWrcOHxfNULwIZhdfPDTQ6Ps6BH1HndYF+QmBtsuMr9wmS
         J6a+JdENNS7/Zmb1YwMYnXHD9HP4BBaa8nohJqi56RrFyLzjV56xvUhEfkWzgyppUgNI
         SWrgi6Ez3j6173n6j/CUUgi9Ve+X3oxaDR8+L9yKF84vY+hCPPUVWpCMdimQf7HNhUzX
         1fww==
X-Gm-Message-State: AOJu0Yxa756pU5ibu4p+AumjGVT20iew7Exd5/ZzDM7FrlRoQ8Sc3A0s
	FZq67HIjtNLUjhWPifsifZHVoiKfGTMoqCW1RuEhiXqvHgaye6OZAVVN3bFuAB0/ImZyDKL2WCt
	gnFMqdq4KZMb5h0RQA26yQ1x/iQn1CBFZ4g==
X-Gm-Gg: AY/fxX4dcj4iEl+2VfbKDlG1qRKXlqw+BZ6u7u9qMqU1ETcEzdEN2SBORkpAnBWajCn
	dEfbZQP5VP196PUuCwofnm4U/fufZOo15AjYaxoRiUE6ndmm1qucWWMzzokSAXxrr6M+5h3utDJ
	OsXDA2Y+sX0hNwzH5yxHjqlVRcs90OYBquYrcHCBB6P422LITwlUejdbX6viatZIN565QdxQc3C
	NGErvOQ3DTHj/rfcq2z7rCy/OZExciOrdRNDjKTEu/0MS70RUDyUQhdwT1Gzrlv75+G8fubpVil
	KB7H7tsR
X-Google-Smtp-Source: AGHT+IGlR7dnXwhccU3NQODBdqqUoLKMJo3LSUnsBXoyzQCPjC5KFe9SKwAS0J8qJNc4okMt9/BJzhQBok4YuKFKZsQ=
X-Received: by 2002:a17:90b:1c87:b0:34c:635f:f855 with SMTP id
 98e67ed59e1d1-34f68c33ab8mr11610288a91.7.1767997173466; Fri, 09 Jan 2026
 14:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:19:11 -0800
X-Gm-Features: AQt7F2r1tJmVhN7gBM2oOxSoGC6zkHr5zSxhyyMAFqvI9XJuRvpBm9zpxD7OyFc
Message-ID: <CAEf4BzYpZPtBFyceDfELDTg8fHFTOC+cqeTvvtWyzOtMqRc5iQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 05/10] bpf: Enable bpf timer and workqueue use in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:49=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor bpf timer and workqueue helpers to allow calling them from NMI
> context by making all operations lock-free and deferring NMI-unsafe
> work to irq_work.
>
> Previously, bpf_timer_start(), and bpf_wq_start()
> could not be called from NMI context because they acquired
> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
> patch removes these limitations.
>
> Key changes:
>  * Remove bpf_spin_lock from struct bpf_async_kern. Replace locked
>    operations with atomic cmpxchg() for initialization and xchg() for
>    cancel and free.
>  * Add per-async irq_work to defer NMI-unsafe operations (hrtimer_start,
>    hrtimer_try_to_cancel, schedule_work) from NMI to softirq context.
>  * Use the lock-free mpmc_cell (added in the previous commit) to pass
>    operation commands (start/cancel/free) along with their parameters
>    (nsec, mode) from NMI-safe callers to the irq_work handler.
>  * Add reference counting to bpf_async_cb to ensure the object stays
>    alive until all scheduled irq_work completes and the timer/work
>    callback finishes.
>  * Move bpf_prog_put() to RCU callback to handle races between
>    set_callback() and cancel_and_free().
>
> This enables BPF programs attached to NMI-context hooks (perf
> events) to use timers and workqueues for deferred processing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 288 ++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 191 insertions(+), 97 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dc8ed948321e6c535d2cc2e8f9fbdd0636cdcabf..b90b005a17e1de9c0c62056a6=
65d124b883c6320 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -29,6 +29,7 @@
>  #include <linux/task_work.h>
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
> +#include <mpmc_cell.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -1095,6 +1096,23 @@ static void *map_key_from_value(struct bpf_map *ma=
p, void *value, u32 *arr_idx)
>         return (void *)value - round_up(map->key_size, 8);
>  }
>
> +enum bpf_async_type {
> +       BPF_ASYNC_TYPE_TIMER =3D 0,
> +       BPF_ASYNC_TYPE_WQ,
> +};
> +
> +enum bpf_async_op {
> +       BPF_ASYNC_START,
> +       BPF_ASYNC_CANCEL,
> +       BPF_ASYNC_CANCEL_AND_FREE,
> +};
> +
> +struct bpf_async_cmd {
> +       u64 nsec;
> +       u32 mode;
> +       u32 op;
> +};
> +
>  struct bpf_async_cb {
>         struct bpf_map *map;
>         struct bpf_prog *prog;
> @@ -1105,6 +1123,12 @@ struct bpf_async_cb {
>                 struct work_struct delete_work;
>         };
>         u64 flags;
> +       struct irq_work worker;
> +       struct bpf_mpmc_cell_ctl ctl;

nit: I'd call it more meaningful "cmd_cell"

> +       struct bpf_async_cmd cmd[2];
> +       atomic_t last_seq;
> +       refcount_t refcnt;
> +       enum bpf_async_type type;
>  };
>
>  /* BPF map elements can contain 'struct bpf_timer'.
> @@ -1142,18 +1166,8 @@ struct bpf_async_kern {
>                 struct bpf_hrtimer *timer;
>                 struct bpf_work *work;
>         };
> -       /* bpf_spin_lock is used here instead of spinlock_t to make
> -        * sure that it always fits into space reserved by struct bpf_tim=
er
> -        * regardless of LOCKDEP and spinlock debug flags.
> -        */
> -       struct bpf_spin_lock lock;

we have to leave dummy placeholder instead of preserve bpf_async_kern
size for ABI compatibility

>  } __attribute__((aligned(8)));
>
> -enum bpf_async_type {
> -       BPF_ASYNC_TYPE_TIMER =3D 0,
> -       BPF_ASYNC_TYPE_WQ,
> -};
> -
>  static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>
>  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
> @@ -1219,6 +1233,13 @@ static void bpf_async_cb_rcu_free(struct rcu_head =
*rcu)
>  {
>         struct bpf_async_cb *cb =3D container_of(rcu, struct bpf_async_cb=
, rcu);
>
> +       /*
> +        * Drop the last reference to prog only after RCU GP, as set_call=
back()
> +        * may race with cancel_and_free()
> +        */
> +       if (cb->prog)
> +               bpf_prog_put(cb->prog);
> +
>         kfree_nolock(cb);
>  }
>
> @@ -1246,18 +1267,17 @@ static void bpf_timer_delete_work(struct work_str=
uct *work)
>         call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
>  }
>
> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async);
> +static void bpf_async_irq_worker(struct irq_work *work);
> +
>  static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map=
 *map, u64 flags,
>                             enum bpf_async_type type)
>  {
> -       struct bpf_async_cb *cb;
> +       struct bpf_async_cb *cb, *old_cb;
>         struct bpf_hrtimer *t;
>         struct bpf_work *w;
>         clockid_t clockid;
>         size_t size;
> -       int ret =3D 0;
> -
> -       if (in_nmi())
> -               return -EOPNOTSUPP;
>
>         switch (type) {
>         case BPF_ASYNC_TYPE_TIMER:
> @@ -1270,18 +1290,13 @@ static int __bpf_async_init(struct bpf_async_kern=
 *async, struct bpf_map *map, u
>                 return -EINVAL;
>         }
>
> -       __bpf_spin_lock_irqsave(&async->lock);
>         t =3D async->timer;

READ_ONCE()?

> -       if (t) {
> -               ret =3D -EBUSY;
> -               goto out;
> -       }
> +       if (t)
> +               return -EBUSY;
>
>         cb =3D bpf_map_kmalloc_nolock(map, size, 0, map->numa_node);
> -       if (!cb) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> +       if (!cb)
> +               return -ENOMEM;
>
>         switch (type) {
>         case BPF_ASYNC_TYPE_TIMER:
> @@ -1304,9 +1319,19 @@ static int __bpf_async_init(struct bpf_async_kern =
*async, struct bpf_map *map, u
>         cb->map =3D map;
>         cb->prog =3D NULL;
>         cb->flags =3D flags;
> +       cb->worker =3D IRQ_WORK_INIT(bpf_async_irq_worker);
> +       bpf_mpmc_cell_init(&cb->ctl, &cb->cmd[0], &cb->cmd[1]);
> +       refcount_set(&cb->refcnt, 1); /* map's reference */
> +       atomic_set(&cb->last_seq, 0);
> +       cb->type =3D type;
>         rcu_assign_pointer(cb->callback_fn, NULL);
>
> -       WRITE_ONCE(async->cb, cb);
> +       old_cb =3D cmpxchg(&async->cb, NULL, cb);
> +       if (old_cb) {
> +               /* Lost the race to initialize this bpf_async_kern, drop =
the allocated object */
> +               kfree_nolock(cb);
> +               return -EBUSY;
> +       }
>         /* Guarantee the order between async->cb and map->usercnt. So
>          * when there are concurrent uref release and bpf timer init, eit=
her
>          * bpf_timer_cancel_and_free() called by uref release reads a no-=
NULL
> @@ -1317,13 +1342,11 @@ static int __bpf_async_init(struct bpf_async_kern=
 *async, struct bpf_map *map, u
>                 /* maps with timers must be either held by user space
>                  * or pinned in bpffs.
>                  */
> -               WRITE_ONCE(async->cb, NULL);
> -               kfree_nolock(cb);
> -               ret =3D -EPERM;
> +               __bpf_async_cancel_and_free(async);
> +               return -EPERM;
>         }
> -out:
> -       __bpf_spin_unlock_irqrestore(&async->lock);
> -       return ret;
> +
> +       return 0;
>  }
>
>  BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_ma=
p *, map,
> @@ -1354,6 +1377,61 @@ static const struct bpf_func_proto bpf_timer_init_=
proto =3D {
>         .arg3_type      =3D ARG_ANYTHING,
>  };
>
> +static int bpf_async_schedule_op(struct bpf_async_cb *cb, u32 op, u64 ns=
ec, u32 timer_mode)
> +{
> +       struct bpf_mpmc_cell_ctl *ctl =3D &cb->ctl;
> +       struct bpf_async_cmd *cmd;
> +
> +       cmd =3D bpf_mpmc_cell_write_begin(ctl);
> +       if (!cmd)
> +               return -EBUSY;
> +
> +       cmd->nsec =3D nsec;
> +       cmd->mode =3D timer_mode;
> +       cmd->op =3D op;
> +
> +       bpf_mpmc_cell_write_commit(ctl);
> +
> +       if (!refcount_inc_not_zero(&cb->refcnt))
> +               return -EBUSY;
> +
> +       irq_work_queue(&cb->worker);

if not in NMI and not irq-disabled mode, we should be able to call
bpf_async_irq_worker() directly here and execute action synchronously
without irq_work execution. Add TODO so we don't forget to implement
that before patch set lands?

> +
> +       return 0;
> +}
> +
> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op =
*op,
> +                            u64 *nsec, u32 *flags)
> +{
> +       struct bpf_mpmc_cell_ctl *ctl =3D &cb->ctl;
> +       struct bpf_async_cmd *cmd;
> +       u32 seq, last_seq;
> +
> +       do {
> +               last_seq =3D atomic_read_acquire(&cb->last_seq);
> +               cmd =3D bpf_mpmc_cell_read_begin(ctl, &seq);
> +
> +               /* Return -EBUSY if current seq is consumed by another re=
ader */
> +               if (seq =3D=3D last_seq)
> +                       return -EBUSY;
> +
> +               *nsec =3D cmd->nsec;
> +               *flags =3D cmd->mode;
> +               *op =3D cmd->op;
> +
> +       /*
> +        * Retry read on one of the two conditions:
> +        *  1. Some writer produced new snapshot while we were reading. O=
ur snapshot may have been
> +        *     modified, and not consistent.
> +        *  2. Another reader consumed some snapshot. We need to validate=
 that this snapshot is not
> +        *     consumed. This prevents duplicate op processing.
> +        */
> +       } while (bpf_mpmc_cell_read_end(ctl, seq) =3D=3D -EAGAIN ||

can read_end return any other error? If yes, how do we handle? If not,
why hard-code -EAGAIN here, maybe just `< 0` check?

> +                atomic_cmpxchg_release(&cb->last_seq, last_seq, seq) !=
=3D last_seq);

nit: repeat condition is complicated enough (and requires multi-line
weirdly indented comment), so I'd do:

while (true) {
   ....

    if (bpf_mpmc_cell_read_end(ctl, seq) < 0)
        continue;
    if (atomic_cmpxchg() =3D=3D last_seq) /* success*/
        break;


(or invert cmpxchg + continue, and then stand-alone break)

> +
> +       return 0;
> +}
> +
>  static int __bpf_async_set_callback(struct bpf_async_kern *async, void *=
callback_fn,
>                                     struct bpf_prog *prog)
>  {
> @@ -1395,22 +1473,19 @@ static const struct bpf_func_proto bpf_timer_set_=
callback_proto =3D {
>         .arg2_type      =3D ARG_PTR_TO_FUNC,
>  };
>
> -BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, =
u64, flags)
> +BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, =
u64, flags)
>  {
>         struct bpf_hrtimer *t;
> -       int ret =3D 0;
> -       enum hrtimer_mode mode;
> +       u32 mode;
>
> -       if (in_nmi())
> -               return -EOPNOTSUPP;
>         if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
>                 return -EINVAL;
> -       __bpf_spin_lock_irqsave(&timer->lock);
> -       t =3D timer->timer;
> -       if (!t || !t->cb.prog) {
> -               ret =3D -EINVAL;
> -               goto out;
> -       }
> +
> +       guard(rcu)();
> +
> +       t =3D async->timer;

READ_ONCE()

> +       if (!t || !t->cb.prog)
> +               return -EINVAL;
>
>         if (flags & BPF_F_TIMER_ABS)
>                 mode =3D HRTIMER_MODE_ABS_SOFT;
> @@ -1420,10 +1495,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern =
*, timer, u64, nsecs, u64, fla
>         if (flags & BPF_F_TIMER_CPU_PIN)
>                 mode |=3D HRTIMER_MODE_PINNED;
>
> -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> -out:
> -       __bpf_spin_unlock_irqrestore(&timer->lock);
> -       return ret;
> +       return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode=
);
>  }
>
>  static const struct bpf_func_proto bpf_timer_start_proto =3D {
> @@ -1435,17 +1507,6 @@ static const struct bpf_func_proto bpf_timer_start=
_proto =3D {
>         .arg3_type      =3D ARG_ANYTHING,
>  };
>
> -static void drop_prog_refcnt(struct bpf_async_cb *async)
> -{
> -       struct bpf_prog *prog =3D async->prog;
> -
> -       if (prog) {
> -               bpf_prog_put(prog);
> -               async->prog =3D NULL;
> -               rcu_assign_pointer(async->callback_fn, NULL);
> -       }
> -}
> -
>  BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
>  {
>         struct bpf_hrtimer *t, *cur_t;
> @@ -1513,27 +1574,16 @@ static const struct bpf_func_proto bpf_timer_canc=
el_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_TIMER,
>  };
>
> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async=
_kern *async)
> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
>  {
>         struct bpf_async_cb *cb;
>
> -       /* Performance optimization: read async->cb without lock first. *=
/
> -       if (!READ_ONCE(async->cb))
> -               return NULL;
> -
> -       __bpf_spin_lock_irqsave(&async->lock);
> -       /* re-read it under lock */
> -       cb =3D async->cb;
> +       cb =3D xchg(&async->cb, NULL);
>         if (!cb)
> -               goto out;
> -       drop_prog_refcnt(cb);
> -       /* The subsequent bpf_timer_start/cancel() helpers won't be able =
to use
> -        * this timer, since it won't be initialized.
> -        */
> -       WRITE_ONCE(async->cb, NULL);
> -out:
> -       __bpf_spin_unlock_irqrestore(&async->lock);
> -       return cb;
> +               return;
> +
> +       /* Consume map's refcnt */
> +       irq_work_queue(&cb->worker);

hm... this is subtle (and maybe broken?) irq_work_queue() can be
ignored here, if there is already another one scheduled, so I think
your clever idea with CANCEL_AND_FREE being done based on this
refcount drop is flawed...

CANCEL_AND_FREE has to succeed, so it's out-of-bounds signal that
shouldn't be going through that command cell, yes. But can't we just
have a simple one-way bool that will be set to true here (+ memory
barriers, maybe), and then irq_work_queue() scheduled. If there is irq
work is scheduled, it will inevitable will see this flag (even if it's
not our callback), and if not, then irq_work_queue() will successfully
schedule callback which will also clean up.


also, same about TODO for irq_work_queue() avoidance


>  }
>
>  static void bpf_timer_delete(struct bpf_hrtimer *t)
> @@ -1588,19 +1638,76 @@ static void bpf_timer_delete(struct bpf_hrtimer *=
t)
>         }
>  }
>
> +static void bpf_async_process_op(struct bpf_async_cb *cb, u32 op,
> +                                u64 timer_nsec, u32 timer_mode)
> +{
> +       switch (cb->type) {
> +       case BPF_ASYNC_TYPE_TIMER: {
> +               struct bpf_hrtimer *t =3D container_of(cb, struct bpf_hrt=
imer, cb);
> +
> +               switch (op) {
> +               case BPF_ASYNC_START:
> +                       hrtimer_start(&t->timer, ns_to_ktime(timer_nsec),=
 timer_mode);
> +                       break;
> +               case BPF_ASYNC_CANCEL:
> +                       hrtimer_try_to_cancel(&t->timer);
> +                       break;
> +               case BPF_ASYNC_CANCEL_AND_FREE:
> +                       bpf_timer_delete(t);
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       }
> +       case BPF_ASYNC_TYPE_WQ: {
> +               struct bpf_work *w =3D container_of(cb, struct bpf_work, =
cb);
> +
> +               switch (op) {
> +               case BPF_ASYNC_START:
> +                       schedule_work(&w->work);
> +                       break;
> +               case BPF_ASYNC_CANCEL_AND_FREE:
> +                       /*
> +                        * Trigger cancel of the sleepable work, but *do =
not* wait for
> +                        * it to finish.
> +                        * kfree will be called once the work has finishe=
d.
> +                        */
> +                       schedule_work(&w->delete_work);
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       }
> +       }
> +}
> +
> +static void bpf_async_irq_worker(struct irq_work *work)
> +{
> +       struct bpf_async_cb *cb =3D container_of(work, struct bpf_async_c=
b, worker);
> +       u32 op, timer_mode;
> +       u64 nsec;
> +       int err;
> +
> +       err =3D bpf_async_read_op(cb, &op, &nsec, &timer_mode);
> +       if (err)
> +               goto out;
> +
> +       bpf_async_process_op(cb, op, nsec, timer_mode);
> +
> +out:
> +       if (refcount_dec_and_test(&cb->refcnt))
> +               bpf_async_process_op(cb, BPF_ASYNC_CANCEL_AND_FREE, 0, 0)=
;
> +}
> +
>  /*
>   * This function is called by map_delete/update_elem for individual elem=
ent and
>   * by ops->map_release_uref when the user space reference to a map reach=
es zero.
>   */
>  void bpf_timer_cancel_and_free(void *val)
>  {
> -       struct bpf_hrtimer *t;
> -
> -       t =3D (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
> -       if (!t)
> -               return;
> -
> -       bpf_timer_delete(t);
> +       __bpf_async_cancel_and_free(val);
>  }
>
>  /* This function is called by map_delete/update_elem for individual elem=
ent and
> @@ -1608,19 +1715,7 @@ void bpf_timer_cancel_and_free(void *val)
>   */
>  void bpf_wq_cancel_and_free(void *val)
>  {
> -       struct bpf_work *work;
> -
> -       BTF_TYPE_EMIT(struct bpf_wq);
> -
> -       work =3D (struct bpf_work *)__bpf_async_cancel_and_free(val);
> -       if (!work)
> -               return;
> -       /* Trigger cancel of the sleepable work, but *do not* wait for
> -        * it to finish if it was running as we might not be in a
> -        * sleepable context.
> -        * kfree will be called once the work has finished.
> -        */
> -       schedule_work(&work->delete_work);
> +       __bpf_async_cancel_and_free(val);
>  }
>
>  BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
> @@ -3093,15 +3188,14 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, u=
nsigned int flags)
>         struct bpf_async_kern *async =3D (struct bpf_async_kern *)wq;
>         struct bpf_work *w;
>
> -       if (in_nmi())
> -               return -EOPNOTSUPP;
>         if (flags)
>                 return -EINVAL;
>         w =3D READ_ONCE(async->work);
>         if (!w || !READ_ONCE(w->cb.prog))
>                 return -EINVAL;
>
> -       schedule_work(&w->work);
> +       bpf_async_schedule_op(&w->cb, BPF_ASYNC_START, 0, 0);
> +
>         return 0;
>  }
>
>
> --
> 2.52.0
>

