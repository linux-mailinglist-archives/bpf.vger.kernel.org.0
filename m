Return-Path: <bpf+bounces-17670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DCE811155
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 13:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F89281EAC
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31229403;
	Wed, 13 Dec 2023 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V45sfMEz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBFEA4;
	Wed, 13 Dec 2023 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702471712; x=1734007712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8oyQWIL48xbMuGTyRmr1kvqN7ATxDJQS7G1iOJWG82U=;
  b=V45sfMEzDY+7T5YN1iOpvDgWIvR/XrCALfo+svksHsiWBVns9tfeY2qo
   cP35OyLLJK/Jq2zwahTO1owVX37I/FD/FHf9Kz23+PZOYjHjmg7BFDZlY
   3Bql1niSxHCcAXlwJhpOxM9RvjvOanrQzMc0rTwMsUzsKJpmtaOVN9X1/
   XLt8aVYRosxoX1C2P56XQX+clJoNTYKUHmjm7KzvS0+qrrM1vwAkxDeEC
   AYZYW7ASsyCYVc2e6GBwPXg110cOW6PH3litsYy3bVv9+v6GFDAF1Uee7
   Ankuf4ByZjK3btlkvoBij9vqykSQV++tgeNgUqq9A3BSNX9ENmP9VWmdK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392132510"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="392132510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 04:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723637716"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="723637716"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.13])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 04:48:20 -0800
Message-ID: <84755553-3a79-4693-9396-084e9ae41235@intel.com>
Date: Wed, 13 Dec 2023 14:48:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] Clean up libperf cpumap's empty function
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
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
 bpf@vger.kernel.org
References: <20231129060211.1890454-1-irogers@google.com>
 <ZXifiVytVbebYE3U@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZXifiVytVbebYE3U@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 19:59, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 28, 2023 at 10:01:57PM -0800, Ian Rogers escreveu:
>> Rename and clean up the use of libperf CPU map functions particularly
>> focussing on perf_cpu_map__empty that may return true for maps
>> containing CPUs but also with an "any CPU"/dummy value.
>>
>> perf_cpu_map__nr is also troubling in that iterating an empty CPU map
>> will yield the "any CPU"/dummy value. Reduce the appearance of some
>> calls to this by using the perf_cpu_map__for_each_cpu macro.
>>
>> Ian Rogers (14):
>>   libperf cpumap: Rename perf_cpu_map__dummy_new
>>   libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
>>   libperf cpumap: Rename perf_cpu_map__empty
>>   libperf cpumap: Replace usage of perf_cpu_map__new(NULL)
>>   libperf cpumap: Add for_each_cpu that skips the "any CPU" case
> 
> Applied 1-6, with James Reviewed-by tags, would be good to have Adrian
> check the PT and BTS parts, testing the end result if he things its all
> ok.
> 

Changing the same lines of code twice in the same patch set is not
really kernel style.

Some of the churn could be reduced by applying and rebasing on the
patch below.

Ideally the patches should be reordered so that the lines only
change once i.e.

	perf_cpu_map__empty -> <replacement>

instead of

	perf_cpu_map__empty -> <rename> -> <replacement>

If that is too much trouble, please accept my ack instead:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


From: Adrian Hunter <adrian.hunter@intel.com>

Factor out perf_cpu_map__empty() use to reduce the occurrences and make
the code more readable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-bts.c | 11 ++++++++---
 tools/perf/arch/x86/util/intel-pt.c  | 21 ++++++++++++---------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d2c8cac11470..cebe994eb9db 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -59,6 +59,11 @@ intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	return INTEL_BTS_AUXTRACE_PRIV_SIZE;
 }
 
+static bool intel_bts_per_cpu(struct evlist *evlist)
+{
+	return !perf_cpu_map__empty(evlist->core.user_requested_cpus);
+}
+
 static int intel_bts_info_fill(struct auxtrace_record *itr,
 			       struct perf_session *session,
 			       struct perf_record_auxtrace_info *auxtrace_info,
@@ -109,8 +114,8 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	struct intel_bts_recording *btsr =
 			container_of(itr, struct intel_bts_recording, itr);
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
+	bool per_cpu_mmaps = intel_bts_per_cpu(evlist);
 	struct evsel *evsel, *intel_bts_evsel = NULL;
-	const struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
 
 	if (opts->auxtrace_sample_mode) {
@@ -143,7 +148,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
-	if (opts->full_auxtrace && !perf_cpu_map__empty(cpus)) {
+	if (opts->full_auxtrace && per_cpu_mmaps) {
 		pr_err(INTEL_BTS_PMU_NAME " does not support per-cpu recording\n");
 		return -EINVAL;
 	}
@@ -224,7 +229,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__empty(cpus))
+		if (per_cpu_mmaps)
 			evsel__set_sample_bit(intel_bts_evsel, CPU);
 	}
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index fa0c718b9e72..0ff9147c75da 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -312,6 +312,11 @@ static void intel_pt_tsc_ctc_ratio(u32 *n, u32 *d)
 	*d = eax;
 }
 
+static bool intel_pt_per_cpu(struct evlist *evlist)
+{
+	return !perf_cpu_map__empty(evlist->core.user_requested_cpus);
+}
+
 static int intel_pt_info_fill(struct auxtrace_record *itr,
 			      struct perf_session *session,
 			      struct perf_record_auxtrace_info *auxtrace_info,
@@ -322,7 +327,8 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
 	struct perf_event_mmap_page *pc;
 	struct perf_tsc_conversion tc = { .time_mult = 0, };
-	bool cap_user_time_zero = false, per_cpu_mmaps;
+	bool per_cpu_mmaps = intel_pt_per_cpu(session->evlist);
+	bool cap_user_time_zero = false;
 	u64 tsc_bit, mtc_bit, mtc_freq_bits, cyc_bit, noretcomp_bit;
 	u32 tsc_ctc_ratio_n, tsc_ctc_ratio_d;
 	unsigned long max_non_turbo_ratio;
@@ -369,8 +375,6 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 			ui__warning("Intel Processor Trace: TSC not available\n");
 	}
 
-	per_cpu_mmaps = !perf_cpu_map__empty(session->evlist->core.user_requested_cpus);
-
 	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
 	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
 	auxtrace_info->priv[INTEL_PT_TIME_SHIFT] = tc.time_shift;
@@ -604,8 +608,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
 	bool have_timing_info, need_immediate = false;
 	struct evsel *evsel, *intel_pt_evsel = NULL;
-	const struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
+	bool per_cpu_mmaps = intel_pt_per_cpu(evlist);
 	u64 tsc_bit;
 	int err;
 
@@ -774,8 +778,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Per-cpu recording needs sched_switch events to distinguish different
 	 * threads.
 	 */
-	if (have_timing_info && !perf_cpu_map__empty(cpus) &&
-	    !record_opts__no_switch_events(opts)) {
+	if (have_timing_info && per_cpu_mmaps && !record_opts__no_switch_events(opts)) {
 		if (perf_can_record_switch_events()) {
 			bool cpu_wide = !target__none(&opts->target) &&
 					!target__has_task(&opts->target);
@@ -832,7 +835,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__empty(cpus))
+		if (per_cpu_mmaps)
 			evsel__set_sample_bit(intel_pt_evsel, CPU);
 	}
 
@@ -858,7 +861,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			tracking_evsel->immediate = true;
 
 		/* In per-cpu case, always need the time of mmap events etc */
-		if (!perf_cpu_map__empty(cpus)) {
+		if (per_cpu_mmaps) {
 			evsel__set_sample_bit(tracking_evsel, TIME);
 			/* And the CPU for switch events */
 			evsel__set_sample_bit(tracking_evsel, CPU);
@@ -870,7 +873,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Warn the user when we do not have enough information to decode i.e.
 	 * per-cpu with no sched_switch (except workload-only).
 	 */
-	if (!ptr->have_sched_switch && !perf_cpu_map__empty(cpus) &&
+	if (!ptr->have_sched_switch && per_cpu_mmaps &&
 	    !target__none(&opts->target) &&
 	    !intel_pt_evsel->core.attr.exclude_user)
 		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
-- 
2.34.1




