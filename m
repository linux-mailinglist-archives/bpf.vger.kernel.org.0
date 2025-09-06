Return-Path: <bpf+bounces-67678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DCB4771E
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 22:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FAA18938A7
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B6296BDF;
	Sat,  6 Sep 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOM5Ux82"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B41C1F12
	for <bpf@vger.kernel.org>; Sat,  6 Sep 2025 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757190174; cv=none; b=GRZXLzxs9eeloJ5elsR4Flogbg+3wd9lWFDNTOmWHt8TN/Tp49gzZBAjXb9ne/KuJAZnGYC+edn1+pq0ZlzjHoGq6Hrm8/UP9Agth1GvJdqTvfXtlgPxS+HObfJaGB6nIz3b345t0kq1OELpF5TTzC8oA7uviPLSEpSyzBsy7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757190174; c=relaxed/simple;
	bh=xZoPYTXe75li328LssYTdsYJLDixh7fww5c9A32oMEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwUzqRGNxGKuXb2ZcKG2e19/T92q0w1ckFcJ3Bkx6mbttOd7lCERzpHarKEFlQMIoQvnz8aywZYjA8JC1Y/eQ3vXZhLR4h5d1k/7mO/sHzE6Yx6awegeW9h+VXKoq0wiiw7f5D6ql4vRIihjk0B5tAC5pyYSSk8XsZle12vFw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOM5Ux82; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4f8bf49aeaso2807694a12.1
        for <bpf@vger.kernel.org>; Sat, 06 Sep 2025 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757190172; x=1757794972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KJt12agHA2oqhRhzAD+mIgslIumhjXJJzGXGwfaDT6U=;
        b=HOM5Ux82MHOI/0gEPnOdQ9UZwAXzXNOLLV91fhuC5hK7A8w7wPvaCxQIoLExW1+WRC
         fCzRLq1Zr/W7SEDyuZ/sxCZX8G5uYbFui6gU/mrnc2D8jAbrRaunDFkD5ErfyoRmLtzW
         SVVEWAukJ4WroCxCfzZlZq88+Y/HV0UtD7VJRR5YsqmxNgvrery9GDYeQM8GoI8F6c7P
         S+c9PIpY4KojeB5L5VYtElXgMCp4vz2VB/vRx7SXf3XrJLEW0SHerSwE4z4WMrNqZrS3
         EXDJW5bWSzapVW7MXIpP1vUERqrTVkBDEUejLzzcaS+P+GCAN3FzAcO/0oiGW3ek3zHc
         9MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757190172; x=1757794972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJt12agHA2oqhRhzAD+mIgslIumhjXJJzGXGwfaDT6U=;
        b=fDCAXZmgEEAQc5StWAyeG+No+GmDre+rj33SpJPXai1gybxCYhA8ubesJgk4/9U8a8
         f/MIS2DmIbEbc7PvkvG3oJ5IaafjmApUqZ13XDY0TtJ58bT8/4LcnVkd0UHFgOM9TRoM
         hKdP6+HaOqaZ+75igC4u6FMkv9rgABXFjmtkE54EFvhxGVsSgA17zzNy9BQ4kl9MX3Hi
         hGCGZhirJecqj4KeYYTvRU/Fn4gFk46yitiODfCfJtVYQxfEZbJNJmplqr9a4mgeT2ji
         Wij0LCgkS+sCqn8GqAYP335YGSTdY0yWIypaMck4bDvlGUlW6F4Zmc9qX+kOxJOgIorm
         8Nlg==
X-Forwarded-Encrypted: i=1; AJvYcCWQPr2ZW08BnYmNE9gufw8JzGcu4hoigmrx1vC7YbzkWGcQVG4jc3FiOUBul1tE26JTGAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0u19psX9dC300WjGojOjKP/e60nYromJIQSedG89sXSXCQXxa
	DA3+BnIqeBiQHj0FQJNkTsZjyfIKQxbOvLV/uCZ8Xs+J1dryoOs2A3wj
X-Gm-Gg: ASbGnctV2bzelsVNyrf7mWzMQ1x2QFAIqnQGu2jIojVdY25raRHT2KHyzjwZPT+vYmY
	94pvvLy7qqRnOgjlhEKpkMwloOEfL6WIAcAuubcAtZswZ1ZXAGS62Kmext92s1iQMHw+yaMEC5d
	Vq+sgBfL3veeNAfjSVQTygk+BZ7JTRButoLnBXm6OVZVat1G1C+fkpPOM1k1y96v8GEQWlFs5z4
	AI+Dv/qfIBZ7dZws7pGLp/5p0ZpjpxbVcz/65toUOG2eJ4sDefHeKdMIpoCjwUK2B4+QT8m5zHr
	ru1FsdEOYDVPnFc9iLxnug7/HJiVt0RWRJZ0V5ARrLyvIx9g8j3dLQ18YaTOhg/BesIRVNhV6q/
	y3kn9JTPkUyaqn9wdVO+mxnU2CuZl
X-Google-Smtp-Source: AGHT+IGlCUStEYtRiRv2vkaHYYSs7g1SEofNpwvFhvi4Bn6GCz084Kg/SsqkuykHq6BJqTE60JWC2Q==
X-Received: by 2002:a17:902:d2d2:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-25173119564mr40140205ad.50.1757190171828;
        Sat, 06 Sep 2025 13:22:51 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b790sm101879005ad.67.2025.09.06.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 13:22:51 -0700 (PDT)
Message-ID: <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Sat, 06 Sep 2025 13:22:47 -0700
In-Reply-To: <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:

[...]

> A small state machine and refcounting scheme ensures safe reuse and
> teardown:
>  STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STANDBY

Nit: state machine is actually a bit more complex:

  digraph G {
    scheduling  -> running    [label=3D"callback 1"];
    scheduled   -> running    [label=3D"callback 2"];
    running     -> standby    [label=3D"callback 3"];
    pending     -> scheduling [label=3D"irq 1"];
    scheduling  -> standby    [label=3D"irq 2"];
    scheduling  -> scheduled  [label=3D"irq 3"];
    standby     -> pending    [label=3D"acquire_ctx"];
 =20
    freed      -> freed [label=3D"cancel_and_free"];
    pending    -> freed [label=3D"cancel_and_free"];
    running    -> freed [label=3D"cancel_and_free"];
    scheduled  -> freed [label=3D"cancel_and_free"];
    scheduling -> freed [label=3D"cancel_and_free"];
    standby    -> freed [label=3D"cancel_and_free"];
  }

[...]

> Flow of successful task work scheduling
>  1) bpf_task_work_schedule_* is called from BPF code.
>  2) Transition state from STANDBY to PENDING, marks context is owned by
>  this task work scheduler
>  3) irq_work_queue() schedules bpf_task_work_irq().
>  4) Transition state from PENDING to SCHEDULING.
>  4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>  transitions to SCHEDULED.

Nit: "4" repeated two times.

>  5) Task work calls bpf_task_work_callback(), which transition state to
>  RUNNING.
>  6) BPF callback is executed
>  7) Context is cleaned up, refcounts released, context state set back to
>  STANDBY.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 319 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 317 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 109cb249e88c..418a0a211699 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[...]

> +static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> +{
> +	/*
> +	 * Scheduled task_work callback holds ctx ref, so if we successfully
> +	 * cancelled, we put that ref on callback's behalf. If we couldn't
> +	 * cancel, callback is inevitably run or has already completed
> +	 * running, and it would have taken care of its ctx ref itself.
> +	 */
> +	if (task_work_cancel_match(ctx->task, task_work_match, ctx))

Will `task_work_cancel(ctx->task, ctx->work)` do the same thing here?

> +		bpf_task_work_ctx_put(ctx);
> +}

[...]

> +static void bpf_task_work_irq(struct irq_work *irq_work)
> +{
> +	struct bpf_task_work_ctx *ctx =3D container_of(irq_work, struct bpf_tas=
k_work_ctx, irq_work);
> +	enum bpf_task_work_state state;
> +	int err;
> +
> +	guard(rcu_tasks_trace)();
> +
> +	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=3D BPF_TW=
_PENDING) {
> +		bpf_task_work_ctx_put(ctx);
> +		return;
> +	}

Why are separate PENDING and SCHEDULING states needed?
Both indicate that the task had not been yet but is ready to be
submitted to task_work_add(). So, on a first glance it seems that
merging the two won't change the behaviour, what do I miss?

> +	err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> +	if (err) {
> +		bpf_task_work_ctx_reset(ctx);
> +		/*
> +		 * try to switch back to STANDBY for another task_work reuse, but we m=
ight have
> +		 * gone to FREED already, which is fine as we already cleaned up after=
 ourselves
> +		 */
> +		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
> +
> +		/* we don't have RCU protection, so put after switching state */
> +		bpf_task_work_ctx_put(ctx);
> +	}
> +
> +	/*
> +	 * It's technically possible for just scheduled task_work callback to
> +	 * complete running by now, going SCHEDULING -> RUNNING and then
> +	 * dropping its ctx refcount. Instead of capturing extra ref just to
> +	 * protected below ctx->state access, we rely on RCU protection to
> +	 * perform below SCHEDULING -> SCHEDULED attempt.
> +	 */
> +	state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
> +	if (state =3D=3D BPF_TW_FREED)
> +		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state=
 */
> +}

[...]

> +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_ta=
sk_work *tw,
> +							   struct bpf_map *map)
> +{
> +	struct bpf_task_work_ctx *ctx;
> +
> +	/* early check to avoid any work, we'll double check at the end again *=
/
> +	if (!atomic64_read(&map->usercnt))
> +		return ERR_PTR(-EBUSY);
> +
> +	ctx =3D bpf_task_work_fetch_ctx(tw, map);
> +	if (IS_ERR(ctx))
> +		return ctx;
> +
> +	/* try to get ref for task_work callback to hold */
> +	if (!bpf_task_work_ctx_tryget(ctx))
> +		return ERR_PTR(-EBUSY);
> +
> +	if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) !=3D BPF_TW_ST=
ANDBY) {
> +		/* lost acquiring race or map_release_uref() stole it from us, put ref=
 and bail */
> +		bpf_task_work_ctx_put(ctx);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	/*
> +	 * Double check that map->usercnt wasn't dropped while we were
> +	 * preparing context, and if it was, we need to clean up as if
> +	 * map_release_uref() was called; bpf_task_work_cancel_and_free()
> +	 * is safe to be called twice on the same task work
> +	 */
> +	if (!atomic64_read(&map->usercnt)) {
> +		/* drop ref we just got for task_work callback itself */
> +		bpf_task_work_ctx_put(ctx);
> +		/* transfer map's ref into cancel_and_free() */
> +		bpf_task_work_cancel_and_free(tw);
> +		return ERR_PTR(-EBUSY);
> +	}

I don't understand how the above check is useful.
Is map->usercnt protected from being changed during execution of
bpf_task_work_schedule()?
There are two such checks in this function, so apparently it is not.
Then what's the point of checking usercnt value if it can be
immediately changed after the check?

> +
> +	return ctx;
> +}
> +
> +static int bpf_task_work_schedule(struct task_struct *task, struct bpf_t=
ask_work *tw,
> +				  struct bpf_map *map, bpf_task_work_callback_t callback_fn,
> +				  struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
> +{
> +	struct bpf_prog *prog;
> +	struct bpf_task_work_ctx *ctx;
> +	int err;
> +
> +	BTF_TYPE_EMIT(struct bpf_task_work);
> +
> +	prog =3D bpf_prog_inc_not_zero(aux->prog);
> +	if (IS_ERR(prog))
> +		return -EBADF;
> +	task =3D bpf_task_acquire(task);
> +	if (!task) {
> +		err =3D -EPERM;

Nit: Why -EPERM? bpf_task_acquire() returns NULL if task->rcu_users
     is zero, does not seem to be permission related.

> +		goto release_prog;
> +	}
> +
> +	ctx =3D bpf_task_work_acquire_ctx(tw, map);
> +	if (IS_ERR(ctx)) {
> +		err =3D PTR_ERR(ctx);
> +		goto release_all;
> +	}
> +
> +	ctx->task =3D task;
> +	ctx->callback_fn =3D callback_fn;
> +	ctx->prog =3D prog;
> +	ctx->mode =3D mode;
> +	ctx->map =3D map;
> +	ctx->map_val =3D (void *)tw - map->record->task_work_off;
> +	init_task_work(&ctx->work, bpf_task_work_callback);
> +	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> +
> +	irq_work_queue(&ctx->irq_work);
> +	return 0;
> +
> +release_all:
> +	bpf_task_release(task);
> +release_prog:
> +	bpf_prog_put(prog);
> +	return err;
> +}
> +

[...]

