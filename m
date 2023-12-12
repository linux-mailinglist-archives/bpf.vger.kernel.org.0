Return-Path: <bpf+bounces-17510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09E80EA64
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96C51C20B46
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9425D4A5;
	Tue, 12 Dec 2023 11:28:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85D6CB8;
	Tue, 12 Dec 2023 03:28:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918C7143D;
	Tue, 12 Dec 2023 03:29:17 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0333F762;
	Tue, 12 Dec 2023 03:28:26 -0800 (PST)
Message-ID: <1c5494f7-960e-07e9-eb8c-6c9dd8405004@arm.com>
Date: Tue, 12 Dec 2023 11:28:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 12/14] perf stat: Remove duplicate cpus_map_matched
 function
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-13-irogers@google.com>
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
In-Reply-To: <20231129060211.1890454-13-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/11/2023 06:02, Ian Rogers wrote:
> Use libperf's perf_cpu_map__equal that performs the same function.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Reviewed-by: James Clark <james.clark@arm.com>

>  tools/perf/builtin-stat.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f583027a0639..8e2f90b5c276 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -164,26 +164,6 @@ static struct perf_stat_config stat_config = {
>  	.iostat_run		= false,
>  };
>  
> -static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> -{
> -	if (!a->core.cpus && !b->core.cpus)
> -		return true;
> -
> -	if (!a->core.cpus || !b->core.cpus)
> -		return false;
> -
> -	if (perf_cpu_map__nr(a->core.cpus) != perf_cpu_map__nr(b->core.cpus))
> -		return false;
> -
> -	for (int i = 0; i < perf_cpu_map__nr(a->core.cpus); i++) {
> -		if (perf_cpu_map__cpu(a->core.cpus, i).cpu !=
> -		    perf_cpu_map__cpu(b->core.cpus, i).cpu)
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
>  static void evlist__check_cpu_maps(struct evlist *evlist)
>  {
>  	struct evsel *evsel, *warned_leader = NULL;
> @@ -194,7 +174,7 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>  		/* Check that leader matches cpus with each member. */
>  		if (leader == evsel)
>  			continue;
> -		if (cpus_map_matched(leader, evsel))
> +		if (perf_cpu_map__equal(leader->core.cpus, evsel->core.cpus))
>  			continue;
>  
>  		/* If there's mismatch disable the group and warn user. */

