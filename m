Return-Path: <bpf+bounces-39327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721D971E98
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 18:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DEB1F22AF2
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76437137764;
	Mon,  9 Sep 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3DFai8N"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0672374C;
	Mon,  9 Sep 2024 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897733; cv=none; b=NyDrY4a0p9+FwGoWm6MTupKrNc05BIAjaCnQts5L7IbUJUUf6VT4FS4J7xSOfpeOso+RsXDJ5SinVr0/8bTAkjQA6LD6vzCIL8/1fmgrOBQxVq8hxSKoKcHCWfxvLooXXSeuMMG45QuuD3zFCv/tMKDaC8v7KK5HokSFYZ9eygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897733; c=relaxed/simple;
	bh=KKDt/4lx2HO72S+NqAJeZLFcyRm3P3ZwFdxC6THERhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0zFMLVOq6Nd0zlplIOY4k8dczw8vz3fn44sdUZA7npvveg0S/wE/z7l3rvd9kxVQYOmhUgf3+mp5G6G1pG0pkPhltkcnYj0LcuboqZwAXSTq1oLVYzt/pOAyyAu5LNG3cLMS3GOM9e55v94eniXq3TyjC7nMplWiGuP1MNRHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3DFai8N; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725897731; x=1757433731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KKDt/4lx2HO72S+NqAJeZLFcyRm3P3ZwFdxC6THERhs=;
  b=I3DFai8NVIQhUvBpLQjQGu0CXGfL2i+NrA6kaDzeP1qerWyHPrdSHKF2
   zIJRPIHwgjejz/0k68zoALCCYXRyx3pbdpTWYnNIqeFXeVnHSYtCWwq8q
   eWhIQO+JZMiyMxuqHxMm+y2x2Y8keR8dhZuSpC66ZaltSFYGoyKI1Mjs5
   9slwaxMZhzX1L43fqEUxEy4IpQ5L2OFv1QRK/OPvEirD4rf7sdtHOji56
   GR/yTvqnx+8YlAWUtsgLdad1TY5ZYr7C//OFFSDUGIbpp3U4bUpxaOJU8
   cN3sK5Mroy5fAzRU6wKHXwDE1neMpKilZn2jPXIndX1H4Naz6o58DLgqY
   A==;
X-CSE-ConnectionGUID: WrhNYfsnTAqlL5DV/Mn4aQ==
X-CSE-MsgGUID: EW5BEODeTK6k86Xh8yEeZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35949373"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="35949373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 09:02:11 -0700
X-CSE-ConnectionGUID: nb8wUGgtQICX5rP5J5UD7Q==
X-CSE-MsgGUID: jNy+FW2zRP24JE8Lhht7NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="71320223"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 09:02:10 -0700
Received: from [10.212.55.50] (kliang2-mobl1.ccr.corp.intel.com [10.212.55.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id AAF6E20CFEDB;
	Mon,  9 Sep 2024 09:02:08 -0700 (PDT)
Message-ID: <b0f93820-0d3b-4fe2-9ad5-f33640f3a4a8@linux.intel.com>
Date: Mon, 9 Sep 2024 12:02:07 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: fix wrong assumption that LBR is only useful
 for sampling events
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org,
 peterz@infradead.org, x86@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, acme@kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20240905180055.1221620-1-andrii@kernel.org>
 <ddfd906c-83cc-490a-a4bb-4fa43793d882@linux.intel.com>
 <CAEf4Bza9H=nH4+=dDNm55X5LZp4MVSkKyBcnuNq3+8cP6qt=uQ@mail.gmail.com>
 <e7e0ef26-2335-4e67-984c-705cb33ff4c3@linux.intel.com>
 <CAEf4BzYOxpLAowE=4A=qUreLkgKBkDYbOxnidbnQNKQdLx7=WQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAEf4BzYOxpLAowE=4A=qUreLkgKBkDYbOxnidbnQNKQdLx7=WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-05 4:33 p.m., Andrii Nakryiko wrote:
> On Thu, Sep 5, 2024 at 1:29 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-09-05 4:22 p.m., Andrii Nakryiko wrote:
>>> On Thu, Sep 5, 2024 at 12:21 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-09-05 2:00 p.m., Andrii Nakryiko wrote:
>>>>> It's incorrect to assume that LBR can/should only be used with sampling
>>>>> events. BPF subsystem provides bpf_get_branch_snapshot() BPF helper,
>>>>> which expects a properly setup and activated perf event which allows
>>>>> kernel to capture LBR data.
>>>>>
>>>>> For instance, retsnoop tool ([0]) makes an extensive use of this
>>>>> functionality and sets up perf event as follows:
>>>>>
>>>>>       struct perf_event_attr attr;
>>>>>
>>>>>       memset(&attr, 0, sizeof(attr));
>>>>>       attr.size = sizeof(attr);
>>>>>       attr.type = PERF_TYPE_HARDWARE;
>>>>>       attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>>>>       attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
>>>>>       attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL;
>>>>>
>>>>> Commit referenced in Fixes tag broke this setup by making invalid assumption
>>>>> that LBR is useful only for sampling events. Remove that assumption.
>>>>>
>>>>> Note, earlier we removed a similar assumption on AMD side of LBR support,
>>>>> see [1] for details.
>>>>>
>>>>>   [0] https://github.com/anakryiko/retsnoop
>>>>>   [1] 9794563d4d05 ("perf/x86/amd: Don't reject non-sampling events with configured LBR")
>>>>>
>>>>> Cc: stable@vger.kernel.org # 6.8+
>>>>> Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag")
>>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>>> ---
>>>>>  arch/x86/events/intel/core.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>>> index 9e519d8a810a..f82a342b8852 100644
>>>>> --- a/arch/x86/events/intel/core.c
>>>>> +++ b/arch/x86/events/intel/core.c
>>>>> @@ -3972,7 +3972,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>>>>                       x86_pmu.pebs_aliases(event);
>>>>>       }
>>>>>
>>>>> -     if (needs_branch_stack(event) && is_sampling_event(event))
>>>>> +     if (needs_branch_stack(event))
>>>>>               event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>>
>>>> To limit the LBR for a sampling event is to avoid unnecessary branch
>>>> stack setup for a counting event in the sample read. The above change
>>>> should break the sample read case.
>>>>
>>>> How about the below patch (not test)? Is it good enough for the BPF usage?
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 0c9c2706d4ec..8d67cbda916b 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -3972,8 +3972,12 @@ static int intel_pmu_hw_config(struct perf_event
>>>> *event)
>>>>                 x86_pmu.pebs_aliases(event);
>>>>         }
>>>>
>>>> -       if (needs_branch_stack(event) && is_sampling_event(event))
>>>> -               event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>> +       if (needs_branch_stack(event)) {
>>>> +               /* Avoid branch stack setup for counting events in SAMPLE READ */
>>>> +               if (is_sampling_event(event) ||
>>>> +                   !(event->attr.sample_type & PERF_SAMPLE_READ))
>>>> +                       event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>>> +       }
>>>>
>>>
>>> I'm sure it will be fine for my use case, as I set only
>>> PERF_SAMPLE_BRANCH_STACK.
>>>
>>> But I'll leave it up to perf subsystem experts to decide if this
>>> condition makes sense, because looking at what PERF_SAMPLE_READ is:
>>>
>>>           PERF_SAMPLE_READ
>>>                  Record counter values for all events in a group,
>>>                  not just the group leader.
>>>
>>> It's not clear why this would disable LBR, if specified.
>>
>> It only disables the counting event with SAMPLE_READ, since LBR is only
>> read in the sampling event's overflow.
>>
> 
> Ok, sounds good! Would you like to send a proper patch with your
> proposed changes?

The patch has been posted. Please give it a try.
https://lore.kernel.org/lkml/20240909155848.326640-1-kan.liang@linux.intel.com/

Thanks,
Kan
> 
>> Thanks,
>> Kan
>>>
>>>>         if (branch_sample_counters(event)) {
>>>>                 struct perf_event *leader, *sibling;
>>>>
>>>>
>>>> Thanks,
>>>> Kan
>>>>>
>>>>>       if (branch_sample_counters(event)) {
> 

