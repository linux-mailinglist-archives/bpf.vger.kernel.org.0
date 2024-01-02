Return-Path: <bpf+bounces-18823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CEF82255E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1907F1C22B3D
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3217742;
	Tue,  2 Jan 2024 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtCoocYz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255FA1772C;
	Tue,  2 Jan 2024 23:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43A7C433C7;
	Tue,  2 Jan 2024 23:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704236742;
	bh=T6cXZag/Xy65XNlKPdc4AWtqQPyk9JHRqhKUCxsZsBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XtCoocYzHvo//7+EA3mfYWOHX9EIE0xClVk2Hh8KjUCHbOLySkNh6Uli8DsDZbysb
	 EYpN0fOqylv/K4teNG//cP1FVP4ZEozs8Zj7yP16QW+2uI7CvZix9wK0q3R/63nWSd
	 NEoEss9ZMalFTjKSc+FsPEYoj/+STjn7LQqgw3+tCVlJuMGLGKnqw7cMgUI6yAepE1
	 OcWo/a/qwYxQdmKR4icMTeHUCFY4Wgs9MalwiErq8eDF4OBEWxEz9KO/1LQjdXDFBE
	 KcWg/z5bcH7ni5qjF+OT6/QNKrEjIm1W8PxpLojC4XsUa47Zhf+xzFbmenLnGUyfPc
	 bgZIM7QBjH+xA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so1450898e87.0;
        Tue, 02 Jan 2024 15:05:42 -0800 (PST)
X-Gm-Message-State: AOJu0YyVQaBkLUBenTsZJq95GpUeYbAz65nNzwVui+0R3hZxt/uzoRX1
	XDunK48UHcQDhKJLJm/yibKW3uilSGJxEIznBKc=
X-Google-Smtp-Source: AGHT+IGBq5Wx9cuhkjxZD5vLlZHMjMLTYjOlb1oTEXQMYX/3bSwNfoIGP73Iy73kkhNHntatC/YNWTBCF4ehZeIdWZc=
X-Received: by 2002:a05:6512:3ba5:b0:50e:7d6b:b5b2 with SMTP id
 g37-20020a0565123ba500b0050e7d6bb5b2mr6487931lfv.6.1704236740865; Tue, 02 Jan
 2024 15:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-2-khuey@kylehuey.com>
In-Reply-To: <20231211045543.31741-2-khuey@kylehuey.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 15:05:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4s5ZaZB0kFz8CWK-NvS4KrE7w90Fzz-wF5WgUMC7dPog@mail.gmail.com>
Message-ID: <CAPhsuW4s5ZaZB0kFz8CWK-NvS4KrE7w90Fzz-wF5WgUMC7dPog@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] perf/bpf: Call bpf handler directly, not through
 overflow machinery
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 8:55=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
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
> ---
>  include/linux/perf_event.h |  6 +-----
>  kernel/events/core.c       | 28 +++++++++++++++-------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 5547ba68e6e4..312b9f31442c 100644
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
> @@ -1337,10 +1336,7 @@ __is_default_overflow_handler(perf_overflow_handle=
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
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b704d83a28b2..54f6372d2634 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9515,6 +9515,12 @@ static inline bool sample_is_allowed(struct perf_e=
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
> @@ -9584,7 +9590,10 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>                 irq_work_queue(&event->pending_irq);
>         }
>
> -       READ_ONCE(event->overflow_handler)(event, data, regs);
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))

This condition is hard to follow. Please consider simplifying it.

Thanks,
Song

> +#endif
> +               READ_ONCE(event->overflow_handler)(event, data, regs);
>
>         if (*perf_event_fasync(event) && event->pending_kill) {
>                 event->pending_wakeup =3D 1;
> @@ -10394,9 +10403,9 @@ static void perf_event_free_filter(struct perf_ev=
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
> @@ -10417,10 +10426,8 @@ static void bpf_overflow_handler(struct perf_eve=
nt *event,
>         rcu_read_unlock();
>  out:
>         __this_cpu_dec(bpf_prog_active);
> -       if (!ret)
> -               return;
>
> -       event->orig_overflow_handler(event, data, regs);
> +       return ret;
>  }
>
>  static int perf_event_set_bpf_handler(struct perf_event *event,
> @@ -10456,8 +10463,6 @@ static int perf_event_set_bpf_handler(struct perf=
_event *event,
>
>         event->prog =3D prog;
>         event->bpf_cookie =3D bpf_cookie;
> -       event->orig_overflow_handler =3D READ_ONCE(event->overflow_handle=
r);
> -       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
>         return 0;
>  }
>
> @@ -10468,7 +10473,6 @@ static void perf_event_free_bpf_handler(struct pe=
rf_event *event)
>         if (!prog)
>                 return;
>
> -       WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler)=
;
>         event->prog =3D NULL;
>         bpf_prog_put(prog);
>  }
> @@ -11928,13 +11932,11 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 overflow_handler =3D parent_event->overflow_handler;
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (overflow_handler =3D=3D bpf_overflow_handler) {
> +               if (parent_event->prog) {
>                         struct bpf_prog *prog =3D parent_event->prog;
>
>                         bpf_prog_inc(prog);
>                         event->prog =3D prog;
> -                       event->orig_overflow_handler =3D
> -                               parent_event->orig_overflow_handler;
>                 }
>  #endif
>         }
> --
> 2.34.1
>
>

