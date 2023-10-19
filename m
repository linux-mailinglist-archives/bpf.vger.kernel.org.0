Return-Path: <bpf+bounces-12633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8A7CECDE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B8DB21248
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7138D;
	Thu, 19 Oct 2023 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6U/OWno"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71A64C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:39:37 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67596133
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:39:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so22915e9.0
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697675974; x=1698280774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWzCLiLZGdTDQE6Mm3c5UmIIcTECp3y/VYTIRTvbYV4=;
        b=U6U/OWnosDk6Gs1AtcU0u9pf31irMk4F8qLim6fgpQmQPsaT5xspNc4OZcQFnd6CNu
         f3YYjPYCiRudNUwZCCz9sDhqk5NGlCUR/MO00/NZjgcGG0ZSnwOK8Ml3W0+t9JVCtMzQ
         CWC1Sp2fn4vqOLXJHiuWIEO3BkYK7Fj61DM8mvCOTorb64G0FfKpn4R1SNxZBvAKGOHG
         PcbyJMimEQoZo5gvmDi3TSnnnTa2Tp/a9JRwVOu5t+4t8iwy09rUgJpDu5f/fVZLkg5P
         xNMUyEgMYnP9Sjas/KQBky8w4Z+wpsu8Nd6nNUBF6TjOIavFq3Fod3t2e3vOCXFBA1r9
         JvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697675974; x=1698280774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWzCLiLZGdTDQE6Mm3c5UmIIcTECp3y/VYTIRTvbYV4=;
        b=lA8vir2lfJZcqlv0e04EXhoBYp/tKalLdTCRJfQkXj8ADyGWpL/zvW3Pbsv/v/Itwy
         C4EE7E3wqmwCpms+vKy0JiB83NB018/XzBiHaUzoSd5Ba37bP9s5SAx5fIBpip3PsnhF
         68GRJ9GPSCAMJR3veuaM5DIehDZOUZRdzZhLTgZihx8t0U7OoRM/UHm5BqJ92tuQkoGN
         e9NoCslFWz8CM45oEi9fxxrenHAdMJhcN61Uc82YrGdZ/zA7LdOOoAo1tWI/3BdkXWww
         j1+Pv1c/BWIkOCYlelGv4MzyDce84BLLXTmYhuTgyjXjRnED5cRjNFdk+PyPz2X8bkiB
         q21A==
X-Gm-Message-State: AOJu0Yy1kzkGh4ciJi4Y74eRB4JtMjZ6zV6MIgTQ7UAW8ld5x0GflEnV
	zisrnE6OGHXpJwDUdtUAoH4hkFKn2VTu63uVuSQoeg==
X-Google-Smtp-Source: AGHT+IGSSTVjmeIukqthlIjrszaciDHvBd9CrEJpr+LhL33bCUc+CagV3HWVpPBehmpBbckPuve+vWKYaUL9O2mnlM4=
X-Received: by 2002:a05:600c:1615:b0:3f7:3e85:36a with SMTP id
 m21-20020a05600c161500b003f73e85036amr38163wmn.7.1697675973589; Wed, 18 Oct
 2023 17:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-14-irogers@google.com>
 <CAM9d7citTUkj5z4bu0HsF73Msnks=2vOBcZU5skT77zUri_Bag@mail.gmail.com>
In-Reply-To: <CAM9d7citTUkj5z4bu0HsF73Msnks=2vOBcZU5skT77zUri_Bag@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Oct 2023 17:39:21 -0700
Message-ID: <CAP-5=fU6ghEpYqy0FhSvxUQ_RSan34Mjp0GDys84FyPcRz_W0w@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf machine thread: Remove exited threads by default
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
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

On Wed, Oct 18, 2023 at 4:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 11, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
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
> Maybe we can do it the other way around.  IOW tools can access
> dead threads for whatever reason if they are dealing with a data
> file.  And I guess the main concern is perf top to reduce memory
> footprint, right?  Then we can declare to remove the dead threads
> for perf top case only IMHO.

Thanks I did consider this but I think this order makes most sense.
The only tool relying on access to dead threads is perf report, but
its uses are questionable:

 - task printing - the tools wants to show all threads from a perf run
and assumes they are in threads. By replacing tool.exit it would be
easy to record dead threads for this, as the maps aren't required the
memory overhead could be improved by just recording the necessary
task's data.

 - offcpu - it would be very useful to have offcpu samples be real
samples, rather than an aggregated sample at the end of the data file
with a timestamp greater-than when the thread exited. These samples
would happen before the exit event is processed and so the reason to
keep dead threads around would be removed. I think we could do some
kind of sample aggregation using BPF, but I think we need to think it
through with exit events. Perhaps we can fix things in the short-term
by generating BPF samples with aggregation when threads exit in the
offcpu BPF code, but then again, if you have this going it seems as
easy just to keep to record all offcpu events as distinct.

Other commands like perf top and perf script don't currently have
dependencies on dead threads and I'm kind of glad, for
understandability, memory footprint, etc. Having the default be that
dead threads linger on will just encourage the kind of issues we see
currently in perf report and having to have every tool, perf script
declare it doesn't want dead threads seems burdensome.

Thanks,
Ian

> Thanks,
> Namhyung
>
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
> >         if (ret < 0)
> >                 goto exit;
> >
> > +       /*
> > +        * tasks_mode require access to exited threads to list those th=
at are in
> > +        * the data file. Off-cpu events are synthesized after other ev=
ents and
> > +        * reference exited threads.
> > +        */
> > +       symbol_conf.keep_exited_threads =3D true;
> > +
> >         annotation_options__init(&report.annotation_opts);
> >
> >         ret =3D perf_config(report__config, &report);
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 6ca7500e2cf4..5cda47eb337d 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *=
machine, union perf_event *event
> >         if (dump_trace)
> >                 perf_event__fprintf_task(event, stdout);
> >
> > -       if (thread !=3D NULL)
> > -               thread__put(thread);
> > -
> > +       if (thread !=3D NULL) {
> > +               if (symbol_conf.keep_exited_threads)
> > +                       thread__set_exited(thread, /*exited=3D*/true);
> > +               else
> > +                       machine__remove_thread(machine, thread);
> > +       }
> > +       thread__put(thread);
> >         return 0;
> >  }
> >
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index 2b2fb9e224b0..6040286e07a6 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -43,7 +43,8 @@ struct symbol_conf {
> >                         disable_add2line_warn,
> >                         buildid_mmap2,
> >                         guest_code,
> > -                       lazy_load_kernel_maps;
> > +                       lazy_load_kernel_maps,
> > +                       keep_exited_threads;
> >         const char      *vmlinux_name,
> >                         *kallsyms_name,
> >                         *source_prefix,
> > diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> > index e79225a0ea46..0df775b5c110 100644
> > --- a/tools/perf/util/thread.h
> > +++ b/tools/perf/util/thread.h
> > @@ -36,13 +36,22 @@ struct thread_rb_node {
> >  };
> >
> >  DECLARE_RC_STRUCT(thread) {
> > +       /** @maps: mmaps associated with this thread. */
> >         struct maps             *maps;
> >         pid_t                   pid_; /* Not all tools update this */
> > +       /** @tid: thread ID number unique to a machine. */
> >         pid_t                   tid;
> > +       /** @ppid: parent process of the process this thread belongs to=
. */
> >         pid_t                   ppid;
> >         int                     cpu;
> >         int                     guest_cpu; /* For QEMU thread */
> >         refcount_t              refcnt;
> > +       /**
> > +        * @exited: Has the thread had an exit event. Such threads are =
usually
> > +        * removed from the machine's threads but some events/tools req=
uire
> > +        * access to dead threads.
> > +        */
> > +       bool                    exited;
> >         bool                    comm_set;
> >         int                     comm_len;
> >         struct list_head        namespaces_list;
> > @@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct th=
read *thread)
> >         return &RC_CHK_ACCESS(thread)->refcnt;
> >  }
> >
> > +static inline void thread__set_exited(struct thread *thread, bool exit=
ed)
> > +{
> > +       RC_CHK_ACCESS(thread)->exited =3D exited;
> > +}
> > +
> >  static inline bool thread__comm_set(const struct thread *thread)
> >  {
> >         return RC_CHK_ACCESS(thread)->comm_set;
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

