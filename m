Return-Path: <bpf+bounces-34710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD3930267
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92B72814A8
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A232556F;
	Fri, 12 Jul 2024 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="R8hW/7gE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8B1BC20
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827048; cv=none; b=qvyASpnRl6S7l7UOOGeaU3Kan/pjGqOY6JGCvXrvl9u3aoKpTHxUL1cJFH6tw/6G0MEfwVXX5rZ5i62igwvrvx8oc6AGAXBkbOELu+ViMezK2UeC5yOZoRYUmpES9Tks5DdXLXGaOnw9DrSmfG/YUE0cd3yqXLFyzUKfCm4wpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827048; c=relaxed/simple;
	bh=nL0cRCxe2VRn5wqpS7DSg3ERZFxeayCU16AF7kaHA5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2xFn+9bduGuXkzzj/GajLDF9JLzZoFf8XNmGC+vSjqT3o97UEBMGRijjjtI8jyIuwGfSySOIVy03fuxIG1prF5QU55i/fLqGC//5+82PlgjegiF+OLEg2NUg9/THNH05nEc8gkotUhMwoYRClKJAvs451UnEWPHvPuMoccS3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=R8hW/7gE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so4586631fa.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720827044; x=1721431844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwuBrPwzCORM2gf6knUVH7sdI90nrwysVUU69ktUrio=;
        b=R8hW/7gEqGJ6sgo2Hk7f8zCWqSt9mdFoy0LxBqXrekDBz8ow4i/M5ib1bGfjzUtSde
         7AsiEX8lB+usHZDPzSfMvPnWZAq+KXnrdqoOwY4zAkMEVo9AO2LXZg/CB6iwxRLSgCAz
         Za4T2Q42i9fIa1LvqEl0qXRriPDEWJD38l4bSOnpoAhsWYSwca22K+PymRlsb84L/aMT
         Vy5+ZAbNyA4RtN49uD3hEmR85ZrYeYJHHurnl5WMIVF9FubuuAKMF/ReYeuIvbRrL+pP
         i/Crqj95aoRH69WLhNTizt7i5CUEqXHeBKv12ktNLk4tBcOeksWVrh0pcXI2hTfM4jD8
         YRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720827044; x=1721431844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwuBrPwzCORM2gf6knUVH7sdI90nrwysVUU69ktUrio=;
        b=pXDS9V208Ma9ebEYDCOgy/p89rXAlWOExIkB+LHYC8IBCS5HaWK9BUSePNWO3IxHT/
         JyhB0UBnJgVAuc3MeCh4A8iMPcrzEOWRSDdy/tXWn+e2L6NMvJ17vzjNWkjTR+ZHnpLV
         AcDzrdQZl79tHIlg6dkZOZAHr3vm/V0ZqDmbXdaeoqvXVZO3EspfJMMxOyFzUNkKh+kP
         D1bPiDX6ILlkFT0zo0ysiMj0D/311oPRB1vUssVyQVkH219vT6dbOpI/FcXAwjb8jR+0
         oy3PT3/xuoC+fGDVTpEcaGYhaUKclH+r3w1MOKhsbx55YJXan4oYtBSRsiV8TcokXAGC
         C8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWnIPgMuFGO5jXqQ815zCn6EH/iVUGVldWDoJ+y5y6BFdGsTQ83U6+rN35lTokdmWxSmvpEKCAE22p1wz9YzysZlAUB
X-Gm-Message-State: AOJu0Ywm2XVTgyONhGYR8nbO0nRgZLv4AOD2438y6FOfPq2qGu5CBkzm
	CFFa2GQN5JI61rnGdEzxdSKPvwngRriGL90yqrq1m36ihZIb5DKWtLjxmDnNoZmOcTq8reHWFZy
	QURNZ3SP6vrdISvMziiHUC3AWmECPAKGwb10G
X-Google-Smtp-Source: AGHT+IEPVuVWsYpsRC2HRqIIUOCKH7saR32IY0rtft8ys3HjYGbfM3zPIoXAMMXK8ItFQZgG/PI6KNH7YTQSp2/3RXA=
X-Received: by 2002:a2e:9015:0:b0:2ee:4c66:6828 with SMTP id
 38308e7fff4ca-2eeb30fc7bbmr80854651fa.24.1720827043852; Fri, 12 Jul 2024
 16:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2> <ZpGrstyKD-PtWyoP@krava>
 <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com> <CAP045ApsNDc-wJSSY0-BC+HMvWErUYk=GAt6P+J_8Q6dcdXj4Q@mail.gmail.com>
In-Reply-To: <CAP045ApsNDc-wJSSY0-BC+HMvWErUYk=GAt6P+J_8Q6dcdXj4Q@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 12 Jul 2024 16:30:31 -0700
Message-ID: <CAP045AqqfU3g2+-groEHzzdJvO3nyHPM5_faUao5UdbSOtK48A@mail.gmail.com>
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
To: Joe Damato <jdamato@fastly.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, acme@kernel.org, andrii.nakryiko@gmail.com, 
	elver@google.com, khuey@kylehuey.com, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org, robert@ocallahan.org, yonghong.song@linux.dev, 
	mkarsten@uwaterloo.ca, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Joe, can you test this?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..f0d7119585dc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9666,6 +9666,8 @@ static inline void
perf_event_free_bpf_handler(struct perf_event *event)
  * Generic event overflow handling, sampling.
  */

+static bool perf_event_is_tracing(struct perf_event *event);
+
 static int __perf_event_overflow(struct perf_event *event,
                  int throttle, struct perf_sample_data *data,
                  struct pt_regs *regs)
@@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_event *e=
vent,

     ret =3D __perf_event_account_interrupt(event, throttle);

-    if (event->prog && !bpf_overflow_handler(event, data, regs))
+    if (event->prog &&
+        !perf_event_is_tracing(event) &&
+        !bpf_overflow_handler(event, data, regs))
         return ret;

     /*
@@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_event *e=
vent)

 #else

+static inline bool perf_event_is_tracing(struct perf_event *event)
+{
+    return false;
+}
+
 static inline void perf_tp_register(void)
 {
 }

- Kyle

On Fri, Jul 12, 2024 at 4:05=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> On Fri, Jul 12, 2024 at 3:49=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > On Fri, Jul 12, 2024 at 3:18=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Fri, Jul 12, 2024 at 09:53:53AM -0700, Joe Damato wrote:
> > > > Greetings:
> > > >
> > > > (I am reposting this question after 2 days and to a wider audience
> > > > as I didn't hear back [1]; my apologies it just seemed like a
> > > > possible bug slipped into 6.10-rc1 and I wanted to bring attention
> > > > to it before 6.10 is released.)
> > > >
> > > > While testing some unrelated networking code with Martin Karsten (c=
c'd on
> > > > this email) we discovered what appears to be some sort of overflow =
bug in
> > > > bpf.
> > > >
> > > > git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF h=
andler
> > > > directly, not through overflow machinery") is the first commit wher=
e the
> > > > (I assume) buggy behavior appears.
> > >
> > > heya, nice catch!
> > >
> > > I can reproduce.. it seems that after f11f10bfa1ca we allow to run tr=
acepoint
> > > program as perf event overflow program
> > >
> > > bpftrace's bpf program returns 1 which means that perf_trace_run_bpf_=
submit
> > > will continue to execute perf_tp_event and then:
> > >
> > >   perf_tp_event
> > >     perf_swevent_event
> > >       __perf_event_overflow
> > >         bpf_overflow_handler
> > >
> > > bpf_overflow_handler then executes event->prog on wrong arguments, wh=
ich
> > > results in wrong 'work' data in bpftrace output
> > >
> > > I can 'fix' that by checking the event type before running the progra=
m like
> > > in the change below, but I wonder there's probably better fix
> > >
> > > Kyle, any idea?
> >
> > Thanks for doing the hard work here Jiri. I did see the original email
> > a couple days ago but the cause was far from obvious to me so I was
> > waiting until I had more time to dig in.
> >
> > The issue here is that kernel/trace/bpf_trace.c pokes at event->prog
> > directly, so the assumption made in my patch series (based on the
> > suggested patch at
> > https://lore.kernel.org/lkml/ZXJJa5re536_e7c1@google.com/) that having
> > a BPF program in event->prog means we also use the BPF overflow
> > handler is wrong.
> >
> > I'll think about how to fix it.
> >
> > - Kyle
>
> The good news is that perf_event_attach_bpf_prog() (where we have a
> program but no overflow handler) and perf_event_set_bpf_handler()
> (where we have a program and an overflow handler) appear to be
> mutually exclusive, gated on perf_event_is_tracing(). So I believe we
> can fix this with a more generic version of your patch.
>
> - Kyle
>
> >
> > > >
> > > > Running the following on my machine as of the commit mentioned abov=
e:
> > > >
> > > >   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] =3D count(=
); }'
> > > >
> > > > while simultaneously transferring data to the target machine (in my=
 case, I
> > > > scp'd a 100MiB file of zeros in a loop) results in very strange out=
put
> > > > (snipped):
> > > >
> > > >   @[11]: 5
> > > >   @[18]: 5
> > > >   @[-30590]: 6
> > > >   @[10]: 7
> > > >   @[14]: 9
> > > >
> > > > It does not seem that the driver I am using on my test system (mlx5=
) would
> > > > ever return a negative value from its napi poll function and likewi=
se for
> > > > the driver Martin is using (mlx4).
> > > >
> > > > As such, I don't think it is possible for args->work to ever be a l=
arge
> > > > negative number, but perhaps I am misunderstanding something?
> > > >
> > > > I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #i=
fdef
> > > > CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibi=
t this
> > > > behavior and the output seems reasonable on my test system. Martin =
confirms
> > > > the same for both commits on his test system, which uses different =
hardware
> > > > than mine.
> > > >
> > > > Is this an expected side effect of this change? I would expect it i=
s not
> > > > and that the output is a bug of some sort. My apologies in that I a=
m not
> > > > particularly familiar with the bpf code and cannot suggest what the=
 root
> > > > cause might be.
> > > >
> > > > If it is not a bug:
> > > >   1. Sorry for the noise :(
> > >
> > > your report is great, thanks a lot!
> > >
> > > jirka
> > >
> > >
> > > >   2. Can anyone suggest what this output might mean or how the
> > > >      script run above should be modified? AFAIK this is a fairly
> > > >      common bpftrace that many folks run for profiling/debugging
> > > >      purposes.
> > > >
> > > > Thanks,
> > > > Joe
> > > >
> > > > [1]: https://lore.kernel.org/bpf/Zo64cpho2cFQiOeE@LQ3V64L9R2/T/#u
> > >
> > > ---
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index c6a6936183d5..0045dc754ef7 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -9580,7 +9580,7 @@ static int bpf_overflow_handler(struct perf_eve=
nt *event,
> > >                 goto out;
> > >         rcu_read_lock();
> > >         prog =3D READ_ONCE(event->prog);
> > > -       if (prog) {
> > > +       if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT) {
> > >                 perf_prepare_sample(data, event, regs);
> > >                 ret =3D bpf_prog_run(prog, &ctx);
> > >         }

