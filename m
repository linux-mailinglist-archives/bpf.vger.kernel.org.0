Return-Path: <bpf+bounces-36882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF394EB98
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69A71C20F96
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E677171E7C;
	Mon, 12 Aug 2024 11:11:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9016F907;
	Mon, 12 Aug 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461112; cv=none; b=ox0GGKZaoZpgYWkSE0tdpqJ6Zqlco4VLs9vJsj+1HtsV8A6hqwK6QDKWepjHcgMXcHb4EwKEp6XjMVZXL/znSGrCVJF2XqVDN4ZTtqnfza1bVRTzUADFZnXyFc/t4JZ1e1k2qUVUgxfhwdLbJH8lrqpiLnYA2jW6u6QFqQIchXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461112; c=relaxed/simple;
	bh=UBV1iGhqSk+MzMClMnpysA7/BT26iWrkRlslDlGQg4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nH54xFBKT8+EM1vP7Z5f/y6YctoWclgv6ghA13Ze+024D+KnV6TgXoHE0DQmHPQ+HO4ROe4ewRysYtIy9JaM7Qa53VvateTqoZA9xLR+Fy1F+L75rCL15hgZW1ui2Rd9NQ6S6242cne9HOIeT/qNzhDFFfhWrJhNW77wrrAR3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WjBfD12QwzyPH1;
	Mon, 12 Aug 2024 19:11:16 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 87D821800A6;
	Mon, 12 Aug 2024 19:11:43 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 12 Aug 2024 19:11:41 +0800
Message-ID: <85991ce3-674d-b46e-b4f9-88a50f7f5122@huawei.com>
Date: Mon, 12 Aug 2024 19:11:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] uprobes: Optimize the allocation of insn_slot for
 performance
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	"oleg@redhat.com >> Oleg Nesterov" <oleg@redhat.com>, Andrii Nakryiko
	<andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com>
 <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/9 2:26, Andrii Nakryiko 写道:
> On Thu, Aug 8, 2024 at 1:45 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>> Hi Andrii and Oleg.
>>
>> This patch sent by me two weeks ago also aim to optimize the performance of uprobe
>> on arm64. I notice recent discussions on the performance and scalability of uprobes
>> within the mailing list. Considering this interest, I've added you and other relevant
>> maintainers to the CC list for broader visibility and potential collaboration.
>>
> 
> Hi Liao,
> 
> As you can see there is an active work to improve uprobes, that
> changes lifetime management of uprobes, removes a bunch of locks taken
> in the uprobe/uretprobe hot path, etc. It would be nice if you can
> hold off a bit with your changes until all that lands. And then
> re-benchmark, as costs might shift.
> 
> But also see some remarks below.
> 
>> Thanks.
>>
>> 在 2024/7/27 17:44, Liao Chang 写道:
>>> The profiling result of single-thread model of selftests bench reveals
>>> performance bottlenecks in find_uprobe() and caches_clean_inval_pou() on
>>> ARM64. On my local testing machine, 5% of CPU time is consumed by
>>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() take
>>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
>>>
>>> This patch introduce struct uprobe_breakpoint to track previously
>>> allocated insn_slot for frequently hit uprobe. it effectively reduce the
>>> need for redundant insn_slot writes and subsequent expensive cache
>>> flush, especially on architecture like ARM64. This patch has been tested
>>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftest
>>> bench and Redis GET/SET benchmark result below reveal obivious
>>> performance gain.
>>>
>>> before-opt
>>> ----------
>>> trig-uprobe-nop:  0.371 ± 0.001M/s (0.371M/prod)
>>> trig-uprobe-push: 0.370 ± 0.001M/s (0.370M/prod)
>>> trig-uprobe-ret:  1.637 ± 0.001M/s (1.647M/prod)
> 
> I'm surprised that nop and push variants are much slower than ret
> variant. This is exactly opposite on x86-64. Do you have an
> explanation why this might be happening? I see you are trying to
> optimize xol_get_insn_slot(), but that is (at least for x86) a slow
> variant of uprobe that normally shouldn't be used. Typically uprobe is
> installed on nop (for USDT) and on function entry (which would be push
> variant, `push %rbp` instruction).
> 
> ret variant, for x86-64, causes one extra step to go back to user
> space to execute original instruction out-of-line, and then trapping
> back to kernel for running uprobe. Which is what you normally want to
> avoid.
> 
> What I'm getting at here. It seems like maybe arm arch is missing fast
> emulated implementations for nops/push or whatever equivalents for
> ARM64 that is. Please take a look at that and see why those are slow
> and whether you can make those into fast uprobe cases?

Hi Andrii,

As you correctly pointed out, the benchmark result on Arm64 is counterintuitive
compared to X86 behavior. My investigation revealed that the root cause lies in
the arch_uprobe_analyse_insn(), which excludes the Arm64 equvialents instructions
of 'nop' and 'push' from the emulatable instruction list. This forces the kernel
to handle these instructions out-of-line in userspace upon breakpoint exception
is handled, leading to a significant performance overhead compared to 'ret' variant,
which is already emulated.

To address this issue, I've developed a patch supports  the emulation of 'nop' and
'push' variants. The benchmark results below indicates the performance gain of
emulation is obivious.

xol (1 cpus)
------------
uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)

emulation (1 cpus)
-------------------
uprobe-nop:  1.862 ± 0.002M/s  (1.862M/s/cpu)
uprobe-push: 1.743 ± 0.006M/s  (1.743M/s/cpu)
uprobe-ret:  1.840 ± 0.001M/s  (1.840M/s/cpu)
uretprobe-nop:  0.964 ± 0.004M/s  (0.964M/s/cpu)
uretprobe-push: 0.936 ± 0.004M/s  (0.936M/s/cpu)
uretprobe-ret:  0.940 ± 0.001M/s  (0.940M/s/cpu)

As you can see, the performance gap between nop/push and ret variants has been significantly
reduced. Due to the emulation of 'push' instruction need to access userspace memory, it spent
more cycles than the other.

> 
>>> trig-uretprobe-nop:  0.331 ± 0.004M/s (0.331M/prod)
>>> trig-uretprobe-push: 0.333 ± 0.000M/s (0.333M/prod)
>>> trig-uretprobe-ret:  0.854 ± 0.002M/s (0.854M/prod)
>>> Redis SET (RPS) uprobe: 42728.52
>>> Redis GET (RPS) uprobe: 43640.18
>>> Redis SET (RPS) uretprobe: 40624.54
>>> Redis GET (RPS) uretprobe: 41180.56
>>>
>>> after-opt
>>> ---------
>>> trig-uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
>>> trig-uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
>>> trig-uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
>>> trig-uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
>>> trig-uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
>>> trig-uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)
>>> Redis SET (RPS) uprobe: 43939.69
>>> Redis GET (RPS) uprobe: 45200.80
>>> Redis SET (RPS) uretprobe: 41658.58
>>> Redis GET (RPS) uretprobe: 42805.80
>>>
>>> While some uprobes might still need to share the same insn_slot, this
>>> patch compare the instructions in the resued insn_slot with the
>>> instructions execute out-of-line firstly to decides allocate a new one
>>> or not.
>>>
>>> Additionally, this patch use a rbtree associated with each thread that
>>> hit uprobes to manage these allocated uprobe_breakpoint data. Due to the
>>> rbtree of uprobe_breakpoints has smaller node, better locality and less
>>> contention, it result in faster lookup times compared to find_uprobe().
>>>
>>> The other part of this patch are some necessary memory management for
>>> uprobe_breakpoint data. A uprobe_breakpoint is allocated for each newly
>>> hit uprobe that doesn't already have a corresponding node in rbtree. All
>>> uprobe_breakpoints will be freed when thread exit.
>>>
>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>> ---
>>>  include/linux/uprobes.h |   3 +
>>>  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++-------
>>>  2 files changed, 211 insertions(+), 38 deletions(-)
>>>
> 
> [...]

-- 
BR
Liao, Chang

