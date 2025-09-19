Return-Path: <bpf+bounces-68964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5127B8AE80
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789501CC413C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1571D8DE1;
	Fri, 19 Sep 2025 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6RGWlBH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6052264A77
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306214; cv=none; b=a/cHVW8cM3pelE0ew8TA1kRSrfSlHH2G33cqWDQS2hzWYGdasyf8mAyMK87xjZ/j9CRfU/bVK34EWzhxIHeKbW7S8JDxIONqQfXPdYTEJcFaUt8oCosmAsm8KaiUoBFB5gA0giNIfmQVVgor2L//awjCeKBo1XqaiElva+ccqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306214; c=relaxed/simple;
	bh=e2D4XvzG/tE8iqzLsejAfQMvGToYdvkVMrbFbgvHihM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqPEuomlQ2SOpyWU1y7g0PvwRyyRWT9yhdYUD+EBsBP6tgLAaMVlNpInlanb6kT2D7iFlpdhskVwwsPqrAKw86S7TuP9OkguxEiNJew2mu1NGRr2sKMIBQWtxI9OIWkQCXbEG+BVuzAfhF7PEH7dWgs6+yfGz58AjhpzVIrqCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6RGWlBH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3eebc513678so1200455f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306211; x=1758911011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6f9gxWxIu7ueqSC9MCdj8qUDs180Yky9QNXsONM4VU=;
        b=E6RGWlBHeST0nyqV7uo6ChlX29HsYeWrN0/Nz9RUOJkZO4R3Kda0Auc9z7F4V+871g
         xQ8/OmUXCtULLqihIKDe30eu++UcLKy4urdSyP0WpFfC88HDqBLyAE/NXYqjvcF7NKUy
         YNO3LzcmGAye7EMNxPS/aK3gwfWxYfVRhbLAP12xYD1CEyekrO8dw+elC4hd/4UvbmkG
         /xMXK63QIH5JX71L7lg4Orf2NoVHIKnwu5KNALz/pTU1NWGlRYQ4WeqsPkCuHR23g4DI
         baQbA1T6G1jAI1E6qmD2TA5z6qQaMcrzyJFrwb0qdtSLZc1DrDbjrHCLXtlf09ns1C6O
         zL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306211; x=1758911011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6f9gxWxIu7ueqSC9MCdj8qUDs180Yky9QNXsONM4VU=;
        b=E21CtSCr2Z9CMEXAbo1LkDSznM4TpqTLsF0izmHklLPQsPd+3vvgUhs7HfSlgZRSNf
         MgRoZbODGP1YTiYDEtZm86mv2bBgIxlIOdG1QScHeU1dkv/48LwNpfEhgldzElsXVg51
         GQky0RsABt7g5PwU/pZuvloUWxwFiiG44Ez7S6JIM6uKwSdLozkqxtHw5Yx4n2KhXggm
         t1yhuYGYjiJ6kkVLF21mPJwR8Tgn/FOdw5HtH+DQUSJnukQuJgqpsWWfJGIeAoGbjfhF
         +OGQ2D+ovDIg6zQRvZWhXm/VR5Cs5SrSlQOh5x2MZNL43KjbbDe5e+KIDkpCUMrcbYQl
         KkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6kf2dzXKCXli+2RN4tHMiBIRCqVx0CpU0NaxAMN14bIAzJ7GOKGRXDyUl/F/fjCQGWNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvWyjFNX16vAtAHQyibqFxyUrnqCUoonpCIkvj89hmzTsmKsv
	VB1ZdrUCwK7ngMcJwCsAWp9rpsjA76l+r3+y8/6Zq+rvxi++6KSZ4ZnXOKhQQG2NaTLrfyd5v35
	x/8caMIi/gQ5v1Yzhiqc8qY1o2uY/ZAo=
X-Gm-Gg: ASbGnctKXlr0D7jj+wFUTcbQjc//6lFSycwwLqyta7dSi1JgROfH5HdpYZfVBiYvzdT
	4jJ07FOnDR2DD55PwDxjrMITLB8YYaVb3OBvII1ohXlSmOf3mxLSulaKacdQG6KFfejBOoH1/JX
	YEmm4ehFcpbjWqRGj0sdcGrz8eOG9mzaqbwxbpOz63/kEkOKBUaFn/p/kv9YBBM7mnXoW0HawFf
	AfsjqNUn0UzRD3O+1ErcUE=
X-Google-Smtp-Source: AGHT+IHuy9Cxryjv/nGOo9wEou9kCjd5GLpjyOiToubk8xJiR+sg84BfZq+Wk+pqrRtF2O0TFocK+7J07pMQTedCXiE=
X-Received: by 2002:a5d:64e5:0:b0:3ed:e1d8:bd73 with SMTP id
 ffacd0b85a97d-3ee86b8478cmr3416858f8f.57.1758306211019; Fri, 19 Sep 2025
 11:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
 <20250918132615.193388-8-mykyta.yatsenko5@gmail.com> <CAADnVQJfGqKpOhQpx_a-kKfv34XRE=hDZAN=u-=CVppUF5wfzA@mail.gmail.com>
 <171ddd7f-a100-4800-b0f3-1ac8e25c13d8@gmail.com> <CAP01T76m5DLzy5TKjrDOG5JQqjtSZOHkJtMRx8vNbWZSK4CGnQ@mail.gmail.com>
 <CAEf4BzYhH-qjJzOnqMVHRp5RbKT-vnJDiLxH0+E3-=M4qc_AKg@mail.gmail.com>
In-Reply-To: <CAEf4BzYhH-qjJzOnqMVHRp5RbKT-vnJDiLxH0+E3-=M4qc_AKg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 11:23:17 -0700
X-Gm-Features: AS18NWADggiwP69urGYyXwJZvqWhU8b-d5Qk8JEIGAlYIsfNRn9iGMLkBARP6Ug
Message-ID: <CAADnVQJ79b-P6vtXBk-M85xRTfJT0DzEhxru-2Lcf_Ji2-j3ZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf: task work scheduling kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:35=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > > It's not a problem if usercnt goes to 0 after we attached a context,
> > > because cancel_and_free() will detach and
> > > put the refcnt, and scheduling codepath will see the FREED state.
> > >
> > > Other thing is checking usercnt =3D=3D 0 before context initializatio=
n -
> > > that's preventing allocation and attach a context to a map that has
> > > already done cleanup. Cleanup won't happen again and this new context
> > > is leaked.
> > >
> > > Trying to summarize:
> > >   1) First check for usercnt =3D=3D 0 is needed so that we don't allo=
cate
> > > contexts
> > > for map that has already cleaned up.
> > >   2) Second check is needed in case of clean up is triggered during c=
ontext
> > > initialization/attach, potentially leading to newly attached context =
leak,
> > > as cancel_and_free() was called for old context and won't be called f=
or
> > > new one.
> > >   3) After context initialization/attach is done, we don't need check=
ing
> > > for usercnt,
> > > as cancel_and_free() will detach and transition to FREED. The state
> > > transition will
> > > be seen by scheduling codepath.
> >
> > I agree, I don't see how we can avoid checking usercnt. Maybe we don't
> > need to check it twice, i.e. optimistically first and then again after
> > cmpxchg and can only do it once.
> > Since this is not a common case it's nbd that we have to put and
>
> You can have a very long-lived BPF map that is only referenced from
> loaded/attached BPF program with usercnt=3D=3D0, so it's not necessarily =
a
> short-lived state. From a correctness standpoint, yes, we can omit the
> first check, but I'd still do it.
>
> > deallocate stuff. But if we don't do usercnt check at all, we will
> > leak memory.
> > Once usercnt drops to zero and task work lingers in map value, nothing
> > will come and free it anymore, short of user deleting the map value
> > manually, which is not guaranteed.

I feel there is a confusion what that usercnt=3D=3D0 check
was for in bpf_timer.
The usercnt=3D=3D0 check is there to prevent circular dependency
of references between prog and map. Only those two.
In other words, so that Ctrl-C of a user process should stop
all bpf progs including timers.
The code that prevents arm/re-arm when usercnt=3D=3D0 is a side
effect in some way.

bpf_async_kern doesn't have refcnt.
Here bpf_task_work_ctx has a refcnt, but it's not participating
in the loop formation.
The loop is prog->map->prog.
prog owns a map. The verifier did bpf_map_get() before adding a map
pointer to prog->aux->used_maps.
bpf_timer_set_callback() and bpf_task_work_schedule() are incrementing
prog refcnt. Something has to drop prog's refcnt because
map's refcnt will get to zero only after prog gets to zero.
That's the reason for release_uref() existence and two refcnts in a map.
map->refcnt and map->usercnt.
And the rule: when usercnt goes to zero make sure that map
doesn't hold prog's refcnt indirectly through their elements.
All map elements cleaned from timers twice.
When map->usercnt goes to zero and then when map->refcnt goes to zero.

Cancelling the timer is a choice to make Ctrl-C behave as
what users expect. Ctrl-C should stop everything.
But it doesn't have to be that way.
While drop prog->refcnt is mandatory.
Otherwise timer callback will run, the prog will execute,
and if prog doesn't rearm the timer or explicitly deletes
the map element, the prog and map will stay in memory forever
not doing anything, while nothing is user space holding
a reference to a map and to a prog.
prog->refcnt =3D=3D 1, map->refcnt =3D=3D 1, map->usercnt =3D=3D 0

Here you've introduced a refcnt in bpf_task_work_ctx and
loop doesn't form anymore (as far as I can see).

The bpf_task_work_ctx->refcnt rules in this patch:
- refcnt is held when map_value->tw !=3D NULL
- refcnt is held when bpf_task_work_ctx is scheduled

When bpf_task_work_callback() finally runs it will drop
bpf_task_work_ctx->refcnt which will drop prog's refcnt.
bpf_timers don't have this logic to drop prog's refcnt after the run.

So release_uref() drops one bpf_task_work_ctx->refcnt
then bpf_task_work_callback() will drop the second and last ctx->refcnt.
That will drop prog->refcnt.
And if there is nothing in user space holding the prog
the prog->refcnt=3D=3D0 which will trigger map->refcnt--
and free of the map which will delete all elements.

So the bpf_timer issue of prog finished and remains in memory
forever is solved differently here.
I think good Ctrl-C behavior is also addressed,
since release_uref cancels task_work.

I could be missing something, of course.

