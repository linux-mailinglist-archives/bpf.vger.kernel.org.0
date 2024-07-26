Return-Path: <bpf+bounces-35740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716C93D6F0
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D21B285D85
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425717BB2A;
	Fri, 26 Jul 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzGlGFr4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E03749C;
	Fri, 26 Jul 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011682; cv=none; b=RjI/PdBzG0LMMIoNa+A0TyieMxiU1aol045wDcl7QWEGrn7fuxWrtIu7bT552LCIKDoBo7F6kL6GqsMXnVKNPXuVZwvvw7oDocbYfSITEvWVDGymEWdpb6W18O3vY4pVTODSwb1rZ+BqKoQoqe1ZKBFnbh4M4LP7NH2sHy2GIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011682; c=relaxed/simple;
	bh=a3W6GeimKRxRA60xDUiGl21hOcI3FV8wxR2WBNjOU8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpYPHkLEd6EuwcfLA5haDrpKAvGOFAdw5X9/7nNzCB4hvRBwtwmQjK2oN081QniiUdGjux8Tc6J7egyxTwAKqB6nyczTO5nnQAmX9Kps+p1gqI3cGetxO4PSuLOSMSxUWUrSxhlLH7ODnIw0hWZdMKI9rDKjNK+jqSsrIGAd1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzGlGFr4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-79b530ba612so835250a12.2;
        Fri, 26 Jul 2024 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722011680; x=1722616480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXsSnNuhk0LJBQD8hnBXU4IwSyNU0wvZpgqq1xZ0ssY=;
        b=FzGlGFr4Y9yw0UJjkLqzOMhtvUaLzCzDQMBzSK01xEBpeFz1WzYqOvvRpmQHW9aiDC
         6OmZo8uZ5ztrtoV+qloAta8Xw1IHl7k8LYr9zIFLDPAIPLljCNNBPm5QaUnNwPb497xF
         fohDJULqbCpjRLaPQq28JaG1IPpANXgqRsHKilt8VZfC3q9iF/nmM5eVbju8CQjkexAh
         TnO3JvgAte+1NKt+qJonv7LOHegFt4eLuMPVsEeXWBLcgqSY97vaWs3eSuKLNR3nzl4G
         772BJlN/WpdN2doPBkoiZaqhTt46JxiNEy4ivbp5SV4cesb4j1rPeaCZpd6j+SwxQRnu
         E8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011680; x=1722616480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXsSnNuhk0LJBQD8hnBXU4IwSyNU0wvZpgqq1xZ0ssY=;
        b=nZU1HG4qeDyu83cfxKwmXuj+shLrcoHcIXFAFXdinKz4yDfcF21eP9Eti3pcReBwYB
         ER+BM5SRUy9ONPczT5vv07p3Bkvouk4K0QQE+yfLHBvryUZdC8KItaNFRfpyfOL5ZO1E
         YvbKExf1F1HPUW4mEd4V4z4nZGYMgV4t1TXSv5+1o5UuGpCQS/O5OL/1sNygkXbDSAEB
         57pgu6UjB2u0lgPJ7WbVCid1E/Lu+vwKWe1J4UuDUGiZ0LtFvduhP3PkFnixmPncGpVV
         e1j+3MP6vEhcdkySXMrxhCfHeqFqD+ByRAX4r7T5sM/hj6z2tTReutFQAzLQBkdU9Kee
         i2iw==
X-Forwarded-Encrypted: i=1; AJvYcCXfpfmfpA3kv1+6I+qRG/K6OM9drFXs2bV5oKhblGVEEvOD8raUAgff0rdzsYPVfm2C/z8HrU386u+1voyqL9SKrD1z2NdBUszclmK5ovMyPB7TsZnQ4bzgxNIjQ3hjIg0zGXcqbAg4iZL1BOoQ+rC2KDuA2YH7F/qgo6eCrPgTH3u0Xw==
X-Gm-Message-State: AOJu0YwNC3KL8E97ttL+zjK+2nZUe9bqJI7jAkjHv8McQ6AFTJ59NuN1
	FhetvlNC1RyP9TZ6b9baOdlR7F+CcsuLQCZp3vm5QyuoJVW0/Lr7sjAK2keNhSCKXLOy9ZDtOFm
	c5cWq1m3PvwupumA8tIvr8F/A+jY=
X-Google-Smtp-Source: AGHT+IG2nhXVPsr4p3NYl2OhYd5cSuUs8jjefg+oqn2WyP5btK61lIKhKhYl2JXMLcjCI4ADtUa7qcb9FQdOpXHCKo0=
X-Received: by 2002:a17:90a:4d8d:b0:2cb:4e69:eaa3 with SMTP id
 98e67ed59e1d1-2cf7e1b99b4mr36883a91.8.1722011680232; Fri, 26 Jul 2024
 09:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net> <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net> <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net> <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava> <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
 <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com>
In-Reply-To: <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 09:34:28 -0700
Message-ID: <CAEf4BzbE4keci=hyt2APp5sfimvqfpLoWgEgEnC=Yp5S-jejKg@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Kyle Huey <me@kylehuey.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:37=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> On Fri, Jul 19, 2024 at 11:26=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jul 16, 2024 at 12:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> > >
> > > On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > > > On Mon, Jul 15, 2024 at 9:30=E2=80=AFAM Peter Zijlstra <peterz@infr=
adead.org> wrote:
> > > > >
> > > > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > > > >
> > > > > > I think this would probably work but stealing the bit seems far=
 more
> > > > > > complicated than just gating on perf_event_is_tracing().
> > > > >
> > > > > perf_event_is_tracing() is something like 3 branches. It is not a=
 simple
> > > > > conditional. Combined with that re-load and the wrong return valu=
e, this
> > > > > all wants a cleanup.
> > > > >
> > > > > Using that LSB works, it's just that the code aint pretty.
> > > >
> > > > Maybe we could gate on !event->tp_event instead. Somebody who is mo=
re
> > > > familiar with this code than me should probably confirm that tp_eve=
nt
> > > > being non-null and perf_event_is_tracing() being true are equivalen=
t
> > > > though.
> > > >
> > >
> > > it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
> > > are the only ones having the tp_event pointer set, Masami?
> > >
> > > fwiw I tried to run bpf selftests with that and it's fine
> >
> > Why can't we do the most straightforward thing in this case?
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index ab6c4c942f79..cf4645b26c90 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct perf_even=
t *event,
> >
> >         ret =3D __perf_event_account_interrupt(event, throttle);
> >
> > -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> > +       if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_=
EVENT &&
> > +           !bpf_overflow_handler(event, data, regs))
> >                 return ret;
> >
> >
> > >
> > > jirka
> > >
>
> Yes, that's effectively equivalent to calling perf_event_is_tracing()
> and would work too. Do you want to land that patch? It needs to go to
> 6.10 stable too.

I'd appreciate it if you can just incorporate that into your patch and
resend it, thank you!

>
> - Kyle

