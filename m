Return-Path: <bpf+bounces-22116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7885724C
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 01:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A571F24091
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 00:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A228F5;
	Fri, 16 Feb 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkkyzQAI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE1170;
	Fri, 16 Feb 2024 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042316; cv=none; b=jS9ewHOK7aYRjOglm9O33mvaFM9Vlsj8lNgbtBKDhJ+iapwMarYudDd4Py1OVdqIplXI65trEOY0LPCet70iAFYy+b6V5J8my9+FoFQbhUbuMjTd3FzdUGnwkc0j/GuYlWsLZXfjYtQOZoHIYMVEQDemEUqdYTI0QO5imHvHEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042316; c=relaxed/simple;
	bh=F+B9CWHQoXM/3CVWDT8Du9ciplR2a1Pk+BKGIJYiqus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI7YX9Re/sN1mYalo5zkR3FsVtjJvPZVaMz1c5wuDKSRyLVvvts3B0vH2rXKjMPThoQkvbIIsIXjcHkoFmV/kk7YiNxNEsxKvxOA4EFdhXlGj5wwI9r/xPLoQESJEEDQ1COgCTblWkoMH+QJckdnI9AmUp9thyn/CEdBwNDifzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkkyzQAI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-296d26db6aaso1065048a91.1;
        Thu, 15 Feb 2024 16:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708042314; x=1708647114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8P+Esqb3vOTsAokX1aWIvQbUbsCyNuNLfr6EeZzaz8=;
        b=jkkyzQAIEf1k0JnT+6cWxDV9pKVo4SqR1csPbYLKs6Vnd5Sq83yq1y2BjHu4TRc85+
         C59XUcQvFUcrwUumbclixXCvJ78+hXO51iK4d4FDqJObmFFojPONSi54K0KWo51uxJfK
         El+b2bAmActhjy6Q1fe1Jff6SHKDfWvDWSh2gRgC3Ns6Cm4Y3H3ttrd4fwCz09IzbYzX
         IfL4o16ortOTtGa4UrRMAs59L8c+zSrFRJ7KnfgxbRYrGGxVrjGu+zihf5snswwsBrDQ
         X+c1jOReCGelnrbbUFW561cESKKlip1q1EAvlagRrz+FMeIOfFTxwmd+6PhXyHD70Nli
         YRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042314; x=1708647114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8P+Esqb3vOTsAokX1aWIvQbUbsCyNuNLfr6EeZzaz8=;
        b=EHNDj73rV0FodBq5Fv6wPYBIopH3EeMu/FAkJW4moMRXOGlgoos4iVPXxvOp3hw+Sp
         gi4tACgSq1kYW1vK+wtfYwJVo4SD1Q3jP1qoTi+9yYvqE4HYjuNNniY/u/VOrpTFIYBP
         T0Ef/EjH7DihReDaEnar3EgHCERLWehvzaTpIJsOHbhL9C1aNQtw2niDlSxkvpSGwj2w
         Xv7pOKIGXF8NWPc6oeL9w/1E0U8WYjWssjftaPJoVbkjjYcYCaZ0VN45IsE3Lt4sJEES
         QdUgh/aw1eT97E7fU7mm3IQG9bWdgFsJAlsu9e5QPxVB83c4TJmGkZz4DFDEJqpBEcK7
         Rnkw==
X-Forwarded-Encrypted: i=1; AJvYcCVDaKjXNexl2nMoRHKx3PwBfVnoq6hX8N1GxaO1AfpuuKc5zjPAA6z/UuyQzsFIJZAHeJZipRF87oy1QrJka4GBLrr3Q+NJVCo9VcOH3AC8QTi+xFYk0RtBpvl2s7KrUSNaTljPbzsVQoZBVV++RidndYbDnid/loQzYKmsOy+1ljCZ6Q==
X-Gm-Message-State: AOJu0YwG1vOoV+iaxwsSvGqAuzJLtFycro6kMW34NH6gKYYxHfNq00HY
	eMrXM/rRObC2KUHfx7Y4BT7qXvXjcmlQ+MMg33toac5oCV730ZTwCtaNL1anhBInmedXosE+DeK
	X/bHMp1ERxMzkz6cBg6L3o4zpk1g=
X-Google-Smtp-Source: AGHT+IF8AviHrDh9TwJh0tEpQSHtrLsd14RmJKWHdSCHA7nVKd5uVkNGmUc2lOqxawg+emCIcOo1SVnR1gLnjyIAnEM=
X-Received: by 2002:a17:90a:db17:b0:298:e89f:72f7 with SMTP id
 g23-20020a17090adb1700b00298e89f72f7mr3236729pjv.8.1708042314198; Thu, 15 Feb
 2024 16:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214173950.18570-1-khuey@kylehuey.com> <20240214173950.18570-2-khuey@kylehuey.com>
In-Reply-To: <20240214173950.18570-2-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 16:11:42 -0800
Message-ID: <CAEf4BzZu_7XRqKcJnM7qwaG=RPDv6fq8=qP4q-gVTkAP=uV=UQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 1/4] perf/bpf: Call bpf handler directly, not
 through overflow machinery
To: Kyle Huey <me@kylehuey.com>
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

On Wed, Feb 14, 2024 at 9:40=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> To ultimately allow bpf programs attached to perf events to completely
> suppress all of the effects of a perf event overflow (rather than just th=
e
> sample output, as they do today), call bpf_overflow_handler() from
> __perf_event_overflow() directly rather than modifying struct perf_event'=
s
> overflow_handler. Return the bpf program's return value from
> bpf_overflow_handler() so that __perf_event_overflow() knows how to
> proceed. Remove the now unnecessary orig_overflow_handler from struct
> perf_event.
>
> This patch is solely a refactoring and results in no behavior change.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/perf_event.h |  6 +-----
>  kernel/events/core.c       | 28 +++++++++++++++-------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a..c7f54fd74d89 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -810,7 +810,6 @@ struct perf_event {
>         perf_overflow_handler_t         overflow_handler;
>         void                            *overflow_handler_context;
>  #ifdef CONFIG_BPF_SYSCALL
> -       perf_overflow_handler_t         orig_overflow_handler;
>         struct bpf_prog                 *prog;
>         u64                             bpf_cookie;
>  #endif
> @@ -1357,10 +1356,7 @@ __is_default_overflow_handler(perf_overflow_handle=
r_t overflow_handler)
>  #ifdef CONFIG_BPF_SYSCALL
>  static inline bool uses_default_overflow_handler(struct perf_event *even=
t)
>  {
> -       if (likely(is_default_overflow_handler(event)))
> -               return true;
> -
> -       return __is_default_overflow_handler(event->orig_overflow_handler=
);
> +       return is_default_overflow_handler(event);
>  }
>  #else
>  #define uses_default_overflow_handler(event) \

and so in both cases uses_default_overflow_handler() is now just
is_default_overflow_handler(), right? So we can clean all this up
quite a bit?

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0f0f71213a1..24a718e7eb98 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9548,6 +9548,12 @@ static inline bool sample_is_allowed(struct perf_e=
vent *event, struct pt_regs *r
>         return true;
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static int bpf_overflow_handler(struct perf_event *event,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs);
> +#endif
> +
>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -9617,7 +9623,10 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>                 irq_work_queue(&event->pending_irq);
>         }
>
> -       READ_ONCE(event->overflow_handler)(event, data, regs);
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> +#endif
> +               READ_ONCE(event->overflow_handler)(event, data, regs);

This is quite hard to follow... And that CONFIG_BPF_SYSCALL check
breaking apart that if statement is not great. Maybe something like:


bool skip_def_handler =3D false;

#ifdef CONFIG_BPF_SYSCALL
    if (event->prog)
        skip =3D bpf_overflow_handler(event, data, regs) =3D=3D 0;
#endif
    if (!skip_def_handler)
        READ_ONCE(event->overflow_handler)(event, data, regs);

we can of course invert "skip" to be "run" and invert conditions, if
that's easier to follow

>
>         if (*perf_event_fasync(event) && event->pending_kill) {
>                 event->pending_wakeup =3D 1;
> @@ -10427,9 +10436,9 @@ static void perf_event_free_filter(struct perf_ev=
ent *event)
>  }
>
>  #ifdef CONFIG_BPF_SYSCALL
> -static void bpf_overflow_handler(struct perf_event *event,
> -                                struct perf_sample_data *data,
> -                                struct pt_regs *regs)
> +static int bpf_overflow_handler(struct perf_event *event,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs)
>  {
>         struct bpf_perf_event_data_kern ctx =3D {
>                 .data =3D data,

[...]

