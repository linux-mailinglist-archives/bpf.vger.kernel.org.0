Return-Path: <bpf+bounces-37152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2233D95136C
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 06:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD175286341
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 04:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E474D8B7;
	Wed, 14 Aug 2024 04:18:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01788182B5;
	Wed, 14 Aug 2024 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723609080; cv=none; b=eQCC+fG7FiMEKFT4NgdwvBV7H0FUg5yoUQOqt0P1vTxLFL3DVgYBTZ2MMMwUjH8h4zWHeFwozwba6b549IVNyU1g4OAZXxt1YkILwD4nPU21s8NHCXL4qMFobbFtsaXHQdCA6fXq/n5NKNvJHstoGvkZ8u7VdagGHWChO74pmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723609080; c=relaxed/simple;
	bh=aUSmNuue/AkXUWPP12jzk5pWyg5JlEitzEVfGB/cnsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZDEYTAYWV7Slm21GDWV3l2QWrAQSKJ3fngDNSlqL4r9koX+hxQMrUMWvFMZNa2ozELWvErBhfeV40C8KkPI7Wb/ZJ9jE+9UwtZnpTSmFKrwuXSmiUkuz4CU6UMzvTtQUxj0H92J5p4ITtHvIoKapSdQsj/wMddf6Nym4q7oINpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkFLq0C6gzndxJ;
	Wed, 14 Aug 2024 12:16:35 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 55C3E1800A0;
	Wed, 14 Aug 2024 12:17:55 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 14 Aug 2024 12:17:53 +0800
Message-ID: <ddf680b7-181c-fb61-6c56-d0e6dfb756c4@huawei.com>
Date: Wed, 14 Aug 2024 12:17:52 +0800
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
 <a22d6d79-fa7e-62b2-0ac1-575068f176a5@huawei.com>
 <CAEf4BzbN-+p0cDnHQPDwhVaqs-r-_Ft-LdUwY2KHG1xfrmyjBQ@mail.gmail.com>
 <CAEf4BzZyCd7ECbWQyEpcB4va_U33v8BdfWVY4cMH4zN-Z1sESw@mail.gmail.com>
 <5a110f15-024f-d693-e04f-7892fc8d7757@huawei.com>
 <CAEf4BzaGPB+AybJNhzD+4rT6ioLuhjp4sW3uG0ST4sCtqSjx1A@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzaGPB+AybJNhzD+4rT6ioLuhjp4sW3uG0ST4sCtqSjx1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/13 1:57, Andrii Nakryiko 写道:
> On Mon, Aug 12, 2024 at 5:05 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>>
>>
>> 在 2024/8/10 2:40, Andrii Nakryiko 写道:
>>> On Fri, Aug 9, 2024 at 11:34 AM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>> On Fri, Aug 9, 2024 at 12:16 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> 在 2024/8/9 2:26, Andrii Nakryiko 写道:
>>>>>> On Thu, Aug 8, 2024 at 1:45 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>>>>>>
>>>>>>> Hi Andrii and Oleg.
>>>>>>>
>>>>>>> This patch sent by me two weeks ago also aim to optimize the performance of uprobe
>>>>>>> on arm64. I notice recent discussions on the performance and scalability of uprobes
>>>>>>> within the mailing list. Considering this interest, I've added you and other relevant
>>>>>>> maintainers to the CC list for broader visibility and potential collaboration.
>>>>>>>
>>>>>>
>>>>>> Hi Liao,
>>>>>>
>>>>>> As you can see there is an active work to improve uprobes, that
>>>>>> changes lifetime management of uprobes, removes a bunch of locks taken
>>>>>> in the uprobe/uretprobe hot path, etc. It would be nice if you can
>>>>>> hold off a bit with your changes until all that lands. And then
>>>>>> re-benchmark, as costs might shift.
>>>>>
>>>>> Andrii, I'm trying to integrate your lockless changes into the upstream
>>>>> next-20240806 kernel tree. And I ran into some conflicts. please let me
>>>>> know which kernel you're currently working on.
>>>>>
>>>>
>>>> My patches are  based on tip/perf/core. But I also just pushed all the
>>>> changes I have accumulated (including patches I haven't sent for
>>>> review just yet), plus your patches for sighand lock removed applied
>>>> on top into [0]. So you can take a look and use that as a base for
>>>> now. Keep in mind, a bunch of those patches might still change, but
>>>> this should give you the best currently achievable performance with
>>>> uprobes/uretprobes. E.g., I'm getting something like below on x86-64
>>>> (note somewhat linear scalability with number of CPU cores, with
>>>> per-CPU performance *slowly* declining):
>>>>
>>>> uprobe-nop            ( 1 cpus):    3.565 ± 0.004M/s  (  3.565M/s/cpu)
>>>> uprobe-nop            ( 2 cpus):    6.742 ± 0.009M/s  (  3.371M/s/cpu)
>>>> uprobe-nop            ( 3 cpus):   10.029 ± 0.056M/s  (  3.343M/s/cpu)
>>>> uprobe-nop            ( 4 cpus):   13.118 ± 0.014M/s  (  3.279M/s/cpu)
>>>> uprobe-nop            ( 5 cpus):   16.360 ± 0.011M/s  (  3.272M/s/cpu)
>>>> uprobe-nop            ( 6 cpus):   19.650 ± 0.045M/s  (  3.275M/s/cpu)
>>>> uprobe-nop            ( 7 cpus):   22.926 ± 0.010M/s  (  3.275M/s/cpu)
>>>> uprobe-nop            ( 8 cpus):   24.707 ± 0.025M/s  (  3.088M/s/cpu)
>>>> uprobe-nop            (10 cpus):   30.842 ± 0.018M/s  (  3.084M/s/cpu)
>>>> uprobe-nop            (12 cpus):   33.623 ± 0.037M/s  (  2.802M/s/cpu)
>>>> uprobe-nop            (14 cpus):   39.199 ± 0.009M/s  (  2.800M/s/cpu)
>>>> uprobe-nop            (16 cpus):   41.698 ± 0.018M/s  (  2.606M/s/cpu)
>>>> uprobe-nop            (24 cpus):   65.078 ± 0.018M/s  (  2.712M/s/cpu)
>>>> uprobe-nop            (32 cpus):   84.580 ± 0.017M/s  (  2.643M/s/cpu)
>>>> uprobe-nop            (40 cpus):  101.992 ± 0.268M/s  (  2.550M/s/cpu)
>>>> uprobe-nop            (48 cpus):  101.032 ± 1.428M/s  (  2.105M/s/cpu)
>>>> uprobe-nop            (56 cpus):  110.986 ± 0.736M/s  (  1.982M/s/cpu)
>>>> uprobe-nop            (64 cpus):  124.145 ± 0.110M/s  (  1.940M/s/cpu)
>>>> uprobe-nop            (72 cpus):  134.940 ± 0.200M/s  (  1.874M/s/cpu)
>>>> uprobe-nop            (80 cpus):  143.918 ± 0.235M/s  (  1.799M/s/cpu)
>>>>
>>>> uretprobe-nop         ( 1 cpus):    1.987 ± 0.001M/s  (  1.987M/s/cpu)
>>>> uretprobe-nop         ( 2 cpus):    3.766 ± 0.003M/s  (  1.883M/s/cpu)
>>>> uretprobe-nop         ( 3 cpus):    5.638 ± 0.002M/s  (  1.879M/s/cpu)
>>>> uretprobe-nop         ( 4 cpus):    7.275 ± 0.003M/s  (  1.819M/s/cpu)
>>>> uretprobe-nop         ( 5 cpus):    9.124 ± 0.004M/s  (  1.825M/s/cpu)
>>>> uretprobe-nop         ( 6 cpus):   10.818 ± 0.007M/s  (  1.803M/s/cpu)
>>>> uretprobe-nop         ( 7 cpus):   12.721 ± 0.014M/s  (  1.817M/s/cpu)
>>>> uretprobe-nop         ( 8 cpus):   13.639 ± 0.007M/s  (  1.705M/s/cpu)
>>>> uretprobe-nop         (10 cpus):   17.023 ± 0.009M/s  (  1.702M/s/cpu)
>>>> uretprobe-nop         (12 cpus):   18.576 ± 0.014M/s  (  1.548M/s/cpu)
>>>> uretprobe-nop         (14 cpus):   21.660 ± 0.004M/s  (  1.547M/s/cpu)
>>>> uretprobe-nop         (16 cpus):   22.922 ± 0.013M/s  (  1.433M/s/cpu)
>>>> uretprobe-nop         (24 cpus):   34.756 ± 0.069M/s  (  1.448M/s/cpu)
>>>> uretprobe-nop         (32 cpus):   44.869 ± 0.153M/s  (  1.402M/s/cpu)
>>>> uretprobe-nop         (40 cpus):   53.397 ± 0.220M/s  (  1.335M/s/cpu)
>>>> uretprobe-nop         (48 cpus):   48.903 ± 2.277M/s  (  1.019M/s/cpu)
>>>> uretprobe-nop         (56 cpus):   42.144 ± 1.206M/s  (  0.753M/s/cpu)
>>>> uretprobe-nop         (64 cpus):   42.656 ± 1.104M/s  (  0.666M/s/cpu)
>>>> uretprobe-nop         (72 cpus):   46.299 ± 1.443M/s  (  0.643M/s/cpu)
>>>> uretprobe-nop         (80 cpus):   46.469 ± 0.808M/s  (  0.581M/s/cpu)
>>>>
>>>> uprobe-ret            ( 1 cpus):    1.219 ± 0.008M/s  (  1.219M/s/cpu)
>>>> uprobe-ret            ( 2 cpus):    1.862 ± 0.008M/s  (  0.931M/s/cpu)
>>>> uprobe-ret            ( 3 cpus):    2.874 ± 0.005M/s  (  0.958M/s/cpu)
>>>> uprobe-ret            ( 4 cpus):    3.512 ± 0.002M/s  (  0.878M/s/cpu)
>>>> uprobe-ret            ( 5 cpus):    3.549 ± 0.001M/s  (  0.710M/s/cpu)
>>>> uprobe-ret            ( 6 cpus):    3.425 ± 0.003M/s  (  0.571M/s/cpu)
>>>> uprobe-ret            ( 7 cpus):    3.551 ± 0.009M/s  (  0.507M/s/cpu)
>>>> uprobe-ret            ( 8 cpus):    3.050 ± 0.002M/s  (  0.381M/s/cpu)
>>>> uprobe-ret            (10 cpus):    2.706 ± 0.002M/s  (  0.271M/s/cpu)
>>>> uprobe-ret            (12 cpus):    2.588 ± 0.003M/s  (  0.216M/s/cpu)
>>>> uprobe-ret            (14 cpus):    2.589 ± 0.003M/s  (  0.185M/s/cpu)
>>>> uprobe-ret            (16 cpus):    2.575 ± 0.001M/s  (  0.161M/s/cpu)
>>>> uprobe-ret            (24 cpus):    1.808 ± 0.011M/s  (  0.075M/s/cpu)
>>>> uprobe-ret            (32 cpus):    1.853 ± 0.001M/s  (  0.058M/s/cpu)
>>>> uprobe-ret            (40 cpus):    1.952 ± 0.002M/s  (  0.049M/s/cpu)
>>>> uprobe-ret            (48 cpus):    2.075 ± 0.007M/s  (  0.043M/s/cpu)
>>>> uprobe-ret            (56 cpus):    2.441 ± 0.004M/s  (  0.044M/s/cpu)
>>>> uprobe-ret            (64 cpus):    1.880 ± 0.012M/s  (  0.029M/s/cpu)
>>>> uprobe-ret            (72 cpus):    0.962 ± 0.002M/s  (  0.013M/s/cpu)
>>>> uprobe-ret            (80 cpus):    1.040 ± 0.011M/s  (  0.013M/s/cpu)
>>>>
>>>> uretprobe-ret         ( 1 cpus):    0.981 ± 0.000M/s  (  0.981M/s/cpu)
>>>> uretprobe-ret         ( 2 cpus):    1.421 ± 0.001M/s  (  0.711M/s/cpu)
>>>> uretprobe-ret         ( 3 cpus):    2.050 ± 0.003M/s  (  0.683M/s/cpu)
>>>> uretprobe-ret         ( 4 cpus):    2.596 ± 0.002M/s  (  0.649M/s/cpu)
>>>> uretprobe-ret         ( 5 cpus):    3.105 ± 0.003M/s  (  0.621M/s/cpu)
>>>> uretprobe-ret         ( 6 cpus):    3.886 ± 0.002M/s  (  0.648M/s/cpu)
>>>> uretprobe-ret         ( 7 cpus):    3.016 ± 0.001M/s  (  0.431M/s/cpu)
>>>> uretprobe-ret         ( 8 cpus):    2.903 ± 0.000M/s  (  0.363M/s/cpu)
>>>> uretprobe-ret         (10 cpus):    2.755 ± 0.001M/s  (  0.276M/s/cpu)
>>>> uretprobe-ret         (12 cpus):    2.400 ± 0.001M/s  (  0.200M/s/cpu)
>>>> uretprobe-ret         (14 cpus):    3.972 ± 0.001M/s  (  0.284M/s/cpu)
>>>> uretprobe-ret         (16 cpus):    3.940 ± 0.003M/s  (  0.246M/s/cpu)
>>>> uretprobe-ret         (24 cpus):    3.002 ± 0.003M/s  (  0.125M/s/cpu)
>>>> uretprobe-ret         (32 cpus):    3.018 ± 0.003M/s  (  0.094M/s/cpu)
>>>> uretprobe-ret         (40 cpus):    1.846 ± 0.000M/s  (  0.046M/s/cpu)
>>>> uretprobe-ret         (48 cpus):    2.487 ± 0.004M/s  (  0.052M/s/cpu)
>>>> uretprobe-ret         (56 cpus):    2.470 ± 0.006M/s  (  0.044M/s/cpu)
>>>> uretprobe-ret         (64 cpus):    2.027 ± 0.014M/s  (  0.032M/s/cpu)
>>>> uretprobe-ret         (72 cpus):    1.108 ± 0.011M/s  (  0.015M/s/cpu)
>>>> uretprobe-ret         (80 cpus):    0.982 ± 0.005M/s  (  0.012M/s/cpu)
>>>>
>>>>
>>>> -ret variants (single-stepping case for x86-64) still suck, but they
>>>> suck 2x less now with your patches :) Clearly more work ahead for
>>>> those, though.
>>>>
>>>
>>> Quick profiling shows that it's mostly xol_take_insn_slot() and
>>> xol_free_insn_slot(), now. So it seems like your planned work might
>>> help here.
>>
>> Andrii, I'm glad we've reached a similar result, The profiling result on
>> my machine reveals that about 80% cycles spent on the atomic operations
>> on area->bitmap and area->slot_count. I guess the atomic access leads to
>> the intensive cacheline bouncing bewteen CPUs.
>>
>> In the passed weekend, I have been working on another patch that optimizes
>> the xol_take_insn_slot() and xol_free_inns_slot() for better scalability.
>> This involves delaying the freeing of xol insn slots to reduce the times
>> of atomic operations and cacheline bouncing. Additionally, per-task refcounts
>> and an RCU-style management of linked-list of allocated insn slots. In short
>> summary, this patch try to replace coarse-grained atomic variables with
>> finer-grained ones, aiming to elimiate the expensive atomic instructions
>> in the hot path. If you or others have bandwidth and interest, I'd welcome
>> a brainstorming session on this topic.
> 
> I'm happy to help, but I still feel like it's best to concentrate on
> landing all the other pending things for uprobe, and then switch to
> optimizing the xol case.
> 
> We have:
>   - RCU protection and avoiding refcounting for uprobes (I'll be
> sending latest revision soon);
>   - SRCU+timeout for uretprobe and single-step (pending the above
> landing first);
>   - removing shared nhit counter increment in trace_uprobe (I've sent
> patches last week, see [0]);
>   - lockless VMA -> inode -> uprobe look up (also pending for #1 to
> land, and some more benchmarking for mm_lock_seq changes from Suren,
> see [1]);
>   - and, of course, your work to remove sighand lock.
> 
> So as you can see, there is plenty to discuss and land already, I just
> don't want to spread the efforts too thin. But if you can help improve
> the benchmark for ARM64, that would be a great parallel effort setting
> us up for further work nicely. Thanks!

Agree. Let's prioritize landing your exising patches. I'll build upon
you works for the further uprobe optimizatoin for Arm64.

Thanks.

> 
>   [0] https://lore.kernel.org/bpf/20240809192357.4061484-1-andrii@kernel.org/
>   [1] https://lore.kernel.org/linux-mm/CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com/
> 
>>
>> Thanks.
>>
>>>
>>>>
>>>>   [0] https://github.com/anakryiko/linux/commits/uprobes-lockless-cumulative/
>>>>
>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>> But also see some remarks below.
>>>>>>
>>>>>>> Thanks.
>>>>>>>
> 
> [...]

-- 
BR
Liao, Chang

