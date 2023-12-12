Return-Path: <bpf+bounces-17546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D124A80EFB9
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C297280F50
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669D7540B;
	Tue, 12 Dec 2023 15:10:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61D64EB;
	Tue, 12 Dec 2023 07:10:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DFBB143D;
	Tue, 12 Dec 2023 07:11:27 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB6293F738;
	Tue, 12 Dec 2023 07:10:35 -0800 (PST)
Message-ID: <b9165c97-1097-6bc8-751a-2bc2ac464edb@arm.com>
Date: Tue, 12 Dec 2023 15:10:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 09/14] perf cpumap: Clean up use of
 perf_cpu_map__has_any_cpu_or_is_empty
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-10-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-10-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> Most uses of what was perf_cpu_map__empty but is now
> perf_cpu_map__has_any_cpu_or_is_empty want to do something with the
> CPU map if it contains CPUs. Replace uses of
> perf_cpu_map__has_any_cpu_or_is_empty with other helpers so that CPUs
> within the map can be handled.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/builtin-c2c.c   | 6 +-----
>  tools/perf/builtin-stat.c  | 9 ++++-----
>  tools/perf/util/auxtrace.c | 4 ++--
>  tools/perf/util/record.c   | 2 +-
>  tools/perf/util/stat.c     | 2 +-
>  5 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index f78eea9e2153..ef7ed53a4b4e 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2319,11 +2319,7 @@ static int setup_nodes(struct perf_session *session)
>  
>  		nodes[node] = set;
>  
> -		/* empty node, skip */
> -		if (perf_cpu_map__has_any_cpu_or_is_empty(map))
> -			continue;
> -
> -		perf_cpu_map__for_each_cpu(cpu, idx, map) {
> +		perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
>  			__set_bit(cpu.cpu, set);
>  
>  			if (WARN_ONCE(cpu2node[cpu.cpu] != -1, "node/cpu topology bug"))
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3303aa20f326..f583027a0639 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1316,10 +1316,9 @@ static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
>  	 * be the first online CPU in the cache domain else use the
>  	 * first online CPU of the cache domain as the ID.
>  	 */
> -	if (perf_cpu_map__has_any_cpu_or_is_empty(cpu_map))
> +	id = perf_cpu_map__min(cpu_map).cpu;
> +	if (id == -1)
>  		id = cpu.cpu;
> -	else
> -		id = perf_cpu_map__cpu(cpu_map, 0).cpu;
>  
>  	/* Free the perf_cpu_map used to find the cache ID */
>  	perf_cpu_map__put(cpu_map);
> @@ -1622,7 +1621,7 @@ static int perf_stat_init_aggr_mode(void)
>  	 * taking the highest cpu number to be the size of
>  	 * the aggregation translate cpumap.
>  	 */
> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
>  		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
>  	else
>  		nr = 0;
> @@ -2289,7 +2288,7 @@ int process_stat_config_event(struct perf_session *session,
>  
>  	perf_event__read_stat_config(&stat_config, &event->stat_config);
>  
> -	if (perf_cpu_map__has_any_cpu_or_is_empty(st->cpus)) {
> +	if (perf_cpu_map__is_empty(st->cpus)) {
>  		if (st->aggr_mode != AGGR_UNSET)
>  			pr_warning("warning: processing task data, aggregation mode not set\n");
>  	} else if (st->aggr_mode != AGGR_UNSET) {
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 3684e6009b63..6b1d4bafad59 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -174,7 +174,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>  				   struct evlist *evlist,
>  				   struct evsel *evsel, int idx)
>  {
> -	bool per_cpu = !perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus);
> +	bool per_cpu = !perf_cpu_map__has_any_cpu(evlist->core.user_requested_cpus);
>  
>  	mp->mmap_needed = evsel->needs_auxtrace_mmap;
>  
> @@ -648,7 +648,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  
>  static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
>  {
> -	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus);
> +	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu(evlist->core.user_requested_cpus);
>  
>  	if (per_cpu_mmaps) {
>  		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 87e817b3cf7e..e867de8ddaaa 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -237,7 +237,7 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
>  
>  	evsel = evlist__last(temp_evlist);
>  
> -	if (!evlist || perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus)) {
> +	if (!evlist || perf_cpu_map__is_any_cpu_or_is_empty(evlist->core.user_requested_cpus)) {
>  		struct perf_cpu_map *cpus = perf_cpu_map__new_online_cpus();
>  
>  		if (cpus)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 012c4946b9c4..915808a6211a 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -315,7 +315,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
>  	if (!counter->per_pkg)
>  		return 0;
>  
> -	if (perf_cpu_map__has_any_cpu_or_is_empty(cpus))
> +	if (perf_cpu_map__is_any_cpu_or_is_empty(cpus))
>  		return 0;
>  
>  	if (!mask) {

