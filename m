Return-Path: <bpf+bounces-74534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06526C5EC8A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 068A73607B6
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F634572F;
	Fri, 14 Nov 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPoSB3nr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428E3314DD
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142777; cv=none; b=KN95KyVp2ZVV2zRC+Hp6enS2/YNFdr2wI9LM083DRy6gWLdC+3Pt6N54DZqSPeCI4zNzHbkLaaGuMUSrjohacGP/PjzrOEiBdB0UgARVGYwaAPam4XKDLu6/C2hqA658NKzV2TTt9KkGP1DShZOFRF0gU3ahOfPbW5OoqD0WC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142777; c=relaxed/simple;
	bh=V1epEisfHuHh3GtAuTvBst8wMo+m1iJsb0zXvqB0HL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mv9RulBY9/3r3rNbkjM0ocvp7X9Ug7c7RJblA9MB0jM4TW/eJoEo6D5h/QJinoiP18I2ioJw+r5+W7xG0mmfJrh5aBcYu7YVHszSy0aqaNn7NbEBZMs4qHehRm9YGn44ZkM36OqG1GlpJJY+4ui25NfNknq9pRt2kJQ+F/Upsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPoSB3nr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295c64cb951so7515ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763142773; x=1763747573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnNP7vbm7JYBVaxggMbpoWY+2JUFe2coayxhYGSXe/Y=;
        b=LPoSB3nrqyaVMjoa/7GabjY3ZJaYADsTKXxJP5FbrUyRHFUQpJWhXNxbOhKsBJAYk4
         2rSsvOy7JBQFPgPBytMVE5sePyqeR/uYP1j9rR8hcXhBrwwGSBB8Pu97fzQm4I0PYMSn
         6TJHBA/2nudoPdRMzHFzERxxzrBVG0rouI750npgD30NN0xhYEPmxN4dO35vXQjDMXJW
         EYbEs49tIW1QZoB0mnLC/dFf+n7rS2ZbYavMs7LkZUdOZ8IIPol7+7fbOyt/GyB7CaXK
         YB72O0BDlJDCRD/yRhdvLzh0OECD2OjG/6aKPYsbKUmKFgVEkY7JzADFuqO3ub8IhbFe
         VfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142773; x=1763747573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xnNP7vbm7JYBVaxggMbpoWY+2JUFe2coayxhYGSXe/Y=;
        b=Rub4dAaaxA7bc0YMGeqh4U0hZHy3PEzSiQ/zcgwXUaDehrPFqF2AQ30MY9WEIuVzlA
         qg8t2HcdykLvKCBIYpcdw79ROx+6InWo6eLsH4/x/CxujvnIfK95jMEGK52+YjoHgvXr
         C0UH1gwW+kR6xJa/X4vHdc9bpsH7CIEy2QVv7anU6jnHlYyYbsgytMg/inHdAvpTFyj6
         Qklzh5OgIo8AZhUs6chr3rwPFNvZCqi5zDV3yVZ6wIL3rqQ95Frr8k2cBD3Ob9dlIn0E
         UaqiBv8YARg22K/gfKb46oVIj686UDKEWT36jhxvt1xKm1wv4QVCj7N9Qgeg1Yv7pEis
         j30Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqDrRf0qoC8qQXLVhywZFAu4Hw4lFS3FA6/m/uvfQmcktth04sZrcvNogJQXoNeIBUMuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGNLiV0Debz1li6ROlSCbKxvA4+/bqzWJKmBKc8Xs8+HOnBEx
	RYCDaYc2R6iEYk6w0j7WKMLdre+b2LOMt1dpkMtOn9SyYJde+qMkzIAG2p60N0C4v+xOs7SyxHP
	khjxqNicEUTA57Bhn+4D+eN710zzU5WEbkhIo/nsQ
X-Gm-Gg: ASbGncvRW2GvsSn8wTy8oLxNSuxlwqfqE+vxFzFWDrT/SNnb48y6W7kx0H+xEtHuWkP
	IzB25LW3gnXV6BzvPCYYgsxXhnvmlmAgEx1YFo7LErF4qfgCgjTqGYQpwTensRO/dvGliBuOdpE
	930Gi3mYiIenbfow2waZs6jB/iD5qiZPqqZ5sOcsnmkVC+GOW007t0TccBmTlsYmSA0RBcr35k0
	0DJ5gMhZJ+WC1pjc6lKxt1GZmi4qDlzJ5BSbJx1CviZ9atureaI7TQ5iFh2acktZFHRURY8kGXT
	yB5eEivCJfC6IvgQhcPywtwV+ThTuXk00wI=
X-Google-Smtp-Source: AGHT+IH4VOL76R+JyUKRf639P+v7AoPi16fK/WxEWiO6lMJIJ6uvR79aLULzbCNDdcV01UkKQ3j5z3JAEF6kokhdmDE=
X-Received: by 2002:a17:902:d2cd:b0:295:5405:46be with SMTP id
 d9443c01a7336-2986be0e61fmr3852445ad.1.1763142772658; Fri, 14 Nov 2025
 09:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-3-namhyung@kernel.org>
In-Reply-To: <20251114070018.160330-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 09:52:41 -0800
X-Gm-Features: AWmQ_blKOLfyQZQt3UerNOhiuI5xURsF-2q5TNn5cV4-yzgW-aZKwwVZjnno628
Message-ID: <CAP-5=fVrpBjsJ7=BZQmhXKcaN+OYTY5_gOVj-Qs+33cH0gft7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] perf tools: Minimal DEFERRED_CALLCHAIN support
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
> Add a new event type for deferred callchains and a new callback for the
> struct perf_tool.  For now it doesn't actually handle the deferred
> callchains but it just marks the sample if it has the PERF_CONTEXT_
> USER_DEFFERED in the callchain array.
>
> At least, perf report can dump the raw data with this change.  Actually
> this requires the next commit to enable attr.defer_callchain, but if you
> already have a data file, it'll show the following result.
>
>   $ perf report -D
>   ...
>   0x2158@perf.data [0x40]: event: 22
>   .
>   . ... raw event: size 64 bytes
>   .  0000:  16 00 00 00 02 00 40 00 06 00 00 00 0b 00 00 00  ......@.....=
....
>   .  0010:  03 00 00 00 00 00 00 00 a7 7f 33 fe 18 7f 00 00  ..........3.=
....
>   .  0020:  0f 0e 33 fe 18 7f 00 00 48 14 33 fe 18 7f 00 00  ..3.....H.3.=
....
>   .  0030:  08 09 00 00 08 09 00 00 e6 7a e7 35 1c 00 00 00  .........z.5=
....
>
>   121163447014 0x2158 [0x40]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 23=
12/2312: 0xb00000006
>   ... FP chain: nr:3
>   .....  0: 00007f18fe337fa7
>   .....  1: 00007f18fe330e0f
>   .....  2: 00007f18fe331448
>   : unhandled!
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/include/perf/event.h       |  8 ++++++++
>  tools/perf/util/event.c                   |  1 +
>  tools/perf/util/evsel.c                   | 19 +++++++++++++++++++
>  tools/perf/util/machine.c                 |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c |  2 ++
>  tools/perf/util/sample.h                  |  2 ++
>  tools/perf/util/session.c                 | 20 ++++++++++++++++++++
>  tools/perf/util/tool.c                    |  1 +
>  tools/perf/util/tool.h                    |  3 ++-
>  9 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include=
/perf/event.h
> index aa1e91c97a226e1a..769bc48ca85c0eb8 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -151,6 +151,13 @@ struct perf_record_switch {
>         __u32                    next_prev_tid;
>  };
>
> +struct perf_record_callchain_deferred {
> +       struct perf_event_header header;
> +       __u64                    cookie;

Could we add a comment that this value is used to match user and
kernel stack traces together? I don't believe that intent is
immediately obvious from the word "cookie".

> +       __u64                    nr;
> +       __u64                    ips[];
> +};
> +
>  struct perf_record_header_attr {
>         struct perf_event_header header;
>         struct perf_event_attr   attr;
> @@ -523,6 +530,7 @@ union perf_event {
>         struct perf_record_read                 read;
>         struct perf_record_throttle             throttle;
>         struct perf_record_sample               sample;
> +       struct perf_record_callchain_deferred   callchain_deferred;
>         struct perf_record_bpf_event            bpf;
>         struct perf_record_ksymbol              ksymbol;
>         struct perf_record_text_poke_event      text_poke;
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index fcf44149feb20c35..4c92cc1a952c1d9f 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -61,6 +61,7 @@ static const char *perf_event__names[] =3D {
>         [PERF_RECORD_CGROUP]                    =3D "CGROUP",
>         [PERF_RECORD_TEXT_POKE]                 =3D "TEXT_POKE",
>         [PERF_RECORD_AUX_OUTPUT_HW_ID]          =3D "AUX_OUTPUT_HW_ID",
> +       [PERF_RECORD_CALLCHAIN_DEFERRED]        =3D "CALLCHAIN_DEFERRED",
>         [PERF_RECORD_HEADER_ATTR]               =3D "ATTR",
>         [PERF_RECORD_HEADER_EVENT_TYPE]         =3D "EVENT_TYPE",
>         [PERF_RECORD_HEADER_TRACING_DATA]       =3D "TRACING_DATA",
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 989c56d4a23f74f4..244b3e44d090d413 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3089,6 +3089,20 @@ int evsel__parse_sample(struct evsel *evsel, union=
 perf_event *event,
>         data->data_src =3D PERF_MEM_DATA_SRC_NONE;
>         data->vcpu =3D -1;
>
> +       if (event->header.type =3D=3D PERF_RECORD_CALLCHAIN_DEFERRED) {
> +               const u64 max_callchain_nr =3D UINT64_MAX / sizeof(u64);
> +
> +               data->callchain =3D (struct ip_callchain *)&event->callch=
ain_deferred.nr;
> +               if (data->callchain->nr > max_callchain_nr)
> +                       return -EFAULT;
> +
> +               data->deferred_cookie =3D event->callchain_deferred.cooki=
e;
> +
> +               if (evsel->core.attr.sample_id_all)
> +                       perf_evsel__parse_id_sample(evsel, event, data);
> +               return 0;
> +       }
> +
>         if (event->header.type !=3D PERF_RECORD_SAMPLE) {
>                 if (!evsel->core.attr.sample_id_all)
>                         return 0;
> @@ -3219,6 +3233,11 @@ int evsel__parse_sample(struct evsel *evsel, union=
 perf_event *event,
>                 if (data->callchain->nr > max_callchain_nr)
>                         return -EFAULT;
>                 sz =3D data->callchain->nr * sizeof(u64);
> +               if (evsel->core.attr.defer_callchain && data->callchain->=
nr >=3D 2 &&
> +                   data->callchain->ips[data->callchain->nr - 2] =3D=3D =
PERF_CONTEXT_USER_DEFERRED) {
> +                       data->deferred_cookie =3D data->callchain->ips[da=
ta->callchain->nr - 1];
> +                       data->deferred_callchain =3D true;
> +               }

It'd be nice to have a comment saying what is going on here. I can see
that if there are 2 stack slots and the 2nd is a magic value then the
first should be read as the "cookie". At a first look this code is
difficult to parse so a comment would add value.

Thanks,
Ian

>                 OVERFLOW_CHECK(array, sz, max_size);
>                 array =3D (void *)array + sz;
>         }
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index b5dd42588c916d91..841b711d970e9457 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2124,6 +2124,7 @@ static int add_callchain_ip(struct thread *thread,
>                                 *cpumode =3D PERF_RECORD_MISC_KERNEL;
>                                 break;
>                         case PERF_CONTEXT_USER:
> +                       case PERF_CONTEXT_USER_DEFERRED:
>                                 *cpumode =3D PERF_RECORD_MISC_USER;
>                                 break;
>                         default:
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index 66b666d9ce649dd7..741c3d657a8b6ae7 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -343,6 +343,8 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_ev=
ent_attr *attr,
>         PRINT_ATTRf(inherit_thread, p_unsigned);
>         PRINT_ATTRf(remove_on_exec, p_unsigned);
>         PRINT_ATTRf(sigtrap, p_unsigned);
> +       PRINT_ATTRf(defer_callchain, p_unsigned);
> +       PRINT_ATTRf(defer_output, p_unsigned);
>
>         PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events,=
 p_unsigned, false);
>         PRINT_ATTRf(bp_type, p_unsigned);
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index fae834144ef42105..a8307b20a9ea8066 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -107,6 +107,8 @@ struct perf_sample {
>         /** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_c=
yc. */
>         u16 weight3;
>         bool no_hw_idx;         /* No hw_idx collected in branch_stack */
> +       bool deferred_callchain;        /* Has deferred user callchains *=
/
> +       u64 deferred_cookie;
>         char insn[MAX_INSN];
>         void *raw_data;
>         struct ip_callchain *callchain;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4b0236b2df2913e1..361e15c1f26a96d0 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -720,6 +720,7 @@ static perf_event__swap_op perf_event__swap_ops[] =3D=
 {
>         [PERF_RECORD_CGROUP]              =3D perf_event__cgroup_swap,
>         [PERF_RECORD_TEXT_POKE]           =3D perf_event__text_poke_swap,
>         [PERF_RECORD_AUX_OUTPUT_HW_ID]    =3D perf_event__all64_swap,
> +       [PERF_RECORD_CALLCHAIN_DEFERRED]  =3D perf_event__all64_swap,
>         [PERF_RECORD_HEADER_ATTR]         =3D perf_event__hdr_attr_swap,
>         [PERF_RECORD_HEADER_EVENT_TYPE]   =3D perf_event__event_type_swap=
,
>         [PERF_RECORD_HEADER_TRACING_DATA] =3D perf_event__tracing_data_sw=
ap,
> @@ -854,6 +855,9 @@ static void callchain__printf(struct evsel *evsel,
>         for (i =3D 0; i < callchain->nr; i++)
>                 printf("..... %2d: %016" PRIx64 "\n",
>                        i, callchain->ips[i]);
> +
> +       if (sample->deferred_callchain)
> +               printf("...... (deferred)\n");
>  }
>
>  static void branch_stack__printf(struct perf_sample *sample,
> @@ -1123,6 +1127,19 @@ static void dump_sample(struct evsel *evsel, union=
 perf_event *event,
>                 sample_read__printf(sample, evsel->core.attr.read_format)=
;
>  }
>
> +static void dump_deferred_callchain(struct evsel *evsel, union perf_even=
t *event,
> +                                   struct perf_sample *sample)
> +{
> +       if (!dump_trace)
> +               return;
> +
> +       printf("(IP, 0x%x): %d/%d: %#" PRIx64 "\n",
> +              event->header.misc, sample->pid, sample->tid, sample->defe=
rred_cookie);
> +
> +       if (evsel__has_callchain(evsel))
> +               callchain__printf(evsel, sample);
> +}
> +
>  static void dump_read(struct evsel *evsel, union perf_event *event)
>  {
>         struct perf_record_read *read_event =3D &event->read;
> @@ -1353,6 +1370,9 @@ static int machines__deliver_event(struct machines =
*machines,
>                 return tool->text_poke(tool, event, sample, machine);
>         case PERF_RECORD_AUX_OUTPUT_HW_ID:
>                 return tool->aux_output_hw_id(tool, event, sample, machin=
e);
> +       case PERF_RECORD_CALLCHAIN_DEFERRED:
> +               dump_deferred_callchain(evsel, event, sample);
> +               return tool->callchain_deferred(tool, event, sample, evse=
l, machine);
>         default:
>                 ++evlist->stats.nr_unknown_events;
>                 return -1;
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 22a8a4ffe05f778e..f732d33e7f895ed4 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -287,6 +287,7 @@ void perf_tool__init(struct perf_tool *tool, bool ord=
ered_events)
>         tool->read =3D process_event_sample_stub;
>         tool->throttle =3D process_event_stub;
>         tool->unthrottle =3D process_event_stub;
> +       tool->callchain_deferred =3D process_event_sample_stub;
>         tool->attr =3D process_event_synth_attr_stub;
>         tool->event_update =3D process_event_synth_event_update_stub;
>         tool->tracing_data =3D process_event_synth_tracing_data_stub;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 88337cee1e3e2be3..9b9f0a8cbf3de4b5 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -44,7 +44,8 @@ enum show_feature_header {
>
>  struct perf_tool {
>         event_sample    sample,
> -                       read;
> +                       read,
> +                       callchain_deferred;
>         event_op        mmap,
>                         mmap2,
>                         comm,
> --
> 2.52.0.rc1.455.g30608eb744-goog
>

