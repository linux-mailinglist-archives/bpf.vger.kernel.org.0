Return-Path: <bpf+bounces-79166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0ED295C7
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A0830424AD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8081CD15;
	Fri, 16 Jan 2026 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw2SpgAg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333014C92
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521732; cv=none; b=p556o50NxmrPMs2uwtg6LEXERjgZvlHk9odlqXOJ6nOnsUAwlLCo46vqITaQUMR1OwcZ0SMmZwVnaikIVK1JTSSW4xjSFjY/6XrQjtV2M2PDNJfpU76m1fnbOsVhesBSCIT8CpSYjv/OzSTYLUxa1YpgU19uWB8MPlV3FYuFYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521732; c=relaxed/simple;
	bh=6OFWJn8DvTDmcj33HFroAe98DHCQ3TpoHyr1vV8MtOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doM6TONge3pn6RbGY2JwSxCqtXFfqcDns6vRnqkK5NjQ94Eg2nvJ4CEoZZIjXRccze4fR6hi769XNKa0ORpaHvxwTDZHShcRCbsfycNqQ+ceOlvRcpbIl4ukthmo+Yn9Qn9s2sC2j2jOYf+DaoS87U5d30iJuQ5Dz+H8d/VI5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw2SpgAg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1624868a91.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 16:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768521719; x=1769126519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP6rtd9ZkcoL44VzMFUD5KhtPFvie6wXfDlmCkUzSpg=;
        b=Qw2SpgAgB5CQHDXl8GqiE9qQKWVhwReO5APU6AoRXK8h1nM/v5GHbRJA3aEt3CJU2B
         7qZWahzvcl2IoyoWI8i/XKCwFDrLhOBgeV5zitX11yashCz11H5UHB1mKAp17u+tvyvN
         nfTi8D6IfvDUP0vtIOMu+gtI3jLc7cVWkHscjipbavzKVcVorZiyaZFC9wfm0/PCwaEV
         XalSj74D9vnhfXXSwneR3AmiyrOpYpZwWSOU/e/wvF6It9IrsBVlpYiyBhJBnQw64lmt
         PZnX5xjxpmxivDlgIpwumONta/Sx2x0zFyU4/E0+2PWLqCFjLudFmGtJdaIbC4/At1qV
         mGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521719; x=1769126519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zP6rtd9ZkcoL44VzMFUD5KhtPFvie6wXfDlmCkUzSpg=;
        b=h1avn98oU/YJi7Rn4QWquT8VLwglZX/RJ5jgeW7WfAySR8rfcQwUxO5FpT4j2CaddG
         TK9UJAWzP8b82q+8paM2KQs8RPQHWjElwnU3ZSHdRD70bogT+7OFFf/DNMi0ju5wPy34
         Iv6aljKw+1QzJ0Xj61m58rPBQPmaLi7r/HzeaAesJ5sHLgiGeXKfVFu1Q6iKOYgxoKNA
         41rWvZpcINYvWMU4Hf+9RhJxXchD0xbtXjQkazi65qKadIy4Zt3NiP0jG7K+0LbdeoMv
         dP84wCZpS9gk8KXikyUHRtoBW8a+w/7Ar05F4JuxLzasHLRKhvChzSAoPdSOsd2T7Hxu
         1p3w==
X-Gm-Message-State: AOJu0YwSdLVfg9foaX4mQ7mff+KPMvMjl9wLJyInB3B81FKcbfYFJIoQ
	Lgw8rYyx7SyQTCS57rQ0i2GTw8cL2NSJjxCJFR12Ih1Pw6YF/Uh6WbsvP520XVlQsWWKvxpN7c/
	VYkwB9QMMo6rxc1ivvKmG94brLl1HS1JhNw==
X-Gm-Gg: AY/fxX5M5W+d3ICXP4CaGxrC/ugv0Ad+zooSUbLQbRGNBZ0LkGgzFU3h+iOFhCfBKKY
	CK4d7e6aEujax+QEtGaNa1ZODS7YZPrk6T2ABrhnA6urVo27Botjfzwh6vxUdCoktFA9e8BS3s9
	F+kiGixzLUHN7oNGutR5U1mc8sLgLy1uZdXQCT8Nf/aJc/rM7hPRRPGfkJT9XsTqQKXcmkJS5Gc
	79Lg5z8wUXLRSDbjGS3gJUx+cbcnkyQVr3bhozM3MDt1lMtxIpdGfDZ18Az+Ru1NMlnchCpdTpK
	K0wx0wHK
X-Received: by 2002:a17:90b:5347:b0:343:6a63:85d5 with SMTP id
 98e67ed59e1d1-35272cdea08mr1002893a91.16.1768521719187; Thu, 15 Jan 2026
 16:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com> <20260115-timer_nolock-v5-5-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-5-15e3aef2703d@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 16:01:45 -0800
X-Gm-Features: AZwV_QjrCWNcUiHcLAusIMbsHK4YI6iCHgOEK47fRKET26fvzQZnqMSR1z1a4gI
Message-ID: <CAEf4BzbFdmKzxe_qaNW5iWFXL9b1dKHEw3EbR+g_hHNqd5fhSQ@mail.gmail.com>
Subject: Re: [PATCH RFC v5 05/10] bpf: Enable bpf timer and workqueue use in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:29=E2=80=AFAM Mykyta Yatsenko
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
>  * Use the lock-free seqcount_latch_t to pass operation
>    commands (start/cancel/free) along with their parameters
>    (nsec, mode) from NMI-safe callers to the irq_work handler.
>  * Add reference counting to bpf_async_cb to ensure the object stays
>    alive until all scheduled irq_work completes and the timer/work
>    callback finishes.
>  * Move bpf_prog_put() to RCU callback to handle races between
>    set_callback() and cancel_and_free().
>  * Refactor __bpf_async_set_callback() getting rid of locks.
>    Each iteration acquires a new reference and stores it
>    in cb->prog via xchg. The previous value is retrieved and released.
>    The loop condition checks if both cb->prog and cb->callback_fn match
>    what we just wrote. If either differs, a concurrent writer overwrote
>    our value, and we must retry.
>    When we retry, our previously-stored prog was already put() by the
>    concurrent writer or we put() it after xchg().

you already described that in earlier patch, no need to repeat that here, I=
MO

>
> This enables BPF programs attached to NMI-context hooks (perf
> events) to use timers and workqueues for deferred processing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 335 ++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 225 insertions(+), 110 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 61ba4f6b741cc05b4a7a73a0322a23874bfd8e83..8c1ed75af072f64f2a63afd90=
ad40a962e8e46b0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -29,6 +29,7 @@
>  #include <linux/task_work.h>
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
> +#include <linux/seqlock.h>
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

enum bpf_async_op here?

> +};
> +
>  struct bpf_async_cb {
>         struct bpf_map *map;
>         struct bpf_prog *prog;
> @@ -1105,6 +1123,13 @@ struct bpf_async_cb {
>                 struct work_struct delete_work;
>         };
>         u64 flags;
> +       struct irq_work worker;
> +       atomic_t writer;
> +       seqcount_latch_t latch;
> +       struct bpf_async_cmd cmd[2];
> +       atomic_t last_seq;
> +       refcount_t refcnt;
> +       enum bpf_async_type type;
>  };
>
>  /* BPF map elements can contain 'struct bpf_timer'.
> @@ -1142,18 +1167,9 @@ struct bpf_async_kern {
>                 struct bpf_hrtimer *timer;
>                 struct bpf_work *work;
>         };
> -       /* bpf_spin_lock is used here instead of spinlock_t to make
> -        * sure that it always fits into space reserved by struct bpf_tim=
er
> -        * regardless of LOCKDEP and spinlock debug flags.
> -        */
> -       struct bpf_spin_lock lock;
> +       u32 __opaque;

nit: I'd call it __pad because it's not used functionally anymore
(maybe also mention in a short comment on the side that we used to
have bpf_spin_lock here)

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
> @@ -1219,6 +1235,13 @@ static void bpf_async_cb_rcu_free(struct rcu_head =
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
> @@ -1246,18 +1269,17 @@ static void bpf_timer_delete_work(struct work_str=
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
> @@ -1270,18 +1292,13 @@ static int __bpf_async_init(struct bpf_async_kern=
 *async, struct bpf_map *map, u
>                 return -EINVAL;
>         }
>
> -       __bpf_spin_lock_irqsave(&async->lock);
> -       t =3D async->timer;
> -       if (t) {
> -               ret =3D -EBUSY;
> -               goto out;
> -       }
> +       old_cb =3D READ_ONCE(async->cb);
> +       if (old_cb)
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
> @@ -1304,9 +1321,20 @@ static int __bpf_async_init(struct bpf_async_kern =
*async, struct bpf_map *map, u
>         cb->map =3D map;
>         cb->prog =3D NULL;
>         cb->flags =3D flags;
> +       cb->worker =3D IRQ_WORK_INIT(bpf_async_irq_worker);
> +       seqcount_latch_init(&cb->latch);
> +       atomic_set(&cb->writer, 0);
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
> @@ -1317,13 +1345,11 @@ static int __bpf_async_init(struct bpf_async_kern=
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
> @@ -1388,33 +1414,95 @@ static int bpf_async_update_prog_callback(struct =
bpf_async_cb *cb, void *callbac
>         return 0;
>  }
>
> +/* Decrements bpf_async_cb refcnt, if it becomes 0 schedule cleanup irq_=
work */
> +static void bpf_async_refcnt_dec_cleanup(struct bpf_async_cb *cb)
> +{
> +       if (!refcount_dec_and_test(&cb->refcnt))
> +               return;
> +
> +       /*
> +        * At this point we took the last reference
> +        * Try to schedule cleanup, either:
> +        *  - Set ref to 1 and succeed irq_work_queue
> +        *  - See non-zero refcnt after decrement - other irq_work is goi=
ng to cleanup
> +        */
> +       do {
> +               refcount_set(&cb->refcnt, 1);
> +               if (irq_work_queue(&cb->worker))
> +                       break;
> +       } while (refcount_dec_and_test(&cb->refcnt));

I still don't understand why you think this hack is better than just
marking cb as "destined for destruction" through one-way flagging that
cannot be reset.

What you have here is some unconventional partial resurrection scheme.
Where cb's refcount dropped to zero, but then we try to temporarily
revive it for that CANCEL_AND_FREE cleanup with *our* scheduled
irq_work callback (which *maybe* will happen), but meanwhile any BPF
program that still has reference to bpf_async_cb (there might be many
on different CPUs) can now suddenly succeed with inc_not_zero(cb)
again...

Why so complicated?.. Refcount is supposed to make things simpler, but
you are managing to abuse it here.

Let's do this:

- make last_seq into u64 (so we can have special value designating
"this async is DONE, no more operations"), that value should not
overlap with valid latch counter values, use U32MAX + 1, for example.

- in __bpf_async_cancel_and_free:
  1. cb =3D xchg(async->cb, BPF_PTR_POISON) (see my notes about poisoning b=
elow)
  2. if (cb && cb !=3D BPF_PTR_POISON) xchg(cb->last_seq,
WE_ARE_DONE_GAME_OVER =3D U32_MAX + 1)
  3. irq_work_queue() (doesn't matter if succeeds, someone will pick
up on WE_ARE_DONE_GAME_OVER)

- in bpf_async_read_op:
    - read cb->last_seq with acquire semantics
    - if (seq =3D=3D WE_ARE_DONE_GAME_OVER)
        - cmpxchg(seq, WE_ARE_DONE_GAME_OVER, WE_ARE_DONE_GAME_OVER + 1)
            - if we lost, bail, someone else already handled this
            - if we won, we are the only ones that will do clean up
        - bpf_async_process_op(cb, BPF_ASYNC_CANCEL_AND_FREE, 0, 0);
(but see below, I think currently we do too much here)
        - done, no more command processing
    - if (seq =3D=3D last_seq) -> out, someone got here first (just like
you have right now)
    - proceed as before, eventually dec_and_test(cb->refcnt), and if
it dropped to zero -> schedule freeing after
call_rcu_tasks_trace+call_rcu

Let's leave refcount to just preserve the lifetime of cb while being
scheduled and processed by irq_work callbacks. And nothing more. And
then see comments later on about async->cb poisoning.

But we still need to keep in mind that there might be active BPF
programs that still have access to this memory. But they won't be able
to schedule anything because a) async->cb is poisoned, b) if they
happen to already have cb, refcount is at zero, so inc_not_zero fails,
c) even if they got refcount, we are at GAME_OVER stage (or beyond
it), so whatever command we write will be ignored.

And I think we can and should honor usercnt=3D=3D0 handling, just like
with task_work.

Do I miss something in the above?

> +}
> +
> +static int bpf_async_schedule_op(struct bpf_async_cb *cb, u32 op, u64 ns=
ec, u32 timer_mode)
> +{
> +       /* Acquire active writer atomic*/

space missing before */

> +       if (atomic_cmpxchg_acquire(&cb->writer, 0, 1))
> +               return -EBUSY;
> +
> +       write_seqcount_latch_begin(&cb->latch);
> +       cb->cmd[0].nsec =3D nsec;
> +       cb->cmd[0].mode =3D timer_mode;
> +       cb->cmd[0].op =3D op;
> +       write_seqcount_latch(&cb->latch);
> +       cb->cmd[1].nsec =3D nsec;
> +       cb->cmd[1].mode =3D timer_mode;
> +       cb->cmd[1].op =3D op;
> +       write_seqcount_latch_end(&cb->latch);
> +       atomic_set(&cb->writer, 0);

Hm... this double write of the same data is interesting, I didn't
realize seqcount_latch requires it. Good to know, but if we had more
than 16 bytes to write, it would be a bit of concern for me, tbh.


> +
> +       if (!refcount_inc_not_zero(&cb->refcnt))
> +               return -EBUSY;
> +
> +       /* TODO: Run operation without irq_work if not in NMI */
> +       if (!irq_work_queue(&cb->worker))
> +               /* irq_work is already scheduled on this CPU */

misleading comment, it doesn't matter if it's on this or another CPU,
it's just irq_work is pending *somewhere*, no?

> +               bpf_async_refcnt_dec_cleanup(cb);
> +
> +       return 0;
> +}
> +
> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op =
*op,
> +                            u64 *nsec, u32 *flags)
> +{
> +       u32 seq, last_seq, idx;
> +
> +       while (true) {
> +               last_seq =3D atomic_read_acquire(&cb->last_seq);
> +
> +               seq =3D raw_read_seqcount_latch(&cb->latch);
> +
> +               /* Return -EBUSY if current seq is consumed by another re=
ader */
> +               if (seq =3D=3D last_seq)
> +                       return -EBUSY;
> +
> +               idx =3D seq & 1;
> +               *nsec =3D cb->cmd[idx].nsec;
> +               *flags =3D cb->cmd[idx].mode;
> +               *op =3D cb->cmd[idx].op;
> +
> +               if (raw_read_seqcount_latch_retry(&cb->latch, seq))
> +                       continue;
> +               /* Commit read sequence number, own snapshot exclusively =
*/
> +               if (atomic_cmpxchg_release(&cb->last_seq, last_seq, seq) =
=3D=3D last_seq)
> +                       break;
> +       }
> +
> +       return 0;
> +}
> +
>  static int __bpf_async_set_callback(struct bpf_async_kern *async, void *=
callback_fn,
>                                     struct bpf_prog *prog)
>  {
>         struct bpf_async_cb *cb;
> -       int ret =3D 0;
>
> -       if (in_nmi())
> -               return -EOPNOTSUPP;
> -       __bpf_spin_lock_irqsave(&async->lock);
> -       cb =3D async->cb;
> -       if (!cb) {
> -               ret =3D -EINVAL;
> -               goto out;
> -       }
> -       if (!atomic64_read(&cb->map->usercnt)) {
> -               /* maps with timers must be either held by user space
> -                * or pinned in bpffs. Otherwise timer might still be
> -                * running even when bpf prog is detached and user space
> -                * is gone, since map_release_uref won't ever be called.
> -                */
> -               ret =3D -EPERM;
> -               goto out;
> -       }
> -       ret =3D bpf_async_update_prog_callback(cb, callback_fn, prog);
> -out:
> -       __bpf_spin_unlock_irqrestore(&async->lock);
> -       return ret;
> +       /* Make sure bpf_async_cb_rcu_free() is not called while here */
> +       guard(rcu)();
> +
> +       cb =3D READ_ONCE(async->cb);
> +       if (!cb)
> +               return -EINVAL;
> +
> +       return bpf_async_update_prog_callback(cb, callback_fn, prog);

shouldn't we do map->usercnt check after successful
bpf_async_update_prog_callback(), and if usercnt dropped to zero, we
just basically request cancle_and_free. We do something like that for
task_work, no?

>  }
>
>  BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void =
*, callback_fn,
> @@ -1431,22 +1519,19 @@ static const struct bpf_func_proto bpf_timer_set_=
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
> +       t =3D READ_ONCE(async->timer);
> +       if (!t || !READ_ONCE(t->cb.prog))
> +               return -EINVAL;
>
>         if (flags & BPF_F_TIMER_ABS)
>                 mode =3D HRTIMER_MODE_ABS_SOFT;
> @@ -1456,10 +1541,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern =
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
> @@ -1536,27 +1618,16 @@ static const struct bpf_func_proto bpf_timer_canc=
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

What prevents bpf_timer_init() from recreating async->cb? Should we
"poison" this pointer here (i.e., xchg() to BPF_PTR_POISON and handle
that in timer_init properly)?

>         if (!cb)
> -               goto out;
> -       bpf_async_update_prog_callback(cb, NULL, NULL);
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
> +       /* Consume map's own refcnt, schedule cleanup irq_work if this is=
 the last ref */
> +       bpf_async_refcnt_dec_cleanup(cb);
>  }
>
>  static void bpf_timer_delete(struct bpf_hrtimer *t)
> @@ -1611,19 +1682,76 @@ static void bpf_timer_delete(struct bpf_hrtimer *=
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

make sure bpf_timer_delete() doesn't do anything stupid and
unnecessary. It shouldn't free any memory, just cancel timer. Let's
analyze whether we need all that queue_work stuff we have there right
now. We will be calling this from a well-defined irq_work context, so
maybe it's good enough to just perform hrtimer_cancel() directly? In
any case we should not do call_rcu(&w->cb.rcu,
bpf_async_cb_rcu_free);, that will be done when cb->refcnt drops to
zero afterwards.

Similar points for wq's CANCEL_AND_FREE, it should only ensure
workqueue is canceled. There is no point in doing cancel_work_sync(),
no one is waiting for irq_work to be done, so just cancel_work()?

> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       }

[...]

