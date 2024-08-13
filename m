Return-Path: <bpf+bounces-37035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6D9506BD
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5B21C20D35
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9C19D077;
	Tue, 13 Aug 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="NZNcxwKP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B5192B91
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556325; cv=none; b=S4U01eKs1vzWYFpmMBJCxw+rL86rfg08/3E9v/JOMX9U9E4uNDMYEUh++725qKD5C8j1GKAlwtGQZDI4em57HFMZu/lqscFlI9T2dUL0KBeOJdi2lEb2G3BBaHPVTzrZ1suq62lqaabk88PRt+v35EeflQJVXxDF9yP6h6j8Lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556325; c=relaxed/simple;
	bh=43igTuJor3nq4TOqUbEZQycMVXzKpmUbmi9vcEwrMUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQsFoTuSWHHz8yuBp8aBF6j6s/9FKTf52wEqQZqRebqk5QZ3YX7vnwMuCFhQ/pqQ4yYhzcdO0c5cRnkzGaiRzqPOQa5lNy5GbkjHbyhfiSwPN3mhvMO2js2h/i6h+c08XdBNXKj0ZOm7Yu8fStnQKhQbNG0/OOYDQdA5FeMJiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=NZNcxwKP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so65264001fa.2
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1723556321; x=1724161121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLTqSL9xOGJSln+6oYEQ8vVYIDiotdSevswl3wN47gE=;
        b=NZNcxwKPLZ1l5EE0atKjMmqxMTrRDFqnLXW6/uLFnsI3DlIuH1e4SOlaWLQz4y9m03
         Td2NTU8OG3Gwd1eqx0HfLyk5xOQnIJ56O5uX8aJdvNPhu8lUD+vd8fB/V/Py9mjTd1ui
         X92XPImxd+QYqz8YECFer31kJhKny7769aeGae3yANDBHcAFuUaLmft6sYKQH+gDb+p9
         83rceZ3gmYP9oagqGL1k7JN9ziFWwDoESu5pahfFiMlMzOyvXLSa2ybtlQstUSm+1Ww/
         UvNonxQscc5obvkcQOpfqenWUtNqRqp6PSBAy1BrcGGz10rfVCwBRa4jdZirCWYC15pq
         zaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556321; x=1724161121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLTqSL9xOGJSln+6oYEQ8vVYIDiotdSevswl3wN47gE=;
        b=t0PimqXa8be1OGt0aiW4qUyFHHngO0jm7+4SbaThoDC3KZz/+3usEb8oRINFXQnS9Z
         +enKH+gZHqneH6rcjoZXAFmU/bDXPBAKxvSTH9gyh9VdQJxNwG+PwjSXBJLDw6p3/qy/
         y2cVWiGqsKw/+zdMMtKXdeo6O3pRAjEH7iO6wcIYwVX7hlBVOOrvxVB8MEVg/FuLjkC+
         1ctpRwN9aqeXggj6NrZTAJWMBw0M1DIwxL4/IK547cpi/3ga2hvtMt9cOxhllcHZA1At
         0ldUVLg5U+f0viTEE+Eac3TniQQwGdwLtLDwlIth8IuD3ztg/XWYqgO56kMamaQbB82P
         YsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQMFt23lDyGGrm/rJO9lVoAcoJKzdraFEzxkyD+rmXDe3Bk+qqOAHSu6j6omlL0oMc3dsCQ2K7mJQFP3gjd9U7W6mr
X-Gm-Message-State: AOJu0YwSmbpdngeIvvBAAHhdMQp6vsIH/pVGKoEFiFjy3PhpxztBwZgx
	qko5nWFPWRBKysnqMwMcVGdSGzoub84hVBF/NtRqu93iyV+bnHyKWlNiaNWTtglzaAHNgk+LyOw
	CpOOQzOO7loKHqpBzkMu+mrd2FMKyzSZ5vw+T
X-Google-Smtp-Source: AGHT+IE+nNeBsXzq8AYhTZpzokdNZ0mZWmEpb0RS22YZUXsbGpDyqS6vAtqPQIv/45k+PjQ/HO8v6uwE2iVwuW/+2r8=
X-Received: by 2002:a2e:b894:0:b0:2ef:2638:48cd with SMTP id
 38308e7fff4ca-2f2b7177c80mr32730081fa.30.1723556320633; Tue, 13 Aug 2024
 06:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
 <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net> <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava> <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
 <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com>
 <CAEf4BzbE4keci=hyt2APp5sfimvqfpLoWgEgEnC=Yp5S-jejKg@mail.gmail.com>
 <CAP045ArBf5Ja4s_gkg3vQciw0v7_h4kWjnbLUSk=uFgQ7WbTqQ@mail.gmail.com>
 <ZrC9oxIcKebAKpx3@LQ3V64L9R2.home> <Zrs3ZqRtT3_lNj6a@LQ3V64L9R2.home>
In-Reply-To: <Zrs3ZqRtT3_lNj6a@LQ3V64L9R2.home>
From: Kyle Huey <me@kylehuey.com>
Date: Tue, 13 Aug 2024 06:38:27 -0700
Message-ID: <CAP045AoTAX7MOObBq0ubS0bSbu1MmrG4wEEiXpKV54W9up1zJg@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Joe Damato <jdamato@fastly.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, khuey@kylehuey.com, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, robert@ocallahan.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:37=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Mon, Aug 05, 2024 at 12:55:17PM +0100, Joe Damato wrote:
> > On Fri, Jul 26, 2024 at 09:35:43AM -0700, Kyle Huey wrote:
> > > Will do.
> > >
> > > - Kyle
> > >
> > > On Fri, Jul 26, 2024 at 9:34=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 26, 2024 at 5:37=E2=80=AFAM Kyle Huey <me@kylehuey.com>=
 wrote:
> > > > >
> > > > > On Fri, Jul 19, 2024 at 11:26=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 16, 2024 at 12:25=E2=80=AFAM Jiri Olsa <olsajiri@gm=
ail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > > > > > > > On Mon, Jul 15, 2024 at 9:30=E2=80=AFAM Peter Zijlstra <pet=
erz@infradead.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote=
:
> > > > > > > > >
> > > > > > > > > > I think this would probably work but stealing the bit s=
eems far more
> > > > > > > > > > complicated than just gating on perf_event_is_tracing()=
.
> > > > > > > > >
> > > > > > > > > perf_event_is_tracing() is something like 3 branches. It =
is not a simple
> > > > > > > > > conditional. Combined with that re-load and the wrong ret=
urn value, this
> > > > > > > > > all wants a cleanup.
> > > > > > > > >
> > > > > > > > > Using that LSB works, it's just that the code aint pretty=
.
> > > > > > > >
> > > > > > > > Maybe we could gate on !event->tp_event instead. Somebody w=
ho is more
> > > > > > > > familiar with this code than me should probably confirm tha=
t tp_event
> > > > > > > > being non-null and perf_event_is_tracing() being true are e=
quivalent
> > > > > > > > though.
> > > > > > > >
> > > > > > >
> > > > > > > it looks like that's the case, AFAICS tracepoint/kprobe/uprob=
e events
> > > > > > > are the only ones having the tp_event pointer set, Masami?
> > > > > > >
> > > > > > > fwiw I tried to run bpf selftests with that and it's fine
> > > > > >
> > > > > > Why can't we do the most straightforward thing in this case?
> > > > > >
> > > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > > index ab6c4c942f79..cf4645b26c90 100644
> > > > > > --- a/kernel/events/core.c
> > > > > > +++ b/kernel/events/core.c
> > > > > > @@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct p=
erf_event *event,
> > > > > >
> > > > > >         ret =3D __perf_event_account_interrupt(event, throttle)=
;
> > > > > >
> > > > > > -       if (event->prog && !bpf_overflow_handler(event, data, r=
egs))
> > > > > > +       if (event->prog && event->prog->type =3D=3D BPF_PROG_TY=
PE_PERF_EVENT &&
> > > > > > +           !bpf_overflow_handler(event, data, regs))
> > > > > >                 return ret;
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > jirka
> > > > > > >
> > > > >
> > > > > Yes, that's effectively equivalent to calling perf_event_is_traci=
ng()
> > > > > and would work too. Do you want to land that patch? It needs to g=
o to
> > > > > 6.10 stable too.
> > > >
> > > > I'd appreciate it if you can just incorporate that into your patch =
and
> > > > resend it, thank you!
> > > >
> > > > >
> > > > > - Kyle
> >
> > I probably missed the updated patch, but I am happy to test any new
> > versions, if needed, to ensure that the bug I hit is fixed.
> >
> > Kyle: please let me know if there's a patch you'd like me to test?
>
> Sorry for pinging this thread again; let me know if a fix was merged
> and I missed it?
>
> Otherwise, if it'd be helpful, I am happy to modify Kyle's patch to
> take Andrii's suggestion and resend, but I don't want to step on
> anyone's toes :)
>
> - Joe

Hi Joe,

You didn't miss anything. I've been remiss in getting back to this.
I'm currently away from home (and the machine I usually do kernel
development on), so if you want to run with this please do so.

Sorry for the inconvenience,

- Kyle

