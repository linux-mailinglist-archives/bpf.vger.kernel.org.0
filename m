Return-Path: <bpf+bounces-53524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65AA55D5F
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 02:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DB3170BEC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618E41632D9;
	Fri,  7 Mar 2025 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgrUk4ex"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E39149E16;
	Fri,  7 Mar 2025 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312667; cv=none; b=tSLCYjEZVCbiBv2+8E83yB2/Csr82H7QY4bc1Yny8oC1aCylOBZeC9BbWUf0YozJb80p9/Tba9XM1TIHwEe3+J94Qd0W4vEdHYGaDUrAKV5eVQT9WqnDz01syIIST7pYcV/YWNJjebu/rKmoTNY3rb8F01wtG9bQBLN4buFSC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312667; c=relaxed/simple;
	bh=ddDRFVu3AinKT+uLQryldvFZhGBEf9XaNHmsJnfE/JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqFVv1UMd+wlms7l3d/DwbFNahDg+QCKusgzC5lh7gw98GSBvqxQMAJeXjYSiHuqXa2Q1bgvjA28YNm6a/FBSBXifuHWX+o3TjleiPGwIXVKFztRRwHWdl0LsoBwlIIDVDkREequvA44qUQnavV42jqLO2IYBvNfNgkrXkvdMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgrUk4ex; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6182c6d52aso953897276.2;
        Thu, 06 Mar 2025 17:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741312665; x=1741917465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIvHxFR0HM69D2jfnpw60P9vkyUMFOY/Aw07zt/0BCI=;
        b=CgrUk4exqVppGqYBJ44g2U5xUDfMm+tkE51LeEeV6wyN1433CopAAIaATJY1S+nnaL
         G9OBg4hiw1RsMVo/nyqo3ZZafKt3PUjVb7W31iQeFcCOLKEtDm48zMvQjWkEI0kiOJAr
         PVmnP8qQSxhUC7/HcahgF7gURelUADl5nEhQ66XNeFnytfEFy/QKIjDCnpruW/opWGiM
         gSU/C4/OIzec7EIZAYz+Q04GW7EOOA2gZVVin8tCvn0PxBzUj5vsrZ8MaNrAAzhra3SM
         Th9p4qPBY5TA4ZRUgN4Hqpd1mkDB99A7w5t2h9nYLsWpE5tZqw98PQMEknIc8c3+RaHt
         ZcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741312665; x=1741917465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIvHxFR0HM69D2jfnpw60P9vkyUMFOY/Aw07zt/0BCI=;
        b=V/USUhMFKPc7Ya69EFm0q2vfU37DyN3PR1vI+g01khga3wZHIs2yUZIL6op0tmNkgK
         qxRr+w/q4nf0UqB3AZ39A4ZQw2V2evFna7LPnXBd5qZldETJQkp0L+Nl0IMBpN7hYOCQ
         z0DiUyIHwkbhFdWunZUI77mMZPERMFYlyX6Gfzkv+GZ1nWKo/ezqQlZlHjkjZAim2G6L
         V0b9NLUyJD/uhk/ZUDMOHGs3q2s76d9OlvDl76OGg7xhGxZWB7gWOFyWr7ridutzw0vz
         r/RiUmVnb2+vP7+L0KV6jL3FL/2OzPl8yaPrg3vA1Ga4+6BNoEX5H5wADKdeMSt1Ug5V
         5+KA==
X-Forwarded-Encrypted: i=1; AJvYcCVelxyx5rUPOWY3Xuj3IlaM5nGiau4Wf21KbpbnRs7rrO+0lpT4frl12D8EF2LN90/oUDIm0Ti0hZwObB30@vger.kernel.org, AJvYcCWc1ZBUPhLUYbV1aJlNSu1xSBWdr6vlkOi2ea+FRjsfvQcTPFZKSlljxeqOMLqixD08upYj4bKRIu4DnZXR/I031A==@vger.kernel.org, AJvYcCXqH/hKDwBwwm421jpRVE92uTHZzO1eue9NaMPMGGod7XLV/l0EODZPM5rk9zy9svBbVcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2vltr+TuZ+ztiaFypCHXYPpuXfmHd4eNYRMqSh0wyjZUpEMd
	ClQ+mGP1wsL7BEOMl3xzO7mzBjftdfU5jf9PAP9S2OoaHDvt6L377QnZc73fCp3uwzGoMnBv0TG
	TIACdZm8TMTg+yJIGGoTnZYwLdqU=
X-Gm-Gg: ASbGncu8S3bjmi0xBzV6Jk1lyEGIVxPZw/gpuFfU0f0PypNIAlDEIpKE4ixnM9pqY04
	UxwN/bHy6X3rYqgU3Q/g+OGc7gDPT+1skjk455YTJGh6r8IQyxUusGlSKvtLpT5xuXrEZeLvupM
	GQxDeFiZaB2wVXRCTO7jzlX1Ww
X-Google-Smtp-Source: AGHT+IEHAgNOpmRteF4cqsIBRhRQ4LQnbRG0/jof8px+u6pKlj8R77lXJxsJcMVXKETYF2SRIbi0hIpMr0ovLCZobKk=
X-Received: by 2002:a05:6902:2082:b0:e5d:e3b1:486f with SMTP id
 3f1490d57ef6-e635c1c4097mr2399418276.30.1741312664665; Thu, 06 Mar 2025
 17:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221183207.560262-1-namhyung@kernel.org>
In-Reply-To: <20250221183207.560262-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 6 Mar 2025 17:57:33 -0800
X-Gm-Features: AQ5f1Jogar7g0Xt5DqR7OVHcsE78y81XrD5FhZxMfANNVeT1oRhn45AqedXRU74
Message-ID: <CAH0uvoi0fqm-jJcw2VtLwHbSrcKUq__UW82oCMLaKEH7Fz-zhQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Implement syscall summary in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

Sorry for replying this crazy late, flu got me good last week...

On Fri, Feb 21, 2025 at 10:32=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When --summary-only option is used, it doesn't need (augmented) arguments
> of syscalls.  Let's skip the augmentation and load another small BPF
> program to collect the statistics in the kernel instead of copying the
> data to the ring-buffer to calculate the stats in userspace.  This will
> be much more light-weight than the existing approach and remove any lost
> events.

Yep, awesome idea, 100% agree. That's how the summary mode should be
written, so cool :)

>
> For simplicity, it's only activated with --summary-mode=3Dtotal in system=
-
> wide mode.  And it also skips to calculate stddev as doing it atomically
> would add more overheads (i.e. requiring a spinlock).  It can be extended
> to cover more use cases later, if needed.
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-trace.c                    |  41 ++++--
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf-trace-summary.c           | 117 ++++++++++++++++++
>  .../perf/util/bpf_skel/syscall_summary.bpf.c  | 109 ++++++++++++++++
>  tools/perf/util/bpf_skel/syscall_summary.h    |  18 +++
>  tools/perf/util/trace.h                       |  31 +++++
>  7 files changed, 311 insertions(+), 8 deletions(-)
>  create mode 100644 tools/perf/util/bpf-trace-summary.c
>  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
>  create mode 100644 tools/perf/util/trace.h
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 55d6ce9ea52fb2a5..3b68a57682ca991d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1198,7 +1198,7 @@ SKELETONS +=3D $(SKEL_OUT)/bperf_leader.skel.h $(SK=
EL_OUT)/bperf_follower.skel.h
>  SKELETONS +=3D $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.=
skel.h
>  SKELETONS +=3D $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.sk=
el.h
>  SKELETONS +=3D $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.=
skel.h
> -SKELETONS +=3D $(SKEL_OUT)/kwork_top.skel.h
> +SKELETONS +=3D $(SKEL_OUT)/kwork_top.skel.h $(SKEL_OUT)/syscall_summary.=
skel.h
>  SKELETONS +=3D $(SKEL_OUT)/bench_uprobe.skel.h
>  SKELETONS +=3D $(SKEL_OUT)/augmented_raw_syscalls.skel.h
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f55a8a6481f27f99..1c7af7583bc560c4 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -55,6 +55,7 @@
>  #include "util/thread_map.h"
>  #include "util/stat.h"
>  #include "util/tool.h"
> +#include "util/trace.h"
>  #include "util/util.h"
>  #include "trace/beauty/beauty.h"
>  #include "trace-event.h"
> @@ -222,6 +223,7 @@ struct trace {
>         bool                    force;
>         bool                    vfs_getname;
>         bool                    force_btf;
> +       bool                    summary_bpf;
>         int                     trace_pgfaults;
>         char                    *perfconfig_events;
>         struct {
> @@ -4276,6 +4278,13 @@ static int trace__run(struct trace *trace, int arg=
c, const char **argv)
>
>         trace->live =3D true;
>
> +       if (trace->summary_bpf) {
> +               if (trace_prepare_bpf_summary() < 0)
> +                       goto out_delete_evlist;
> +
> +               goto create_maps;
> +       }
> +
>         if (!trace->raw_augmented_syscalls) {
>                 if (trace->trace_syscalls && trace__add_syscall_newtp(tra=
ce))
>                         goto out_error_raw_syscalls;
> @@ -4334,6 +4343,7 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>         if (trace->cgroup)
>                 evlist__set_default_cgroup(trace->evlist, trace->cgroup);
>
> +create_maps:
>         err =3D evlist__create_maps(evlist, &trace->opts.target);
>         if (err < 0) {
>                 fprintf(trace->output, "Problems parsing the target to tr=
ace, check your options!\n");
> @@ -4426,9 +4436,11 @@ static int trace__run(struct trace *trace, int arg=
c, const char **argv)
>         if (err < 0)
>                 goto out_error_apply_filters;
>
> -       err =3D evlist__mmap(evlist, trace->opts.mmap_pages);
> -       if (err < 0)
> -               goto out_error_mmap;
> +       if (!trace->summary_bpf) {
> +               err =3D evlist__mmap(evlist, trace->opts.mmap_pages);
> +               if (err < 0)
> +                       goto out_error_mmap;
> +       }
>
>         if (!target__none(&trace->opts.target) && !trace->opts.target.ini=
tial_delay)
>                 evlist__enable(evlist);

I think if summary_bpf is true we don't need to enable the evlist
either, but we can leave it here.

> @@ -4441,6 +4453,9 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>                 evlist__enable(evlist);
>         }
>
> +       if (trace->summary_bpf)
> +               trace_start_bpf_summary();
> +
>         trace->multiple_threads =3D perf_thread_map__pid(evlist->core.thr=
eads, 0) =3D=3D -1 ||
>                 perf_thread_map__nr(evlist->core.threads) > 1 ||
>                 evlist__first(evlist)->core.attr.inherit;
> @@ -4508,12 +4523,17 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
>
>         evlist__disable(evlist);
>
> +       if (trace->summary_bpf)
> +               trace_end_bpf_summary();
> +
>         if (trace->sort_events)
>                 ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
>
>         if (!err) {
>                 if (trace->summary) {
> -                       if (trace->summary_mode =3D=3D SUMMARY__BY_TOTAL)
> +                       if (trace->summary_bpf)
> +                               trace_print_bpf_summary(trace->sctbl, tra=
ce->output);
> +                       else if (trace->summary_mode =3D=3D SUMMARY__BY_T=
OTAL)
>                                 trace__fprintf_total_summary(trace, trace=
->output);
>                         else
>                                 trace__fprintf_thread_summary(trace, trac=
e->output);
> @@ -4529,6 +4549,7 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>         }
>
>  out_delete_evlist:
> +       trace_cleanup_bpf_summary();
>         delete_syscall_stats(trace->syscall_stats);
>         trace__symbols__exit(trace);
>         evlist__free_syscall_tp_fields(evlist);
> @@ -5446,6 +5467,15 @@ int cmd_trace(int argc, const char **argv)
>                 goto skip_augmentation;
>         }
>
> +       if (!argc && target__none(&trace.opts.target))
> +               trace.opts.target.system_wide =3D true;
> +
> +       if (trace.summary_only && trace.opts.target.system_wide &&
> +           trace.summary_mode =3D=3D SUMMARY__BY_TOTAL && !trace.trace_p=
gfaults) {

I feel like trace_pgfaults can coexist with the BPF summary, but I'm
fine with the current logic.

BTW, this part of the code can be confusing; You covered a case where:
sudo ./perf trace -s --summary-mode=3Dtotal -F all -a --syscall
is handled properly. Because normally when doing
sudo ./perf trace -s --summary-mode=3Dtotal -F all -a
without the --syscall option, perf trace won't even get to this point,
it will skip augmentation from here:
if (!trace.trace_syscalls)
        goto skip_augmentation;

So, good work!

> +               trace.summary_bpf =3D true;
> +               goto skip_augmentation;
> +       }
> +
>         trace.skel =3D augmented_raw_syscalls_bpf__open();
>         if (!trace.skel) {
>                 pr_debug("Failed to open augmented syscalls BPF skeleton"=
);
> @@ -5649,9 +5679,6 @@ int cmd_trace(int argc, const char **argv)
>                 goto out_close;
>         }
>
> -       if (!argc && target__none(&trace.opts.target))
> -               trace.opts.target.system_wide =3D true;
> -
>         if (input_name)
>                 err =3D trace__replay(&trace);
>         else
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 034a6603d5a8e8b0..ba4201a6f3c69753 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -171,6 +171,7 @@ perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_off_cpu.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf-filter.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf-filter-flex.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf-filter-bison.o
> +perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf-trace-summary.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D btf.o
>
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-tr=
ace-summary.c
> new file mode 100644
> index 0000000000000000..7e8b1c9b3faeee4f
> --- /dev/null
> +++ b/tools/perf/util/bpf-trace-summary.c
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "syscalltbl.h"
> +#include "util/trace.h"
> +#include "util/util.h"
> +#include <bpf/bpf.h>
> +#include <linux/time64.h>
> +
> +#include "bpf_skel/syscall_summary.h"
> +#include "bpf_skel/syscall_summary.skel.h"
> +
> +
> +static struct syscall_summary_bpf *skel;
> +
> +int trace_prepare_bpf_summary(void)
> +{
> +       skel =3D syscall_summary_bpf__open_and_load();
> +       if (skel =3D=3D NULL) {
> +               fprintf(stderr, "failed to load syscall summary bpf skele=
ton\n");
> +               return -1;
> +       }
> +
> +       if (syscall_summary_bpf__attach(skel) < 0) {
> +               fprintf(stderr, "failed to attach syscall summary bpf ske=
leton\n");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +void trace_start_bpf_summary(void)
> +{
> +       skel->bss->enabled =3D 1;
> +}
> +
> +void trace_end_bpf_summary(void)
> +{
> +       skel->bss->enabled =3D 0;
> +}
> +
> +struct syscall_data {
> +       int syscall_nr;
> +       struct syscall_stats stats;
> +};
> +
> +static int datacmp(const void *a, const void *b)
> +{
> +       const struct syscall_data *sa =3D a;
> +       const struct syscall_data *sb =3D b;
> +
> +       return sa->stats.total_time > sb->stats.total_time ? -1 : 1;
> +}
> +
> +int trace_print_bpf_summary(struct syscalltbl *sctbl, FILE *fp)
> +{
> +       struct syscall_key *prev_key, key;
> +       struct syscall_data *data =3D NULL;
> +       struct bpf_map *map =3D skel->maps.syscall_stats_map;
> +       int nr_data =3D 0;
> +       int printed =3D 0;
> +
> +       /* get stats from the bpf map */
> +       prev_key =3D NULL;
> +       while (!bpf_map__get_next_key(map, prev_key, &key, sizeof(key))) =
{
> +               struct syscall_stats stat;
> +
> +               if (!bpf_map__lookup_elem(map, &key, sizeof(key), &stat, =
sizeof(stat), 0)) {
> +                       struct syscall_data *tmp, *pos;
> +
> +                       tmp =3D realloc(data, sizeof(*data) * (nr_data + =
1));
> +                       if (tmp =3D=3D NULL)
> +                               break;
> +
> +                       data =3D tmp;
> +                       pos =3D &data[nr_data++];
> +
> +                       pos->syscall_nr =3D key.nr;
> +                       memcpy(&pos->stats, &stat, sizeof(stat));
> +               }
> +
> +               prev_key =3D &key;
> +       }
> +
> +       qsort(data, nr_data, sizeof(*data), datacmp);
> +
> +       printed +=3D fprintf(fp, "\n");
> +
> +       printed +=3D fprintf(fp, "   syscall            calls  errors  to=
tal       min       avg       max       stddev\n");
> +       printed +=3D fprintf(fp, "                                     (m=
sec)    (msec)    (msec)    (msec)        (%%)\n");
> +       printed +=3D fprintf(fp, "   --------------- --------  ------ ---=
----- --------- --------- ---------     ------\n");
> +
> +       for (int i =3D 0; i < nr_data; i++) {
> +               struct syscall_data *pos =3D &data[i];
> +               double total =3D (double)(pos->stats.total_time) / NSEC_P=
ER_MSEC;
> +               double min =3D (double)(pos->stats.min_time) / NSEC_PER_M=
SEC;
> +               double max =3D (double)(pos->stats.max_time) / NSEC_PER_M=
SEC;
> +               double avg =3D total / pos->stats.count;
> +
> +               printed +=3D fprintf(fp, "   %-15s", syscalltbl__name(sct=
bl, pos->syscall_nr));
> +               printed +=3D fprintf(fp, " %8u %6u %9.3f %9.3f %9.3f %9.3=
f %9.2f%%\n",
> +                                  pos->stats.count, pos->stats.error, to=
tal, min, avg, max,
> +                                  /*stddev=3D*/0.0);

Assuming the performance downfall comes from libc's sqrt(), isn't it
calculated only after collecting all the data? And don't we have at
most nr_data records to process? I fail to understand how they "add
more overheads", can you please explain?

> +       }
> +
> +       printed +=3D fprintf(fp, "\n\n");
> +       free(data);
> +
> +       return printed;
> +}
> +
> +void trace_cleanup_bpf_summary(void)
> +{
> +       syscall_summary_bpf__destroy(skel);
> +}
> diff --git a/tools/perf/util/bpf_skel/syscall_summary.bpf.c b/tools/perf/=
util/bpf_skel/syscall_summary.bpf.c
> new file mode 100644
> index 0000000000000000..e573ce39de73eaf3
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Trace raw_syscalls tracepoints to collect system call statistics.
> + */
> +
> +#include "vmlinux.h"
> +#include "syscall_summary.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +/* This is to calculate a delta between sys-enter and sys-exit for each =
thread */
> +struct syscall_trace {
> +       int nr; /* syscall number is only available at sys-enter */
> +       int unused;
> +       u64 timestamp;
> +};
> +
> +#define MAX_ENTRIES    (16 * 1024)
> +
> +struct syscall_trace_map {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, int); /* tid */
> +       __type(value, struct syscall_trace);
> +       __uint(max_entries, MAX_ENTRIES);
> +} syscall_trace_map SEC(".maps");
> +
> +struct syscall_stats_map {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, struct syscall_key);
> +       __type(value, struct syscall_stats);
> +       __uint(max_entries, MAX_ENTRIES);
> +} syscall_stats_map SEC(".maps");
> +
> +int enabled; /* controlled from userspace */
> +
> +static void update_stats(int nr, s64 duration, long ret)
> +{
> +       struct syscall_key key =3D { .nr =3D nr, };
> +       struct syscall_stats *stats;
> +
> +       stats =3D bpf_map_lookup_elem(&syscall_stats_map, &key);
> +       if (stats =3D=3D NULL) {
> +               struct syscall_stats zero =3D {};
> +
> +               bpf_map_update_elem(&syscall_stats_map, &key, &zero, BPF_=
NOEXIST);
> +               stats =3D bpf_map_lookup_elem(&syscall_stats_map, &key);
> +               if (stats =3D=3D NULL)
> +                       return;
> +       }
> +
> +       __sync_fetch_and_add(&stats->count, 1);
> +       if (ret < 0)
> +               __sync_fetch_and_add(&stats->error, 1);
> +
> +       if (duration > 0) {
> +               __sync_fetch_and_add(&stats->total_time, duration);
> +               if (stats->max_time < duration)
> +                       stats->max_time =3D duration;
> +               if (stats->min_time > duration || stats->min_time =3D=3D =
0)
> +                       stats->min_time =3D duration;
> +       }
> +
> +       return;
> +}
> +
> +SEC("tp_btf/sys_enter")
> +int sys_enter(u64 *ctx)
> +{
> +       int tid;
> +       struct syscall_trace st;
> +
> +       if (!enabled)
> +               return 0;
> +
> +       st.nr =3D ctx[1]; /* syscall number */
> +       st.unused =3D 0;
> +       st.timestamp =3D bpf_ktime_get_ns();
> +
> +       tid =3D bpf_get_current_pid_tgid();
> +       bpf_map_update_elem(&syscall_trace_map, &tid, &st, BPF_ANY);
> +
> +       return 0;
> +}
> +
> +SEC("tp_btf/sys_exit")
> +int sys_exit(u64 *ctx)
> +{
> +       int tid;
> +       long ret =3D ctx[1]; /* return value of the syscall */
> +       struct syscall_trace *st;
> +       s64 delta;
> +
> +       if (!enabled)
> +               return 0;
> +
> +       tid =3D bpf_get_current_pid_tgid();
> +       st =3D bpf_map_lookup_elem(&syscall_trace_map, &tid);
> +       if (st =3D=3D NULL)
> +               return 0;
> +
> +       delta =3D bpf_ktime_get_ns() - st->timestamp;

Do you think we can do bpf_ktime_get_ns() a little earlier, say before
bpf_map_lookup_elem()? Although the difference will be tiny...


> +       update_stats(st->nr, delta, ret);
> +
> +       bpf_map_delete_elem(&syscall_trace_map, &tid);
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/perf/util/bpf_skel/syscall_summary.h b/tools/perf/util=
/bpf_skel/syscall_summary.h
> new file mode 100644
> index 0000000000000000..644dc7049377147e
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/syscall_summary.h
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/* Data structures shared between BPF and tools. */
> +#ifndef UTIL_BPF_SKEL_SYSCALL_SUMMARY_H
> +#define UTIL_BPF_SKEL_SYSCALL_SUMMARY_H
> +
> +struct syscall_key {
> +       int nr;
> +};
> +
> +struct syscall_stats {
> +       u64 total_time;
> +       u64 max_time;
> +       u64 min_time;
> +       u32 count;
> +       u32 error;
> +};
> +
> +#endif /* UTIL_BPF_SKEL_SYSCALL_SUMMARY_H */
> diff --git a/tools/perf/util/trace.h b/tools/perf/util/trace.h
> new file mode 100644
> index 0000000000000000..4d7a7c4544d94caf
> --- /dev/null
> +++ b/tools/perf/util/trace.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef UTIL_TRACE_H
> +#define UTIL_TRACE_H
> +
> +#include <stdio.h>  /* for FILE */
> +
> +struct syscalltbl;
> +
> +#ifdef HAVE_BPF_SKEL
> +
> +int trace_prepare_bpf_summary(void);
> +void trace_start_bpf_summary(void);
> +void trace_end_bpf_summary(void);
> +int trace_print_bpf_summary(struct syscalltbl *sctbl, FILE *fp);
> +void trace_cleanup_bpf_summary(void);
> +
> +#else /* !HAVE_BPF_SKEL */
> +
> +static inline int trace_prepare_bpf_summary(void) { return -1; }
> +static inline void trace_start_bpf_summary(void) {}
> +static inline void trace_end_bpf_summary(void) {}
> +static inline int trace_print_bpf_summary(struct syscalltbl *sctbl __may=
be_unused,
> +                                         FILE *fp __maybe_unused)
> +{
> +       return 0;
> +}
> +static inline void trace_cleanup_bpf_summary(void) {}
> +
> +#endif /* HAVE_BPF_SKEL */
> +
> +#endif /* UTIL_TRACE_H */
> --
> 2.48.1.601.g30ceb7b040-goog
>

Awesome patch :)

Thanks,
Howard

