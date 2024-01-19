Return-Path: <bpf+bounces-19873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC7832427
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 06:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B7284A3B
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 05:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8B4A12;
	Fri, 19 Jan 2024 05:14:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DEA63DF;
	Fri, 19 Jan 2024 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705641281; cv=none; b=tRnEaAWmuF7F3YW9SJKIRkarQ2+VPt5iMKWSItl2beUTCD3iVPmmRSOeFufwFGocKWbpU5LQEMEq2PX/Dr1jQ7lsPUbIwANK/ohKkIPVAf5piiUVzrUYQ7YKAavkjXGhTzav0aE3HZ5eK02Af0MfUBmiswsTzwQeWBXNkmol8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705641281; c=relaxed/simple;
	bh=gxSzQTf6jmvbBw8nozGpd8UPCbitPnoQAkYe8hXwxzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6FNoxrUUQyEDi8bPmDJzVglTei79cUkAbGIjnWO3AKtjFfNRFORcK3J27btLp0dSiS53CBrNxQrYTHQdqjJLYubsq67P7e3UlWH66+ThiggV1Mv0l+UtII9wT5fRgElFZqvvQBBaFnb/yLzptyG6Lna6ujvWv+rj3pEpFC++20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2904d8c29d2so107402a91.2;
        Thu, 18 Jan 2024 21:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705641279; x=1706246079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Heknx9B9Mq2DzjyZ9n1MXLrOGgOlHXA+fVx4XEJEn/0=;
        b=CYbMyxcmXowrS52QWvD/8JevCnO7/i+Pbkz/42BPI+wM6YehzfX9dGmjK6y8HCCP6W
         QG9ztqDB5lpqBHjz7UZJl+fIHLGLmTx3viNV0KrDRxmA55FlAicvG1aA5j2msJdztPH5
         4kK+YYiamk1cmkh2u6aqcKkHKC6q6d0kpo5vpNssviA8Szq28gCjLhB+Rq656W/kW5yy
         SfFZdTDZSyzZKnXaLGQHgM+TsX4/84O2Da2YqqdOegFc7meNAYWpAU48Bo9xRgxS2jzd
         Oyhc4ee1yfanyEnuqr0rurE0Wz6ZASD4tsrfcsHuaGnT/z5eDBnfTfkcyFPwKss6ihjE
         Ie/A==
X-Gm-Message-State: AOJu0Yx5mBax5oksczVgQbVE0rSCb2AzoBpY1zSec5RJZm6P62FvUdxH
	BCIdoH29b9UBIafnwSwYMf//PzRo+BOerwy/E8sxHgsAzhJD84m/sMKpL0Cc1FtRLsSbSmCAV1+
	6xz2o4VWf79jS5kfruZJUskhdg7A=
X-Google-Smtp-Source: AGHT+IEx04eW1wXaAKULD9Iv+dN8GjXTCGGwNL09a3nQ8jcBhD8NNbebPOh7vIxUq5iQSikVmgxSPzQvDqrlsxNVMhI=
X-Received: by 2002:a17:90a:242:b0:28e:79cf:f1f1 with SMTP id
 t2-20020a17090a024200b0028e79cff1f1mr1562868pje.80.1705641279389; Thu, 18 Jan
 2024 21:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119001352.9396-1-khuey@kylehuey.com> <20240119001352.9396-4-khuey@kylehuey.com>
In-Reply-To: <20240119001352.9396-4-khuey@kylehuey.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 18 Jan 2024 21:14:27 -0800
Message-ID: <CAM9d7cgK_uKtPk_pz6WTCUNdaQWdLg=e3oq6Ah3fG8=DzxN+0g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf/bpf: Allow a bpf program to suppress all
 sample side effects
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Marco Elver <elver@google.com>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 18, 2024 at 4:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> Returning zero from a bpf program attached to a perf event already
> suppresses any data output. Return early from __perf_event_overflow() in
> this case so it will also suppress event_limit accounting, SIGTRAP
> generation, and F_ASYNC signalling.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Acked-by: Song Liu <song@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  kernel/events/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 24a718e7eb98..a329bec42c4d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9574,6 +9574,11 @@ static int __perf_event_overflow(struct perf_event=
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
> @@ -9623,10 +9628,7 @@ static int __perf_event_overflow(struct perf_event=
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

