Return-Path: <bpf+bounces-17533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D980EE28
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D501F21650
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C170971;
	Tue, 12 Dec 2023 13:54:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CC0283;
	Tue, 12 Dec 2023 05:54:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92A02143D;
	Tue, 12 Dec 2023 05:55:16 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65A483F738;
	Tue, 12 Dec 2023 05:54:25 -0800 (PST)
Message-ID: <bfb1936a-7f91-089e-c8c4-f27824779fde@arm.com>
Date: Tue, 12 Dec 2023 13:54:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 05/14] libperf cpumap: Add for_each_cpu that skips the
 "any CPU" case
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-6-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> When iterating CPUs in a CPU map it is often desirable to skip the
> "any CPU" (aka dummy) case. Add a helper for this and use in
> builtin-record.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/lib/perf/include/perf/cpumap.h | 6 ++++++
>  tools/perf/builtin-record.c          | 4 +---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 9cf361fc5edc..dbe0a7352b64 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -64,6 +64,12 @@ LIBPERF_API bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map);
>  	     (idx) < perf_cpu_map__nr(cpus);			\
>  	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
>  
> +#define perf_cpu_map__for_each_cpu_skip_any(_cpu, idx, cpus)	\
> +	for ((idx) = 0, (_cpu) = perf_cpu_map__cpu(cpus, idx);	\
> +	     (idx) < perf_cpu_map__nr(cpus);			\
> +	     (idx)++, (_cpu) = perf_cpu_map__cpu(cpus, idx))	\
> +		if ((_cpu).cpu != -1)
> +
>  #define perf_cpu_map__for_each_idx(idx, cpus)				\
>  	for ((idx) = 0; (idx) < perf_cpu_map__nr(cpus); (idx)++)
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8ec818568662..066f9232e947 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3580,9 +3580,7 @@ static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cp
>  	if (cpu_map__is_dummy(cpus))
>  		return 0;
>  
> -	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -		if (cpu.cpu == -1)
> -			continue;
> +	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpus) {
>  		/* Return ENODEV is input cpu is greater than max cpu */
>  		if ((unsigned long)cpu.cpu > mask->nbits)
>  			return -ENODEV;

