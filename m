Return-Path: <bpf+bounces-34709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A024E93024B
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00321C212CB
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CB0130492;
	Fri, 12 Jul 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="ldeWEXEd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39354965E
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720825533; cv=none; b=gImAIzVBKNJOAiiOwGPUzn2sL5HDw7q2kkcMCBUKXKJ4o26XxqTe30aqVloTtSm7bK+NQwPAJpAAasZ/SR0RLG46aXZEF1QPgtYoGlBmwSfvnaxGXoresAAiw0oSwoh+6FP/1GaBc+BldighgJ9HVCPsmfuKhtxGf1QfLeVwi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720825533; c=relaxed/simple;
	bh=4FdxqM8UZeIL3nt3cP3n1S61HES3nQqIKSLB1HJxv8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKR5IOqMvoeXYd7bShm3syxZC24xdZlEv6FJDPiF6UOE8PTrDS3MX6K0oKRIEmCCTfzJxg7DG8Pt153efOqK6wAXAjfr12K8gTbzSplPQ5dA1zenGR27+Q5BrMtHZo4GhDiPa26i/PYHsIaMm4R72513zE4s7zGYS0ckiPJmwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=ldeWEXEd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so31902471fa.2
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720825530; x=1721430330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR4wG1/g0ZdZbGAfTddNZ5Iro17H/Xb1ZUuvvbhxJ4Q=;
        b=ldeWEXEd48O453zQYkw2+LUIn6noOPp8SE/DeKfjMAaDyhzLn8D+ZWtvG7OrKvrvb+
         rSeEwE2gPQfp56WOUNqwurHjUzDfzdH8nFRB8TQRa9J0sifjMRAfKopeLvpU23NWNiEs
         kqnK4M9lLM/8DF8fVW0CINAr8N1B4tOblIy12ejT2JKiQlknIjqY7PKkm1acqukOusdV
         YR0+WTnLzbZlG24Wl3+aUaCLQAaeqFD6aKnFR+OUIoghEoWUuAP73RDBI7vifPVPDicX
         CeictIdYlRH8aydra36N1qN2oqB47Ns4gm9m+4ASf+Bk7Lyxk/l40k9jpP+bvKG3v0yT
         3O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720825530; x=1721430330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eR4wG1/g0ZdZbGAfTddNZ5Iro17H/Xb1ZUuvvbhxJ4Q=;
        b=CpQHgOsbx3M4w5lrleI3TzLBx3Jm1NDPCQ+NjbNxOYFONFK9V2TW6J3FYnT7li3Gxw
         kdTv/1HEVPwN9MoYUxLmO8rTWWcvjvhDjACgzIlx2Q2RU4NmOzQXBFFgYE6J+Vkw/S9J
         4ae8UZunzq8R21LMT+KFhfu21I5RNrsRu9XV+ohhPx1e5ompSVbyXCSPZ3pYE33IgPbu
         yVtslaxzmZVGguxExfjIKuKmkmD3W2U4BOW2aocwhYC92VPBJz8uQ4+40zOdNzTc977a
         fOtlgc2thSCq/iMA0OjPHrtfTrZa5Aiax3+mNaJuRBAKtyPQ1R/2smOFPx5EFtpAYHJn
         kRJg==
X-Forwarded-Encrypted: i=1; AJvYcCX52Rcll/RLyPoVTW88SoQ02mUskYbjK1Qt9M2Cig818fVxg40YpO1P+lzNA4x2NpxCR+NfFbxoxR9Cn+Pud3S9M0+4
X-Gm-Message-State: AOJu0Ywj/UVQ8Sft8CSfDyH9fTC2PFmGOAPtKBcWTQmt1d7BykpBBxjY
	vBYvUzvdWWcPtH+5MBalGti1eMx5V7ehRtQsQFcDtETvLeP33lSLw9w+ivUCMKqQeBRqjY5fcme
	IZxJCXYlSP2PYRXb123jMDVdryHjwaAHGXPN8
X-Google-Smtp-Source: AGHT+IED0heXC/QFa5MXlCk7JVXnubbFKsurleRcGOG3DX57kK/loG9+wStySDtyxPD+g5+X7QrXTAivh0RvSF+m9TE=
X-Received: by 2002:a2e:9bd8:0:b0:2ee:80e0:b9f5 with SMTP id
 38308e7fff4ca-2eeb318aad1mr79739451fa.42.1720825529769; Fri, 12 Jul 2024
 16:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2> <ZpGrstyKD-PtWyoP@krava> <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
In-Reply-To: <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 12 Jul 2024 16:05:16 -0700
Message-ID: <CAP045ApsNDc-wJSSY0-BC+HMvWErUYk=GAt6P+J_8Q6dcdXj4Q@mail.gmail.com>
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, acme@kernel.org, andrii.nakryiko@gmail.com, 
	elver@google.com, khuey@kylehuey.com, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org, robert@ocallahan.org, yonghong.song@linux.dev, 
	mkarsten@uwaterloo.ca, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 3:49=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> On Fri, Jul 12, 2024 at 3:18=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Fri, Jul 12, 2024 at 09:53:53AM -0700, Joe Damato wrote:
> > > Greetings:
> > >
> > > (I am reposting this question after 2 days and to a wider audience
> > > as I didn't hear back [1]; my apologies it just seemed like a
> > > possible bug slipped into 6.10-rc1 and I wanted to bring attention
> > > to it before 6.10 is released.)
> > >
> > > While testing some unrelated networking code with Martin Karsten (cc'=
d on
> > > this email) we discovered what appears to be some sort of overflow bu=
g in
> > > bpf.
> > >
> > > git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF han=
dler
> > > directly, not through overflow machinery") is the first commit where =
the
> > > (I assume) buggy behavior appears.
> >
> > heya, nice catch!
> >
> > I can reproduce.. it seems that after f11f10bfa1ca we allow to run trac=
epoint
> > program as perf event overflow program
> >
> > bpftrace's bpf program returns 1 which means that perf_trace_run_bpf_su=
bmit
> > will continue to execute perf_tp_event and then:
> >
> >   perf_tp_event
> >     perf_swevent_event
> >       __perf_event_overflow
> >         bpf_overflow_handler
> >
> > bpf_overflow_handler then executes event->prog on wrong arguments, whic=
h
> > results in wrong 'work' data in bpftrace output
> >
> > I can 'fix' that by checking the event type before running the program =
like
> > in the change below, but I wonder there's probably better fix
> >
> > Kyle, any idea?
>
> Thanks for doing the hard work here Jiri. I did see the original email
> a couple days ago but the cause was far from obvious to me so I was
> waiting until I had more time to dig in.
>
> The issue here is that kernel/trace/bpf_trace.c pokes at event->prog
> directly, so the assumption made in my patch series (based on the
> suggested patch at
> https://lore.kernel.org/lkml/ZXJJa5re536_e7c1@google.com/) that having
> a BPF program in event->prog means we also use the BPF overflow
> handler is wrong.
>
> I'll think about how to fix it.
>
> - Kyle

The good news is that perf_event_attach_bpf_prog() (where we have a
program but no overflow handler) and perf_event_set_bpf_handler()
(where we have a program and an overflow handler) appear to be
mutually exclusive, gated on perf_event_is_tracing(). So I believe we
can fix this with a more generic version of your patch.

- Kyle

>
> > >
> > > Running the following on my machine as of the commit mentioned above:
> > >
> > >   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] =3D count();=
 }'
> > >
> > > while simultaneously transferring data to the target machine (in my c=
ase, I
> > > scp'd a 100MiB file of zeros in a loop) results in very strange outpu=
t
> > > (snipped):
> > >
> > >   @[11]: 5
> > >   @[18]: 5
> > >   @[-30590]: 6
> > >   @[10]: 7
> > >   @[14]: 9
> > >
> > > It does not seem that the driver I am using on my test system (mlx5) =
would
> > > ever return a negative value from its napi poll function and likewise=
 for
> > > the driver Martin is using (mlx4).
> > >
> > > As such, I don't think it is possible for args->work to ever be a lar=
ge
> > > negative number, but perhaps I am misunderstanding something?
> > >
> > > I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #ifd=
ef
> > > CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibit =
this
> > > behavior and the output seems reasonable on my test system. Martin co=
nfirms
> > > the same for both commits on his test system, which uses different ha=
rdware
> > > than mine.
> > >
> > > Is this an expected side effect of this change? I would expect it is =
not
> > > and that the output is a bug of some sort. My apologies in that I am =
not
> > > particularly familiar with the bpf code and cannot suggest what the r=
oot
> > > cause might be.
> > >
> > > If it is not a bug:
> > >   1. Sorry for the noise :(
> >
> > your report is great, thanks a lot!
> >
> > jirka
> >
> >
> > >   2. Can anyone suggest what this output might mean or how the
> > >      script run above should be modified? AFAIK this is a fairly
> > >      common bpftrace that many folks run for profiling/debugging
> > >      purposes.
> > >
> > > Thanks,
> > > Joe
> > >
> > > [1]: https://lore.kernel.org/bpf/Zo64cpho2cFQiOeE@LQ3V64L9R2/T/#u
> >
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index c6a6936183d5..0045dc754ef7 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9580,7 +9580,7 @@ static int bpf_overflow_handler(struct perf_event=
 *event,
> >                 goto out;
> >         rcu_read_lock();
> >         prog =3D READ_ONCE(event->prog);
> > -       if (prog) {
> > +       if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT) {
> >                 perf_prepare_sample(data, event, regs);
> >                 ret =3D bpf_prog_run(prog, &ctx);
> >         }

