Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD352DEEB
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 23:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245010AbiESVCw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245016AbiESVCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 17:02:49 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90002ED8C5;
        Thu, 19 May 2022 14:02:40 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-f1d5464c48so8232795fac.6;
        Thu, 19 May 2022 14:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhNCb9LVQT2y+c1GcBgYSm7P/0wfKykJLM9u1VS0bGM=;
        b=AtL0tqTdkxIYv1EXi6OJLEoSOW1eTvXK8EOjU/ci0sDSeVnv9vgUvjVua9D9TNpeWs
         fZ3tNLFFvwnakOYR3F0iLK+cz6hGd/06RVdF81Sx8yzp4empSOHvx5iMwnOBK2AS0NAP
         KT4KJ7+L/ihm6NUd4ZKbtqJf/oZHZcOum+YmPpKWkij/po1iUHQ22Gl2NPuIGM+OBEsd
         b7wNQZAV5+umrOhepLAO6fPpBOjMSgvBJSEDdtwUXoeXeSwn4laSIshyygI2GHI5IjBi
         yzJDxq4rzU/8CvViZKt/Uc+m/KHz2LlZ6O+RS1JsOsGJs9ib9ynLxSz2dKu6pha4V5dX
         F5kw==
X-Gm-Message-State: AOAM5314OwN956v5u4q0GF4yoQP0zam/T9+4DCjeeUZczDOn7u0VFAtf
        AeCAnBuOKHl+dYfmtdqUBsVtrW+RycxUWfhuYGU=
X-Google-Smtp-Source: ABdhPJzkcoNAu7ods84mp3iuQehJ35l8v00aBOjNA0clVdv9enPtYX3aWelBisSdli7eFvpT6Js1HT69rjRKtJJGMUo=
X-Received: by 2002:a05:6871:215:b0:f1:8bf5:23ab with SMTP id
 t21-20020a056871021500b000f18bf523abmr3792505oad.92.1652994159791; Thu, 19
 May 2022 14:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220518224725.742882-1-namhyung@kernel.org> <20220518224725.742882-4-namhyung@kernel.org>
 <CAP-5=fWfZ_MqiAUx-tdO1C=Dyyzno6FbBp+KGAb_MweXs+N7Jw@mail.gmail.com>
In-Reply-To: <CAP-5=fWfZ_MqiAUx-tdO1C=Dyyzno6FbBp+KGAb_MweXs+N7Jw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 19 May 2022 14:02:28 -0700
Message-ID: <CAM9d7cgxdFJJQOg6ivuy4+nh=WME2fgjvM-kSWLv9zd49yxR4A@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf record: Implement basic filtering for off-cpu
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 18, 2022 at 9:02 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It should honor cpu and task filtering with -a, -C or -p, -t options.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-record.c            |  2 +-
> >  tools/perf/util/bpf_off_cpu.c          | 78 +++++++++++++++++++++++---
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 52 +++++++++++++++--
> >  tools/perf/util/off_cpu.h              |  6 +-
> >  4 files changed, 123 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 91f88501412e..7f60d2eac0b4 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -907,7 +907,7 @@ static int record__config_text_poke(struct evlist *evlist)
> >
> >  static int record__config_off_cpu(struct record *rec)
> >  {
> > -       return off_cpu_prepare(rec->evlist);
> > +       return off_cpu_prepare(rec->evlist, &rec->opts.target);
> >  }
> >
> >  static bool record__kcore_readable(struct machine *machine)
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> > index 9ed7aca3f4ac..b5e2d038da50 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -6,6 +6,9 @@
> >  #include "util/off_cpu.h"
> >  #include "util/perf-hooks.h"
> >  #include "util/session.h"
> > +#include "util/target.h"
> > +#include "util/cpumap.h"
> > +#include "util/thread_map.h"
> >  #include <bpf/bpf.h>
> >
> >  #include "bpf_skel/off_cpu.skel.h"
> > @@ -60,8 +63,23 @@ static int off_cpu_config(struct evlist *evlist)
> >         return 0;
> >  }
> >
> > -static void off_cpu_start(void *arg __maybe_unused)
> > +static void off_cpu_start(void *arg)
> >  {
> > +       struct evlist *evlist = arg;
> > +
> > +       /* update task filter for the given workload */
> > +       if (!skel->bss->has_cpu && !skel->bss->has_task &&
> > +           perf_thread_map__pid(evlist->core.threads, 0) != -1) {
> > +               int fd;
> > +               u32 pid;
> > +               u8 val = 1;
> > +
> > +               skel->bss->has_task = 1;
> > +               fd = bpf_map__fd(skel->maps.task_filter);
> > +               pid = perf_thread_map__pid(evlist->core.threads, 0);
> > +               bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
> > +       }
> > +
> >         skel->bss->enabled = 1;
> >  }
> >
> > @@ -71,31 +89,75 @@ static void off_cpu_finish(void *arg __maybe_unused)
> >         off_cpu_bpf__destroy(skel);
> >  }
> >
> > -int off_cpu_prepare(struct evlist *evlist)
> > +int off_cpu_prepare(struct evlist *evlist, struct target *target)
> >  {
> > -       int err;
> > +       int err, fd, i;
> > +       int ncpus = 1, ntasks = 1;
> >
> >         if (off_cpu_config(evlist) < 0) {
> >                 pr_err("Failed to config off-cpu BPF event\n");
> >                 return -1;
> >         }
> >
> > -       set_max_rlimit();
> > -
> > -       skel = off_cpu_bpf__open_and_load();
> > +       skel = off_cpu_bpf__open();
> >         if (!skel) {
> >                 pr_err("Failed to open off-cpu BPF skeleton\n");
> >                 return -1;
> >         }
> >
> > +       /* don't need to set cpu filter for system-wide mode */
> > +       if (target->cpu_list) {
> > +               ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
> > +               bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
> > +       }
> > +
> > +       if (target__has_task(target)) {
> > +               ntasks = perf_thread_map__nr(evlist->core.threads);
> > +               bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
> > +       }
> > +
> > +       set_max_rlimit();
> > +
> > +       err = off_cpu_bpf__load(skel);
> > +       if (err) {
> > +               pr_err("Failed to load off-cpu skeleton\n");
> > +               goto out;
> > +       }
> > +
> > +       if (target->cpu_list) {
> > +               u32 cpu;
> > +               u8 val = 1;
> > +
> > +               skel->bss->has_cpu = 1;
> > +               fd = bpf_map__fd(skel->maps.cpu_filter);
> > +
> > +               for (i = 0; i < ncpus; i++) {
> > +                       cpu = perf_cpu_map__cpu(evlist->core.user_requested_cpus, i).cpu;
> > +                       bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
>
> Perhaps more concise with a for_each:
>
> perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.user_requested_cpus)
>   bpf_map_update_elem(fd, &cpu.cpu, &val, BPF_ANY);

Will change.

Thanks,
Namhyung
