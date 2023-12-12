Return-Path: <bpf+bounces-17512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC580EA86
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A7281825
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01785D4AF;
	Tue, 12 Dec 2023 11:38:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10823CD;
	Tue, 12 Dec 2023 03:38:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E482143D;
	Tue, 12 Dec 2023 03:39:32 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34173F762;
	Tue, 12 Dec 2023 03:38:40 -0800 (PST)
Message-ID: <c32bcf09-355a-54af-c136-861a3639f5cf@arm.com>
Date: Tue, 12 Dec 2023 11:38:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 03/14] libperf cpumap: Rename perf_cpu_map__empty
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-4-irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=c3=a9_Almeida?=
 <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 "Steinar H. Gunderson" <sesse@google.com>,
 Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>,
 Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231129060211.1890454-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> The name perf_cpu_map_empty is misleading as true is also returned
> when the map contains an "any" CPU (aka dummy) map. Rename to
> perf_cpu_map__has_any_cpu_or_is_empty, later changes will
> (re)introduce perf_cpu_map__empty and perf_cpu_map__has_any_cpu.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  2 +-
>  tools/lib/perf/cpumap.c                  |  2 +-
>  tools/lib/perf/evlist.c                  |  4 ++--
>  tools/lib/perf/include/perf/cpumap.h     |  4 ++--
>  tools/lib/perf/libperf.map               |  2 +-
>  tools/perf/arch/arm/util/cs-etm.c        | 10 +++++-----
>  tools/perf/arch/arm64/util/arm-spe.c     |  4 ++--
>  tools/perf/arch/x86/util/intel-bts.c     |  4 ++--
>  tools/perf/arch/x86/util/intel-pt.c      | 10 +++++-----
>  tools/perf/builtin-c2c.c                 |  2 +-
>  tools/perf/builtin-stat.c                |  6 +++---
>  tools/perf/util/auxtrace.c               |  4 ++--
>  tools/perf/util/record.c                 |  2 +-
>  tools/perf/util/stat.c                   |  2 +-
>  14 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index a256a26598b0..fcfb9499ef9c 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -46,7 +46,7 @@ SYNOPSIS
>    void perf_cpu_map__put(struct perf_cpu_map *map);
>    int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
>    int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
> -  bool perf_cpu_map__empty(const struct perf_cpu_map *map);
> +  bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map);
>    int perf_cpu_map__max(struct perf_cpu_map *map);
>    bool perf_cpu_map__has(const struct perf_cpu_map *map, int cpu);
>  
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 463ca8b37d45..49fc98e16514 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -311,7 +311,7 @@ int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
>  	return cpus ? __perf_cpu_map__nr(cpus) : 1;
>  }
>  
> -bool perf_cpu_map__empty(const struct perf_cpu_map *map)
> +bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map)
>  {
>  	return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
>  }
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 3acbbccc1901..75f36218fdd9 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -619,7 +619,7 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
>  
>  	/* One for each CPU */
>  	nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
> -	if (perf_cpu_map__empty(evlist->all_cpus)) {
> +	if (perf_cpu_map__has_any_cpu_or_is_empty(evlist->all_cpus)) {
>  		/* Plus one for each thread */
>  		nr_mmaps += perf_thread_map__nr(evlist->threads);
>  		/* Minus the per-thread CPU (-1) */
> @@ -653,7 +653,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
>  		return -ENOMEM;
>  
> -	if (perf_cpu_map__empty(cpus))
> +	if (perf_cpu_map__has_any_cpu_or_is_empty(cpus))
>  		return mmap_per_thread(evlist, ops, mp);
>  
>  	return mmap_per_cpu(evlist, ops, mp);
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index b24bd8b8f34e..9cf361fc5edc 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -47,9 +47,9 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
>  LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
>  LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
>  /**
> - * perf_cpu_map__empty - is map either empty or the "any CPU"/dummy value.
> + * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
>   */
> -LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
> +LIBPERF_API bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map);
>  LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
>  LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
>  LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 8a71f841498e..10b3f3722642 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -9,7 +9,7 @@ LIBPERF_0.0.1 {
>  		perf_cpu_map__read;
>  		perf_cpu_map__nr;
>  		perf_cpu_map__cpu;
> -		perf_cpu_map__empty;
> +		perf_cpu_map__has_any_cpu_or_is_empty;
>  		perf_cpu_map__max;
>  		perf_cpu_map__has;
>  		perf_thread_map__new_array;
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 2cf873d71dff..c6b7b3066324 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -211,7 +211,7 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
>  		 * program can run on any CPUs in this case, thus don't skip
>  		 * validation.
>  		 */
> -		if (!perf_cpu_map__empty(event_cpus) &&
> +		if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
>  		    !perf_cpu_map__has(event_cpus, cpu))
>  			continue;
>  
> @@ -435,7 +435,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
>  	 * when a context switch happened.
>  	 */
> -	if (!perf_cpu_map__empty(cpus)) {
> +	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>  		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>  					   "timestamp", 1);
>  		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> @@ -461,7 +461,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	evsel->core.attr.sample_period = 1;
>  
>  	/* In per-cpu case, always need the time of mmap events etc */
> -	if (!perf_cpu_map__empty(cpus))
> +	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
>  		evsel__set_sample_bit(evsel, TIME);
>  
>  	err = cs_etm_validate_config(itr, cs_etm_evsel);
> @@ -539,7 +539,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
>  
>  	/* cpu map is not empty, we have specific CPUs to work with */
> -	if (!perf_cpu_map__empty(event_cpus)) {
> +	if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
>  		for (i = 0; i < cpu__max_cpu().cpu; i++) {
>  			struct perf_cpu cpu = { .cpu = i, };
>  
> @@ -814,7 +814,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>  		return -EINVAL;
>  
>  	/* If the cpu_map is empty all online CPUs are involved */
> -	if (perf_cpu_map__empty(event_cpus)) {
> +	if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
>  		cpu_map = online_cpus;
>  	} else {
>  		/* Make sure all specified CPUs are online */
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index e3acc739bd00..51ccbfd3d246 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	 * In the case of per-cpu mmaps, sample CPU for AUX event;
>  	 * also enable the timestamp tracing for samples correlation.
>  	 */
> -	if (!perf_cpu_map__empty(cpus)) {
> +	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>  		evsel__set_sample_bit(arm_spe_evsel, CPU);
>  		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
>  					   "ts_enable", 1);
> @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	tracking_evsel->core.attr.sample_period = 1;
>  
>  	/* In per-cpu case, always need the time of mmap events etc */
> -	if (!perf_cpu_map__empty(cpus)) {
> +	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>  		evsel__set_sample_bit(tracking_evsel, TIME);
>  		evsel__set_sample_bit(tracking_evsel, CPU);
>  
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index d2c8cac11470..af8ae4647585 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -143,7 +143,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  	if (!opts->full_auxtrace)
>  		return 0;
>  
> -	if (opts->full_auxtrace && !perf_cpu_map__empty(cpus)) {
> +	if (opts->full_auxtrace && !perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>  		pr_err(INTEL_BTS_PMU_NAME " does not support per-cpu recording\n");
>  		return -EINVAL;
>  	}
> @@ -224,7 +224,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  		 * In the case of per-cpu mmaps, we need the CPU on the
>  		 * AUX event.
>  		 */
> -		if (!perf_cpu_map__empty(cpus))
> +		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
>  			evsel__set_sample_bit(intel_bts_evsel, CPU);
>  	}
>  
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index fa0c718b9e72..d199619df3ab 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -369,7 +369,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
>  			ui__warning("Intel Processor Trace: TSC not available\n");
>  	}
>  
> -	per_cpu_mmaps = !perf_cpu_map__empty(session->evlist->core.user_requested_cpus);
> +	per_cpu_mmaps = !perf_cpu_map__has_any_cpu_or_is_empty(session->evlist->core.user_requested_cpus);
>  
>  	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
>  	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
> @@ -774,7 +774,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	 * Per-cpu recording needs sched_switch events to distinguish different
>  	 * threads.
>  	 */
> -	if (have_timing_info && !perf_cpu_map__empty(cpus) &&
> +	if (have_timing_info && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
>  	    !record_opts__no_switch_events(opts)) {
>  		if (perf_can_record_switch_events()) {
>  			bool cpu_wide = !target__none(&opts->target) &&
> @@ -832,7 +832,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  		 * In the case of per-cpu mmaps, we need the CPU on the
>  		 * AUX event.
>  		 */
> -		if (!perf_cpu_map__empty(cpus))
> +		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
>  			evsel__set_sample_bit(intel_pt_evsel, CPU);
>  	}
>  
> @@ -858,7 +858,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  			tracking_evsel->immediate = true;
>  
>  		/* In per-cpu case, always need the time of mmap events etc */
> -		if (!perf_cpu_map__empty(cpus)) {
> +		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>  			evsel__set_sample_bit(tracking_evsel, TIME);
>  			/* And the CPU for switch events */
>  			evsel__set_sample_bit(tracking_evsel, CPU);
> @@ -870,7 +870,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	 * Warn the user when we do not have enough information to decode i.e.
>  	 * per-cpu with no sched_switch (except workload-only).
>  	 */
> -	if (!ptr->have_sched_switch && !perf_cpu_map__empty(cpus) &&
> +	if (!ptr->have_sched_switch && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
>  	    !target__none(&opts->target) &&
>  	    !intel_pt_evsel->core.attr.exclude_user)
>  		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index a4cf9de7a7b5..f78eea9e2153 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2320,7 +2320,7 @@ static int setup_nodes(struct perf_session *session)
>  		nodes[node] = set;
>  
>  		/* empty node, skip */
> -		if (perf_cpu_map__empty(map))
> +		if (perf_cpu_map__has_any_cpu_or_is_empty(map))
>  			continue;
>  
>  		perf_cpu_map__for_each_cpu(cpu, idx, map) {
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a3af805a1d57..3303aa20f326 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1316,7 +1316,7 @@ static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
>  	 * be the first online CPU in the cache domain else use the
>  	 * first online CPU of the cache domain as the ID.
>  	 */
> -	if (perf_cpu_map__empty(cpu_map))
> +	if (perf_cpu_map__has_any_cpu_or_is_empty(cpu_map))
>  		id = cpu.cpu;
>  	else
>  		id = perf_cpu_map__cpu(cpu_map, 0).cpu;
> @@ -1622,7 +1622,7 @@ static int perf_stat_init_aggr_mode(void)
>  	 * taking the highest cpu number to be the size of
>  	 * the aggregation translate cpumap.
>  	 */
> -	if (!perf_cpu_map__empty(evsel_list->core.user_requested_cpus))
> +	if (!perf_cpu_map__has_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
>  		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
>  	else
>  		nr = 0;
> @@ -2289,7 +2289,7 @@ int process_stat_config_event(struct perf_session *session,
>  
>  	perf_event__read_stat_config(&stat_config, &event->stat_config);
>  
> -	if (perf_cpu_map__empty(st->cpus)) {
> +	if (perf_cpu_map__has_any_cpu_or_is_empty(st->cpus)) {
>  		if (st->aggr_mode != AGGR_UNSET)
>  			pr_warning("warning: processing task data, aggregation mode not set\n");
>  	} else if (st->aggr_mode != AGGR_UNSET) {
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index f528c4364d23..3684e6009b63 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -174,7 +174,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>  				   struct evlist *evlist,
>  				   struct evsel *evsel, int idx)
>  {
> -	bool per_cpu = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> +	bool per_cpu = !perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus);
>  
>  	mp->mmap_needed = evsel->needs_auxtrace_mmap;
>  
> @@ -648,7 +648,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  
>  static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
>  {
> -	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> +	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus);
>  
>  	if (per_cpu_mmaps) {
>  		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 9eb5c6a08999..40290382b2d7 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -237,7 +237,7 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
>  
>  	evsel = evlist__last(temp_evlist);
>  
> -	if (!evlist || perf_cpu_map__empty(evlist->core.user_requested_cpus)) {
> +	if (!evlist || perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus)) {
>  		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
>  
>  		if (cpus)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index ec3506042217..012c4946b9c4 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -315,7 +315,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
>  	if (!counter->per_pkg)
>  		return 0;
>  
> -	if (perf_cpu_map__empty(cpus))
> +	if (perf_cpu_map__has_any_cpu_or_is_empty(cpus))
>  		return 0;
>  
>  	if (!mask) {

