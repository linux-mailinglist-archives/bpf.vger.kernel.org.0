Return-Path: <bpf+bounces-74544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48BC5EE43
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C533B18C3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BAE2DC34D;
	Fri, 14 Nov 2025 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWekDByP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042E2DA762
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145394; cv=none; b=szs0MKb2st0zVydQ5rOgDl32k0KEtlj3NulCKAkBjykfQwSz3UFJsmzEvpxrdi1+6bTCeBe+6/uwbD39Plq0oNAh51bwN/hiWLddirSO/JOX1VO5KKW1PBVPRZCWbvfIUg5q6bIglZZ+zpgAOOdTBbM8xaTvi2jE2F3JhEYlIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145394; c=relaxed/simple;
	bh=Eo7W31nEJuAaR6/dAndrqjEkhWeYBwfJogWhTovRSMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NktLuFmTFvA8kmvguLStFZsF7rt2tbTT3g1ydxDE941th53HT5x2/N/xwSmegrvofhyddcJFL+66HyYllAPdbNrOeixRTOy3lLqvjewiM0bG8jzL4Vp6RjPJ16V7bbTXLdyoVeiYotdFsL59TlvglOwd0gNq63VRzElY6I7Wypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWekDByP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29852dafa7dso15325ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763145391; x=1763750191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXpd5A+XxrnjyJGcA7eEGQuZn+syQZ95+bHbmkBw0TU=;
        b=XWekDByPmcv/ojW7242Vl7SimnnF0x/YnMjEp+/0B6V0BDD/baY8+faeyRYMHSRDGC
         aafGGZIc58qrUFnhjjTUhh/RfBSeceiI/e+aDcIthqr5H15xNb3g3ldGUrB1orn7uQYh
         lyzAgHBY9VGh78DxUXufEMaj9Tqj1wOWaseUQxMKZIt+XbVOJPosFduFIUw0gWu+8KOT
         WSiIHLpbwyuxQkSFLUXXgF12IPhU+eS2WxcqoIbsVbIjHVZlQohlHc0JKVlH4AfJ/rgH
         Ub3Qt2Q9q0amqj5Q62LRp8NZjd4IxcajIwXWUNPbXFa7lweKjneNT6uPxd11+OS/sweh
         51YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763145391; x=1763750191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXpd5A+XxrnjyJGcA7eEGQuZn+syQZ95+bHbmkBw0TU=;
        b=V+pbKevx1BJ3EwAvTp/uZKCxnLMC9icz8BB5izTbNRqj0lG86M4bAIQE63xhkVa3z1
         I634W+rxlVOZFbvg1EaAIZMYBFKrafwVUx1DcbqMzhcnwnxcgxeWB2fAqwB362sLaMv1
         HzM9srncOs2qDQ5g3mljL5ozxX7lDBIzh+YDToekJWfxZPTonZHL7tiLorBwyA4+tvm8
         c76yrTZpdMk39QNII6mNJwh6ImCS6qIVr5mJGG1DOvpSFDT8ORUU3zq0kRIUALbLTkKI
         ncHSL2CTPSuNhNPBg6n8+5LZ6OfAVcUjE4coxbYzBXBXaUkSo2GLY0efEJSlS0r6BxlW
         uqSw==
X-Forwarded-Encrypted: i=1; AJvYcCVxuFthRSVZzrMc1/orViys9mv8f7ynHolywMdnOFL7VSCF/Adhnvx6MybOaEpCATrfxvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6I4XyoQN/EI4qAuNZ7IQH5uRoWCkFPOGMZ1sDUBM1FRZKpaSr
	evzDUgXecSgyh38uvkSNVpZEgGKOmB15AS8Z4ZkUw2DzuCj7ExUgw5l5sc6kmYFtSZjbP4nmu1U
	xHLl5wroi4bdTht+1ZYhoE3JEkvamztdc8eu260JjHMm9xBp+IJ9zJVc9kBo=
X-Gm-Gg: ASbGncsSgMRCagd4a/hfArbhM10XXGwqICWg6yoSWnRm3naWYdb/RRAHv0CsvYu1l3t
	Zj2O7c2/vtX4lv2ZteU1NJSBHggjKcwCkhnBLQMubAAnW+4n4rECKw76I+flMBlmwNo/a9QpOUr
	CP56vau/PGK4EphV3NBNevCXA5/M7MJ5yz4C3hFsQrj/qB9mpnfScI74LgJFwexEICQuO1+9OQ+
	0TripX+FdgImyxczc18B8vY9dAKNIxWka3jlz5fvOlw6movAIe5KJ2ZSGciGxSoZjielvQlv9WA
	yIyIJwtoLfvjV1uVc9ze96RI
X-Google-Smtp-Source: AGHT+IHPcRglCxEYzheUnmCjTj6+edhDuRs/YjYRHaf7sJqGj02ri3PhPl2KN8Z8lxdcpauZGOgY7GfcltpwpOKDsb0=
X-Received: by 2002:a17:903:2a83:b0:298:4819:f4d9 with SMTP id
 d9443c01a7336-299c6b24636mr184195ad.8.1763145390784; Fri, 14 Nov 2025
 10:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-6-namhyung@kernel.org>
In-Reply-To: <20251114070018.160330-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 10:36:18 -0800
X-Gm-Features: AWmQ_blBNQ1pqKRCZEs-2PgH8OGNf-EFmiApQUauTak2B5LjokT0WjwUy0qlaT0
Message-ID: <CAP-5=fWN00y2nrt1AUPKEndVEhDRFV=Vtc2p1m_k3uNL8o=Ybw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] perf tools: Merge deferred user callchains
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

On Thu, Nov 13, 2025 at 11:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
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
> ---
>  tools/perf/Documentation/perf-script.txt |  5 ++
>  tools/perf/builtin-inject.c              |  1 +
>  tools/perf/builtin-report.c              |  1 +
>  tools/perf/builtin-script.c              |  5 +-
>  tools/perf/util/callchain.c              | 29 ++++++++++
>  tools/perf/util/callchain.h              |  3 ++
>  tools/perf/util/evlist.c                 |  1 +
>  tools/perf/util/evlist.h                 |  2 +
>  tools/perf/util/session.c                | 67 +++++++++++++++++++++++-
>  tools/perf/util/tool.c                   |  1 +
>  tools/perf/util/tool.h                   |  1 +
>  11 files changed, 114 insertions(+), 2 deletions(-)
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
> index 044074080aa53abd..30ae38212f57580a 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2542,6 +2542,7 @@ int cmd_inject(int argc, const char **argv)
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
> index 3b2896350bad2924..2374c7a1684028cc 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4025,6 +4025,7 @@ int cmd_script(int argc, const char **argv)
>         bool header_only =3D false;
>         bool script_started =3D false;
>         bool unsorted_dump =3D false;
> +       bool merge_deferred_callchains =3D true;
>         char *rec_script_path =3D NULL;
>         char *rep_script_path =3D NULL;
>         struct perf_session *session;
> @@ -4178,6 +4179,8 @@ int cmd_script(int argc, const char **argv)
>                     "Guest code can be found in hypervisor process"),
>         OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
>                     "Enable LBR callgraph stitching approach"),
> +       OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
> +                   "Enable merge deferred user callchains"),
>         OPTS_EVSWITCH(&script.evswitch),
>         OPT_END()
>         };
> @@ -4434,7 +4437,7 @@ int cmd_script(int argc, const char **argv)
>         script.tool.throttle             =3D process_throttle_event;
>         script.tool.unthrottle           =3D process_throttle_event;
>         script.tool.ordering_requires_timestamps =3D true;
> -       script.tool.merge_deferred_callchains =3D false;
> +       script.tool.merge_deferred_callchains =3D merge_deferred_callchai=
ns;
>         session =3D perf_session__new(&data, &script.tool);
>         if (IS_ERR(session))
>                 return PTR_ERR(session);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index d7b7eef740b9d6ed..a0a0e6784420d478 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1828,3 +1828,32 @@ int sample__for_each_callchain_node(struct thread =
*thread, struct evsel *evsel,
>         }
>         return 0;
>  }
> +
> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> +                                    struct perf_sample *sample_callchain=
)

Would sample_kernel and sample_user be clearer names here? Perhaps
sample_deferred_kernel.

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

I don't follow "but the cookie", do you mean "but not the cookie" ?

> +       memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * siz=
eof(u64));
> +       /* copy deferred user callchains */
> +       memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips=
,
> +              nr_deferred * sizeof(u64));
> +

assert(sample_orig->callchain =3D=3D NULL);

> +       sample_orig->callchain =3D callchain;
> +       return 0;
> +}
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 86ed9e4d04f9ee7b..89785125ed25783d 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -317,4 +317,7 @@ int sample__for_each_callchain_node(struct thread *th=
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

Please document which struct is on the list.

>  };
>
>  struct evsel_str_handler {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 361e15c1f26a96d0..2e777fd1bcf6707b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1285,6 +1285,60 @@ static int evlist__deliver_sample(struct evlist *e=
vlist, const struct perf_tool
>                                             per_thread);
>  }
>
> +struct deferred_event {
> +       struct list_head list;
> +       union perf_event *event;
> +};

Given the list is in evlist.h, could we put this at the top of the
file so that you don't need to search down for it. Comments on where
the list is held and life time of the event would be useful.

> +
> +static int evlist__deliver_deferred_samples(struct evlist *evlist,
> +                                           const struct perf_tool *tool,
> +                                           union  perf_event *event,
> +                                           struct perf_sample *sample,
> +                                           struct machine *machine)
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
> @@ -1313,6 +1367,16 @@ static int machines__deliver_event(struct machines=
 *machines,
>                         return 0;
>                 }
>                 dump_sample(evsel, event, sample, perf_env__arch(machine-=
>env));
> +               if (sample->deferred_callchain && tool->merge_deferred_ca=
llchains) {
> +                       struct deferred_event *de =3D malloc(sizeof(*de))=
;
> +
> +                       if (de =3D=3D NULL)
> +                               return -ENOMEM;
> +
> +                       de->event =3D event;

I'm not sure how this is safe. Don't you need to copy the event at
this point? An event may be in a ring buffer, file, or some memory.
Generally the event can only be used in the context of the tool
callback and not for longer. Similarly with the perf_sample as that
has pointers into the event.

Thanks,
Ian

> +                       list_add_tail(&de->list, &evlist->deferred_sample=
s);
> +                       return 0;
> +               }
>                 return evlist__deliver_sample(evlist, tool, event, sample=
, evsel, machine);
>         case PERF_RECORD_MMAP:
>                 return tool->mmap(tool, event, sample, machine);
> @@ -1372,7 +1436,8 @@ static int machines__deliver_event(struct machines =
*machines,
>                 return tool->aux_output_hw_id(tool, event, sample, machin=
e);
>         case PERF_RECORD_CALLCHAIN_DEFERRED:
>                 dump_deferred_callchain(evsel, event, sample);
> -               return tool->callchain_deferred(tool, event, sample, evse=
l, machine);
> +               return evlist__deliver_deferred_samples(evlist, tool, eve=
nt,
> +                                                       sample, machine);
>         default:
>                 ++evlist->stats.nr_unknown_events;
>                 return -1;
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index f732d33e7f895ed4..c5d3b464b2a433b3 100644
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
> 2.52.0.rc1.455.g30608eb744-goog
>

