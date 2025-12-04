Return-Path: <bpf+bounces-76007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBDCA20B1
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 01:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 018383012744
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131631624D5;
	Thu,  4 Dec 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpP+knOR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA4DDC5
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808417; cv=none; b=pWM0AW7GTUIOQAlJN+bYXIeND3i0vOPZMqz10DBEMM3IdTXYgRlqoRxh9GfP6IJ9tJPIYkrEanPl50dnEmVnFDBRHCxUvshmz9g+Wob30Y1N1zNJoIEbLwYFaOzrKtzl7y2W52mrcYLm577LGOP7tWDZt9jKFkerc1wOVw+z/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808417; c=relaxed/simple;
	bh=Gyu07sgO89udA4VpdmLEzJ2y+Ygct3bzDi4mURvrIpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jF06fDdFPD3MjAXX7Q5ZlIDP7s+OJIdxV+shG56zSj68VmvPwy/2fUJkQDW1M5UC+8tGJ/cw1VOwl3DWLjUEUeDwKs1kWe2ueo/p1ZS90jmQ8mEIwYmY/xmj3ubfd+nvfIYL1LIgC16xhLJcvy+CBzVhwUeCZWXIixVpwdLjnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpP+knOR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79d1247240so56864766b.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764808414; x=1765413214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umN819w48S7XpRn5se0oiD1rh9hIyAruGfJiHIcVXLk=;
        b=PpP+knOR37fIwWPJ1GcYPRMmF8K54s073MVve/sn+koeVyYYfZ/PJ1MBIjf58cG5Q+
         RwL5o/9BJmYuHsjl5zPolLB7vNFx++HBd04yQsOY5z0siFbFca0+6/ExGREbScS/mips
         ordLiud9qcbFfkJgFg5qsoSYqMqqTPH9iFPMRvq+XLv2oFn5lQUjsynkFDDqWQJAzH0/
         t0350LjKb9zjwlbsSQ5cd1v84YaCkH1PdpWiO8fEpkxC/DZgNXLI6G6z+9bRtpByGVav
         xZJLFf/vTrBXWKNSwwF1/Yds7msXdEeG6mMWN/5taEbhxwwyD63AlM9139MJuIUf6G6H
         3WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764808414; x=1765413214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umN819w48S7XpRn5se0oiD1rh9hIyAruGfJiHIcVXLk=;
        b=Mvx+6gy5k7eaVxkMkIOksW1OZXgIPbnOEXNoUjWApRgx47voXLTcqTGUNOeMmiBYYT
         2ITGky20J3bGSOMvloWO/y8cU7ELX/Z1xGXbksnTb9mVqo+TkWK5ENOosKjm1nZM1YV7
         sNKLd34SS0T0l1+F9fXBmUkwVyRuIsln3Lnd49/a+arE6oHEkdhZyKifgBTWvmGQt7wi
         0xj0EQhhDQgRBShRjsq3sS8j9NFAWiSusiPn7Wi2fr7lrOMrvcVYx1g70d1gvRFV/kS+
         c6I0WGyc3RDm+wS9jc0jnb51TwIHIQh/zVE37+DjOJtQsY1cw4J+S5ss90/jHRiPIdUR
         TKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwaR2OR1LR1/op9PilTIo4kV87Hw6pgVGceOfPTwVbnL3QzwFvmOUue3zT+IW4v5ugx3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Q9IeTzfSqJXLF4jbe6o7arl+vRzARNycNbBX8TrYOtAKQI2h
	VLrEjLABMngpqDUfK2xa1HEsF9T2xlqM2hfdx0Vcu4/qewfurj01dit+0bXJCB8iyKw77w5i/vi
	+NSKwWa1gyyhjnVZbb9Ng9hElT2l1iuz3G3f6Abwj
X-Gm-Gg: ASbGncsMDbKhWXwfytC2ysBRBHu2u/keTil/dLe/8uiy3rp3fw0pYLeAAfdFQoGtyi7
	9C1mrbMEBI46j8eQdVVrqIvR43Fsi+gMvAui5+/K9C3Hci0gu7MV94AoJDKyn5CA78oMhM3cCUH
	ld7zWKWLJnLKptMwzoNE/m34SFO78sGHfJxIsgJBCpMsEcqP1iu0BYVOkq1LtSnM6+hSByN60Hn
	WvS2U73S6LCGny0aO8G6XqLB4kTMeruqzfscUeNAjYMarZ1ReLX3jJ61a60faF4TUzI05Mlq9a4
	tnncJj9IkhdAqeeKOWO8lofeSlJrrw==
X-Google-Smtp-Source: AGHT+IHiW686iz9sbIrGvDGc5m0yQyoZa9JTastn+MWfElK1LeOcbwJzc9K8FNpVwBziTCtyvIuv20SpJtsdYCwKNF4=
X-Received: by 2002:a17:907:d8e:b0:b73:1baa:6424 with SMTP id
 a640c23a62f3a-b79dc7c29b5mr565562266b.55.1764808413540; Wed, 03 Dec 2025
 16:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com> <20251201202437.3750901-2-wusamuel@google.com>
 <51711ea1-2e5c-457d-902d-68797eb496cb@arm.com>
In-Reply-To: <51711ea1-2e5c-457d-902d-68797eb496cb@arm.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 3 Dec 2025 16:33:22 -0800
X-Gm-Features: AWmQ_bm1mpitIcii6HDOivmMy4RjSPBoPtqJ3zy6c1_aiBXckMIMe8FKRJn1KVY
Message-ID: <CAG2KctqZfkHDXjhv+aTDAeNgxkA_V9kQjQH0rm5moaRX38MS3Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
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
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	christian.loehle@arm.com, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Lalit Maganti <lalitm@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:03=E2=80=AFAM Douglas Raillard
<douglas.raillard@arm.com> wrote:
>
> Hi Samuel,
>
> On 01-12-2025 20:24, Samuel Wu wrote:
> > The existing cpu_frequency trace_event can be verbose, emitting a nearl=
y
> > identical trace event for every CPU in the policy even when their
> > frequencies are identical.
> >
> > This patch replaces the cpu_frequency trace event with policy_frequency
> > trace event, a more efficient alternative. From the kernel's
> > perspective, emitting a trace event once per policy instead of once per
> > cpu saves some memory and is less overhead.
>
> I'd be fully behind that as a general guideline.
>
> > From the post-processing
> > perspective, analysis of the trace log is simplified without any loss o=
f
> > information.
>
> Unfortunately I'm not so sure about the "simplified" part (as of today),
> more on that below.
>
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >   drivers/cpufreq/cpufreq.c      | 14 ++------------
> >   drivers/cpufreq/intel_pstate.c |  6 ++++--
> >   include/trace/events/power.h   | 24 +++++++++++++++++++++---
> >   kernel/trace/power-traces.c    |  2 +-
> >   samples/bpf/cpustat_kern.c     |  8 ++++----
> >   samples/bpf/cpustat_user.c     |  6 +++---
> >   tools/perf/builtin-timechart.c | 12 ++++++------
> >   7 files changed, 41 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 4472bb1ec83c..dd3f08f3b958 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -309,8 +309,6 @@ static void cpufreq_notify_transition(struct cpufre=
q_policy *policy,
> >                                     struct cpufreq_freqs *freqs,
> >                                     unsigned int state)
> >   {
> > -     int cpu;
> > -
> >       BUG_ON(irqs_disabled());
> >
> >       if (cpufreq_disabled())
> > @@ -344,10 +342,7 @@ static void cpufreq_notify_transition(struct cpufr=
eq_policy *policy,
> >               adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
> >               pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
> >                        cpumask_pr_args(policy->cpus));
> > -
> > -             for_each_cpu(cpu, policy->cpus)
> > -                     trace_cpu_frequency(freqs->new, cpu);
> > -
> > +             trace_policy_frequency(freqs->new, policy->cpu, policy->c=
pus);
> >               srcu_notifier_call_chain(&cpufreq_transition_notifier_lis=
t,
> >                                        CPUFREQ_POSTCHANGE, freqs);
> >
> > @@ -2201,7 +2196,6 @@ unsigned int cpufreq_driver_fast_switch(struct cp=
ufreq_policy *policy,
> >                                       unsigned int target_freq)
> >   {
> >       unsigned int freq;
> > -     int cpu;
> >
> >       target_freq =3D clamp_val(target_freq, policy->min, policy->max);
> >       freq =3D cpufreq_driver->fast_switch(policy, target_freq);
> > @@ -2213,11 +2207,7 @@ unsigned int cpufreq_driver_fast_switch(struct c=
pufreq_policy *policy,
> >       arch_set_freq_scale(policy->related_cpus, freq,
> >                           arch_scale_freq_ref(policy->cpu));
> >       cpufreq_stats_record_transition(policy, freq);
> > -
> > -     if (trace_cpu_frequency_enabled()) {
> > -             for_each_cpu(cpu, policy->cpus)
> > -                     trace_cpu_frequency(freq, cpu);
> > -     }
> > +     trace_policy_frequency(freq, policy->cpu, policy->cpus);
> >
> >       return freq;
> >   }
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
> > index ec4abe374573..9724b5d19d83 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2297,7 +2297,8 @@ static int hwp_get_cpu_scaling(int cpu)
> >
> >   static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
> >   {
> > -     trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> > +     trace_policy_frequency(pstate * cpu->pstate.scaling, cpu->cpu,
> > +                            cpumask_of(cpu->cpu));
> >       cpu->pstate.current_pstate =3D pstate;
> >       /*
> >        * Generally, there is no guarantee that this code will always ru=
n on
> > @@ -2587,7 +2588,8 @@ static void intel_pstate_adjust_pstate(struct cpu=
data *cpu)
> >
> >       target_pstate =3D get_target_pstate(cpu);
> >       target_pstate =3D intel_pstate_prepare_request(cpu, target_pstate=
);
> > -     trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu=
);
> > +     trace_policy_frequency(target_pstate * cpu->pstate.scaling, cpu->=
cpu,
> > +                            cpumask_of(cpu->cpu));
> >       intel_pstate_update_pstate(cpu, target_pstate);
> >
> >       sample =3D &cpu->sample;
> > diff --git a/include/trace/events/power.h b/include/trace/events/power.=
h
> > index 370f8df2fdb4..317098ffdd5f 100644
> > --- a/include/trace/events/power.h
> > +++ b/include/trace/events/power.h
> > @@ -182,11 +182,29 @@ TRACE_EVENT(pstate_sample,
> >               { PM_EVENT_RECOVER, "recover" }, \
> >               { PM_EVENT_POWEROFF, "poweroff" })
> >
> > -DEFINE_EVENT(cpu, cpu_frequency,
> > +TRACE_EVENT(policy_frequency,
> >
> > -     TP_PROTO(unsigned int frequency, unsigned int cpu_id),
> > +     TP_PROTO(unsigned int frequency, unsigned int cpu_id,
> > +              const struct cpumask *policy_cpus),
> >
> > -     TP_ARGS(frequency, cpu_id)
> > +     TP_ARGS(frequency, cpu_id, policy_cpus),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(u32, state)
> > +             __field(u32, cpu_id)
> > +             __cpumask(cpumask)
>
> Using a cpumask is the most technically correct option here, but it also =
carries a big issue.
> Userspace tooling will have a very hard time doing anything with it. A lo=
t of that is down
> to having no appropriate counterpart in "table libraries" in general (e.g=
. what would you
> map that to in pandas, polars or SQL ?). Some of the lack of support is p=
robably also down to how
> infrequently used it is. For example I don't think Perfetto would be able=
 to handle that
> in the ftrace_event and args table, as the documented supported value typ=
es are:

I've been in touch with the Perfetto team through this process, and it
is an easy update for them to handle. If there are other libraries
using this event, I think their approach would be similar to how
Perfetto's SQL tables handle this new trace event.

> args table:
> value_type      STRING  The type of the value of the arg. Will be one of =
'int', 'uint', 'string', 'real', 'pointer', 'bool' or 'json'.
> https://perfetto.dev/docs/analysis/stdlib-docs

In the same URL as above, there is a 'cpu_frequency_counters' SQL
table documentation. The new tracepoint would be parsed by Perfetto's
C++ parser before being inserted into the aforementioned SQL table as
four separate rows, given a policy with 4 CPUs. This effectively
creates the same table with the same data (just slightly different
timestamps) as prior to this patch.

>
> So while I definitely support improving the situation around cpumasks (I =
lobbied a bit for that),
> I don't think the ecosystem is ready for it yet and having such a core ev=
ent switched to using it
> is going to cause a lot of pain.
>
> Some alternatives for tooling could be:
> 1. Record the policy cpumasks in a tool-friendly format in the trace head=
er, but no current format I know
>     of provides that, and ftrace does not provide a "JSON blob to be pass=
ed through" we could easily append to.
>     Any such addition will therefore require libraries update which will =
take time.
>
> 3. Doing without the data in the trace. That means collecting and bundlin=
g another sidecar file, which
>     is really not convenient and still requires 3rd party tool modificati=
ons for end users.
>
> 2. Add policy_frequency event, but not remove cpu_frequency yet. Possibly=
 with a deprecation warning
>     when enabling the event.
>

These alternatives should work, but I feel are probably too complex to
be worth the effort.

> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->state =3D frequency;
> > +             __entry->cpu_id =3D cpu_id;
> > +             __assign_cpumask(cpumask, policy_cpus);
>
> ipi_send_cpumask uses cpumask_bits():
>
>                 __assign_cpumask(cpumask, cpumask_bits(cpumask));
>
> It's not clear what is best practice, as struct cpumask contains a single=
 member anyway and
> __assign_cpumask() expands to a memcpy() so they are functionally identic=
al.
>
> > +     ),
> > +
> > +     TP_printk("state=3D%lu cpu_id=3D%lu policy_cpus=3D%*pb",
> > +               (unsigned long)__entry->state,
> > +               (unsigned long)__entry->cpu_id,
> > +               cpumask_pr_args((struct cpumask *)__get_dynamic_array(c=
pumask)))
>
> Looking at ipi_send_cpumask, this should be:
>
>    __get_cpumask(cpumask)
>
> The cast and cpumask_pr_args() may look like it's working, but there is o=
nly a very slim
> chance any downstream tool will know what to do with this. Looking at lib=
traceevent
> (which trace-cmd is based on):
>
> ./utest/traceevent-utest.c:116: "print fmt: \"cpumask=3D%s\", __get_cpuma=
sk(cpumask)\n";
> ./src/event-parse.c:3674:       if (strcmp(token, "__get_cpumask") =3D=3D=
 0 ||
> ./src/event-parse.c:7568:               printf("__get_cpumask(%s)", args-=
>bitmask.bitmask);
>
> But there is no match for "cpumask_pr_args".

Thanks for pointing out libtraceevent- I didn't know about this tool,
but I'll take a look at compatibility and adjust appropriately. The
macros are a little tricky, but I agree that it seems best to follow
the template set out by the pre-existing ipi_send_cpumask.

>
> Considering the gap between what works when using the in-kernel text rend=
ering and what can be
> reasonably expected to work in any other userspace tool, it's a good idea=
 to try
> as many as possible unfortunately.
>

Overall, I appreciate the thorough and insightful feedback Douglas! If
there are any other tools consuming cpu_frequency, I can help update
them appropriately. AFAICT Perfetto is by far, the most widespread
tool consuming cpu_frequency.

> >   );
> >
> >   TRACE_EVENT(cpu_frequency_limits,
> > diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
> > index f2fe33573e54..a537e68a6878 100644
> > --- a/kernel/trace/power-traces.c
> > +++ b/kernel/trace/power-traces.c
> > @@ -16,5 +16,5 @@
> >
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
> > -EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_frequency);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(policy_frequency);
> >
> > diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
> > index 7ec7143e2757..f485de0f89b2 100644
> > --- a/samples/bpf/cpustat_kern.c
> > +++ b/samples/bpf/cpustat_kern.c
> > @@ -75,9 +75,9 @@ struct {
> >   } pstate_duration SEC(".maps");
> >
> >   /*
> > - * The trace events for cpu_idle and cpu_frequency are taken from:
> > + * The trace events for cpu_idle and policy_frequency are taken from:
> >    * /sys/kernel/tracing/events/power/cpu_idle/format
> > - * /sys/kernel/tracing/events/power/cpu_frequency/format
> > + * /sys/kernel/tracing/events/power/policy_frequency/format
> >    *
> >    * These two events have same format, so define one common structure.
> >    */
> > @@ -162,7 +162,7 @@ int bpf_prog1(struct cpu_args *ctx)
> >        */
> >       if (ctx->state !=3D (u32)-1) {
> >
> > -             /* record pstate after have first cpu_frequency event */
> > +             /* record pstate after have first policy_frequency event =
*/
> >               if (!*pts)
> >                       return 0;
> >
> > @@ -208,7 +208,7 @@ int bpf_prog1(struct cpu_args *ctx)
> >       return 0;
> >   }
> >
> > -SEC("tracepoint/power/cpu_frequency")
> > +SEC("tracepoint/power/policy_frequency")
> >   int bpf_prog2(struct cpu_args *ctx)
> >   {
> >       u64 *pts, *cstate, *pstate, cur_ts, delta;
> > diff --git a/samples/bpf/cpustat_user.c b/samples/bpf/cpustat_user.c
> > index 356f756cba0d..f7e81f702358 100644
> > --- a/samples/bpf/cpustat_user.c
> > +++ b/samples/bpf/cpustat_user.c
> > @@ -143,12 +143,12 @@ static int cpu_stat_inject_cpu_idle_event(void)
> >
> >   /*
> >    * It's possible to have no any frequency change for long time and ca=
nnot
> > - * get ftrace event 'trace_cpu_frequency' for long period, this introd=
uces
> > + * get ftrace event 'trace_policy_frequency' for long period, this int=
roduces
> >    * big deviation for pstate statistics.
> >    *
> >    * To solve this issue, below code forces to set 'scaling_max_freq' t=
o 208MHz
> > - * for triggering ftrace event 'trace_cpu_frequency' and then recovery=
 back to
> > - * the maximum frequency value 1.2GHz.
> > + * for triggering ftrace event 'trace_policy_frequency' and then recov=
ery back
> > + * to the maximum frequency value 1.2GHz.
> >    */
> >   static int cpu_stat_inject_cpu_frequency_event(void)
> >   {
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timech=
art.c
> > index 22050c640dfa..3ef1a2fd0493 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> > @@ -612,10 +612,10 @@ process_sample_cpu_idle(struct timechart *tchart =
__maybe_unused,
> >   }
> >
> >   static int
> > -process_sample_cpu_frequency(struct timechart *tchart,
> > -                          struct evsel *evsel,
> > -                          struct perf_sample *sample,
> > -                          const char *backtrace __maybe_unused)
> > +process_sample_policy_frequency(struct timechart *tchart,
> > +                             struct evsel *evsel,
> > +                             struct perf_sample *sample,
> > +                             const char *backtrace __maybe_unused)
> >   {
> >       u32 state  =3D evsel__intval(evsel, sample, "state");
> >       u32 cpu_id =3D evsel__intval(evsel, sample, "cpu_id");
> > @@ -1541,7 +1541,7 @@ static int __cmd_timechart(struct timechart *tcha=
rt, const char *output_name)
> >   {
> >       const struct evsel_str_handler power_tracepoints[] =3D {
> >               { "power:cpu_idle",             process_sample_cpu_idle }=
,
> > -             { "power:cpu_frequency",        process_sample_cpu_freque=
ncy },
> > +             { "power:policy_frequency",     process_sample_policy_fre=
quency },
> >               { "sched:sched_wakeup",         process_sample_sched_wake=
up },
> >               { "sched:sched_switch",         process_sample_sched_swit=
ch },
> >   #ifdef SUPPORT_OLD_POWER_EVENTS
> > @@ -1804,7 +1804,7 @@ static int timechart__record(struct timechart *tc=
hart, int argc, const char **ar
> >       unsigned int backtrace_args_no =3D ARRAY_SIZE(backtrace_args);
> >
> >       const char * const power_args[] =3D {
> > -             "-e", "power:cpu_frequency",
> > +             "-e", "power:policy_frequency",
> >               "-e", "power:cpu_idle",
> >       };
> >       unsigned int power_args_nr =3D ARRAY_SIZE(power_args);
>
> --
>
> Douglas
>

