Return-Path: <bpf+bounces-79127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC1D28081
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA98B305AB9B
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D73C00B3;
	Thu, 15 Jan 2026 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPS1+2LO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A03C00B2
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503032; cv=pass; b=itNTy39GwL74+Z1kPhhq4kw5vYSOtzfr8i5rFAuKh7uaW0JAjRrcWYTrxNooTexS4pwvrG/wLuZLPa13D3F6xgxJGDKvDNHqBfoYbet0pLKWFeN8RYt8lU/8cvoj0HQj5kH85TzjIWq/lGvrdTOG7qZQsinlitHAloRjY4GlpjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503032; c=relaxed/simple;
	bh=gQtRYgLCeRAq8QsfKbXbRJ5PemQLVXh1Ew/167lVpVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWew/u0xa2PgcpI5hjM99PDKmVJxdQCrz8l1BTCYW7fiSKFZomJY5INCkZlBSpdhCKniDK1GXJYNTvXN3KqHHCY/IxTYNlhRlB2I0ZdI6NnoK/+0FqsT/RpmuCVe2mBcN2i8xGMrlUu1cqochRyKFkXsj7FE7sJenaU77G8OE88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPS1+2LO; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso726281a91.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:50:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768503026; cv=none;
        d=google.com; s=arc-20240605;
        b=jloNU58Pki2954WNnJuQ3wZgikaMowsIvBjF9WTPsP/cJdHsDXdCYUezITcRnOJt/5
         FUqqWLda5kBIhunFNV7YYajHMf2uLvhIFXINlaVFeethLg579LkANzyDcW+MUKdT4xC/
         Jtw0YO4Blc+jvBO8WKx9MBwPjqpdHYM1udaIOxPEajhaeEZewIVH5QvJ1iUwu0FAGupo
         5FnkJ7MYHL6Ww3gJJA7rQ2M5d1Pj/rM4E5h/oJU0Qk/pt/a9m3Dqb9IukP1dMKeUv94f
         NK/gX1VCd7aWbRHk8m6saur+cxRsLrDBQ8FWPGKP5L+SrbirEpb+yrr/QnfiQN462sfC
         EQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OnpCoYg3n4ioXiv+ldJpW4ktoyK6Gvbrlk/GRDVTf7w=;
        fh=LDs7DWYhz8gF01DN3E1yAokKB3paKc10G8OFWtvH904=;
        b=ha/APLWgkzcRGwa6cfZ7M9W+iSqdUo2VPDkOBRLGdCmgm3J/qpyIuJ7z90X5CPwf0p
         8HZefEtzrJ79/PkDWDx93owfNI1oxwa25o7PoJVci9am9F+wlWoD0qE9IgUyYUld016w
         EiBtQUt1MEtBvh4es4QXIcxVDRQPsPB5svlYnTSxkyyEPNQ6nLfgaeVfuqnOs/temJ+H
         kXVRxKB1XalNQKYVZrSSB+JZpBGaHvHo5nMMC0QPH4Uput3pwT7tVlELiyLttO9+pxZo
         wfMEpHekhQgrSlbMRrLBy3NB21Jj2ZRUog1Af93m5hdxI+k6qSpDunjta5r9Y/KJktBi
         58MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503026; x=1769107826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnpCoYg3n4ioXiv+ldJpW4ktoyK6Gvbrlk/GRDVTf7w=;
        b=FPS1+2LOHcbVW2YkPKvcwnd+DdJOCShb+u1PNYlJgIvOCObhUQUSKbb2kUMZ6jyBB9
         voN1gI5DHGPgDv+58qusfPq0Sq9p2hyYmg4Wn9uQ3niVkPCh6tLdKX7b/xcUJx4g7FrV
         73iANe6VU/oCD+FraOZdggQc4WRd3zg0742TCC8H6ihIz7/ORAdpwG2VCgYrXz2g+Yxj
         uE+bl2m4pSlk0uiW0GecJ5QYWZOCc0PVR/9YDEzvmaLszpeSeZ5t2mUhXsaBChlimloe
         RoKJounO70kUK6Tzgno5XWfBuciuk0q9I6B30xYSNH/RimZJUUUYRwXvmm6ytyvZV4PY
         1TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503026; x=1769107826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnpCoYg3n4ioXiv+ldJpW4ktoyK6Gvbrlk/GRDVTf7w=;
        b=So5sSVgrk6WeIBgmZUMPXPJd7p6jh/IPEWNyypGZRoip/Hc3SXd3C2oAUBGKedFPhB
         KiBgu54w2mmKC8UexZ8oLMtSAhZqQUkSf9J6VK308CJKo00dGSwwC/zbBIQzK2z0ZWeY
         hVp+UspIqknS7JxPedpPrY42MSLZk0Kk/bbUlcYmOmtAOD5EMKMOFGICQZrmSJUCqlvw
         UJj/19wmjNSnQVGlfdMK9/snzqnFJC+Kw8j3favO4KfuAhiu9U7O2HABsPafJZPvMRy9
         5p0JqUob7KYvuKBFCUQ/tKsuE57vVHrt6YWd0kNlvJYPwCmNdFLQT3Xi4DthRZpy8mZq
         cISA==
X-Forwarded-Encrypted: i=1; AJvYcCUFyCleLu5YwuIc5v2TjCkfK3n4wj6Hpbg3avzelbDs32RSffDEVNir8/WwZ4x0hKPgtkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTP0fvNcVfYFEHACj0nAmjShDVrWqb2v4oIGGHldBhqg4h1HAX
	Qu7mNC5Y87d0h+/+ttXkAcHRiFC+IXOZ9pjFHAISA1tDA3X4+hyg0Ja3hzV7GPPAvY7vYJ+xSQ9
	haAacqEi7sdj40yhCGfcWMvQBbL9ilUY=
X-Gm-Gg: AY/fxX6JBs1m5zfsM0zItdCmk1QnECgWPq6xTR4TjUCw1Zbj4lHUaTKMpHwBe4rw6Ov
	G5DmhnzGz8E1XD9B0BzlAz1CFCsGmvEokfJfW1TPrr9xUnmSbAhrcSfkMkJuzEptVR3DlBiuu1w
	D8NlQFvZ40DYXVDsCJ5kSF0bT+rt/lcc2A08/2INhbXQ4mym7NqW+u5MmS+9iakjX4a79euYn/+
	ouAIpZCNjJ/G44NLEIQpHyGpTUnRTsAzHux873kw0peLC05aWyVcJBnzTK/H9cBQhMkZq41aDiD
	E8t/PZef
X-Received: by 2002:a17:90b:3c85:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-3527317db23mr287866a91.11.1768503026313; Thu, 15 Jan 2026
 10:50:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112214940.1222115-1-jolsa@kernel.org> <20260112214940.1222115-5-jolsa@kernel.org>
 <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
In-Reply-To: <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 10:50:13 -0800
X-Gm-Features: AZwV_Qgp2lQN9PVyejnfsDp_b_Uy6fqZH6QztBobLA0UKr6zwNYYWO93As_6mFY
Message-ID: <CAEf4Bzbn-Sai+pnC1Gu-E-uhJeSA8g-6xB49bswdPFpJd92Rng@mail.gmail.com>
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

On Thu, Jan 15, 2026 at 10:48=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 12, 2026 at 1:50=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > Adding support to call bpf_get_stackid helper from trigger programs,
> > so far added for kprobe multi.
> >
> > Adding the --stacktrace/-g option to enable it.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c            |  4 ++++
> >  tools/testing/selftests/bpf/bench.h            |  1 +
> >  .../selftests/bpf/benchs/bench_trigger.c       |  1 +
> >  .../selftests/bpf/progs/trigger_bench.c        | 18 ++++++++++++++++++
> >  4 files changed, 24 insertions(+)
> >
>
> This now actually becomes a stack trace benchmark :) But I don't mind,
> I think it would be good to be able to benchmark this. But I think we
> should then implement it for all different tracing programs (tp,
> raw_tp, fentry/fexit/fmod_ret) for consistency and so we can compare
> and contrast?...
>
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selfte=
sts/bpf/bench.c
> > index bd29bb2e6cb5..8dadd9c928ec 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -265,6 +265,7 @@ static const struct argp_option opts[] =3D {
> >         { "verbose", 'v', NULL, 0, "Verbose debug output"},
> >         { "affinity", 'a', NULL, 0, "Set consumer/producer thread affin=
ity"},
> >         { "quiet", 'q', NULL, 0, "Be more quiet"},
> > +       { "stacktrace", 'g', NULL, 0, "Get stack trace"},
>
> bikeshedding time: why "g"? why not -S or something like that?
>
> >         { "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
> >           "Set of CPUs for producer threads; implies --affinity"},
> >         { "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
> > @@ -350,6 +351,9 @@ static error_t parse_arg(int key, char *arg, struct=
 argp_state *state)
> >         case 'q':
> >                 env.quiet =3D true;
> >                 break;
> > +       case 'g':
> > +               env.stacktrace =3D true;
> > +               break;
> >         case ARG_PROD_AFFINITY_SET:
> >                 env.affinity =3D true;
> >                 if (parse_num_list(arg, &env.prod_cpus.cpus,
> > diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selfte=
sts/bpf/bench.h
> > index bea323820ffb..7cf21936e7ed 100644
> > --- a/tools/testing/selftests/bpf/bench.h
> > +++ b/tools/testing/selftests/bpf/bench.h
> > @@ -26,6 +26,7 @@ struct env {
> >         bool list;
> >         bool affinity;
> >         bool quiet;
> > +       bool stacktrace;
> >         int consumer_cnt;
> >         int producer_cnt;
> >         int nr_cpus;
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools=
/testing/selftests/bpf/benchs/bench_trigger.c
> > index 34018fc3927f..aeec9edd3851 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > @@ -146,6 +146,7 @@ static void setup_ctx(void)
> >         bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true)=
;
> >
> >         ctx.skel->rodata->batch_iters =3D args.batch_iters;
> > +       ctx.skel->rodata->stacktrace =3D env.stacktrace;
> >  }
> >
> >  static void load_ctx(void)
> > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/=
testing/selftests/bpf/progs/trigger_bench.c
> > index 2898b3749d07..479400d96fa4 100644
> > --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> > +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > @@ -25,6 +25,23 @@ static __always_inline void inc_counter(void)
> >         __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >  }
> >
> > +volatile const int stacktrace;
> > +
> > +typedef __u64 stack_trace_t[128];
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +       __uint(max_entries, 16384);
> > +       __type(key, __u32);
> > +       __type(value, stack_trace_t);
> > +} stackmap SEC(".maps");

oh, and why bother with STACK_TRACE map, just call bpf_get_stack() API
and have maybe per-CPU scratch array for stack trace (per-CPU so that
in multi-cpu benchmarks they don't just contend on the same cache
lines)

> > +
> > +static __always_inline void do_stacktrace(void *ctx)
> > +{
> > +       if (stacktrace)
> > +               bpf_get_stackid(ctx, &stackmap, 0);
> > +}
> > +
> >  SEC("?uprobe")
> >  int bench_trigger_uprobe(void *ctx)
> >  {
> > @@ -96,6 +113,7 @@ SEC("?kprobe.multi/bpf_get_numa_node_id")
> >  int bench_trigger_kprobe_multi(void *ctx)
> >  {
> >         inc_counter();
> > +       do_stacktrace(ctx);
> >         return 0;
> >  }
> >
> > --
> > 2.52.0
> >

