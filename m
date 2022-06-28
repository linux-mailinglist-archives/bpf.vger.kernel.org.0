Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17055E7B8
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346214AbiF1OrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 10:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347163AbiF1Oq6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 10:46:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263022ED55;
        Tue, 28 Jun 2022 07:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C65CCB81EA2;
        Tue, 28 Jun 2022 14:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDB3C3411D;
        Tue, 28 Jun 2022 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656427614;
        bh=TvTe4Qb0dtjUwWQirqmAkZHbbIfz5YO7qMPwTZqUeSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UV3InFSBhPO4SzgB4K8MD6zPRFYHx6vL0yiV+Gn9hOrBuceOdCSe/cnz+i+Ny9AGR
         nfjXbcyjtfnv82PQxBCQrDJHCZxssfsfaN/ftuk9r4c08Lc5SnAuj7dEcTQ7VRDODW
         H7ayiKcgmY0vVKKWYOdzBUtD/zrAUoBAAe94pO/i3SHtWyzlBxcIKteS0Q165lvtLt
         h44/1QwNxd7k0pF7vhJHYPCP3tiyyDmVKNQT+f1AmrmKVNe8TqjpK1PI0DHe/3uWD6
         LnAufJus7qjt9dAD3X7ESidKcleMREsPG5xxJmrZxYOaZ+lp5mItAA8RH9WhKi5UyR
         PYZVRLwTxWGqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 166494096F; Tue, 28 Jun 2022 11:46:52 -0300 (-03)
Date:   Tue, 28 Jun 2022 11:46:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 2/6] perf offcpu: Accept allowed sample types only
Message-ID: <YrsUXCRBNSV4ILoK@kernel.org>
References: <20220624231313.367909-1-namhyung@kernel.org>
 <20220624231313.367909-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624231313.367909-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jun 24, 2022 at 04:13:09PM -0700, Namhyung Kim escreveu:
> As offcpu-time event is synthesized at the end, it could not get the
> all the sample info.  Define OFFCPU_SAMPLE_TYPES for allowed ones and
> mask out others in evsel__config() to prevent parse errors.
> 
> Because perf sample parsing assumes a specific ordering with the
> sample types, setting unsupported one would make it fail to read
> data like perf record -d/--data.

> Fixes: edc41a1099c2 ("perf record: Enable off-cpu analysis with BPF")

Thanks, applied.

- Arnaldo

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_off_cpu.c | 7 ++++++-
>  tools/perf/util/evsel.c       | 9 +++++++++
>  tools/perf/util/off_cpu.h     | 9 +++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index b73e84a02264..f289b7713598 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -265,6 +265,12 @@ int off_cpu_write(struct perf_session *session)
>  
>  	sample_type = evsel->core.attr.sample_type;
>  
> +	if (sample_type & ~OFFCPU_SAMPLE_TYPES) {
> +		pr_err("not supported sample type: %llx\n",
> +		       (unsigned long long)sample_type);
> +		return -1;
> +	}
> +
>  	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
>  		if (evsel->core.id)
>  			sid = evsel->core.id[0];
> @@ -319,7 +325,6 @@ int off_cpu_write(struct perf_session *session)
>  		}
>  		if (sample_type & PERF_SAMPLE_CGROUP)
>  			data.array[n++] = key.cgroup_id;
> -		/* TODO: handle more sample types */
>  
>  		size = n * sizeof(u64);
>  		data.hdr.size = size;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ce499c5da8d7..094b0a9c0bc0 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -48,6 +48,7 @@
>  #include "util.h"
>  #include "hashmap.h"
>  #include "pmu-hybrid.h"
> +#include "off_cpu.h"
>  #include "../perf-sys.h"
>  #include "util/parse-branch-options.h"
>  #include <internal/xyarray.h>
> @@ -1102,6 +1103,11 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
>  	}
>  }
>  
> +static bool evsel__is_offcpu_event(struct evsel *evsel)
> +{
> +	return evsel__is_bpf_output(evsel) && !strcmp(evsel->name, OFFCPU_EVENT);
> +}
> +
>  /*
>   * The enable_on_exec/disabled value strategy:
>   *
> @@ -1366,6 +1372,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	 */
>  	if (evsel__is_dummy_event(evsel))
>  		evsel__reset_sample_bit(evsel, BRANCH_STACK);
> +
> +	if (evsel__is_offcpu_event(evsel))
> +		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
>  }
>  
>  int evsel__set_filter(struct evsel *evsel, const char *filter)
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 548008f74d42..2dd67c60f211 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -1,6 +1,8 @@
>  #ifndef PERF_UTIL_OFF_CPU_H
>  #define PERF_UTIL_OFF_CPU_H
>  
> +#include <linux/perf_event.h>
> +
>  struct evlist;
>  struct target;
>  struct perf_session;
> @@ -8,6 +10,13 @@ struct record_opts;
>  
>  #define OFFCPU_EVENT  "offcpu-time"
>  
> +#define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
> +			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
> +			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
> +			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
> +			      PERF_SAMPLE_CGROUP)
> +
> +
>  #ifdef HAVE_BPF_SKEL
>  int off_cpu_prepare(struct evlist *evlist, struct target *target,
>  		    struct record_opts *opts);
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog

-- 

- Arnaldo
