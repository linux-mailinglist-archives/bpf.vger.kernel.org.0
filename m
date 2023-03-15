Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5366BBA19
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 17:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCOQoK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Mar 2023 12:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjCOQns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 12:43:48 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015DD733BA;
        Wed, 15 Mar 2023 09:42:42 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v10so1568520iol.9;
        Wed, 15 Mar 2023 09:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXnHSHn0OIMlEfTyptdmvvl/lNtp1Drps3uAT4JiXu4=;
        b=Sas+HCv91BW/7Pp/tK5aJNUXMGfIU0EWGPNG5zNRc0r114OfXXdXNpIf9lLNAx3547
         bNxDsHpnT1uGTrI9+nGUk2qCT7e2Ti137jhyN3RvhC3+UBAt8KRGSkvZdkTe6LZUfaYk
         58Wk4BPBBaqPDox4Tu8EsxvA8rJtwfI8IQKhrFsnToZtIv3hSCL2tD5ZfjeUGqOQRDvP
         c2ArtgmRYpqS3zGn/CpRFtWgj70eGm4mJpwO7yTulupn+OH1HtVWK3YloyAXY7e8FQz9
         dBR9fc2Gn9gaHXggoNIKX2IbphEOUTnBdZTuPlGKNyyZ5wPVHdkpMEAAmzNAEvRBtHg4
         SXSg==
X-Gm-Message-State: AO0yUKUI8KkOzJ6XE0FaS2SUP9fAGHVlcZGWR5k8pm4Kd5JF1aO6IyO5
        iszZ0jCqNyHxsQXSX6aU1LbqfyJ96GPMnfcL5Mo=
X-Google-Smtp-Source: AK7set9myTdE44FhiF9dcpMngKcZOIb2P3E8OB3W/Qa0WUAZBAmN1oCaRhRscQk6Xaq1+ECQKM9tMrN0W0OC9ar99Ks=
X-Received: by 2002:a02:95a4:0:b0:400:3324:88b9 with SMTP id
 b33-20020a0295a4000000b00400332488b9mr6095096jai.5.1678898500473; Wed, 15 Mar
 2023 09:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230314234237.3008956-1-namhyung@kernel.org> <20230314234237.3008956-4-namhyung@kernel.org>
 <ZBHMcfCr+GeQJ9Sz@kernel.org>
In-Reply-To: <ZBHMcfCr+GeQJ9Sz@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Mar 2023 09:41:29 -0700
Message-ID: <CAM9d7cgzes+PgVKNPHQB3mzz-5wwHnBEh-RV8Mc5PqgSfGsy-Q@mail.gmail.com>
Subject: Re: [PATCH 03/10] perf record: Add BPF event filter support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Wed, Mar 15, 2023 at 6:47 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Mar 14, 2023 at 04:42:30PM -0700, Namhyung Kim escreveu:
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
>
> Had to add:
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index be336f1b2b689602..153a13cdca9df1ea 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -19,6 +19,7 @@
>  #include "mmap.h"
>  #include "stat.h"
>  #include "metricgroup.h"
> +#include "util/bpf-filter.h"
>  #include "util/env.h"
>  #include "util/pmu.h"
>  #include <internal/lib.h>
> @@ -135,6 +136,18 @@ int bpf_counter__disable(struct evsel *evsel __maybe_unused)
>         return 0;
>  }
>
> +// not to drag util/bpf-filter.c
> +
> +int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
> +{
> +       return 0;
> +}
> +
> +int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
> +{
> +       return 0;
> +}
> +
>  /*
>   * Support debug printing even though util/debug.c is not linked.  That means
>   * implementing 'verbose' and 'eprintf'.
>
>
> Please run 'perf test' before submitting patches,

Ugh, sorry.  I think I ran it at some point but missed the python test :-p

Anyway, I'm afraid you need to enclose with #ifndef HAVE_BPF_SKEL.

Thanks,
Namhyung


>
> - Arnaldo
>
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
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
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
> > index ff815c2f67e8..122f71726eaa 100644
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
> > +     kind of event.
> >
> >       - tracepoint filters
> >
> > @@ -176,6 +179,12 @@ OPTIONS
> >
> >       Multiple filters can be separated with space or comma.
> >
> > +     - bpf filters
> > +
> > +     A BPF filter can access the sample data and make a decision based on the
> > +     data.  Users need to set an appropriate sample type to use the BPF
> > +     filter.
> > +
> >  --exclude-perf::
> >       Don't record events issued by perf itself. This option should follow
> >       an event selector (-e) which selects tracepoint event(s). It adds a
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> > index aa78a15a6f0a..1b77436e067e 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -763,8 +763,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
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
> > index b74e12239aec..cc491a037836 100644
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
> > +             if (evsel->filter) {
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
> > index a83d8cd5eb51..dc3faf005c3b 100644
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
> > @@ -1517,6 +1518,7 @@ void evsel__exit(struct evsel *evsel)
> >       assert(list_empty(&evsel->core.node));
> >       assert(evsel->evlist == NULL);
> >       bpf_counter__destroy(evsel);
> > +     perf_bpf_filter__destroy(evsel);
> >       evsel__free_counts(evsel);
> >       perf_evsel__free_fd(&evsel->core);
> >       perf_evsel__free_id(&evsel->core);
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 3b2e5bb3e852..6c5cf5244486 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -28,6 +28,7 @@
> >  #include "perf.h"
> >  #include "util/parse-events-hybrid.h"
> >  #include "util/pmu-hybrid.h"
> > +#include "util/bpf-filter.h"
> >  #include "tracepoint.h"
> >  #include "thread_map.h"
> >
> > @@ -2542,11 +2543,8 @@ static int set_filter(struct evsel *evsel, const void *arg)
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
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
>
> --
>
> - Arnaldo
