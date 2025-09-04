Return-Path: <bpf+bounces-67489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E9B44574
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C33D179F2E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB0343216;
	Thu,  4 Sep 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smv0+bqf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50922259E;
	Thu,  4 Sep 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010745; cv=none; b=BcAjqAWR2R1EUJROw/5SgdSnl/8WD0rIFwIBNpaz7mmJSCW5ejLBGo2CAVzdDwDp37kDguiTmXtJ96HIO2kQrprifqcidCzUz/RTbRlswZwHJcwC5fWrwwBp9NH/njOY6d6oSI2Y6PEpZVJ2PEjnYZ6f2VSzL8tW6DvSRET0TVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010745; c=relaxed/simple;
	bh=943I0GcjUyMX2dosDBHOkG7mHU4PjGS5v7lo06QAkZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw3K0lwSG7J0gSwczwrBzM7uyHPq9M+Fdxb+8JgxK/D3dJKN7AR+gMmk4vxv2G+8rAriD34GH36w76kd44VvJwKg9CCot5JIUrYdm4uJ3axis+SEgfnCecmZF2lffA4I8FHw2oPy2NfexhgsNiKT5BbgMAnCE1bqiIgRQcPsn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smv0+bqf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b21006804so14035165ad.3;
        Thu, 04 Sep 2025 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757010743; x=1757615543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gv8zeBQICCYVWDlDKqh2DOJAY+dGMcvu93jaelQdfc=;
        b=Smv0+bqfnd1r7IdWdLy4ASvJllblgVonyg/iExTSXxXMgJ2WTrr709Dy4u6ji2LVIt
         A3nN5NxvX3PQNtDciKl99AKtWTVx7F7i38IhsytcNV/3RG+7TV4mFmCdvQ7wJiZXZ37d
         4ftJtkjYuT8decbrjpTWVxAqjh153ZAOGkMIYK+Iei3Oa/pkX9o2xXahJcGo1XIlSBAO
         3TKA9iR0RysMEzVo4OzwaeN8dzCbUuLdK1THeHJbV1VuKtBJpM7Umiq8xla5/PL054n0
         hG9H5QAtgwdo5tINrq7zI2gTakabji8HtYafPvxQTpQU9JnR6Hds9/aE5F5zlVAEUZb7
         PvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757010743; x=1757615543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gv8zeBQICCYVWDlDKqh2DOJAY+dGMcvu93jaelQdfc=;
        b=FTPbYLFLXyrOv1cUe29TqqaItJqCSgv5zJRTYClQxsQDyJ2XIgItyyQVYJUj4gQOJt
         s80bRGfAKf2tIYySOptHKotLSZ9ltpqWkL4HHIQfVD9QLDKJv3lYckqxh3IeM8zozOTb
         4yHLwT9bDlUzOp4HRvl45UlbBiuH0jGAhs/re0H3/Ebx9Aqu/zMdInx/GbcnOWNTPCKG
         PicpJ2ToVE5CaJGJ9jHjHxzREudEt+knLsNx25YG//krpsWKtZTVBQd78muf3qvRQhsm
         jyR6RNnF382UxQQsXQej89UW9oXZ+Hh2KqzGCbcm+rIBEQvfUrhfTjoVL4rUcaOK38jf
         rT0g==
X-Forwarded-Encrypted: i=1; AJvYcCUnxTJYsu5OXatGFyHkhPqXPiZBIqkESpsSo+v1ztyrOlu4ETUV0BTSjokOFFBaPrQnCec=@vger.kernel.org, AJvYcCWV+Sdf+0yTtYrscuHLmipcCRol/jENfEGtx/i1x38yOiJz02czplHj4igNdh/Tnl9tjFLfS3jvydAHiV31@vger.kernel.org, AJvYcCXXjJI/C2ee5QsKAnm8aHTwxy0yVZMhevKsNL9CyCIz0E1FaccsWeXsVIdZpie/YzBPsuKdkL8vqWGR+SExGusJSgFP@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2tKKiI0d3+/PRi6WyHPJFBzB2PldF45LEYbpHkSKl3RpHCos
	mtBO2mPpCsjf84U9MEaYNEhWlvdyTKA1nBbG30rbYzOeQqRxwKFdHimxUMwhFKwBpmLEXt3fCGN
	1JTKKNqN7QtcSdKCUp8RAU/kCyU8Q494=
X-Gm-Gg: ASbGnctug5OjLoIA/xhj4nwQo3d6Q6BUwF5nCttFhAsVqmshivQI6KVcBEDQXC8EKEW
	9FqHz6JE7dOXqET88fKqmdcSjyoVttwHNaSqv9fvtRHbOb6cG+kbSzezSSjGVkQni1b6NjiO/lb
	3Ce86jF2jWHwId9G3yoGlMRVm845jd9gC1oNVQ5VJgTY58Es/QI6ioM4rI+7MFDEvo4aNo52z7J
	hZajQl6X1JC0yQwFVGFurE=
X-Google-Smtp-Source: AGHT+IEaoN25sSpiYCC7dxZJPo8QGQBmtnkPVAWQafz1BqB7gaC8ImfMKqO31myNRLapma6KSCafwPXti44hm96qLZA=
X-Received: by 2002:a17:902:ef4c:b0:246:8b9d:2519 with SMTP id
 d9443c01a7336-24944a73e9bmr246315115ad.23.1757010742871; Thu, 04 Sep 2025
 11:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava> <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
 <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com>
 <aLlGHSgTR5T17dma@krava> <CAG48ez2BBTiDGT1NNK2dfZLiYMF-C75EAcufcVKWtP+Y4v-Utw@mail.gmail.com>
 <aLmcFp4Ya7SL6FxU@krava>
In-Reply-To: <aLmcFp4Ya7SL6FxU@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 11:32:06 -0700
X-Gm-Features: Ac12FXxPDWD-hH0sT4V6TBbAeZLB4n6kwx8l2z6fHQOoO4OQX99SItYKG5JYvXk
Message-ID: <CAEf4BzbPSTEKs2ya6-d5ecR=wdsRtxRwLJO0r+oEm-_R-B2_yQ@mail.gmail.com>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Sep 04, 2025 at 11:39:33AM +0200, Jann Horn wrote:
> > On Thu, Sep 4, 2025 at 9:56=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > > On Wed, Sep 03, 2025 at 04:12:37PM -0700, Andrii Nakryiko wrote:
> > > > On Wed, Sep 3, 2025 at 2:01=E2=80=AFPM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > > >
> > > > > On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
> > > > >
> > > > > > > > +SYSCALL_DEFINE0(uprobe)
> > > > > > > > +{
> > > > > > > > +       struct pt_regs *regs =3D task_pt_regs(current);
> > > > > > > > +       struct uprobe_syscall_args args;
> > > > > > > > +       unsigned long ip, sp;
> > > > > > > > +       int err;
> > > > > > > > +
> > > > > > > > +       /* Allow execution only from uprobe trampolines. */
> > > > > > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > > > > > +               goto sigill;
> > > > > > >
> > > > > > > Hey Jiri,
> > > > > > >
> > > > > > > So I've been thinking what's the simplest and most reliable w=
ay to
> > > > > > > feature-detect support for this sys_uprobe (e.g., for libbpf =
to know
> > > > > > > whether we should attach at nop5 vs nop1), and clearly that w=
ould be
> > > > > > > to try to call uprobe() syscall not from trampoline, and expe=
ct some
> > > > > > > error code.
> > > > > > >
> > > > > > > How bad would it be to change this part to return some unique=
-enough
> > > > > > > error code (-ENXIO, -EDOM, whatever).
> > > > > > >
> > > > > > > Is there any reason not to do this? Security-wise it will be =
just fine, right?
> > > > > >
> > > > > > good question.. maybe :) the sys_uprobe sigill error path follo=
wed the
> > > > > > uprobe logic when things go bad, seem like good idea to be stri=
ct
> > > > > >
> > > > > > I understand it'd make the detection code simpler, but it could=
 just
> > > > > > just fork and check for sigill, right?
> > > > >
> > > > > Can't you simply uprobe your own nop5 and read back the text to s=
ee what
> > > > > it turns into?
> > > >
> > > > Sure, but none of that is neither fast, nor cheap, nor that simple.=
..
> > > > (and requires elevated permissions just to detect)
> > > >
> > > > Forking is also resource-intensive. (think from libbpf's perspectiv=
e,
> > > > it's not cool for library to fork some application just to check su=
ch
> > > > a seemingly simple thing as whether to
> > > >
> > > > The question is why all that? That SIGILL when !in_uprobe_trampolin=
e()
> > > > is just paranoid. I understand killing an application if it tries t=
o
> > > > screw up "protocol" in all the subsequent checks. But here it's
> > > > equally secure to just fail that syscall with normal error, instead=
 of
> > > > punishing by death.
> > >
> > > adding Jann to the loop, any thoughts on this ^^^ ?
> >
> > If I understand correctly, the main reason for the SIGILL is that if
> > you hit an error in here when coming from an actual uprobe, and if the
> > syscall were to just return an error, then you'd end up not restoring
> > registers as expected which would probably end up crashing the process
> > in a pretty ugly way?
>
> for some cases yes, for the initial checks I think we could just skip
> the uprobe and process would continue just fine
>

For non-buggy kernel implementation in_uprobe_trampoline(regs->ip)
will (should) always be true when triggered for kernel-installed
uprobe. So this check can fail only for cases when someone
intentionally called sys_uprobe not from kernel-generated and
kernel-controlled trampoline.

At which point it's totally fine to just return an error and do nothing.

> we use sigill because the trap code paths use it for errors and to be
> paranoid about the !in_uprobe_trampoline check

Yeah, and it should be totally fine to keep doing that.

It's just about that entry in_uprobe_trampoline() check. And that's
sufficient to make all this nicely integrated with USDT use cases.

(I'd say it would be nice to also amend this into original patch to
avoid someone cherry picking original commit and forgetting/missing
the follow up change. But that's up to Peter.)

Jiri, can you please send a quick patch and see how that goes? Thanks!

>
> jirka
>
> >
> > I guess as long as in_uprobe_trampoline() is reliable (which it should
> > be), it would be fine to return an error when in_uprobe_trampoline()
> > fails, though it would be nice to have a short comment describing that
> > calls from uprobe trampolines must never fail with an error.
>
>

