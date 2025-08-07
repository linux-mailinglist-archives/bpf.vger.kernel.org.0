Return-Path: <bpf+bounces-65234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D5B1DD39
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD88918C0356
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A032222B6;
	Thu,  7 Aug 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxTIjKyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF643AA1
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754592988; cv=none; b=k2HUqIdul92wgkgBJPZAZA2yDD9DS8qpEwoeDizADEv2BbeOUmOLlgr8Ti4Y7NP7IUhZpbCqrqztfnLp591RVu49FryW9mvIXebj8W0/32J3PfM0oZjnoEJe8vCO5mYPrME/BKD1jnZhW9dg58wPyR/U6WcHlOtAbKgwA1BC/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754592988; c=relaxed/simple;
	bh=Tq5rQ06NYQvc2ie3Q2Ju1gi5w0rnhbgM+bzj00yt248=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEkjMTLHCEXqZsPqGis6aOoqRAc6QHjp89Cl6uZWsR7m1RUzr6dzN6E2ykwdHA7B45kk0cdZedo0Jz/PdRxAJps9T5JPIH5YABQ3jujajn7isedDdOa7yKqKDOIy4pcW+EyKRgqVSIGUcPtyBGOmbDFBUJ6kZDez8un+mKRXjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxTIjKyy; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-617d24e7246so1140486a12.2
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754592985; x=1755197785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51LTPv/J5+T9T/uOvhKG0CZKPXoh5e3UzPj3n5SOZs8=;
        b=mxTIjKyyMT1rgo8wtb4eYCo7/pTlgD7FtKGi6rZUyT94/wUmArJN9rc/MHNM6rv1FC
         fEveBXHgPysd5gEOOgg/urHYwyUVDbjfZNRfb+0Rs8uE1Ee2R5ZlDObtGnRyFXNFSQz8
         eU9SLTqN96Bc3zh+OnXJyoGpAOpXcFvOGE3ckKnH3btwe1q9oglByJG6SuaxH/np2qfc
         /ndQ+Uti3kTNuSzZqh+bgTXb2ov+t4KEV2FEBMHh9cYAsz3pvm/s3CacvV16URuhmXys
         d0DaCkx84Y4tWVg4aSgn2jsDExzy8FCIEK52Wc/Hfi4x6+qFhcUWXsZHqTpDlW+hsFSO
         f5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754592985; x=1755197785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51LTPv/J5+T9T/uOvhKG0CZKPXoh5e3UzPj3n5SOZs8=;
        b=Y9yBYu/wUyx8ZnJB4/QFx9dGuez24KHkf3o75arn8BqYrVQ+gNLfAJgw2W/ipO+hH2
         TjG6+SArAZUs4MvL0bhTwTN+tWGiyaCbG/As9JaeglciIArpT8QERcoitISV4ZYvZECd
         2rh8oD87o9HiatkG3an8jKarhIcw/z0/yAldzFY6bEe0XGfan1aKtzEg+y+0YUcO3F0c
         4rjuJgzN++ScIUeq4UEu318xiYI/sN01ZALGYUBSpaQjWVlQn0/TaBpZnmFQRMsc5X5T
         ZiIhqmvJXCe52/ijuGYq72E/pFaO+u5QpGH2/YEvI6hy50hnUwY6qyf1nct1kLDHeNtI
         yhUg==
X-Gm-Message-State: AOJu0YzLCtrZG1CCKMIVFhHO7eAHr7iwP1tcX3HCF0c8q06QH9OwMtnD
	cqidQTgNsxiT9n5GO+go+C+4sqJNRhoz+2/BFd+C96/lT1febVnF6fULGPVa0DXV8WpiQ8/mpsP
	aBhhPN2d08RcolVerXOl2azbS+au4S70=
X-Gm-Gg: ASbGncsLEfyEKJrNXnsdD0WnQxRiZF7WcPZBYwmVQtqlkWeS/GuQsZv9ICKWHXL0Q2X
	yI1opo66EJAq/eDaRB4j7bKuwkoQGitebA3d3e1mGfPAG51DEAUEvLoymXUmkmDktpU3WySxR3g
	jjhXnaRnndtz5QLdLq85fVISOS2bEUr90JDXYmKcDyKK9Mqrim/W1FSgvXus0koFbXXRmbLfLIl
	s1G2SdbYFNUPENoJs50PvGKS7DsdCb2WX8CV+fU
X-Google-Smtp-Source: AGHT+IGgoEcNhF0xDl2Y2/RNsC9xtkLmT4P0fmRQ6vI3ySvCcLedCPQTorRMBkSEaKoMr4MAY8FWOrJTS1e8HOoVlxg=
X-Received: by 2002:a17:907:6091:b0:ade:198c:4b6f with SMTP id
 a640c23a62f3a-af9c62fb70fmr10036466b.1.1754592984671; Thu, 07 Aug 2025
 11:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com> <20250806144554.576706-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250806144554.576706-4-mykyta.yatsenko5@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 7 Aug 2025 20:55:48 +0200
X-Gm-Features: Ac12FXzX3GiXPc2eWY00Aaec9BgS2VUxMek116q4S12kLd1D-J89mc6vjVgg6sc
Message-ID: <CAP01T76ZArSz8r8z2q3J-76N=cQrPh_YBcyMog6VVHcfUNssJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Aug 2025 at 16:46, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> w=
rote:
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
>  * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_work r=
uns.
>  * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in softirq co=
ntext)
> to enqueue task work.
>  * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BPF map =
entries.
>
> Flow of task work scheduling
>  1) bpf_task_work_schedule_* is called from BPF code.
>  2) Transition state from STANDBY to PENDING.
>  3) irq_work_queue() schedules bpf_task_work_irq().
>  4) Transition state from PENDING to SCHEDULING.
>  4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>  transitions to SCHEDULED.
>  5) Task work calls bpf_task_work_callback(), which transition state to
>  RUNNING.
>  6) BPF callback is executed
>  7) Context is cleaned up, refcounts released, state set back to
>  STANDBY.
>
> Map value deletion
> If map value that contains bpf_task_work_context is deleted, BPF map
> implementation calls bpf_task_work_cancel_and_free().
> Deletion is handled by atomically setting state to FREED and
> releasing references or letting scheduler do that, depending on the
> last state before the deletion:
>  * SCHEDULING: release references in bpf_task_work_cancel_and_free(),
>  expect bpf_task_work_irq() to cancel task work.
>  * SCHEDULED: release references and try to cancel task work in
>  bpf_task_work_cancel_and_free().
>   * other states: one of bpf_task_work_irq(), bpf_task_work_schedule(),
>   bpf_task_work_callback() should cleanup upon detecting the state
>   switching to FREED.
>
> The state transitions are controlled with atomic_cmpxchg, ensuring:
>  * Only one thread can successfully enqueue work.
>  * Proper handling of concurrent deletes (BPF_TW_FREED).
>  * Safe rollback if task_work_add() fails.
>

In general I am not sure why we need so many acquire/release pairs.
Why not use test_and_set_bit etc.? Or simply cmpxchg?
What ordering of stores are we depending on that merits
acquire/release ordering?
We should probably document explicitly.

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 188 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 186 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 516286f67f0d..4c8b1c9be7aa 100644
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
> @@ -3702,6 +3704,160 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, c=
onst char *s2__ign)
>
>  typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *, void =
*);
>
> +enum bpf_task_work_state {
> +       /* bpf_task_work is ready to be used */
> +       BPF_TW_STANDBY =3D 0,
> +       /* bpf_task_work is getting scheduled into irq_work */
> +       BPF_TW_PENDING,
> +       /* bpf_task_work is in irq_work and getting scheduled into task_w=
ork */
> +       BPF_TW_SCHEDULING,
> +       /* bpf_task_work is scheduled into task_work successfully */
> +       BPF_TW_SCHEDULED,
> +       /* callback is running */
> +       BPF_TW_RUNNING,
> +       /* BPF map value storing this bpf_task_work is deleted */
> +       BPF_TW_FREED,
> +};
> +
> +struct bpf_task_work_context {
> +       /* map that contains this structure in a value */
> +       struct bpf_map *map;
> +       /* bpf_task_work_state value, representing the state */
> +       atomic_t state;
> +       /* bpf_prog that schedules task work */
> +       struct bpf_prog *prog;
> +       /* task for which callback is scheduled */
> +       struct task_struct *task;
> +       /* notification mode for task work scheduling */
> +       enum task_work_notify_mode mode;
> +       /* callback to call from task work */
> +       bpf_task_work_callback_t callback_fn;
> +       struct callback_head work;
> +       struct irq_work irq_work;
> +} __aligned(8);

I will echo Alexei's comments about the layout. We cannot inline all
this in map value.
Allocation using an init function or in some control function is
probably the only way.

> +
> +static bool task_work_match(struct callback_head *head, void *data)
> +{
> +       struct bpf_task_work_context *ctx =3D container_of(head, struct b=
pf_task_work_context, work);
> +
> +       return ctx =3D=3D data;
> +}
> +
> +static void bpf_reset_task_work_context(struct bpf_task_work_context *ct=
x)
> +{
> +       bpf_prog_put(ctx->prog);
> +       bpf_task_release(ctx->task);
> +       rcu_assign_pointer(ctx->map, NULL);
> +}
> +
> +static void bpf_task_work_callback(struct callback_head *cb)
> +{
> +       enum bpf_task_work_state state;
> +       struct bpf_task_work_context *ctx;
> +       struct bpf_map *map;
> +       u32 idx;
> +       void *key;
> +       void *value;
> +
> +       rcu_read_lock_trace();
> +       ctx =3D container_of(cb, struct bpf_task_work_context, work);
> +
> +       state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULING, =
BPF_TW_RUNNING);
> +       if (state =3D=3D BPF_TW_SCHEDULED)
> +               state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHE=
DULED, BPF_TW_RUNNING);
> +       if (state =3D=3D BPF_TW_FREED)
> +               goto out;

I am leaving out commenting on this, since I expect it to change per
later comments.

> +
> +       map =3D rcu_dereference(ctx->map);
> +       if (!map)
> +               goto out;
> +
> +       value =3D (void *)ctx - map->record->task_work_off;
> +       key =3D (void *)map_key_from_value(map, value, &idx);
> +
> +       migrate_disable();
> +       ctx->callback_fn(map, key, value);
> +       migrate_enable();
> +
> +       /* State is running or freed, either way reset. */
> +       bpf_reset_task_work_context(ctx);
> +       atomic_cmpxchg_release(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDB=
Y);
> +out:
> +       rcu_read_unlock_trace();
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
> +       rcu_read_lock_trace();

What's the idea behind rcu_read_lock_trace? Let's add a comment.

> +       state =3D atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, BPF=
_TW_SCHEDULING);
> +       if (state =3D=3D BPF_TW_FREED) {
> +               bpf_reset_task_work_context(ctx);
> +               goto out;
> +       }
> +
> +       err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);

Racy, SCHEDULING->FREE state claim from cancel_and_free will release ctx->t=
ask.

> +       if (err) {
> +               state =3D atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHE=
DULING, BPF_TW_PENDING);

Races here look fine, since we don't act on FREED (for this block
atleast), cancel_and_free doesn't act on seeing PENDING,
so there is interlocking.

> +               if (state =3D=3D BPF_TW_SCHEDULING) {
> +                       bpf_reset_task_work_context(ctx);
> +                       atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDIN=
G, BPF_TW_STANDBY);
> +               }
> +               goto out;
> +       }
> +       state =3D atomic_cmpxchg_release(&ctx->state, BPF_TW_SCHEDULING, =
BPF_TW_SCHEDULED);
> +       if (state =3D=3D BPF_TW_FREED)
> +               task_work_cancel_match(ctx->task, task_work_match, ctx);

It looks like there is a similar race condition here.
If BPF_TW_SCHEDULING is set, cancel_and_free may invoke and attempt
bpf_task_release() from bpf_reset_task_work_context().
Meanwhile, we will access ctx->task here directly after seeing BPF_TW_FREED=
.

> +out:
> +       rcu_read_unlock_trace();
> +}
> +
> +static int bpf_task_work_schedule(struct task_struct *task, struct bpf_t=
ask_work_context *ctx,
> +                                 struct bpf_map *map, bpf_task_work_call=
back_t callback_fn,
> +                                 struct bpf_prog_aux *aux, enum task_wor=
k_notify_mode mode)
> +{
> +       struct bpf_prog *prog;
> +
> +       BTF_TYPE_EMIT(struct bpf_task_work);
> +
> +       prog =3D bpf_prog_inc_not_zero(aux->prog);
> +       if (IS_ERR(prog))
> +               return -EPERM;
> +
> +       if (!atomic64_read(&map->usercnt)) {
> +               bpf_prog_put(prog);
> +               return -EPERM;
> +       }
> +       task =3D bpf_task_acquire(task);
> +       if (!task) {
> +               bpf_prog_put(prog);
> +               return -EPERM;
> +       }
> +
> +       if (atomic_cmpxchg_acquire(&ctx->state, BPF_TW_STANDBY, BPF_TW_PE=
NDING) !=3D BPF_TW_STANDBY) {

If we are reusing map values, wouldn't a freed state stay perpetually freed=
?
I.e. after the first delete of array elements etc. it becomes useless.
Every array map update would invoke a cancel_and_free.
Who resets it?



> +               bpf_task_release(task);
> +               bpf_prog_put(prog);
> +               return -EBUSY;
> +       }
> +
> +       ctx->task =3D task;
> +       ctx->callback_fn =3D callback_fn;
> +       ctx->prog =3D prog;
> +       ctx->mode =3D mode;
> +       init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> +       init_task_work(&ctx->work, bpf_task_work_callback);
> +       rcu_assign_pointer(ctx->map, map);
> +
> +       irq_work_queue(&ctx->irq_work);
> +
> +       return 0;
> +}
> +
>  /**
>   * bpf_task_work_schedule_signal - Schedule BPF callback using task_work=
_add with TWA_SIGNAL mode
>   * @task: Task struct for which callback should be scheduled
> @@ -3718,7 +3874,8 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struc=
t task_struct *task,
>                                               bpf_task_work_callback_t ca=
llback,
>                                               void *aux__prog)
>  {
> -       return 0;
> +       return bpf_task_work_schedule(task, (struct bpf_task_work_context=
 *)tw, map__map,
> +                                     callback, aux__prog, TWA_SIGNAL);
>  }
>
>  /**
> @@ -3738,13 +3895,38 @@ __bpf_kfunc int bpf_task_work_schedule_resume(str=
uct task_struct *task,
>                                               bpf_task_work_callback_t ca=
llback,
>                                               void *aux__prog)
>  {
> -       return 0;
> +       enum task_work_notify_mode mode;
> +
> +       mode =3D task =3D=3D current && in_nmi() ? TWA_NMI_CURRENT : TWA_=
RESUME;
> +       return bpf_task_work_schedule(task, (struct bpf_task_work_context=
 *)tw, map__map,
> +                                     callback, aux__prog, mode);
>  }
>
>  __bpf_kfunc_end_defs();
>
>  void bpf_task_work_cancel_and_free(void *val)
>  {
> +       struct bpf_task_work_context *ctx =3D val;
> +       enum bpf_task_work_state state;
> +
> +       state =3D atomic_xchg(&ctx->state, BPF_TW_FREED);
> +       switch (state) {
> +       case BPF_TW_SCHEDULED:
> +               task_work_cancel_match(ctx->task, task_work_match, ctx);
> +               fallthrough;
> +       /* Scheduling codepath is trying to schedule task work, reset con=
text here. */
> +       case BPF_TW_SCHEDULING:
> +               bpf_reset_task_work_context(ctx);
> +               break;
> +       /* work is not initialized, mark as freed and exit */
> +       case BPF_TW_STANDBY:
> +       /* The context is in interim state, scheduling logic should clean=
up. */
> +       case BPF_TW_PENDING:
> +       /* Callback is already running, it should reset context upon fini=
shing. */
> +       case BPF_TW_RUNNING:
> +       default:
> +               break;
> +       }
>  }
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3770,6 +3952,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
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
>

