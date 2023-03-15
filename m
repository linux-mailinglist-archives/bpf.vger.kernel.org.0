Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12D26BB519
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 14:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjCONs2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjCONs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 09:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A68C805;
        Wed, 15 Mar 2023 06:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AED661DA5;
        Wed, 15 Mar 2023 13:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A72C433EF;
        Wed, 15 Mar 2023 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678888052;
        bh=pLTTdcysDE6MuWCJgZEr33nFmAHkj+/laic2uRWrGpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4U2NIwt7leQZluMD/1StUmSwXjtb7crTNxEWND78mybiE/jkjbRmPVRWBqiV/0hr
         pvd/GlHX0B7o5RYG3q75x9TSm0qmsdnbFlP21RfX2TiECpaT59PSYSpDxiSCI4GTK3
         GW7ZGf3L76aO5Jb+eBHFaheNocqhj5BxNENo26FssKz+W7dPowaKZEFyXDtVB68p0t
         7YDiZv97KrC7cGRK4kq3BbS7D153xybPbAYrzozMNMsBzzX7eYIh56YD2KrBHS74qd
         1oebLvwTncCKM6chZcsYTy7vWbi9Z3jjUKLT2YZK6e6RnEkg2vMOCgx7psu3tpi4aw
         lCREf0Tz9FgQw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76FFD4049F; Wed, 15 Mar 2023 10:47:29 -0300 (-03)
Date:   Wed, 15 Mar 2023 10:47:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH 03/10] perf record: Add BPF event filter support
Message-ID: <ZBHMcfCr+GeQJ9Sz@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
 <20230314234237.3008956-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314234237.3008956-4-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 14, 2023 at 04:42:30PM -0700, Namhyung Kim escreveu:
> Use --filter option to set BPF filter for generic events other than the
> tracepoints or Intel PT.  The BPF program will check the sample data and
> filter according to the expression.
> 
> For example, the below is the typical perf record for frequency mode.
> The sample period started from 1 and increased gradually.
> 
> $ sudo ./perf record -e cycles true
> $ sudo ./perf script
>        perf-exec 2272336 546683.916875:          1 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>        perf-exec 2272336 546683.916892:          1 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>        perf-exec 2272336 546683.916899:          3 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>        perf-exec 2272336 546683.916905:         17 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>        perf-exec 2272336 546683.916911:        100 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>        perf-exec 2272336 546683.916917:        589 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>        perf-exec 2272336 546683.916924:       3470 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>        perf-exec 2272336 546683.916930:      20465 cycles:  ffffffff828499b8 perf_event_exec+0x298 ([kernel.kallsyms])
>             true 2272336 546683.916940:     119873 cycles:  ffffffff8283afdd perf_iterate_ctx+0x2d ([kernel.kallsyms])
>             true 2272336 546683.917003:     461349 cycles:  ffffffff82892517 vma_interval_tree_insert+0x37 ([kernel.kallsyms])
>             true 2272336 546683.917237:     635778 cycles:  ffffffff82a11400 security_mmap_file+0x20 ([kernel.kallsyms])
> 
> When you add a BPF filter to get samples having periods greater than 1000,
> the output would look like below:

Had to add:

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index be336f1b2b689602..153a13cdca9df1ea 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -19,6 +19,7 @@
 #include "mmap.h"
 #include "stat.h"
 #include "metricgroup.h"
+#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/pmu.h"
 #include <internal/lib.h>
@@ -135,6 +136,18 @@ int bpf_counter__disable(struct evsel *evsel __maybe_unused)
 	return 0;
 }
 
+// not to drag util/bpf-filter.c
+
+int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
+{
+	return 0;
+}
+
+int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
+{
+	return 0;
+}
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.


Please run 'perf test' before submitting patches,

- Arnaldo
 
> $ sudo ./perf record -e cycles --filter 'period > 1000' true
> $ sudo ./perf script
>        perf-exec 2273949 546850.708501:       5029 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
>        perf-exec 2273949 546850.708508:      32409 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
>        perf-exec 2273949 546850.708526:     143369 cycles:  ffffffff82b4cdbf xas_start+0x5f ([kernel.kallsyms])
>        perf-exec 2273949 546850.708600:     372650 cycles:  ffffffff8286b8f7 __pagevec_lru_add+0x117 ([kernel.kallsyms])
>        perf-exec 2273949 546850.708791:     482953 cycles:  ffffffff829190de __mod_memcg_lruvec_state+0x4e ([kernel.kallsyms])
>             true 2273949 546850.709036:     501985 cycles:  ffffffff828add7c tlb_gather_mmu+0x4c ([kernel.kallsyms])
>             true 2273949 546850.709292:     503065 cycles:      7f2446d97c03 _dl_map_object_deps+0x973 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-record.txt | 15 +++++++++++---
>  tools/perf/util/bpf_counter.c            |  3 +--
>  tools/perf/util/evlist.c                 | 25 +++++++++++++++++-------
>  tools/perf/util/evsel.c                  |  2 ++
>  tools/perf/util/parse-events.c           |  8 +++-----
>  5 files changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index ff815c2f67e8..122f71726eaa 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -119,9 +119,12 @@ OPTIONS
>  	  "perf report" to view group events together.
>  
>  --filter=<filter>::
> -        Event filter. This option should follow an event selector (-e) which
> -	selects either tracepoint event(s) or a hardware trace PMU
> -	(e.g. Intel PT or CoreSight).
> +	Event filter.  This option should follow an event selector (-e).
> +	If the event is a tracepoint, the filter string will be parsed by
> +	the kernel.  If the event is a hardware trace PMU (e.g. Intel PT
> +	or CoreSight), it'll be processed as an address filter.  Otherwise
> +	it means a general filter using BPF which can be applied for any
> +	kind of event.
>  
>  	- tracepoint filters
>  
> @@ -176,6 +179,12 @@ OPTIONS
>  
>  	Multiple filters can be separated with space or comma.
>  
> +	- bpf filters
> +
> +	A BPF filter can access the sample data and make a decision based on the
> +	data.  Users need to set an appropriate sample type to use the BPF
> +	filter.
> +
>  --exclude-perf::
>  	Don't record events issued by perf itself. This option should follow
>  	an event selector (-e) which selects tracepoint event(s). It adds a
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index aa78a15a6f0a..1b77436e067e 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -763,8 +763,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
>  
>  static inline bool bpf_counter_skip(struct evsel *evsel)
>  {
> -	return list_empty(&evsel->bpf_counter_list) &&
> -		evsel->follower_skel == NULL;
> +	return evsel->bpf_counter_ops == NULL;
>  }
>  
>  int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index b74e12239aec..cc491a037836 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -31,6 +31,7 @@
>  #include "util/evlist-hybrid.h"
>  #include "util/pmu.h"
>  #include "util/sample.h"
> +#include "util/bpf-filter.h"
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sched.h>
> @@ -1086,17 +1087,27 @@ int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
>  	int err = 0;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->filter == NULL)
> -			continue;
> -
>  		/*
>  		 * filters only work for tracepoint event, which doesn't have cpu limit.
>  		 * So evlist and evsel should always be same.
>  		 */
> -		err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
> -		if (err) {
> -			*err_evsel = evsel;
> -			break;
> +		if (evsel->filter) {
> +			err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
> +			if (err) {
> +				*err_evsel = evsel;
> +				break;
> +			}
> +		}
> +
> +		/*
> +		 * non-tracepoint events can have BPF filters.
> +		 */
> +		if (!list_empty(&evsel->bpf_filters)) {
> +			err = perf_bpf_filter__prepare(evsel);
> +			if (err) {
> +				*err_evsel = evsel;
> +				break;
> +			}
>  		}
>  	}
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a83d8cd5eb51..dc3faf005c3b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -50,6 +50,7 @@
>  #include "off_cpu.h"
>  #include "../perf-sys.h"
>  #include "util/parse-branch-options.h"
> +#include "util/bpf-filter.h"
>  #include <internal/xyarray.h>
>  #include <internal/lib.h>
>  #include <internal/threadmap.h>
> @@ -1517,6 +1518,7 @@ void evsel__exit(struct evsel *evsel)
>  	assert(list_empty(&evsel->core.node));
>  	assert(evsel->evlist == NULL);
>  	bpf_counter__destroy(evsel);
> +	perf_bpf_filter__destroy(evsel);
>  	evsel__free_counts(evsel);
>  	perf_evsel__free_fd(&evsel->core);
>  	perf_evsel__free_id(&evsel->core);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 3b2e5bb3e852..6c5cf5244486 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -28,6 +28,7 @@
>  #include "perf.h"
>  #include "util/parse-events-hybrid.h"
>  #include "util/pmu-hybrid.h"
> +#include "util/bpf-filter.h"
>  #include "tracepoint.h"
>  #include "thread_map.h"
>  
> @@ -2542,11 +2543,8 @@ static int set_filter(struct evsel *evsel, const void *arg)
>  		perf_pmu__scan_file(pmu, "nr_addr_filters",
>  				    "%d", &nr_addr_filters);
>  
> -	if (!nr_addr_filters) {
> -		fprintf(stderr,
> -			"This CPU does not support address filtering\n");
> -		return -1;
> -	}
> +	if (!nr_addr_filters)
> +		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
>  
>  	if (evsel__append_addr_filter(evsel, str) < 0) {
>  		fprintf(stderr,
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
