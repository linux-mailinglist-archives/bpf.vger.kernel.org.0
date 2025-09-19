Return-Path: <bpf+bounces-68973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65BB8B33C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CB4A057E4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC127B338;
	Fri, 19 Sep 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoWr0dzh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D785225D6
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314658; cv=none; b=YlWxQoZMJ/qsv/gNEPdIpi0u0hSfoq6t8savgm5W7NffddXg8OZvNrvOLdegybYADGBbMhx9mqjEix6WeHM/xyZg546eCpuBsWZZXN7s+n3aQjmQo4HOEgevt+pB4EhNISe+OteLnwsIt7gHHxGf+Yz2xc4WExP+VsgqU1URV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314658; c=relaxed/simple;
	bh=ZTqpwe/YQsjijQpmAYrpqaDxzRc8MrAVMaIfDsZBh6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfJTDv8mEbXeCb/bJh+QaEnab2S2EqUN1Wlez42qAUCSVVdXHlmFfbtytiKvlquEC8v9I3m3uK85zBd3jsIMJ8daGbnwxR+/dzmOqguGNHVIl81bME4Rm+zvF60IrbISER+N+L16IOb7Qy25Tqje8MlVu06b3d2mzmW6OXy/p/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoWr0dzh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso24243335e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758314653; x=1758919453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia+JL9v8gRpOVEaQtdOQAwRA/Lakve3wzZahhgqBWeQ=;
        b=KoWr0dzhVK9gkd4ihExOHQLyDZdBHNnB/N4IJzG3zG6QCN/N/xlxOdfLU4Fr+RaETX
         cuhWiwxxjuVKpGCR2H0g7mB0vReHzKF3DOEfTHlECCcV6Gwp4aEo1mcY/vYsb2BC3bHF
         gumFoiKLHd3F6yYTGI2f3Xw/yUQSf3iTK9feogjXb/ql7D+WKS0mPWgc0MIidUtSUadL
         py8dmdmdjUpdoFQg9ggEcFWD06SrKls9DgqW3sz9L3wQA+Nsih+qbiVyPdyQFUpj5THz
         JsLBOp0KwXdmTjRQ2ckSVkZB0Xi74B8PQd2eTTDZO5ev1vZJ8WD+UuLuHMKevVca6iGE
         TOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314653; x=1758919453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ia+JL9v8gRpOVEaQtdOQAwRA/Lakve3wzZahhgqBWeQ=;
        b=w3k3+QW+sZU6QuCVY+c82sXAn4LCCT7/hIjtnkyQ6MHDWXc3m8HB2W2MyfeNQdoRfG
         xyfuUAo0fyC8TrrOX/lmhdyrd2D/pjcZlubuEkDNmp3Im1H6D41Qd7sonkdYEC8N2K92
         RlAd45uSITtYBG+tbeprPXBwObGX7m8frhsp+lonq0T0Esw5juIKdV4KKOa5d52euNKf
         GxZTesgPt+kOvepxpRjMPN9teetU3IR5OR2q9uW0owKbVTdtjFLEnnrF4Xag16wP2Exk
         /u0MKjk6mfANFPl+H5Yq7usaDmakEazBJyus+6cWIQATwOsSMajY+quAqyRmWiHz7K62
         f6mA==
X-Forwarded-Encrypted: i=1; AJvYcCX5i3u7oszCO1B4gVamc36th8QsP7NtoL/Z4IkaFkEq80jX8+sTlQF7ggKoZkVFYEASdTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUI24vm9cSvnyP0lYr+Ryx8CD/JLH87JDDzII2PvtDq5HNWogU
	yx3ZqjK0q85au2cpUMAvWdC1ZPSvCnC10vHUfdJJkUBSVWiXqpIc0fVllEPBfsebCGnDArXomCn
	Lr4T3JUY7D11dScyEupsJfdhpDh1+et8=
X-Gm-Gg: ASbGnct681ZObIHBD17jtzkwYWiW18lWfbxqo9RpmL8O6ikIO8IfiH0tiAGXUvIrf5O
	KkhgMfYrEfeUHyWQZ6dXe6WOLAm/9JxDtcoTrDOGhBKdwJYyuoZt/Fnm4Qtd0xbZPytJyk2+DtX
	NlbgcFVVN37UO6FLANOrX5hLshgbrOlVX+JS/AtKRxm1Jas7bLOnnvp2W5l3cyE9Qwgzq7GNI+c
	SY6ikCgfE5JigTVH5cKBlk=
X-Google-Smtp-Source: AGHT+IG6HxXxtpjYcAcrP1MVCCD3otMula1ma/4gXpLbs+3HNWB/uTrjUOC/don2OFzDtHw/1iux7FCp3Su8R/++kb4=
X-Received: by 2002:a05:6000:18a3:b0:3c7:e6d0:b1b6 with SMTP id
 ffacd0b85a97d-3ee16320510mr4773632f8f.9.1758314652504; Fri, 19 Sep 2025
 13:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
 <20250918132615.193388-8-mykyta.yatsenko5@gmail.com> <CAADnVQJfGqKpOhQpx_a-kKfv34XRE=hDZAN=u-=CVppUF5wfzA@mail.gmail.com>
 <171ddd7f-a100-4800-b0f3-1ac8e25c13d8@gmail.com> <CAP01T76m5DLzy5TKjrDOG5JQqjtSZOHkJtMRx8vNbWZSK4CGnQ@mail.gmail.com>
 <CAEf4BzYhH-qjJzOnqMVHRp5RbKT-vnJDiLxH0+E3-=M4qc_AKg@mail.gmail.com> <CAADnVQJ79b-P6vtXBk-M85xRTfJT0DzEhxru-2Lcf_Ji2-j3ZA@mail.gmail.com>
In-Reply-To: <CAADnVQJ79b-P6vtXBk-M85xRTfJT0DzEhxru-2Lcf_Ji2-j3ZA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 13:43:59 -0700
X-Gm-Features: AS18NWBM-VP0Ga0M_EBpJcNllMJFnacI2pjzRG-cdRCAEbxQ7Gp2XmhgraODZ5w
Message-ID: <CAADnVQ+QvhsqYFLy89ZbUPN2s7AVVXFJzqVfvyx60N6_WuXoeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf: task work scheduling kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 11:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 19, 2025 at 9:35=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > > > It's not a problem if usercnt goes to 0 after we attached a context=
,
> > > > because cancel_and_free() will detach and
> > > > put the refcnt, and scheduling codepath will see the FREED state.
> > > >
> > > > Other thing is checking usercnt =3D=3D 0 before context initializat=
ion -
> > > > that's preventing allocation and attach a context to a map that has
> > > > already done cleanup. Cleanup won't happen again and this new conte=
xt
> > > > is leaked.
> > > >
> > > > Trying to summarize:
> > > >   1) First check for usercnt =3D=3D 0 is needed so that we don't al=
locate
> > > > contexts
> > > > for map that has already cleaned up.
> > > >   2) Second check is needed in case of clean up is triggered during=
 context
> > > > initialization/attach, potentially leading to newly attached contex=
t leak,
> > > > as cancel_and_free() was called for old context and won't be called=
 for
> > > > new one.
> > > >   3) After context initialization/attach is done, we don't need che=
cking
> > > > for usercnt,
> > > > as cancel_and_free() will detach and transition to FREED. The state
> > > > transition will
> > > > be seen by scheduling codepath.
> > >
> > > I agree, I don't see how we can avoid checking usercnt. Maybe we don'=
t
> > > need to check it twice, i.e. optimistically first and then again afte=
r
> > > cmpxchg and can only do it once.
> > > Since this is not a common case it's nbd that we have to put and
> >
> > You can have a very long-lived BPF map that is only referenced from
> > loaded/attached BPF program with usercnt=3D=3D0, so it's not necessaril=
y a
> > short-lived state. From a correctness standpoint, yes, we can omit the
> > first check, but I'd still do it.
> >
> > > deallocate stuff. But if we don't do usercnt check at all, we will
> > > leak memory.
> > > Once usercnt drops to zero and task work lingers in map value, nothin=
g
> > > will come and free it anymore, short of user deleting the map value
> > > manually, which is not guaranteed.
>
> I feel there is a confusion what that usercnt=3D=3D0 check
> was for in bpf_timer.
> The usercnt=3D=3D0 check is there to prevent circular dependency
> of references between prog and map. Only those two.
> In other words, so that Ctrl-C of a user process should stop
> all bpf progs including timers.
> The code that prevents arm/re-arm when usercnt=3D=3D0 is a side
> effect in some way.
>
> bpf_async_kern doesn't have refcnt.
> Here bpf_task_work_ctx has a refcnt, but it's not participating
> in the loop formation.
> The loop is prog->map->prog.
> prog owns a map. The verifier did bpf_map_get() before adding a map
> pointer to prog->aux->used_maps.
> bpf_timer_set_callback() and bpf_task_work_schedule() are incrementing
> prog refcnt. Something has to drop prog's refcnt because
> map's refcnt will get to zero only after prog gets to zero.
> That's the reason for release_uref() existence and two refcnts in a map.
> map->refcnt and map->usercnt.
> And the rule: when usercnt goes to zero make sure that map
> doesn't hold prog's refcnt indirectly through their elements.
> All map elements cleaned from timers twice.
> When map->usercnt goes to zero and then when map->refcnt goes to zero.
>
> Cancelling the timer is a choice to make Ctrl-C behave as
> what users expect. Ctrl-C should stop everything.
> But it doesn't have to be that way.
> While drop prog->refcnt is mandatory.
> Otherwise timer callback will run, the prog will execute,
> and if prog doesn't rearm the timer or explicitly deletes
> the map element, the prog and map will stay in memory forever
> not doing anything, while nothing is user space holding
> a reference to a map and to a prog.
> prog->refcnt =3D=3D 1, map->refcnt =3D=3D 1, map->usercnt =3D=3D 0
>
> Here you've introduced a refcnt in bpf_task_work_ctx and
> loop doesn't form anymore (as far as I can see).
>
> The bpf_task_work_ctx->refcnt rules in this patch:
> - refcnt is held when map_value->tw !=3D NULL
> - refcnt is held when bpf_task_work_ctx is scheduled
>
> When bpf_task_work_callback() finally runs it will drop
> bpf_task_work_ctx->refcnt which will drop prog's refcnt.
> bpf_timers don't have this logic to drop prog's refcnt after the run.
>
> So release_uref() drops one bpf_task_work_ctx->refcnt
> then bpf_task_work_callback() will drop the second and last ctx->refcnt.
> That will drop prog->refcnt.
> And if there is nothing in user space holding the prog
> the prog->refcnt=3D=3D0 which will trigger map->refcnt--
> and free of the map which will delete all elements.
>
> So the bpf_timer issue of prog finished and remains in memory
> forever is solved differently here.
> I think good Ctrl-C behavior is also addressed,
> since release_uref cancels task_work.
>
> I could be missing something, of course.

We discussed it offline with Andrii.
What I missed in the above is the case where release_uref()
clears ctx to NULL, but the program might still
use that map value and if both usercnt checks
are removed it can allocate ctx, schedule and run a callback.
That's not a clean Ctrl-C behavior.
It's not a correctness issue from kernel pov.
There will be no dangling detached prog/map combo.
Some bpf_timers users already have this logic in their services:
when they unpin the bpf map they expect all timers
to be stopped and not fire again.
The prog might still be attached and can run,
but the map with usercnt=3D=3D0 is effectively poisoned.
So let's leave 2nd check after state became pending
and update the comment to explain that we're not fixing
a race or correctness issue.
The usercnt=3D=3D0 means that nor processes or bpffs are holding
a reference to the map and new callbacks should not be scheduled.
This is a policy choice.
Not sure how to phrase all that succinctly.

