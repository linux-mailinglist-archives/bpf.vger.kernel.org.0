Return-Path: <bpf+bounces-22121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9685739B
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5319E1F22CCD
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E3DDD5;
	Fri, 16 Feb 2024 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="DkCTWick"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D1DDAE
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708048796; cv=none; b=oz72zdjmPrZllZEVyfcBSCnAPetfgfXmV2zuKE2YkoltCUAu7ylAy11gJtz5TgJ0bs9NF/vf8lYSZV6Z3VvSP4NBaZUz75r9uEb0lCBsk+s7rEwMXqDJ/RIiAymGwxKfsIZ8uzy4JZli3nCu9WJsjNC+x2sO/uHMAx/XZBJLCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708048796; c=relaxed/simple;
	bh=6Jf8Tf3YNL8Iit35UP///6Wu8rWBNYzPIySyhB9DyxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuBtmnNYKuCKNK59ID9NMkkfZyBBOIkRDaCIwUuPGzENSGW1prbw1XakRrBjv4fdZ672pBn22X9BQjTOBo/qJ/I/EWD+SbllUmlcGSD7oO8pcnr5lFjOWmXs9Trc9Mg6JmgoCOCbEho0DnakbA0EfSCdwxpVoAH3Ij+S2iezyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=DkCTWick; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a17f3217aso193282366b.2
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 17:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1708048793; x=1708653593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkh1NITpOSxywtc0rXIfkglAv7pc2Po+WHLtzXx3g5M=;
        b=DkCTWicksi/iGrSwllQAvEn0iDjk5BaGaBQ+GgjBTOTwHL0pgWMc1LYxy8F6kY9Hwq
         dGrxgywpRbRrrMmt/NwgHdR/h6r08EjjdU9t9YBzUaZauDNvDkrHkVOMWoMV5UVhE8IH
         a+8xXqIdS1guLqD9bMjHK/JujRg26lUdUB7cqitSEX5LPz/xxkGpXvbSHeLCAD+/6Fkg
         wz4uoPjqHrdhDp07919YKejqyY0N73BbcJRUa9N0UMxgyKCSiD+hqfQ/JjCq3pe88/ue
         gLrc9n0GIfJTBWT2IqNom/QsWLvvgI31mHsbopd/0EqHV/xqahT40f/f/s3Sjdk/yHXQ
         g5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708048793; x=1708653593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkh1NITpOSxywtc0rXIfkglAv7pc2Po+WHLtzXx3g5M=;
        b=QVVg3wmH+ZO0xMgpx5gB10LlC2/KMo/DlIbJaCCLWtSoePYkg2WN0vHZ3Ha0Pv+fNL
         44BQDQTMhsmezfjBkCDEnZpRFtBc11EXi/F10hIAITcB8I8mUmZBHtDL1ym7gcp8kpyX
         spmtEuXErMxY/qC0hz3m/PvsrQEc8hsq71SDoa1bLZzb1Xjs/Dgl0lnMR7fwASLszhFB
         QJ+ZCc14SCB5zhogUQXCVRg6lVqsVRwuwkar3UvX5Cd0hNrm8Ry7eHllA4b38Ovx7XZj
         1+hlo0llO5J5qp672VcJrXLiY14F3wlBErYateIo0aMYEwdcPK/ktxR+bqvRXElDMqp5
         somg==
X-Forwarded-Encrypted: i=1; AJvYcCUQfMJOWnLWE+RnwfdZ/2yHA+IPnYsw7fhbR3Eq6nbd5WCYWYQNvoGYuoB45bHNH5au3uvehztvKuJCPwKga1aTF0up
X-Gm-Message-State: AOJu0YwRynwKjKX0RqN8jLCHLw5WfSCo71tHwZW106gapAlA2H1pF/ze
	489lhDJSLWlOX17YREIeBlUKNz0fBQX142H1lfURvbEpECrIP/15h6O+9eIoDU6pN3FOf8mfb+e
	sya/dbiICo0yqcSWiSQZ0quk9Wz6H253XFgRp
X-Google-Smtp-Source: AGHT+IHtbu8SCnFfkPU/Y3/W/5A60xjkCU/AfNXafWbyJ2P+SAyHGSfW0pyRBRZ1ZhJj7Tob7k2Zd4P+HLFt+T344/k=
X-Received: by 2002:a17:906:e52:b0:a3d:678e:d020 with SMTP id
 q18-20020a1709060e5200b00a3d678ed020mr2263334eji.43.1708048793090; Thu, 15
 Feb 2024 17:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214173950.18570-1-khuey@kylehuey.com> <20240214173950.18570-4-khuey@kylehuey.com>
 <CAEf4BzYFbVeVhSjj2wSLfg+qRs5x+yS1Wq9jwLNpJJPPtFiFqQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYFbVeVhSjj2wSLfg+qRs5x+yS1Wq9jwLNpJJPPtFiFqQ@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 15 Feb 2024 17:59:41 -0800
Message-ID: <CAP045Aq=siNqY_Nr6nbzdAaFUq7Rok0e+PWByYQuSspWguwsNQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/4] perf/bpf: Allow a bpf program to suppress
 all sample side effects
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Song Liu <song@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 4:14=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 14, 2024 at 9:40=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > Returning zero from a bpf program attached to a perf event already
> > suppresses any data output. Return early from __perf_event_overflow() i=
n
> > this case so it will also suppress event_limit accounting, SIGTRAP
> > generation, and F_ASYNC signalling.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > Acked-by: Song Liu <song@kernel.org>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/events/core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 24a718e7eb98..a329bec42c4d 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9574,6 +9574,11 @@ static int __perf_event_overflow(struct perf_eve=
nt *event,
> >
> >         ret =3D __perf_event_account_interrupt(event, throttle);
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +       if (event->prog && !bpf_overflow_handler(event, data, regs))
> > +               return ret;
> > +#endif
> > +
> >         /*
> >          * XXX event_limit might not quite work as expected on inherite=
d
> >          * events
> > @@ -9623,10 +9628,7 @@ static int __perf_event_overflow(struct perf_eve=
nt *event,
> >                 irq_work_queue(&event->pending_irq);
> >         }
> >
> > -#ifdef CONFIG_BPF_SYSCALL
> > -       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> > -#endif
> > -               READ_ONCE(event->overflow_handler)(event, data, regs);
> > +       READ_ONCE(event->overflow_handler)(event, data, regs);
> >
>
> Sorry, I haven't followed previous discussions, but why can't this
> change be done as part of patch 1?

The idea was to refactor the code without making any behavior changes
(patches 1 and 2) and then to change the behavior (patch 3).

- Kyle

> >         if (*perf_event_fasync(event) && event->pending_kill) {
> >                 event->pending_wakeup =3D 1;
> > --
> > 2.34.1
> >

