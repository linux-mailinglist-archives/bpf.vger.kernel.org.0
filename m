Return-Path: <bpf+bounces-59445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B79ACBA7C
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 19:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE73B9A05
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A50D227BA4;
	Mon,  2 Jun 2025 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7NeZj9F"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95830226D00;
	Mon,  2 Jun 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886721; cv=none; b=r4o5ha5DqlICuqf/O/Nwf/Q72dlopuFaPDIZfv6Q65qJJbZIza9F5uSSnDFUMN8H2Qo4HYN2y0QSOrswSuQVRYaOABwLhrsqMTFGabw2yn3IZXTir0U+9UBhu0eD8HKupim4aNiofP6jZlE/68L3AvxEuh8o6V2gtuSAdqRrnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886721; c=relaxed/simple;
	bh=6WvDGzwZG+cRZJ5KBAUMkQEEpLf/3z2Bm34cSwbwChY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxJE9ElSj7lNTik/ahwRSq/96rvPXjHMTF2o1xalcLxQxw+PnBxauXVde8B4zsDWMzn7wrcQ4qV0lrjJhtP/cOOtN2JBLwBwbn1mKkrCB1EfOxCMMokO8Ku4gU5rCHuNg+ZV/WX6f/+LhD0x+vRmPrjkmd8MD7ovF2JUqV6RaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7NeZj9F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748886720; x=1780422720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6WvDGzwZG+cRZJ5KBAUMkQEEpLf/3z2Bm34cSwbwChY=;
  b=C7NeZj9FFHm2YlGwBgl++C/QUmODl7NDA/zwtmiIp4CkLVDEnX90XD4w
   GbQwM2exsa9Nbt1G/lZ5FMgICXUWyi6jwyKR2ByxtU8ydeIdJTGaWd4AO
   zFVGj6J5ZwSDezWsj8u+7vQUpEZ9ne7EfQ8ObvyF567o0Q+N07ZUu69zL
   42BRkNQOmnE8Tq3aiq7vYFBcVgwHJV36jExL6T6EoxoTNBjhdLhQaCslF
   5RBsdhqDRnqOXFiUOI7XWwn3im0iEVZDM9yWh7Tm++paQrvuDg2edelBX
   A1Vj1IuV2368Zt5iNpaRdg43iPZMBMIrSkaJdh4VFe5WOZy70cHAHwfhM
   g==;
X-CSE-ConnectionGUID: sPzA7/43Q0uVkwBUpGTN4g==
X-CSE-MsgGUID: pFnkIYWfSuixMBU1bNMm/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="54568997"
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="54568997"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 10:51:58 -0700
X-CSE-ConnectionGUID: d1FV0lH1R9OtU8oLuAwSOA==
X-CSE-MsgGUID: FMZUZhQnRfOlhB7EMXUhqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="144564349"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 10:51:58 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 48E6820B5736;
	Mon,  2 Jun 2025 10:51:56 -0700 (PDT)
Message-ID: <fb64520f-3890-4cdf-9c12-73d6b8de584b@linux.intel.com>
Date: Mon, 2 Jun 2025 13:51:55 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf regression. Was: [PATCH V4 01/16] perf: Fix the throttle
 logic for a group
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 Stephane Eranian <eranian@google.com>, Chun-Tse Shao <ctshao@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Leo Yan <leo.yan@arm.com>,
 bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
 <djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw>
 <d3c6b899-7281-4f97-a449-96f506181bab@linux.intel.com>
 <CAADnVQL_v4SscxVK5fLxKo5Z4+LJtVfpvrJ4+ztu-ecPfxwrhQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAADnVQL_v4SscxVK5fLxKo5Z4+LJtVfpvrJ4+ztu-ecPfxwrhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-06-02 12:24 p.m., Alexei Starovoitov wrote:
> On Mon, Jun 2, 2025 at 5:55 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> Hi Alexei,
>>
>> On 2025-06-01 8:30 p.m., Alexei Starovoitov wrote:
>>> On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The current throttle logic doesn't work well with a group, e.g., the
>>>> following sampling-read case.
>>>>
>>>> $ perf record -e "{cycles,cycles}:S" ...
>>>>
>>>> $ perf report -D | grep THROTTLE | tail -2
>>>>             THROTTLE events:        426  ( 9.0%)
>>>>           UNTHROTTLE events:        425  ( 9.0%)
>>>>
>>>> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
>>>> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
>>>> ... sample_read:
>>>> .... group nr 2
>>>> ..... id 0000000000000327, value 000000000cbb993a, lost 0
>>>> ..... id 0000000000000328, value 00000002211c26df, lost 0
>>>>
>>>> The second cycles event has a much larger value than the first cycles
>>>> event in the same group.
>>>>
>>>> The current throttle logic in the generic code only logs the THROTTLE
>>>> event. It relies on the specific driver implementation to disable
>>>> events. For all ARCHs, the implementation is similar. Only the event is
>>>> disabled, rather than the group.
>>>>
>>>> The logic to disable the group should be generic for all ARCHs. Add the
>>>> logic in the generic code. The following patch will remove the buggy
>>>> driver-specific implementation.
>>>>
>>>> The throttle only happens when an event is overflowed. Stop the entire
>>>> group when any event in the group triggers the throttle.
>>>> The MAX_INTERRUPTS is set to all throttle events.
>>>>
>>>> The unthrottled could happen in 3 places.
>>>> - event/group sched. All events in the group are scheduled one by one.
>>>>   All of them will be unthrottled eventually. Nothing needs to be
>>>>   changed.
>>>> - The perf_adjust_freq_unthr_events for each tick. Needs to restart the
>>>>   group altogether.
>>>> - The __perf_event_period(). The whole group needs to be restarted
>>>>   altogether as well.
>>>>
>>>> With the fix,
>>>> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
>>>> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
>>>> ... sample_read:
>>>> .... group nr 2
>>>> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
>>>> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
>>>>
>>>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>> ---
>>>>  kernel/events/core.c | 66 ++++++++++++++++++++++++++++++--------------
>>>>  1 file changed, 46 insertions(+), 20 deletions(-)
>>>
>>> This patch breaks perf hw events somehow.
>>>
>>> After merging this into bpf trees we see random "watchdog: BUG: soft lockup"
>>> with various stack traces followed up:
>>> [   78.620749] Sending NMI from CPU 8 to CPUs 0:
>>> [   76.387722] NMI backtrace for cpu 0
>>> [   76.387722] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O L      6.15.0-10818-ge0f0ee1c31de #1163 PREEMPT
>>> [   76.387722] Tainted: [O]=OOT_MODULE, [L]=SOFTLOCKUP
>>> [   76.387722] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>> [   76.387722] RIP: 0010:_raw_spin_lock_irqsave+0xc/0x40
>>> [   76.387722] Call Trace:
>>> [   76.387722]  <IRQ>
>>> [   76.387722]  hrtimer_try_to_cancel.part.0+0x24/0xe0
>>> [   76.387722]  hrtimer_cancel+0x21/0x40
>>> [   76.387722]  cpu_clock_event_stop+0x64/0x70
>>
>>
>> The issues should be fixed by the patch.
>> https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>>
>> Could you please give it a try?
> 
> Thanks. It fixes it, but the commit log says that
> only cpu-clock and task_clock are affected,
> which are SW events.

Yes, only the two SW events are affected.

> 
> While our tests are locking while setting up:
> 
>         struct perf_event_attr attr = {
>                 .freq = 1,
>                 .type = PERF_TYPE_HARDWARE,
>                 .config = PERF_COUNT_HW_CPU_CYCLES,
>         };
> 
> Is it because we run in x86 VM and HW_CPU_CYCLES is mapped
> to cpu-clock sw ?

No, that's from different PMU. We never map HW_CPU_CYCLES to a SW event.
It will error our if the PMU is not available.

I'm not familiar with your test case and env. At least, I saw
PERF_COUNT_SW_CPU_CLOCK is used in the case unpriv_bpf_disabled.

Thanks,
Kan


