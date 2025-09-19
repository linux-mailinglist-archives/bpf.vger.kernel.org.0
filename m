Return-Path: <bpf+bounces-68942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24331B8A968
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36001C27C3D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563E22D7B5;
	Fri, 19 Sep 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOFbu1Wc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F346A927
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299753; cv=none; b=sI6lbMlIkmvmXzTe07np0rlKh8fJ7KbavKjHfCjkrxF8CUf2pTQkPkRRwL+TpwomhwmQ0tRjn2qI4bFVS2u331OnIdUUyhwrBmBC4NvLEEbUk++PCqaK6G41kyxICbmi59ejlJSi7B3w5cn8Ga2fAo9Ojs/ZkkjF1RIL4nORkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299753; c=relaxed/simple;
	bh=sBYymB3WPr2ZLF3vTCkyvHau2o3NU1SAN81nI/AxJeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSN8I2pUE/WdF0rlUb0r+qCjE13J1bT2Ti231zo67nLuJSsE7wDGTW2dfP28WPz1HbSpTeTjeynkgVxbBYw++MbIL/jLq19v1VI0VmLohK/e2U4kzE0uoh9DsWKlhGL1dFGpdwWdpe0rDqWJmbTKB9qurOzmO9zLa83iYTnKyGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOFbu1Wc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5516255bedso899149a12.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758299751; x=1758904551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zpeob8vSZ5yLJNzJfKdXalSZn1wyzCSF06TBMENPCYE=;
        b=SOFbu1WcH/PXk0+hvpOi6hlKozBQwapfnwz5aNYY/tSvkcm9rZlk1JZmT9D+kAYnUG
         vFWn+t5yGTstSKf9Mz37mYGkr1VIxPx2o4T64DRn/Q6LSW0a+8yAQyoo9J/Jb3MkvYuc
         ws1DnQx6nqWLfe+0hzQPftpmSW2XKNRRdL5mBx3VAx6X4DxOeotc4XF7QWp1SLsCgxUb
         8K9ZrajTC3JdQe6EViZroqRkQ5CryTI8nyAOazX2Kqhh9qVwoxyPrV+TTYiDhySqfBBs
         sRO+FwRgeh7fbx8QeumlUVRIexud/Wn1g65Sazvy8sg1f0sWqwsbOrZyvMwc3U40CXxe
         IvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299751; x=1758904551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zpeob8vSZ5yLJNzJfKdXalSZn1wyzCSF06TBMENPCYE=;
        b=qpxPr7RtNg2s0wjtJiV9S9p1zp/KIYohq3s8kiEI8t4xkPjjr6r761yCkm1peQQZFO
         mUi83CiFjkQ7973sk46LAtISQjTvVWxr00GDEKSrqeuRtlXJAgGWeaeIB1J/gJ0J8rwh
         sAhv867cU/5nG/Kk5/YfoTCLJCQvqfwQcLFGi3ORWILixPCQrpmllSX1wMzDeF7u4DoF
         yhJ05iZxxVZVvB0AE7Ukv9aHYMyQP4512L2a6zv6Ziw04ctktH5akFAwlfYzdo7VVyzj
         8t5fWEV/8QYIiLNcJIc/R9BG2yZN0CD1Y0OpbYnB8mOeTOvRFj+SEqIxVDCEmLMQgmFe
         1c9w==
X-Forwarded-Encrypted: i=1; AJvYcCWBcz/GwrCYdJcKcJLtv68vq62YZK4kd1IrTBJQWDOcbT0OT26r1oNXg1Jw1UHWYRdoGpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVFhDVPDoK7qlQFm2KVIWiDAjS7lW4dPyIwKRCWTmYYdu+c9Y
	LCOV/w32h1Hkcq5iIDkygySGKnhcSfELgVC8+sIDl3qlSGcA/4Syk6EwkGYWC7b5sykcBtI50VB
	7YBa98E7Mr6PWaus9ZugCUch5jWRxn6I=
X-Gm-Gg: ASbGncsq/kBr94L+GCbD2IDOWteS6sqOfTNptvt1RMF+0N6Hsig3YnEh6AzKMb1J+Oy
	yfUUazKDNnBwRXSxYAzf7YFkUy04ROLaLb7tdgLZOeVPiXiYkbBYpKTFaXD7CO3ZZqxhdxkdkbS
	F7cDt28WbEe+iQAYInfXsO5H7Ow9GtBfD6X0pHNdlLC5UlusLUMHw+G71KJqlGVgSyvOkH3tP30
	84RmyHNxJZWrCma/qF56oU=
X-Google-Smtp-Source: AGHT+IF69Zalh2J7Kv3MdwrQKPhZhwmt1U+cexIuki4dNqcSCGBk6+rVW6yWcmuNvNaS4WbfQI0VbFTuSj18qYerL7I=
X-Received: by 2002:a17:902:f64f:b0:269:96a1:d96e with SMTP id
 d9443c01a7336-269ba46699fmr53205735ad.20.1758299751134; Fri, 19 Sep 2025
 09:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
 <20250918132615.193388-8-mykyta.yatsenko5@gmail.com> <CAADnVQJfGqKpOhQpx_a-kKfv34XRE=hDZAN=u-=CVppUF5wfzA@mail.gmail.com>
 <171ddd7f-a100-4800-b0f3-1ac8e25c13d8@gmail.com> <CAP01T76m5DLzy5TKjrDOG5JQqjtSZOHkJtMRx8vNbWZSK4CGnQ@mail.gmail.com>
In-Reply-To: <CAP01T76m5DLzy5TKjrDOG5JQqjtSZOHkJtMRx8vNbWZSK4CGnQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 09:35:39 -0700
X-Gm-Features: AS18NWBxghXbRRD8L_wVi5xtky7P2G4k_roGOXQ0P89K1lN4KWcDgIwv4MzgBQ4
Message-ID: <CAEf4BzYhH-qjJzOnqMVHRp5RbKT-vnJDiLxH0+E3-=M4qc_AKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf: task work scheduling kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:53=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 19 Sept 2025 at 14:27, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > On 9/19/25 01:56, Alexei Starovoitov wrote:
> > > On Thu, Sep 18, 2025 at 6:26=E2=80=AFAM Mykyta Yatsenko
> > > <mykyta.yatsenko5@gmail.com> wrote:
> > >> +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct b=
pf_task_work *tw,
> > >> +                                                          struct bp=
f_map *map)
> > >> +{
> > >> +       struct bpf_task_work_ctx *ctx;
> > >> +
> > >> +       /* early check to avoid any work, we'll double check at the =
end again */
> > >> +       if (!atomic64_read(&map->usercnt))
> > >> +               return ERR_PTR(-EBUSY);
> > >> +
> > >> +       ctx =3D bpf_task_work_fetch_ctx(tw, map);
> > >> +       if (IS_ERR(ctx))
> > >> +               return ctx;
> > >> +
> > >> +       /* try to get ref for task_work callback to hold */
> > >> +       if (!bpf_task_work_ctx_tryget(ctx))
> > >> +               return ERR_PTR(-EBUSY);
> > >> +
> > >> +       if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) !=
=3D BPF_TW_STANDBY) {
> > >> +               /* lost acquiring race or map_release_uref() stole i=
t from us, put ref and bail */
> > >> +               bpf_task_work_ctx_put(ctx);
> > >> +               return ERR_PTR(-EBUSY);
> > >> +       }
> > >> +
> > >> +       /*
> > >> +        * Double check that map->usercnt wasn't dropped while we we=
re
> > >> +        * preparing context, and if it was, we need to clean up as =
if
> > >> +        * map_release_uref() was called; bpf_task_work_cancel_and_f=
ree()
> > >> +        * is safe to be called twice on the same task work
> > >> +        */
> > >> +       if (!atomic64_read(&map->usercnt)) {
> > >> +               /* drop ref we just got for task_work callback itsel=
f */
> > >> +               bpf_task_work_ctx_put(ctx);
> > >> +               /* transfer map's ref into cancel_and_free() */
> > >> +               bpf_task_work_cancel_and_free(tw);
> > >> +               return ERR_PTR(-EBUSY);
> > >> +       }
> > >> +
> > >> +       return ctx;
> > >> +}
> > > If I understood the logic correctly the usercnt handling
> > > is very much best effort: "let's try to detect usercnt=3D=3D0
> > > and clean thing up, but if we don't detect it should be ok too".
> > > I think it distracts from the main state transition logic.
> > > I think it's better to remove both map->usercnt checks
> > > and comment how the race with release_uref() is handled
> > > through the state transitions.
> > >
> > > Why above usercnt=3D=3D0 check is racy?
> > > Because usercnt could have become zero right after this atomic64_read=
().
> > > Then valid ctx (though maybe detached) would have been returned
> > > to bpf_task_work_schedule(), and it would proceed with
> > > irq_work_queue().
> > > tw->ctx either already xchg-ed to NULL or will be soon.
> > >
> > > The bpf_task_work_irq() callback would fire eventually it will do
> > >   + if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=3D
> > > BPF_TW_PENDING) {
> > >
> > > if releas_uref() already did bpf_task_work_cancel_and_free()
> > > then ctx->state =3D=3D BPF_TW_FREED and
> > >    +   bpf_task_work_ctx_put(ctx);
> > >    +   return;
> > >    + }
> > > will be called on this detached ctx.
> > >
> > > but xchg(&ctx->state, BPF_TW_FREED) might not have been done.
> > > so the code will proceed...
> > > and further it looks correct when it comes to handling
> > > races with cancel_and_free().
> > >
> > > The point that usercnt=3D=3D0 or not doesn't change thing.
> > > We don't check it in the steps after acquire_ctx().
> > > It looks to me these two checks in bpf_task_work_acquire_ctx()
> > > don't fix any race.
> > > It seems to me they can be removed without affecting correctness,
> > > and if so, let's remove them to avoid misleading
> > > readers and ourselves in the future that they matter.
> > >
> > > Note, similar usercnt checks in bpf_timer are not analogous,
> > > since they're done under lock with async->cb manipulations.
> > >
> > >
> > > Also I believe Eduard requested stess test to be part of patchset.
> > > Please include it. I'd like to see what kind of stress testing
> > > was done. Patch 8 is just basic sanity.
> > An example of race condition I'm handling is:
> > Imagine usercnt gets to 0, and then for some map value cancel_and_free(=
)
> > (detach context) races with bpf_task_work_fetch_ctx() (attach context),
> > if this race resolves to context first being detached (by
> > cancel_and_free())
> > and then new one attached (by scheduling codepath).
> > Detached context state is set to FREED and it's deallocated.
> > But newly attached context state is STANDBY (cancel_and_free() has neve=
r
> > seen it)
> > and map holds the refcnt to it, which never go to 0, as cancel_and_free=
()
> > for the element has been already called, so we never free it.
> >
> > It's not a problem if usercnt goes to 0 after we attached a context,
> > because cancel_and_free() will detach and
> > put the refcnt, and scheduling codepath will see the FREED state.
> >
> > Other thing is checking usercnt =3D=3D 0 before context initialization =
-
> > that's preventing allocation and attach a context to a map that has
> > already done cleanup. Cleanup won't happen again and this new context
> > is leaked.
> >
> > Trying to summarize:
> >   1) First check for usercnt =3D=3D 0 is needed so that we don't alloca=
te
> > contexts
> > for map that has already cleaned up.
> >   2) Second check is needed in case of clean up is triggered during con=
text
> > initialization/attach, potentially leading to newly attached context le=
ak,
> > as cancel_and_free() was called for old context and won't be called for
> > new one.
> >   3) After context initialization/attach is done, we don't need checkin=
g
> > for usercnt,
> > as cancel_and_free() will detach and transition to FREED. The state
> > transition will
> > be seen by scheduling codepath.
>
> I agree, I don't see how we can avoid checking usercnt. Maybe we don't
> need to check it twice, i.e. optimistically first and then again after
> cmpxchg and can only do it once.
> Since this is not a common case it's nbd that we have to put and

You can have a very long-lived BPF map that is only referenced from
loaded/attached BPF program with usercnt=3D=3D0, so it's not necessarily a
short-lived state. From a correctness standpoint, yes, we can omit the
first check, but I'd still do it.

> deallocate stuff. But if we don't do usercnt check at all, we will
> leak memory.
> Once usercnt drops to zero and task work lingers in map value, nothing
> will come and free it anymore, short of user deleting the map value
> manually, which is not guaranteed.

