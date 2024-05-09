Return-Path: <bpf+bounces-29228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83A8C1598
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555FE1F221F9
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D657FBBE;
	Thu,  9 May 2024 19:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65C7E583;
	Thu,  9 May 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283922; cv=none; b=EcFhmBZz7eWQEYtpYciQIBVMVhTk0xhxnn6acwocLHAJPrE1PDtRV2vL9YkKvYDh4rHzqbPgZGO+Gz4PxJ7/9sVQlfUTv9+JG6iBuSI3kRcv/h8p/MCOzyqsHLWjCPYXW7MIpLxQnPAae4BVhfsY7Pti8tAdOieTFoPokLV/cM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283922; c=relaxed/simple;
	bh=PADhBWwzIvV+KcMYknF6nguY74DMj0qhRPGeCokk5XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Idu+F3umCLsZkdXetFtxXhJFElxlE/vcF/+dH14pt+oT48ZgCE9Y4uwKHVRX0mHeED2pJXzJF7vMSqb/q9V6uQq5Z0JK7JM7eDTueIrPX9pQr8LQzenc+19K4fWE+WqgYBFFnn+U0nc0i6ahT4pGFhOsr+UMPTyQp1xDLmevp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so849026a12.0;
        Thu, 09 May 2024 12:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715283920; x=1715888720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjFpFxlZq5IzKOtG9JnnZmqQAVF+8NQXdt9aFMsAxpY=;
        b=FCOwL+r+1D7fPMyO5WzSgw7iiotk+mR6wSrNd6a1yLFVqhYJz2nwAJJs3/UqrsugsA
         IYnpvsBpFEzS/Ioy+zSiEomi2cPtdn7gA2o4PlBKxOuQRLxv45TAs7SNdgltWJRf2WKL
         AG1YefkZ7ly66urclerUgYz3SfrJgIVKcT5btltROhpmCbB64sj62H1vlt1omgbovxUt
         x/Ij6btX+dNGydEYu7eh6PVWhiHQ16g7w53BQz5ie79NE6rK3z5+eyrPIiQ7AKaQTXeE
         O61+XBCZvmxWujY2CD6/pT+VRj1FhneyqLzLwWGnhXnWpiY0qKKAx7lvOsALb2pL7rFz
         mKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoPAMoyFM/p9kMNgtKlueus2NQjSvJqwKPpVFV2tLSNNp9+wQqj2GIQwTtxxKNJZYFNQQ5E5tctPNVtuZmuwfxor1DFP9xlgImrcoD+/qfPhKc7+glH4mAm6EbgGeuNocv9zUX9fuA37Pnf071VexT+2Ar+MCMUsxk8Pg3Vlyb7kpPgQ==
X-Gm-Message-State: AOJu0YwwwzjTbSwV48FGdDZxTva4OoOtzOlVf+bYCvBMIeWg4A9V+1jp
	qOHEcYUPx72Ewa2eB2jtZIdAH/y7967elQpvSt5jabI68H4HHKUEQTwEW8TQll+wVNN+5KJpeiJ
	Ofz1y+elqFc3HOHLmCVTRavU0HxE=
X-Google-Smtp-Source: AGHT+IEdAq35jjHOPKv3ygxw0++9RQ/dc5hcpeP2qnTH/zTrDWZpO7uMAd3iGsPvW0Ncmwri2RrQay06I+W/ldenb60=
X-Received: by 2002:a17:90a:51a2:b0:2b4:329e:e373 with SMTP id
 98e67ed59e1d1-2b6cc45030bmr532105a91.6.1715283919743; Thu, 09 May 2024
 12:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502000602.753861-1-yabinc@google.com>
In-Reply-To: <20240502000602.753861-1-yabinc@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 9 May 2024 12:45:08 -0700
Message-ID: <CAM9d7cj2WUdbXz1E4kQCYY=7tO+C9XXQidMJuQNp=WP6dudLkw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Save raw sample data conditionally based on
 sample type
To: Yabin Cui <yabinc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 1, 2024 at 5:06=E2=80=AFPM Yabin Cui <yabinc@google.com> wrote:
>
> Currently, space for raw sample data is always allocated within sample
> records for both BPF output and tracepoint events. This leads to unused
> space in sample records when raw sample data is not requested.

Oh, I thought it was ok because even if it sets _RAW bit in the
data->sample_flags unconditionally, perf_prepare_sample() and
perf_output_sample() checks the original event's attr->sample_type
so the raw data won't be recorded.

But I've realized that it increased data->dyn_size already. :(
Which means the sample would have garbage at the end.

I need to check if there are other places that made the same
mistake for other sample types.

>
> This patch checks sample type of an event before saving raw sample data
> in both BPF output and tracepoint event handling logic. Raw sample data
> will only be saved if explicitly requested, reducing overhead when it
> is not needed.
>
> Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper")
> Signed-off-by: Yabin Cui <yabinc@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>
> Changes since v1:
>  - Check event->attr.sample_type & PERF_SAMPLE_RAW before
>    calling perf_sample_save_raw_data().
>  - Subject has been changed to reflect the change of solution.
>
> Original commit message from v1:
> perf/core: Trim dyn_size if raw data is absent
>
>  kernel/events/core.c     | 37 ++++++++++++++++++++-----------------
>  kernel/trace/bpf_trace.c | 12 +++++++-----
>  2 files changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f..dc5f3147feef 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10120,9 +10120,9 @@ static struct pmu perf_tracepoint =3D {
>  };
>
>  static int perf_tp_filter_match(struct perf_event *event,
> -                               struct perf_sample_data *data)
> +                               struct perf_raw_record *raw)
>  {
> -       void *record =3D data->raw->frag.data;
> +       void *record =3D raw->frag.data;
>
>         /* only top level events have filters set */
>         if (event->parent)
> @@ -10134,7 +10134,7 @@ static int perf_tp_filter_match(struct perf_event=
 *event,
>  }
>
>  static int perf_tp_event_match(struct perf_event *event,
> -                               struct perf_sample_data *data,
> +                               struct perf_raw_record *raw,
>                                 struct pt_regs *regs)
>  {
>         if (event->hw.state & PERF_HES_STOPPED)
> @@ -10145,7 +10145,7 @@ static int perf_tp_event_match(struct perf_event =
*event,
>         if (event->attr.exclude_kernel && !user_mode(regs))
>                 return 0;
>
> -       if (!perf_tp_filter_match(event, data))
> +       if (!perf_tp_filter_match(event, raw))
>                 return 0;
>
>         return 1;
> @@ -10171,6 +10171,7 @@ EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
>  static void __perf_tp_event_target_task(u64 count, void *record,
>                                         struct pt_regs *regs,
>                                         struct perf_sample_data *data,
> +                                       struct perf_raw_record *raw,
>                                         struct perf_event *event)
>  {
>         struct trace_entry *entry =3D record;
> @@ -10180,13 +10181,18 @@ static void __perf_tp_event_target_task(u64 cou=
nt, void *record,
>         /* Cannot deliver synchronous signal to other task. */
>         if (event->attr.sigtrap)
>                 return;
> -       if (perf_tp_event_match(event, data, regs))
> +       if (perf_tp_event_match(event, raw, regs)) {
> +               perf_sample_data_init(data, 0, 0);
> +               if (event->attr.sample_type & PERF_SAMPLE_RAW)
> +                       perf_sample_save_raw_data(data, raw);
>                 perf_swevent_event(event, count, data, regs);
> +       }
>  }
>
>  static void perf_tp_event_target_task(u64 count, void *record,
>                                       struct pt_regs *regs,
>                                       struct perf_sample_data *data,
> +                                     struct perf_raw_record *raw,
>                                       struct perf_event_context *ctx)
>  {
>         unsigned int cpu =3D smp_processor_id();
> @@ -10194,15 +10200,15 @@ static void perf_tp_event_target_task(u64 count=
, void *record,
>         struct perf_event *event, *sibling;
>
>         perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu, pm=
u) {
> -               __perf_tp_event_target_task(count, record, regs, data, ev=
ent);
> +               __perf_tp_event_target_task(count, record, regs, data, ra=
w, event);
>                 for_each_sibling_event(sibling, event)
> -                       __perf_tp_event_target_task(count, record, regs, =
data, sibling);
> +                       __perf_tp_event_target_task(count, record, regs, =
data, raw, sibling);
>         }
>
>         perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, cpu, =
pmu) {
> -               __perf_tp_event_target_task(count, record, regs, data, ev=
ent);
> +               __perf_tp_event_target_task(count, record, regs, data, ra=
w, event);
>                 for_each_sibling_event(sibling, event)
> -                       __perf_tp_event_target_task(count, record, regs, =
data, sibling);
> +                       __perf_tp_event_target_task(count, record, regs, =
data, raw, sibling);
>         }
>  }
>
> @@ -10220,15 +10226,10 @@ void perf_tp_event(u16 event_type, u64 count, v=
oid *record, int entry_size,
>                 },
>         };
>
> -       perf_sample_data_init(&data, 0, 0);
> -       perf_sample_save_raw_data(&data, &raw);
> -
>         perf_trace_buf_update(record, event_type);
>
>         hlist_for_each_entry_rcu(event, head, hlist_entry) {
> -               if (perf_tp_event_match(event, &data, regs)) {
> -                       perf_swevent_event(event, count, &data, regs);
> -
> +               if (perf_tp_event_match(event, &raw, regs)) {
>                         /*
>                          * Here use the same on-stack perf_sample_data,
>                          * some members in data are event-specific and
> @@ -10238,7 +10239,9 @@ void perf_tp_event(u16 event_type, u64 count, voi=
d *record, int entry_size,
>                          * because data->sample_flags is set.
>                          */
>                         perf_sample_data_init(&data, 0, 0);
> -                       perf_sample_save_raw_data(&data, &raw);
> +                       if (event->attr.sample_type & PERF_SAMPLE_RAW)
> +                               perf_sample_save_raw_data(&data, &raw);
> +                       perf_swevent_event(event, count, &data, regs);
>                 }
>         }
>
> @@ -10255,7 +10258,7 @@ void perf_tp_event(u16 event_type, u64 count, voi=
d *record, int entry_size,
>                         goto unlock;
>
>                 raw_spin_lock(&ctx->lock);
> -               perf_tp_event_target_task(count, record, regs, &data, ctx=
);
> +               perf_tp_event_target_task(count, record, regs, &data, &ra=
w, ctx);
>                 raw_spin_unlock(&ctx->lock);
>  unlock:
>                 rcu_read_unlock();
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9dc605f08a23..4b3ff71b4c0a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -620,7 +620,8 @@ static const struct bpf_func_proto bpf_perf_event_rea=
d_value_proto =3D {
>
>  static __always_inline u64
>  __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
> -                       u64 flags, struct perf_sample_data *sd)
> +                       u64 flags, struct perf_raw_record *raw,
> +                       struct perf_sample_data *sd)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         unsigned int cpu =3D smp_processor_id();
> @@ -645,6 +646,9 @@ __bpf_perf_event_output(struct pt_regs *regs, struct =
bpf_map *map,
>         if (unlikely(event->oncpu !=3D cpu))
>                 return -EOPNOTSUPP;
>
> +       if (event->attr.sample_type & PERF_SAMPLE_RAW)
> +               perf_sample_save_raw_data(sd, raw);
> +
>         return perf_event_output(event, sd, regs);
>  }
>
> @@ -688,9 +692,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, r=
egs, struct bpf_map *, map,
>         }
>
>         perf_sample_data_init(sd, 0, 0);
> -       perf_sample_save_raw_data(sd, &raw);
>
> -       err =3D __bpf_perf_event_output(regs, map, flags, sd);
> +       err =3D __bpf_perf_event_output(regs, map, flags, &raw, sd);
>  out:
>         this_cpu_dec(bpf_trace_nest_level);
>         preempt_enable();
> @@ -749,9 +752,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, =
void *meta, u64 meta_size,
>
>         perf_fetch_caller_regs(regs);
>         perf_sample_data_init(sd, 0, 0);
> -       perf_sample_save_raw_data(sd, &raw);
>
> -       ret =3D __bpf_perf_event_output(regs, map, flags, sd);
> +       ret =3D __bpf_perf_event_output(regs, map, flags, &raw, sd);
>  out:
>         this_cpu_dec(bpf_event_output_nest_level);
>         preempt_enable();
> --
> 2.45.0.rc0.197.gbae5840b3b-goog
>

