Return-Path: <bpf+bounces-12621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E17CEC08
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D6F281EC5
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC03D3AE;
	Wed, 18 Oct 2023 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1C18E0B;
	Wed, 18 Oct 2023 23:30:29 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4C113;
	Wed, 18 Oct 2023 16:30:26 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-584a761b301so5436316a12.3;
        Wed, 18 Oct 2023 16:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671826; x=1698276626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6x4MOo5/gvvDjdQbTbVRFsm6OAJqGdIH7cIh4FO9aMI=;
        b=ai65WB9rtwIQ6y2fgJt5kn0OAUlTebSVaAVswjLRdPvLS/yM11Uu8JAhuBEv87bTlC
         ZMUHmpzk/orNqAIzpyKUWfoxedM4hlL9k6eoNynYP9pr0z1r2N8dK2mYveYiBE0hAE/T
         BlMHq3lujsWXEp/Wrx/SVgoe8phY4JU+yMrt8WNzv+WCrZ/I7KnynwMYwO1rDNUmAATL
         +r+I4NESdP1ywE1spyhdClIkq74VAMv5vB4sxyO8CCyqZwspZoOvvalJxrm1K0qrx5bJ
         uxoF4if2Eb/3GXpg68njvBPcE5XWOsvB6EAUn6VgkKQCJBi2LzQOUNtGFk/fMhoSaKrM
         Bq4g==
X-Gm-Message-State: AOJu0YxFKP1HEUT9LYtpvQgPnvdMCl9+egC432E1r0TW02FDv35SHUjS
	R8/FaueE0Pgd68EVIXi/Lyj+UfcJYpJuPDut3bg=
X-Google-Smtp-Source: AGHT+IHgipjxPBcfAIbKk9O2m4YkW5BgcpV1jfpiPcBoPEWVF5sMa8/z+Uxrtn2Sh7DA6NrF4CMrHQw+W5rMoBJZDic=
X-Received: by 2002:a05:6a21:6da0:b0:14c:d494:77c5 with SMTP id
 wl32-20020a056a216da000b0014cd49477c5mr679241pzb.13.1697671826126; Wed, 18
 Oct 2023 16:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-14-irogers@google.com>
In-Reply-To: <20231012062359.1616786-14-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 18 Oct 2023 16:30:15 -0700
Message-ID: <CAM9d7citTUkj5z4bu0HsF73Msnks=2vOBcZU5skT77zUri_Bag@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf machine thread: Remove exited threads by default
To: Ian Rogers <irogers@google.com>
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

On Wed, Oct 11, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> struct thread values hold onto references to mmaps, dsos, etc. When a
> thread exits it is necessary to clean all of this memory up by
> removing the thread from the machine's threads. Some tools require
> this doesn't happen, such as perf report if offcpu events exist or if
> a task list is being generated, so add a symbol_conf value to make the
> behavior optional. When an exited thread is left in the machine's
> threads, mark it as exited.
>
> This change relates to commit 40826c45eb0b ("perf thread: Remove
> notion of dead threads"). Dead threads were removed as they had a
> reference count of 0 and were difficult to reason about with the
> reference count checker. Here a thread is removed from threads when it
> exits, unless via symbol_conf the exited thread isn't remove and is
> marked as exited. Reference counting behaves as it normally does.

Maybe we can do it the other way around.  IOW tools can access
dead threads for whatever reason if they are dealing with a data
file.  And I guess the main concern is perf top to reduce memory
footprint, right?  Then we can declare to remove the dead threads
for perf top case only IMHO.

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-report.c   |  7 +++++++
>  tools/perf/util/machine.c     | 10 +++++++---
>  tools/perf/util/symbol_conf.h |  3 ++-
>  tools/perf/util/thread.h      | 14 ++++++++++++++
>  4 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dcedfe00f04d..749246817aed 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1411,6 +1411,13 @@ int cmd_report(int argc, const char **argv)
>         if (ret < 0)
>                 goto exit;
>
> +       /*
> +        * tasks_mode require access to exited threads to list those that=
 are in
> +        * the data file. Off-cpu events are synthesized after other even=
ts and
> +        * reference exited threads.
> +        */
> +       symbol_conf.keep_exited_threads =3D true;
> +
>         annotation_options__init(&report.annotation_opts);
>
>         ret =3D perf_config(report__config, &report);
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 6ca7500e2cf4..5cda47eb337d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2157,9 +2157,13 @@ int machine__process_exit_event(struct machine *ma=
chine, union perf_event *event
>         if (dump_trace)
>                 perf_event__fprintf_task(event, stdout);
>
> -       if (thread !=3D NULL)
> -               thread__put(thread);
> -
> +       if (thread !=3D NULL) {
> +               if (symbol_conf.keep_exited_threads)
> +                       thread__set_exited(thread, /*exited=3D*/true);
> +               else
> +                       machine__remove_thread(machine, thread);
> +       }
> +       thread__put(thread);
>         return 0;
>  }
>
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index 2b2fb9e224b0..6040286e07a6 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -43,7 +43,8 @@ struct symbol_conf {
>                         disable_add2line_warn,
>                         buildid_mmap2,
>                         guest_code,
> -                       lazy_load_kernel_maps;
> +                       lazy_load_kernel_maps,
> +                       keep_exited_threads;
>         const char      *vmlinux_name,
>                         *kallsyms_name,
>                         *source_prefix,
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index e79225a0ea46..0df775b5c110 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -36,13 +36,22 @@ struct thread_rb_node {
>  };
>
>  DECLARE_RC_STRUCT(thread) {
> +       /** @maps: mmaps associated with this thread. */
>         struct maps             *maps;
>         pid_t                   pid_; /* Not all tools update this */
> +       /** @tid: thread ID number unique to a machine. */
>         pid_t                   tid;
> +       /** @ppid: parent process of the process this thread belongs to. =
*/
>         pid_t                   ppid;
>         int                     cpu;
>         int                     guest_cpu; /* For QEMU thread */
>         refcount_t              refcnt;
> +       /**
> +        * @exited: Has the thread had an exit event. Such threads are us=
ually
> +        * removed from the machine's threads but some events/tools requi=
re
> +        * access to dead threads.
> +        */
> +       bool                    exited;
>         bool                    comm_set;
>         int                     comm_len;
>         struct list_head        namespaces_list;
> @@ -189,6 +198,11 @@ static inline refcount_t *thread__refcnt(struct thre=
ad *thread)
>         return &RC_CHK_ACCESS(thread)->refcnt;
>  }
>
> +static inline void thread__set_exited(struct thread *thread, bool exited=
)
> +{
> +       RC_CHK_ACCESS(thread)->exited =3D exited;
> +}
> +
>  static inline bool thread__comm_set(const struct thread *thread)
>  {
>         return RC_CHK_ACCESS(thread)->comm_set;
> --
> 2.42.0.609.gbb76f46606-goog
>

