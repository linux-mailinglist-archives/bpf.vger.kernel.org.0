Return-Path: <bpf+bounces-76073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A400DCA4C0F
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AFC230341D4
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F7330B08;
	Thu,  4 Dec 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnnMAqia"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D72DC328;
	Thu,  4 Dec 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868880; cv=none; b=pSL4il5EAaCTIKnIBd0we3cxOdIUW5fYDZksO72XdH/3chXA2t7Ler8aozxRMiFwen4cxNsio7M+ip58c7obWUUA90GEiAoTwEc1K12EqcgiBhc0qZL4J8JqcNOzjWFBM7tLSBG+cAZxtIhb2x2fAz1uwV9EdUIs6bBhbdSTmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868880; c=relaxed/simple;
	bh=dJP+cF1XpPS4uR1YGghgewhX3tzZYivafXjr5CECvb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nkzvfl17e21tEIiPLrCXcm4oUOAB7EaqzmQN//6ZF1SRU3OJBysB5xISBbGSSMt3NysOhooNj8lb1gKuDGSzPxIw58gxJeQgCeshgOpGRD/vSpSldo36n45ZSVSogszz1/yCilYng/zer5C2+4kcGNs/vgGrWE1cn7ZOc3WEtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnnMAqia; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764868877; x=1796404877;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dJP+cF1XpPS4uR1YGghgewhX3tzZYivafXjr5CECvb8=;
  b=HnnMAqia8ywdk61rxLhcgmeOh908ltN/gynH5e7q0sCycAwb4+2ymdZp
   RsYwMIN9/mBbEqxexI81+mFQifmAvJECn2nPQE6mFh4snUNm8mQXy+RJf
   FaEvP+xDZtgD43U25P3d5M8M186xt/69lwhrXcm7DM+jEPcvV0Pxwxjtq
   Yjc0cgGFQwQFXH+5UUfL7TjaLPGg/Nu4N2sd0aRhKu/kyx+1ehkp3zLer
   DmA7BGGfImO+Ruz59izjtW84djA0katB0SpWmedlHxofFFOwPB5b01iUv
   +Eq/GPYPkf9lfBORmgpMgCzyPDiHS7pqwKwWKxFwsRgWo9o3U1Qh92KNn
   Q==;
X-CSE-ConnectionGUID: GzPBoaW+Rl2OLu6uekySmw==
X-CSE-MsgGUID: 7ixloMCERSeOd2reDEeLvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="92376854"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="92376854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:21:14 -0800
X-CSE-ConnectionGUID: iHZae6+nRTWbtGgZB3HPzg==
X-CSE-MsgGUID: /cT1YChFRxCL5BaCzLOd8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="194112143"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:21:14 -0800
Message-ID: <2b31224a6cf361a5d2859c84aa1bcdf52916423e.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with
 trace_policy_frequency
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle
	 <christian.loehle@arm.com>
Cc: Samuel Wu <wusamuel@google.com>, Huang Rui <ray.huang@amd.com>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan	 <perry.yuan@amd.com>, Jonathan
 Corbet <corbet@lwn.net>, Viresh Kumar	 <viresh.kumar@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Len Brown	
 <lenb@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin	 <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Date: Thu, 04 Dec 2025 09:21:13 -0800
In-Reply-To: <CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
References: <20251201202437.3750901-1-wusamuel@google.com>
	 <20251201202437.3750901-2-wusamuel@google.com>
	 <f28577c1-ca95-43ca-b179-32e2cd46d054@arm.com>
	 <CAJZ5v0hAmgjozeX0egBs_ii_zzKXGPsPBUWwmGD+23KD++Rzqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-04 at 15:57 +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 4, 2025 at 1:49=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >=20
> > On 12/1/25 20:24, Samuel Wu wrote:
> > > The existing cpu_frequency trace_event can be verbose, emitting a
> > > nearly
> > > identical trace event for every CPU in the policy even when their
> > > frequencies are identical.
> > >=20
> > > This patch replaces the cpu_frequency trace event with
> > > policy_frequency
> > > trace event, a more efficient alternative. From the kernel's
> > > perspective, emitting a trace event once per policy instead of
> > > once per
> > > cpu saves some memory and is less overhead. From the post-
> > > processing
> > > perspective, analysis of the trace log is simplified without any
> > > loss of
> > > information.
> > >=20
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > > =C2=A0drivers/cpufreq/cpufreq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++=
------------
> > > =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0 6 ++++--
> > > =C2=A0include/trace/events/power.h=C2=A0=C2=A0 | 24 +++++++++++++++++=
++++---
> > > =C2=A0kernel/trace/power-traces.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0samples/bpf/cpustat_kern.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++=
++----
> > > =C2=A0samples/bpf/cpustat_user.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++=
+---
> > > =C2=A0tools/perf/builtin-timechart.c | 12 ++++++------
> > > =C2=A07 files changed, 41 insertions(+), 31 deletions(-)
> > >=20
> > > diff --git a/drivers/cpufreq/cpufreq.c
> > > b/drivers/cpufreq/cpufreq.c
> > > index 4472bb1ec83c..dd3f08f3b958 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -309,8 +309,6 @@ static void cpufreq_notify_transition(struct
> > > cpufreq_policy *policy,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct c=
pufreq_freqs *freqs,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=
 int state)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 int cpu;
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(irqs_disabled());
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpufreq_disabled())
> > > @@ -344,10 +342,7 @@ static void cpufreq_notify_transition(struct
> > > cpufreq_policy *policy,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_pr_=
args(policy->cpus));
> > > -
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 for_each_cpu(cpu, policy->cpus)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_cpu_frequency(=
freqs->new, cpu);
> > > -
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 trace_policy_frequency(freqs->new, policy->cpu,
> > > policy->cpus);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> > > srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CPUFREQ_POSTCHANGE,
> > > freqs);
> > >=20
> > > @@ -2201,7 +2196,6 @@ unsigned int
> > > cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int target_freq)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int freq;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 int cpu;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_freq =3D clamp_val(target_freq,=
 policy->min, policy-
> > > >max);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq =3D cpufreq_driver->fast_switch(p=
olicy, target_freq);
> > > @@ -2213,11 +2207,7 @@ unsigned int
> > > cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch_set_freq_scale(policy->related_cp=
us, freq,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 arch_scale_freq_ref(policy->cpu));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpufreq_stats_record_transition(policy=
, freq);
> > > -
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (trace_cpu_frequency_enabled()) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 for_each_cpu(cpu, policy->cpus)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_cpu_frequency(=
freq, cpu);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 trace_policy_frequency(freq, policy->cpu, p=
olicy->cpus);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return freq;
> > > =C2=A0}
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index ec4abe374573..9724b5d19d83 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2297,7 +2297,8 @@ static int hwp_get_cpu_scaling(int cpu)
> > >=20
> > > =C2=A0static void intel_pstate_set_pstate(struct cpudata *cpu, int
> > > pstate)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 trace_cpu_frequency(pstate * cpu->pstate.sc=
aling, cpu-
> > > >cpu);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 trace_policy_frequency(pstate * cpu->pstate=
.scaling, cpu-
> > > >cpu,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpumask_of(cpu->cpu));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->pstate.current_pstate =3D pstate;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Generally, there is no guarant=
ee that this code will
> > > always run on
> > > @@ -2587,7 +2588,8 @@ static void
> > > intel_pstate_adjust_pstate(struct cpudata *cpu)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_pstate =3D get_target_pstate(cp=
u);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_pstate =3D intel_pstate_prepare=
_request(cpu,
> > > target_pstate);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 trace_cpu_frequency(target_pstate * cpu->ps=
tate.scaling,
> > > cpu->cpu);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 trace_policy_frequency(target_pstate * cpu-=
>pstate.scaling,
> > > cpu->cpu,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpumask_of(cpu->cpu));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intel_pstate_update_pstate(cpu, target=
_pstate);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sample =3D &cpu->sample;
> > > diff --git a/include/trace/events/power.h
> > > b/include/trace/events/power.h
> > > index 370f8df2fdb4..317098ffdd5f 100644
> > > --- a/include/trace/events/power.h
> > > +++ b/include/trace/events/power.h
> > > @@ -182,11 +182,29 @@ TRACE_EVENT(pstate_sample,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 { PM_EVENT_RECOVER, "recover" }, \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 { PM_EVENT_POWEROFF, "poweroff" })
> > >=20
> > > -DEFINE_EVENT(cpu, cpu_frequency,
> > > +TRACE_EVENT(policy_frequency,
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(unsigned int frequency, unsigned i=
nt cpu_id),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(unsigned int frequency, unsigned i=
nt cpu_id,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct cpumask *policy_cpus),
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(frequency, cpu_id)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(frequency, cpu_id, policy_cpus),
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 TP_STRUCT__entry(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __field(u32, state)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __field(u32, cpu_id)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __cpumask(cpumask)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ),
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 TP_fast_assign(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __entry->state =3D frequency;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __entry->cpu_id =3D cpu_id;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __assign_cpumask(cpumask, policy_cpus);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ),
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 TP_printk("state=3D%lu cpu_id=3D%lu policy_=
cpus=3D%*pb",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (unsigned long)__entry->state,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (unsigned long)__entry->cpu_id,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cpumask_pr_args((struct cpumask
> > > *)__get_dynamic_array(cpumask)))
> > > =C2=A0);
> > >=20
> > > =C2=A0TRACE_EVENT(cpu_frequency_limits,
> > > diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-
> > > traces.c
> > > index f2fe33573e54..a537e68a6878 100644
> > > --- a/kernel/trace/power-traces.c
> > > +++ b/kernel/trace/power-traces.c
> > > @@ -16,5 +16,5 @@
> > >=20
> > > =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
> > > =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
> > > -EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_frequency);
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(policy_frequency);
> > >=20
> > > diff --git a/samples/bpf/cpustat_kern.c
> > > b/samples/bpf/cpustat_kern.c
> > > index 7ec7143e2757..f485de0f89b2 100644
> > > --- a/samples/bpf/cpustat_kern.c
> > > +++ b/samples/bpf/cpustat_kern.c
> > > @@ -75,9 +75,9 @@ struct {
> > > =C2=A0} pstate_duration SEC(".maps");
> > >=20
> > > =C2=A0/*
> > > - * The trace events for cpu_idle and cpu_frequency are taken
> > > from:
> > > + * The trace events for cpu_idle and policy_frequency are taken
> > > from:
> > > =C2=A0 * /sys/kernel/tracing/events/power/cpu_idle/format
> > > - * /sys/kernel/tracing/events/power/cpu_frequency/format
> > > + * /sys/kernel/tracing/events/power/policy_frequency/format
> > > =C2=A0 *
> > > =C2=A0 * These two events have same format, so define one common
> > > structure.
> > > =C2=A0 */
> > > @@ -162,7 +162,7 @@ int bpf_prog1(struct cpu_args *ctx)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ctx->state !=3D (u32)-1) {
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* record pstate after have first cpu_frequency
> > > event */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* record pstate after have first policy_frequency
> > > event */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!*pts)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > >=20
> > > @@ -208,7 +208,7 @@ int bpf_prog1(struct cpu_args *ctx)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > =C2=A0}
> > >=20
> > > -SEC("tracepoint/power/cpu_frequency")
> > > +SEC("tracepoint/power/policy_frequency")
> > > =C2=A0int bpf_prog2(struct cpu_args *ctx)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 *pts, *cstate, *pstate, cur_ts, de=
lta;
> > > diff --git a/samples/bpf/cpustat_user.c
> > > b/samples/bpf/cpustat_user.c
> > > index 356f756cba0d..f7e81f702358 100644
> > > --- a/samples/bpf/cpustat_user.c
> > > +++ b/samples/bpf/cpustat_user.c
> > > @@ -143,12 +143,12 @@ static int
> > > cpu_stat_inject_cpu_idle_event(void)
> > >=20
> > > =C2=A0/*
> > > =C2=A0 * It's possible to have no any frequency change for long time
> > > and cannot
> > > - * get ftrace event 'trace_cpu_frequency' for long period, this
> > > introduces
> > > + * get ftrace event 'trace_policy_frequency' for long period,
> > > this introduces
> > > =C2=A0 * big deviation for pstate statistics.
> > > =C2=A0 *
> > > =C2=A0 * To solve this issue, below code forces to set
> > > 'scaling_max_freq' to 208MHz
> > > - * for triggering ftrace event 'trace_cpu_frequency' and then
> > > recovery back to
> > > - * the maximum frequency value 1.2GHz.
> > > + * for triggering ftrace event 'trace_policy_frequency' and then
> > > recovery back
> > > + * to the maximum frequency value 1.2GHz.
> > > =C2=A0 */
> > > =C2=A0static int cpu_stat_inject_cpu_frequency_event(void)
> > > =C2=A0{
> > > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-
> > > timechart.c
> > > index 22050c640dfa..3ef1a2fd0493 100644
> > > --- a/tools/perf/builtin-timechart.c
> > > +++ b/tools/perf/builtin-timechart.c
> > > @@ -612,10 +612,10 @@ process_sample_cpu_idle(struct timechart
> > > *tchart __maybe_unused,
> > > =C2=A0}
> > >=20
> > > =C2=A0static int
> > > -process_sample_cpu_frequency(struct timechart *tchart,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct evsel *evsel,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct perf_sample *sample,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const char *backtrace __maybe_unused)
> > > +process_sample_policy_frequency(struct timechart *tchart,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct evsel *evsel,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct perf_sample *sample,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *backtrace
> > > __maybe_unused)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 state=C2=A0 =3D evsel__intval(evse=
l, sample, "state");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 cpu_id =3D evsel__intval(evsel, sa=
mple, "cpu_id");
> > > @@ -1541,7 +1541,7 @@ static int __cmd_timechart(struct timechart
> > > *tchart, const char *output_name)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct evsel_str_handler power_t=
racepoints[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 { "power:cpu_idle",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > process_sample_cpu_idle },
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { "power:cpu_frequency",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > process_sample_cpu_frequency },
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { "power:policy_frequency",=C2=A0=C2=A0=C2=A0=C2=A0
> > > process_sample_policy_frequency },
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 { "sched:sched_wakeup",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> > > process_sample_sched_wakeup },
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 { "sched:sched_switch",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> > > process_sample_sched_switch },
> > > =C2=A0#ifdef SUPPORT_OLD_POWER_EVENTS
> > > @@ -1804,7 +1804,7 @@ static int timechart__record(struct
> > > timechart *tchart, int argc, const char **ar
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int backtrace_args_no =3D
> > > ARRAY_SIZE(backtrace_args);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char * const power_args[] =3D {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "-e", "power:cpu_frequency",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "-e", "power:policy_frequency",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "-e", "power:cpu_idle",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int power_args_nr =3D ARRAY_S=
IZE(power_args);
> >=20
> > perf timechart seem to do per-CPU reporting though?
> > So this is broken by not emitting an event per-CPU? At least with a
> > simple s/cpu_frequency/policy_frequency/
> > like here.
> > Similar for the bpf samples technically...
>=20
> This kind of boils down to whether or not tracepoints can be regarded
> as ABI and to what extent.
>=20

We have tools using tracing. We may need to check those tools.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/to=
ols/power/x86/intel_pstate_tracer/intel_pstate_tracer.py?h=3Dnext-20251204
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/to=
ols/power/x86/amd_pstate_tracer/amd_pstate_trace.py?h=3Dnext-20251204

Thanks,
Srinivas


> In this particular case, I'm not sure I agree with the stated
> motivation.
>=20
> First of all, on systems with one CPU per cpufreq policy (the vast
> majority of x86, including AMD, and the ARM systems using the CPPC
> driver AFAICS), the "issue" at hand is actually a non-issue and
> changing the name of the tracepoint alone would confuse things in
> user
> space IIUC.=C2=A0 Those need to work the way they do today.
>=20
> On systems with multiple CPUs per cpufreq policy there is some extra
> overhead related to the cpu_frequency tracepoint, but the if someone
> is only interested in the "policy" frequency, they can filter out all
> CPUs belonging to the same policy except for one from the traces,
> don't they?

