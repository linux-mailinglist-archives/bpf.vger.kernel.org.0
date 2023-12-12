Return-Path: <bpf+bounces-17544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2281680EF9E
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 16:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B9A1F215F5
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB02745FA;
	Tue, 12 Dec 2023 15:06:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F367BE3;
	Tue, 12 Dec 2023 07:06:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED55C143D;
	Tue, 12 Dec 2023 07:07:34 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9F9B3F738;
	Tue, 12 Dec 2023 07:06:43 -0800 (PST)
Message-ID: <94e3745c-8c2b-bdf3-f331-1cbe56574d48@arm.com>
Date: Tue, 12 Dec 2023 15:06:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 06/14] libperf cpumap: Add any, empty and min helpers
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-7-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-7-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> Additional helpers to better replace
> perf_cpu_map__has_any_cpu_or_is_empty.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/cpumap.c              | 27 +++++++++++++++++++++++++++
>  tools/lib/perf/include/perf/cpumap.h | 16 ++++++++++++++++
>  tools/lib/perf/libperf.map           |  4 ++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 49fc98e16514..7403819da8fd 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -316,6 +316,19 @@ bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map)
>  	return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
>  }
>  
> +bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map)
> +{
> +	if (!map)
> +		return true;
> +
> +	return __perf_cpu_map__nr(map) == 1 && __perf_cpu_map__cpu(map, 0).cpu == -1;
> +}

I'm struggling to understand the relevance of the difference between
has_any and is_any I see that there is a slight difference, but could it
not be refactored out so we only need one?

Do you ever get an 'any' map that has more than 1 entry? It's quite a
subtle difference that is_any returns false if the first one is 'any'
but then there are subsequent entries. Whereas has_any would return
true. I'm not sure if future readers would be able to appreciate that.

I see has_any is only used twice, both on evlist->all_cpus. Is there
something about that member that means it could have a map that has an
'any' mixed with CPUs? Wouldn't that have the same result as a normal
'any' anyway?

> +
> +bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
> +{
> +	return map == NULL;
> +}
> +
>  int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
>  {
>  	int low, high;
> @@ -372,6 +385,20 @@ bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
>  	return map && __perf_cpu_map__cpu(map, 0).cpu == -1;
>  }
>  
> +struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map)
> +{
> +	struct perf_cpu cpu, result = {
> +		.cpu = -1
> +	};
> +	int idx;
> +
> +	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
> +		result = cpu;
> +		break;
> +	}
> +	return result;
> +}
> +
>  struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
>  {
>  	struct perf_cpu result = {
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index dbe0a7352b64..523e4348fc96 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -50,6 +50,22 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
>   * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
>   */
>  LIBPERF_API bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map);
> +/**
> + * perf_cpu_map__is_any_cpu_or_is_empty - is map either empty or the "any CPU"/dummy value.
> + */
> +LIBPERF_API bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map);
> +/**
> + * perf_cpu_map__is_empty - does the map contain no values and it doesn't
> + *                          contain the special "any CPU"/dummy value.
> + */
> +LIBPERF_API bool perf_cpu_map__is_empty(const struct perf_cpu_map *map);
> +/**
> + * perf_cpu_map__min - the minimum CPU value or -1 if empty or just the "any CPU"/dummy value.
> + */
> +LIBPERF_API struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map);
> +/**
> + * perf_cpu_map__max - the maximum CPU value or -1 if empty or just the "any CPU"/dummy value.
> + */
>  LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
>  LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
>  LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 10b3f3722642..2aa79b696032 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -10,6 +10,10 @@ LIBPERF_0.0.1 {
>  		perf_cpu_map__nr;
>  		perf_cpu_map__cpu;
>  		perf_cpu_map__has_any_cpu_or_is_empty;
> +		perf_cpu_map__is_any_cpu_or_is_empty;
> +		perf_cpu_map__is_empty;
> +		perf_cpu_map__has_any_cpu;
> +		perf_cpu_map__min;
>  		perf_cpu_map__max;
>  		perf_cpu_map__has;
>  		perf_thread_map__new_array;

