Return-Path: <bpf+bounces-18825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB41822565
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A421C22BDC
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DD17752;
	Tue,  2 Jan 2024 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMgKZl3e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EF1773F;
	Tue,  2 Jan 2024 23:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F8DC4339A;
	Tue,  2 Jan 2024 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704237025;
	bh=cdt3nYEybKmQbfM3ySTBLTkjCOPXxwLzf6bFeEjafcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MMgKZl3euaIgRS/rdh3jsKLdafUBcRNE+EkY06ex3veFvlpzzUZQeHr2pi3Lp2p72
	 70/dCGRnNy/fxoN1jEjUvsH5YYQReOflkBhLznZF+z2xAvcOXC4eJOFC5wvrnC8fuG
	 s0gcaVOkXC1KWRsNSIDEcXwgRUXlWDHoeVzmfNHa1UjQo+5DO/PbHM4llvbRKEqqve
	 J/t4fmsmRpc7jI40g/Ln4j3FzslxaAxtshBB1kBp9KiweeNov3w0d5K2S1CoKhJcyx
	 80YsMwMWWJWnuumbwguUAyNwkHNODVWnZcUlJqOiG5JDsZsr8DFg14PVW6W0jx49Tp
	 WvWeE+8UgUhRQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd10001532so13787051fa.0;
        Tue, 02 Jan 2024 15:10:25 -0800 (PST)
X-Gm-Message-State: AOJu0YyN4wxlin9LAoP0L1SUsiw1Zz7PKF36LaK6FT69/FXYa1AhuuXD
	c5mYcfWaJwkdNP82JEuKSn2yXg71GBnDaVBeLE8=
X-Google-Smtp-Source: AGHT+IGtnX18WgYlYa1vpaBEduY4eYsvnvFQfTN9PsRZW/1ElLKF2X7/aKToZAIphSI2szJV3jjgcphjxUuGyUBZdMs=
X-Received: by 2002:a05:6512:b83:b0:50e:6909:7f68 with SMTP id
 b3-20020a0565120b8300b0050e69097f68mr10274917lfv.117.1704237023754; Tue, 02
 Jan 2024 15:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-4-khuey@kylehuey.com>
In-Reply-To: <20231211045543.31741-4-khuey@kylehuey.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 15:10:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6yhHQ1WRx5jXN3M=Bx3t=OdRY3V+DGcLFU8y-MJS3QLA@mail.gmail.com>
Message-ID: <CAPhsuW6yhHQ1WRx5jXN3M=Bx3t=OdRY3V+DGcLFU8y-MJS3QLA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] perf/bpf: Allow a bpf program to suppress all
 sample side effects
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

On Sun, Dec 10, 2023 at 8:56=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> Returning zero from a bpf program attached to a perf event already
> suppresses any data output. Return early from __perf_event_overflow() in
> this case so it will also suppress event_limit accounting, SIGTRAP
> generation, and F_ASYNC signalling.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/events/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 54f6372d2634..d6093fe893c8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9541,6 +9541,11 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (event->prog && !bpf_overflow_handler(event, data, regs))
> +               return ret;
> +#endif
> +
>         /*
>          * XXX event_limit might not quite work as expected on inherited
>          * events
> @@ -9590,10 +9595,7 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>                 irq_work_queue(&event->pending_irq);
>         }
>
> -#ifdef CONFIG_BPF_SYSCALL
> -       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> -#endif
> -               READ_ONCE(event->overflow_handler)(event, data, regs);
> +       READ_ONCE(event->overflow_handler)(event, data, regs);
>
>         if (*perf_event_fasync(event) && event->pending_kill) {
>                 event->pending_wakeup =3D 1;
> --
> 2.34.1
>
>

