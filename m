Return-Path: <bpf+bounces-13051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE17D3F85
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AED1B20ED8
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8120219F0;
	Mon, 23 Oct 2023 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrElkOID"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256702135D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 18:49:19 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17682FD
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:49:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507c9305727so523e87.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698086955; x=1698691755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBjinH4YO+2hSUCb0fHvQc14NdFtTudqRmx2oJc8QDw=;
        b=TrElkOIDdyHkGZa2pRqKHPMC2NkI6Pq7qjDIfwRadW3PlIiE1h3Vv9JcMJibH27puR
         MEikxWSGsP5qLk360CnuDxauE0ml/KeLfYGAlVwsp5ovPlJ4sbkMVsNGK22nioLeHwDs
         e/rd8XHzvbsiLXcK5isXGTLFhqCIABnabKWlR3vtJoy1y3pE8t2BpFv7h9nQGgGx5B8V
         HE2ZSUE78xw6OI/Eh23MHOfaWispUUBE2hZTXbEJcrg2cMcuL13XbAZ8irMsZgk3tnH/
         jX2qbEnIK8pnxazzIw4XlFWW/dRBuj3m6kwFgCIA2Cpkp0JqPHrf5TaQWVgrCyvGmJbA
         cpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086955; x=1698691755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBjinH4YO+2hSUCb0fHvQc14NdFtTudqRmx2oJc8QDw=;
        b=qgu6Gdi0/0m8ELRaf+/kbTSZhclsJy6Te/QQCW9mAqGTewXRSIj7F7ZDfuJHHU3R4o
         kyMLcxs54rX17Dp6WC58y14fyTT1R+fWZJSC40rivis5wd3HEB/NMqndSOFldYjwuj4X
         LIa//mlbcsVN2fs7rHdzQ2F4lG63xrFXkh7/deLXnFm/NiM5Ik8R7XtZYzWVCcBD4biU
         4Vj03qhGK9bijgtMYWDcsJuWC+wWdXMDszgcAcM+dmou9YnBogAy+BYEvbx/VFEE/4ly
         PoznrVptiBhT55ZhzYTzWaVzYkx+0x2gO+AFZHZJeX7g8lHnupjss1UrQtLDedtC7M4Q
         cnjw==
X-Gm-Message-State: AOJu0YzcsEFgsEpkhQ8KFi64ZY5B9bSjm0pTeqBVDL30sa4FjK/MPNy1
	FcN/zjTDGjPgmnG2sDm+GEKn4A4ZKvF+AjqTMyv1HQ==
X-Google-Smtp-Source: AGHT+IFsxngWQhbFKtMr0Js2ydVoCXWOs+SxuSLi0Ti01Tz+Tm1+dUsdRUXa9JduZgph4C0uK5fDC5ziqAwjQgo39Kw=
X-Received: by 2002:a05:6512:3685:b0:505:7c88:9e45 with SMTP id
 d5-20020a056512368500b005057c889e45mr14376lfs.0.1698086954981; Mon, 23 Oct
 2023 11:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-14-irogers@google.com>
 <c04c196a-3f29-4b89-97a7-5e71def3d3ce@intel.com>
In-Reply-To: <c04c196a-3f29-4b89-97a7-5e71def3d3ce@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Oct 2023 11:49:00 -0700
Message-ID: <CAP-5=fX303b8-hQXWaRibtYFyBS2sQywDSKR6KhKMUMX_0gzrw@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf machine thread: Remove exited threads by default
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 7:24=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 12/10/23 09:23, Ian Rogers wrote:
> > struct thread values hold onto references to mmaps, dsos, etc. When a
> > thread exits it is necessary to clean all of this memory up by
> > removing the thread from the machine's threads. Some tools require
> > this doesn't happen, such as perf report if offcpu events exist or if
> > a task list is being generated, so add a symbol_conf value to make the
> > behavior optional. When an exited thread is left in the machine's
> > threads, mark it as exited.
> >
> > This change relates to commit 40826c45eb0b ("perf thread: Remove
> > notion of dead threads"). Dead threads were removed as they had a
> > reference count of 0 and were difficult to reason about with the
> > reference count checker. Here a thread is removed from threads when it
> > exits, unless via symbol_conf the exited thread isn't remove and is
> > marked as exited. Reference counting behaves as it normally does.
>
> Can we exclude AUX area tracing?
>
> Essentially, the EXIT event happens when the task is still running
> in kernel mode, so the thread has not in fact fully exited.
>
> Example:
>
> # perf record -a --kcore -e intel_pt// uname
>
> Before:
>
> # perf script --itrace=3Db --show-task-events -C6 | grep -C10 EXIT
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63124ee __perf_event_header__init_id+0x5e ([kernel.kallsyms]) =3D> fff=
fffffb63124f7 __perf_event_header__init_id+0x67 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6312501 __perf_event_header__init_id+0x71 ([kernel.kallsyms]) =3D> fff=
fffffb6312512 __perf_event_header__init_id+0x82 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6312531 __perf_event_header__init_id+0xa1 ([kernel.kallsyms]) =3D> fff=
fffffb6316b3a perf_event_task_output+0x26a ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6316b40 perf_event_task_output+0x270 ([kernel.kallsyms]) =3D> ffffffff=
b6316959 perf_event_task_output+0x89 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6316966 perf_event_task_output+0x96 ([kernel.kallsyms]) =3D> ffffffffb=
6322040 perf_output_begin+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322080 perf_output_begin+0x40 ([kernel.kallsyms]) =3D> ffffffffb6194d=
c0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) =3D> ffffffffb6322085=
 perf_output_begin+0x45 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63220ce perf_output_begin+0x8e ([kernel.kallsyms]) =3D> ffffffffb611d2=
80 preempt_count_add+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb611d2bf preempt_count_add+0x3f ([kernel.kallsyms]) =3D> ffffffffb63220=
d3 perf_output_begin+0x93 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63220e8 perf_output_begin+0xa8 ([kernel.kallsyms]) =3D> ffffffffb63220=
ff perf_output_begin+0xbf ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638: PERF_RECORD_EXIT(14740:14740=
):(14739:14739)
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322119 perf_output_begin+0xd9 ([kernel.kallsyms]) =3D> ffffffffb63221=
28 perf_output_begin+0xe8 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322146 perf_output_begin+0x106 ([kernel.kallsyms]) =3D> ffffffffb6322=
0ea perf_output_begin+0xaa ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63220f9 perf_output_begin+0xb9 ([kernel.kallsyms]) =3D> ffffffffb63221=
ab perf_output_begin+0x16b ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63221ae perf_output_begin+0x16e ([kernel.kallsyms]) =3D> ffffffffb6322=
1b6 perf_output_begin+0x176 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322202 perf_output_begin+0x1c2 ([kernel.kallsyms]) =3D> ffffffffb6322=
167 perf_output_begin+0x127 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb632218c perf_output_begin+0x14c ([kernel.kallsyms]) =3D> ffffffffb6316=
96b perf_event_task_output+0x9b ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6316990 perf_event_task_output+0xc0 ([kernel.kallsyms]) =3D> ffffffffb=
61034a0 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb61034b7 __task_pid_nr_ns+0x17 ([kernel.kallsyms]) =3D> ffffffffb6194dc=
0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) =3D> ffffffffb61034bc=
 __task_pid_nr_ns+0x1c ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6103503 __task_pid_nr_ns+0x63 ([kernel.kallsyms]) =3D> ffffffffb610353=
b __task_pid_nr_ns+0x9b ([kernel.kallsyms])
>
> After:
>
> $ perf script --itrace=3Db --show-task-events -C6 | grep -C10 EXIT
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63124ee __perf_event_header__init_id+0x5e ([kernel.kallsyms]) =3D> fff=
fffffb63124f7 __perf_event_header__init_id+0x67 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6312501 __perf_event_header__init_id+0x71 ([kernel.kallsyms]) =3D> fff=
fffffb6312512 __perf_event_header__init_id+0x82 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6312531 __perf_event_header__init_id+0xa1 ([kernel.kallsyms]) =3D> fff=
fffffb6316b3a perf_event_task_output+0x26a ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6316b40 perf_event_task_output+0x270 ([kernel.kallsyms]) =3D> ffffffff=
b6316959 perf_event_task_output+0x89 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6316966 perf_event_task_output+0x96 ([kernel.kallsyms]) =3D> ffffffffb=
6322040 perf_output_begin+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322080 perf_output_begin+0x40 ([kernel.kallsyms]) =3D> ffffffffb6194d=
c0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) =3D> ffffffffb6322085=
 perf_output_begin+0x45 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63220ce perf_output_begin+0x8e ([kernel.kallsyms]) =3D> ffffffffb611d2=
80 preempt_count_add+0x0 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb611d2bf preempt_count_add+0x3f ([kernel.kallsyms]) =3D> ffffffffb63220=
d3 perf_output_begin+0x93 ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63220e8 perf_output_begin+0xa8 ([kernel.kallsyms]) =3D> ffffffffb63220=
ff perf_output_begin+0xbf ([kernel.kallsyms])
>            uname   14740 [006] 26795.092638: PERF_RECORD_EXIT(14740:14740=
):(14739:14739)
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322119 perf_output_begin+0xd9 ([kernel.kallsyms]) =3D> ffffffffb63221=
28 perf_output_begin+0xe8 ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322146 perf_output_begin+0x106 ([kernel.kallsyms]) =3D> ffffffffb6322=
0ea perf_output_begin+0xaa ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63220f9 perf_output_begin+0xb9 ([kernel.kallsyms]) =3D> ffffffffb63221=
ab perf_output_begin+0x16b ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb63221ae perf_output_begin+0x16e ([kernel.kallsyms]) =3D> ffffffffb6322=
1b6 perf_output_begin+0x176 ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6322202 perf_output_begin+0x1c2 ([kernel.kallsyms]) =3D> ffffffffb6322=
167 perf_output_begin+0x127 ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb632218c perf_output_begin+0x14c ([kernel.kallsyms]) =3D> ffffffffb6316=
96b perf_event_task_output+0x9b ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6316990 perf_event_task_output+0xc0 ([kernel.kallsyms]) =3D> ffffffffb=
61034a0 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb61034b7 __task_pid_nr_ns+0x17 ([kernel.kallsyms]) =3D> ffffffffb6194dc=
0 __rcu_read_lock+0x0 ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6194de1 __rcu_read_lock+0x21 ([kernel.kallsyms]) =3D> ffffffffb61034bc=
 __task_pid_nr_ns+0x1c ([kernel.kallsyms])
>           :14740   14740 [006] 26795.092638:          1   branches:  ffff=
ffffb6103503 __task_pid_nr_ns+0x63 ([kernel.kallsyms]) =3D> ffffffffb610353=
b __task_pid_nr_ns+0x9b ([kernel.kallsyms])
>
> This will also affect samples made after PERF_RECORD_EXIT but before
> the task finishes exiting.

Makes sense. Would an appropriate fix be in perf_session__open to set:
symbol_conf.keep_exited_threads =3D true;

when:
perf_header__has_feat(&session->header, HEADER_AUXTRACE)

It is kind of hacky to be changing global state this way, but
symbol_conf is like that in general.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-report.c   |  7 +++++++
> >  tools/perf/util/machine.c     | 10 +++++++---
> >  tools/perf/util/symbol_conf.h |  3 ++-
> >  tools/perf/util/thread.h      | 14 ++++++++++++++
> >  4 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index dcedfe00f04d..749246817aed 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1411,6 +1411,13 @@ int cmd_report(int argc, const char **argv)
> >       if (ret < 0)
> >               goto exit;
> >
> > +     /*
> > +      * tasks_mode require access to exited threads to list those that=
 are in
> > +      * the data file. Off-cpu events are synthesized after other even=
ts and
> > +      * reference exited threads.
> > +      */
> > +     symbol_conf.keep_exited_threads =3D true;
> > +
> >       annotation_options__init(&report.annotation_opts);
> >
> >       ret =3D perf_config(report__config, &report);
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 6ca7500e2cf4..5cda47eb337d 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *=
machine, union perf_event *event
> >       if (dump_trace)
> >               perf_event__fprintf_task(event, stdout);
> >
> > -     if (thread !=3D NULL)
> > -             thread__put(thread);
> > -
> > +     if (thread !=3D NULL) {
> > +             if (symbol_conf.keep_exited_threads)
> > +                     thread__set_exited(thread, /*exited=3D*/true);
> > +             else
> > +                     machine__remove_thread(machine, thread);
> > +     }
> > +     thread__put(thread);
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index 2b2fb9e224b0..6040286e07a6 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -43,7 +43,8 @@ struct symbol_conf {
> >                       disable_add2line_warn,
> >                       buildid_mmap2,
> >                       guest_code,
> > -                     lazy_load_kernel_maps;
> > +                     lazy_load_kernel_maps,
> > +                     keep_exited_threads;
> >       const char      *vmlinux_name,
> >                       *kallsyms_name,
> >                       *source_prefix,
> > diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> > index e79225a0ea46..0df775b5c110 100644
> > --- a/tools/perf/util/thread.h
> > +++ b/tools/perf/util/thread.h
> > @@ -36,13 +36,22 @@ struct thread_rb_node {
> >  };
> >
> >  DECLARE_RC_STRUCT(thread) {
> > +     /** @maps: mmaps associated with this thread. */
> >       struct maps             *maps;
> >       pid_t                   pid_; /* Not all tools update this */
> > +     /** @tid: thread ID number unique to a machine. */
> >       pid_t                   tid;
> > +     /** @ppid: parent process of the process this thread belongs to. =
*/
> >       pid_t                   ppid;
> >       int                     cpu;
> >       int                     guest_cpu; /* For QEMU thread */
> >       refcount_t              refcnt;
> > +     /**
> > +      * @exited: Has the thread had an exit event. Such threads are us=
ually
> > +      * removed from the machine's threads but some events/tools requi=
re
> > +      * access to dead threads.
> > +      */
> > +     bool                    exited;
> >       bool                    comm_set;
> >       int                     comm_len;
> >       struct list_head        namespaces_list;
> > @@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct th=
read *thread)
> >       return &RC_CHK_ACCESS(thread)->refcnt;
> >  }
> >
> > +static inline void thread__set_exited(struct thread *thread, bool exit=
ed)
> > +{
> > +     RC_CHK_ACCESS(thread)->exited =3D exited;
> > +}
> > +
> >  static inline bool thread__comm_set(const struct thread *thread)
> >  {
> >       return RC_CHK_ACCESS(thread)->comm_set;
>

