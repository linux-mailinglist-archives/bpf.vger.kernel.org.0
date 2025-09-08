Return-Path: <bpf+bounces-67761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE1B4975F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268E5177A7C
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331113148A2;
	Mon,  8 Sep 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKYe+hhP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84C1E1DE7
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353143; cv=none; b=GpQoiF2EDQdUaJJXB144UWg/UysHaYA1/JCJura82qoV1Wc2Bq5A9H+5vT1O21EFDZ2pETxIlDRWzUMIypXh6R3CqTOhPUIc/0BYjANOPBU/4Tq6Runy2HcvHKvDzkNoX6Bes7ogLTnyUjbxuY3QRmRuTYoE2IY+N0stN14YBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353143; c=relaxed/simple;
	bh=xEkkrzl5xkJngYJArYZYSslCCwJ0vcA45jgka7SOPQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LvgdtNMxkLXJkKLnrgfvIkbCaR2D00xi/oPSCA7HiQjVvt+fRBP+1tjbq7QtbUxe6VTLbKEKo5MGCg/UZzJiIDZkLIfJKrei2W9lgwuSVH2Q2y5x+r4KM3/ay5F4vZhxgmVPqC6LVRmYislqoDnceqyzqqrqDUqVNvfGADYCCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKYe+hhP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77269d19280so4212869b3a.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757353141; x=1757957941; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RLaYnNDSHjswkJsC5Vf6eDnJyCalrquOljqqNys/rDM=;
        b=cKYe+hhPJ2E8L8CdPvXViZwOkxdSlHqKU69zKwHV074r3BwY3SBw4YLiNZPvps66bv
         IuNilOIGEsLugLxQywyL6+bTC51fMfs2weTuYQbmWM03YhVkuweuBRsFlF+5y5aKWkIh
         IPtSx2PZO3TfRTctr2Kszj+2AoX3y005s9J0awuUXfcI2HZMLASmPRoFxZ/mJjScbM9B
         S0XdbPFx7YtgWYGjl6wjYoAXOQ9dXdvr59p28pluSM2pPY60qcV70hjzJJDO3LjXTP3x
         nnd2LoFbrfu1QyiK7iSzlC5PnxSTICkfOdQrvyO+KSYhzNFo/igMuDABCEsJ8Vs3+le+
         Rb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353141; x=1757957941;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLaYnNDSHjswkJsC5Vf6eDnJyCalrquOljqqNys/rDM=;
        b=mX1XFGj7Lr5RnuIkkIA+ihDyWz+pSsk6IyTd4dPnoGCX40xYJcDdzyfLKS4WZbZbez
         TPZ3WeFm/oV7+dBP7ULC1R/JrnQN6G8PVuWxplxoFq8Np6hQq2jcHJUtq+Uagb7rk5ia
         XKHrB5lfDxNghTyzlXX6wmNysVYIDfxmk/YY3fv7wAZ0rd5KtWKhxPrC7Le9xdR/7leS
         jCJAVgzGlDFEkU2jJ1RzyKtmFHnY6jD7+KJvsKRf/MnW1UUWqlPMJAWMWtWipbeaW8u/
         cosYwu1OWprGb0vkcBUSEvb9PIYzmoiZnXsAe7N2yyxS9Dbq/KkpdYEwQfjw6g2kR9bW
         Vejg==
X-Forwarded-Encrypted: i=1; AJvYcCWSLL72UknhauNYPhe+Aa5LWE0yH8nMhtNlhGeCsJBcRZxVhN4yDnDgreERcsbw5jQdcpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29veBb6cEcj4ZZS8OO6Oh97HWWimhtU8MEM8p7I5MM3cu0ZAa
	Lx/px1pOmd/eQqwjr1hugpei69qodkMloW0wPM/ujttxAk0tLjJi80Gh
X-Gm-Gg: ASbGncuXrTBMaaXu4QDJ5x1jQKyGD4mil7vP3foHnzZm+/32ZTMZPgFCrO0VkdDMpaJ
	F+SMtOBfxaet3M6PnYnPRsdHzJjpSfZ4zWyKkA0cuLpo3UiAYHKuoqMA0qm2scktfrdxBGq0x3i
	cWrIVK4XdZGrPnS5xkVgcFYLQqYcI6x4AGrjexSegin0PjgfNLMlSJvsPqnSYT6OP3gvE/v9A2u
	l02f/XQwmRz2fpRA/HKapCdKld2lRXD1LBDKvyiAX+mprxAWgT+WBRnUsc0RhQiY6mC54S+o2TA
	9DkBFp9FAog5y15VcVY9Vf7IjObCAqYtp42390u5vTe+V5HztRp0iLGAD3wyut54Xnvhd93Y0bV
	p9pEKua6qcFUDrc2n8MPiQaCU88PIWGx4B0zCJ/+FvCXwkemvjtKRwQYaQQ==
X-Google-Smtp-Source: AGHT+IHWeFu6BQsuGrgeEiaS8rsYYkFKqEcyYGMDSTFmJ6taEVPhYLaxAvJXXON16Os+LCeGVVHCYg==
X-Received: by 2002:a05:6a00:2ea1:b0:771:ecf2:53ba with SMTP id d2e1a72fcca58-7742dc9efdbmr10221840b3a.7.1757353141341;
        Mon, 08 Sep 2025 10:39:01 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1f59sm29589563b3a.77.2025.09.08.10.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:39:00 -0700 (PDT)
Message-ID: <b727f3872d51c2b8cc622fb01cdc864a3336b9d8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 08 Sep 2025 10:38:59 -0700
In-Reply-To: <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
	 <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
	 <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 14:13 +0100, Mykyta Yatsenko wrote:

[...]

> > > +static void bpf_task_work_irq(struct irq_work *irq_work)
> > > +{
> > > +	struct bpf_task_work_ctx *ctx =3D container_of(irq_work, struct bpf=
_task_work_ctx, irq_work);
> > > +	enum bpf_task_work_state state;
> > > +	int err;
> > > +
> > > +	guard(rcu_tasks_trace)();
> > > +
> > > +	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=3D BP=
F_TW_PENDING) {
> > > +		bpf_task_work_ctx_put(ctx);
> > > +		return;
> > > +	}
> > Why are separate PENDING and SCHEDULING states needed?
> > Both indicate that the task had not been yet but is ready to be
> > submitted to task_work_add(). So, on a first glance it seems that
> > merging the two won't change the behaviour, what do I miss?

> Yes, this is right, we may drop SCHEDULING state, it does not change any=
=20
> behavior compared to PENDING.
> The state check before task_work_add is needed anyway, so we won't=20
> remove much code here.
> I kept it just to be more consistent: with every state check we also=20
> transition state machine forward.

Why is state check before task_work_add() mandatory?
You check for FREED in both branches of task_work_add(),
so there seem to be no issues with leaking ctx.

> > > +	err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> > > +	if (err) {
> > > +		bpf_task_work_ctx_reset(ctx);
> > > +		/*
> > > +		 * try to switch back to STANDBY for another task_work reuse, but =
we might have
> > > +		 * gone to FREED already, which is fine as we already cleaned up a=
fter ourselves
> > > +		 */
> > > +		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
> > > +
> > > +		/* we don't have RCU protection, so put after switching state */
> > > +		bpf_task_work_ctx_put(ctx);
> > > +	}
> > > +
> > > +	/*
> > > +	 * It's technically possible for just scheduled task_work callback =
to
> > > +	 * complete running by now, going SCHEDULING -> RUNNING and then
> > > +	 * dropping its ctx refcount. Instead of capturing extra ref just t=
o
> > > +	 * protected below ctx->state access, we rely on RCU protection to
> > > +	 * perform below SCHEDULING -> SCHEDULED attempt.
> > > +	 */
> > > +	state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED)=
;
> > > +	if (state =3D=3D BPF_TW_FREED)
> > > +		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED s=
tate */
> > > +}
> > [...]
> >=20
> > > +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bp=
f_task_work *tw,
> > > +							   struct bpf_map *map)
> > > +{
> > > +	struct bpf_task_work_ctx *ctx;
> > > +
> > > +	/* early check to avoid any work, we'll double check at the end aga=
in */
> > > +	if (!atomic64_read(&map->usercnt))
> > > +		return ERR_PTR(-EBUSY);
> > > +
> > > +	ctx =3D bpf_task_work_fetch_ctx(tw, map);
> > > +	if (IS_ERR(ctx))
> > > +		return ctx;
> > > +
> > > +	/* try to get ref for task_work callback to hold */
> > > +	if (!bpf_task_work_ctx_tryget(ctx))
> > > +		return ERR_PTR(-EBUSY);
> > > +
> > > +	if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) !=3D BPF_T=
W_STANDBY) {
> > > +		/* lost acquiring race or map_release_uref() stole it from us, put=
 ref and bail */
> > > +		bpf_task_work_ctx_put(ctx);
> > > +		return ERR_PTR(-EBUSY);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Double check that map->usercnt wasn't dropped while we were
> > > +	 * preparing context, and if it was, we need to clean up as if
> > > +	 * map_release_uref() was called; bpf_task_work_cancel_and_free()
> > > +	 * is safe to be called twice on the same task work
> > > +	 */
> > > +	if (!atomic64_read(&map->usercnt)) {
> > > +		/* drop ref we just got for task_work callback itself */
> > > +		bpf_task_work_ctx_put(ctx);
> > > +		/* transfer map's ref into cancel_and_free() */
> > > +		bpf_task_work_cancel_and_free(tw);
> > > +		return ERR_PTR(-EBUSY);
> > > +	}
> > I don't understand how the above check is useful.
> > Is map->usercnt protected from being changed during execution of
> > bpf_task_work_schedule()?
> > There are two such checks in this function, so apparently it is not.
> > Then what's the point of checking usercnt value if it can be
> > immediately changed after the check?

> BPF map implementation calls bpf_task_work_cancel_and_free() for each=20
> value when map->usercnt goes to 0.
> We need to make sure that after mutating map value (attaching a ctx,=20
> setting state and refcnt), we do not
> leak memory to a newly allocated ctx.
> If bpf_task_work_cancel_and_free() runs concurrently with=20
> bpf_task_work_acquire_ctx(), there is a chance that map cleans up the=20
> value first and then we attach a ctx with refcnt=3D2, memory will leak.=
=20
> Alternatively, if map->usercnt is set to 0 right after this check, we=20
> are guaranteed to have the initialized context attached already, so the=
=20
> refcnts will be properly decremented (once by=20
> bpf_task_work_cancel_and_free()
> and once by bpf_task_work_irq() and clean up is safe).
>=20
> In other words, initialization of the ctx in struct bpf_task_work is=20
> multi-step operation, those steps could be
> interleaved with cancel_and_free(), in such case the value may leak the=
=20
> ctx. Check map->usercnt=3D=3D0 after initialization,
> to force correct cleanup preventing the leak. Calling cancel_and_free()=
=20
> for the same value twice is safe.

Ack, thank you for explaining.

> >=20
> > > +
> > > +	return ctx;
> > > +}

[...]

