Return-Path: <bpf+bounces-74537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3C4C5ECD3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3D2A359A8D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B042D9494;
	Fri, 14 Nov 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US3Y6Uqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6262D7DCF
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143780; cv=none; b=t9ciwvkMQa605igkKHuu2qjXUWK8kWgZdgRfNChmpQFucrFb7gsTAvA2vGTGoy9jbw3r+Ju5bJ+U9sry6qd7J5zR+vLjaPh67vcWOO2SGjcW+5eQBO4Wd5MMg74r2ZNgTGYBxtTfESYT9GjpnkaPWO8Q3HZJLF8bfRUwcM9bShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143780; c=relaxed/simple;
	bh=Qj116r8wG94UQP8HjtmaoROir+nPfu7YP7mgjorqEeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULF4Thb6l+rB7aF+eSwoJiQegI12Qfox4m4EgN304U8dhvsh+WsSVOMgu9qoo1+rgPagn3kmBRIF2h1jfm+uO+kyWu3it3ImeQeVbCGeuPT28oxckQj4F/1vSQWE7Rzd5g64zeMy3/5ahwUdWAAVjsMaAKJlE0fkJSoalcuMTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=US3Y6Uqw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2980343d9d1so7495ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763143778; x=1763748578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfcSJqzizlhSMZ3ziZWThpj9SQiWBkXkKqqv5cpvGYI=;
        b=US3Y6UqwRkJqshkXbTJfrg4vGkHKRB4dnsptZ7Cyu2WXxrRaA8beBYRiXMg1wRPgNu
         CSkVymHkfVRJwc7WOn5+kqo5b34Q5zIJc8lOj56WSGLjCwo/NLxSzfvFFrRgF61gw4RR
         6WaF0zE/KZclyh1XMxh8gv/0PiSM1FXTU7/iEncwvt5/MlWrWmGKp6/Osds5grdqRvi9
         817islbFGGmS7706k0t1H0M7BDQpLPfrNUZRz8Yd+kcn8Wc6HeeqsDDZ7UCFKQq+RGD2
         nYjldWubvd6SM7fJ8fVe1G+m8Cq5H1GRC/HI3Q3Adyug6ExSl2Qvzr0rP4no3XvlBfdn
         jyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143778; x=1763748578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfcSJqzizlhSMZ3ziZWThpj9SQiWBkXkKqqv5cpvGYI=;
        b=bY+r321wYMc4QNEqmCWur8vRSkJR2YppWj+trkH2scywAFDRnH1y0+qoDdCtHATcsa
         +K8vn1lALcHshjsthTf+SEGennS43Y6JLrNGTn+GkkiLU/LtRqZYE0zd79wM5hg/BUXu
         31Mf1L/DxtlrmrUDsHZxrZvYSz0/1kNqXZsqp6BL/BMnUsTW0lcZL7dcGtM5FCygtwWx
         Lr8EUCdG14GTsFD3X838+/tPctclacvej/s1seU5aoU5CtJRZSowd5pMDshzt409fRbX
         F/PxmTk7shZGZ+X+m3443RGW2WqkIP3ofY1JM/v1pSUL8BXRIZa8YB4m3tIAO4JzETG0
         hc1A==
X-Forwarded-Encrypted: i=1; AJvYcCVlGrzWo5aVGHQVFTRI5Q99PvuFAxBV5pv80pBOOg3Yyc0QD++lrmk0Sy7VwwnsbYMiylY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0TI45oc3Kiap+qHCG99ByM24Q8wnbMihNlNO3e8P9CbgAOLM
	p/jmGVpJ/HNA4LMTjBHZIoRP1vOQcXrzM1l/Zm/vXcTvWok27MJ9lpRmae1tg0O/SS0u39ElvtX
	NEZCp18r3XQ1SbcQfWVAniR28Lu3RhGt62lHYtGkU
X-Gm-Gg: ASbGncvl4uMwZyNbf7hRIG6+sStCbIk98jvhVsWEWSMC6lZ9YWzR2NA7af8CEQkjAGq
	thlRogY1/Dy5KSZDKuz0MWk9ijvhsuDPtdSzpTjTaoJR/PANIerGMD+gVCObgEj/YglBoStIkWK
	b4XvBQGyHpE8TLLKGy9/cDRuAhOcNBKugeSo/4v8iznxfccEhy1irwkV2kw6FFCncYIT7NYowT8
	JGjuf52UA+3LfJvJEX5qHOaG3bj5JjVrkjUlDmRvmQI1yl0HNFgYlWQtFfpgq7pN/maq0FcJ2BR
	absfyBLRHCklj4j+kCuXZ1bNdIDSUzJXDFo=
X-Google-Smtp-Source: AGHT+IGSH8Q5Hx2fAj5bpeGSWWCqADuyQwea6eN6EYBSBSBCh5PDFPAqU8+s4PDS9iapi7mwfKh7q4oETvX7OtfUiAQ=
X-Received: by 2002:a17:903:d6:b0:299:c368:6b20 with SMTP id
 d9443c01a7336-299c3686cc1mr621875ad.19.1763143777713; Fri, 14 Nov 2025
 10:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-4-namhyung@kernel.org>
 <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
In-Reply-To: <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 10:09:26 -0800
X-Gm-Features: AWmQ_bnZnAiZcOS_HogfEOCWSgRPcWbe1_ehB7Nxn39aC03IKS0EhbntdbV7U1k
Message-ID: <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user callchains
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

On Fri, Nov 14, 2025 at 9:59=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Nov 13, 2025 at 11:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > And add the missing feature detection logic to clear the flag on old
> > kernels.
> >
> >   $ perf record -g -vv true
> >   ...
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             0 (PERF_TYPE_HARDWARE)
> >     size                             136
> >     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     mmap                             1
> >     comm                             1
> >     freq                             1
> >     enable_on_exec                   1
> >     task                             1
> >     sample_id_all                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >     defer_callchain                  1
> >     defer_output                     1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
> >   sys_perf_event_open failed, error -22
> >   switching off deferred callchain support
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
> >  tools/perf/util/evsel.h |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 244b3e44d090d413..f5652d00b457d096 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1061,6 +1061,14 @@ static void __evsel__config_callchain(struct evs=
el *evsel, struct record_opts *o
> >                 }
> >         }
> >
> > +       if (param->record_mode =3D=3D CALLCHAIN_FP && !attr->exclude_ca=
llchain_user) {
> > +               /*
> > +                * Enable deferred callchains optimistically.  It'll be=
 switched
> > +                * off later if the kernel doesn't support it.
> > +                */
> > +               attr->defer_callchain =3D 1;
> > +       }
>
> If a user has requested frame pointer call chains why would they want
> deferred call chains? The point of deferral to my understanding is to
> allow the paging in of debug data, but frame pointers don't need that
> as the stack should be in the page cache.
>
> Is this being done for code coverage reasons so that deferral is known
> to work for later addition of SFrames? In which case this should be an
> opt-in not default behavior. When there is a record_mode of
> CALLCHAIN_SFRAME then making deferral the default for that mode makes
> sense, but not for frame pointers IMO.

Just to be clear. I don't think the behavior of using frame pointers
should change. Deferral has downsides, for example:

  $ perf record -g -a sleep 1

Without deferral kernel stack traces will contain both kernel and user
traces. With deferral the user stack trace is only generated when the
system call returns and so there is a chance for kernel stack traces
to be missing their user part. An obvious behavioral change. I think
for what you are doing here we can have an option something like:

  $ perf record --call-graph fp-deferred -a sleep 1

Which would need a man page update, etc. What is happening with the
other call-graph modes and deferral? Could the option be something
like `--call-graph fp,deferred` so that the option is a common one and
say stack snapshots for dwarf be somehow improved?

Thanks,
Ian

> Thanks,
> Ian
>
> > +
> >         if (function) {
> >                 pr_info("Disabling user space callchains for function t=
race event.\n");
> >                 attr->exclude_callchain_user =3D 1;
> > @@ -1511,6 +1519,7 @@ void evsel__config(struct evsel *evsel, struct re=
cord_opts *opts,
> >         attr->mmap2    =3D track && !perf_missing_features.mmap2;
> >         attr->comm     =3D track;
> >         attr->build_id =3D track && opts->build_id;
> > +       attr->defer_output =3D track;
> >
> >         /*
> >          * ksymbol is tracked separately with text poke because it need=
s to be
> > @@ -2199,6 +2208,10 @@ static int __evsel__prepare_open(struct evsel *e=
vsel, struct perf_cpu_map *cpus,
> >
> >  static void evsel__disable_missing_features(struct evsel *evsel)
> >  {
> > +       if (perf_missing_features.defer_callchain && evsel->core.attr.d=
efer_callchain)
> > +               evsel->core.attr.defer_callchain =3D 0;
> > +       if (perf_missing_features.defer_callchain && evsel->core.attr.d=
efer_output)
> > +               evsel->core.attr.defer_output =3D 0;
> >         if (perf_missing_features.inherit_sample_read && evsel->core.at=
tr.inherit &&
> >             (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
> >                 evsel->core.attr.inherit =3D 0;
> > @@ -2473,6 +2486,13 @@ static bool evsel__detect_missing_features(struc=
t evsel *evsel, struct perf_cpu
> >
> >         /* Please add new feature detection here. */
> >
> > +       attr.defer_callchain =3D true;
> > +       if (has_attr_feature(&attr, /*flags=3D*/0))
> > +               goto found;
> > +       perf_missing_features.defer_callchain =3D true;
> > +       pr_debug2("switching off deferred callchain support\n");
> > +       attr.defer_callchain =3D false;
> > +
> >         attr.inherit =3D true;
> >         attr.sample_type =3D PERF_SAMPLE_READ | PERF_SAMPLE_TID;
> >         if (has_attr_feature(&attr, /*flags=3D*/0))
> > @@ -2584,6 +2604,10 @@ static bool evsel__detect_missing_features(struc=
t evsel *evsel, struct perf_cpu
> >         errno =3D old_errno;
> >
> >  check:
> > +       if ((evsel->core.attr.defer_callchain || evsel->core.attr.defer=
_output) &&
> > +           perf_missing_features.defer_callchain)
> > +               return true;
> > +
> >         if (evsel->core.attr.inherit &&
> >             (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
> >             perf_missing_features.inherit_sample_read)
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 3ae4ac8f9a37e009..a08130ff2e47a887 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -221,6 +221,7 @@ struct perf_missing_features {
> >         bool branch_counters;
> >         bool aux_action;
> >         bool inherit_sample_read;
> > +       bool defer_callchain;
> >  };
> >
> >  extern struct perf_missing_features perf_missing_features;
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
> >

