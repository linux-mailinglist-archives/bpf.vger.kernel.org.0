Return-Path: <bpf+bounces-67841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F003B4A07A
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 06:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB774E38B1
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418632BE653;
	Tue,  9 Sep 2025 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/btJUya"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F30221DB1
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390753; cv=none; b=MLOjhBL95TWb16oA1EXjpDQ9g/gAZSPHY9bVWTnsLGv+4tLmAUJyODTVg7H9o3GZFu7MGddzOjyTA/Kd+7g6kDJmnPCPBK2q6Na/EU4VfYrfLe+9gHVWTcYtLQFOurKkQLyOeiL5iYMazYKDHmXPVydRv7sSwtvjxqGWup1n1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390753; c=relaxed/simple;
	bh=0tMCLuwXiX6hoMRV4O+cix9H+ZQ/kZGcs7tUN5/aUjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koajJiH55la20Xc8ff120ZXguoSrc3oNjOR5GoOciPp+tad7hBFkPCd+ZU9p7zM91NOCRDDj5LkaZsK0Fu03ZVALAV8KAmCVhwF7kVuX4yej00mBIv8B9qgtq/KwWoqrd0ws4L84lhXsvv7SD2ajzfSP94vypYl1AdV8CRZSJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/btJUya; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-251ace3e7caso35252105ad.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757390750; x=1757995550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e4qaV1WAtgErrTLNQy/F0bB+D5tXbv+jHl/+13gWTTI=;
        b=h/btJUyarNf5uImJtOmDDLB9JUhBb6IFauM4wZIjWoY/NNB2dJ3A5sgE0fDWxMN30w
         R97kFcARPjM2n25rnQERAzwaHsWA1x1OBYSLolnztNck0YTQQRNoip5blm6goQy1el8n
         yLl1i+1xNRmkPaA4dfl5L3yxICQ7Ggjye32qCfuSlJ3eM+dnBap5jfCF7E6S8vVA9D5+
         NwEpiCP1SfzCJi24wQ6JN1dAT6sTzW4nLG96IVNg0DZT1DDnKMlf1SnnqUUAekpS8EBU
         QeeA+Uh70EVZl1zJlxYr2EPUdQCS+LcnB9ewETvXWtv5Z5Y/LdLB4U5OIlfaS+GkaHp1
         a8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757390750; x=1757995550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4qaV1WAtgErrTLNQy/F0bB+D5tXbv+jHl/+13gWTTI=;
        b=gEQN11QpXUQqSlRZK2HmPnkYogtOhOhaKbjKwwuYi760gW7Ncjq0g/bzrn8P+PNmE8
         PIpbGf91Um8wsoGj9w6vmgUcH6uzy4MBM5rEx4G+gp7C2824w3W1DlGyTFVgfMnoeWN4
         BOf91daajYADJbMkrOMuw2IBEpiBbzKyVP7jCBvq1/nL7SBkO6Y1NWXaoHNsUoQSS4F6
         s0gyjmIS0Bbbc+ithybiu3S8cUS62BY+/Upus4wOiqqDphmaSInH9TzsSktHJ9c+IsHr
         DUwK5gyGupzr+URlIWHDKdamNPt6/3nn9BnAKET/30qM7BwFOBoteRCH9IlvpGG9v1TX
         0hjQ==
X-Gm-Message-State: AOJu0YzyIKpmv/yJxFBOZHsaYH+PWocd1Fpey6D7x15Cz3EanP70a1l9
	T23BLcHOKwAlVOTnJZ+WBMcCJEWEvDEZEHosHBR5hPddTy0rR2sEPRXT
X-Gm-Gg: ASbGncv9xCu22z33z2S0plQGr/JdLq5gn5EA6rp9SzbRQuYsrO0dWdg50p/GUAlsZJB
	/kEd0ZE+GNvWpN7jQYZiJk5VYg41RJAXpTEHS4aZcluYx9IlNOQvIOOG6WMtnYAFHLquVinpe2a
	0lzk7AiLC01E4mwT7qEBom1uO0wtKoqKjYXILzg8Dh/zSBEVrCp2gDHJ83nz6RHZ66FfG+bgytz
	Td5lhiuHwCGq+8X6l7CHVxpBYh21MQqtozIcsQzAVHwfcYYV9GtTkCQzXr4NcB3X3NA1n7xXKsV
	He2K35iP9djNVDL7/YW0EU0eVwDgkf+rb6bQV8DOWp6grBlekfHOSxWDz9C1EcKXpVXM3SSNWxN
	gsJrOBq7vYTC3zrNb0A==
X-Google-Smtp-Source: AGHT+IF94C5kR6tfqcr1iNI0CKPZIGICZx/gkgE6+3WjmAUeOY+HY4GKpF0g0hPiimgjWwtMVup/MQ==
X-Received: by 2002:a17:902:dac3:b0:24a:fc8d:894c with SMTP id d9443c01a7336-2516d81824fmr145402095ad.1.1757390750298;
        Mon, 08 Sep 2025 21:05:50 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b9be55c1esm13787493a91.9.2025.09.08.21.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:05:49 -0700 (PDT)
Message-ID: <205c8ce8829a93bd1f371ac9f86d86c3ef5c0639.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com,
 memxor@gmail.com, Mykyta Yatsenko	 <yatsenko@meta.com>
Date: Mon, 08 Sep 2025 21:05:47 -0700
In-Reply-To: <CAEf4BzYSc_vGz42vpYzgAGmT15Lx77BduV6c9AJurQw5PSe63g@mail.gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
	 <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
	 <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com>
	 <CAEf4BzYSc_vGz42vpYzgAGmT15Lx77BduV6c9AJurQw5PSe63g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 23:33 -0400, Andrii Nakryiko wrote:
> On Mon, Sep 8, 2025 at 9:13=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >=20
> > On 9/6/25 21:22, Eduard Zingerman wrote:
> > > On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> > >=20
> > > [...]
> > >=20
> > > > A small state machine and refcounting scheme ensures safe reuse and
> > > > teardown:
> > > >   STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STAND=
BY
> > > Nit: state machine is actually a bit more complex:
> > >=20
> > >    digraph G {
> > >      scheduling  -> running    [label=3D"callback 1"];
> > >      scheduled   -> running    [label=3D"callback 2"];
> > >      running     -> standby    [label=3D"callback 3"];
> > >      pending     -> scheduling [label=3D"irq 1"];
> > >      scheduling  -> standby    [label=3D"irq 2"];
> > >      scheduling  -> scheduled  [label=3D"irq 3"];
> > >      standby     -> pending    [label=3D"acquire_ctx"];
> > >=20
> > >      freed      -> freed [label=3D"cancel_and_free"];
> > >      pending    -> freed [label=3D"cancel_and_free"];
> > >      running    -> freed [label=3D"cancel_and_free"];
> > >      scheduled  -> freed [label=3D"cancel_and_free"];
> > >      scheduling -> freed [label=3D"cancel_and_free"];
> > >      standby    -> freed [label=3D"cancel_and_free"];
> > >    }
> > >=20
> > > [...]
> > >=20
> > I'll update the description to contain proper graph.
>=20
> Hm... I like the main linear chain of state transitions as is, tbh.
> It's fundamentally simple and helps get the general picture. Sure,
> there are important details, but I don't think we should overwhelm
> anyone reading with all of this upfront.
>=20
> In the above, "callback 1" and so on is not really helpful for
> understanding, IMO.

I'm not suggesting to take the above graphviz spec as a description.
Just point out that current message is misleading.

> I'd just add the note that a) each state can transition to FREED and
> b) with tiny probability we might skip SCHEDULED and go SCHEDULING ->
> RUNNING (extremely unlikely if at all possible, tbh).
>=20
> In short, let's not go too detailed here.

As you see fit. Transition graph is easier to read for me, but maybe
other people are better at reading text.

>=20
> > > > Flow of successful task work scheduling
> > > >   1) bpf_task_work_schedule_* is called from BPF code.
> > > >   2) Transition state from STANDBY to PENDING, marks context is own=
ed by
> > > >   this task work scheduler
> > > >   3) irq_work_queue() schedules bpf_task_work_irq().
> > > >   4) Transition state from PENDING to SCHEDULING.
> > > >   4) bpf_task_work_irq() attempts task_work_add(). If successful, s=
tate
> > > >   transitions to SCHEDULED.
> > > Nit: "4" repeated two times.
> > >=20
> > > >   5) Task work calls bpf_task_work_callback(), which transition sta=
te to
> > > >   RUNNING.
> > > >   6) BPF callback is executed
> > > >   7) Context is cleaned up, refcounts released, context state set b=
ack to
> > > >   STANDBY.
> > > >=20
> > > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > ---
> > > >   kernel/bpf/helpers.c | 319 ++++++++++++++++++++++++++++++++++++++=
++++-
> > > >   1 file changed, 317 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index 109cb249e88c..418a0a211699 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > [...]
> > >=20
> > > > +static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> > > > +{
> > > > +    /*
> > > > +     * Scheduled task_work callback holds ctx ref, so if we succes=
sfully
> > > > +     * cancelled, we put that ref on callback's behalf. If we coul=
dn't
> > > > +     * cancel, callback is inevitably run or has already completed
> > > > +     * running, and it would have taken care of its ctx ref itself=
.
> > > > +     */
> > > > +    if (task_work_cancel_match(ctx->task, task_work_match, ctx))
> > > Will `task_work_cancel(ctx->task, ctx->work)` do the same thing here?
> > I think so, yes, thanks for checking.
> > >=20
> > > > +            bpf_task_work_ctx_put(ctx);
> > > > +}
> > > [...]
> > >=20
> > > > +static void bpf_task_work_irq(struct irq_work *irq_work)
> > > > +{
> > > > +    struct bpf_task_work_ctx *ctx =3D container_of(irq_work, struc=
t bpf_task_work_ctx, irq_work);
> > > > +    enum bpf_task_work_state state;
> > > > +    int err;
> > > > +
> > > > +    guard(rcu_tasks_trace)();
> > > > +
> > > > +    if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=
=3D BPF_TW_PENDING) {
> > > > +            bpf_task_work_ctx_put(ctx);
> > > > +            return;
> > > > +    }
> > > Why are separate PENDING and SCHEDULING states needed?
> > > Both indicate that the task had not been yet but is ready to be
> > > submitted to task_work_add(). So, on a first glance it seems that
> > > merging the two won't change the behaviour, what do I miss?
> > Yes, this is right, we may drop SCHEDULING state, it does not change an=
y
> > behavior compared to PENDING.
> > The state check before task_work_add is needed anyway, so we won't
> > remove much code here.
> > I kept it just to be more consistent: with every state check we also
> > transition state machine forward.
>=20
> Yeah, I like this property as well, I think it makes it easier to
> reason about all this. I'd keep the PENDING and SCHEDULING
> distinction, unless there is a strong reason not to.
>=20
> It also gives us a natural point to check for FREED before doing
> unnecessary task_work scheduling + cancelling (if we were already in
> FREED). It doesn't seem like we'll simplify anything by SCHEDULING (or
> PENDING) state.

Again, people are probably different, but it took me some time trying
to figure out if I'm missing some details or SCHEDULING is there just
for the sake of it.

> > >=20
> > > > +    err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> > > > +    if (err) {
> > > > +            bpf_task_work_ctx_reset(ctx);
> > > > +            /*
> > > > +             * try to switch back to STANDBY for another task_work=
 reuse, but we might have
> > > > +             * gone to FREED already, which is fine as we already =
cleaned up after ourselves
> > > > +             */
> > > > +            (void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_S=
TANDBY);
> > > > +
> > > > +            /* we don't have RCU protection, so put after switchin=
g state */
> > > > +            bpf_task_work_ctx_put(ctx);
> > > > +    }
> > > > +
>=20
> [...]
>=20
> > > > +
> > > > +    return ctx;
> > > > +}
> > > > +
> > > > +static int bpf_task_work_schedule(struct task_struct *task, struct=
 bpf_task_work *tw,
> > > > +                              struct bpf_map *map, bpf_task_work_c=
allback_t callback_fn,
> > > > +                              struct bpf_prog_aux *aux, enum task_=
work_notify_mode mode)
> > > > +{
> > > > +    struct bpf_prog *prog;
> > > > +    struct bpf_task_work_ctx *ctx;
> > > > +    int err;
> > > > +
> > > > +    BTF_TYPE_EMIT(struct bpf_task_work);
> > > > +
> > > > +    prog =3D bpf_prog_inc_not_zero(aux->prog);
> > > > +    if (IS_ERR(prog))
> > > > +            return -EBADF;
> > > > +    task =3D bpf_task_acquire(task);
> > > > +    if (!task) {
> > > > +            err =3D -EPERM;
> > > Nit: Why -EPERM? bpf_task_acquire() returns NULL if task->rcu_users
> > >       is zero, does not seem to be permission related.
> > Right, this probably should be -EBADF.
>=20
> timer and wq (and now task_work) return -EPERM for map->usercnt=3D=3D0
> check, but we have -EBADF for prog refcount being zero. It's a bit all
> over the place... I don't have a strong preference, but it would be
> nice to stay more or less consistent for all these "it's too late"
> conditions, IMO.

Ok, probably being consistently wrong is better option here,
let's stick with -EPERM.

[...]

