Return-Path: <bpf+bounces-34825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282AD9316DA
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39001F21ED1
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A118EA98;
	Mon, 15 Jul 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="TZFfW7G6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4E18EA83
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054054; cv=none; b=tAvLpzpFHvgc8XqXbW2iCDdOvx6wFF4786Vh5AfwWD8Gwx4tLUnXtb907hNf09dfJqxZ2jmBzzZCb6jwHmmscnhTOCcDEDs2uFyc+KkV5jM/Rdn5wOK0Bd3TqDmKBUgrSl2XhIPl6/2bMSX2ZXihvf/X2wCTZAdVFQkD4fTdOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054054; c=relaxed/simple;
	bh=DeWbq/9MJYc6Iy22z0bqgmBszSZFbAELQkGWsV1arsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qI0ab1gQESbqeEJ0VDeLTPmfMCVoocoyqR36FscbjrQVC1ZLmReZLvkN6IqS6peNOxPtA95CQvDqkGO+BOPd5YBCf9UhN9hmCGd9t1oFQuQNK+lKcEcufZr6ypQwoSYkln8oFeHpLE3EC/ZK40ELxL6xm2hJ8ALnwNLgfz5kTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=TZFfW7G6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso5331221e87.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1721054051; x=1721658851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0+uPrvzV5BDJSu1TLs5SPOWV5Ui4MhlzXkhNuVzqFk=;
        b=TZFfW7G6NCC6iwNyKkyMuJXVulXheNoO8FqvKjl5TKF65SQCWHw9araqByMGUYwqqa
         xL9mBEo1BKTtlo/BMR+Dqul61bM7v1U+4scQn4Mbg43E7m4L8mLMfGOGkjbfkRih97BU
         9TZ62DhR5TAqMqEu+kiWkBrKM2InwXYHqFrM+fM66nfCJYQ3VQsIuzSUYp9SZZsFHbJh
         JHK+nXD/Vz8YMFKoB0KtTYzHZYjT29+i3Mmn+Zm9gnz4rUG46Lwt0+pRo0XfmDqEEXqA
         NGv9AuQBsQVYU9dpUEpzOup/o1AuPYvJ3heqVPCBF0kri4OB10wxiAtiSrEakxWnxhv4
         GOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054051; x=1721658851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0+uPrvzV5BDJSu1TLs5SPOWV5Ui4MhlzXkhNuVzqFk=;
        b=tTWx8FVAnROWn5hlzQaoP6rF54hjNmI1VizOW4s7Mt9b+glKJWNEuVr2u0PEAhf1p3
         Gtg4awy7KqnartptkWZTkDL9zb59WmKXVr11k2zOImh3Om3EpCBKs1aD/sJVhPdKxASd
         TRq1FpfrJ0Yms5nsccKHAywcQ4mdPjYIJ3ayXrvNxkSvT/caYNvW0ziz9+dUQScyw/2J
         zZ8fQuk1SBwzn1fhyFA//qDWztANURsYcOTGqzdeDfv/UlSwwQ6CqneAdP4WS5ZMXE9i
         Nmeod6PkysCgcNNVo5vzIR9Kby7sxypIR0lvh45aBbvPrbjkS+FdvmOyvKf8zDivC0WL
         cHEw==
X-Forwarded-Encrypted: i=1; AJvYcCWIFVrT6X/ul8nim4NQ0CGhz2qo1EZIYRfcSHVipAYBY9SKwHWLTqD2PacsSi+BFxJunj9LPUFTXGabtpHTyvtuLF/1
X-Gm-Message-State: AOJu0YwI/hy9lZgI3ZeFqOLc+cKhk0kBRYuO8vLsOZundnWQbur9hbT9
	U8VFnvvSm2z4e0wdkF5778IltjZuR9ks88BsYRe5LPaNBQ8OtNBjFr2ydsVFrxOuJhochtA0c4L
	I5ae9hytEUf3SBLFV6k7H3tvNiVP0F0vGOEVS
X-Google-Smtp-Source: AGHT+IHv5w2FuoGdCOk35Qlk8/8Rs4DpWrQSuu28zD64GVgiAmSsM/9jgupw2aUlE4JUkcBHG00X8hM7ORpSL+AE3F4=
X-Received: by 2002:a2e:9193:0:b0:2ee:7a3a:9969 with SMTP id
 38308e7fff4ca-2eef2d7b2b5mr585921fa.5.1721054050935; Mon, 15 Jul 2024
 07:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715111208.GB14400@noisy.programming.kicks-ass.net>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 15 Jul 2024 07:33:57 -0700
Message-ID: <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:12=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sat, Jul 13, 2024 at 10:32:07PM +0200, Jiri Olsa wrote:
> > On Fri, Jul 12, 2024 at 09:46:45PM -0700, Kyle Huey wrote:
> > > The regressing commit is new in 6.10. It assumed that anytime event->=
prog
> > > is set bpf_overflow_handler() should be invoked to execute the attach=
ed bpf
> > > program. This assumption is false for tracing events, and as a result=
 the
> > > regressing commit broke bpftrace by invoking the bpf handler with gar=
bage
> > > inputs on overflow.
> > >
> > > Prior to the regression the overflow handlers formed a chain (of leng=
th 0,
> > > 1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
> > > bpf_overflow_handler() to that chain, while perf_event_attach_bpf_pro=
g()
> > > (the tracing case) did not. Both set event->prog. The chain of overfl=
ow
> > > handlers was replaced by a single overflow handler slot and a fixed c=
all to
> > > bpf_overflow_handler() when appropriate. This modifies the condition =
there
> > > to include !perf_event_is_tracing(), restoring the previous behavior =
and
> > > fixing bpftrace.
> > >
> > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > Reported-by: Joe Damato <jdamato@fastly.com>
> > > Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not throug=
h overflow machinery")
> > > Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
> > > Tested-by: Kyle Huey <khuey@kylehuey.com> # bpf overflow handlers
> > > ---
> > >  kernel/events/core.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 8f908f077935..f0d7119585dc 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -9666,6 +9666,8 @@ static inline void perf_event_free_bpf_handler(=
struct perf_event *event)
> > >   * Generic event overflow handling, sampling.
> > >   */
> > >
> > > +static bool perf_event_is_tracing(struct perf_event *event);
> > > +
> > >  static int __perf_event_overflow(struct perf_event *event,
> > >                              int throttle, struct perf_sample_data *d=
ata,
> > >                              struct pt_regs *regs)
> > > @@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
> > >
> > >     ret =3D __perf_event_account_interrupt(event, throttle);
> > >
> > > -   if (event->prog && !bpf_overflow_handler(event, data, regs))
> > > +   if (event->prog &&
> > > +       !perf_event_is_tracing(event) &&
> > > +       !bpf_overflow_handler(event, data, regs))
> > >             return ret;
> >
> > ok makes sense, it's better to follow the perf_event_set_bpf_prog condi=
tion
> >
> > Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>
> Urgh, so wth does event_is_tracing do with event->prog? And can't we
> clean this up?

Tracing events keep track of the bpf program in event->prog solely for
cleanup. The bpf programs are stored in and invoked from
event->tp_event->prog_array, but when the event is destroyed it needs
to know which bpf program to remove from that array.

> That whole perf_event_is_tracing() is a pretty gross function.
>
> Also, I think the default return value of bpf_overflow_handler() is
> wrong -- note how if !event->prog we won't call bpf_overflow_handler(),
> but if we do call it, but then have !event->prog on the re-read, we
> still return 0.

The synchronization model here isn't quite clear to me but I don't
think this matters in practice. Once event->prog is set the only
allowed change is for it to be cleared when the perf event is freed.
Anything else is refused by perf_event_set_bpf_handler() with EEXIST.
Can that free race with an overflow handler? I'm not sure, but even if
it can, dropping an overflow for an event that's being freed seems
fine to me. If it can't race then we could remove the condition on the
re-read entirely.

- Kyle

