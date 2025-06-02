Return-Path: <bpf+bounces-59430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220ABACAE53
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AA31890CB2
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689ED21B1AB;
	Mon,  2 Jun 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qlfme/q/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D6214A7C;
	Mon,  2 Jun 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868944; cv=none; b=AkZd3jNFYlW2c8BT9OG3IB0c+RpQ0OJHgIheOXDIgjBDHIrgz+SyNvO9h35kUXaF1Z30KqWVrebPNBC8Ynvx/hZy0Xz6+XW6xF7phyhr4JL0Iib2eNbthI48H1hdxs/eIChJ8G1eXzsR7zKxPVRm9vQR+MaRsUxujspi0zaYE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868944; c=relaxed/simple;
	bh=y9+IaaeJoUBPuK65ygBY5K30uxjC2G0ZhhZUVxyNCyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFZdeNEs8OMWnqsNVJfLIK7rDuO6x+qLN9KBGiZrqHeRzYjzB57iA+DszKnG0mYfwEOdq+qCqXJ7Dw4rrpQCd+K3xhIuhbgz7p99/n1mU3icAp9/8lC7Rv5hLKUlisp6ducnePJh61OsElqvsL2tOZ3SpLDWQqYrQTPta/Fgz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qlfme/q/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748868942; x=1780404942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y9+IaaeJoUBPuK65ygBY5K30uxjC2G0ZhhZUVxyNCyI=;
  b=Qlfme/q/RfUojPyWMg1/6I4lZ8dhB1kcSGzVnh3AJvgynaACTR25FRNE
   dCX+4Ea5KfmgkAIOuVJzV6YMyX7ghHjKqgHZQ2je/mph1ddgNQ9AmKVak
   z1G3d4OBYYNKfXEIEdAmDNiIa4SJebHuM8PffU2jv490XzNPkLmhhphtn
   JfJZ88iwJHBdQEma6hIznwKqJlinYYayOgL6RafYdmEzWhcMyElUYwCL0
   dmDtYENrWGvZf1ZqkZEYUrf/Ltl23Yfjf0BIKTTuj5CaT7Hi9x5+qbimT
   8sPFJ3J9/M4kvchemaTjpLp8rCrMoDnfjQnqe1IAh9MGgDYlLVgz6BM5O
   w==;
X-CSE-ConnectionGUID: V+HzTEA6QROL7FLVVoYaEg==
X-CSE-MsgGUID: MShqi+MERPuOM6zJmQd6pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="49997138"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="49997138"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 05:55:41 -0700
X-CSE-ConnectionGUID: aUnRIk5STJCcfkg+ysGCDA==
X-CSE-MsgGUID: 7zCLPVguQy+0DyRARrnRYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="145474976"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 05:55:41 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7FC9B20B5736;
	Mon,  2 Jun 2025 05:55:39 -0700 (PDT)
Message-ID: <d3c6b899-7281-4f97-a449-96f506181bab@linux.intel.com>
Date: Mon, 2 Jun 2025 08:55:38 -0400
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
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, leo.yan@arm.com, bpf@vger.kernel.org,
 andrii@kernel.org, ihor.solodrai@linux.dev, song@kernel.org, jolsa@kernel.org
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
 <djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexei,

On 2025-06-01 8:30 p.m., Alexei Starovoitov wrote:
> On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The current throttle logic doesn't work well with a group, e.g., the
>> following sampling-read case.
>>
>> $ perf record -e "{cycles,cycles}:S" ...
>>
>> $ perf report -D | grep THROTTLE | tail -2
>>             THROTTLE events:        426  ( 9.0%)
>>           UNTHROTTLE events:        425  ( 9.0%)
>>
>> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
>> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
>> ... sample_read:
>> .... group nr 2
>> ..... id 0000000000000327, value 000000000cbb993a, lost 0
>> ..... id 0000000000000328, value 00000002211c26df, lost 0
>>
>> The second cycles event has a much larger value than the first cycles
>> event in the same group.
>>
>> The current throttle logic in the generic code only logs the THROTTLE
>> event. It relies on the specific driver implementation to disable
>> events. For all ARCHs, the implementation is similar. Only the event is
>> disabled, rather than the group.
>>
>> The logic to disable the group should be generic for all ARCHs. Add the
>> logic in the generic code. The following patch will remove the buggy
>> driver-specific implementation.
>>
>> The throttle only happens when an event is overflowed. Stop the entire
>> group when any event in the group triggers the throttle.
>> The MAX_INTERRUPTS is set to all throttle events.
>>
>> The unthrottled could happen in 3 places.
>> - event/group sched. All events in the group are scheduled one by one.
>>   All of them will be unthrottled eventually. Nothing needs to be
>>   changed.
>> - The perf_adjust_freq_unthr_events for each tick. Needs to restart the
>>   group altogether.
>> - The __perf_event_period(). The whole group needs to be restarted
>>   altogether as well.
>>
>> With the fix,
>> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
>> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
>> ... sample_read:
>> .... group nr 2
>> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
>> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  kernel/events/core.c | 66 ++++++++++++++++++++++++++++++--------------
>>  1 file changed, 46 insertions(+), 20 deletions(-)
> 
> This patch breaks perf hw events somehow.
> 
> After merging this into bpf trees we see random "watchdog: BUG: soft lockup"
> with various stack traces followed up:
> [   78.620749] Sending NMI from CPU 8 to CPUs 0:
> [   76.387722] NMI backtrace for cpu 0
> [   76.387722] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           O L      6.15.0-10818-ge0f0ee1c31de #1163 PREEMPT
> [   76.387722] Tainted: [O]=OOT_MODULE, [L]=SOFTLOCKUP
> [   76.387722] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   76.387722] RIP: 0010:_raw_spin_lock_irqsave+0xc/0x40
> [   76.387722] Call Trace:
> [   76.387722]  <IRQ>
> [   76.387722]  hrtimer_try_to_cancel.part.0+0x24/0xe0
> [   76.387722]  hrtimer_cancel+0x21/0x40
> [   76.387722]  cpu_clock_event_stop+0x64/0x70


The issues should be fixed by the patch.
https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/

Could you please give it a try?

Thanks,
Kan


> [   76.387722]  __perf_event_account_interrupt+0xcf/0x140
> [   76.387722]  __perf_event_overflow+0x36/0x340
> [   76.387722]  ? hrtimer_start_range_ns+0x2c1/0x420
> [   76.387722]  ? kvm_sched_clock_read+0x11/0x20
> [   76.387722]  perf_swevent_hrtimer+0xaf/0x100
> [   76.387722]  ? cpu_clock_event_add+0x6e/0x90
> [   76.387722]  ? event_sched_in+0xc3/0x190
> [   76.387722]  ? update_load_avg+0x87/0x3d0
> [   76.387722]  ? _raw_spin_unlock+0xe/0x20
> [   76.387722]  ? sched_balance_update_blocked_averages+0x59b/0x6a0
> [   76.387722]  ? ctx_sched_in+0x184/0x210
> [   76.387722]  ? kvm_sched_clock_read+0x11/0x20
> [   76.387722]  ? sched_clock_cpu+0x55/0x190
> [   76.387722]  ? perf_exclude_event+0x50/0x50
> [   76.387722]  __hrtimer_run_queues+0x111/0x290
> [   76.387722]  hrtimer_interrupt+0xff/0x240
> [   76.387722]  __sysvec_apic_timer_interrupt+0x4f/0x110
> [   76.387722]  sysvec_apic_timer_interrupt+0x6c/0x90
> 
> After reverting:
> commit e800ac51202f ("perf: Only dump the throttle log for the leader")
> commit 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> everything is back to normal.
> 
> There are many ways to reproduce.
> Any test that sets up perf hw event followed up by tests that IPIs all cpus.
> One way:
> selftests/bpf/test_progs -t stacktrace_build_id_nmi
> selftests/bpf/test_progs -t unpriv_bpf_disabled
> 
> Please take a look.
> 

