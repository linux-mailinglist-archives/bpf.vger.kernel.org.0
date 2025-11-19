Return-Path: <bpf+bounces-75097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0DC704DA
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 679A23C1C58
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CFF2FFDC9;
	Wed, 19 Nov 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4Ntf/oO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129C2FF64B
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571025; cv=none; b=akvYd31kW8gmDledApKX52mqZpUjSCpyh7ge7/PFM/K0QHFJzz+K0AFmazpDZpBxtgrHL10p8Auc5Uw4LXdv/Y2RjPMyCLQ7HLrUupz4VX5/7ogkMvllMu+ivodyQsFz6LRPLj37p07l2t/wakOyAk61Si6dUCuFbFGxT9zuPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571025; c=relaxed/simple;
	bh=O9JFz3qyS53bqmLU9nQY1FOT5EXxDiLOVx9MZNEHaA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYBZGQs+FItGsiy4BOsadE/bhZ8l+Gcu5QbCou+a1vMxnkkAXPnWakAZuSbZYlv++uBYy5i2xapvQGvYvrFRYCM+SS8LEAwBURa2Gq2gIiZM8fakokKGfxHaDRwaJj9qlJJi9oqwnKIc+p1YhpZo1/0zlIhgZQ57xo4mQIYfSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4Ntf/oO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2980343d9d1so191175ad.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 08:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763571021; x=1764175821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQBnHYw0VSBBj4j2L4MqTo6j0WkJfPfTKwzmJoktb9M=;
        b=f4Ntf/oOxqQLW5CsePNSC6nzrd49ZoXGWU7eDGSMNhSLiWvTnXYvcq8cmuEO7SsGiO
         TYqcc7orlMcZea7SzeAaFdk/GDmX7EaA98Bbc6vU4cgTb1D8JGJu7YpwEkV/ZKBccuXf
         iKVzwuv7daIBnYZeMd3OitoHaxDQHPSXvsRN0bvM3PKnakP1vMA/4VC1MOd//PD/StUG
         BqSuFnzK6YlH3MPAuitoIKo7J8x3AAF8233vtrr3xYldyJCHD5IgS+6TrD3Qx2n+WiUY
         NhZSzzvCFTw3GPpPJuVAFuElfbf4fjLCDSXv8X1VxFOGDRp2WnEeEsYXyTKub8s8xmzr
         7OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571021; x=1764175821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQBnHYw0VSBBj4j2L4MqTo6j0WkJfPfTKwzmJoktb9M=;
        b=OxpczRlioi1kmO9u6Hjv3BuCsznzOcCehSn2uRv0b3M+MplGW90UyyJKJJ5RiwBE1u
         S5GVXf9w7yQ13JCKUBrK8qNh8v63li7/mKmgWotGf+bqhpCtRQ52gKIJQSux/xapn+fB
         6Quet9vXJtc7ajVxSMxLkt8B/cpbGbVwkMIkXuim0CNsgVjqoC1AyjJOQZvANs/b4KKC
         SbPJsL0PtJGb2VUZ+hs4vUtF/VQEIvgny/l+8f/FDEqnnrxh3RVxwct7UrL4g5LWEDS+
         2TlQ0aRKKqFmvwY27Wr4unkr+gihOWKxa4t8wjc3FdK5ia4djVjFmUeJvUiERKcJUUWJ
         ASrA==
X-Forwarded-Encrypted: i=1; AJvYcCUBT4j8UsjzkOnHYs9GewrYzmg/Z3OTiP5LZiZkXVnsmbqnAMcYt4sfyuluQuPpQRcBb0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0i7AY/MLdgnys7ce0FBwDJzp3n1IKMAOtECyNzh5CiyVqfWWU
	DLQCBkaAEWKyehlLmAQk1ie0SkXK1LA3AJ1TEhLEjw0w0t4rhnbdd9tlfLOI7vumG4WO4q0nLt1
	ODp1NOKAK7qmxhGhJDsmcB6JFhUtr5O+XVf/FAppo
X-Gm-Gg: ASbGncu4r1KRgo5Idd6bQiTqDgX7L3tbLKRxi8Yc593Qq9KkrNEiNShZN9DbOL2fhuc
	pMG30SoKue2qMADoN4J7N9uxgelu9Ikw9+j/iDsI2ZxGqaQihkkgr7toAglyR1u6xMspsUe+lFU
	pZsB/UxaN/ZDUmtISevnncc/P6qGmsNXqzW5dKz1/gKALx9VN3YzlL06dhNJ2GAotvkR/nbPMjQ
	+ZzkqndTPyF+JkuNCEhKSq8Ehs+WSz8won/1RfD5BnBl+62fhwRfnWXbi2jGfM3uLfyC+hCXU2y
	onHQDjfmCyjjcnR0HqjiGhULSA==
X-Google-Smtp-Source: AGHT+IEICHjk33fXEW+hyxHU8aTmZdnV/O+AHUpf/mOXU8tiARf5WeMbTWR+rSjeKJAnzTruCuAluI0+rTOTjLbj29U=
X-Received: by 2002:a05:7022:6b98:b0:119:e56b:c1dc with SMTP id
 a92af1059eb24-11c8dda9816mr145267c88.7.1763571020624; Wed, 19 Nov 2025
 08:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115234106.348571-1-namhyung@kernel.org> <20251115234106.348571-4-namhyung@kernel.org>
In-Reply-To: <20251115234106.348571-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:50:08 -0800
X-Gm-Features: AWmQ_bly3STldTS6YUBz9binx1C6MJzkuz8EvLWSHaE9ZthT7K55gqE8MmJZAdI
Message-ID: <CAP-5=fXX_h8q=0uTGkU89Z_r6Rw30oMfxyJw5p-O45t0OSppJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf record: Add --call-graph fp,defer option for
 deferred callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a new callchain record mode option for deferred callchains.  For now
> it only works with FP (frame-pointer) mode.
>
> And add the missing feature detection logic to clear the flag on old
> kernels.
>
>   $ perf record --call-graph fp,defer -vv true
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     size                             136
>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>     defer_callchain                  1
>     defer_output                     1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -22
>   switching off deferred callchain support
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-config.txt |  3 +++
>  tools/perf/Documentation/perf-record.txt |  4 ++++
>  tools/perf/util/callchain.c              | 16 +++++++++++++---
>  tools/perf/util/callchain.h              |  1 +
>  tools/perf/util/evsel.c                  | 19 +++++++++++++++++++
>  tools/perf/util/evsel.h                  |  1 +
>  6 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Docume=
ntation/perf-config.txt
> index c6f33565966735fe..642d1c490d9e3bcd 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -452,6 +452,9 @@ Variables
>                 kernel space is controlled not by this option but by the
>                 kernel config (CONFIG_UNWINDER_*).
>
> +               The 'defer' mode can be used with 'fp' mode to enable def=
erred
> +               user callchains (like 'fp,defer').
> +
>         call-graph.dump-size::
>                 The size of stack to dump in order to do post-unwinding. =
Default is 8192 (byte).
>                 When using dwarf into record-mode, the default size will =
be used if omitted.
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index 067891bd7da6edc8..e8b9aadbbfa50574 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -325,6 +325,10 @@ OPTIONS
>         by default.  User can change the number by passing it after comma
>         like "--call-graph fp,32".
>
> +       Also "defer" can be used with "fp" (like "--call-graph fp,defer")=
 to
> +       enable deferred user callchain which will collect user-space call=
chains
> +       when the thread returns to the user space.
> +
>  -q::
>  --quiet::
>         Don't print any warnings or messages, useful for scripting.
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index d7b7eef740b9d6ed..2884187ccbbecfdc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -275,9 +275,13 @@ int parse_callchain_record(const char *arg, struct c=
allchain_param *param)
>                         if (tok) {
>                                 unsigned long size;
>
> -                               size =3D strtoul(tok, &name, 0);
> -                               if (size < (unsigned) sysctl__max_stack()=
)
> -                                       param->max_stack =3D size;
> +                               if (!strncmp(tok, "defer", sizeof("defer"=
))) {
> +                                       param->defer =3D true;
> +                               } else {
> +                                       size =3D strtoul(tok, &name, 0);
> +                                       if (size < (unsigned) sysctl__max=
_stack())
> +                                               param->max_stack =3D size=
;
> +                               }
>                         }
>                         break;
>
> @@ -314,6 +318,12 @@ int parse_callchain_record(const char *arg, struct c=
allchain_param *param)
>         } while (0);
>
>         free(buf);
> +
> +       if (param->defer && param->record_mode !=3D CALLCHAIN_FP) {
> +               pr_err("callchain: deferred callchain only works with FP\=
n");
> +               return -EINVAL;
> +       }
> +
>         return ret;
>  }
>
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 86ed9e4d04f9ee7b..d5ae4fbb7ce5fa44 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -98,6 +98,7 @@ extern bool dwarf_callchain_users;
>
>  struct callchain_param {
>         bool                    enabled;
> +       bool                    defer;
>         enum perf_call_graph_mode record_mode;
>         u32                     dump_size;
>         enum chain_mode         mode;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5ee3e7dee93fbbcb..7772ee9cfe3ac1c7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1065,6 +1065,9 @@ static void __evsel__config_callchain(struct evsel =
*evsel, struct record_opts *o
>                 pr_info("Disabling user space callchains for function tra=
ce event.\n");
>                 attr->exclude_callchain_user =3D 1;
>         }
> +
> +       if (param->defer && !attr->exclude_callchain_user)
> +               attr->defer_callchain =3D 1;
>  }
>
>  void evsel__config_callchain(struct evsel *evsel, struct record_opts *op=
ts,
> @@ -1511,6 +1514,7 @@ void evsel__config(struct evsel *evsel, struct reco=
rd_opts *opts,
>         attr->mmap2    =3D track && !perf_missing_features.mmap2;
>         attr->comm     =3D track;
>         attr->build_id =3D track && opts->build_id;
> +       attr->defer_output =3D track && callchain->defer;
>
>         /*
>          * ksymbol is tracked separately with text poke because it needs =
to be
> @@ -2199,6 +2203,10 @@ static int __evsel__prepare_open(struct evsel *evs=
el, struct perf_cpu_map *cpus,
>
>  static void evsel__disable_missing_features(struct evsel *evsel)
>  {
> +       if (perf_missing_features.defer_callchain && evsel->core.attr.def=
er_callchain)
> +               evsel->core.attr.defer_callchain =3D 0;
> +       if (perf_missing_features.defer_callchain && evsel->core.attr.def=
er_output)
> +               evsel->core.attr.defer_output =3D 0;
>         if (perf_missing_features.inherit_sample_read && evsel->core.attr=
.inherit &&
>             (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
>                 evsel->core.attr.inherit =3D 0;
> @@ -2473,6 +2481,13 @@ static bool evsel__detect_missing_features(struct =
evsel *evsel, struct perf_cpu
>
>         /* Please add new feature detection here. */
>
> +       attr.defer_callchain =3D true;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.defer_callchain =3D true;
> +       pr_debug2("switching off deferred callchain support\n");
> +       attr.defer_callchain =3D false;
> +
>         attr.inherit =3D true;
>         attr.sample_type =3D PERF_SAMPLE_READ | PERF_SAMPLE_TID;
>         if (has_attr_feature(&attr, /*flags=3D*/0))
> @@ -2584,6 +2599,10 @@ static bool evsel__detect_missing_features(struct =
evsel *evsel, struct perf_cpu
>         errno =3D old_errno;
>
>  check:
> +       if ((evsel->core.attr.defer_callchain || evsel->core.attr.defer_o=
utput) &&
> +           perf_missing_features.defer_callchain)
> +               return true;
> +
>         if (evsel->core.attr.inherit &&
>             (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
>             perf_missing_features.inherit_sample_read)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3ae4ac8f9a37e009..a08130ff2e47a887 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -221,6 +221,7 @@ struct perf_missing_features {
>         bool branch_counters;
>         bool aux_action;
>         bool inherit_sample_read;
> +       bool defer_callchain;
>  };
>
>  extern struct perf_missing_features perf_missing_features;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>

