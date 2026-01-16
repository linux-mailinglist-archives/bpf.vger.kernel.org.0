Return-Path: <bpf+bounces-79345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC8D3892D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 318023014D53
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EAE3115A1;
	Fri, 16 Jan 2026 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYjAObTc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6C310627
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602307; cv=none; b=p20HZoJQKnXQHmcEMCfXl6J4xPYCuVZfFsE50CuHzF7ZXdpzWwH/GNGnReyf5E/jzo//xRu+YblLgs5pnfLsfd1Uf9WS9c5IOlXxfIwXZPfhfP6UIyyzAWTbrbxRFqSPxJSRHGMbNMv8VMj4mFDc+1AaJL32duupGvpkjGuDETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602307; c=relaxed/simple;
	bh=qptEp8sEbtVPxJxGO0g+sItbsWbLaXt42kMa9TNE7OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpJx88aBDVOSneFFiHTho9+BC2+Tml3D0vcSfxn5FTJUYmxLqBnFZfGgIOCRoKQAvyOzXrYgiZX20tRpAGCoCbexeTXo8lMW6Qzq9hQ9GmVS0MVco4gnE8gN9Or9kqjFRS+HpNAPL5R53BmdxGqhAiPDazn2eB6gsjG4ZmHG/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYjAObTc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c56188aef06so1079948a12.2
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602305; x=1769207105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKu+95CPgLvp/C5TpNMES7nTK5oZeBFLzp4GfKdaUjQ=;
        b=BYjAObTcCgGFplePKZv6cz5XoZKBjmWL48jUdlDZp+DBFqebZubj0QRA4bvqAKBJj2
         nOYU2n4OFBgGt6K1rprnpPxbDV0F1Be1QAp0zgnqRP3RVFWuYHbfqccJm9uklvH9XPWp
         wjrUaGi0BLzqck69ZMRm5bFiz3e3xbFnNR5K1ubysC6TqXMzZ2K7SFtF+W0Zdct3D8I8
         RO/bq3JMjG+HJc0fQ+RQfnyv0fMrd2Q4HYoltQwAr3yNetP0aAyR5qcaJ9CHYXjAxT1s
         vo1WYdIveve1yhrffb7jD0b7KKXbvDlNpPWcJaIlMuBuHqziJbXUe/dfXcoN5LDISe/h
         GE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602305; x=1769207105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JKu+95CPgLvp/C5TpNMES7nTK5oZeBFLzp4GfKdaUjQ=;
        b=FfyhyrMVPjFKDtlaCD8qfKKoqXS4vfb2pEn1RiFoDc+Gs0EmEVUkFvOHrnWifOhY5d
         UOR7TD6kA+j+8pCX6Uwq291Ww8eipVy01VepmOxu5MqLHSZdzWQX5XhbPDhHKl2hjvVX
         83lXdA0oB8Wfi3pBYr6BDIxhQgitm7B1NWT4ly+zGfAcIvuXffZFha3uGP0uNH/QUOYq
         0gG/cperJ4vDh54ctk1zGYMsHTJaP0/N71io80sOXyO25m93PV4Jqfhyy05McqvW4uGq
         zfEX/iPbVTNmyMl5GHgiuROOH4o2BVwjfvz1IF6y6yeBoGG52Pv/+UNbiF4jzzhXZaEh
         LE8g==
X-Forwarded-Encrypted: i=1; AJvYcCV7mp2sCXXFNOy1bm43Cb0slIVzB0Nk3ziz2udtx/VNj6XTyYF+D941gzF8qr4p0F+5/rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrTRYqlQ7Afb7cf6w/3mYSqamEMNYYpzeYgkg6nJcYkZXH14q
	vjrhakIzukxJbgjNbnUoqG4NJp2aizzEeRCE8086fB/1HjDs0EsQgFFqECBJSmMFizrc3n5jsyj
	Zs4c45iGomrklHdZ3jpACRx07tvIWpZo=
X-Gm-Gg: AY/fxX5+NKDsMFW2Dl42fpukE8Y852kgcqrAKcgRBeIlMaHWhAv97As1lj4kqzPyoPp
	PLebYNTRLbLjHzfJOEjAdqIHUVjI+K1eR0ZoP75BFPR0VIuzKIWwhp2LYOjoRAiPt1fUE4PIzpY
	MyZH72J6CivMGoGFB2Uh4FqPi2Ry4o35tVWqtsCAycpitbi9iV/yKfGX4DxeXlPJFX8o/9C2wGE
	SvmOw+qZ4/GVaWs8+MSTL90CUOgkCu6DD1lSInAkZxHwuQ228k8pPvSc5Ub4BXmo8pAouszKi/H
	ts+xP1TgPmw=
X-Received: by 2002:a17:90b:3501:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-35272fe6ee0mr4031169a91.37.1768602305010; Fri, 16 Jan 2026
 14:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112214940.1222115-1-jolsa@kernel.org> <20260112214940.1222115-3-jolsa@kernel.org>
 <20260112170757.4e41c0d8@gandalf.local.home> <aWYv6864cdO2PWbb@krava>
 <CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com> <aWpme7kBw9xyzRFP@krava>
In-Reply-To: <aWpme7kBw9xyzRFP@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:24:51 -0800
X-Gm-Features: AZwV_QjlKAd57l3v7WOINdaUEuCO64fxYBxvdL4QvGUxnlSeVPU6ggFqHIo30QA
Message-ID: <CAEf4BzZyF2MsF5CkLEsrd0dumeCJ3-zzP+azCZ4TRoDkzjGLdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program
 stack unwind to hw_regs path
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 8:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jan 15, 2026 at 10:52:04AM -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 13, 2026 at 3:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Mon, Jan 12, 2026 at 05:07:57PM -0500, Steven Rostedt wrote:
> > > > On Mon, 12 Jan 2026 22:49:38 +0100
> > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > > To recreate same stack setup for return probe as we have for entr=
y
> > > > > probe, we set the instruction pointer to the attached function ad=
dress,
> > > > > which gets us the same unwind setup and same stack trace.
> > > > >
> > > > > With the fix, entry probe:
> > > > >
> > > > >   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
> > > > >   Attaching 1 probe...
> > > > >
> > > > >         __x64_sys_newuname+9
> > > > >         do_syscall_64+134
> > > > >         entry_SYSCALL_64_after_hwframe+118
> > > > >
> > > > > return probe:
> > > > >
> > > > >   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
> > > > >   Attaching 1 probe...
> > > > >
> > > > >         __x64_sys_newuname+4
> > > > >         do_syscall_64+134
> > > > >         entry_SYSCALL_64_after_hwframe+118
> > > >
> > > > But is this really correct?
> > > >
> > > > The stack trace of the return from __x86_sys_newuname is from offse=
t "+4".
> > > >
> > > > The stack trace from entry is offset "+9". Isn't it confusing that =
the
> > > > offset is likely not from the return portion of that function?
> > >
> > > right, makes sense.. so standard kprobe actualy skips attached functi=
on
> > > (__x86_sys_newuname) on return probe stacktrace.. perhaps we should d=
o
> > > the same for kprobe_multi
> >
> > but it is quite nice to see what function we were kretprobing,
> > actually...
>
> IIUC Steven doesn't like the wrong +offset that comes from entry probe,
> maybe we could have func+(ADDRESS_OF_RET+1) ..but not sure how hard that
> would be
>
> still.. you always have the attached function ip when you get the stacktr=
ace,
> so I'm not sure how usefull it's to have it in stacktrace as well.. you c=
an
> always add it yourself

You can, but that's a custom thing that every single tool has to
implement. Having traced function right there in the stack would be so
nice and convenient.

I don't insist, but I'm just saying that practically speaking this
would make sense. Even conceptually, kretprobe is (logically) called
from traced function right before exit. In reality it's not exactly
like that and we don't know where ret happened, but having traced
function in kretprobe's stack trace is more useful than confusing,
IMO.

But again, I just found it interesting that we could have it, if we wanted =
to.

>
>
> > How hard would it be to support that for singular kprobe
> > as well? And what does fexit's stack trace show for such case?
>
> I think we will get the bpf_program address, so we see the attached
> function in stacktrace, will check
>
> thanks,
> jirka

