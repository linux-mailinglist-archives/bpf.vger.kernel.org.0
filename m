Return-Path: <bpf+bounces-75931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79533C9D4FF
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 00:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1914E4B2C
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2262FB632;
	Tue,  2 Dec 2025 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHE1C94m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F429BDA5
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717285; cv=none; b=ntK+5M3alAytFgJQcL2N9V+dxEDugGVWlBFlD+WW1Tr00/vEuWgo+lA4tZJDlb6KffBZr1c6KbylI2ogBpVqw45K+1o1Ms22Xlo2EkayNsGGZqqzw0LGqQyRWsavV/TfPlCgu/GjxPzSik8+6cSL/eOjdvBmx7FdU4BHu9IKmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717285; c=relaxed/simple;
	bh=rwlYwyjxR7MVpCIx30Sd9S/6Po951LrD1Rsf9dmB2dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RogDpPdJY8Ip2RQprt0v4H6H21XcZOrh3SA8XAkxwg5KJQyiQFRUwtDlPYLWfnfIIwnH6UCuA091dsSA7oxYp8vxe1/F/l1epzrfMLMAXctNuWJM1LL7oGCnqBHlt8KW8fe0mmEhVdFRNP0OcXw0FwPrOqWEGH+tozHl45Z5dr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHE1C94m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295c64cb951so79255ad.0
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 15:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764717282; x=1765322082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbcRLejcK649KgikpWnpBmbst5SCko1VBjU4RlFQO/Q=;
        b=yHE1C94mu3DWdHy1Oxltg3PAnJiBsHVeGHEGiEwOxfpj9DpT+OqsTt8xAixwO6OMom
         PP1YaAGLbPmX+skrNxrIBd8yxfTcrUAokhB22GBHAJaHx7N07lq/jpkfO6d4XiWX0bUz
         +UuHCddjSshiQcVqbBKWK0LGfUgsf8VfDulDU7lswyGmbQnPaZ3GYXLUIwsiySFtFrFb
         wP35lGwukklHTkxwkRd0mDgyK0zvI75/E2EbpEsfGQmA2o4l80TuJLb/CK6P9ATLRAbW
         Cf98HOEdNShuxFipIfpVrYK9KawwivRZAl+IKtWUbhdhXvcgY3jFjuSh+UbpyO0imeXL
         9btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764717282; x=1765322082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbcRLejcK649KgikpWnpBmbst5SCko1VBjU4RlFQO/Q=;
        b=RoTeYwl+WnViXHrcLlT+7M9j7BvhbGeUR6qIWZgI/B81n8MTFgV3tV/uFZ7kJuxs7R
         nCcbZaxRZcrsBW1leE17BEdrIO1ldWVxZidUN7j9wj0tuazXb9pntpHrnc761EV1dLIK
         zU4yj1fQZU6x6bEw0N3hU7SmJWSTsq/z/FP+79v3v+SxGYN69GuskGQQ/il1gPGMCFJN
         cHTc7dSAIxZqRkbEAxOk0lThutSccz4AYweGFj7VA+4LGpIjMR2wblpuY8SjrtsMMwjY
         7YjWihM/TB9Tk/k2aE21JWVEOtv6mepusZmKfFuIjn+J31FJo8o9taTYOP5XgbD9Nvif
         Repw==
X-Forwarded-Encrypted: i=1; AJvYcCUcQTWMKRNTXKe1xnKaTx+1JbUAc/ebqPF12LxJbwamcaoOe2c/+xfxa4Ko327+9V4g4RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBdPKjd0Qg/qN6ZiFr32v8qYGqIjLrdXp9sejuysx31US6foO
	nyTOWcDrG9uPT62I1gGKoL0gxK9k84FTaEpcUkmxOqJ5bDv5GQ0nrTDwR4QB7+eOPhbotHRhTmC
	YMIgi+Y1FctZoL2Z5IRvTCoi3hwZ4sY799tYE0GZ4
X-Gm-Gg: ASbGncupKAcj8Pe6nNbrG1Ye4H3ofqnS6O3K32uDpS+2HQYYMFges9IelVTVsmFcISl
	V66IPVFu2EbAalNTPxANTbEoXunbStc6z/w5O2QhGgK0Da1QpfLIlb3bB7LSUT3Tv+rh9g6GU0w
	4/3cSG9JWnMtdaT8/y4glVZ1Wa/vriHAEvn71K2pfPGbEZ/m2ERkHo/0KnbxFQj2I3PV8QEPx8I
	x7DDFNxHZUIqp8Dbnvz8jBxKxG5d8GVwA+QJulxd/OFKdjT/weDzSXVKX1PeSBuYMbgh8ugLrn1
	CqC1kpeuSHjBYUcTMXLzZ1vTdGdwAdJA848=
X-Google-Smtp-Source: AGHT+IE4d1TUWAU2Z1qIYsDaK76L+7KgBdOop97lcA85C18l3NjJ9uEBqrYf+6vwTf+jx66HwcPwAHn0d2ECtdkV73M=
X-Received: by 2002:a17:902:d509:b0:29a:7af:b3c9 with SMTP id
 d9443c01a7336-29d66701e16mr1165495ad.16.1764717282101; Tue, 02 Dec 2025
 15:14:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120234804.156340-1-namhyung@kernel.org> <20251120234804.156340-6-namhyung@kernel.org>
In-Reply-To: <20251120234804.156340-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 15:14:31 -0800
X-Gm-Features: AWmQ_blwG_lZNp7ZrEaBuiDKg7GeAmmfBSdMffDtWpNt17aYwquU6O2LefFs3KI
Message-ID: <CAP-5=fUVgxHn-oxQNQBJKDo=k8VPXBKA5BkJ5LbUF-UOm9t8Xw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] perf tools: Merge deferred user callchains
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

On Thu, Nov 20, 2025 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Save samples with deferred callchains in a separate list and deliver
> them after merging the user callchains.  If users don't want to merge
> they can set tool->merge_deferred_callchains to false to prevent the
> behavior.
>
> With previous result, now perf script will show the merged callchains.
>
>   $ perf script
>   ...
>   pwd    2312   121.163435:     249113 cpu/cycles/P:
>           ffffffff845b78d8 __build_id_parse.isra.0+0x218 ([kernel.kallsym=
s])
>           ffffffff83bb5bf6 perf_event_mmap+0x2e6 ([kernel.kallsyms])
>           ffffffff83c31959 mprotect_fixup+0x1e9 ([kernel.kallsyms])
>           ffffffff83c31dc5 do_mprotect_pkey+0x2b5 ([kernel.kallsyms])
>           ffffffff83c3206f __x64_sys_mprotect+0x1f ([kernel.kallsyms])
>           ffffffff845e6692 do_syscall_64+0x62 ([kernel.kallsyms])
>           ffffffff8360012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.k=
allsyms])
>               7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x=
86-64.so.2)
>               7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/l=
d-linux-x86-64.so.2)
>               7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-l=
inux-x86-64.so.2)
>   ...
>
> The old output can be get using --no-merge-callchain option.
> Also perf report can get the user callchain entry at the end.
>
>   $ perf report --no-children --stdio -q -S __build_id_parse.isra.0
>   # symbol: __build_id_parse.isra.0
>        8.40%  pwd      [kernel.kallsyms]
>               |
>               ---__build_id_parse.isra.0
>                  perf_event_mmap
>                  mprotect_fixup
>                  do_mprotect_pkey
>                  __x64_sys_mprotect
>                  do_syscall_64
>                  entry_SYSCALL_64_after_hwframe
>                  mprotect
>                  _dl_sysdep_start
>                  _dl_start_user
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/Documentation/perf-script.txt |  5 ++
>  tools/perf/builtin-inject.c              |  1 +
>  tools/perf/builtin-report.c              |  1 +
>  tools/perf/builtin-script.c              |  4 ++
>  tools/perf/util/callchain.c              | 29 +++++++++
>  tools/perf/util/callchain.h              |  3 +
>  tools/perf/util/evlist.c                 |  1 +
>  tools/perf/util/evlist.h                 |  2 +
>  tools/perf/util/session.c                | 79 +++++++++++++++++++++++-
>  tools/perf/util/tool.c                   |  2 +
>  tools/perf/util/tool.h                   |  1 +
>  11 files changed, 127 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index 28bec7e78bc858ba..03d1129606328d6d 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -527,6 +527,11 @@ include::itrace.txt[]
>         The known limitations include exception handing such as
>         setjmp/longjmp will have calls/returns not match.
>
> +--merge-callchains::
> +       Enable merging deferred user callchains if available.  This is th=
e
> +       default behavior.  If you want to see separate CALLCHAIN_DEFERRED
> +       records for some reason, use --no-merge-callchains explicitly.
> +
>  :GMEXAMPLECMD: script
>  :GMEXAMPLESUBCMD:
>  include::guest-files.txt[]
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index bd9245d2dd41aa48..51d2721b6db9dccb 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2527,6 +2527,7 @@ int cmd_inject(int argc, const char **argv)
>         inject.tool.auxtrace            =3D perf_event__repipe_auxtrace;
>         inject.tool.bpf_metadata        =3D perf_event__repipe_op2_synth;
>         inject.tool.dont_split_sample_group =3D true;
> +       inject.tool.merge_deferred_callchains =3D false;
>         inject.session =3D __perf_session__new(&data, &inject.tool,
>                                              /*trace_event_repipe=3D*/inj=
ect.output.is_pipe,
>                                              /*host_env=3D*/NULL);
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2bc269f5fcef8023..add6b1c2aaf04270 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1614,6 +1614,7 @@ int cmd_report(int argc, const char **argv)
>         report.tool.event_update         =3D perf_event__process_event_up=
date;
>         report.tool.feature              =3D process_feature_event;
>         report.tool.ordering_requires_timestamps =3D true;
> +       report.tool.merge_deferred_callchains =3D !dump_trace;
>
>         session =3D perf_session__new(&data, &report.tool);
>         if (IS_ERR(session)) {
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 85b42205a71b3993..62e43d3c5ad731a0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4009,6 +4009,7 @@ int cmd_script(int argc, const char **argv)
>         bool header_only =3D false;
>         bool script_started =3D false;
>         bool unsorted_dump =3D false;
> +       bool merge_deferred_callchains =3D true;
>         char *rec_script_path =3D NULL;
>         char *rep_script_path =3D NULL;
>         struct perf_session *session;
> @@ -4162,6 +4163,8 @@ int cmd_script(int argc, const char **argv)
>                     "Guest code can be found in hypervisor process"),
>         OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
>                     "Enable LBR callgraph stitching approach"),
> +       OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
> +                   "Enable merge deferred user callchains"),
>         OPTS_EVSWITCH(&script.evswitch),
>         OPT_END()
>         };
> @@ -4418,6 +4421,7 @@ int cmd_script(int argc, const char **argv)
>         script.tool.throttle             =3D process_throttle_event;
>         script.tool.unthrottle           =3D process_throttle_event;
>         script.tool.ordering_requires_timestamps =3D true;
> +       script.tool.merge_deferred_callchains =3D merge_deferred_callchai=
ns;
>         session =3D perf_session__new(&data, &script.tool);
>         if (IS_ERR(session))
>                 return PTR_ERR(session);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 2884187ccbbecfdc..71dc5a070065dd2a 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1838,3 +1838,32 @@ int sample__for_each_callchain_node(struct thread =
*thread, struct evsel *evsel,
>         }
>         return 0;
>  }
> +
> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,

nit: We use the term deferred rather than original except in this
context. I think deferred is a little more intention revealing than
original. Perhaps add a comment capturing that the original sample is
the deferred kernel sample.

Thanks,
Ian

> +                                    struct perf_sample *sample_callchain=
)
> +{
> +       u64 nr_orig =3D sample_orig->callchain->nr - 1;
> +       u64 nr_deferred =3D sample_callchain->callchain->nr;
> +       struct ip_callchain *callchain;
> +
> +       if (sample_orig->callchain->nr < 2) {
> +               sample_orig->deferred_callchain =3D false;
> +               return -EINVAL;
> +       }
> +
> +       callchain =3D calloc(1 + nr_orig + nr_deferred, sizeof(u64));
> +       if (callchain =3D=3D NULL) {
> +               sample_orig->deferred_callchain =3D false;
> +               return -ENOMEM;
> +       }
> +
> +       callchain->nr =3D nr_orig + nr_deferred;
> +       /* copy original including PERF_CONTEXT_USER_DEFERRED (but the co=
okie) */
> +       memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * siz=
eof(u64));
> +       /* copy deferred user callchains */
> +       memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips=
,
> +              nr_deferred * sizeof(u64));
> +
> +       sample_orig->callchain =3D callchain;
> +       return 0;
> +}
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index d5ae4fbb7ce5fa44..2a52af8c80ace33c 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -318,4 +318,7 @@ int sample__for_each_callchain_node(struct thread *th=
read, struct evsel *evsel,
>                                     struct perf_sample *sample, int max_s=
tack,
>                                     bool symbols, callchain_iter_fn cb, v=
oid *data);
>
> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> +                                    struct perf_sample *sample_callchain=
);
> +
>  #endif /* __PERF_CALLCHAIN_H */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index e8217efdda5323c6..03674d2cbd015e4f 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -85,6 +85,7 @@ void evlist__init(struct evlist *evlist, struct perf_cp=
u_map *cpus,
>         evlist->ctl_fd.pos =3D -1;
>         evlist->nr_br_cntr =3D -1;
>         metricgroup__rblist_init(&evlist->metric_events);
> +       INIT_LIST_HEAD(&evlist->deferred_samples);
>  }
>
>  struct evlist *evlist__new(void)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 5e71e3dc60423079..911834ae7c2a6f76 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -92,6 +92,8 @@ struct evlist {
>          * of struct metric_expr.
>          */
>         struct rblist   metric_events;
> +       /* samples with deferred_callchain would wait here. */
> +       struct list_head deferred_samples;
>  };
>
>  struct evsel_str_handler {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 361e15c1f26a96d0..dc570ad47ccc2c63 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1285,6 +1285,66 @@ static int evlist__deliver_sample(struct evlist *e=
vlist, const struct perf_tool
>                                             per_thread);
>  }
>
> +/*
> + * Samples with deferred callchains should wait for the next matching
> + * PERF_RECORD_CALLCHAIN_RECORD entries.  Keep the events in a list and
> + * deliver them once it finds the callchains.
> + */
> +struct deferred_event {
> +       struct list_head list;
> +       union perf_event *event;
> +};
> +
> +static int evlist__deliver_deferred_callchain(struct evlist *evlist,
> +                                             const struct perf_tool *too=
l,
> +                                             union  perf_event *event,
> +                                             struct perf_sample *sample,
> +                                             struct machine *machine)
> +{
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       if (!tool->merge_deferred_callchains) {
> +               evsel =3D evlist__id2evsel(evlist, sample->id);
> +               return tool->callchain_deferred(tool, event, sample,
> +                                               evsel, machine);
> +       }
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample orig_sample;
> +
> +               ret =3D evlist__parse_sample(evlist, de->event, &orig_sam=
ple);
> +               if (ret < 0) {
> +                       pr_err("failed to parse original sample\n");
> +                       break;
> +               }
> +
> +               if (sample->tid !=3D orig_sample.tid)
> +                       continue;
> +
> +               if (event->callchain_deferred.cookie =3D=3D orig_sample.d=
eferred_cookie)
> +                       sample__merge_deferred_callchain(&orig_sample, sa=
mple);
> +               else
> +                       orig_sample.deferred_callchain =3D false;
> +
> +               evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> +                                            &orig_sample, evsel, machine=
);
> +
> +               if (orig_sample.deferred_callchain)
> +                       free(orig_sample.callchain);
> +
> +               list_del(&de->list);
> +               free(de->event);
> +               free(de);
> +
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
>  static int machines__deliver_event(struct machines *machines,
>                                    struct evlist *evlist,
>                                    union perf_event *event,
> @@ -1313,6 +1373,22 @@ static int machines__deliver_event(struct machines=
 *machines,
>                         return 0;
>                 }
>                 dump_sample(evsel, event, sample, perf_env__arch(machine-=
>env));
> +               if (sample->deferred_callchain && tool->merge_deferred_ca=
llchains) {
> +                       struct deferred_event *de =3D malloc(sizeof(*de))=
;
> +                       size_t sz =3D event->header.size;
> +
> +                       if (de =3D=3D NULL)
> +                               return -ENOMEM;
> +
> +                       de->event =3D malloc(sz);
> +                       if (de->event =3D=3D NULL) {
> +                               free(de);
> +                               return -ENOMEM;
> +                       }
> +                       memcpy(de->event, event, sz);
> +                       list_add_tail(&de->list, &evlist->deferred_sample=
s);
> +                       return 0;
> +               }
>                 return evlist__deliver_sample(evlist, tool, event, sample=
, evsel, machine);
>         case PERF_RECORD_MMAP:
>                 return tool->mmap(tool, event, sample, machine);
> @@ -1372,7 +1448,8 @@ static int machines__deliver_event(struct machines =
*machines,
>                 return tool->aux_output_hw_id(tool, event, sample, machin=
e);
>         case PERF_RECORD_CALLCHAIN_DEFERRED:
>                 dump_deferred_callchain(evsel, event, sample);
> -               return tool->callchain_deferred(tool, event, sample, evse=
l, machine);
> +               return evlist__deliver_deferred_callchain(evlist, tool, e=
vent,
> +                                                         sample, machine=
);
>         default:
>                 ++evlist->stats.nr_unknown_events;
>                 return -1;
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index e77f0e2ecc1f79db..27ba5849c74a2e7d 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -266,6 +266,7 @@ void perf_tool__init(struct perf_tool *tool, bool ord=
ered_events)
>         tool->cgroup_events =3D false;
>         tool->no_warn =3D false;
>         tool->show_feat_hdr =3D SHOW_FEAT_NO_HEADER;
> +       tool->merge_deferred_callchains =3D true;
>
>         tool->sample =3D process_event_sample_stub;
>         tool->mmap =3D process_event_stub;
> @@ -448,6 +449,7 @@ void delegate_tool__init(struct delegate_tool *tool, =
struct perf_tool *delegate)
>         tool->tool.cgroup_events =3D delegate->cgroup_events;
>         tool->tool.no_warn =3D delegate->no_warn;
>         tool->tool.show_feat_hdr =3D delegate->show_feat_hdr;
> +       tool->tool.merge_deferred_callchains =3D delegate->merge_deferred=
_callchains;
>
>         tool->tool.sample =3D delegate_sample;
>         tool->tool.read =3D delegate_read;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 9b9f0a8cbf3de4b5..e96b69d25a5b737d 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -90,6 +90,7 @@ struct perf_tool {
>         bool            cgroup_events;
>         bool            no_warn;
>         bool            dont_split_sample_group;
> +       bool            merge_deferred_callchains;
>         enum show_feature_header show_feat_hdr;
>  };
>
> --
> 2.52.0.rc2.455.g230fcf2819-goog
>

