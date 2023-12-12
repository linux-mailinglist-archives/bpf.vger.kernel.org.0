Return-Path: <bpf+bounces-17511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8680EA71
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A2A1F218ED
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EFD5D4A9;
	Tue, 12 Dec 2023 11:33:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A455D3;
	Tue, 12 Dec 2023 03:32:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8269A143D;
	Tue, 12 Dec 2023 03:33:44 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D8943F762;
	Tue, 12 Dec 2023 03:32:53 -0800 (PST)
Message-ID: <e2284c10-1dc3-2c55-1e56-2cd8c0c8d461@arm.com>
Date: Tue, 12 Dec 2023 11:32:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 02/14] libperf cpumap: Rename and prefer sysfs for
 perf_cpu_map__default_new
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-3-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:01, Ian Rogers wrote:
> Rename perf_cpu_map__default_new to perf_cpu_map__new_online_cpus to
> better indicate what the implementation does. Read the online CPUs
> from /sys/devices/system/cpu/online first before using sysconf as
> sysconf can't accurately configure holes in the CPU map. If sysconf is
> used, warn when the configured and online processors disagree.
> 
> When reading from a file, if the read doesn't yield a CPU map then
> return an empty map rather than the default online. This avoids
> recursion but also better yields being able to detect failures.
> 
> Add more comments.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/lib/perf/cpumap.c              | 59 +++++++++++++++++-----------
>  tools/lib/perf/include/perf/cpumap.h | 15 ++++++-
>  tools/lib/perf/libperf.map           |  2 +-
>  tools/lib/perf/tests/test-cpumap.c   |  2 +-
>  4 files changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 2bd6aba3d8c9..463ca8b37d45 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -9,6 +9,7 @@
>  #include <unistd.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include "internal.h"
>  
>  void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
>  {
> @@ -66,15 +67,21 @@ void perf_cpu_map__put(struct perf_cpu_map *map)
>  	}
>  }
>  
> -static struct perf_cpu_map *cpu_map__default_new(void)
> +static struct perf_cpu_map *cpu_map__new_sysconf(void)
>  {
>  	struct perf_cpu_map *cpus;
> -	int nr_cpus;
> +	int nr_cpus, nr_cpus_conf;
>  
>  	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  	if (nr_cpus < 0)
>  		return NULL;
>  
> +	nr_cpus_conf = sysconf(_SC_NPROCESSORS_CONF);
> +	if (nr_cpus != nr_cpus_conf) {
> +		pr_warning("Number of online CPUs (%d) differs from the number configured (%d) the CPU map will only cover the first %d CPUs.",
> +			nr_cpus, nr_cpus_conf, nr_cpus);
> +	}
> +
>  	cpus = perf_cpu_map__alloc(nr_cpus);
>  	if (cpus != NULL) {
>  		int i;
> @@ -86,9 +93,27 @@ static struct perf_cpu_map *cpu_map__default_new(void)
>  	return cpus;
>  }
>  
> -struct perf_cpu_map *perf_cpu_map__default_new(void)
> +static struct perf_cpu_map *cpu_map__new_syfs_online(void)
>  {
> -	return cpu_map__default_new();
> +	struct perf_cpu_map *cpus = NULL;
> +	FILE *onlnf;
> +
> +	onlnf = fopen("/sys/devices/system/cpu/online", "r");
> +	if (onlnf) {
> +		cpus = perf_cpu_map__read(onlnf);
> +		fclose(onlnf);
> +	}
> +	return cpus;
> +}
> +
> +struct perf_cpu_map *perf_cpu_map__new_online_cpus(void)
> +{
> +	struct perf_cpu_map *cpus = cpu_map__new_syfs_online();
> +
> +	if (cpus)
> +		return cpus;
> +
> +	return cpu_map__new_sysconf();
>  }
>  
>  
> @@ -180,27 +205,11 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
>  
>  	if (nr_cpus > 0)
>  		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
> -	else
> -		cpus = cpu_map__default_new();
>  out_free_tmp:
>  	free(tmp_cpus);
>  	return cpus;
>  }
>  
> -static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
> -{
> -	struct perf_cpu_map *cpus = NULL;
> -	FILE *onlnf;
> -
> -	onlnf = fopen("/sys/devices/system/cpu/online", "r");
> -	if (!onlnf)
> -		return cpu_map__default_new();
> -
> -	cpus = perf_cpu_map__read(onlnf);
> -	fclose(onlnf);
> -	return cpus;
> -}
> -
>  struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  {
>  	struct perf_cpu_map *cpus = NULL;
> @@ -211,7 +220,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  	int max_entries = 0;
>  
>  	if (!cpu_list)
> -		return cpu_map__read_all_cpu_map();
> +		return perf_cpu_map__new_online_cpus();
>  
>  	/*
>  	 * must handle the case of empty cpumap to cover
> @@ -268,9 +277,11 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  
>  	if (nr_cpus > 0)
>  		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
> -	else if (*cpu_list != '\0')
> -		cpus = cpu_map__default_new();
> -	else
> +	else if (*cpu_list != '\0') {
> +		pr_warning("Unexpected characters at end of cpu list ('%s'), using online CPUs.",
> +			   cpu_list);
> +		cpus = perf_cpu_map__new_online_cpus();
> +	} else
>  		cpus = perf_cpu_map__new_any_cpu();
>  invalid:
>  	free(tmp_cpus);
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index d0bf218ada11..b24bd8b8f34e 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -22,7 +22,20 @@ struct perf_cpu_map;
>   * perf_cpu_map__new_any_cpu - a map with a singular "any CPU"/dummy -1 value.
>   */
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_any_cpu(void);
> -LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
> +/**
> + * perf_cpu_map__new_online_cpus - a map read from
> + *                                 /sys/devices/system/cpu/online if
> + *                                 available. If reading wasn't possible a map
> + *                                 is created using the online processors
> + *                                 assuming the first 'n' processors are all
> + *                                 online.
> + */
> +LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
> +/**
> + * perf_cpu_map__new - create a map from the given cpu_list such as "0-7". If no
> + *                     cpu_list argument is provided then
> + *                     perf_cpu_map__new_online_cpus is returned.
> + */
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index a8ff64baea3e..8a71f841498e 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -2,7 +2,7 @@ LIBPERF_0.0.1 {
>  	global:
>  		libperf_init;
>  		perf_cpu_map__new_any_cpu;
> -		perf_cpu_map__default_new;
> +		perf_cpu_map__new_online_cpus;
>  		perf_cpu_map__get;
>  		perf_cpu_map__put;
>  		perf_cpu_map__new;
> diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
> index 2c359bdb951e..c998b1dae863 100644
> --- a/tools/lib/perf/tests/test-cpumap.c
> +++ b/tools/lib/perf/tests/test-cpumap.c
> @@ -29,7 +29,7 @@ int test_cpumap(int argc, char **argv)
>  	perf_cpu_map__put(cpus);
>  	perf_cpu_map__put(cpus);
>  
> -	cpus = perf_cpu_map__default_new();
> +	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus)
>  		return -1;
>  

