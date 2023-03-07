Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6666AE001
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCGNHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 08:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCGNG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 08:06:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D37FD56;
        Tue,  7 Mar 2023 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678194335; x=1709730335;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=KFg4L7M6IRI6fgqdYWT7p8LpuP1HblpAzdXOjwSB7b0=;
  b=AlEUqBj3FNX4CpOIV6jn4MBmYj1qrqtRFhPoYDPjvYSJaV0GipAOLy8o
   O+uUI0vRNus3GKHf2f5MRXKwGC1H9vBcKS4apKK+FKBY3f0NZ0oJevzp0
   47rRqGpTBfj/62b3n2+ft9dmLxd2X0V+9nPbb409fAKnWSEXyMLBwL4oj
   9fjXfnUnIJUU1yJJBPI21P68NJa6xHnwgshb5jYgu4Fb4busrIeG9R9gR
   iRqDkaU68g9//0xxnv0WbXW0mMqLJb61P7Ak2pe+Z5yEN2CQ0aD3zzbCi
   1dmt6NARJZXcYbbCUcnW3W1PKWShkfceVg54opVMcMO5C8wIAlQ3zC8t2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="324149157"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="324149157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:04:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="765636950"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="765636950"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.236])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:04:51 -0800
Message-ID: <6a99683d-c9fc-8ff7-5a95-8b835a6df6f5@intel.com>
Date:   Tue, 7 Mar 2023 15:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/8] perf record: Record dropped sample count
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
 <20230222230141.1729048-5-namhyung@kernel.org>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230222230141.1729048-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/02/23 01:01, Namhyung Kim wrote:
> When it uses bpf filters, event might drop some samples.  It'd be nice
> if it can report how many samples it lost.  As LOST_SAMPLES event can
> carry the similar information, let's use it for bpf filters.
> 
> To indicate it's from BPF filters, add a new misc flag for that and
> do not display cpu load warnings.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/include/perf/event.h |  2 ++
>  tools/perf/builtin-record.c         | 38 ++++++++++++++++++-----------
>  tools/perf/util/bpf-filter.c        |  7 ++++++
>  tools/perf/util/bpf-filter.h        |  5 ++++
>  tools/perf/util/session.c           |  3 ++-
>  5 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index ad47d7b31046..51b9338f4c11 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -70,6 +70,8 @@ struct perf_record_lost {
>  	__u64			 lost;
>  };
>  
> +#define PERF_RECORD_MISC_LOST_SAMPLES_BPF (1 << 15)
> +
>  struct perf_record_lost_samples {
>  	struct perf_event_header header;
>  	__u64			 lost;
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8374117e66f6..197e802a150b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -52,6 +52,7 @@
>  #include "util/pmu-hybrid.h"
>  #include "util/evlist-hybrid.h"
>  #include "util/off_cpu.h"
> +#include "util/bpf-filter.h"
>  #include "asm/bug.h"
>  #include "perf.h"
>  #include "cputopo.h"
> @@ -1856,24 +1857,16 @@ record__switch_output(struct record *rec, bool at_exit)
>  	return fd;
>  }
>  
> -static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
> +static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>  					struct perf_record_lost_samples *lost,
> -					int cpu_idx, int thread_idx)
> +					int cpu_idx, int thread_idx, u64 lost_count,
> +					u16 misc_flag)
>  {
> -	struct perf_counts_values count;
>  	struct perf_sample_id *sid;
>  	struct perf_sample sample = {};
>  	int id_hdr_size;
>  
> -	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
> -		pr_err("read LOST count failed\n");
> -		return;
> -	}
> -
> -	if (count.lost == 0)
> -		return;
> -
> -	lost->lost = count.lost;
> +	lost->lost = lost_count;
>  	if (evsel->core.ids) {
>  		sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
>  		sample.id = sid->id;
> @@ -1882,6 +1875,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
>  	id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1),
>  						       evsel->core.attr.sample_type, &sample);
>  	lost->header.size = sizeof(*lost) + id_hdr_size;
> +	lost->header.misc = misc_flag;
>  	record__write(rec, NULL, lost, lost->header.size);
>  }
>  
> @@ -1905,6 +1899,7 @@ static void record__read_lost_samples(struct record *rec)
>  
>  	evlist__for_each_entry(session->evlist, evsel) {
>  		struct xyarray *xy = evsel->core.sample_id;
> +		u64 lost_count;
>  
>  		if (xy == NULL || evsel->core.fd == NULL)
>  			continue;
> @@ -1916,12 +1911,27 @@ static void record__read_lost_samples(struct record *rec)
>  
>  		for (int x = 0; x < xyarray__max_x(xy); x++) {
>  			for (int y = 0; y < xyarray__max_y(xy); y++) {
> -				__record__read_lost_samples(rec, evsel, lost, x, y);
> +				struct perf_counts_values count;
> +
> +				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
> +					pr_err("read LOST count failed\n");
> +					goto out;
> +				}
> +
> +				if (count.lost) {
> +					__record__save_lost_samples(rec, evsel, lost,
> +								    x, y, count.lost, 0);
> +				}
>  			}
>  		}
> +
> +		lost_count = perf_bpf_filter__lost_count(evsel);
> +		if (lost_count)
> +			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> +						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
>  	}
> +out:
>  	free(lost);
> -
>  }
>  
>  static volatile sig_atomic_t workload_exec_errno;
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index e1b1a5343bad..660db5ccd3da 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -69,6 +69,13 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
>  	return 0;
>  }
>  
> +u64 perf_bpf_filter__lost_count(struct evsel *evsel)
> +{
> +	struct sample_filter_bpf *skel = evsel->bpf_skel;
> +
> +	return skel ? skel->bss->dropped : 0;
> +}
> +
>  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
>  						       enum perf_bpf_filter_op op,
>  						       unsigned long val)
> diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> index 6077930073f9..36b44c8188ab 100644
> --- a/tools/perf/util/bpf-filter.h
> +++ b/tools/perf/util/bpf-filter.h
> @@ -22,6 +22,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
>  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
>  int perf_bpf_filter__prepare(struct evsel *evsel);
>  int perf_bpf_filter__destroy(struct evsel *evsel);
> +u64 perf_bpf_filter__lost_count(struct evsel *evsel);
>  
>  #else /* !HAVE_BPF_SKEL */
>  
> @@ -38,5 +39,9 @@ static inline int perf_bpf_filter__destroy(struct evsel *evsel)
>  {
>  	return -ENOSYS;
>  }
> +static inline u64 perf_bpf_filter__lost_count(struct evsel *evsel)

Needs  __maybe_unused on the parameters

> +{
> +	return 0;
> +}
>  #endif /* HAVE_BPF_SKEL*/
>  #endif /* PERF_UTIL_BPF_FILTER_H */
> \ No newline at end of file
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 749d5b5c135b..7d8d057d1772 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1582,7 +1582,8 @@ static int machines__deliver_event(struct machines *machines,
>  			evlist->stats.total_lost += event->lost.lost;
>  		return tool->lost(tool, event, sample, machine);
>  	case PERF_RECORD_LOST_SAMPLES:
> -		if (tool->lost_samples == perf_event__process_lost_samples)
> +		if (tool->lost_samples == perf_event__process_lost_samples &&
> +		    !(event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF))
>  			evlist->stats.total_lost_samples += event->lost_samples.lost;
>  		return tool->lost_samples(tool, event, sample, machine);
>  	case PERF_RECORD_READ:

