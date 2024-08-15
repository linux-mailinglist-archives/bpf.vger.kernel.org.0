Return-Path: <bpf+bounces-37240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CDD95280A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 04:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C071F23361
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 02:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387023776;
	Thu, 15 Aug 2024 02:58:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3C38382;
	Thu, 15 Aug 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690729; cv=none; b=so+zn0p31FG4g0vuf6CfL1SQN/D6oUZdbMaYvwVtvagHmqdIW3meGZ+THX5ABXcJLlE2WT/lXoOedk3/cDWC2nTcrpgHidzBRQD/jIoxXdJR+iPWnHoFWmh3zkbd2BBQBsDXAr+fe0iY1YaMvQqBRtOr9eFhTJHHB2qqfesIheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690729; c=relaxed/simple;
	bh=86J0cKNCLMIx8ugIr/ubHmolU32V6osL0szusAhIeNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DxRdYQOtWIeofKLuy20hiEYw7YCs5p52zAk+fQNNJ0O0P4hQ6mnx5RHaJiINmyMIxVIA315SfA4wIG905yc3RUzJzAtmfjlqoMDpTfJeH0Cuse86FfOSHBaQm05XY0UGjZLf+T5vd0Y5jG7mJtixuVFBjhF2jUlqMGBQUvXNqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkqXy3MGgzpTDN;
	Thu, 15 Aug 2024 10:57:22 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AB981800A0;
	Thu, 15 Aug 2024 10:58:44 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 15 Aug 2024 10:58:42 +0800
Message-ID: <9044640f-727a-f4ec-cb70-35eeeb28111e@huawei.com>
Date: Thu, 15 Aug 2024 10:58:42 +0800
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
 <CAEf4BzZkXWcE7=2FNm-DrSFOR-Pd9LqrQJvV0ShXfPnXzSzYjg@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzZkXWcE7=2FNm-DrSFOR-Pd9LqrQJvV0ShXfPnXzSzYjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/15 2:42, Andrii Nakryiko 写道:
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
> 
> Why would the *benchmarks* have to be modified? The typical
> kprobe/kretprobe attachment should be fast, and those benchmarks
> simulate typical fast path kprobe/kretprobe. Is there some simulation
> logic that is shared between uprobes and kprobes or something?

Yes, kprobe and uprobe share many things for Arm64, but there are curical
difference. Let me explain further. Simulating a 'push' instruction on
arm64 will modify the stack pointer at *probe breakpoint. However, kprobe
and uprobe use different way to restore the stack pointer upon returning
from the breakpoint exception. Consequently.sharing the same simulation
logic for both would result in kernel panic for kprobe.

To avoid complicating the exception return logic, I've opted to simuate
'push' only for uprobe and maintain the single-stepping for kprobe [0].
This trade-off avoid the impacts to kprobe/kretprobe, and no need to
change the kprobe/kretprobe related benchmark.

[0] https://lore.kernel.org/all/20240814080356.2639544-1-liaochang1@huawei.com/

> 
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
> 
> [...]

-- 
BR
Liao, Chang

