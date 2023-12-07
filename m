Return-Path: <bpf+bounces-17035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8BD809112
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 20:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E09A1C208F5
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B44F5F8;
	Thu,  7 Dec 2023 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQgnC7tV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0058E;
	Thu,  7 Dec 2023 11:12:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so4992206a12.1;
        Thu, 07 Dec 2023 11:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701976371; x=1702581171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBcbek6gttfppERWG6d3/hToWIBrJs6uRJTnr+Awj6E=;
        b=dQgnC7tV+Fpu5/5QqiQWj1jHqWtZe89H3xPDeXbIzL+fqcP4pk68pHeiiOdVSbJkg8
         mJdkWNmxmgQtkUG+gPHuhr5FFiljy9v+GuwK6wnc0Ar9a3WUHNWkXmur2SMAVzCxgk6k
         bPfj0c03laCraaK2YNu7j0aJWaZabOXttSPM3yhCWqXiWAUIMjR6SNYYisWGp4Xm4m6O
         0UVKsrzPqtSuOCxqcarcS3WdM4qpyLgua+62lYKYTLQE4+17gxZsHT9nV/ykC0+KwpbG
         0lW3guGBKiEtNy1OIb5LXsW7r7S/dJn4ms82NAbnj6YJPtcPtzB2n7o+0nuJNHmCFkKp
         NqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976371; x=1702581171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBcbek6gttfppERWG6d3/hToWIBrJs6uRJTnr+Awj6E=;
        b=DXOjEvFiTVkd5rfv1Y+w3kADj+PE95iQvJ4nALnbGuGZDvC5GtpU8MD8svELCwOIEs
         33GPy30tmG4zWrq9L0x9kJi/5FjZKzdq65RqU+K9ZQxdnH3PA8S37PUvS4bqkEnTvNh2
         HuN+A2d8uUsoBcevM2d6yVIJ40De1i5HPAeb/m+zgX5Kdcyexm62cXxZRWJKm/EIdqHo
         +7AsYPA7SkPv8jjcYqHGkv/NoU/XdiGFaKBBbEPhJx5GS48bnVnISLfB5cukKcRVcHwD
         IUjyIQeHYXKMR3UcFqKaf/9jiw2732lNeqycbkubDOcSk1R5s+xEebRfKuW081gVNmud
         YDHA==
X-Gm-Message-State: AOJu0YyUx/lVlnv6GGmZFQFldfYGZiTEBiY+Yue27b7YtS9m3++yD0mI
	Q3SW9uBiar4L5wAYSjU4uty01ynmUflEEI4GTolPQtMdBGE=
X-Google-Smtp-Source: AGHT+IHlWG5bKii7MvV2efsGC4HKRhhsZ5maBOhBSV/8S5dfwK9hpNSZOGn/4a9pAHw3z3+goSCLDK5cRl3DzSO6/SU=
X-Received: by 2002:a17:906:c10d:b0:9fa:7c87:b10a with SMTP id
 do13-20020a170906c10d00b009fa7c87b10amr6266158ejc.10.1701976371192; Thu, 07
 Dec 2023 11:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-3-khuey@kylehuey.com>
In-Reply-To: <20231207163458.5554-3-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 7 Dec 2023 11:12:38 -0800
Message-ID: <CAEf4Bza5LWs8nQhJ78QRAU78PU8DOjs5aZkbsgdggr_a+GdEjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf/bpf: Allow a bpf program to suppress all
 sample side effects.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> Returning zero from a bpf program attached to a perf event already
> suppresses any data output. By clearing pending_kill, returning zero from=
 a
> bpf program will effectively pretend the sample never happened for all
> userspace purposes.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 19fddfc27a4a..6cda05a4969d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10421,8 +10421,10 @@ static void bpf_overflow_handler(struct perf_eve=
nt *event,
>         rcu_read_unlock();
>  out:
>         __this_cpu_dec(bpf_prog_active);
> -       if (!ret)
> +       if (!ret) {
> +               event->pending_kill =3D 0;
>                 return;
> +       }
>
>         event->orig_overflow_handler(event, data, regs);
>  }
> --
> 2.34.1
>

