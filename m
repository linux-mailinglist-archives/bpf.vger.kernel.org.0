Return-Path: <bpf+bounces-67838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A956B4A028
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 05:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000D24E63D7
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0692BE7C3;
	Tue,  9 Sep 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9tsk/1w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2843273803
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389359; cv=none; b=ZKCv434miLfNhhSDqtRiRvX4pbRu2Tn2P8ET1ye4eZxiTYXYzP+XIxyFb041Mpw68SrDyyxtz/fH+g7U52nVRT2q0VkoL3U2SVd8rmHvLyLox/onmHySWSBvdQn9T63h7rq83IambjeRAc1yDSIIWq1LfIoCWrs4PcZlJ8ljYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389359; c=relaxed/simple;
	bh=KcvLrDinvCBBZEr4M1vWkUaq6uLKXn90rvGigqNeEB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+3AEVZ6VwLJ+My8I5TMumczfmSOfvzIu/luam3Tl7UCv8IKBni4c7FYAoBFQjZpnnAzE4fcT1Vhly9yJBrgFOuOKf5Jq9U74rNiBMwcfC8UZdMaucVoHw9M/LikPorbB2fuZe1HIZT7H1ol8/UZOAaJAEQtXqGIsgqaFy9dTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9tsk/1w; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329b76008c6so4159337a91.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 20:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757389357; x=1757994157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzrUZzQG/iK5s7y83VcbGZJu1ceY5/fRFUJrdo/r+qc=;
        b=B9tsk/1wVFI1yjm9A+M9awqWKVf9aRqSKgf6zrCluIsl8ZkneGgsDFuPiwaZxyhC+L
         5FCCYXMclW/T+JpMYIPEbV1clEqXiH/Zm+SdHjj0x8DScmoj8ZkzsJKERyrO9MsYmxTJ
         DEWhzz4esW5iArE6aQxndmbzg7ozbQbFSye6zzt4Ay56jYDcv2DgqM3zxhBpl90ifMr3
         q77qvgw9kOEQkgZGKooo1NmOHGLl9yAl5ri6T2NXPOsMbWSYMjPABjqTE/04JQ94n7yN
         w0G7IWnOqubGpP+ZuYUgP7Ou4PuU/Ka7laH9Fs6G0CWYloxkUL9FZwJbm93Ga2yC3mgU
         FxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389357; x=1757994157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzrUZzQG/iK5s7y83VcbGZJu1ceY5/fRFUJrdo/r+qc=;
        b=JhdeDErMy1dYNGjlZE8T6WacLKG91YiVY4SbpP5EiawcQeX44OlHjb9JyxB7dJBrS1
         ngi3/AQEhyUgY05eaBhy6HQFuKBLqmXtbKOc1Mj03KHwzkPIZO/28D7uxOI07CNAj5aO
         7lgCEPBrdWCLZz2dkOoZCAykm9D4PYfAW95LqyYpxNgHfUAS5B2g/qKMFkD1sFrzNHs4
         gzr4QRgFQTz4Un2uob54PfWC+UqcLhRl6sEUYiabfs7g5FPH+IlJIQ58ScUd2qlAf86F
         6VpXERUY/sMn+nrLEZVYF2pkZyxzG/0RV1O3ffjqOxtiPncFZExjfSGbZCQFVXOX7clH
         yR6A==
X-Forwarded-Encrypted: i=1; AJvYcCU+gLhHasMff8tRykOc26Sz/j3oMnXBy8nbi39qQ0piul6IYqlEwOzGTEr+VZ0fCiLVg/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+HxASt6SU0+5NcARI9Vcmorrp91KnrefBqeDs1EnWLJLXvpW
	N+B8DAb/9oDArJrFCMkdW2dfD5yuNAjK68vPsVhIAtsldQIcWikMIawjVOcV1Wjod9c5qO4LuBD
	GHaQmL8MQmiVLou2xoo3cTvrLFjRm4O0=
X-Gm-Gg: ASbGncv/7KLGiqoctXIkwEzpumHpX2qMtjKI9Rx/MZZmnqHj+IkeiPEdqmrY31fgYY1
	SClrWp/io+XsD9NLNI2ozNtqunli+3xGdehRpNMEbTZUdGnO4LdgcLo1YvhGbSuqFlNMZoNi0v0
	zaxIV1PuxzhinIWQk7Vxm86K27s651n0NUZvl0nH3dYVwfHykscGgRM5AtvP0BeI2XAmSO8vU3z
	pBkmrFKhbNNBc5rNqI=
X-Google-Smtp-Source: AGHT+IHn74N1BxFzZZCjl2zHvPTTWGyI8gtCigiGxRhI2QqkpAbahMfFVqNWd32fSZbaw+XrA8RChQnvA464hMsvLME=
X-Received: by 2002:a17:90b:5344:b0:32b:7082:b2 with SMTP id
 98e67ed59e1d1-32d43f7ddc1mr14567542a91.23.1757389356835; Mon, 08 Sep 2025
 20:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com> <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
 <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com> <b727f3872d51c2b8cc622fb01cdc864a3336b9d8.camel@gmail.com>
In-Reply-To: <b727f3872d51c2b8cc622fb01cdc864a3336b9d8.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Sep 2025 23:42:24 -0400
X-Gm-Features: Ac12FXzzfaft3RjFbCMu5XIAwwqvLgvrv-Emu4pyHY-rYX19t-j8PEFM6SY29Vc
Message-ID: <CAEf4BzbVbCMiTKC8Zz96W16tKCU2cfiM2ULAA7B2ofb0hRZ6sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-09-08 at 14:13 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
> > > > +static void bpf_task_work_irq(struct irq_work *irq_work)
> > > > +{
> > > > + struct bpf_task_work_ctx *ctx =3D container_of(irq_work, struct b=
pf_task_work_ctx, irq_work);
> > > > + enum bpf_task_work_state state;
> > > > + int err;
> > > > +
> > > > + guard(rcu_tasks_trace)();
> > > > +
> > > > + if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=3D =
BPF_TW_PENDING) {
> > > > +         bpf_task_work_ctx_put(ctx);
> > > > +         return;
> > > > + }
> > > Why are separate PENDING and SCHEDULING states needed?
> > > Both indicate that the task had not been yet but is ready to be
> > > submitted to task_work_add(). So, on a first glance it seems that
> > > merging the two won't change the behaviour, what do I miss?
>
> > Yes, this is right, we may drop SCHEDULING state, it does not change an=
y
> > behavior compared to PENDING.
> > The state check before task_work_add is needed anyway, so we won't
> > remove much code here.
> > I kept it just to be more consistent: with every state check we also
> > transition state machine forward.
>
> Why is state check before task_work_add() mandatory?
> You check for FREED in both branches of task_work_add(),
> so there seem to be no issues with leaking ctx.

Not really mandatory, but I think it is good to avoid even attempting
to schedule task_work if the map element was already deleted?
Technically, even that last FREED check in bpf_task_work_irq is not
strictly necessary, we could have always let task_work callback
execute and bail all the way there, but that seems too extreme (and
task_work can be delayed by a lot for some special task states, I
think).

Also, keep in mind, this same state machine will be used for timers
and wqs (at least we should try), and so, in general, being diligent
about not doing doomed-to-be-failed-or-cancelled work is a good
property.

>
> > > > + err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> > > > + if (err) {
> > > > +         bpf_task_work_ctx_reset(ctx);
> > > > +         /*
> > > > +          * try to switch back to STANDBY for another task_work re=
use, but we might have
> > > > +          * gone to FREED already, which is fine as we already cle=
aned up after ourselves
> > > > +          */
> > > > +         (void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STAN=
DBY);
> > > > +
> > > > +         /* we don't have RCU protection, so put after switching s=
tate */
> > > > +         bpf_task_work_ctx_put(ctx);
> > > > + }
> > > > +
> > > > + /*
> > > > +  * It's technically possible for just scheduled task_work callbac=
k to
> > > > +  * complete running by now, going SCHEDULING -> RUNNING and then
> > > > +  * dropping its ctx refcount. Instead of capturing extra ref just=
 to
> > > > +  * protected below ctx->state access, we rely on RCU protection t=
o
> > > > +  * perform below SCHEDULING -> SCHEDULED attempt.
> > > > +  */
> > > > + state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULE=
D);
> > > > + if (state =3D=3D BPF_TW_FREED)
> > > > +         bpf_task_work_cancel(ctx); /* clean up if we switched int=
o FREED state */
> > > > +}
> > > [...]
> > >
> > > > +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct =
bpf_task_work *tw,
> > > > +                                                    struct bpf_map=
 *map)
> > > > +{
> > > > + struct bpf_task_work_ctx *ctx;
> > > > +
> > > > + /* early check to avoid any work, we'll double check at the end a=
gain */
> > > > + if (!atomic64_read(&map->usercnt))
> > > > +         return ERR_PTR(-EBUSY);
> > > > +
> > > > + ctx =3D bpf_task_work_fetch_ctx(tw, map);
> > > > + if (IS_ERR(ctx))
> > > > +         return ctx;
> > > > +
> > > > + /* try to get ref for task_work callback to hold */
> > > > + if (!bpf_task_work_ctx_tryget(ctx))
> > > > +         return ERR_PTR(-EBUSY);
> > > > +
> > > > + if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) !=3D BPF=
_TW_STANDBY) {
> > > > +         /* lost acquiring race or map_release_uref() stole it fro=
m us, put ref and bail */
> > > > +         bpf_task_work_ctx_put(ctx);
> > > > +         return ERR_PTR(-EBUSY);
> > > > + }
> > > > +
> > > > + /*
> > > > +  * Double check that map->usercnt wasn't dropped while we were
> > > > +  * preparing context, and if it was, we need to clean up as if
> > > > +  * map_release_uref() was called; bpf_task_work_cancel_and_free()
> > > > +  * is safe to be called twice on the same task work
> > > > +  */
> > > > + if (!atomic64_read(&map->usercnt)) {
> > > > +         /* drop ref we just got for task_work callback itself */
> > > > +         bpf_task_work_ctx_put(ctx);
> > > > +         /* transfer map's ref into cancel_and_free() */
> > > > +         bpf_task_work_cancel_and_free(tw);
> > > > +         return ERR_PTR(-EBUSY);
> > > > + }
> > > I don't understand how the above check is useful.
> > > Is map->usercnt protected from being changed during execution of
> > > bpf_task_work_schedule()?
> > > There are two such checks in this function, so apparently it is not.
> > > Then what's the point of checking usercnt value if it can be
> > > immediately changed after the check?
>
> > BPF map implementation calls bpf_task_work_cancel_and_free() for each
> > value when map->usercnt goes to 0.
> > We need to make sure that after mutating map value (attaching a ctx,
> > setting state and refcnt), we do not
> > leak memory to a newly allocated ctx.
> > If bpf_task_work_cancel_and_free() runs concurrently with
> > bpf_task_work_acquire_ctx(), there is a chance that map cleans up the
> > value first and then we attach a ctx with refcnt=3D2, memory will leak.
> > Alternatively, if map->usercnt is set to 0 right after this check, we
> > are guaranteed to have the initialized context attached already, so the
> > refcnts will be properly decremented (once by
> > bpf_task_work_cancel_and_free()
> > and once by bpf_task_work_irq() and clean up is safe).
> >
> > In other words, initialization of the ctx in struct bpf_task_work is
> > multi-step operation, those steps could be
> > interleaved with cancel_and_free(), in such case the value may leak the
> > ctx. Check map->usercnt=3D=3D0 after initialization,
> > to force correct cleanup preventing the leak. Calling cancel_and_free()
> > for the same value twice is safe.
>
> Ack, thank you for explaining.

btw, one can argue that first map->usercnt=3D=3D0 check is also not
mandatory, we can always go through allocating/getting context and
only then check map->usercnt, but see above, I think we should be
diligent and avoid useless work.

>
> > >
> > > > +
> > > > + return ctx;
> > > > +}
>
> [...]

