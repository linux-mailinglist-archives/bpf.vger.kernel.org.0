Return-Path: <bpf+bounces-37252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66176952A49
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	by am.mirrors.kernel.org (Postfix) with ESMTP id EC0591F21CF7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCBD199234;
	Thu, 15 Aug 2024 08:00:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB54198E78;
	Thu, 15 Aug 2024 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708800; cv=none; b=t01oqhcY9PaZoEHgzLMip+tjTwdkuwpQHEGzhs9EzlK5k8YQhLXr7Gzvhi8Mtq3KWwVCyRv/PUCaVLdGApmNTjWINyqybml23RLciDW/ThTJ02Q0+J3SmuFkGrH4vt2tjcVPmrqsBpcNgh4XmroxOHrmh5J54KbBLGska6G2dLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708800; c=relaxed/simple;
	bh=XwDdYd67nw6O4gN2C/AFvJ5qOri7xBwic0zMAeUdy14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mjZ0rnUeXWAtAFi9SwBge1O6mjqg1VVM10eXvqS9FjFtvW/OKptf8QdigEz8MYnJNsDUpqrE8k/71bV7IfNSFnb7O5QCU9cyuma9WJGPqwF+r1JZJjGseR8NlqdWJvCXUQ0KiO8qWGZ9GMn7qCWwz+BFoLGX1x/tIGRHiWX7CpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WkyFQ1B2Hz1T4GR;
	Thu, 15 Aug 2024 15:59:22 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 11267140159;
	Thu, 15 Aug 2024 15:59:53 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 15 Aug 2024 15:59:51 +0800
Message-ID: <e17cf2d1-e3e0-f549-b04a-664ca2708817@huawei.com>
Date: Thu, 15 Aug 2024 15:59:50 +0800
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
 <85991ce3-674d-b46e-b4f9-88a50f7f5122@huawei.com>
 <CAEf4BzYvpgfFGckcKdzkC_g1J1SFi7xBe=_cjdVy4KEMikvGMw@mail.gmail.com>
 <2c23e9cc-5593-84d0-9157-1e946df941d9@huawei.com>
 <CAEf4BzYSC+OQ0D+B0oEi3uN0kyZ07kPaneLJLJqF=oA6gTXLbg@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYSC+OQ0D+B0oEi3uN0kyZ07kPaneLJLJqF=oA6gTXLbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/15 0:57, Andrii Nakryiko 写道:
> On Tue, Aug 13, 2024 at 9:17 PM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>>
>>
>> 在 2024/8/13 1:49, Andrii Nakryiko 写道:
>>> On Mon, Aug 12, 2024 at 4:11 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> 在 2024/8/9 2:26, Andrii Nakryiko 写道:
>>>>> On Thu, Aug 8, 2024 at 1:45 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>>>>>
>>>>>> Hi Andrii and Oleg.
>>>>>>
>>>>>> This patch sent by me two weeks ago also aim to optimize the performance of uprobe
>>>>>> on arm64. I notice recent discussions on the performance and scalability of uprobes
>>>>>> within the mailing list. Considering this interest, I've added you and other relevant
>>>>>> maintainers to the CC list for broader visibility and potential collaboration.
>>>>>>
>>>>>
>>>>> Hi Liao,
>>>>>
>>>>> As you can see there is an active work to improve uprobes, that
>>>>> changes lifetime management of uprobes, removes a bunch of locks taken
>>>>> in the uprobe/uretprobe hot path, etc. It would be nice if you can
>>>>> hold off a bit with your changes until all that lands. And then
>>>>> re-benchmark, as costs might shift.
>>>>>
>>>>> But also see some remarks below.
>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> 在 2024/7/27 17:44, Liao Chang 写道:
>>>>>>> The profiling result of single-thread model of selftests bench reveals
>>>>>>> performance bottlenecks in find_uprobe() and caches_clean_inval_pou() on
>>>>>>> ARM64. On my local testing machine, 5% of CPU time is consumed by
>>>>>>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() take
>>>>>>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
>>>>>>>
>>>>>>> This patch introduce struct uprobe_breakpoint to track previously
>>>>>>> allocated insn_slot for frequently hit uprobe. it effectively reduce the
>>>>>>> need for redundant insn_slot writes and subsequent expensive cache
>>>>>>> flush, especially on architecture like ARM64. This patch has been tested
>>>>>>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftest
>>>>>>> bench and Redis GET/SET benchmark result below reveal obivious
>>>>>>> performance gain.
>>>>>>>
>>>>>>> before-opt
>>>>>>> ----------
>>>>>>> trig-uprobe-nop:  0.371 ± 0.001M/s (0.371M/prod)
>>>>>>> trig-uprobe-push: 0.370 ± 0.001M/s (0.370M/prod)
>>>>>>> trig-uprobe-ret:  1.637 ± 0.001M/s (1.647M/prod)
>>>>>
>>>>> I'm surprised that nop and push variants are much slower than ret
>>>>> variant. This is exactly opposite on x86-64. Do you have an
>>>>> explanation why this might be happening? I see you are trying to
>>>>> optimize xol_get_insn_slot(), but that is (at least for x86) a slow
>>>>> variant of uprobe that normally shouldn't be used. Typically uprobe is
>>>>> installed on nop (for USDT) and on function entry (which would be push
>>>>> variant, `push %rbp` instruction).
>>>>>
>>>>> ret variant, for x86-64, causes one extra step to go back to user
>>>>> space to execute original instruction out-of-line, and then trapping
>>>>> back to kernel for running uprobe. Which is what you normally want to
>>>>> avoid.
>>>>>
>>>>> What I'm getting at here. It seems like maybe arm arch is missing fast
>>>>> emulated implementations for nops/push or whatever equivalents for
>>>>> ARM64 that is. Please take a look at that and see why those are slow
>>>>> and whether you can make those into fast uprobe cases?
>>>>
>>>> Hi Andrii,
>>>>
>>>> As you correctly pointed out, the benchmark result on Arm64 is counterintuitive
>>>> compared to X86 behavior. My investigation revealed that the root cause lies in
>>>> the arch_uprobe_analyse_insn(), which excludes the Arm64 equvialents instructions
>>>> of 'nop' and 'push' from the emulatable instruction list. This forces the kernel
>>>> to handle these instructions out-of-line in userspace upon breakpoint exception
>>>> is handled, leading to a significant performance overhead compared to 'ret' variant,
>>>> which is already emulated.
>>>>
>>>> To address this issue, I've developed a patch supports  the emulation of 'nop' and
>>>> 'push' variants. The benchmark results below indicates the performance gain of
>>>> emulation is obivious.
>>>>
>>>> xol (1 cpus)
>>>> ------------
>>>> uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
>>>> uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
>>>> uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
>>>> uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
>>>> uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
>>>> uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)
>>>>
>>>> emulation (1 cpus)
>>>> -------------------
>>>> uprobe-nop:  1.862 ± 0.002M/s  (1.862M/s/cpu)
>>>> uprobe-push: 1.743 ± 0.006M/s  (1.743M/s/cpu)
>>>> uprobe-ret:  1.840 ± 0.001M/s  (1.840M/s/cpu)
>>>> uretprobe-nop:  0.964 ± 0.004M/s  (0.964M/s/cpu)
>>>> uretprobe-push: 0.936 ± 0.004M/s  (0.936M/s/cpu)
>>>> uretprobe-ret:  0.940 ± 0.001M/s  (0.940M/s/cpu)
>>>>
>>>> As you can see, the performance gap between nop/push and ret variants has been significantly
>>>> reduced. Due to the emulation of 'push' instruction need to access userspace memory, it spent
>>>> more cycles than the other.
>>>
>>> Great, it's an obvious improvement. Are you going to send patches
>>> upstream? Please cc bpf@vger.kernel.org as well.
>>
>> I'll need more time to thoroughly test this patch. The emulation o push/nop
>> instructions also impacts the kprobe/kretprobe paths on Arm64, As as result,
>> I'm working on enhancements to trig-kprobe/kretprobe to prevent performance
>> regression.
>>
>>>
>>>
>>> I'm also thinking we should update uprobe/uretprobe benchmarks to be
>>> less x86-specific. Right now "-nop" is the happy fastest case, "-push"
>>> is still happy, slightly slower case (due to the need to emulate stack
>>> operation) and "-ret" is meant to be the slow single-step case. We
>>> should adjust the naming and make sure that on ARM64 we hit similar
>>> code paths. Given you seem to know arm64 pretty well, can you please
>>> take a look at updating bench tool for ARM64 (we can also rename
>>> benchmarks to something a bit more generic, rather than using
>>> instruction names)?
>>
>> Let me use a matrix below for the structured comparsion of uprobe/uretprobe
>> benchmarks on X86 and Arm64:
>>
>> Architecture  Instrution Type   Handling method   Performance
>> X86           nop               Emulated          Fastest
>> X86           push              Emulated          Fast
>> X86           ret               Single-step       Slow
>> Arm64         nop               Emulated          Fastest
>> Arm64         push              Emulated          Fast
>> Arm64         ret               Emulated          Faster
>>
>> I suggest categorize benchmarks into 'emu' for emulated instructions and 'ss'
>> for 'single-steppable' instructions. Generally, emulated instructions should
>> outperform single-step ones across different architectures. Regarding the
>> generic naming, I propose using a self-explanatory style, such as
>> s/nop/empty-insn/g, s/push/push-stack/g, s/ret/func-return/g.
>>
>> Above all, example "bench --list" output:
>>
>> X86:
>>   ...
>>   trig-uprobe-emu-empty-insn
>>   trig-uprobe-ss-func-return
>>   trig-uprobe-emu-push-stack
>>   trig-uretprobe-emu-empyt-insn
>>   trig-uretprobe-ss-func-return
>>   trig-uretprobe-emu-push-stack
>>   ...
>>
>> Arm64:
>>   ...
>>   trig-uprobe-emu-empty-insn
>>   trig-uprobe-emu-func-return
>>   trig-uprobe-emu-push-stack
>>   trig-uretprobe-emu-empyt-insn
>>   trig-uretprobe-emu-func-return
>>   trig-uretprobe-emu-push-stack
>>   ...
>>
>> This structure will allow for direct comparison of uprobe/uretprobe
>> performance across different architectures and instruction types.
>> Please let me know your thought, Andrii.
> 
> Tbh, sounds a bit like an overkill. But before we decide on naming,
> what kind of situation is single-stepped on arm64?

On Arm64, the following instruction types are generally not single-steppable.

  - Modifying and reading PC, including 'ret' and various branch instructions.

  - Forming a PC-relative address using the PC and an immediate value.

  - Generating exception, includes BRK, HLT, HVC, SMC, SVC.

  - Loading memory at address calculated based on the PC and an immediate offset.

  - Moving general-purpose register to system registers of PE (similar to logical cores on x86).

  - Hint instruction cause exception or unintend behavior for single-stepping.
    However, 'nop' is steppable hint.

Most parts of instructions that doesn't fall into any of these types are single-stepped,
including the Arm64 equvialents of 'push'.

Thanks.

> 
>>
>> Thanks.
>>
>>>
>>>>
>>>>>
>>>>>>> trig-uretprobe-nop:  0.331 ± 0.004M/s (0.331M/prod)
>>>>>>> trig-uretprobe-push: 0.333 ± 0.000M/s (0.333M/prod)
>>>>>>> trig-uretprobe-ret:  0.854 ± 0.002M/s (0.854M/prod)
>>>>>>> Redis SET (RPS) uprobe: 42728.52
>>>>>>> Redis GET (RPS) uprobe: 43640.18
>>>>>>> Redis SET (RPS) uretprobe: 40624.54
>>>>>>> Redis GET (RPS) uretprobe: 41180.56
>>>>>>>
>>>>>>> after-opt
>>>>>>> ---------
>>>>>>> trig-uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
>>>>>>> trig-uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
>>>>>>> trig-uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
>>>>>>> trig-uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
>>>>>>> trig-uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
>>>>>>> trig-uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)
>>>>>>> Redis SET (RPS) uprobe: 43939.69
>>>>>>> Redis GET (RPS) uprobe: 45200.80
>>>>>>> Redis SET (RPS) uretprobe: 41658.58
>>>>>>> Redis GET (RPS) uretprobe: 42805.80
>>>>>>>
>>>>>>> While some uprobes might still need to share the same insn_slot, this
>>>>>>> patch compare the instructions in the resued insn_slot with the
>>>>>>> instructions execute out-of-line firstly to decides allocate a new one
>>>>>>> or not.
>>>>>>>
>>>>>>> Additionally, this patch use a rbtree associated with each thread that
>>>>>>> hit uprobes to manage these allocated uprobe_breakpoint data. Due to the
>>>>>>> rbtree of uprobe_breakpoints has smaller node, better locality and less
>>>>>>> contention, it result in faster lookup times compared to find_uprobe().
>>>>>>>
>>>>>>> The other part of this patch are some necessary memory management for
>>>>>>> uprobe_breakpoint data. A uprobe_breakpoint is allocated for each newly
>>>>>>> hit uprobe that doesn't already have a corresponding node in rbtree. All
>>>>>>> uprobe_breakpoints will be freed when thread exit.
>>>>>>>
>>>>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>>>>> ---
>>>>>>>  include/linux/uprobes.h |   3 +
>>>>>>>  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++-------
>>>>>>>  2 files changed, 211 insertions(+), 38 deletions(-)
>>>>>>>
>>>>>
>>>>> [...]
>>>>
>>>> --
>>>> BR
>>>> Liao, Chang
>>
>> --
>> BR
>> Liao, Chang

-- 
BR
Liao, Chang

