Return-Path: <bpf+bounces-34708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63D93023E
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831C91C21138
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A384882886;
	Fri, 12 Jul 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="eJMIpkTi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAC745E2
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720824568; cv=none; b=Klc3yfJ95RFhYa1cVoqFTpBOJW6mrlwJO6q29iTj1Z6QAq8CXFwaJ1LKJtKeqiWKfW10wSYUnudSuUzfZvUbFwPBs2JpcdonY44ZdCLmLx7S6TbJw+vxj5ox4+qUEXRHkAr8recnM1+18inGRSoSYyWXDD3YeAjlw/Jca+mSB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720824568; c=relaxed/simple;
	bh=yzrZqcsuq4CzUEEp7agdi5M1qVJCH/6gW70AV7UgS5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHe7m8wF2mddQ028SuJR9YM2qYPehSfv0nu4NlDEmVx9wTrJ6eF5DZ0EBxi1n26EceNDqiNPTzLKASALMVEe//CUpE+A81JYimFHbyH9EPDIASpzxNpPqnFOCSXT2y2fn2+2oe1cUqmohBBeWNTnsAViTUjQoV0oJspK2U4kYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=eJMIpkTi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so4362201fa.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720824564; x=1721429364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNbG9SPw6ODdqm0X1D1P5bIp1TAPpaaOK+IcIxDrqlA=;
        b=eJMIpkTikkEt1IEhNVOJSF0qjn7LsbHJirBjROi3lfMRkK1+n/TQiVRjyfbOeqDF5a
         49W+lhLYoAVIPxe+H2TPstwePMhbWhLxMw/LIChAC6v2zqHWovkTINrVRCWf+xDhrQG5
         qRPvgst+nc5cjJJpr6GmhLbcV2CECEmAF6Uu7/p6sLtvZVbujq98qoflVwUwbU5EzIwK
         Ra5TmuMBIchekmL4J+74NtPb7KXghbseixjbvPsvx3UygsV7KoIOPdX7myCVMsHnyuOa
         w9uwt/ag2ofLGaCWTfGtOiLR4kjGmaZKVN5VRBPPUNqzT7i/1qAjofL0FscCLG4No8di
         YLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720824564; x=1721429364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNbG9SPw6ODdqm0X1D1P5bIp1TAPpaaOK+IcIxDrqlA=;
        b=iZknBD0i8P0pmt17qGvn3TAdMaKHyODOLjGXEQHaAq3BTQ3bMnbytWvvv1xpBEOr+L
         qtky3gFMuEguUlPfHXf7tpRPfpaxSkSbYlokFWOAHk3Y3Eost8DipaLQeRDH2KFMxV1u
         2FIUM1tS4lik+y9aXE5cMshwMVq0aDEM0S73JYpk7QXzvYigwfoEyHja+lHaa46uitmW
         kAsB014pZtUjZX6ikeAyXxDUtJzupK6/r94mR4fI6Etrur6iuZ5s+igeTtozkZbQrR7V
         XyJxy87D0jrQEMWi3Xnwfb2d3j1zbqTAVgTDi0O24MVpauGnnb8hnzvdN24S2/qtLL/5
         b0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUdNggKdnyUnXMy4oTpqpMyAoO7cuwkDa5uNKPAyuDVcivUXZJcZyLKEvafSXAHzDbFxvi/n7WHEAkV62tMNpjahctG
X-Gm-Message-State: AOJu0Yy1LxnSRZhmf+Rj2bpYv7tEkX2CWheaPNpP4Go6oBH/RMt4Rjb+
	R3Sl194FwNuPI6MYZjZVrFpIgnRIxV/B1jFsA8m5gKWE0m0cO0SDovr/wkouE0EtF2xpW0f5yKM
	guCrudeK0OzE9LRMG1lbOo56oVAxgs5cn74fn
X-Google-Smtp-Source: AGHT+IFQTYMXfqyYBs8TBsM8FGOvJi8uuLScFLRKAzHQL5X7ONHmwQeJ/BxhMJmn063fY3YFc597TbdshfS7b5JGoXU=
X-Received: by 2002:a05:651c:198c:b0:2ee:46ec:60bc with SMTP id
 38308e7fff4ca-2eeb30fc98amr101773481fa.27.1720824563679; Fri, 12 Jul 2024
 15:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2> <ZpGrstyKD-PtWyoP@krava>
In-Reply-To: <ZpGrstyKD-PtWyoP@krava>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 12 Jul 2024 15:49:10 -0700
Message-ID: <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
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

On Fri, Jul 12, 2024 at 3:18=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jul 12, 2024 at 09:53:53AM -0700, Joe Damato wrote:
> > Greetings:
> >
> > (I am reposting this question after 2 days and to a wider audience
> > as I didn't hear back [1]; my apologies it just seemed like a
> > possible bug slipped into 6.10-rc1 and I wanted to bring attention
> > to it before 6.10 is released.)
> >
> > While testing some unrelated networking code with Martin Karsten (cc'd =
on
> > this email) we discovered what appears to be some sort of overflow bug =
in
> > bpf.
> >
> > git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF handl=
er
> > directly, not through overflow machinery") is the first commit where th=
e
> > (I assume) buggy behavior appears.
>
> heya, nice catch!
>
> I can reproduce.. it seems that after f11f10bfa1ca we allow to run tracep=
oint
> program as perf event overflow program
>
> bpftrace's bpf program returns 1 which means that perf_trace_run_bpf_subm=
it
> will continue to execute perf_tp_event and then:
>
>   perf_tp_event
>     perf_swevent_event
>       __perf_event_overflow
>         bpf_overflow_handler
>
> bpf_overflow_handler then executes event->prog on wrong arguments, which
> results in wrong 'work' data in bpftrace output
>
> I can 'fix' that by checking the event type before running the program li=
ke
> in the change below, but I wonder there's probably better fix
>
> Kyle, any idea?

Thanks for doing the hard work here Jiri. I did see the original email
a couple days ago but the cause was far from obvious to me so I was
waiting until I had more time to dig in.

The issue here is that kernel/trace/bpf_trace.c pokes at event->prog
directly, so the assumption made in my patch series (based on the
suggested patch at
https://lore.kernel.org/lkml/ZXJJa5re536_e7c1@google.com/) that having
a BPF program in event->prog means we also use the BPF overflow
handler is wrong.

I'll think about how to fix it.

- Kyle


> >
> > Running the following on my machine as of the commit mentioned above:
> >
> >   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] =3D count(); }=
'
> >
> > while simultaneously transferring data to the target machine (in my cas=
e, I
> > scp'd a 100MiB file of zeros in a loop) results in very strange output
> > (snipped):
> >
> >   @[11]: 5
> >   @[18]: 5
> >   @[-30590]: 6
> >   @[10]: 7
> >   @[14]: 9
> >
> > It does not seem that the driver I am using on my test system (mlx5) wo=
uld
> > ever return a negative value from its napi poll function and likewise f=
or
> > the driver Martin is using (mlx4).
> >
> > As such, I don't think it is possible for args->work to ever be a large
> > negative number, but perhaps I am misunderstanding something?
> >
> > I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #ifdef
> > CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibit th=
is
> > behavior and the output seems reasonable on my test system. Martin conf=
irms
> > the same for both commits on his test system, which uses different hard=
ware
> > than mine.
> >
> > Is this an expected side effect of this change? I would expect it is no=
t
> > and that the output is a bug of some sort. My apologies in that I am no=
t
> > particularly familiar with the bpf code and cannot suggest what the roo=
t
> > cause might be.
> >
> > If it is not a bug:
> >   1. Sorry for the noise :(
>
> your report is great, thanks a lot!
>
> jirka
>
>
> >   2. Can anyone suggest what this output might mean or how the
> >      script run above should be modified? AFAIK this is a fairly
> >      common bpftrace that many folks run for profiling/debugging
> >      purposes.
> >
> > Thanks,
> > Joe
> >
> > [1]: https://lore.kernel.org/bpf/Zo64cpho2cFQiOeE@LQ3V64L9R2/T/#u
>
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c6a6936183d5..0045dc754ef7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9580,7 +9580,7 @@ static int bpf_overflow_handler(struct perf_event *=
event,
>                 goto out;
>         rcu_read_lock();
>         prog =3D READ_ONCE(event->prog);
> -       if (prog) {
> +       if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT) {
>                 perf_prepare_sample(data, event, regs);
>                 ret =3D bpf_prog_run(prog, &ctx);
>         }

