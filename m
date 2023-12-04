Return-Path: <bpf+bounces-16649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B401D80418A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E65B1F2137A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6853AC1B;
	Mon,  4 Dec 2023 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAADVfoC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E2A1;
	Mon,  4 Dec 2023 14:19:03 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a195a1474easo485966366b.2;
        Mon, 04 Dec 2023 14:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728342; x=1702333142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYU4akPtvFm5xz51DoEaDieWeepv6tFYyNIW+3QSnxY=;
        b=KAADVfoCnlfXgN3YXaoXrYBMr9E/Xw9hYBXS3OriU0jVISiciHhp9PPVxypPa5oXYC
         K5AtwUSJfY4E4d3LN5apBONlehklpHhbR/GXXwtgOWIq+FBtNS69/B6Da84d/6rZcW+F
         D1DQevQnQcPZxFFX1oFFabYWvVobAXEbOQGvacyKe9BFn/Srgxdq/qJHbsqbs2vvKgzo
         jBRLqY/SsjvjuOU+2IgUCc+vJa7+4taGHZNha3Ol2ClEob0pyPCRALFCsaT0kKSrt3Y0
         TVGck94E+EAu7lzr2z8QSG0QBg5CruLdrTNhzA8pvSERDz+BCT8QER1gIHd+3Mo8KEsX
         7uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728342; x=1702333142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYU4akPtvFm5xz51DoEaDieWeepv6tFYyNIW+3QSnxY=;
        b=RkIBqva/FQA3Jh7KD6zeFUjOXEEdZAuOOSsi8YES6OCQv2V5Ynky/JOC/Kg2HQcPnT
         iTFJQUeotxgvN913KP8D/xLy50o/bih2b14D9BO1SWHRP5UFpG/gY/IZWhr1zV8VM3n2
         DUnRQXgwdNKf9uG6/Z+hS9X2AIko+dPLJu+i0Pj6iol5b2S4LSRs5SPGZcVciN8hnebP
         59wRv8c4OmIZU2O5y8IbuAGYfMIKa+MhejcXvxtR3O3UD6EpN6pCC5k0nXis8Yo1wjVx
         pm9Rgtfaa3ty4Rrz1jSl1zXEjKKyVbXFtVbRemBW+rvMQFA/1LY1XOfGRTFi387FPY/d
         OUDw==
X-Gm-Message-State: AOJu0Yzszh034Ld4JAjOJSi63pkUlCczKr+OhxDXJDa311NtTSDKysh1
	9fmCBBA66sx31j8mhhS13i78lMnS6Z7jjuXZ2RE=
X-Google-Smtp-Source: AGHT+IEUZ+QSuNnw8O1+WRVAZOBAh2DXCAeWzoNnFv6EZ2T0JW6+vdpFkUMQxb0FJen0reFAn0mooykfJNdC5uyVxwc=
X-Received: by 2002:a17:906:51c5:b0:a12:635d:fcd1 with SMTP id
 v5-20020a17090651c500b00a12635dfcd1mr519128ejk.35.1701728341626; Mon, 04 Dec
 2023 14:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
In-Reply-To: <20231204201406.341074-2-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Dec 2023 14:18:49 -0800
Message-ID: <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> Returning zero from a bpf program attached to a perf event already
> suppresses any data output. This allows it to suppress I/O availability
> signals too.

make sense, just one question below

>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b704d83a28b2..34d7b19d45eb 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct perf_eve=
nt *event,
>         rcu_read_unlock();
>  out:
>         __this_cpu_dec(bpf_prog_active);
> -       if (!ret)
> +       if (!ret) {
> +               event->pending_kill =3D 0;
>                 return;
> +       }

What's the distinction between event->pending_kill and
event->pending_wakeup? Should we do something about pending_wakeup?
Asking out of complete ignorance of all these perf specifics.


>
>         event->orig_overflow_handler(event, data, regs);
>  }
> --
> 2.34.1
>
>

