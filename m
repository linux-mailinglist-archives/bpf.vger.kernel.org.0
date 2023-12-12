Return-Path: <bpf+bounces-17548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4480EFC8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9494F1F21568
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778BD75419;
	Tue, 12 Dec 2023 15:13:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C200D3;
	Tue, 12 Dec 2023 07:13:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68BE143D;
	Tue, 12 Dec 2023 07:14:11 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BE933F738;
	Tue, 12 Dec 2023 07:13:20 -0800 (PST)
Message-ID: <5e2e56cf-9177-cb83-f88b-bd6592260a05@arm.com>
Date: Tue, 12 Dec 2023 15:13:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 11/14] perf arm64 header: Remove unnecessary CPU map
 get and put
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-12-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-12-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> In both cases the CPU map is known owned by either the caller or a
> PMU.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/arch/arm64/util/header.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index 97037499152e..a9de0b5187dd 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -25,8 +25,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>  	if (!sysfs || sz < MIDR_SIZE)
>  		return EINVAL;
>  
> -	cpus = perf_cpu_map__get(cpus);
> -
>  	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
>  		char path[PATH_MAX];
>  		FILE *file;
> @@ -51,7 +49,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>  		break;
>  	}
>  
> -	perf_cpu_map__put(cpus);
>  	return ret;
>  }
>  

