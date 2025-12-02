Return-Path: <bpf+bounces-75879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D4C9B6C8
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 13:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5DA64E3046
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E72D3126C9;
	Tue,  2 Dec 2025 12:03:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0D2288F7;
	Tue,  2 Dec 2025 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677014; cv=none; b=iIXMNDZ4SPDP68AZ47ZyJeDI6SbXt5ztqVG1qUGspKwhSPbReat4hqYoo7fGzX8I2Bam8h+0JkBt4/v66DzxmKS5itIqI11VHwKXf6J9zDCquhj2a253Juv7rHxOn3OoOXo/uFPK+x23fTHiDUKWgNomacNUmMT99za07UhA10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677014; c=relaxed/simple;
	bh=W0DSPkYRUbCwHCoprwCL/Fyya55vjwBNtQRR5Xse8vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgLVf//Ojvplt8YIh8wTlWxGeFuWMYyTAsBy6XZILDgZ/KAOEBPCkSm+AJtiuq0GL4UpOLKnGrd0teT5OeY+JY9fKezfMnywt27OSAWmz9HUKeBXKYLouQwZtO5+K4jmNkZ6D/MBFGWPeujQdGL9LkDkIAIFEDVP2UF8pNcFeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B94153B;
	Tue,  2 Dec 2025 04:03:23 -0800 (PST)
Received: from [192.168.1.127] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AEA73F73B;
	Tue,  2 Dec 2025 04:03:22 -0800 (PST)
Message-ID: <51711ea1-2e5c-457d-902d-68797eb496cb@arm.com>
Date: Tue, 2 Dec 2025 12:03:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with
 trace_policy_frequency
To: Samuel Wu <wusamuel@google.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>
Cc: christian.loehle@arm.com, kernel-team@android.com,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251201202437.3750901-1-wusamuel@google.com>
 <20251201202437.3750901-2-wusamuel@google.com>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20251201202437.3750901-2-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Samuel,

On 01-12-2025 20:24, Samuel Wu wrote:
> The existing cpu_frequency trace_event can be verbose, emitting a nearly
> identical trace event for every CPU in the policy even when their
> frequencies are identical.
> 
> This patch replaces the cpu_frequency trace event with policy_frequency
> trace event, a more efficient alternative. From the kernel's
> perspective, emitting a trace event once per policy instead of once per
> cpu saves some memory and is less overhead.

I'd be fully behind that as a general guideline.

> From the post-processing
> perspective, analysis of the trace log is simplified without any loss of
> information.

Unfortunately I'm not so sure about the "simplified" part (as of today),
more on that below.

> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>   drivers/cpufreq/cpufreq.c      | 14 ++------------
>   drivers/cpufreq/intel_pstate.c |  6 ++++--
>   include/trace/events/power.h   | 24 +++++++++++++++++++++---
>   kernel/trace/power-traces.c    |  2 +-
>   samples/bpf/cpustat_kern.c     |  8 ++++----
>   samples/bpf/cpustat_user.c     |  6 +++---
>   tools/perf/builtin-timechart.c | 12 ++++++------
>   7 files changed, 41 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c..dd3f08f3b958 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -309,8 +309,6 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>   				      struct cpufreq_freqs *freqs,
>   				      unsigned int state)
>   {
> -	int cpu;
> -
>   	BUG_ON(irqs_disabled());
>   
>   	if (cpufreq_disabled())
> @@ -344,10 +342,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>   		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
>   		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
>   			 cpumask_pr_args(policy->cpus));
> -
> -		for_each_cpu(cpu, policy->cpus)
> -			trace_cpu_frequency(freqs->new, cpu);
> -
> +		trace_policy_frequency(freqs->new, policy->cpu, policy->cpus);
>   		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
>   					 CPUFREQ_POSTCHANGE, freqs);
>   
> @@ -2201,7 +2196,6 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>   					unsigned int target_freq)
>   {
>   	unsigned int freq;
> -	int cpu;
>   
>   	target_freq = clamp_val(target_freq, policy->min, policy->max);
>   	freq = cpufreq_driver->fast_switch(policy, target_freq);
> @@ -2213,11 +2207,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>   	arch_set_freq_scale(policy->related_cpus, freq,
>   			    arch_scale_freq_ref(policy->cpu));
>   	cpufreq_stats_record_transition(policy, freq);
> -
> -	if (trace_cpu_frequency_enabled()) {
> -		for_each_cpu(cpu, policy->cpus)
> -			trace_cpu_frequency(freq, cpu);
> -	}
> +	trace_policy_frequency(freq, policy->cpu, policy->cpus);
>   
>   	return freq;
>   }
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ec4abe374573..9724b5d19d83 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2297,7 +2297,8 @@ static int hwp_get_cpu_scaling(int cpu)
>   
>   static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
>   {
> -	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> +	trace_policy_frequency(pstate * cpu->pstate.scaling, cpu->cpu,
> +			       cpumask_of(cpu->cpu));
>   	cpu->pstate.current_pstate = pstate;
>   	/*
>   	 * Generally, there is no guarantee that this code will always run on
> @@ -2587,7 +2588,8 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
>   
>   	target_pstate = get_target_pstate(cpu);
>   	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
> -	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
> +	trace_policy_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu,
> +			       cpumask_of(cpu->cpu));
>   	intel_pstate_update_pstate(cpu, target_pstate);
>   
>   	sample = &cpu->sample;
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 370f8df2fdb4..317098ffdd5f 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -182,11 +182,29 @@ TRACE_EVENT(pstate_sample,
>   		{ PM_EVENT_RECOVER, "recover" }, \
>   		{ PM_EVENT_POWEROFF, "poweroff" })
>   
> -DEFINE_EVENT(cpu, cpu_frequency,
> +TRACE_EVENT(policy_frequency,
>   
> -	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
> +	TP_PROTO(unsigned int frequency, unsigned int cpu_id,
> +		 const struct cpumask *policy_cpus),
>   
> -	TP_ARGS(frequency, cpu_id)
> +	TP_ARGS(frequency, cpu_id, policy_cpus),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, state)
> +		__field(u32, cpu_id)
> +		__cpumask(cpumask)

Using a cpumask is the most technically correct option here, but it also carries a big issue.
Userspace tooling will have a very hard time doing anything with it. A lot of that is down
to having no appropriate counterpart in "table libraries" in general (e.g. what would you
map that to in pandas, polars or SQL ?). Some of the lack of support is probably also down to how
infrequently used it is. For example I don't think Perfetto would be able to handle that
in the ftrace_event and args table, as the documented supported value types are:

args table:
value_type 	STRING 	The type of the value of the arg. Will be one of 'int', 'uint', 'string', 'real', 'pointer', 'bool' or 'json'.
https://perfetto.dev/docs/analysis/stdlib-docs

So while I definitely support improving the situation around cpumasks (I lobbied a bit for that),
I don't think the ecosystem is ready for it yet and having such a core event switched to using it
is going to cause a lot of pain.

Some alternatives for tooling could be:
1. Record the policy cpumasks in a tool-friendly format in the trace header, but no current format I know
    of provides that, and ftrace does not provide a "JSON blob to be passed through" we could easily append to.
    Any such addition will therefore require libraries update which will take time.

3. Doing without the data in the trace. That means collecting and bundling another sidecar file, which
    is really not convenient and still requires 3rd party tool modifications for end users.

2. Add policy_frequency event, but not remove cpu_frequency yet. Possibly with a deprecation warning
    when enabling the event.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->state = frequency;
> +		__entry->cpu_id = cpu_id;
> +		__assign_cpumask(cpumask, policy_cpus);

ipi_send_cpumask uses cpumask_bits():

		__assign_cpumask(cpumask, cpumask_bits(cpumask));

It's not clear what is best practice, as struct cpumask contains a single member anyway and
__assign_cpumask() expands to a memcpy() so they are functionally identical.

> +	),
> +
> +	TP_printk("state=%lu cpu_id=%lu policy_cpus=%*pb",
> +		  (unsigned long)__entry->state,
> +		  (unsigned long)__entry->cpu_id,
> +		  cpumask_pr_args((struct cpumask *)__get_dynamic_array(cpumask)))

Looking at ipi_send_cpumask, this should be:

   __get_cpumask(cpumask)

The cast and cpumask_pr_args() may look like it's working, but there is only a very slim
chance any downstream tool will know what to do with this. Looking at libtraceevent
(which trace-cmd is based on):

./utest/traceevent-utest.c:116: "print fmt: \"cpumask=%s\", __get_cpumask(cpumask)\n";
./src/event-parse.c:3674:       if (strcmp(token, "__get_cpumask") == 0 ||
./src/event-parse.c:7568:               printf("__get_cpumask(%s)", args->bitmask.bitmask);

But there is no match for "cpumask_pr_args".

Considering the gap between what works when using the in-kernel text rendering and what can be
reasonably expected to work in any other userspace tool, it's a good idea to try
as many as possible unfortunately.

>   );
>   
>   TRACE_EVENT(cpu_frequency_limits,
> diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
> index f2fe33573e54..a537e68a6878 100644
> --- a/kernel/trace/power-traces.c
> +++ b/kernel/trace/power-traces.c
> @@ -16,5 +16,5 @@
>   
>   EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
>   EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
> -EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_frequency);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(policy_frequency);
>   
> diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
> index 7ec7143e2757..f485de0f89b2 100644
> --- a/samples/bpf/cpustat_kern.c
> +++ b/samples/bpf/cpustat_kern.c
> @@ -75,9 +75,9 @@ struct {
>   } pstate_duration SEC(".maps");
>   
>   /*
> - * The trace events for cpu_idle and cpu_frequency are taken from:
> + * The trace events for cpu_idle and policy_frequency are taken from:
>    * /sys/kernel/tracing/events/power/cpu_idle/format
> - * /sys/kernel/tracing/events/power/cpu_frequency/format
> + * /sys/kernel/tracing/events/power/policy_frequency/format
>    *
>    * These two events have same format, so define one common structure.
>    */
> @@ -162,7 +162,7 @@ int bpf_prog1(struct cpu_args *ctx)
>   	 */
>   	if (ctx->state != (u32)-1) {
>   
> -		/* record pstate after have first cpu_frequency event */
> +		/* record pstate after have first policy_frequency event */
>   		if (!*pts)
>   			return 0;
>   
> @@ -208,7 +208,7 @@ int bpf_prog1(struct cpu_args *ctx)
>   	return 0;
>   }
>   
> -SEC("tracepoint/power/cpu_frequency")
> +SEC("tracepoint/power/policy_frequency")
>   int bpf_prog2(struct cpu_args *ctx)
>   {
>   	u64 *pts, *cstate, *pstate, cur_ts, delta;
> diff --git a/samples/bpf/cpustat_user.c b/samples/bpf/cpustat_user.c
> index 356f756cba0d..f7e81f702358 100644
> --- a/samples/bpf/cpustat_user.c
> +++ b/samples/bpf/cpustat_user.c
> @@ -143,12 +143,12 @@ static int cpu_stat_inject_cpu_idle_event(void)
>   
>   /*
>    * It's possible to have no any frequency change for long time and cannot
> - * get ftrace event 'trace_cpu_frequency' for long period, this introduces
> + * get ftrace event 'trace_policy_frequency' for long period, this introduces
>    * big deviation for pstate statistics.
>    *
>    * To solve this issue, below code forces to set 'scaling_max_freq' to 208MHz
> - * for triggering ftrace event 'trace_cpu_frequency' and then recovery back to
> - * the maximum frequency value 1.2GHz.
> + * for triggering ftrace event 'trace_policy_frequency' and then recovery back
> + * to the maximum frequency value 1.2GHz.
>    */
>   static int cpu_stat_inject_cpu_frequency_event(void)
>   {
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 22050c640dfa..3ef1a2fd0493 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -612,10 +612,10 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
>   }
>   
>   static int
> -process_sample_cpu_frequency(struct timechart *tchart,
> -			     struct evsel *evsel,
> -			     struct perf_sample *sample,
> -			     const char *backtrace __maybe_unused)
> +process_sample_policy_frequency(struct timechart *tchart,
> +				struct evsel *evsel,
> +				struct perf_sample *sample,
> +				const char *backtrace __maybe_unused)
>   {
>   	u32 state  = evsel__intval(evsel, sample, "state");
>   	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
> @@ -1541,7 +1541,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
>   {
>   	const struct evsel_str_handler power_tracepoints[] = {
>   		{ "power:cpu_idle",		process_sample_cpu_idle },
> -		{ "power:cpu_frequency",	process_sample_cpu_frequency },
> +		{ "power:policy_frequency",	process_sample_policy_frequency },
>   		{ "sched:sched_wakeup",		process_sample_sched_wakeup },
>   		{ "sched:sched_switch",		process_sample_sched_switch },
>   #ifdef SUPPORT_OLD_POWER_EVENTS
> @@ -1804,7 +1804,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
>   	unsigned int backtrace_args_no = ARRAY_SIZE(backtrace_args);
>   
>   	const char * const power_args[] = {
> -		"-e", "power:cpu_frequency",
> +		"-e", "power:policy_frequency",
>   		"-e", "power:cpu_idle",
>   	};
>   	unsigned int power_args_nr = ARRAY_SIZE(power_args);

--

Douglas


