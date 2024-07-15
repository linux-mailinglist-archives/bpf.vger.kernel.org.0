Return-Path: <bpf+bounces-34827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3513B931781
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E175B221C4
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CBB18F2E2;
	Mon, 15 Jul 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="juyQuUpO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7AB2AD31
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056803; cv=none; b=bmIjjhESop1zn9x7WjzggwUo2PEtqHpSzKfyCDLefsj3CzuHtVYmKXJqUpxtuak4U+PKxyZodt0O0qUUHlXSsUD96f515ZHATlpaDqJNoskmwDA1WIk+UkABKxGkZIHt4NpcpO2waRsBtyMx/oskYLFLBR9ODTsqo2ryL2eRa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056803; c=relaxed/simple;
	bh=xVtOUrwk4vZ1HeRE0WVbIfe0bSuilqI4ZyxB5xfIzys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3cz5/FTovU4GSLSypr+9bb5sjPVAtsbU/PXwAHYaxoDCtW56omlwpvYLGtl/vq4gWUE6lH6LTGMttz+yFOWij9xc4OekenmIWh3QFvWWv7BiGhwcmrRhdGmFl180VG7aujyyahCzR+RODV3X2XUpayJNBzcdyA0VuXpxE82bnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=juyQuUpO; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso23485411fa.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1721056799; x=1721661599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/IeoKkxMSHCxwB2Ru5xsdGJDxWlCgExddLuuWNKzCs=;
        b=juyQuUpO2aoO0nD2CNmF0zGcHHD5hPoy8GWm4KHP3gizNqsRn5WVWgDlZex1NL4kIY
         XWEUjty6KZ5ohGq2NBrcjDbIPJPh4NGh/rg1mhqNAZKsn5p7UfMURr/tCBkWaUzBTjx8
         womMCOJSV+F/WS+miNXmwP6h2UQ3re04OvgLxQCTKeBIF1Uh9q7kJWoXQDL9OzPOFy8z
         Exh6nSD/FpoZAnuweGQc6k3NDYR1CeRKmy4GkGK/Rjd98rvAQ1aJCf8rWHLjzkImrlM6
         4l7lm/RPJKsFG+jk8y8k7ART8kLj9timF9Saznrpzh9p7k+7sreZf53cFEoL79Pdt86L
         glSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721056799; x=1721661599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/IeoKkxMSHCxwB2Ru5xsdGJDxWlCgExddLuuWNKzCs=;
        b=LonDuusXJHbhs5qSCaJMV8oZjcXKV4WnwJ+FEO75XO0paQMdlTR2OnUy/UlHoVZGcb
         Ni224MyyV/yrZvmv/WyW9DaUDN23ca7cSt8ArMbQ/oot4LR5vctyZLQGaq9ytPFtQvfm
         0U0fIzen92GxoPXYIH3couQXfE2GY9dxWJDuYF5DQL91vl+YTSpltqRF/ZtiEcttlntX
         BaHe1P3wSUGDmsECzl6tY7nV0Z1aY0HvmnjlXtJrMS7NMr5Ey51XKpY0Bt5xoz37uh/U
         GOgsLBqmgGHqzuFPct6BxAI94/ekgxLJ00dJiC0WY2B15fWuVRyidJwStTjLi7XFPDKR
         KU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxFLPJZK5huUk5N7jqKoy0s8LeIq8a6/aVli33VHI+z9APRIBDzr+LcaVVCYtaLTnUMwdSZiRvKQuj+AYvzpF4ci0W
X-Gm-Message-State: AOJu0YyRQrdcJMrRhkYDzn0SyhT1YCX6xu2pM6pChj5NK6izRFWJmDd3
	1o596e719Ne97HoStC9GGi3BbvF8tnCwUKQr1HAhxXpCUjFGebkwNo7P/0Cx3hWVZXmbALkgPid
	Wtut5UFhMfM0ljQKAuAwe/p1l+wqBxmoT4t9L
X-Google-Smtp-Source: AGHT+IEYLLR0a/H9i0Puh6iXlV4T3WIDkdGAUwLlXCLZr3sZq0yH80Q33H3k5Tb3RqkpzW8Ev9dYsRTlIDvVN8N01Z4=
X-Received: by 2002:a2e:2ac4:0:b0:2ee:92ea:8d0a with SMTP id
 38308e7fff4ca-2eef2d7e29cmr1458771fa.23.1721056799347; Mon, 15 Jul 2024
 08:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net> <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 15 Jul 2024 08:19:44 -0700
Message-ID: <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
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

On Mon, Jul 15, 2024 at 8:04=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 15, 2024 at 07:33:57AM -0700, Kyle Huey wrote:
> > On Mon, Jul 15, 2024 at 4:12=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
>
> > > Urgh, so wth does event_is_tracing do with event->prog? And can't we
> > > clean this up?
> >
> > Tracing events keep track of the bpf program in event->prog solely for
> > cleanup. The bpf programs are stored in and invoked from
> > event->tp_event->prog_array, but when the event is destroyed it needs
> > to know which bpf program to remove from that array.
>
> Yeah, figured it out eventually.. Does look like it needs event->prog
> and we can't easily remedy this dual use :/
>
> > > That whole perf_event_is_tracing() is a pretty gross function.
> > >
> > > Also, I think the default return value of bpf_overflow_handler() is
> > > wrong -- note how if !event->prog we won't call bpf_overflow_handler(=
),
> > > but if we do call it, but then have !event->prog on the re-read, we
> > > still return 0.
> >
> > The synchronization model here isn't quite clear to me but I don't
> > think this matters in practice. Once event->prog is set the only
> > allowed change is for it to be cleared when the perf event is freed.
> > Anything else is refused by perf_event_set_bpf_handler() with EEXIST.
> > Can that free race with an overflow handler? I'm not sure, but even if
> > it can, dropping an overflow for an event that's being freed seems
> > fine to me. If it can't race then we could remove the condition on the
> > re-read entirely.
>
> Right, also rcu_read_lock() is cheap enough to unconditionally do I'm
> thinking.
>
> So since we have two distinct users of event->prog, I figured we could
> distinguish them from one of the LSB in the pointer value, which then
> got me the below.
>
> But now that I see the end result I'm not at all sure this is sane.
>
> But I figure it ought to work...

I think this would probably work but stealing the bit seems far more
complicated than just gating on perf_event_is_tracing().

Would it assuage your concerns at all if I made event->prog a simple
union between say handler_prog and sample_prog (still discriminated by
perf_event_is_tracing() where necessary) with appropriate comments and
changed the two code paths accordingly?

- Kyle

> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ab6c4c942f79..5ec78346c2a1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9594,6 +9594,13 @@ static inline bool sample_is_allowed(struct perf_e=
vent *event, struct pt_regs *r
>  }
>
>  #ifdef CONFIG_BPF_SYSCALL
> +
> +static inline struct bpf_prog *event_prog(struct perf_event *event)
> +{
> +       unsigned long _prog =3D (unsigned long)READ_ONCE(event->prog);
> +       return (void *)(_prog & ~1);
> +}
> +
>  static int bpf_overflow_handler(struct perf_event *event,
>                                 struct perf_sample_data *data,
>                                 struct pt_regs *regs)
> @@ -9603,19 +9610,21 @@ static int bpf_overflow_handler(struct perf_event=
 *event,
>                 .event =3D event,
>         };
>         struct bpf_prog *prog;
> -       int ret =3D 0;
> +       int ret =3D 1;
> +
> +       guard(rcu)();
>
> -       ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
> -       if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1))
> -               goto out;
> -       rcu_read_lock();
>         prog =3D READ_ONCE(event->prog);
> -       if (prog) {
> +       if (!((unsigned long)prog & 1))
> +               return ret;
> +
> +       prog =3D (void *)((unsigned long)prog & ~1);
> +
> +       if (unlikely(__this_cpu_inc_return(bpf_prog_active) =3D=3D 1)) {
>                 perf_prepare_sample(data, event, regs);
> +               ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
>                 ret =3D bpf_prog_run(prog, &ctx);
>         }
> -       rcu_read_unlock();
> -out:
>         __this_cpu_dec(bpf_prog_active);
>
>         return ret;
> @@ -9652,14 +9661,14 @@ static inline int perf_event_set_bpf_handler(stru=
ct perf_event *event,
>                 return -EPROTO;
>         }
>
> -       event->prog =3D prog;
> +       event->prog =3D (void *)((unsigned long)prog | 1);
>         event->bpf_cookie =3D bpf_cookie;
>         return 0;
>  }
>
>  static inline void perf_event_free_bpf_handler(struct perf_event *event)
>  {
> -       struct bpf_prog *prog =3D event->prog;
> +       struct bpf_prog *prog =3D event_prog(event);
>
>         if (!prog)
>                 return;
> @@ -9707,7 +9716,7 @@ static int __perf_event_overflow(struct perf_event =
*event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> +       if (!bpf_overflow_handler(event, data, regs))
>                 return ret;
>
>         /*
> @@ -12026,10 +12035,10 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
>                 if (parent_event->prog) {
> -                       struct bpf_prog *prog =3D parent_event->prog;
> +                       struct bpf_prog *prog =3D event_prog(parent_event=
);
>
>                         bpf_prog_inc(prog);
> -                       event->prog =3D prog;
> +                       event->prog =3D parent_event->prog;
>                 }
>  #endif
>         }

