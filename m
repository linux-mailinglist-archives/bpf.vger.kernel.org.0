Return-Path: <bpf+bounces-22242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B4E85A0C8
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0E92815D1
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D1D286AC;
	Mon, 19 Feb 2024 10:17:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D4225628;
	Mon, 19 Feb 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337825; cv=none; b=I3wqNnLTDglI4FO8KcGVPFhmmf1fEFNcPL4GlQLeBvSzPqZmmti+MbS53eF7p3xlfLjWp8SWXyiC+wGH++BK4WPvvBDKK+zIhWZsQZ+Bbe7+XO38zyRVg6ugMxareXHd77VuduPdevOyfAeTfDKskDzZEBZEDrWG7xdw0jrv1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337825; c=relaxed/simple;
	bh=mfeqi+V0Uk81dQGUCG750LmHcTV8G6MdZH+WxBvptxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBTlkS1uReiPtuXvR+bOK0MczWgipnrHCWh6rRmK2v3WikEy3EQFblMl1/wRdV9YBlZVke4K3dBfdqIdX4slxs6Div1vNCfhi+2wyySmDY3mzSG5dP4RrMjwtkrT33v6dcG77tAUEbEA9OhLcy41/1ewZoRC9cSVmENT/gQ4wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B8331007;
	Mon, 19 Feb 2024 02:17:42 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D783F762;
	Mon, 19 Feb 2024 02:16:54 -0800 (PST)
Message-ID: <b8bb3b4c-9774-e4e8-5705-5a6e01f68eb6@arm.com>
Date: Mon, 19 Feb 2024 10:16:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/8] perf arm-spe/cs-etm: Directly iterate CPU maps
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
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
 bpf@vger.kernel.org, Leo Yan <leo.yan@linux.dev>
References: <20240202234057.2085863-1-irogers@google.com>
 <20240202234057.2085863-4-irogers@google.com>
 <CAM9d7chPqFGEih7z7rp=eS5P30gSMvG=6fi=0QqT=EdfdMOH_A@mail.gmail.com>
 <CAP-5=fXzqF--KUOo1awmxDewupF-r_a2=yFC75tuGasNE-WpXg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fXzqF--KUOo1awmxDewupF-r_a2=yFC75tuGasNE-WpXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/02/2024 01:33, Ian Rogers wrote:
> On Fri, Feb 16, 2024 at 5:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Fri, Feb 2, 2024 at 3:41 PM Ian Rogers <irogers@google.com> wrote:
>>>
>>> Rather than iterate all CPUs and see if they are in CPU maps, directly
>>> iterate the CPU map. Similarly make use of the intersect function
>>> taking care for when "any" CPU is specified. Switch
>>> perf_cpu_map__has_any_cpu_or_is_empty to more appropriate
>>> alternatives.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/arch/arm/util/cs-etm.c    | 114 ++++++++++++---------------
>>>  tools/perf/arch/arm64/util/arm-spe.c |   4 +-
>>>  2 files changed, 51 insertions(+), 67 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>>> index 77e6663c1703..07be32d99805 100644
>>> --- a/tools/perf/arch/arm/util/cs-etm.c
>>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>>> @@ -197,38 +197,37 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
>>>  static int cs_etm_validate_config(struct auxtrace_record *itr,
>>>                                   struct evsel *evsel)
>>>  {
>>> -       int i, err = -EINVAL;
>>> +       int idx, err = 0;
>>>         struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
>>> -       struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>>> -
>>> -       /* Set option of each CPU we have */
>>> -       for (i = 0; i < cpu__max_cpu().cpu; i++) {
>>> -               struct perf_cpu cpu = { .cpu = i, };
>>> +       struct perf_cpu_map *intersect_cpus;
>>> +       struct perf_cpu cpu;
>>>
>>> -               /*
>>> -                * In per-cpu case, do the validation for CPUs to work with.
>>> -                * In per-thread case, the CPU map is empty.  Since the traced
>>> -                * program can run on any CPUs in this case, thus don't skip
>>> -                * validation.
>>> -                */
>>> -               if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
>>> -                   !perf_cpu_map__has(event_cpus, cpu))
>>> -                       continue;
>>> +       /*
>>> +        * Set option of each CPU we have. In per-cpu case, do the validation
>>> +        * for CPUs to work with. In per-thread case, the CPU map has the "any"
>>> +        * CPU value. Since the traced program can run on any CPUs in this case,
>>> +        * thus don't skip validation.
>>> +        */
>>> +       if (!perf_cpu_map__has_any_cpu(event_cpus)) {
>>> +               struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>>>
>>> -               if (!perf_cpu_map__has(online_cpus, cpu))
>>> -                       continue;
>>> +               intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
>>> +               perf_cpu_map__put(online_cpus);
>>> +       } else {
>>> +               intersect_cpus = perf_cpu_map__new_online_cpus();
>>> +       }
>>
>> Would it be ok if any of these operations fail?  I believe the
>> cpu map functions work well with NULL already.
> 
> If the allocation fails then the loop below won't iterate (the map
> will be empty). The map is released and not used elsewhere in the
> code. An allocation failure here won't cause the code to crash, but
> there are other places where the code assumes what the properties of
> having done this function are and they won't be working as intended.
> It's not uncommon to see ENOMEM to just be abort for this reason.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Namhyung
>>

Reviewed-by: James Clark <james.clark@arm.com>

About the out of memory case, I don't really have much preference about
that. I doubt much of the code is tested or resiliant to it and the
behaviour is probably already unpredictable.

>>>
>>> -               err = cs_etm_validate_context_id(itr, evsel, i);
>>> +       perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
>>> +               err = cs_etm_validate_context_id(itr, evsel, cpu.cpu);
>>>                 if (err)
>>> -                       goto out;
>>> -               err = cs_etm_validate_timestamp(itr, evsel, i);
>>> +                       break;
>>> +
>>> +               err = cs_etm_validate_timestamp(itr, evsel, cpu.cpu);
>>>                 if (err)
>>> -                       goto out;
>>> +                       break;
>>>         }
>>>
>>> -       err = 0;
>>> -out:
>>> -       perf_cpu_map__put(online_cpus);
>>> +       perf_cpu_map__put(intersect_cpus);
>>>         return err;
>>>  }
>>>
>>> @@ -435,7 +434,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>>          * Also the case of per-cpu mmaps, need the contextID in order to be notified
>>>          * when a context switch happened.
>>>          */
>>> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>>> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>>                 evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>>>                                            "timestamp", 1);
>>>                 evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>>> @@ -461,7 +460,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>>         evsel->core.attr.sample_period = 1;
>>>
>>>         /* In per-cpu case, always need the time of mmap events etc */
>>> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
>>> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
>>>                 evsel__set_sample_bit(evsel, TIME);
>>>
>>>         err = cs_etm_validate_config(itr, cs_etm_evsel);
>>> @@ -533,45 +532,31 @@ static size_t
>>>  cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>>>                       struct evlist *evlist __maybe_unused)
>>>  {
>>> -       int i;
>>> +       int idx;
>>>         int etmv3 = 0, etmv4 = 0, ete = 0;
>>>         struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
>>> -       struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>>> -
>>> -       /* cpu map is not empty, we have specific CPUs to work with */
>>> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
>>> -               for (i = 0; i < cpu__max_cpu().cpu; i++) {
>>> -                       struct perf_cpu cpu = { .cpu = i, };
>>> +       struct perf_cpu_map *intersect_cpus;
>>> +       struct perf_cpu cpu;
>>>
>>> -                       if (!perf_cpu_map__has(event_cpus, cpu) ||
>>> -                           !perf_cpu_map__has(online_cpus, cpu))
>>> -                               continue;
>>> +       if (!perf_cpu_map__has_any_cpu(event_cpus)) {
>>> +               /* cpu map is not "any" CPU , we have specific CPUs to work with */
>>> +               struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>>>
>>> -                       if (cs_etm_is_ete(itr, i))
>>> -                               ete++;
>>> -                       else if (cs_etm_is_etmv4(itr, i))
>>> -                               etmv4++;
>>> -                       else
>>> -                               etmv3++;
>>> -               }
>>> +               intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
>>> +               perf_cpu_map__put(online_cpus);
>>>         } else {
>>> -               /* get configuration for all CPUs in the system */
>>> -               for (i = 0; i < cpu__max_cpu().cpu; i++) {
>>> -                       struct perf_cpu cpu = { .cpu = i, };
>>> -
>>> -                       if (!perf_cpu_map__has(online_cpus, cpu))
>>> -                               continue;
>>> -
>>> -                       if (cs_etm_is_ete(itr, i))
>>> -                               ete++;
>>> -                       else if (cs_etm_is_etmv4(itr, i))
>>> -                               etmv4++;
>>> -                       else
>>> -                               etmv3++;
>>> -               }
>>> +               /* Event can be "any" CPU so count all online CPUs. */
>>> +               intersect_cpus = perf_cpu_map__new_online_cpus();
>>>         }
>>> -
>>> -       perf_cpu_map__put(online_cpus);
>>> +       perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
>>> +               if (cs_etm_is_ete(itr, cpu.cpu))
>>> +                       ete++;
>>> +               else if (cs_etm_is_etmv4(itr, cpu.cpu))
>>> +                       etmv4++;
>>> +               else
>>> +                       etmv3++;
>>> +       }
>>> +       perf_cpu_map__put(intersect_cpus);
>>>
>>>         return (CS_ETM_HEADER_SIZE +
>>>                (ete   * CS_ETE_PRIV_SIZE) +
>>> @@ -813,16 +798,15 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>>>         if (!session->evlist->core.nr_mmaps)
>>>                 return -EINVAL;
>>>
>>> -       /* If the cpu_map is empty all online CPUs are involved */
>>> -       if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
>>> +       /* If the cpu_map has the "any" CPU all online CPUs are involved */
>>> +       if (perf_cpu_map__has_any_cpu(event_cpus)) {
>>>                 cpu_map = online_cpus;
>>>         } else {
>>>                 /* Make sure all specified CPUs are online */
>>> -               for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
>>> -                       struct perf_cpu cpu = { .cpu = i, };
>>> +               struct perf_cpu cpu;
>>>
>>> -                       if (perf_cpu_map__has(event_cpus, cpu) &&
>>> -                           !perf_cpu_map__has(online_cpus, cpu))
>>> +               perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
>>> +                       if (!perf_cpu_map__has(online_cpus, cpu))
>>>                                 return -EINVAL;
>>>                 }
>>>
>>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>>> index 51ccbfd3d246..0b52e67edb3b 100644
>>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>>> @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>>>          * In the case of per-cpu mmaps, sample CPU for AUX event;
>>>          * also enable the timestamp tracing for samples correlation.
>>>          */
>>> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>>> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>>                 evsel__set_sample_bit(arm_spe_evsel, CPU);
>>>                 evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
>>>                                            "ts_enable", 1);
>>> @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>>>         tracking_evsel->core.attr.sample_period = 1;
>>>
>>>         /* In per-cpu case, always need the time of mmap events etc */
>>> -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
>>> +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>>                 evsel__set_sample_bit(tracking_evsel, TIME);
>>>                 evsel__set_sample_bit(tracking_evsel, CPU);
>>>
>>> --
>>> 2.43.0.594.gd9cf4e227d-goog
>>>

