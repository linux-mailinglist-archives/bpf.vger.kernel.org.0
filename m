Return-Path: <bpf+bounces-29544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1568C2BE8
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D40283566
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6113B7B2;
	Fri, 10 May 2024 21:30:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122711BDC8;
	Fri, 10 May 2024 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376611; cv=none; b=V4UqNVcfFjqSOe8CGkEi7lgKasbG3C+LYjCVkqH8ZyQSJ2/LZiI4ToA+1VAPs8GA9wtlgnkapE8GRet/Kf6+k1QEQaZGaMIRhntLNi8s9prYVS5wIIv7MRRRZID75t5Q8d7578rhSyQebUxVKuaQS6krWD2Qyp73n4iTRpKYUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376611; c=relaxed/simple;
	bh=eS1QIdyLTdFWFAB2PrpvAfGPAebgZ8VSah0rayF6MeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVOMbY96HvfY0jetv/y+CY40lU4asbmSyqZ0r0WpzniUiNcGuUaTGuAtEg+JqmnmXVyxu6qSjTTrENGv2IUYhs+LIo2Ni6mH4xXX4Rf/C++YzBJosGLT0qfySOXyD2OWc6KruS1JW+O0y1cb9hzWgXEdbbCBiA48+P8OqLI1BmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b36232fa48so1943598a91.1;
        Fri, 10 May 2024 14:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376609; x=1715981409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMAf5rKeg6w+VI/gIYLoiifCQecVQKRvthW/4/8BwYI=;
        b=R5O/sUHHIYW/puUQkGVtrc9X+AkD8yk67JDKaV78ke35tW1LKwYaBh+AvsvqMnogVH
         RssM/edkdBC0BsA65H57j186FbtnKzxx5qdqxTe8tVSA/FkjWdVpWdrBwfgk5voS8rL0
         Cql2jEWEk22Vir1tqBGvpSQeDSabwJNf29TIb/vKCVGiN3mlHtM4k+/R4JmFwGORUVTn
         ENp1+dTvB3qj2V0WTwBuFj35k6Z8Idj1ZcBA5CDCXjUfklqhekIw7/xol91ydKIpNhNM
         msAKy+Lf7mctms0itQSzDTnTE1ZO1EyLmyuQmIrE935ysxMsdnODXfFfjQpgO/GwSBbr
         azmA==
X-Forwarded-Encrypted: i=1; AJvYcCXUD0ebiNAJrRg+goAfOkwdeEhKAKaEbc3Z9FNj0TZpj3ET5zxSita+Z97ic+isOTBu6OHsJdwltZC9tTX9m9XXVYv/P272QkqeAxahImhm3r0wqS0stBUyVWsYAN01hOpEYisL/82e5o8LJGqes5yGnAKb1vu8PG4wFSEvvNZ8lGTXDg==
X-Gm-Message-State: AOJu0YyW5Xwp8n59q52xxJKzakjwT1+kxTWKaqrlZQ2kO0Fsw0SZX738
	pNcdAUcY48ISxh3a7BYql+aqOw+YN2/YjRxNZTJHNXsjE943+Xfl4KSlLQTGpaVojrxWsK7CuBn
	VCyE4ypCdn8CAzU8sZtZrRHSiVqE=
X-Google-Smtp-Source: AGHT+IFZkbSenvkLhokyv4EMxK86TWp9XlqSlcLUgh3x5kwN3NGOIxUQGzTPrJdFy06QmvA9W3LCymPfU5Y4Ft3Wj+I=
X-Received: by 2002:a17:90a:296:b0:2b3:463d:992b with SMTP id
 98e67ed59e1d1-2b6ccef6431mr3678869a91.42.1715376609286; Fri, 10 May 2024
 14:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-4-yabinc@google.com>
In-Reply-To: <20240510191423.2297538-4-yabinc@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 10 May 2024 14:29:58 -0700
Message-ID: <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] perf/core: Check sample_type in perf_sample_save_brstack
To: Yabin Cui <yabinc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:14=E2=80=AFPM Yabin Cui <yabinc@google.com> wrot=
e:
>
> Check sample_type in perf_sample_save_brstack() to prevent
> saving branch stack data when it isn't required.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Yabin Cui <yabinc@google.com>

It seems powerpc has the similar bug, then you need this:

Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper")

Thanks,
Namhyung

> ---
>  arch/x86/events/amd/core.c |  3 +--
>  arch/x86/events/core.c     |  3 +--
>  arch/x86/events/intel/ds.c |  3 +--
>  include/linux/perf_event.h | 13 ++++++++-----
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 985ef3b47919..fb9bf3aa1b42 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -967,8 +967,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs=
)
>                 if (!x86_perf_event_set_period(event))
>                         continue;
>
> -               if (has_branch_stack(event))
> -                       perf_sample_save_brstack(&data, event, &cpuc->lbr=
_stack, NULL);
> +               perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, =
NULL);
>
>                 if (perf_event_overflow(event, &data, regs))
>                         x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5b0dd07b1ef1..ff5577315938 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1702,8 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>
>                 perf_sample_data_init(&data, 0, event->hw.last_period);
>
> -               if (has_branch_stack(event))
> -                       perf_sample_save_brstack(&data, event, &cpuc->lbr=
_stack, NULL);
> +               perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, =
NULL);
>
>                 if (perf_event_overflow(event, &data, regs))
>                         x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index c2b5585aa6d1..f25236ffa28f 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1754,8 +1754,7 @@ static void setup_pebs_fixed_sample_data(struct per=
f_event *event,
>         if (x86_pmu.intel_cap.pebs_format >=3D 3)
>                 setup_pebs_time(event, data, pebs->tsc);
>
> -       if (has_branch_stack(event))
> -               perf_sample_save_brstack(data, event, &cpuc->lbr_stack, N=
ULL);
> +       perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
>  }
>
>  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 8617815456b0..ecfbe22ff299 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1269,6 +1269,11 @@ static inline void perf_sample_save_raw_data(struc=
t perf_sample_data *data,
>         data->sample_flags |=3D PERF_SAMPLE_RAW;
>  }
>
> +static inline bool has_branch_stack(struct perf_event *event)
> +{
> +       return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
> +}
> +
>  static inline void perf_sample_save_brstack(struct perf_sample_data *dat=
a,
>                                             struct perf_event *event,
>                                             struct perf_branch_stack *brs=
,
> @@ -1276,6 +1281,9 @@ static inline void perf_sample_save_brstack(struct =
perf_sample_data *data,
>  {
>         int size =3D sizeof(u64); /* nr */
>
> +       if (!has_branch_stack(event))
> +               return;
> +
>         if (branch_sample_hw_index(event))
>                 size +=3D sizeof(u64);
>         size +=3D brs->nr * sizeof(struct perf_branch_entry);
> @@ -1665,11 +1673,6 @@ extern void perf_bp_event(struct perf_event *event=
, void *data);
>  # define perf_arch_bpf_user_pt_regs(regs) regs
>  #endif
>
> -static inline bool has_branch_stack(struct perf_event *event)
> -{
> -       return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
> -}
> -
>  static inline bool needs_branch_stack(struct perf_event *event)
>  {
>         return event->attr.branch_sample_type !=3D 0;
> --
> 2.45.0.118.g7fe29c98d7-goog
>

