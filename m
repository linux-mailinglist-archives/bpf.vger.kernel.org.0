Return-Path: <bpf+bounces-17547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9390480EFC1
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E0281BDB
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43875410;
	Tue, 12 Dec 2023 15:12:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F77BAA;
	Tue, 12 Dec 2023 07:12:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F51E143D;
	Tue, 12 Dec 2023 07:12:49 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE2D3F738;
	Tue, 12 Dec 2023 07:11:57 -0800 (PST)
Message-ID: <e067c360-56ac-1756-3b3b-4bf5f663be87@arm.com>
Date: Tue, 12 Dec 2023 15:11:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 10/14] perf top: Avoid repeated function calls
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-11-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-11-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> Add a local variable to avoid repeated calls to perf_cpu_map__nr.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/util/top.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
> index be7157de0451..4db3d1bd686c 100644
> --- a/tools/perf/util/top.c
> +++ b/tools/perf/util/top.c
> @@ -28,6 +28,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
>  	struct record_opts *opts = &top->record_opts;
>  	struct target *target = &opts->target;
>  	size_t ret = 0;
> +	int nr_cpus;
>  
>  	if (top->samples) {
>  		samples_per_sec = top->samples / top->delay_secs;
> @@ -93,19 +94,17 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
>  	else
>  		ret += SNPRINTF(bf + ret, size - ret, " (all");
>  
> +	nr_cpus = perf_cpu_map__nr(top->evlist->core.user_requested_cpus);
>  	if (target->cpu_list)
>  		ret += SNPRINTF(bf + ret, size - ret, ", CPU%s: %s)",
> -				perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
> -				? "s" : "",
> +				nr_cpus > 1 ? "s" : "",
>  				target->cpu_list);
>  	else {
>  		if (target->tid)
>  			ret += SNPRINTF(bf + ret, size - ret, ")");
>  		else
>  			ret += SNPRINTF(bf + ret, size - ret, ", %d CPU%s)",
> -					perf_cpu_map__nr(top->evlist->core.user_requested_cpus),
> -					perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
> -					? "s" : "");
> +					nr_cpus, nr_cpus > 1 ? "s" : "");
>  	}
>  
>  	perf_top__reset_sample_counters(top);

