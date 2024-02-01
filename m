Return-Path: <bpf+bounces-20944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E5845630
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08BF1F248A4
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F915CD7E;
	Thu,  1 Feb 2024 11:26:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4815CD54;
	Thu,  1 Feb 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786760; cv=none; b=UVQvDWqXkwi/CEX20V+3MtxXBu6jFDF0FvHVGp6nGVeR4pK9PuFSVdLYJzxId6A+XRk0WQBnwQ+sl/TyjVrJieiAMC956oRJXNEzaph1dmd7XPUr8VoSBmSb77EDDNChHYtVni/8qW14BbHO7AGzKfUWCtSGVwvMfhQl5n14l6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786760; c=relaxed/simple;
	bh=8NYoTkhsHUnypCg6m2XRxAbuAQ1Vy9v6uPqeK8+fYu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=B3AMhuHo5hyu1j8ecRBI2PG7/QnopASuzWysuDyDTbGn7Ipj/MyEkR7gRGO5X8jhTkv/zXS82qkR9/ziErZXXEBI2BI4kJ/VkpsTf7BCdZb1EMS7mtbSMXzn0pDoWJQHFNSsOKvXuOua+xgDOLaFZgSejIyl91Nm+On4QKs/ZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663F0DA7;
	Thu,  1 Feb 2024 03:26:40 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BF4F3F762;
	Thu,  1 Feb 2024 03:25:48 -0800 (PST)
Message-ID: <9d177173-c66f-a0d3-ba4d-2261f8663fce@arm.com>
Date: Thu, 1 Feb 2024 11:25:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/8] perf arm-spe/cs-etm: Directly iterate CPU maps
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20240201042236.1538928-1-irogers@google.com>
 <20240201042236.1538928-4-irogers@google.com>
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
In-Reply-To: <20240201042236.1538928-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/02/2024 04:22, Ian Rogers wrote:
> Rather than iterate all CPUs and see if they are in CPU maps, directly
> iterate the CPU map. Similarly make use of the intersect
> function. Switch perf_cpu_map__has_any_cpu_or_is_empty to more
> appropriate alternatives.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 77 ++++++++++++----------------
>  tools/perf/arch/arm64/util/arm-spe.c |  4 +-
>  2 files changed, 34 insertions(+), 47 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 77e6663c1703..f4378ba0b8d6 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -197,38 +197,32 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
>  static int cs_etm_validate_config(struct auxtrace_record *itr,
>  				  struct evsel *evsel)
>  {
> -	int i, err = -EINVAL;
> +	int idx, err = -EINVAL;
>  	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
>  	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
> +	struct perf_cpu_map *intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);

Hi Ian,

This has the same issue as V1. 'any' intersect 'online' == empty. Now no
validation happens anymore. For this to be the same as it used to be,
validation has to happen on _all_ cores when event_cpus == -1. So it
needs to be 'any' intersect 'online' == 'online'.

Same issue below with cs_etm_info_priv_size()

Thanks
James

> +	struct perf_cpu cpu;
>  
> -	/* Set option of each CPU we have */
> -	for (i = 0; i < cpu__max_cpu().cpu; i++) {
> -		struct perf_cpu cpu = { .cpu = i, };
> -
> -		/*
> -		 * In per-cpu case, do the validation for CPUs to work with.
> -		 * In per-thread case, the CPU map is empty.  Since the traced
> -		 * program can run on any CPUs in this case, thus don't skip
> -		 * validation.
> -		 */
> -		if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
> -		    !perf_cpu_map__has(event_cpus, cpu))
> -			continue;
> -
> -		if (!perf_cpu_map__has(online_cpus, cpu))
> -			continue;
> +	perf_cpu_map__put(online_cpus);
>  
> -		err = cs_etm_validate_context_id(itr, evsel, i);
> +	/*
> +	 * Set option of each CPU we have. In per-cpu case, do the validation
> +	 * for CPUs to work with.  In per-thread case, the CPU map is empty.
> +	 * Since the traced program can run on any CPUs in this case, thus don't
> +	 * skip validation.
> +	 */
> +	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> +		err = cs_etm_validate_context_id(itr, evsel, cpu.cpu);
>  		if (err)
>  			goto out;
> -		err = cs_etm_validate_timestamp(itr, evsel, i);
> +		err = cs_etm_validate_timestamp(itr, evsel, cpu.cpu);
>  		if (err)
>  			goto out;
>  	}
>  
>  	err = 0;
>  out:
> -	perf_cpu_map__put(online_cpus);
> +	perf_cpu_map__put(intersect_cpus);
>  	return err;
>  }
>  
> @@ -435,7 +429,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
>  	 * when a context switch happened.
>  	 */
> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>  		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>  					   "timestamp", 1);
>  		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> @@ -461,7 +455,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	evsel->core.attr.sample_period = 1;
>  
>  	/* In per-cpu case, always need the time of mmap events etc */
> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
>  		evsel__set_sample_bit(evsel, TIME);
>  
>  	err = cs_etm_validate_config(itr, cs_etm_evsel);
> @@ -533,38 +527,32 @@ static size_t
>  cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  		      struct evlist *evlist __maybe_unused)
>  {
> -	int i;
> +	int idx;
>  	int etmv3 = 0, etmv4 = 0, ete = 0;
>  	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
>  	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
> +	struct perf_cpu cpu;
>  
>  	/* cpu map is not empty, we have specific CPUs to work with */
> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> -		for (i = 0; i < cpu__max_cpu().cpu; i++) {
> -			struct perf_cpu cpu = { .cpu = i, };
> -
> -			if (!perf_cpu_map__has(event_cpus, cpu) ||
> -			    !perf_cpu_map__has(online_cpus, cpu))
> -				continue;
> +	if (!perf_cpu_map__is_empty(event_cpus)) {
> +		struct perf_cpu_map *intersect_cpus =
> +			perf_cpu_map__intersect(event_cpus, online_cpus);
>  
> -			if (cs_etm_is_ete(itr, i))
> +		perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> +			if (cs_etm_is_ete(itr, cpu.cpu))
>  				ete++;
> -			else if (cs_etm_is_etmv4(itr, i))
> +			else if (cs_etm_is_etmv4(itr, cpu.cpu))
>  				etmv4++;
>  			else
>  				etmv3++;
>  		}
> +		perf_cpu_map__put(intersect_cpus);
>  	} else {
>  		/* get configuration for all CPUs in the system */
> -		for (i = 0; i < cpu__max_cpu().cpu; i++) {
> -			struct perf_cpu cpu = { .cpu = i, };
> -
> -			if (!perf_cpu_map__has(online_cpus, cpu))
> -				continue;
> -
> -			if (cs_etm_is_ete(itr, i))
> +		perf_cpu_map__for_each_cpu(cpu, idx, online_cpus) {
> +			if (cs_etm_is_ete(itr, cpu.cpu))
>  				ete++;
> -			else if (cs_etm_is_etmv4(itr, i))
> +			else if (cs_etm_is_etmv4(itr, cpu.cpu))
>  				etmv4++;
>  			else
>  				etmv3++;
> @@ -814,15 +802,14 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>  		return -EINVAL;
>  
>  	/* If the cpu_map is empty all online CPUs are involved */
> -	if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> +	if (perf_cpu_map__is_empty(event_cpus)) {
>  		cpu_map = online_cpus;
>  	} else {
>  		/* Make sure all specified CPUs are online */
> -		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
> -			struct perf_cpu cpu = { .cpu = i, };
> +		struct perf_cpu cpu;
>  
> -			if (perf_cpu_map__has(event_cpus, cpu) &&
> -			    !perf_cpu_map__has(online_cpus, cpu))
> +		perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
> +			if (!perf_cpu_map__has(online_cpus, cpu))
>  				return -EINVAL;
>  		}
>  
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 51ccbfd3d246..0b52e67edb3b 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	 * In the case of per-cpu mmaps, sample CPU for AUX event;
>  	 * also enable the timestamp tracing for samples correlation.
>  	 */
> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>  		evsel__set_sample_bit(arm_spe_evsel, CPU);
>  		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
>  					   "ts_enable", 1);
> @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	tracking_evsel->core.attr.sample_period = 1;
>  
>  	/* In per-cpu case, always need the time of mmap events etc */
> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>  		evsel__set_sample_bit(tracking_evsel, TIME);
>  		evsel__set_sample_bit(tracking_evsel, CPU);
>  

