Return-Path: <bpf+bounces-75837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65345C99024
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 21:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3483C4E2489
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2B25EFBB;
	Mon,  1 Dec 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFRrM7mp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1282749E4
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620690; cv=none; b=Fj8wWoetGjD28684D1J26zPC963qCV0FIOHdOYkz7y0MqaeO2rWrGkKbjmhv9jwmBxlAV3NnKXRObZytxqCNYHLXb7suZCdAFFDkRjn9H/4BSK1SpUdiOy81MtCEbX0fK0o3MV8+QLAJaA6AikWK57aCwppYtTb8lSoD3LVCQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620690; c=relaxed/simple;
	bh=c8mlL+8JS1BJUpGU/CCeiDRO5fIc5qgfb2CsJTD7loM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M5qk4KZTh53ITLhEQVIgcHmbIiB3GbmNBN14WdmOUTTmfHi4LSH2sdSuLcEfwG0f/aZsAz3MYWSAORfGJVWIz0RDEu4xUEokQI22+yIcYh7p7keOF18LCcY8F5IPGHWds/5w+FyucsLsw6HrVGl4fnSjuvbcqLgqc9oUd9DgqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hFRrM7mp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b609c0f6522so7286360a12.3
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764620687; x=1765225487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVFOz36NzkthLgnEyyQ+T4r4aeS1YE42iDi3jXssFxw=;
        b=hFRrM7mpzLrZTZ2TFHNzSGTtT3ZCRTlV6VnyC1B06vb+UCzxj5rO3hcTfBjgZYEdQR
         dOqBf2N4cx9S/hxn2Wapt93EUeCQMcp9uvOl56LDH7pa6A6AztQlSIdFGHPafNJgce5V
         yKe2+pZm5Ztn+1YiIhllZxWkB4fPosZmh5OLGPUiTUzrQ56JA2WakcqcPBvqvXXN4s9q
         PCyw7pVxMim5HDerEzCaO54D5BpeJ57/bwxGGz0XNNHF5adwAhoLmHLPMAYj5CiqmjrA
         r+uMKAq0CHDN2AYR/BlMZe+oh+mrjj3uAiiJtPEzqW1scUWaiwt6d/RgBmzyEbfBvH+g
         jcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764620687; x=1765225487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVFOz36NzkthLgnEyyQ+T4r4aeS1YE42iDi3jXssFxw=;
        b=HQezqM6/sCRC0wfOt1Hy4vIsvYe45S0N1DtsxfyvzNMR7Qlb6uWuwevdIAdH07aHyx
         NxtIr/ChcyVXj0UwZoLnZO0PgR/Oqb6IiXAUf8f4fx2zC0WfUlTy/2XmzpL7fDNrzvPz
         l54Ti1QSyub49W83coTf62ql+KclcLWI4kW0EPa2qWkQ2domM8wacQOB50aOYuUZEWoK
         OlIAg0LEkEXSYZmwiio6M0EbCm2Hygr0Oy9Ej60K7uU/IZtSeTDEGglyeJn8IlCN59sT
         NWGVIVV/aSZPl8mkRDO/firs1jTw/hhbQeTy3VGgveomuZnyXl4LkKcnxFdlLj6nm+yS
         zHtg==
X-Forwarded-Encrypted: i=1; AJvYcCXqQyOl225Se+EpACPVOroo+mQiDv16TkkEuSWIwmnP1FO2QldoBOcw4FDxOEV5ZMHlbrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0m2WFlqBuScITROwFTF8WhejUYYpnOMUG3OQniPRJGARraQoy
	XQpWrFqWnrkqXd00IBPrli6/HOZEiY9nAGuW/I2SP0+SosGSlyU1FpL5Ob9ty3wq+mxqtj5XbXT
	0Bw3VGn4Nnjp/1w==
X-Google-Smtp-Source: AGHT+IHPxyuFPomFpGgGktNU3wpxpzdAkLl3pdvHFWHui5G6OkggawCXSx5wuTjHZkmGbO2fX9w00ZQkykohvQ==
X-Received: from dycro14.prod.google.com ([2002:a05:693c:2b0e:b0:2a2:454c:f92])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:220f:b0:2a4:3593:c7df with SMTP id 5a478bee46e88-2a719bfe888mr27242313eec.31.1764620686557;
 Mon, 01 Dec 2025 12:24:46 -0800 (PST)
Date: Mon,  1 Dec 2025 12:24:34 -0800
In-Reply-To: <20251201202437.3750901-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251201202437.3750901-2-wusamuel@google.com>
Subject: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
From: Samuel Wu <wusamuel@google.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Cc: christian.loehle@arm.com, Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing cpu_frequency trace_event can be verbose, emitting a nearly
identical trace event for every CPU in the policy even when their
frequencies are identical.

This patch replaces the cpu_frequency trace event with policy_frequency
trace event, a more efficient alternative. From the kernel's
perspective, emitting a trace event once per policy instead of once per
cpu saves some memory and is less overhead. From the post-processing
perspective, analysis of the trace log is simplified without any loss of
information.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/cpufreq/cpufreq.c      | 14 ++------------
 drivers/cpufreq/intel_pstate.c |  6 ++++--
 include/trace/events/power.h   | 24 +++++++++++++++++++++---
 kernel/trace/power-traces.c    |  2 +-
 samples/bpf/cpustat_kern.c     |  8 ++++----
 samples/bpf/cpustat_user.c     |  6 +++---
 tools/perf/builtin-timechart.c | 12 ++++++------
 7 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4472bb1ec83c..dd3f08f3b958 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -309,8 +309,6 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 				      struct cpufreq_freqs *freqs,
 				      unsigned int state)
 {
-	int cpu;
-
 	BUG_ON(irqs_disabled());
 
 	if (cpufreq_disabled())
@@ -344,10 +342,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
 		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
 			 cpumask_pr_args(policy->cpus));
-
-		for_each_cpu(cpu, policy->cpus)
-			trace_cpu_frequency(freqs->new, cpu);
-
+		trace_policy_frequency(freqs->new, policy->cpu, policy->cpus);
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 					 CPUFREQ_POSTCHANGE, freqs);
 
@@ -2201,7 +2196,6 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
 	unsigned int freq;
-	int cpu;
 
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	freq = cpufreq_driver->fast_switch(policy, target_freq);
@@ -2213,11 +2207,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 	arch_set_freq_scale(policy->related_cpus, freq,
 			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
-
-	if (trace_cpu_frequency_enabled()) {
-		for_each_cpu(cpu, policy->cpus)
-			trace_cpu_frequency(freq, cpu);
-	}
+	trace_policy_frequency(freq, policy->cpu, policy->cpus);
 
 	return freq;
 }
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe374573..9724b5d19d83 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2297,7 +2297,8 @@ static int hwp_get_cpu_scaling(int cpu)
 
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 {
-	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
+	trace_policy_frequency(pstate * cpu->pstate.scaling, cpu->cpu,
+			       cpumask_of(cpu->cpu));
 	cpu->pstate.current_pstate = pstate;
 	/*
 	 * Generally, there is no guarantee that this code will always run on
@@ -2587,7 +2588,8 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 
 	target_pstate = get_target_pstate(cpu);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
+	trace_policy_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu,
+			       cpumask_of(cpu->cpu));
 	intel_pstate_update_pstate(cpu, target_pstate);
 
 	sample = &cpu->sample;
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 370f8df2fdb4..317098ffdd5f 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -182,11 +182,29 @@ TRACE_EVENT(pstate_sample,
 		{ PM_EVENT_RECOVER, "recover" }, \
 		{ PM_EVENT_POWEROFF, "poweroff" })
 
-DEFINE_EVENT(cpu, cpu_frequency,
+TRACE_EVENT(policy_frequency,
 
-	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
+	TP_PROTO(unsigned int frequency, unsigned int cpu_id,
+		 const struct cpumask *policy_cpus),
 
-	TP_ARGS(frequency, cpu_id)
+	TP_ARGS(frequency, cpu_id, policy_cpus),
+
+	TP_STRUCT__entry(
+		__field(u32, state)
+		__field(u32, cpu_id)
+		__cpumask(cpumask)
+	),
+
+	TP_fast_assign(
+		__entry->state = frequency;
+		__entry->cpu_id = cpu_id;
+		__assign_cpumask(cpumask, policy_cpus);
+	),
+
+	TP_printk("state=%lu cpu_id=%lu policy_cpus=%*pb",
+		  (unsigned long)__entry->state,
+		  (unsigned long)__entry->cpu_id,
+		  cpumask_pr_args((struct cpumask *)__get_dynamic_array(cpumask)))
 );
 
 TRACE_EVENT(cpu_frequency_limits,
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index f2fe33573e54..a537e68a6878 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -16,5 +16,5 @@
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
-EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_frequency);
+EXPORT_TRACEPOINT_SYMBOL_GPL(policy_frequency);
 
diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
index 7ec7143e2757..f485de0f89b2 100644
--- a/samples/bpf/cpustat_kern.c
+++ b/samples/bpf/cpustat_kern.c
@@ -75,9 +75,9 @@ struct {
 } pstate_duration SEC(".maps");
 
 /*
- * The trace events for cpu_idle and cpu_frequency are taken from:
+ * The trace events for cpu_idle and policy_frequency are taken from:
  * /sys/kernel/tracing/events/power/cpu_idle/format
- * /sys/kernel/tracing/events/power/cpu_frequency/format
+ * /sys/kernel/tracing/events/power/policy_frequency/format
  *
  * These two events have same format, so define one common structure.
  */
@@ -162,7 +162,7 @@ int bpf_prog1(struct cpu_args *ctx)
 	 */
 	if (ctx->state != (u32)-1) {
 
-		/* record pstate after have first cpu_frequency event */
+		/* record pstate after have first policy_frequency event */
 		if (!*pts)
 			return 0;
 
@@ -208,7 +208,7 @@ int bpf_prog1(struct cpu_args *ctx)
 	return 0;
 }
 
-SEC("tracepoint/power/cpu_frequency")
+SEC("tracepoint/power/policy_frequency")
 int bpf_prog2(struct cpu_args *ctx)
 {
 	u64 *pts, *cstate, *pstate, cur_ts, delta;
diff --git a/samples/bpf/cpustat_user.c b/samples/bpf/cpustat_user.c
index 356f756cba0d..f7e81f702358 100644
--- a/samples/bpf/cpustat_user.c
+++ b/samples/bpf/cpustat_user.c
@@ -143,12 +143,12 @@ static int cpu_stat_inject_cpu_idle_event(void)
 
 /*
  * It's possible to have no any frequency change for long time and cannot
- * get ftrace event 'trace_cpu_frequency' for long period, this introduces
+ * get ftrace event 'trace_policy_frequency' for long period, this introduces
  * big deviation for pstate statistics.
  *
  * To solve this issue, below code forces to set 'scaling_max_freq' to 208MHz
- * for triggering ftrace event 'trace_cpu_frequency' and then recovery back to
- * the maximum frequency value 1.2GHz.
+ * for triggering ftrace event 'trace_policy_frequency' and then recovery back
+ * to the maximum frequency value 1.2GHz.
  */
 static int cpu_stat_inject_cpu_frequency_event(void)
 {
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 22050c640dfa..3ef1a2fd0493 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -612,10 +612,10 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 }
 
 static int
-process_sample_cpu_frequency(struct timechart *tchart,
-			     struct evsel *evsel,
-			     struct perf_sample *sample,
-			     const char *backtrace __maybe_unused)
+process_sample_policy_frequency(struct timechart *tchart,
+				struct evsel *evsel,
+				struct perf_sample *sample,
+				const char *backtrace __maybe_unused)
 {
 	u32 state  = evsel__intval(evsel, sample, "state");
 	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
@@ -1541,7 +1541,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 {
 	const struct evsel_str_handler power_tracepoints[] = {
 		{ "power:cpu_idle",		process_sample_cpu_idle },
-		{ "power:cpu_frequency",	process_sample_cpu_frequency },
+		{ "power:policy_frequency",	process_sample_policy_frequency },
 		{ "sched:sched_wakeup",		process_sample_sched_wakeup },
 		{ "sched:sched_switch",		process_sample_sched_switch },
 #ifdef SUPPORT_OLD_POWER_EVENTS
@@ -1804,7 +1804,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 	unsigned int backtrace_args_no = ARRAY_SIZE(backtrace_args);
 
 	const char * const power_args[] = {
-		"-e", "power:cpu_frequency",
+		"-e", "power:policy_frequency",
 		"-e", "power:cpu_idle",
 	};
 	unsigned int power_args_nr = ARRAY_SIZE(power_args);
-- 
2.52.0.107.ga0afd4fd5b-goog


