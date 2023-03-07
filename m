Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B476C6AF72E
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 22:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCGVGK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 16:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCGVGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 16:06:09 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2AC9E65C;
        Tue,  7 Mar 2023 13:06:08 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-536cb25982eso267878577b3.13;
        Tue, 07 Mar 2023 13:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYEKiuL+XZif3mNNO70+2wqcpywL1vqIp76X1v4C78k=;
        b=mvwij5RWjGSMI9irDJeMlExufT23OkK47yBSbN1yFp6hVLLgUpQJ2RUBzwz7k9s6n1
         8VJqKqbQ+ZgwMrsfaA+WmyDmOVAvy4QT8k8fAuG7wCp1dmR1yq5fwzrzH61qbQgoy66A
         mneGTu9qIWZRK2jmo/7mUmJBw3iQw07YV86i5jok8/Tv7qJYaXS1+iZf4npMG5FKNbaf
         Q1x5HjrwlDc1kN+FXgiZ4dFqc52mrhEWb6PegziDM0SFusMeadtzMdOqUQ3bsvNexiDj
         QDlWqRwidzBLj8PlLu5vIqNEt/UeGzYqo84V1EMDMXnNtBrlzkksVLMJH8oux8JFoUzV
         yoeg==
X-Gm-Message-State: AO0yUKXEEp2F5hK5AoMGyQ6A8MOH9Dewog5gXRisphFTBwFpUj+7oJbK
        gYwg4AMl6IuKxsd1A3fhghh5nPIiRGHorA9b0sXjAFq17eQ=
X-Google-Smtp-Source: AK7set9bS3QS0nq9+I95KvD5zh73Fr2BW+LPDcurBp/vfuK6lpHdrdKhwW0JIbFJqfKtWIh99KkEyXDj5cKaK8h9OlM=
X-Received: by 2002:a81:b71c:0:b0:536:7529:55b4 with SMTP id
 v28-20020a81b71c000000b00536752955b4mr10151649ywh.3.1678223167164; Tue, 07
 Mar 2023 13:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20230222230141.1729048-1-namhyung@kernel.org> <20230222230141.1729048-4-namhyung@kernel.org>
 <4d6f69ce-e765-13f6-ae30-8ec63eaf4c34@intel.com>
In-Reply-To: <4d6f69ce-e765-13f6-ae30-8ec63eaf4c34@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Mar 2023 13:05:56 -0800
Message-ID: <CAM9d7ch9QAoernuHFY3pC0zr+ROHS_m1WquNUrcC7E15otBDnw@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf record: Add BPF event filter support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 5:04 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 23/02/23 01:01, Namhyung Kim wrote:
> > Use --filter option to set BPF filter for generic events other than the
> > tracepoints or Intel PT.  The BPF program will check the sample data and
> > filter according to the expression.
> >
> > For example, the below is the typical perf record for frequency mode.
> > The sample period started from 1 and increased gradually.
> >
> > $ sudo ./perf record -e cycles true
> > $ sudo ./perf script
> >        perf-exec 2272336 546683.916875:          1 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >        perf-exec 2272336 546683.916892:          1 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >        perf-exec 2272336 546683.916899:          3 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >        perf-exec 2272336 546683.916905:         17 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >        perf-exec 2272336 546683.916911:        100 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >        perf-exec 2272336 546683.916917:        589 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >        perf-exec 2272336 546683.916924:       3470 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >        perf-exec 2272336 546683.916930:      20465 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
> >             true 2272336 546683.916940:     119873 cycles:  ffffffff8283afdd perf_iterate_ctx+0x2d ([kernel.kallsyms])
> >             true 2272336 546683.917003:     461349 cycles:  ffffffff82892517 vma_interval_tree_insert+0x37 ([kernel.kallsyms])
> >             true 2272336 546683.917237:     635778 cycles:  ffffffff82a11400 security_mmap_file+0x20 ([kernel.kallsyms])
> >
> > When you add a BPF filter to get samples having periods greater than 1000,
> > the output would look like below:
> >
> > $ sudo ./perf record -e cycles --filter 'period > 1000' true
> > $ sudo ./perf script
> >        perf-exec 2273949 546850.708501:       5029 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
> >        perf-exec 2273949 546850.708508:      32409 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
> >        perf-exec 2273949 546850.708526:     143369 cycles:  ffffffff82b4cdbf xas_start+0x5f ([kernel.kallsyms])
> >        perf-exec 2273949 546850.708600:     372650 cycles:  ffffffff8286b8f7 __pagevec_lru_add+0x117 ([kernel.kallsyms])
> >        perf-exec 2273949 546850.708791:     482953 cycles:  ffffffff829190de __mod_memcg_lruvec_state+0x4e ([kernel.kallsyms])
> >             true 2273949 546850.709036:     501985 cycles:  ffffffff828add7c tlb_gather_mmu+0x4c ([kernel.kallsyms])
> >             true 2273949 546850.709292:     503065 cycles:      7f2446d97c03 _dl_map_object_deps+0x973 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 15 +++++++++++---
> >  tools/perf/util/bpf_counter.c            |  3 +--
> >  tools/perf/util/evlist.c                 | 25 +++++++++++++++++-------
> >  tools/perf/util/evsel.c                  |  2 ++
> >  tools/perf/util/parse-events.c           |  8 +++-----
> >  5 files changed, 36 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index ff815c2f67e8..9f4e1337e6dc 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -119,9 +119,12 @@ OPTIONS
> >         "perf report" to view group events together.
> >
> >  --filter=<filter>::
> > -        Event filter. This option should follow an event selector (-e) which
> > -     selects either tracepoint event(s) or a hardware trace PMU
> > -     (e.g. Intel PT or CoreSight).
> > +     Event filter.  This option should follow an event selector (-e).
> > +     If the event is a tracepoint, the filter string will be parsed by
> > +     the kernel.  If the event is a hardware trace PMU (e.g. Intel PT
> > +     or CoreSight), it'll be processed as an address filter.  Otherwise
> > +     it means a general filter using BPF which can be applied for any
> > +     kind of events.
>
> events -> event
>
> >
> >       - tracepoint filters
> >
> > @@ -174,6 +177,12 @@ OPTIONS
> >       within a single mapping.  MMAP events (or /proc/<pid>/maps) can be
> >       examined to determine if that is a possibility.
> >
> > +     - bpf filters
> > +
> > +     BPF filter can access the sample data and make a decision based on the
>
> 'BPF filter' -> 'A BPF filter'
>
> > +     data.  Users need to set the appropriate sample type to use the BPF
>
> 'the appropriate' -> 'an appropriate'
>
> Perhaps could expand on what "appropriate sample type" means here,
> also, since the user does not actually specify sample_type directly.
>
> What happens if the sample_type is not appropriate?

Good point.  If it doesn't have an appropriate sample type, value 0
will be used and I expect it makes the filter fail.  But we should not
rely on such a behavior and request user to provide the sample type.
I think perf tool should show a warning to tell the missing options.

>
> > +     filter.
> > +
> >       Multiple filters can be separated with space or comma.
> >
> >  --exclude-perf::
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> > index eeee899fcf34..0414385794ee 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -781,8 +781,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
> >
> >  static inline bool bpf_counter_skip(struct evsel *evsel)
> >  {
> > -     return list_empty(&evsel->bpf_counter_list) &&
> > -             evsel->follower_skel == NULL;
> > +     return evsel->bpf_counter_ops == NULL;
> >  }
> >
> >  int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 817df2504a1e..1ae047b24c89 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -31,6 +31,7 @@
> >  #include "util/evlist-hybrid.h"
> >  #include "util/pmu.h"
> >  #include "util/sample.h"
> > +#include "util/bpf-filter.h"
> >  #include <signal.h>
> >  #include <unistd.h>
> >  #include <sched.h>
> > @@ -1086,17 +1087,27 @@ int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
> >       int err = 0;
> >
> >       evlist__for_each_entry(evlist, evsel) {
> > -             if (evsel->filter == NULL)
> > -                     continue;
> > -
> >               /*
> >                * filters only work for tracepoint event, which doesn't have cpu limit.
> >                * So evlist and evsel should always be same.
> >                */
> > -             err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
> > -             if (err) {
> > -                     *err_evsel = evsel;
> > -                     break;
> > +              if (evsel->filter) {
>
> Extra space before 'if'

Oops, will fix.

Thanks,
Namhyung


>
> > +                     err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
> > +                     if (err) {
> > +                             *err_evsel = evsel;
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             /*
> > +              * non-tracepoint events can have BPF filters.
> > +              */
> > +             if (!list_empty(&evsel->bpf_filters)) {
> > +                     err = perf_bpf_filter__prepare(evsel);
> > +                     if (err) {
> > +                             *err_evsel = evsel;
> > +                             break;
> > +                     }
> >               }
> >       }
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 51e8ce6edddc..cae624fde026 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -50,6 +50,7 @@
> >  #include "off_cpu.h"
> >  #include "../perf-sys.h"
> >  #include "util/parse-branch-options.h"
> > +#include "util/bpf-filter.h"
> >  #include <internal/xyarray.h>
> >  #include <internal/lib.h>
> >  #include <internal/threadmap.h>
> > @@ -1494,6 +1495,7 @@ void evsel__exit(struct evsel *evsel)
> >       assert(list_empty(&evsel->core.node));
> >       assert(evsel->evlist == NULL);
> >       bpf_counter__destroy(evsel);
> > +     perf_bpf_filter__destroy(evsel);
> >       evsel__free_counts(evsel);
> >       perf_evsel__free_fd(&evsel->core);
> >       perf_evsel__free_id(&evsel->core);
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 0336ff27c15f..4371a2bb2564 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -27,6 +27,7 @@
> >  #include "perf.h"
> >  #include "util/parse-events-hybrid.h"
> >  #include "util/pmu-hybrid.h"
> > +#include "util/bpf-filter.h"
> >  #include "tracepoint.h"
> >  #include "thread_map.h"
> >
> > @@ -2537,11 +2538,8 @@ static int set_filter(struct evsel *evsel, const void *arg)
> >               perf_pmu__scan_file(pmu, "nr_addr_filters",
> >                                   "%d", &nr_addr_filters);
> >
> > -     if (!nr_addr_filters) {
> > -             fprintf(stderr,
> > -                     "This CPU does not support address filtering\n");
> > -             return -1;
> > -     }
> > +     if (!nr_addr_filters)
> > +             return perf_bpf_filter__parse(&evsel->bpf_filters, str);
> >
> >       if (evsel__append_addr_filter(evsel, str) < 0) {
> >               fprintf(stderr,
>
