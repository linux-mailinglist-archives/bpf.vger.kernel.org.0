Return-Path: <bpf+bounces-9757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2958B79D41F
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AEC281BFC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13C18B08;
	Tue, 12 Sep 2023 14:55:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2218036
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 14:55:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082B115;
	Tue, 12 Sep 2023 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694530506; x=1726066506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+08KNNthxi3J1Jr0M7Xfm3cEncr3LYOQUYNu2NOJbqg=;
  b=YsKcXtx/zECe20wJ2s/1js8SmhHVGXRZ1OGE12a+Qxot2Pfr1K1x3qLr
   lNvW9SbyyVPeM2uWCSzUaywqL7L02I5b0WuzX1l/Km7Eswy6oob4w6LNh
   GXobuKPtkDieCuh2kXx2SLHaNWWJin07runAY0y0byfCk3IXFvuolVn6f
   x/02v9S2ARxpDQA+YJyGYA5xROOFxVLCK6TG1pRbIx0BEekH7F6uhjR3d
   YT/7q0t1XkG2APrgNyHgE3e7mr08G4DFeisfzCV5pZ8dM39JKNJjrk6xp
   GBSKOhj/7FymEwpZy61LSYeq+dJv+TFjIS8tTbsZVswKF/BpdLIKfDEJ8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381099274"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381099274"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 07:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074576894"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074576894"
Received: from srosalim-mobl1.ger.corp.intel.com (HELO [10.251.217.51]) ([10.251.217.51])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 07:55:01 -0700
Message-ID: <d248ec69-9bde-d57d-5175-a413c6c94f5c@linux.intel.com>
Date: Tue, 12 Sep 2023 17:54:59 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH 2/2] perf/core: Allow reading package events from
 perf_event_read_local
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, irogers@google.com, mark.rutland@arm.com,
 linux-perf-users@vger.kernel.org, hpa@zytor.com, mingo@redhat.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
 alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
 namhyung@kernel.org, jolsa@kernel.org
References: <20230912124432.3616761-1-tero.kristo@linux.intel.com>
 <20230912124432.3616761-3-tero.kristo@linux.intel.com>
 <20230912140434.GB22127@noisy.programming.kicks-ass.net>
From: Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <20230912140434.GB22127@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/09/2023 17:04, Peter Zijlstra wrote:
> On Tue, Sep 12, 2023 at 03:44:32PM +0300, Tero Kristo wrote:
>> Per-package perf events are typically registered with a single CPU only,
>> however they can be read across all the CPUs within the package.
>> Currently perf_event_read maps the event CPU according to the topology
>> information to avoid an unnecessary SMP call, however
>> perf_event_read_local deals with hard values and rejects a read with a
>> failure if the CPU is not the one exactly registered. Allow similar
>> mapping within the perf_event_read_local if the perf event in question
>> can support this.
>>
>> This allows users like BPF code to read the package perf events properly
>> across different CPUs within a package.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   kernel/events/core.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4c72a41f11af..780dde646e8a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4528,6 +4528,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>>   {
>>   	unsigned long flags;
>>   	int ret = 0;
>> +	int event_cpu;
>>   
>>   	/*
>>   	 * Disabling interrupts avoids all counter scheduling (context
>> @@ -4551,15 +4552,18 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>>   		goto out;
>>   	}
>>   
>> +	event_cpu = READ_ONCE(event->oncpu);
>> +	event_cpu = __perf_event_read_cpu(event, event_cpu);
> What happens with __perf_event_read_cpu() when event_cpu == -1 ?

Good question. It looks like I need to add a check against that. Will 
update and send v2 out.

-Tero


>
>> +
>>   	/* If this is a per-CPU event, it must be for this CPU */
>>   	if (!(event->attach_state & PERF_ATTACH_TASK) &&
>> -	    event->cpu != smp_processor_id()) {
>> +	    event_cpu != smp_processor_id()) {
>>   		ret = -EINVAL;
>>   		goto out;
>>   	}
>>   
>>   	/* If this is a pinned event it must be running on this CPU */
>> -	if (event->attr.pinned && event->oncpu != smp_processor_id()) {
>> +	if (event->attr.pinned && event_cpu != smp_processor_id()) {
>>   		ret = -EBUSY;
>>   		goto out;
>>   	}
>> @@ -4569,7 +4573,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>>   	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
>>   	 * oncpu == -1).
>>   	 */
>> -	if (event->oncpu == smp_processor_id())
>> +	if (event_cpu == smp_processor_id())
>>   		event->pmu->read(event);
>>   
>>   	*value = local64_read(&event->count);
>> -- 
>> 2.40.1
>>

