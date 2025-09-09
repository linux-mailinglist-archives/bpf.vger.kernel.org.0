Return-Path: <bpf+bounces-67836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14F3B4A012
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 05:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809224E6398
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6C526FA67;
	Tue,  9 Sep 2025 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbmLYjr/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970992550DD
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388842; cv=none; b=SyxF6PPzGyWVFvM1I3JxbhC7OLDd+2izBTriQjlbXfAYT+Pwtj3NiY8rdYk2VR4eBb5XLoNIaQEdKypYQ+/lDKlt7xyEqXJlHy+tYF4NiUgHXgbWRGwGIr/dszbUIjXBfm7SV6ZZyV/CSnLAB0hIOCoj2+wPFOFmNFTJCZlA1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388842; c=relaxed/simple;
	bh=3Xg8/yyKkZjaE3ycI45hXWfyvo/Ts4crzpJWRZR2XWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLG97aBKlpzA5dplf5pxUDyyXS9ryJYho+VM3j8YiPAsQ//6i4FV5GxT5IZi2ROb8KO9ZzxLtDyr4kqk9iytEYB7De1kvBAV9ttg/RrfwaznsMhay0NhoPYF//jNhptGiaSBVOf+2/YpdE68ndLIk8BH+VRUGiHbuJFWiiRuyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbmLYjr/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77250e45d36so4415971b3a.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757388840; x=1757993640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWAioguTu9v7E44Tqmiu156LBPdllx/8fn0NaNWuKBk=;
        b=hbmLYjr/uzpq4wKQbWLzHMYA1swp0vA8bpA1mDMdCZ4h6vFFrE+kHzPVeVY7r7n4Iu
         evvcxseWu30R42k5v9lKzLQln0YwWIJqsV52sAMY81FcBEjaGJizDQBQgB56X1tXipBX
         VkbFgwfW/9B58+XQB6IcEsermnA5fSeEPZ5beeRkihy0oa0QC8XNt96r5540JhqPr0hd
         LN4xCQx4TSCyc6sQJGb6px+zyypnWmFPOS1fyEJCPncC2WQGwRjny+iJlOEHCwCi0YGu
         th0EDn3PreMzLzWcevPUl5ZBuo/1p1tW8WQ1jlvooTiV3NYhtK/qwG7T2JGk6uxBOvHe
         hYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757388840; x=1757993640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWAioguTu9v7E44Tqmiu156LBPdllx/8fn0NaNWuKBk=;
        b=sNC+vU2sPHLVlPwn9PqGnHa8jGc21vKgjNaWeb+FM8NldZy85Z4/4G1R61yJN6+VvY
         AU3/19nqq3cUQlWxahSzETeZUEkGFDpi4uVFOCLuVOo5gxjf1N90B3AdFeZrpuFlkxzX
         j6un9vTXJdecjSPBAZtJlPI7QQUZTg3XAnGDqKM+nJlqDhpgEduf43BWe/N88iS2re7g
         oe6quf6fJVSPpnByQYFi4IdMUXS0hzca8Jsfg12MVWfHyblXIC6vWCYpfGyyiPwGrp0f
         WLkrZejBzbhdtaeDzJR1leiqfq7foFKCvLbxVil+3jkL0KAPt26cHMwV2lDrsYwNknL1
         0VCg==
X-Forwarded-Encrypted: i=1; AJvYcCXmK2VxrcRDozv/jFi7qsG4Pw1NvWcuCD3I+W5OqFHYc/evXOj8wsR0+0oihJ/B+8Hfyh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+jAGNKiO9nwNWWOqWU25zHepxLtI5Fu6oklQyyumgL7Bjzqb
	7u9oye5FhwuWAZXQI6GUBfA5Tt6YgcyX+LYCifyrrgKJtHbk4QL9D7vkXIzzA1qd8aw+1NfqwK0
	tl4dW2W1FDPAaGfbb4fx8CT0RdGwcmS8=
X-Gm-Gg: ASbGncvZFTNeL/uFx4XW/F2BGDC7JlB+y0vIWJCHSdCJ23HoyP3M+S+tHpx4W32jV7o
	nJ/txwaiRdnByNE4BaiApOo5Rhwon7hKm2QvxswHiQp6ScQmW6w5wEvPYzSBFRc70xPQ8fsbnsS
	HBE9dJSj5eeXeNOI7rZLNCkGXs5GhPpAhJj0Gar3bUQP2+jmo5I+7JUuIF05yXzj0UcrgHX55Ke
	QiX6Fd6D+zHI8ri7Ng=
X-Google-Smtp-Source: AGHT+IFfXWSkRCnTblofVjmEiK8tif6RBf31wY3+yRanpZThkIrJ4c33WnTqXo7sek71j9VjIUQ5a0WjYZZzI6vZGfc=
X-Received: by 2002:a05:6a21:33a9:b0:24a:96cb:fe55 with SMTP id
 adf61e73a8af0-253430a7d2amr16591264637.43.1757388839735; Mon, 08 Sep 2025
 20:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com> <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
 <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com>
In-Reply-To: <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Sep 2025 23:33:47 -0400
X-Gm-Features: Ac12FXx9oK24UdtujIJNEm4KSNGO6yKMP50wmBb1wjD68H77lQ7wi0-gwY7nhsA
Message-ID: <CAEf4BzYSc_vGz42vpYzgAGmT15Lx77BduV6c9AJurQw5PSe63g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:13=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/6/25 21:22, Eduard Zingerman wrote:
> > On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> >
> > [...]
> >
> >> A small state machine and refcounting scheme ensures safe reuse and
> >> teardown:
> >>   STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STANDBY
> > Nit: state machine is actually a bit more complex:
> >
> >    digraph G {
> >      scheduling  -> running    [label=3D"callback 1"];
> >      scheduled   -> running    [label=3D"callback 2"];
> >      running     -> standby    [label=3D"callback 3"];
> >      pending     -> scheduling [label=3D"irq 1"];
> >      scheduling  -> standby    [label=3D"irq 2"];
> >      scheduling  -> scheduled  [label=3D"irq 3"];
> >      standby     -> pending    [label=3D"acquire_ctx"];
> >
> >      freed      -> freed [label=3D"cancel_and_free"];
> >      pending    -> freed [label=3D"cancel_and_free"];
> >      running    -> freed [label=3D"cancel_and_free"];
> >      scheduled  -> freed [label=3D"cancel_and_free"];
> >      scheduling -> freed [label=3D"cancel_and_free"];
> >      standby    -> freed [label=3D"cancel_and_free"];
> >    }
> >
> > [...]
> >
> I'll update the description to contain proper graph.

Hm... I like the main linear chain of state transitions as is, tbh.
It's fundamentally simple and helps get the general picture. Sure,
there are important details, but I don't think we should overwhelm
anyone reading with all of this upfront.

In the above, "callback 1" and so on is not really helpful for
understanding, IMO.

I'd just add the note that a) each state can transition to FREED and
b) with tiny probability we might skip SCHEDULED and go SCHEDULING ->
RUNNING (extremely unlikely if at all possible, tbh).

In short, let's not go too detailed here.

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
> > Nit: "4" repeated two times.
> >
> >>   5) Task work calls bpf_task_work_callback(), which transition state =
to
> >>   RUNNING.
> >>   6) BPF callback is executed
> >>   7) Context is cleaned up, refcounts released, context state set back=
 to
> >>   STANDBY.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/helpers.c | 319 +++++++++++++++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 317 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 109cb249e88c..418a0a211699 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> > [...]
> >
> >> +static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> >> +{
> >> +    /*
> >> +     * Scheduled task_work callback holds ctx ref, so if we successfu=
lly
> >> +     * cancelled, we put that ref on callback's behalf. If we couldn'=
t
> >> +     * cancel, callback is inevitably run or has already completed
> >> +     * running, and it would have taken care of its ctx ref itself.
> >> +     */
> >> +    if (task_work_cancel_match(ctx->task, task_work_match, ctx))
> > Will `task_work_cancel(ctx->task, ctx->work)` do the same thing here?
> I think so, yes, thanks for checking.
> >
> >> +            bpf_task_work_ctx_put(ctx);
> >> +}
> > [...]
> >
> >> +static void bpf_task_work_irq(struct irq_work *irq_work)
> >> +{
> >> +    struct bpf_task_work_ctx *ctx =3D container_of(irq_work, struct b=
pf_task_work_ctx, irq_work);
> >> +    enum bpf_task_work_state state;
> >> +    int err;
> >> +
> >> +    guard(rcu_tasks_trace)();
> >> +
> >> +    if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=3D =
BPF_TW_PENDING) {
> >> +            bpf_task_work_ctx_put(ctx);
> >> +            return;
> >> +    }
> > Why are separate PENDING and SCHEDULING states needed?
> > Both indicate that the task had not been yet but is ready to be
> > submitted to task_work_add(). So, on a first glance it seems that
> > merging the two won't change the behaviour, what do I miss?
> Yes, this is right, we may drop SCHEDULING state, it does not change any
> behavior compared to PENDING.
> The state check before task_work_add is needed anyway, so we won't
> remove much code here.
> I kept it just to be more consistent: with every state check we also
> transition state machine forward.

Yeah, I like this property as well, I think it makes it easier to
reason about all this. I'd keep the PENDING and SCHEDULING
distinction, unless there is a strong reason not to.

It also gives us a natural point to check for FREED before doing
unnecessary task_work scheduling + cancelling (if we were already in
FREED). It doesn't seem like we'll simplify anything by SCHEDULING (or
PENDING) state.

> >
> >> +    err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> >> +    if (err) {
> >> +            bpf_task_work_ctx_reset(ctx);
> >> +            /*
> >> +             * try to switch back to STANDBY for another task_work re=
use, but we might have
> >> +             * gone to FREED already, which is fine as we already cle=
aned up after ourselves
> >> +             */
> >> +            (void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STAN=
DBY);
> >> +
> >> +            /* we don't have RCU protection, so put after switching s=
tate */
> >> +            bpf_task_work_ctx_put(ctx);
> >> +    }
> >> +

[...]

> >> +
> >> +    return ctx;
> >> +}
> >> +
> >> +static int bpf_task_work_schedule(struct task_struct *task, struct bp=
f_task_work *tw,
> >> +                              struct bpf_map *map, bpf_task_work_call=
back_t callback_fn,
> >> +                              struct bpf_prog_aux *aux, enum task_wor=
k_notify_mode mode)
> >> +{
> >> +    struct bpf_prog *prog;
> >> +    struct bpf_task_work_ctx *ctx;
> >> +    int err;
> >> +
> >> +    BTF_TYPE_EMIT(struct bpf_task_work);
> >> +
> >> +    prog =3D bpf_prog_inc_not_zero(aux->prog);
> >> +    if (IS_ERR(prog))
> >> +            return -EBADF;
> >> +    task =3D bpf_task_acquire(task);
> >> +    if (!task) {
> >> +            err =3D -EPERM;
> > Nit: Why -EPERM? bpf_task_acquire() returns NULL if task->rcu_users
> >       is zero, does not seem to be permission related.
> Right, this probably should be -EBADF.

timer and wq (and now task_work) return -EPERM for map->usercnt=3D=3D0
check, but we have -EBADF for prog refcount being zero. It's a bit all
over the place... I don't have a strong preference, but it would be
nice to stay more or less consistent for all these "it's too late"
conditions, IMO.

> >> +            goto release_prog;
> >> +    }
> >> +
> >> +    ctx =3D bpf_task_work_acquire_ctx(tw, map);
> >> +    if (IS_ERR(ctx)) {
> >> +            err =3D PTR_ERR(ctx);
> >> +            goto release_all;
> >> +    }
> >> +
> >> +    ctx->task =3D task;
> >> +    ctx->callback_fn =3D callback_fn;
> >> +    ctx->prog =3D prog;
> >> +    ctx->mode =3D mode;
> >> +    ctx->map =3D map;
> >> +    ctx->map_val =3D (void *)tw - map->record->task_work_off;
> >> +    init_task_work(&ctx->work, bpf_task_work_callback);
> >> +    init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> >> +
> >> +    irq_work_queue(&ctx->irq_work);
> >> +    return 0;
> >> +
> >> +release_all:
> >> +    bpf_task_release(task);
> >> +release_prog:
> >> +    bpf_prog_put(prog);
> >> +    return err;
> >> +}
> >> +
> > [...]
>

