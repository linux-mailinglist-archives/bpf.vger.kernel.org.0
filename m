Return-Path: <bpf+bounces-79126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1356D27C99
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CAB7300151B
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EEA3C1FE7;
	Thu, 15 Jan 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0AHG3uU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365D3AA1A0
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502927; cv=none; b=o2pdBvHXJZBO0Y11RD/hcunooeFLYZdJsl+pn4Jm6V15WBMTH1WIXPFqocXUau3s7AdzAB0hS3bzv8aaORXBDAx5gPVsCwZUF1M+yie48gocQX3vVh5dMtUmShIgoFtsB1NyGl6C/1VdYXSoxAwKsYYG9zzV9g53v8OR2ODROJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502927; c=relaxed/simple;
	bh=UQrMhLzAWtEW2fNPRRa41ReV0ebPBQO/kw9fUUbSz0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lh6sKEfLKjdcBxdqLyB2S/WNWKfMWqy9Ia4dQySsEnHvkACPH7sDmGhtm6oMTByVI+xmM3+LUUwpjG/tj+GGoG9kxd4QkUCDVDWAvnK3u9wHFB3jaQVHv85yHFaMTYoI7lzGa1G6oaC5gAdqfPheEN+/1C0m/B2rk5qnCi62EE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0AHG3uU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso428069a12.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768502922; x=1769107722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHYgSO64FJPmGn4to5xXyL76aKmYw2DEo0/XWOgIEws=;
        b=h0AHG3uUeEJIndx/HnYM5H/I6laHcDhUX6XxYbe4JY1Ay8V2ZYekhnmjnafbo1C9++
         V+mB5AoZuubh2Qat2ouR82OTwnZME3mrzfriy4mHgq7ZI7bGERkQ4t6TvhPypPJ/zzci
         bht0lWFeCral/wwVd3wCiRuTgPN5Pd+RbYyYWP8laaKdCM5xrw1mY5Rpz7knQ6AkHJ8M
         cNF/4fSi5uoRJSrsfTsSoPZXQya8az17I1Usg69RAchJTuxgM7utGql1i+iDJIrLh41W
         9TmFLBzu2sozIY5nyBoJxuc5yt31b3JQWN7N8DR6M0fhwbb4SEPZFAt+xV+JOxVsEMBZ
         X/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502922; x=1769107722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHYgSO64FJPmGn4to5xXyL76aKmYw2DEo0/XWOgIEws=;
        b=P0uOYSvMfyVI4dvvOn7WPHvWEx8ShxKepVcOXgM6DhabI7Hl4ogst+asUWgHUb8Ykq
         UWRaiMM51qei9CWzEbPK7QJ6tz7jukEPME0RwamLrgnASCe9CTuVkCnvpDShjIGC1v51
         xAqL7v5OhUb2ijLLCWUmN/Xul6B1B3ZYDWXIAYfacxmEyUWbosP9b28cuYJeakp/Oe+8
         gl5lKwwv9BSHCgQXOcPK58YCLwSR6ox94EEdp6ymV5ZWA7SeVlMVtsLzod7oZaHNTSAH
         8k4D2K/zpfe66GWkkv69oQWnmhQmIM4cSIQePTOL1gmyD7mqRPEArwX8rj7X44kdfXCY
         hOgA==
X-Forwarded-Encrypted: i=1; AJvYcCVAXjxRTJisD+zucZFYStEH+uIxKJVwA+P8gXXwrAA7A8LcSe8jH/89A8r8zthATOZTw/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza01pIDpB8DFwY3IDYGGSvshhOrHG5NzZHkeLFHXPxQw66AXQp
	CKJSadB5X5GEqOrvGLoY60r/9QXmjwFDtERIzKlj4iuyocPo6ZzLQTzyZtqI9ZSWUwgnF17Maxq
	tlk1Qjz/VHkn82srd8zOsw1F+1wjtNA4=
X-Gm-Gg: AY/fxX4qH8Nh48I3//XVIkfp6mQTPfdyToxQdtHFKom/sQp7+z9zMO7/A8n5dJlODe2
	61w6bXEFwRrIzeQlEDnyGw5ycMmGDYv+Koc/Ixusw3hqzHYgeK8blR4uA/w8U0sYShKyRgimIDh
	Fmxa0XnPCgJbDluOeJOwMQRnK3FMSbZfIulT3ddFNjfLGsfPntLhQoHE/vtPXDCz/Nq3jWZFCHF
	2dRdZTQZ3qDG4JHWjF2TKp1H7KuET1Yl6koB8L3x3f/DnBV6qGuq+npb4TWZb8n4QJlT5eW+EGP
	m3aGNxXJ
X-Received: by 2002:a17:90b:4a44:b0:340:be44:dd0b with SMTP id
 98e67ed59e1d1-35273298af9mr230008a91.34.1768502921893; Thu, 15 Jan 2026
 10:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112214940.1222115-1-jolsa@kernel.org> <20260112214940.1222115-5-jolsa@kernel.org>
In-Reply-To: <20260112214940.1222115-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 10:48:29 -0800
X-Gm-Features: AZwV_QjX7VrTUtsAMUBt5BaayEmgkKUeqnOB-9FMhVngm8sFa5SmN6zLgjvUsfQ
Message-ID: <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Allow to benchmark trigger
 with stacktrace
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 1:50=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to call bpf_get_stackid helper from trigger programs,
> so far added for kprobe multi.
>
> Adding the --stacktrace/-g option to enable it.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c            |  4 ++++
>  tools/testing/selftests/bpf/bench.h            |  1 +
>  .../selftests/bpf/benchs/bench_trigger.c       |  1 +
>  .../selftests/bpf/progs/trigger_bench.c        | 18 ++++++++++++++++++
>  4 files changed, 24 insertions(+)
>

This now actually becomes a stack trace benchmark :) But I don't mind,
I think it would be good to be able to benchmark this. But I think we
should then implement it for all different tracing programs (tp,
raw_tp, fentry/fexit/fmod_ret) for consistency and so we can compare
and contrast?...

> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index bd29bb2e6cb5..8dadd9c928ec 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -265,6 +265,7 @@ static const struct argp_option opts[] =3D {
>         { "verbose", 'v', NULL, 0, "Verbose debug output"},
>         { "affinity", 'a', NULL, 0, "Set consumer/producer thread affinit=
y"},
>         { "quiet", 'q', NULL, 0, "Be more quiet"},
> +       { "stacktrace", 'g', NULL, 0, "Get stack trace"},

bikeshedding time: why "g"? why not -S or something like that?

>         { "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
>           "Set of CPUs for producer threads; implies --affinity"},
>         { "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
> @@ -350,6 +351,9 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
>         case 'q':
>                 env.quiet =3D true;
>                 break;
> +       case 'g':
> +               env.stacktrace =3D true;
> +               break;
>         case ARG_PROD_AFFINITY_SET:
>                 env.affinity =3D true;
>                 if (parse_num_list(arg, &env.prod_cpus.cpus,
> diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftest=
s/bpf/bench.h
> index bea323820ffb..7cf21936e7ed 100644
> --- a/tools/testing/selftests/bpf/bench.h
> +++ b/tools/testing/selftests/bpf/bench.h
> @@ -26,6 +26,7 @@ struct env {
>         bool list;
>         bool affinity;
>         bool quiet;
> +       bool stacktrace;
>         int consumer_cnt;
>         int producer_cnt;
>         int nr_cpus;
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 34018fc3927f..aeec9edd3851 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -146,6 +146,7 @@ static void setup_ctx(void)
>         bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true);
>
>         ctx.skel->rodata->batch_iters =3D args.batch_iters;
> +       ctx.skel->rodata->stacktrace =3D env.stacktrace;
>  }
>
>  static void load_ctx(void)
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/te=
sting/selftests/bpf/progs/trigger_bench.c
> index 2898b3749d07..479400d96fa4 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -25,6 +25,23 @@ static __always_inline void inc_counter(void)
>         __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>  }
>
> +volatile const int stacktrace;
> +
> +typedef __u64 stack_trace_t[128];
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> +       __uint(max_entries, 16384);
> +       __type(key, __u32);
> +       __type(value, stack_trace_t);
> +} stackmap SEC(".maps");
> +
> +static __always_inline void do_stacktrace(void *ctx)
> +{
> +       if (stacktrace)
> +               bpf_get_stackid(ctx, &stackmap, 0);
> +}
> +
>  SEC("?uprobe")
>  int bench_trigger_uprobe(void *ctx)
>  {
> @@ -96,6 +113,7 @@ SEC("?kprobe.multi/bpf_get_numa_node_id")
>  int bench_trigger_kprobe_multi(void *ctx)
>  {
>         inc_counter();
> +       do_stacktrace(ctx);
>         return 0;
>  }
>
> --
> 2.52.0
>

