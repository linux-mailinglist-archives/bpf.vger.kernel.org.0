Return-Path: <bpf+bounces-39066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5896E416
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC42A1F236F5
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364741A264D;
	Thu,  5 Sep 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNS5XkJg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40E17741;
	Thu,  5 Sep 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568164; cv=none; b=vCprDgCTJJW2YiuXfdZ1bBH5CTUr3sF06NJKjyNcx2+JvCTwCP2GfDycs4WHoIZmAYUiXgAIIjyknfwcb3NpkmTiXILWRTYqUwPpPJYewcHFKRNdK4BKPnB3sUnLhZ+p5YqEv/TuJpSkvtnYYLYo7D1WxJyT3dlo0jYCYsF8zO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568164; c=relaxed/simple;
	bh=fBBFb9FQi//n2IkrhqHGFBsr3iR4Voh5TgwyMZe14/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeJNxv7m5wJqRQxJvnAB/7wQnNUFgtq4oDoz9isYth+F+fnHphhNHZqIXEpX3SGpoUWZ8r6REuFLj6na6RB9YEAa5e7r+dr3kZkdomuFf9JYaR8tSIYSCMEJC/e1WfACSVWIyD1YhQSzdjHbjF+IxGW2N/26fsOcFxRKIiHG5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNS5XkJg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725568163; x=1757104163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fBBFb9FQi//n2IkrhqHGFBsr3iR4Voh5TgwyMZe14/8=;
  b=XNS5XkJghenRDsy6w2bit1zGki1A/EgMXHDOeOJIiQKdurtqZhSQ1Omd
   nwKCmhtwlsl23L2Zqy7es+spv1U4AfCmVWw6pThvf4+oGR7l3PDfCq6SJ
   eWFaxqOsuvIL7nGJ2PCTmiaKxZqc+ehcp2PAhBW7cFp7VieKuc0P5AyD4
   a/n72lsFGoSkOzZGyJQRb/v0ct2Ljd6IpKy4pCaNOcVtIygXJ8+wzb5Q6
   ARk2OwhppxB1ZzzF+Kgcrji3nyIUFw0tc6jaYEF3VbzE4Ud7pqm7Fci8G
   ++p+GoPpNuPwI1OJjiGLQdjBlwGoC4gMuoAIXTn5yc9vaWRLZHLNRfTdG
   Q==;
X-CSE-ConnectionGUID: yABEtWyYSgOYTNUzd2GZkg==
X-CSE-MsgGUID: 3vjZk1VZTb2z1aKMR7Y50Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24112708"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24112708"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 13:29:22 -0700
X-CSE-ConnectionGUID: sZ7wHTKKSpCe8HpdEieldw==
X-CSE-MsgGUID: re/+xrkUQgqihGklafG6HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65738301"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 13:29:23 -0700
Received: from [10.212.68.73] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E6F6020B5782;
	Thu,  5 Sep 2024 13:29:20 -0700 (PDT)
Message-ID: <e7e0ef26-2335-4e67-984c-705cb33ff4c3@linux.intel.com>
Date: Thu, 5 Sep 2024 16:29:19 -0400
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAEf4Bza9H=nH4+=dDNm55X5LZp4MVSkKyBcnuNq3+8cP6qt=uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-05 4:22 p.m., Andrii Nakryiko wrote:
> On Thu, Sep 5, 2024 at 12:21 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-09-05 2:00 p.m., Andrii Nakryiko wrote:
>>> It's incorrect to assume that LBR can/should only be used with sampling
>>> events. BPF subsystem provides bpf_get_branch_snapshot() BPF helper,
>>> which expects a properly setup and activated perf event which allows
>>> kernel to capture LBR data.
>>>
>>> For instance, retsnoop tool ([0]) makes an extensive use of this
>>> functionality and sets up perf event as follows:
>>>
>>>       struct perf_event_attr attr;
>>>
>>>       memset(&attr, 0, sizeof(attr));
>>>       attr.size = sizeof(attr);
>>>       attr.type = PERF_TYPE_HARDWARE;
>>>       attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>>       attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
>>>       attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL;
>>>
>>> Commit referenced in Fixes tag broke this setup by making invalid assumption
>>> that LBR is useful only for sampling events. Remove that assumption.
>>>
>>> Note, earlier we removed a similar assumption on AMD side of LBR support,
>>> see [1] for details.
>>>
>>>   [0] https://github.com/anakryiko/retsnoop
>>>   [1] 9794563d4d05 ("perf/x86/amd: Don't reject non-sampling events with configured LBR")
>>>
>>> Cc: stable@vger.kernel.org # 6.8+
>>> Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag")
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>  arch/x86/events/intel/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 9e519d8a810a..f82a342b8852 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -3972,7 +3972,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>>                       x86_pmu.pebs_aliases(event);
>>>       }
>>>
>>> -     if (needs_branch_stack(event) && is_sampling_event(event))
>>> +     if (needs_branch_stack(event))
>>>               event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>>
>> To limit the LBR for a sampling event is to avoid unnecessary branch
>> stack setup for a counting event in the sample read. The above change
>> should break the sample read case.
>>
>> How about the below patch (not test)? Is it good enough for the BPF usage?
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 0c9c2706d4ec..8d67cbda916b 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3972,8 +3972,12 @@ static int intel_pmu_hw_config(struct perf_event
>> *event)
>>                 x86_pmu.pebs_aliases(event);
>>         }
>>
>> -       if (needs_branch_stack(event) && is_sampling_event(event))
>> -               event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>> +       if (needs_branch_stack(event)) {
>> +               /* Avoid branch stack setup for counting events in SAMPLE READ */
>> +               if (is_sampling_event(event) ||
>> +                   !(event->attr.sample_type & PERF_SAMPLE_READ))
>> +                       event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>> +       }
>>
> 
> I'm sure it will be fine for my use case, as I set only
> PERF_SAMPLE_BRANCH_STACK.
> 
> But I'll leave it up to perf subsystem experts to decide if this
> condition makes sense, because looking at what PERF_SAMPLE_READ is:
> 
>           PERF_SAMPLE_READ
>                  Record counter values for all events in a group,
>                  not just the group leader.
> 
> It's not clear why this would disable LBR, if specified.

It only disables the counting event with SAMPLE_READ, since LBR is only
read in the sampling event's overflow.

Thanks,
Kan
> 
>>         if (branch_sample_counters(event)) {
>>                 struct perf_event *leader, *sibling;
>>
>>
>> Thanks,
>> Kan
>>>
>>>       if (branch_sample_counters(event)) {

