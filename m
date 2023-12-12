Return-Path: <bpf+bounces-17509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2EE80EA4C
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DF828234E
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0A5D488;
	Tue, 12 Dec 2023 11:25:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A79DB8;
	Tue, 12 Dec 2023 03:25:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C35E143D;
	Tue, 12 Dec 2023 03:26:05 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F483F762;
	Tue, 12 Dec 2023 03:25:14 -0800 (PST)
Message-ID: <a4e6e2b4-a66a-2aa8-1200-250b4fbcc58d@arm.com>
Date: Tue, 12 Dec 2023 11:25:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 13/14] perf cpumap: Use perf_cpu_map__for_each_cpu when
 possible
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-14-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-14-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> Rather than manually iterating the CPU map, use
> perf_cpu_map__for_each_cpu. When possible tidy local variables.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm64/util/header.c           | 10 ++--
>  tools/perf/tests/bitmap.c                     | 13 +++---
>  tools/perf/tests/topology.c                   | 46 +++++++++----------
>  tools/perf/util/bpf_kwork.c                   | 16 ++++---
>  tools/perf/util/bpf_kwork_top.c               | 12 ++---
>  tools/perf/util/cpumap.c                      | 12 ++---
>  .../scripting-engines/trace-event-python.c    | 12 +++--
>  tools/perf/util/session.c                     |  5 +-
>  tools/perf/util/svghelper.c                   | 20 ++++----
>  9 files changed, 72 insertions(+), 74 deletions(-)
> 
[...]
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 860e1837ba96..8ef0e5ac03c2 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1693,13 +1693,15 @@ static void python_process_stat(struct perf_stat_config *config,
>  {
>  	struct perf_thread_map *threads = counter->core.threads;
>  	struct perf_cpu_map *cpus = counter->core.cpus;
> -	int cpu, thread;
>  
> -	for (thread = 0; thread < perf_thread_map__nr(threads); thread++) {
> -		for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
> -			process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
> +	for (int thread = 0; thread < perf_thread_map__nr(threads); thread++) {
> +		int idx;
> +		struct perf_cpu cpu;
> +
> +		perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> +			process_stat(counter, cpu,
>  				     perf_thread_map__pid(threads, thread), tstamp,
> -				     perf_counts(counter->counts, cpu, thread));
> +				     perf_counts(counter->counts, idx, thread));

I thought changing cpu to idx was fixing a bug, but it was actually just
hard to read before where cpu was actually idx and not cpu, so this
cleanup is pretty good.

Reviewed-by: James Clark <james.clark@arm.com>

