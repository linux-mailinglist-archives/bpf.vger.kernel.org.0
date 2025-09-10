Return-Path: <bpf+bounces-68019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414FDB51915
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13C53A6550
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D21322DAB;
	Wed, 10 Sep 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG3iWJYo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6F322764
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513684; cv=none; b=rvfrMU1PmaetfE8J6YwsOEupeD8nfCzdH/bdS814b4ED8YWx3CVL3paTYCeXL0oLrq9DS6fiUDTMkHTtDik8/p3bStRK/PixIla+2QuyxWyG7/aj3oolOhnAJXbISyo2KxfZ/uaJQVtf86b2cY9NLQB7P7SiRLqHUDwu8jE1Asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513684; c=relaxed/simple;
	bh=kNb9ngJeKd45xAc5joMXF/UAXNCYFCpLE4pDidS1DT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba541Ce+bOziq40XzJUtypK0LZ77hkiQki+N6AvLW+sED+x8k7sUlgqEkBITN/f2iZQE7lgzvmFYxGj9HWRE66+m4I1UdF1fvn26BGsh6T1wOl03DsO/RfkPza8bkH16O6V57wG/4C2eYFhpTPbVNCcsjUAVp4MkAphV8rGAk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG3iWJYo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so5235616b3a.3
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513682; x=1758118482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3h2e4v0nVgSB+o45Rhi1rtGUTuaai8PcBVdFkzqTXg=;
        b=dG3iWJYo1wvSg+HWCDj7FF1WcOo3ABR/FguVi8vYqtTK972alUvyRDnWm5wthN/+IS
         jlFG88FnPH+V7Brz602Xq3MT6qV2y0cgEcuubeI8y+Pk0QbIxlA25PHecZG1wUyvWY9v
         p7XpVZJDcG7BMyfw48LMe4jqzFwkc+Eci3Vy5wOx1b5neb+R5JMlmug9QmNl2lsANf1d
         9jGfnYrKvQxchfccgZc+iOHJVuU7Eh/r4vdopKCgWghPP5/dgbKXQenK4oluOUUoaG7l
         6AMGy0OzbaYshMjL7u6EIf8dWPWOOtVSos9KnTw98Ye3S9CDDpdpCchFhEjSj+jrbAT7
         NRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513682; x=1758118482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3h2e4v0nVgSB+o45Rhi1rtGUTuaai8PcBVdFkzqTXg=;
        b=Jcm/pgsbjxd14uNURVLzGArpWa7NpCukF8b08gXuyBMuBCRvyBkcxvGqNwxM6sKWx6
         sRbPvbgVGb52/HkTAwzwYxmLWQKKCxmgZPVhemAvURv7ESniEy49ep3FDnZEkfinP8mT
         py/phCFOcMi0GFmhIvX/M8HBRvrU8zYA8fmmCSalm1oiAcuRypqNd7Z26LH4x3RF2kn7
         CG7l4vOSots9d7MFniHlhzzaYOnBPUvHcV5tyN/qB/x4yCALWximDpEFnU0mPORPWwFP
         d+ViBF/Q3TA+DaHldip9pL1FRY3UZEWis9u0mxqIE+YV04v46mVLyA2qi2G/hYGxyEKl
         NgAg==
X-Forwarded-Encrypted: i=1; AJvYcCUnGv628h1buB2DgLfJk1QbsI2dHsLk3fTi0gFvCJRYBPWyGf9bgwYbt02rm7Sc8GuCC0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEj00EHAmh31ZGhB061+oSCZIOZa6iJ/YWvrNalzNpPt5LAvoi
	Gtx5QLLJlPPHZD+glcG/WuNIBqSSopZ7eM1guHEtPtEK5ffA4eFPqlszpuKYLKAWlhpQuRX+oHy
	UDQ+Lb7cB1UibPU2fNIKodkI/oZiPLcI=
X-Gm-Gg: ASbGncuOIuqquwqInkIdg3zYMemuzKwBMAg9eTLAZ0FSpHNL+8IQSMZLQ9YXkaOhuBL
	cJlCqn0RAZZrCCoWSD8+uLbDqb+JOEEgt7y+7/DO3KsVg7c7c7jRffSv8GP/MDGYvG8W9LaBqOu
	3IQE8wjaT65HT0KEGoHPvU9payycY9G3agkgHvaN2mFT0rU64bkv3iv3To5qN9uH6l1365vH1bp
	xEVDwAfGy+LEA0in6wssU8kOWABeoQOMQ==
X-Google-Smtp-Source: AGHT+IGb6MC6iw/dltQYvdu2HCm5TdVhJ4JUkmgFkyIek2fyPvGLZLHuQVe+UheIrpHdvLxQXGp1GEd/0KlRPatlFPA=
X-Received: by 2002:a05:6a21:33a5:b0:246:9192:2777 with SMTP id
 adf61e73a8af0-2533e18c711mr23367123637.4.1757513681956; Wed, 10 Sep 2025
 07:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com> <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
 <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com> <CAEf4BzYSc_vGz42vpYzgAGmT15Lx77BduV6c9AJurQw5PSe63g@mail.gmail.com>
 <205c8ce8829a93bd1f371ac9f86d86c3ef5c0639.camel@gmail.com>
In-Reply-To: <205c8ce8829a93bd1f371ac9f86d86c3ef5c0639.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Sep 2025 10:14:29 -0400
X-Gm-Features: Ac12FXyzhIQIliQX-Z6iO3TQDT3yr0qo3dkVl8v-CelOyUGL-q3Ppu1vBm0CUks
Message-ID: <CAEf4BzbmD1pXuMmJnQN=WW=MQEtZtQ6yDYrmfVPjinaKKrvd9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:05=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-09-08 at 23:33 -0400, Andrii Nakryiko wrote:
> > On Mon, Sep 8, 2025 at 9:13=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > On 9/6/25 21:22, Eduard Zingerman wrote:
> > > > On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> > > >
> > > > [...]
> > > >
> > > > > A small state machine and refcounting scheme ensures safe reuse a=
nd
> > > > > teardown:
> > > > >   STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STA=
NDBY
> > > > Nit: state machine is actually a bit more complex:
> > > >
> > > >    digraph G {
> > > >      scheduling  -> running    [label=3D"callback 1"];
> > > >      scheduled   -> running    [label=3D"callback 2"];
> > > >      running     -> standby    [label=3D"callback 3"];
> > > >      pending     -> scheduling [label=3D"irq 1"];
> > > >      scheduling  -> standby    [label=3D"irq 2"];
> > > >      scheduling  -> scheduled  [label=3D"irq 3"];
> > > >      standby     -> pending    [label=3D"acquire_ctx"];
> > > >
> > > >      freed      -> freed [label=3D"cancel_and_free"];
> > > >      pending    -> freed [label=3D"cancel_and_free"];
> > > >      running    -> freed [label=3D"cancel_and_free"];
> > > >      scheduled  -> freed [label=3D"cancel_and_free"];
> > > >      scheduling -> freed [label=3D"cancel_and_free"];
> > > >      standby    -> freed [label=3D"cancel_and_free"];
> > > >    }
> > > >
> > > > [...]
> > > >
> > > I'll update the description to contain proper graph.
> >
> > Hm... I like the main linear chain of state transitions as is, tbh.
> > It's fundamentally simple and helps get the general picture. Sure,
> > there are important details, but I don't think we should overwhelm
> > anyone reading with all of this upfront.
> >
> > In the above, "callback 1" and so on is not really helpful for
> > understanding, IMO.
>
> I'm not suggesting to take the above graphviz spec as a description.
> Just point out that current message is misleading.
>
> > I'd just add the note that a) each state can transition to FREED and
> > b) with tiny probability we might skip SCHEDULED and go SCHEDULING ->
> > RUNNING (extremely unlikely if at all possible, tbh).
> >
> > In short, let's not go too detailed here.
>
> As you see fit. Transition graph is easier to read for me, but maybe
> other people are better at reading text.
>
> >
> > > > > Flow of successful task work scheduling
> > > > >   1) bpf_task_work_schedule_* is called from BPF code.
> > > > >   2) Transition state from STANDBY to PENDING, marks context is o=
wned by
> > > > >   this task work scheduler
> > > > >   3) irq_work_queue() schedules bpf_task_work_irq().
> > > > >   4) Transition state from PENDING to SCHEDULING.
> > > > >   4) bpf_task_work_irq() attempts task_work_add(). If successful,=
 state
> > > > >   transitions to SCHEDULED.
> > > > Nit: "4" repeated two times.
> > > >
> > > > >   5) Task work calls bpf_task_work_callback(), which transition s=
tate to
> > > > >   RUNNING.
> > > > >   6) BPF callback is executed
> > > > >   7) Context is cleaned up, refcounts released, context state set=
 back to
> > > > >   STANDBY.
> > > > >
> > > > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > > ---
> > > > >   kernel/bpf/helpers.c | 319 ++++++++++++++++++++++++++++++++++++=
++++++-
> > > > >   1 file changed, 317 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index 109cb249e88c..418a0a211699 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > [...]
> > > >
> > > > > +static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> > > > > +{
> > > > > +    /*
> > > > > +     * Scheduled task_work callback holds ctx ref, so if we succ=
essfully
> > > > > +     * cancelled, we put that ref on callback's behalf. If we co=
uldn't
> > > > > +     * cancel, callback is inevitably run or has already complet=
ed
> > > > > +     * running, and it would have taken care of its ctx ref itse=
lf.
> > > > > +     */
> > > > > +    if (task_work_cancel_match(ctx->task, task_work_match, ctx))
> > > > Will `task_work_cancel(ctx->task, ctx->work)` do the same thing her=
e?
> > > I think so, yes, thanks for checking.
> > > >
> > > > > +            bpf_task_work_ctx_put(ctx);
> > > > > +}
> > > > [...]
> > > >
> > > > > +static void bpf_task_work_irq(struct irq_work *irq_work)
> > > > > +{
> > > > > +    struct bpf_task_work_ctx *ctx =3D container_of(irq_work, str=
uct bpf_task_work_ctx, irq_work);
> > > > > +    enum bpf_task_work_state state;
> > > > > +    int err;
> > > > > +
> > > > > +    guard(rcu_tasks_trace)();
> > > > > +
> > > > > +    if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) =
!=3D BPF_TW_PENDING) {
> > > > > +            bpf_task_work_ctx_put(ctx);
> > > > > +            return;
> > > > > +    }
> > > > Why are separate PENDING and SCHEDULING states needed?
> > > > Both indicate that the task had not been yet but is ready to be
> > > > submitted to task_work_add(). So, on a first glance it seems that
> > > > merging the two won't change the behaviour, what do I miss?
> > > Yes, this is right, we may drop SCHEDULING state, it does not change =
any
> > > behavior compared to PENDING.
> > > The state check before task_work_add is needed anyway, so we won't
> > > remove much code here.
> > > I kept it just to be more consistent: with every state check we also
> > > transition state machine forward.
> >
> > Yeah, I like this property as well, I think it makes it easier to
> > reason about all this. I'd keep the PENDING and SCHEDULING
> > distinction, unless there is a strong reason not to.
> >
> > It also gives us a natural point to check for FREED before doing
> > unnecessary task_work scheduling + cancelling (if we were already in
> > FREED). It doesn't seem like we'll simplify anything by SCHEDULING (or
> > PENDING) state.
>
> Again, people are probably different, but it took me some time trying
> to figure out if I'm missing some details or SCHEDULING is there just
> for the sake of it.

Another reason I realized this morning, besides just a subjective "it
feels right", is that we'll want to optimize away the need for
irq_work (for timers it's going to be important) if we are in the more
permissive context (not nmi, not irq disabled, stuff like that), and
for that probably the simplest way would be to switch state into
SCHEDULING directly, bypassing PENDING altogether. So we'll need to
have two distinct states to keep the code simple.

>
> > > >
> > > > > +    err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> > > > > +    if (err) {
> > > > > +            bpf_task_work_ctx_reset(ctx);
> > > > > +            /*
> > > > > +             * try to switch back to STANDBY for another task_wo=
rk reuse, but we might have
> > > > > +             * gone to FREED already, which is fine as we alread=
y cleaned up after ourselves
> > > > > +             */
> > > > > +            (void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW=
_STANDBY);
> > > > > +
> > > > > +            /* we don't have RCU protection, so put after switch=
ing state */
> > > > > +            bpf_task_work_ctx_put(ctx);
> > > > > +    }
> > > > > +
> >
> > [...]
> >
> > > > > +
> > > > > +    return ctx;
> > > > > +}
> > > > > +
> > > > > +static int bpf_task_work_schedule(struct task_struct *task, stru=
ct bpf_task_work *tw,
> > > > > +                              struct bpf_map *map, bpf_task_work=
_callback_t callback_fn,
> > > > > +                              struct bpf_prog_aux *aux, enum tas=
k_work_notify_mode mode)
> > > > > +{
> > > > > +    struct bpf_prog *prog;
> > > > > +    struct bpf_task_work_ctx *ctx;
> > > > > +    int err;
> > > > > +
> > > > > +    BTF_TYPE_EMIT(struct bpf_task_work);
> > > > > +
> > > > > +    prog =3D bpf_prog_inc_not_zero(aux->prog);
> > > > > +    if (IS_ERR(prog))
> > > > > +            return -EBADF;
> > > > > +    task =3D bpf_task_acquire(task);
> > > > > +    if (!task) {
> > > > > +            err =3D -EPERM;
> > > > Nit: Why -EPERM? bpf_task_acquire() returns NULL if task->rcu_users
> > > >       is zero, does not seem to be permission related.
> > > Right, this probably should be -EBADF.
> >
> > timer and wq (and now task_work) return -EPERM for map->usercnt=3D=3D0
> > check, but we have -EBADF for prog refcount being zero. It's a bit all
> > over the place... I don't have a strong preference, but it would be
> > nice to stay more or less consistent for all these "it's too late"
> > conditions, IMO.
>
> Ok, probably being consistently wrong is better option here,
> let's stick with -EPERM.
>
> [...]

