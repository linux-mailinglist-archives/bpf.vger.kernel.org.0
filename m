Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A16AE000
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCGNHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 08:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCGNGl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 08:06:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47037FD5B;
        Tue,  7 Mar 2023 05:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678194334; x=1709730334;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=fqXx9628Xf+x+Ds+HjrZdUWy/x/bo3kOdeKYZJNdsvE=;
  b=dDWjb9PYwTGSCB70Bopzdg2hz94mbCPLmfNWLrpUkLDtNxou+lULGv29
   HKy51sjb5wgGHAF/U8UvobMRAsgYVt0NOKIMdt1va1zejhOnKe+gyfbPn
   +zqfA+owvxql4AY+i9xbkk7dUfbmekkiiFKnqeTqktweN9Iv+uTb7nL2d
   NsfDw9uHeESWcZ6slEGgBtf0wAP34s6bd5PNNOc478T8bW2JgJOOUBhBQ
   v246boHDG+dqlk69IEqAatEIQncFJn+S0+7ED5zBfWap5LnSPY1h3LLII
   5JoyeSDD+6xGe7CqwUOGuLs+VSXiKzTMOsEDUzxZOhp4tUg79G+ubN7L3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400666523"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="400666523"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="800383684"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="800383684"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.236])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:04:32 -0800
Message-ID: <4d6f69ce-e765-13f6-ae30-8ec63eaf4c34@intel.com>
Date:   Tue, 7 Mar 2023 15:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/8] perf record: Add BPF event filter support
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <20230222230141.1729048-1-namhyung@kernel.org>
 <20230222230141.1729048-4-namhyung@kernel.org>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230222230141.1729048-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/02/23 01:01, Namhyung Kim wrote:
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
> 
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
> index ff815c2f67e8..9f4e1337e6dc 100644
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
> +	kind of events.

events -> event

>  
>  	- tracepoint filters
>  
> @@ -174,6 +177,12 @@ OPTIONS
>  	within a single mapping.  MMAP events (or /proc/<pid>/maps) can be
>  	examined to determine if that is a possibility.
>  
> +	- bpf filters
> +
> +	BPF filter can access the sample data and make a decision based on the

'BPF filter' -> 'A BPF filter'

> +	data.  Users need to set the appropriate sample type to use the BPF

'the appropriate' -> 'an appropriate'

Perhaps could expand on what "appropriate sample type" means here,
also, since the user does not actually specify sample_type directly.

What happens if the sample_type is not appropriate?

> +	filter.
> +
>  	Multiple filters can be separated with space or comma.
>  
>  --exclude-perf::
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index eeee899fcf34..0414385794ee 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -781,8 +781,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
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
> index 817df2504a1e..1ae047b24c89 100644
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
> +		 if (evsel->filter) {

Extra space before 'if'

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
> index 51e8ce6edddc..cae624fde026 100644
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
> @@ -1494,6 +1495,7 @@ void evsel__exit(struct evsel *evsel)
>  	assert(list_empty(&evsel->core.node));
>  	assert(evsel->evlist == NULL);
>  	bpf_counter__destroy(evsel);
> +	perf_bpf_filter__destroy(evsel);
>  	evsel__free_counts(evsel);
>  	perf_evsel__free_fd(&evsel->core);
>  	perf_evsel__free_id(&evsel->core);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 0336ff27c15f..4371a2bb2564 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -27,6 +27,7 @@
>  #include "perf.h"
>  #include "util/parse-events-hybrid.h"
>  #include "util/pmu-hybrid.h"
> +#include "util/bpf-filter.h"
>  #include "tracepoint.h"
>  #include "thread_map.h"
>  
> @@ -2537,11 +2538,8 @@ static int set_filter(struct evsel *evsel, const void *arg)
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

