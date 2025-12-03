Return-Path: <bpf+bounces-75940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09396C9DD22
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 06:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27433A8919
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 05:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20FC289811;
	Wed,  3 Dec 2025 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op1w70R0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE828488D;
	Wed,  3 Dec 2025 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764740964; cv=none; b=vDlGUyXrs9PSZgOep+3LCferEccxj7n5c/Fl7wJvBvnnA29EbFk5qRiFMG2CyTxiwjLxsNckUYkKXYbWqEXaRBVZXhwswXEPaTwAboi2q4nR2FCW2Ntc/J//q5L0xTgbtdNO0YumKrnK0pvwSvi4LCNFstg/1F72c0AB9bMR72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764740964; c=relaxed/simple;
	bh=6PZhvW7+spW+0Cm7xrdhtzD8zcq9m/0TSLOGxIHAfr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwL+Yvj2QbaRnaK0aOx+ljxT094M/++naThjUcw/ywHpy+j6bhRYiQ5VdhxH0xyUCPO4yK/Sl4S9ISvWLryIUDXh6kBZnARiZAv1haU6pIq8/Ah0qsTcKYWxStx/NcwVFRl1aDu9hHjWncbBy92f3hHZm1/Vb8dqYZ/sVzkf8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op1w70R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AABC4CEFB;
	Wed,  3 Dec 2025 05:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764740963;
	bh=6PZhvW7+spW+0Cm7xrdhtzD8zcq9m/0TSLOGxIHAfr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Op1w70R0gPqnQLH2l/k059lhdwRZVqlt64Mvz84CFJpJmv3Mg6O6H4CJniaraaSJy
	 iTl1MzLyATI0K9nHWDL8tpIZXuesmNRi4bzJT3bvVt0XA4J6WIlLa7ZXyqHnKgwFAu
	 PNAADCAAAgYdiuzW6+Xe3ak1BJzrFroEnFZtNkkGNR4V22eQQa4/ZfTahosuGqbbDZ
	 Wwk1c1MZx5eqFqgDwvAwvii5cARZIiTLmn4kim6d7bv1ftuHGkMm7vgh4hJlgqw0fI
	 i0dkYhOJlZ4iKdquo2BUCrFuBPcZzXvoXs+X1GMnG97LmMThpWn8cDmVIDHgMnaRoV
	 bvR5GgTzMUiiw==
Date: Tue, 2 Dec 2025 21:49:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 3/6] perf record: Add --call-graph fp,defer option for
 deferred callchains
Message-ID: <aS_PYGilTIpuVZt8@google.com>
References: <20251120234804.156340-1-namhyung@kernel.org>
 <20251120234804.156340-4-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251120234804.156340-4-namhyung@kernel.org>

On Thu, Nov 20, 2025 at 03:48:01PM -0800, Namhyung Kim wrote:
> Add a new callchain record mode option for deferred callchains.  For now
> it only works with FP (frame-pointer) mode.
> 
> And add the missing feature detection logic to clear the flag on old
> kernels.
> 
>   $ perf record --call-graph fp,defer -vv true
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     size                             136
>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>     defer_callchain                  1
>     defer_output                     1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -22
>   switching off deferred callchain support
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-config.txt |  3 +++
>  tools/perf/Documentation/perf-record.txt |  4 ++++
>  tools/perf/util/callchain.c              | 16 +++++++++++++---
>  tools/perf/util/callchain.h              |  1 +
>  tools/perf/util/evsel.c                  | 19 +++++++++++++++++++
>  tools/perf/util/evsel.h                  |  1 +
>  6 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index c6f33565966735fe..642d1c490d9e3bcd 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -452,6 +452,9 @@ Variables
>  		kernel space is controlled not by this option but by the
>  		kernel config (CONFIG_UNWINDER_*).
>  
> +		The 'defer' mode can be used with 'fp' mode to enable deferred
> +		user callchains (like 'fp,defer').
> +
>  	call-graph.dump-size::
>  		The size of stack to dump in order to do post-unwinding. Default is 8192 (byte).
>  		When using dwarf into record-mode, the default size will be used if omitted.
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 067891bd7da6edc8..e8b9aadbbfa50574 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -325,6 +325,10 @@ OPTIONS
>  	by default.  User can change the number by passing it after comma
>  	like "--call-graph fp,32".
>  
> +	Also "defer" can be used with "fp" (like "--call-graph fp,defer") to
> +	enable deferred user callchain which will collect user-space callchains
> +	when the thread returns to the user space.
> +
>  -q::
>  --quiet::
>  	Don't print any warnings or messages, useful for scripting.
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index d7b7eef740b9d6ed..2884187ccbbecfdc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -275,9 +275,13 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>  			if (tok) {
>  				unsigned long size;
>  
> -				size = strtoul(tok, &name, 0);
> -				if (size < (unsigned) sysctl__max_stack())
> -					param->max_stack = size;
> +				if (!strncmp(tok, "defer", sizeof("defer"))) {
> +					param->defer = true;
> +				} else {
> +					size = strtoul(tok, &name, 0);
> +					if (size < (unsigned) sysctl__max_stack())
> +						param->max_stack = size;
> +				}
>  			}
>  			break;
>  
> @@ -314,6 +318,12 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>  	} while (0);
>  
>  	free(buf);
> +
> +	if (param->defer && param->record_mode != CALLCHAIN_FP) {
> +		pr_err("callchain: deferred callchain only works with FP\n");
> +		return -EINVAL;
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 86ed9e4d04f9ee7b..d5ae4fbb7ce5fa44 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -98,6 +98,7 @@ extern bool dwarf_callchain_users;
>  
>  struct callchain_param {
>  	bool			enabled;
> +	bool			defer;
>  	enum perf_call_graph_mode record_mode;
>  	u32			dump_size;
>  	enum chain_mode 	mode;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f1a311637694ac0a..887c6ac6c49cc415 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1065,6 +1065,9 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  		pr_info("Disabling user space callchains for function trace event.\n");
>  		attr->exclude_callchain_user = 1;
>  	}
> +
> +	if (param->defer && !attr->exclude_callchain_user)
> +		attr->defer_callchain = 1;
>  }
>  
>  void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
> @@ -1511,6 +1514,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	attr->mmap2    = track && !perf_missing_features.mmap2;
>  	attr->comm     = track;
>  	attr->build_id = track && opts->build_id;
> +	attr->defer_output = track && callchain->defer;

I need to update this part like below:

	attr->defer_output = track && callchain && callchain->defer;

Thanks,
Namhyung

>  
>  	/*
>  	 * ksymbol is tracked separately with text poke because it needs to be
> @@ -2199,6 +2203,10 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  static void evsel__disable_missing_features(struct evsel *evsel)
>  {
> +	if (perf_missing_features.defer_callchain && evsel->core.attr.defer_callchain)
> +		evsel->core.attr.defer_callchain = 0;
> +	if (perf_missing_features.defer_callchain && evsel->core.attr.defer_output)
> +		evsel->core.attr.defer_output = 0;
>  	if (perf_missing_features.inherit_sample_read && evsel->core.attr.inherit &&
>  	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
>  		evsel->core.attr.inherit = 0;
> @@ -2473,6 +2481,13 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
>  
>  	/* Please add new feature detection here. */
>  
> +	attr.defer_callchain = true;
> +	if (has_attr_feature(&attr, /*flags=*/0))
> +		goto found;
> +	perf_missing_features.defer_callchain = true;
> +	pr_debug2("switching off deferred callchain support\n");
> +	attr.defer_callchain = false;
> +
>  	attr.inherit = true;
>  	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
>  	if (has_attr_feature(&attr, /*flags=*/0))
> @@ -2584,6 +2599,10 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
>  	errno = old_errno;
>  
>  check:
> +	if ((evsel->core.attr.defer_callchain || evsel->core.attr.defer_output) &&
> +	    perf_missing_features.defer_callchain)
> +		return true;
> +
>  	if (evsel->core.attr.inherit &&
>  	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
>  	    perf_missing_features.inherit_sample_read)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3ae4ac8f9a37e009..a08130ff2e47a887 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -221,6 +221,7 @@ struct perf_missing_features {
>  	bool branch_counters;
>  	bool aux_action;
>  	bool inherit_sample_read;
> +	bool defer_callchain;
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 

