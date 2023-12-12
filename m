Return-Path: <bpf+bounces-17539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5180EEE8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B3DB20DD4
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F975745C0;
	Tue, 12 Dec 2023 14:36:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 808608E;
	Tue, 12 Dec 2023 06:36:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55E94143D;
	Tue, 12 Dec 2023 06:37:12 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BB023F738;
	Tue, 12 Dec 2023 06:36:21 -0800 (PST)
Message-ID: <2adf8e9c-e08d-a772-bfe2-378d6759721f@arm.com>
Date: Tue, 12 Dec 2023 14:36:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 07/14] perf arm-spe/cs-etm: Directly iterate CPU maps
Content-Language: en-US
From: James Clark <james.clark@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
 Kan Liang <kan.liang@linux.intel.com>,
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
 bpf@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-8-irogers@google.com>
 <e3a01313-ed03-bc54-0260-5445fb2c15ee@arm.com>
In-Reply-To: <e3a01313-ed03-bc54-0260-5445fb2c15ee@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 14:17, James Clark wrote:
> 
> 
> On 29/11/2023 06:02, Ian Rogers wrote:
>> Rather than iterate all CPUs and see if they are in CPU maps, directly
>> iterate the CPU map. Similarly make use of the intersect
>> function. Switch perf_cpu_map__has_any_cpu_or_is_empty to more
>> appropriate alternatives.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/arch/arm/util/cs-etm.c    | 77 ++++++++++++----------------
>>  tools/perf/arch/arm64/util/arm-spe.c |  4 +-
>>  2 files changed, 34 insertions(+), 47 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index 77e6663c1703..a68a72f2f668 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -197,38 +197,32 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
>>  static int cs_etm_validate_config(struct auxtrace_record *itr,
>>  				  struct evsel *evsel)
>>  {
>> -	int i, err = -EINVAL;
>> +	int idx, err = -EINVAL;
>>  	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
>>  	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>> +	struct perf_cpu_map *intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
>> +	struct perf_cpu cpu;
>>  
>> -	/* Set option of each CPU we have */
>> -	for (i = 0; i < cpu__max_cpu().cpu; i++) {
>> -		struct perf_cpu cpu = { .cpu = i, };
>> -
>> -		/*
>> -		 * In per-cpu case, do the validation for CPUs to work with.
>> -		 * In per-thread case, the CPU map is empty.  Since the traced
>> -		 * program can run on any CPUs in this case, thus don't skip
>> -		 * validation.
>> -		 */
>> -		if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
>> -		    !perf_cpu_map__has(event_cpus, cpu))
>> -			continue;
> 
> This has broken validation for per-thread sessions.
> perf_cpu_map__intersect() doesn't seem to be able to handle the case
> where an 'any' map intersected with an online map should return the
> online map. Or at least it should for this to work, and it seems to make
> sense for it to work that way.
> 
> At least that was my initial impression, but I only debugged it and saw
> that the loop is now skipped entirely.
> 
>> -
>> -		if (!perf_cpu_map__has(online_cpus, cpu))
>> -			continue;
>> +	perf_cpu_map__put(online_cpus);
>>  
>> -		err = cs_etm_validate_context_id(itr, evsel, i);
>> +	/*
>> +	 * Set option of each CPU we have. In per-cpu case, do the validation
>> +	 * for CPUs to work with.  In per-thread case, the CPU map is empty.
>> +	 * Since the traced program can run on any CPUs in this case, thus don't
>> +	 * skip validation.
>> +	 */
>> +	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
>> +		err = cs_etm_validate_context_id(itr, evsel, cpu.cpu);
>>  		if (err)
>>  			goto out;
>> -		err = cs_etm_validate_timestamp(itr, evsel, i);
>> +		err = cs_etm_validate_timestamp(itr, evsel, idx);
>>  		if (err)
>>  			goto out;
>>  	}
>>  
>>  	err = 0;
>>  out:
>> -	perf_cpu_map__put(online_cpus);
>> +	perf_cpu_map__put(intersect_cpus);
>>  	return err;
>>  }
>>  
>> @@ -435,7 +429,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>  	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
>>  	 * when a context switch happened.
>>  	 */
>> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>  		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>>  					   "timestamp", 1);
>>  		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>> @@ -461,7 +455,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>  	evsel->core.attr.sample_period = 1;
>>  
>>  	/* In per-cpu case, always need the time of mmap events etc */
>> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
>> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
>>  		evsel__set_sample_bit(evsel, TIME);
>>  
>>  	err = cs_etm_validate_config(itr, cs_etm_evsel);
>> @@ -533,38 +527,32 @@ static size_t
>>  cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>>  		      struct evlist *evlist __maybe_unused)
>>  {
>> -	int i;
>> +	int idx;
>>  	int etmv3 = 0, etmv4 = 0, ete = 0;
>>  	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
>>  	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>> +	struct perf_cpu cpu;
>>  
>>  	/* cpu map is not empty, we have specific CPUs to work with */
>> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
>> -		for (i = 0; i < cpu__max_cpu().cpu; i++) {
>> -			struct perf_cpu cpu = { .cpu = i, };
>> -
>> -			if (!perf_cpu_map__has(event_cpus, cpu) ||
>> -			    !perf_cpu_map__has(online_cpus, cpu))
>> -				continue;
>> +	if (!perf_cpu_map__is_empty(event_cpus)) {
>> +		struct perf_cpu_map *intersect_cpus =
>> +			perf_cpu_map__intersect(event_cpus, online_cpus);
>>  
>> -			if (cs_etm_is_ete(itr, i))
>> +		perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
>> +			if (cs_etm_is_ete(itr, cpu.cpu))

Similar problem here. For a per-thread session, the CPU map is not empty
(it's an 'any' map, presumably length 1), so it comes into this first
if, rather than the else below which is for the 'any' scenario.

Then the intersect with online CPUs results in an empty map, so no CPU
metadata is recorded, then the session fails.

If you made the intersect work in the way I mentioned above we could
also delete the else below, because that's just another way to convert
from 'any' to 'all online'.

>>  				ete++;
>> -			else if (cs_etm_is_etmv4(itr, i))
>> +			else if (cs_etm_is_etmv4(itr, cpu.cpu))
>>  				etmv4++;
>>  			else
>>  				etmv3++;
>>  		}
>> +		perf_cpu_map__put(intersect_cpus);
>>  	} else {
>>  		/* get configuration for all CPUs in the system */
>> -		for (i = 0; i < cpu__max_cpu().cpu; i++) {
>> -			struct perf_cpu cpu = { .cpu = i, };
>> -
>> -			if (!perf_cpu_map__has(online_cpus, cpu))
>> -				continue;
>> -
>> -			if (cs_etm_is_ete(itr, i))
>> +		perf_cpu_map__for_each_cpu(cpu, idx, online_cpus) {
>> +			if (cs_etm_is_ete(itr, cpu.cpu))
>>  				ete++;
>> -			else if (cs_etm_is_etmv4(itr, i))
>> +			else if (cs_etm_is_etmv4(itr, cpu.cpu))
>>  				etmv4++;
>>  			else
>>  				etmv3++;
>> @@ -814,15 +802,14 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>>  		return -EINVAL;
>>  
>>  	/* If the cpu_map is empty all online CPUs are involved */
>> -	if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
>> +	if (perf_cpu_map__is_empty(event_cpus)) {
>>  		cpu_map = online_cpus;
>>  	} else {
>>  		/* Make sure all specified CPUs are online */
>> -		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
>> -			struct perf_cpu cpu = { .cpu = i, };
>> +		struct perf_cpu cpu;
>>  
>> -			if (perf_cpu_map__has(event_cpus, cpu) &&
>> -			    !perf_cpu_map__has(online_cpus, cpu))
>> +		perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
>> +			if (!perf_cpu_map__has(online_cpus, cpu))
>>  				return -EINVAL;
>>  		}
>>  
>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>> index 51ccbfd3d246..0b52e67edb3b 100644
>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>> @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>>  	 * In the case of per-cpu mmaps, sample CPU for AUX event;
>>  	 * also enable the timestamp tracing for samples correlation.
>>  	 */
>> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>  		evsel__set_sample_bit(arm_spe_evsel, CPU);
>>  		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
>>  					   "ts_enable", 1);
>> @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>>  	tracking_evsel->core.attr.sample_period = 1;
>>  
>>  	/* In per-cpu case, always need the time of mmap events etc */
>> -	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>> +	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>  		evsel__set_sample_bit(tracking_evsel, TIME);
>>  		evsel__set_sample_bit(tracking_evsel, CPU);
>>  

