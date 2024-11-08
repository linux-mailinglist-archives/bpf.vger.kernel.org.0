Return-Path: <bpf+bounces-44320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988AE9C147B
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 04:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC54BB21AA9
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 03:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6912C499;
	Fri,  8 Nov 2024 03:13:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59823AD;
	Fri,  8 Nov 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035634; cv=none; b=nElB6WGEU2SbGSM1J0G48J/MQMtQJsxE3EUYAW81uFYEwcI4wsTv75FwSQgGF68p2+6pnkPV0HM5gM11hbNfAgwsdLwP9fijOEyH9M7TMgpowWS++0F3OHZ3+ftJQv41P0coLHuPSl6ZKMDcenNNU1Acn5vxIC6Ugdugi7tXH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035634; c=relaxed/simple;
	bh=fzAC7+BpEThNWmuUbUbLYUFyzQqXhk8ySkQbpH62mzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SL44XajSbx+PXKl09g3aLOyFqw9eFQxr5LPUMloF/nkqJy7mG+vznot/n46Wlzcnj8IB7xxHH+u6FtiC2FrIydj3n1zyY1AvgmURYS+myQzDlpars/8qT1sFVFyK3pslqgi8dZdn3VFPPHiiiy3BR9Y+0u4Ta9bZ9KGvNGlDPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xl3rg2vWYz1SGFZ;
	Fri,  8 Nov 2024 11:12:03 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 3430C180041;
	Fri,  8 Nov 2024 11:13:47 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 8 Nov 2024 11:13:46 +0800
Message-ID: <000d70e5-0d54-4a75-b95b-9b11d95541a7@huawei.com>
Date: Fri, 8 Nov 2024 11:13:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user
 stack
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<peterz@infradead.org>, <ast@kernel.org>, <puranjay@kernel.org>,
	<andrii@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240910060407.1427716-1-liaochang1@huawei.com>
 <ZxpUX1rbppLqS0bD@J2N7QTR9R3.cambridge.arm.com>
 <CAEf4Bzb9fM+hx8quHpCCeRh2p7UVk9Kk6yGj3XvyJLTQu9C-2w@mail.gmail.com>
 <46451dbe-056c-4c13-bfae-7ee8d6e115b5@huawei.com>
 <CAEf4BzYBAtNbCyCLybPxQrp-CZ9NVOco9X=xctnQ7BuDfhoadA@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYBAtNbCyCLybPxQrp-CZ9NVOco9X=xctnQ7BuDfhoadA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/11/7 3:45, Andrii Nakryiko 写道:
> On Tue, Nov 5, 2024 at 4:22 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>> Andrii and Mark.
>>
>> 在 2024/10/26 4:51, Andrii Nakryiko 写道:
>>> On Thu, Oct 24, 2024 at 7:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
>>>>
>>>> On Tue, Sep 10, 2024 at 06:04:07AM +0000, Liao Chang wrote:
>>>>> This patch is the second part of a series to improve the selftest bench
>>>>> of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #imm]'
>>>>> significantly impact uprobe/uretprobe performance at function entry in
>>>>> most user cases. Profiling results below reveals the STP that executes
>>>>> in the xol slot and trap back to kernel, reduce redis RPS and increase
>>>>> the time of string grep obviously.
>>>>>
>>>>> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
>>>>>
>>>>> Redis GET (higher is better)
>>>>> ----------------------------
>>>>> No uprobe: 49149.71 RPS
>>>>> Single-stepped STP: 46750.82 RPS
>>>>> Emulated STP: 48981.19 RPS
>>>>>
>>>>> Redis SET (larger is better)
>>>>> ----------------------------
>>>>> No uprobe: 49761.14 RPS
>>>>> Single-stepped STP: 45255.01 RPS
>>>>> Emulated stp: 48619.21 RPS
>>>>>
>>>>> Grep (lower is better)
>>>>> ----------------------
>>>>> No uprobe: 2.165s
>>>>> Single-stepped STP: 15.314s
>>>>> Emualted STP: 2.216s
>>>>
>>>> The results for grep are concerning.
>>>>
>>>> In theory, the overhead for stepping should be roughly double the
>>>> overhead for emulating, assuming the exception-entry and
>>>> exception-return are the dominant cost. The cost of stepping should be
>>>> trivial.
>>>>
>>>> Those results show emulating adds 0.051s (for a ~2.4% overhead), while
>>>> stepping adds 13.149s (for a ~607% overhead), meaning stepping is 250x
>>>> more expensive.
>>>>
>>>> Was this tested bare-metal, or in a VM?
>>>
>>> Hey Mark, I hope Liao will have a chance to reply, I don't know the
>>> details of his benchmarking. But I can try to give you my numbers and
>>> maybe answer a few questions, hopefully that helps move the
>>> conversation forward.
>>>
>>> So, first of all, I did a quick benchmark on bare metal (without
>>> Liao's optimization, though), here are my results:
>>>
>>> uprobe-nop            ( 1 cpus):    2.334 ± 0.011M/s  (  2.334M/s/cpu)
>>> uprobe-push           ( 1 cpus):    2.321 ± 0.010M/s  (  2.321M/s/cpu)
>>> uprobe-ret            ( 1 cpus):    4.144 ± 0.041M/s  (  4.144M/s/cpu)
>>>
>>> uretprobe-nop         ( 1 cpus):    1.684 ± 0.004M/s  (  1.684M/s/cpu)
>>> uretprobe-push        ( 1 cpus):    1.736 ± 0.003M/s  (  1.736M/s/cpu)
>>> uretprobe-ret         ( 1 cpus):    2.502 ± 0.006M/s  (  2.502M/s/cpu)
>>>
>>> uretprobes are inherently slower, so I'll just compare uprobe, as the
>>> differences are very clear either way.
>>>
>>> -nop is literally nop (Liao solved that issue, I just don't have his
>>> patch applied on my test machine). -push has `stp     x29, x30, [sp,
>>> #-0x10]!` instruction traced. -ret is literally just `ret`
>>> instruction.
>>>
>>> So you can see that -ret is almost twice as fast as the -push variant
>>> (it's a microbenchmark, yes, but still).
>>>
>>>>
>>>> AFAICT either:
>>>>
>>>> * Single-stepping is unexpectedly expensive.
>>>>
>>>>   Historically we had performance issues with hypervisor trapping of
>>>>   debug features, and there are things we might be able to improve in
>>>>   the hypervisor and kernel, which would improve stepping *all*
>>>>   instructions.
>>>>
>>>
>>> Single-stepping will always be more expensive, as it necessitates
>>> extra hop kernel->user space->kernel, so no matter the optimization
>>> for single-stepping, if we can avoid it, we should. It will be
>>> noticeable.
>>>
>>>>   If stepping is the big problem, we could move uprobes over to a BRK
>>>>   rather than a single-step. That would require require updating and
>>>>   fixing the logic to decide which instructions are steppable, but
>>>>   that's necessary anyway given it has extant soundness issues.
>>>
>>> I'm afraid I don't understand what BRK means and what are the
>>> consequences in terms of overheads. I'm not an ARM person either, so
>>> sorry if that's a stupid question. But either way, I can't address
>>> this. But see above, emulating an instruction feels like a much better
>>> approach, if possible.
>>
>> As I understand, Mark's suggestion is to place a BRK instruction next to
>> the instruction in the xol slot. Once the instruction in the xol slot
>> executed, the BRK instruction would trigger a trap into kernel. This is
>> a common technique used on platforms that don't support hardware single-
>> step. However, since Arm64 does support hardware single-stepping, kernel
>> enables it in pre_ssout(), allowing the CPU to automatically trap into kernel
>> after instruction in xol slot executed. But even we move uprobes over
>> to a BRK rather than a single-step. It can't reduce the overhead of user->
>> kernel->user context switch on the bare-metal. Maybe I am wrong, Mark,
>> could you give more details about the BRK.
>>
> 
> I see, thanks for elaborating. So the suggestion was to go from very
> expensive single-stepping mode to still expensive breakpoint-based
> kernel->user->kernel workflow.
> 
> I think either way it's going to be much slower than avoiding
> kernel->user->kernel hop, so we should emulate STP instead, yep.

Exactly, in most cases, simluation is the better option.

> 
>>>
>>>>
>>>> * XOL management is absurdly expensive.
>>>>
>>>>   Does uprobes keep the XOL slot around (like krpobes does), or does it
>>>>   create the slot afresh for each trap?
>>>
>>> XOL *page* is created once per process, lazily, and then we just
>>> juggle a bunch of fixed slots there for each instance of
>>> single-stepped uprobe. And yes, there are some bottlenecks in XOL
>>> management, though it's mostly due to lock contention (as it is
>>> implemented right now). Liao and Oleg have been improving XOL
>>> management, but still, avoiding XOL in the first place is the much
>>> preferred way.
>>>
>>>>
>>>>   If that's trying to create a slot afresh for each trap, there are
>>>>   several opportunities for improvement, e.g. keep the slot around for
>>>>   as long as the uprobe exists, or pre-allocate shared slots for common
>>>>   instructions and use those.
>>>
>>> As I mentioned, a XOL page is allocated and mapped once, but yes, it
>>> seems like we dynamically get a slot in it for each single-stepped
>>> execution (see xol_take_insn_slot() in kernel/events/uprobes.c). It's
>>> probably not a bad idea to just cache and hold a XOL slot for each
>>> specific uprobe, I don't see why we should limit ourselves to just one
>>> XOL page. We also don't need to pre-size each slot, we can probably
>>> allocate just the right amount of space for a given uprobe.
>>>
>>> All good ideas for sure, we should do them, IMO. But we'll still be
>>> paying an extra kernel->user->kernel switch, which almost certainly is
>>> slower than doing a simple stack push emulation just like we do in
>>> x86-64 case, no?
>>>
>>>
>>> BTW, I did a quick local profiling run. I don't think XOL management
>>> is the main source of overhead. I see 5% of CPU cycles spent in
>>> arch_uprobe_copy_ixol, but other than that XOL doesn't figure in stack
>>> traces. There are at least 22% CPU cycles spent in some
>>> local_daif_restore function, though, not sure what that is, but might
>>> be related to interrupt handling, right?
>>
>> The local_daif_restore() is part of the path for all user->kernel->user
>> context switch, including interrupt handling, breakpoints, and single-stepping
>> etc. I am surprised to see it consuming 22% of CPU cycles as well. I haven't
>> been enable to reproduce this on my local machine.
>>
>> Andrii, could you use the patch below to see if it can reduce the 5% of
>> CPU cycles spent in arch_uprobe_copy_ixol, I doubt that D/I cache
>> synchronization is the cause of this part of overhead.
>>
>> https://lore.kernel.org/all/20240919121719.2148361-1-liaochang1@huawei.com/
> 
> tbh, I think pre-allocating and setting up fixed XOL slots instead of
> dynamically allocating them is the way to go. We can allocate as many
> special "[uprobes]" pages as necessary to accommodate all the
> single-stepped uprobes in XOL, remember their index, etc. I think
> that's much more performant (and simpler, IMO) approach overall. All
> this preparation, however expensive it might be, will be done once per
> each attached/detached uprobe/uretprobe, which is the place where we
> want to do expensive stuff. Not when uprobe/uretprobe is actually
> triggered.

Generally agreed. But I have two concerns about pre-allocating of XOL slots:

1. If some uprobes/uretprobes are rarely or never triggered, pre-allocating
   slots for them seem wastful. However, it isn't a issue on machines with
   ample memory(e.g., hundreds of GB or a couple of TB).

2. Currently, threads that trigger the same uprobe/uretprobe are dynamically
   allocated different slots. Since we can't predict how many threads will
   trigger the same uprobe/uretprobe. it can't pre-allocate enough slots for
   per each uprobe/uretprobe. If you allow all threads to share the slot
   associated with each uprobe/uretprobe. this would result in XOL pages being
   shared across procecces, I think it would introduce significant changes to
   the page management of xol_area and fault handling.

> 
>>
>>>
>>>
>>> The take away I'd like to communicate here is avoiding the
>>> single-stepping need is *the best way* to go, IMO. So if we can
>>> emulate those STP instructions for uprobe *cheaply*, that would be
>>> awesome.
>>
>> Given some significant uprobe optimizations from Oleg and Andrii
>> merged, I am curious to see how these changes impact the profiling
>> result on Arm64. So I re-ran the selftest bench on the latest kernel
>> (based on tag next-20241104) and the kernel (based on tag next-20240909)
>> that I used when I submitted this patch. The results re-ran are shown
>> below.
>>
>> next-20240909(xol stp + xol nop)
>> --------------------------------
>> uprobe-nop      ( 1 cpus):    0.424 ± 0.000M/s  (  0.424M/s/cpu)
>> uprobe-push     ( 1 cpus):    0.415 ± 0.001M/s  (  0.415M/s/cpu)
>> uprobe-ret      ( 1 cpus):    2.101 ± 0.002M/s  (  2.101M/s/cpu)
>> uretprobe-nop   ( 1 cpus):    0.347 ± 0.000M/s  (  0.347M/s/cpu)
>> uretprobe-push  ( 1 cpus):    0.349 ± 0.000M/s  (  0.349M/s/cpu)
>> uretprobe-ret   ( 1 cpus):    1.051 ± 0.001M/s  (  1.051M/s/cpu)
>>
>> next-20240909(sim stp + sim nop)
>> --------------------------------
>> uprobe-nop      ( 1 cpus):    2.042 ± 0.002M/s  (  2.042M/s/cpu)
>> uprobe-push     ( 1 cpus):    1.363 ± 0.002M/s  (  1.363M/s/cpu)
>> uprobe-ret      ( 1 cpus):    2.052 ± 0.002M/s  (  2.052M/s/cpu)
>> uretprobe-nop   ( 1 cpus):    1.049 ± 0.001M/s  (  1.049M/s/cpu)
>> uretprobe-push  ( 1 cpus):    0.780 ± 0.000M/s  (  0.780M/s/cpu)
>> uretprobe-ret   ( 1 cpus):    1.065 ± 0.001M/s  (  1.065M/s/cpu)
>>
>> next-20241104 (xol stp + sim nop)
>> ---------------------------------
>> uprobe-nop      ( 1 cpus):    2.044 ± 0.003M/s  (  2.044M/s/cpu)
>> uprobe-push     ( 1 cpus):    0.415 ± 0.001M/s  (  0.415M/s/cpu)
>> uprobe-ret      ( 1 cpus):    2.047 ± 0.001M/s  (  2.047M/s/cpu)
>> uretprobe-nop   ( 1 cpus):    0.832 ± 0.003M/s  (  0.832M/s/cpu)
>> uretprobe-push  ( 1 cpus):    0.328 ± 0.000M/s  (  0.328M/s/cpu)
>> uretprobe-ret   ( 1 cpus):    0.833 ± 0.003M/s  (  0.833M/s/cpu)
>>
>> next-20241104 (sim stp + sim nop)
>> ---------------------------------
>> uprobe-nop      ( 1 cpus):    2.052 ± 0.002M/s  (  2.052M/s/cpu)
>> uprobe-push     ( 1 cpus):    1.411 ± 0.002M/s  (  1.411M/s/cpu)
>> uprobe-ret      ( 1 cpus):    2.052 ± 0.005M/s  (  2.052M/s/cpu)
>> uretprobe-nop   ( 1 cpus):    0.839 ± 0.005M/s  (  0.839M/s/cpu)
>> uretprobe-push  ( 1 cpus):    0.702 ± 0.002M/s  (  0.702M/s/cpu)
>> uretprobe-ret   ( 1 cpus):    0.837 ± 0.001M/s  (  0.837M/s/cpu)
>>
>> It seems that the STP simluation approach in this patch significantly
>> improves uprobe-push throughtput by 240% (from 0.415Ms/ to 1.411M/s)
>> and uretprobe-push by 114% (from 0.328M/s to 0.702M/s) on kernels
>> bases on next-20240909 and next-20241104. While there is still room
>> for improvement to reach the throughput of -nop and -ret, the gains
>> are very substantail.
>>
>> But I'm a bit puzzled by the throughput of uprobe/uretprobe-push using
>> single-stepping stp, which are far lower compared to the result when
>> when I submitted patch(look closely to the uprobe-push and uretprobe-push
>> results in commit log). I'm certain that the tests were run on the
>> same bare-metal machine with background tasked minimized. I doubt some
>> uncommitted uprobe optimization on my local repo twist the result of
>> -push using single-step.
> 
> You can always profiler and compare before/after, right? See where
> added costs are coming from?

Yes, I've been looking through the git reflog to restore the
kernel tree to the state when I submitted this patch.

Regarding the throughtput data of uprobe/uretprobe-push using
single-stepping, I believe *the re-ran result provide a more
accurate picture*. If we carefully compare the throughput of
-nop and -push, we can see that they are very close (uprobe-nop
is 0.424M/s/cpu and uprobe-push is 0.415M/s/cpu, uretprobe-nop
is 0.347M/s/cpu and upretprobe-push is 0.349M/s/cpu). This is
expected, as both use single-stepping to execute NOP and STP.
There's no reason -push using single-step should outperform the
one of -nop(uprobe-push is 0.868M/s/cpu a month ago).

In summary, understanding these performance is crucial for selecting
an approach that balances accuracy and efficiency. Although this
patch offers lower gain compared to my initial implementation.
But, considering the complexity of 'STP', the cost seems acceptable,
right?

> 
>>
>> In addition to the micro benchmark, I also re-ran Redis benchmark to
>> compare the impact of single-stepping STP and simluated STP to the
>> throughput of redis-server. I believe the impact of uprobe on the real
>> application depends on the frequency of uprobe triggered and the application's
>> hot paths. Therefore, I wouldn't say the simluated STP will benefit all
>> real world applications.
> 
> It will benefit *a lot* of real world applications, though, so I think
> it's very important to improve.

Good to see that.

> 
>>
>> $ redis-benchmark -h [redis-server IP] -p 7778 -n 64000 -d 4 -c 128 -t SET
>> $ redis-server --port 7778 --protected-mode no --save "" --appendonly no & &&
>>   bpftrace -e 'uprobe:redis-server:readQueryFromClient{}
>>                uprobe:redis-server:processCommand{}
>>                uprobe:redis-server:aeApiPoll {}'
>>
>> next-20241104
>> -------------
>> RPS: 55602.1
>>
>> next-20241104 + ss stp
>> ----------------------
>> RPS: 47220.9
>> uprobe@@aeApiPoll: 554565
>> uprobe@processCommand: 1275160
>> uprobe@readQueryFromClient: 1277710
>>>> next-20241104 + sim stp
>> -----------------------
>> RPS           54290.09
>> uprobe@aeApiPoll: 496007
>> uprobe@processCommand: 1275160
>> uprobe@readQueryFromClient: 1277710
>>
>> Andrii expressed concern that the STP simulation in this patch is too
>> expensive. If we believe the result I re-ran, perhaps it is not a
>> bad way to simluate STP. Looking forward to your feedbacks, or someone
>> could propose a cheaper way to simluate STP, I'm very happy to test it
>> on my machine, thanks.
> 
> I'm no ARM64 expert, but seeing that we simulate stack pushes with
> just memory reads/write for x86-64, it feels like that should be
> satisfactory for ARM64. So I'd suggest you to go back to the initial
> implementation, clean it up, rebase, re-benchmark, and send a new
> revision. Let's continue the discussion there?

I've re-benchmarked the initial implementation on the latest kernel
tree (tag next-20241104). I paste the results for single-stepping,
the initial patch and this patch here for comparision. Please see
the results below:

next-20241104 + xol stp
-----------------------
uprobe-push     ( 1 cpus):    0.415 ± 0.001M/s  (  0.415M/s/cpu)
uretprobe-push  ( 1 cpus):    0.328 ± 0.000M/s  (  0.328M/s/cpu)

next-20221104 + initial patch
-----------------------------
uprobe-push     ( 1 cpus):    1.798 ± 0.001M/s  (  1.798M/s/cpu)
uretprobe-push  ( 1 cpus):    0.806 ± 0.001M/s  (  0.806M/s/cpu)

next-20241104 + this patch
--------------------------
uprobe-push     ( 1 cpus):    1.411 ± 0.002M/s  (  1.411M/s/cpu)
uretprobe-push  ( 1 cpus):    0.702 ± 0.002M/s  (  0.702M/s/cpu)

As shown in the benchmark results, the initial implementation offers
a limited performance advantage, especailly, it comes at the cost of
accuracy.

> 
>>
>> [...]
>>
>>>>>
>>>>> xol-stp
>>>>> -------
>>>>> uprobe-nop      ( 1 cpus):    1.566 ± 0.006M/s  (  1.566M/s/cpu)
>>>>> uprobe-push     ( 1 cpus):    0.868 ± 0.001M/s  (  0.868M/s/cpu)
>>>>> uprobe-ret      ( 1 cpus):    1.629 ± 0.001M/s  (  1.629M/s/cpu)
>>>>> uretprobe-nop   ( 1 cpus):    0.871 ± 0.001M/s  (  0.871M/s/cpu)
>>>>> uretprobe-push  ( 1 cpus):    0.616 ± 0.001M/s  (  0.616M/s/cpu)
>>>>> uretprobe-ret   ( 1 cpus):    0.878 ± 0.002M/s  (  0.878M/s/cpu)
>>>>>
>>>>> simulated-stp
>>>>> -------------
>>>>> uprobe-nop      ( 1 cpus):    1.544 ± 0.001M/s  (  1.544M/s/cpu)
>>>>> uprobe-push     ( 1 cpus):    1.128 ± 0.002M/s  (  1.128M/s/cpu)
>>>>> uprobe-ret      ( 1 cpus):    1.550 ± 0.005M/s  (  1.550M/s/cpu)
>>>>> uretprobe-nop   ( 1 cpus):    0.872 ± 0.004M/s  (  0.872M/s/cpu)
>>>>> uretprobe-push  ( 1 cpus):    0.714 ± 0.001M/s  (  0.714M/s/cpu)
>>>>> uretprobe-ret   ( 1 cpus):    0.896 ± 0.001M/s  (  0.896M/s/cpu)
>>>>>
>>>>> The profiling results based on the upstream kernel with spinlock
>>>>> optimization patches [2] reveals the simulation of STP increase the
>>>>> uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu) and
>>>>> uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).
>>>>>
>>>>> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com/
>>>>> [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
>>>>> [2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@huawei.com/
>>>>>
>>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>>> ---
>>>>>  arch/arm64/include/asm/insn.h            |  1 +
>>>>>  arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
>>>>>  arch/arm64/kernel/probes/decode-insn.h   |  1 +
>>>>>  arch/arm64/kernel/probes/simulate-insn.c | 89 ++++++++++++++++++++++++
>>>>>  arch/arm64/kernel/probes/simulate-insn.h |  1 +
>>>>>  arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
>>>>>  arch/arm64/lib/insn.c                    |  5 ++
>>>>>  7 files changed, 134 insertions(+)
>>>>>
>>>
>>> [...]
>>
>> --
>> BR
>> Liao, Chang
>>

-- 
BR
Liao, Chang


