Return-Path: <bpf+bounces-17514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860EC80EAB9
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073BD1F21E6F
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AB25DF09;
	Tue, 12 Dec 2023 11:44:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85A35CD;
	Tue, 12 Dec 2023 03:44:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9426A143D;
	Tue, 12 Dec 2023 03:45:00 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31EF83F762;
	Tue, 12 Dec 2023 03:44:09 -0800 (PST)
Message-ID: <2e2f9859-a53f-f7a2-1e2b-6a3e0f2ed7db@arm.com>
Date: Tue, 12 Dec 2023 11:44:05 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 04/14] libperf cpumap: Replace usage of
 perf_cpu_map__new(NULL)
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-5-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> Passing NULL to perf_cpu_map__new performs
> perf_cpu_map__new_online_cpus, just directly call
> perf_cpu_map__new_online_cpus to be more intention revealing.

If it's not too much effort I would make perf_cpu_map__new() assert if
it's called with NULL now, to avoid any future divergance or hidden
behavior again.

Either way:

Reviewed-by: James Clark <james.clark@arm.com>

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/Documentation/examples/sampling.c  | 2 +-
>  tools/lib/perf/Documentation/libperf-sampling.txt | 2 +-
>  tools/lib/perf/evlist.c                           | 2 +-
>  tools/lib/perf/tests/test-evlist.c                | 4 ++--
>  tools/lib/perf/tests/test-evsel.c                 | 2 +-
>  tools/perf/arch/arm/util/cs-etm.c                 | 6 +++---
>  tools/perf/arch/arm64/util/header.c               | 2 +-
>  tools/perf/bench/epoll-ctl.c                      | 2 +-
>  tools/perf/bench/epoll-wait.c                     | 2 +-
>  tools/perf/bench/futex-hash.c                     | 2 +-
>  tools/perf/bench/futex-lock-pi.c                  | 2 +-
>  tools/perf/bench/futex-requeue.c                  | 2 +-
>  tools/perf/bench/futex-wake-parallel.c            | 2 +-
>  tools/perf/bench/futex-wake.c                     | 2 +-
>  tools/perf/builtin-ftrace.c                       | 2 +-
>  tools/perf/tests/code-reading.c                   | 2 +-
>  tools/perf/tests/keep-tracking.c                  | 2 +-
>  tools/perf/tests/mmap-basic.c                     | 2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c        | 2 +-
>  tools/perf/tests/perf-time-to-tsc.c               | 2 +-
>  tools/perf/tests/switch-tracking.c                | 2 +-
>  tools/perf/tests/topology.c                       | 2 +-
>  tools/perf/util/bpf_counter.c                     | 2 +-
>  tools/perf/util/cpumap.c                          | 2 +-
>  tools/perf/util/cputopo.c                         | 2 +-
>  tools/perf/util/evlist.c                          | 2 +-
>  tools/perf/util/perf_api_probe.c                  | 4 ++--
>  tools/perf/util/record.c                          | 2 +-
>  28 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/lib/perf/Documentation/examples/sampling.c b/tools/lib/perf/Documentation/examples/sampling.c
> index 8e1a926a9cfe..bc142f0664b5 100644
> --- a/tools/lib/perf/Documentation/examples/sampling.c
> +++ b/tools/lib/perf/Documentation/examples/sampling.c
> @@ -39,7 +39,7 @@ int main(int argc, char **argv)
>  
>  	libperf_init(libperf_print);
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus) {
>  		fprintf(stderr, "failed to create cpus\n");
>  		return -1;
> diff --git a/tools/lib/perf/Documentation/libperf-sampling.txt b/tools/lib/perf/Documentation/libperf-sampling.txt
> index d6ca24f6ef78..2378980fab8a 100644
> --- a/tools/lib/perf/Documentation/libperf-sampling.txt
> +++ b/tools/lib/perf/Documentation/libperf-sampling.txt
> @@ -97,7 +97,7 @@ In this case we will monitor all the available CPUs:
>  
>  [source,c]
>  --
> - 42         cpus = perf_cpu_map__new(NULL);
> + 42         cpus = perf_cpu_map__new_online_cpus();
>   43         if (!cpus) {
>   44                 fprintf(stderr, "failed to create cpus\n");
>   45                 return -1;
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 75f36218fdd9..058e3ff10f9b 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -39,7 +39,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  	if (evsel->system_wide) {
>  		/* System wide: set the cpu map of the evsel to all online CPUs. */
>  		perf_cpu_map__put(evsel->cpus);
> -		evsel->cpus = perf_cpu_map__new(NULL);
> +		evsel->cpus = perf_cpu_map__new_online_cpus();
>  	} else if (evlist->has_user_cpus && evsel->is_pmu_core) {
>  		/*
>  		 * User requested CPUs on a core PMU, ensure the requested CPUs
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index ab63878bacb9..10f70cb41ff1 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -46,7 +46,7 @@ static int test_stat_cpu(void)
>  	};
>  	int err, idx;
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	__T("failed to create cpus", cpus);
>  
>  	evlist = perf_evlist__new();
> @@ -350,7 +350,7 @@ static int test_mmap_cpus(void)
>  
>  	attr.config = id;
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	__T("failed to create cpus", cpus);
>  
>  	evlist = perf_evlist__new();
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index a11fc51bfb68..545ec3150546 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -27,7 +27,7 @@ static int test_stat_cpu(void)
>  	};
>  	int err, idx;
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	__T("failed to create cpus", cpus);
>  
>  	evsel = perf_evsel__new(&attr);
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index c6b7b3066324..77e6663c1703 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -199,7 +199,7 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
>  {
>  	int i, err = -EINVAL;
>  	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
> -	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
> +	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>  
>  	/* Set option of each CPU we have */
>  	for (i = 0; i < cpu__max_cpu().cpu; i++) {
> @@ -536,7 +536,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  	int i;
>  	int etmv3 = 0, etmv4 = 0, ete = 0;
>  	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
> -	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
> +	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>  
>  	/* cpu map is not empty, we have specific CPUs to work with */
>  	if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> @@ -802,7 +802,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>  	u64 nr_cpu, type;
>  	struct perf_cpu_map *cpu_map;
>  	struct perf_cpu_map *event_cpus = session->evlist->core.user_requested_cpus;
> -	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
> +	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>  	struct cs_etm_recording *ptr =
>  			container_of(itr, struct cs_etm_recording, itr);
>  	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index a2eef9ec5491..97037499152e 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -57,7 +57,7 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>  
>  int get_cpuid(char *buf, size_t sz)
>  {
> -	struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
> +	struct perf_cpu_map *cpus = perf_cpu_map__new_online_cpus();
>  	int ret;
>  
>  	if (!cpus)
> diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
> index 6bfffe83dde9..d3db73dac66a 100644
> --- a/tools/perf/bench/epoll-ctl.c
> +++ b/tools/perf/bench/epoll-ctl.c
> @@ -330,7 +330,7 @@ int bench_epoll_ctl(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> -	cpu = perf_cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new_online_cpus();
>  	if (!cpu)
>  		goto errmem;
>  
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index cb5174b53940..06bb3187660a 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -444,7 +444,7 @@ int bench_epoll_wait(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> -	cpu = perf_cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new_online_cpus();
>  	if (!cpu)
>  		goto errmem;
>  
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index 2005a3fa3026..0c69d20efa32 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -138,7 +138,7 @@ int bench_futex_hash(int argc, const char **argv)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	cpu = perf_cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new_online_cpus();
>  	if (!cpu)
>  		goto errmem;
>  
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index 092cbd52db82..7a4973346180 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -172,7 +172,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	if (argc)
>  		goto err;
>  
> -	cpu = perf_cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new_online_cpus();
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index c0035990a33c..d9ad736c1a3e 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -174,7 +174,7 @@ int bench_futex_requeue(int argc, const char **argv)
>  	if (argc)
>  		goto err;
>  
> -	cpu = perf_cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new_online_cpus();
>  	if (!cpu)
>  		err(EXIT_FAILURE, "cpu_map__new");
>  
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index 5ab0234d74e6..b66df553e561 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -264,7 +264,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
>  			err(EXIT_FAILURE, "mlockall");
>  	}
>  
> -	cpu = perf_cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new_online_cpus();
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 18a5894af8bb..690fd6d3da13 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -149,7 +149,7 @@ int bench_futex_wake(int argc, const char **argv)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	cpu = perf_cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new_online_cpus();
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index ac2e6c75f912..eb30c8eca488 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -333,7 +333,7 @@ static int set_tracing_func_irqinfo(struct perf_ftrace *ftrace)
>  
>  static int reset_tracing_cpu(void)
>  {
> -	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
> +	struct perf_cpu_map *cpumap = perf_cpu_map__new_online_cpus();
>  	int ret;
>  
>  	ret = set_tracing_cpumask(cpumap);
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 8620146d0378..7a3a7bbbec71 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -610,7 +610,7 @@ static int do_test_code_reading(bool try_kcore)
>  		goto out_put;
>  	}
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus) {
>  		pr_debug("perf_cpu_map__new failed\n");
>  		goto out_put;
> diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
> index 8f4f9b632e1e..5a3b2bed07f3 100644
> --- a/tools/perf/tests/keep-tracking.c
> +++ b/tools/perf/tests/keep-tracking.c
> @@ -81,7 +81,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
>  	threads = thread_map__new(-1, getpid(), UINT_MAX);
>  	CHECK_NOT_NULL__(threads);
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	CHECK_NOT_NULL__(cpus);
>  
>  	evlist = evlist__new();
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 886a13a77a16..012c8ae439fd 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -52,7 +52,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>  		return -1;
>  	}
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (cpus == NULL) {
>  		pr_debug("perf_cpu_map__new\n");
>  		goto out_free_threads;
> diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
> index f3275be83a33..fb114118c876 100644
> --- a/tools/perf/tests/openat-syscall-all-cpus.c
> +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> @@ -37,7 +37,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
>  		return -1;
>  	}
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (cpus == NULL) {
>  		pr_debug("perf_cpu_map__new\n");
>  		goto out_thread_map_delete;
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index efcd71c2738a..bbe2ddeb9b74 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -93,7 +93,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  	threads = thread_map__new(-1, getpid(), UINT_MAX);
>  	CHECK_NOT_NULL__(threads);
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	CHECK_NOT_NULL__(cpus);
>  
>  	evlist = evlist__new();
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index e52b031bedc5..5cab17a1942e 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -351,7 +351,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
>  		goto out_err;
>  	}
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus) {
>  		pr_debug("perf_cpu_map__new failed!\n");
>  		goto out_err;
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 9dee63734e66..2a842f53fbb5 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -215,7 +215,7 @@ static int test__session_topology(struct test_suite *test __maybe_unused, int su
>  	if (session_write_header(path))
>  		goto free_path;
>  
> -	map = perf_cpu_map__new(NULL);
> +	map = perf_cpu_map__new_online_cpus();
>  	if (map == NULL) {
>  		pr_debug("failed to get system cpumap\n");
>  		goto free_path;
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 7f9b0e46e008..7a8af60e0f51 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -455,7 +455,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  		return -1;
>  
>  	if (!all_cpu_map) {
> -		all_cpu_map = perf_cpu_map__new(NULL);
> +		all_cpu_map = perf_cpu_map__new_online_cpus();
>  		if (!all_cpu_map)
>  			return -1;
>  	}
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 0e090e8bc334..0581ee0fa5f2 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -672,7 +672,7 @@ struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
>  	static struct perf_cpu_map *online;
>  
>  	if (!online)
> -		online = perf_cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
> +		online = perf_cpu_map__new_online_cpus(); /* from /sys/devices/system/cpu/online */
>  
>  	return online;
>  }
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> index 81cfc85f4668..8bbeb2dc76fd 100644
> --- a/tools/perf/util/cputopo.c
> +++ b/tools/perf/util/cputopo.c
> @@ -267,7 +267,7 @@ struct cpu_topology *cpu_topology__new(void)
>  	ncpus = cpu__max_present_cpu().cpu;
>  
>  	/* build online CPU map */
> -	map = perf_cpu_map__new(NULL);
> +	map = perf_cpu_map__new_online_cpus();
>  	if (map == NULL) {
>  		pr_debug("failed to get system cpumap\n");
>  		return NULL;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index ff7f85ded89d..0ed3ce2aa8eb 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1352,7 +1352,7 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
>  	 * error, and we may not want to do that fallback to a
>  	 * default cpu identity map :-\
>  	 */
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus)
>  		goto out;
>  
> diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
> index e1e2d701599c..1de3b69cdf4a 100644
> --- a/tools/perf/util/perf_api_probe.c
> +++ b/tools/perf/util/perf_api_probe.c
> @@ -64,7 +64,7 @@ static bool perf_probe_api(setup_probe_fn_t fn)
>  	struct perf_cpu cpu;
>  	int ret, i = 0;
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus)
>  		return false;
>  	cpu = perf_cpu_map__cpu(cpus, 0);
> @@ -140,7 +140,7 @@ bool perf_can_record_cpu_wide(void)
>  	struct perf_cpu cpu;
>  	int fd;
>  
> -	cpus = perf_cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus)
>  		return false;
>  
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 40290382b2d7..87e817b3cf7e 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -238,7 +238,7 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
>  	evsel = evlist__last(temp_evlist);
>  
>  	if (!evlist || perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus)) {
> -		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
> +		struct perf_cpu_map *cpus = perf_cpu_map__new_online_cpus();
>  
>  		if (cpus)
>  			cpu =  perf_cpu_map__cpu(cpus, 0);

