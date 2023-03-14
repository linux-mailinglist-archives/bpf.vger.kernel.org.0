Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D632F6BA18D
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 22:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCNVmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCNVmn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 17:42:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A24617B;
        Tue, 14 Mar 2023 14:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67E6CCE1777;
        Tue, 14 Mar 2023 21:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A74C433D2;
        Tue, 14 Mar 2023 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678830138;
        bh=O2/V8An4y4HPQZQMLd2yHYKygWqd9I/oQmCKa9k5eG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DE8qK1Uk9MtI3yLlK5w4Htj2dluL101agFfvNwjS8Ik+k0NnE5GUNe3BVbdewNcAV
         uwI8tAdAz9BghNUSLIoVYDGaSJ4a+WwqZAVkHJe/3HHZbj9bSbwHPLK+zIHEDbDMtG
         6JGhAHr3ps8ABWDRrexxDr7ZtNXYw046cKUHsPf54ALYKkN4eTk5g+n9iVkl5nUXUI
         F1okuaV80ZmEzb6SbQaIgF88AJVEaP1S8Ypc/ZeiXryvl5rM6ZVY/oQbWAPr/16q00
         POvpZ8888MPkEk2w71iDxikxyvAMEysF1tK3YCNZG4v3sUvmWlethzZ1D+jrefkxHz
         R1LA0skJ5szpw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1827B4049F; Tue, 14 Mar 2023 18:42:16 -0300 (-03)
Date:   Tue, 14 Mar 2023 18:42:16 -0300
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
Subject: Re: [PATCH 4/9] perf record: Record dropped sample count
Message-ID: <ZBDqOMJexe7Cq3eM@kernel.org>
References: <20230307233309.3546160-1-namhyung@kernel.org>
 <20230307233309.3546160-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307233309.3546160-5-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 07, 2023 at 03:33:04PM -0800, Namhyung Kim escreveu:
> When it uses bpf filters, event might drop some samples.  It'd be nice
> if it can report how many samples it lost.  As LOST_SAMPLES event can
> carry the similar information, let's use it for bpf filters.
> 
> To indicate it's from BPF filters, add a new misc flag for that and
> do not display cpu load warnings.

This one isn't applying, can you please refresh on top of
acme/tmp.perf-tools-next ?

- Arnaldo
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
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
> index f20e1bc03778..7bd6f2e41513 100644
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
> index eb8e1ac43cdf..f0c66764c6d0 100644
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
> @@ -38,5 +39,9 @@ static inline int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline u64 perf_bpf_filter__lost_count(struct evsel *evsel __maybe_unused)
> +{
> +	return 0;
> +}
>  #endif /* HAVE_BPF_SKEL*/
>  #endif /* PERF_UTIL_BPF_FILTER_H */
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
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
