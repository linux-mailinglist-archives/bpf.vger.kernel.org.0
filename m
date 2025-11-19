Return-Path: <bpf+bounces-75098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80928C7066E
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85E9A4FF539
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB43002CA;
	Wed, 19 Nov 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AV8C9Lyl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07C2D8DD0
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571080; cv=none; b=QJXzU30JzwD5HkjZum4eYpaBKSXpz4/gbLCwcvBOJXJjimzWnJAXLILWJozAKmHWi5R66M3ApYOg3QNKGBFtJm9RM0lGUpG7uP6BA0vdyYIuUw9OrszzcVYMxD2mVM/CVbuNO5d2tHBx3bIIzyYtkTnid4HyI0728aFnDQ7ww/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571080; c=relaxed/simple;
	bh=nQahBAqd9A3uMYOeNF6oDXlCXzdSKi9c1+8wneM3F6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlI+7UYhLKGEa8aa+LDAMBXMGmsq6K+SHby66Ef9MIM7JnzKrfAlM4bJu8QWJpnJhUgojIBWy/9FDPGZh2dXyifjPkNfbOkk7b7BW0XDlO4fWIeiEuwmjObZoMLl7W2LbhDPwuCWSM4g4xK3LJOdQyMZzzXX/JHfiAXGbKVSjH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AV8C9Lyl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29852dafa7dso220485ad.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763571077; x=1764175877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=attkz3hb2o7VbwjOaioSYx2TafHXy4IEgJE4uz2Nb8w=;
        b=AV8C9LylZaElFN3IB9FCZo3QLqAaP59K7xou7c3VRi/lRQ+k0wCA9myJG4XG5jWvFt
         VCham5Eik97aoF8Vc8rv0nNPjwKxErjwruIJclrYSxIMhkHrGNdPTNeDrXpawQYIJnF9
         Q3xGsnpEnph5WQzXKls+GYoP0MCZIRkZ1Aa1lwAStm/0rhFv4ubbCFIVrCDw1L2+X7Aa
         ah2KjoxhxJZlWS83H2mAXDibyAs72/YSwKQsgbiSkqGeEAdh2hdk7vWAg8jBd9FvdnPU
         uwD08VhhJkoP1V7WpnH2amaRcbC20RAnaA2mkYg+zfmp5l5BWEb1mrbZYNlnFM3SzkEH
         8f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571077; x=1764175877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=attkz3hb2o7VbwjOaioSYx2TafHXy4IEgJE4uz2Nb8w=;
        b=MIEcKNqu/xGtLwhpbdafOt+cTynOBE4TPZ2YZYXeqzlHIB9KpagApFJyO1Hq0hvLbL
         AN2O3bSVMCOpAupK4U60A+SozqPlSkb85scxL0mTu6sqQXo5gKeSop5zoUt/62jCl71j
         /WNctcZVow65eH5CE7M2C7xN4pXsPQDORSGlyuLYPTOX5e+fRoR4/Q7NB2xjNE3ZoTsL
         Ki7JiEGt3WpYEraDgOTC2ICDiz0tSMlqkGAw1lz+ebJSXwg3lbIGBYIZ8nDh36SACCDt
         4JyRtow11MdaZhR7l2iUodfBigt10luhAOlAX4COlpGpfGvtKz+ZZJ7zpAzazojV6r+F
         AQoA==
X-Forwarded-Encrypted: i=1; AJvYcCVVStwkoMfXIoeFDsDWeQJK/VBz/GsL8D2lIzmFY2/50CRH2gCtVMhuTmQoWVzg1iFknSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeG0OIzjW/qlIllYYfnDi9upr/6kgY7RWyziIJh4vRY5SZLw2U
	NNd61UO8mYBleL5qZX/9a7L3T+mSTa7SM8TdLDhZIiylhmNEt7VvjK+Rm50sRtClHje0kAnCNlK
	7FleWPnS/DIdK7XjvOZixxgsU9htGQmdk7WuPsB41
X-Gm-Gg: ASbGnctkkbard7fvMLeHDFBD3jR7aEiFpHfEnDooUtMOy7Yl6oVWl/ccH3ufrk9zcwn
	f5eqUCUp858C5PQ7Qqi/PP+AlDdJwlVDhSJIIsL+jhLE/Vl/rXG5pQvFKL4FoBM+7RFi51zY1QD
	N0ezM02fvQnvQ8MpVPoUshbIrPtEO+guqLFjmCs6QoskcEyvhOGdOZkFLR3x4vaXfISCinVRfIe
	UBJQ6gt5QXAQ1oPewHxG50ZhP/zDqbz3teZIyy0033WjJMcLaUFGx8kFGbzMg7j9tgidbworM0K
	PPTU8KuuvWIerZj0x0YC/3Zm5Q==
X-Google-Smtp-Source: AGHT+IGrGYmUdrGNbrEcCZ2Lb4w2x+nf21XgWAqygnecEbVd8wlT3Q9897677EaPK3Vxzh6+WC7cCcn8YEmMGBQAJHo=
X-Received: by 2002:a05:7022:670b:b0:11a:fcc8:c311 with SMTP id
 a92af1059eb24-11c8ddae885mr129688c88.5.1763571076468; Wed, 19 Nov 2025
 08:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115234106.348571-1-namhyung@kernel.org> <20251115234106.348571-5-namhyung@kernel.org>
In-Reply-To: <20251115234106.348571-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:50:57 -0800
X-Gm-Features: AWmQ_bnVKO8c9bXEJsrfvioIgEOHmv-1NhmRxz-5e6N8fNNM-Nya4lwaQhItlno
Message-ID: <CAP-5=fUXrUE7gkQMqkXiW6NurarrW7O-ey5punwX3LH-e_ma-g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
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
> Handle the deferred callchains in the script output.
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
>                  b00000006 (cookie) ([unknown])
>
>   pwd    2312   121.163447: DEFERRED CALLCHAIN [cookie: b00000006]
>               7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x=
86-64.so.2)
>               7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/l=
d-linux-x86-64.so.2)
>               7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-l=
inux-x86-64.so.2)
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c     | 89 +++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel_fprintf.c |  5 +-
>  2 files changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 011962e1ee0f6898..85b42205a71b3993 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2706,6 +2706,94 @@ static int process_sample_event(const struct perf_=
tool *tool,
>         return ret;
>  }
>
> +static int process_deferred_sample_event(const struct perf_tool *tool,
> +                                        union perf_event *event,
> +                                        struct perf_sample *sample,
> +                                        struct evsel *evsel,
> +                                        struct machine *machine)
> +{
> +       struct perf_script *scr =3D container_of(tool, struct perf_script=
, tool);
> +       struct perf_event_attr *attr =3D &evsel->core.attr;
> +       struct evsel_script *es =3D evsel->priv;
> +       unsigned int type =3D output_type(attr->type);
> +       struct addr_location al;
> +       FILE *fp =3D es->fp;
> +       int ret =3D 0;
> +
> +       if (output[type].fields =3D=3D 0)
> +               return 0;
> +
> +       /* Set thread to NULL to indicate addr_al and al are not initiali=
zed */
> +       addr_location__init(&al);
> +
> +       if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_nu=
m,
> +                                         sample->time)) {
> +               goto out_put;
> +       }
> +
> +       if (debug_mode) {
> +               if (sample->time < last_timestamp) {
> +                       pr_err("Samples misordered, previous: %" PRIu64
> +                               " this: %" PRIu64 "\n", last_timestamp,
> +                               sample->time);
> +                       nr_unordered++;
> +               }
> +               last_timestamp =3D sample->time;
> +               goto out_put;
> +       }
> +
> +       if (filter_cpu(sample))
> +               goto out_put;
> +
> +       if (machine__resolve(machine, &al, sample) < 0) {
> +               pr_err("problem processing %d event, skipping it.\n",
> +                      event->header.type);
> +               ret =3D -1;
> +               goto out_put;
> +       }
> +
> +       if (al.filtered)
> +               goto out_put;
> +
> +       if (!show_event(sample, evsel, al.thread, &al, NULL))
> +               goto out_put;
> +
> +       if (evswitch__discard(&scr->evswitch, evsel))
> +               goto out_put;
> +
> +       perf_sample__fprintf_start(scr, sample, al.thread, evsel,
> +                                  PERF_RECORD_CALLCHAIN_DEFERRED, fp);
> +       fprintf(fp, "DEFERRED CALLCHAIN [cookie: %llx]",
> +               (unsigned long long)event->callchain_deferred.cookie);
> +
> +       if (PRINT_FIELD(IP)) {
> +               struct callchain_cursor *cursor =3D NULL;
> +
> +               if (symbol_conf.use_callchain && sample->callchain) {
> +                       cursor =3D get_tls_callchain_cursor();
> +                       if (thread__resolve_callchain(al.thread, cursor, =
evsel,
> +                                                     sample, NULL, NULL,
> +                                                     scripting_max_stack=
)) {
> +                               pr_info("cannot resolve deferred callchai=
ns\n");
> +                               cursor =3D NULL;
> +                       }
> +               }
> +
> +               fputc(cursor ? '\n' : ' ', fp);
> +               sample__fprintf_sym(sample, &al, 0, output[type].print_ip=
_opts,
> +                                   cursor, symbol_conf.bt_stop_list, fp)=
;
> +       }
> +
> +       fprintf(fp, "\n");
> +
> +       if (verbose > 0)
> +               fflush(fp);
> +
> +out_put:
> +       addr_location__exit(&al);
> +       return ret;
> +}
> +
>  // Used when scr->per_event_dump is not set
>  static struct evsel_script es_stdout;
>
> @@ -4303,6 +4391,7 @@ int cmd_script(int argc, const char **argv)
>
>         perf_tool__init(&script.tool, !unsorted_dump);
>         script.tool.sample               =3D process_sample_event;
> +       script.tool.callchain_deferred   =3D process_deferred_sample_even=
t;
>         script.tool.mmap                 =3D perf_event__process_mmap;
>         script.tool.mmap2                =3D perf_event__process_mmap2;
>         script.tool.comm                 =3D perf_event__process_comm;
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fpri=
ntf.c
> index 103984b29b1e10ae..10f1a03c28601e36 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -168,7 +168,10 @@ int sample__fprintf_callchain(struct perf_sample *sa=
mple, int left_alignment,
>                                 node_al.addr =3D addr;
>                                 node_al.map  =3D map__get(map);
>
> -                               if (print_symoffset) {
> +                               if (sample->deferred_callchain &&
> +                                   sample->deferred_cookie =3D=3D node->=
ip) {
> +                                       printed +=3D fprintf(fp, "(cookie=
)");
> +                               } else if (print_symoffset) {
>                                         printed +=3D __symbol__fprintf_sy=
mname_offs(sym, &node_al,
>                                                                          =
         print_unknown_as_addr,
>                                                                          =
         true, fp);
> --
> 2.52.0.rc1.455.g30608eb744-goog
>

