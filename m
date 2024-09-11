Return-Path: <bpf+bounces-39562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF5974871
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117AD1F26F3A
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8C2D057;
	Wed, 11 Sep 2024 03:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6C282F7;
	Wed, 11 Sep 2024 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726024034; cv=none; b=SPiSIICAi8rUuMW8rLrOSVQn2+y2ID5V4exlOFdto1Tl0ISo0CRxh/lFrEJlxnuuaURenhjUfV+JgoTx9PDcbg2P42TajB0OT3dxJ92EmteSeg7Sb6wgb3qavcvmBWLEBcbyUiGvYPgywf8l089Ljke7Bp5EosdklEZvCZb8U2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726024034; c=relaxed/simple;
	bh=940mgBJmC6hbA6r1sSviHQQZ1ds93etAldQvIvPZcbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HQ5Ch6CwG/50Mgty0dgMBEzPvfDo3S8jw+xk83GAMGtlWB522DBx9bcQOIBl9E6y80NTSR01loxUmYY5anRTzSIBSx0pYwq4dXFIp2BP0rpr+YQ1BmrX7rMFanTMr0rpE8n0i2vNRebPbTgepaJVttUxa+ksXUjGQakuXWgmRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3QST5v5mzyRRM;
	Wed, 11 Sep 2024 11:06:01 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 46D811402E2;
	Wed, 11 Sep 2024 11:07:08 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 11 Sep 2024 11:06:58 +0800
Message-ID: <f96eda54-9fb1-31a0-b138-cde0716f11f1@huawei.com>
Date: Wed, 11 Sep 2024 11:06:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user
 stack
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mhiramat@kernel.org>,
	<oleg@redhat.com>, <peterz@infradead.org>, <ast@kernel.org>,
	<puranjay@kernel.org>, <andrii@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240910060407.1427716-1-liaochang1@huawei.com>
 <CAEf4BzZ3trjMWjvWX4Zy1GzW5RN1ihXZSnLZax7V-mCzAUg2cg@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzZ3trjMWjvWX4Zy1GzW5RN1ihXZSnLZax7V-mCzAUg2cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/11 4:54, Andrii Nakryiko 写道:
> On Mon, Sep 9, 2024 at 11:14 PM Liao Chang <liaochang1@huawei.com> wrote:
>>
>> This patch is the second part of a series to improve the selftest bench
>> of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #imm]'
>> significantly impact uprobe/uretprobe performance at function entry in
>> most user cases. Profiling results below reveals the STP that executes
>> in the xol slot and trap back to kernel, reduce redis RPS and increase
>> the time of string grep obviously.
>>
>> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
>>
>> Redis GET (higher is better)
>> ----------------------------
>> No uprobe: 49149.71 RPS
>> Single-stepped STP: 46750.82 RPS
>> Emulated STP: 48981.19 RPS
>>
>> Redis SET (larger is better)
>> ----------------------------
>> No uprobe: 49761.14 RPS
>> Single-stepped STP: 45255.01 RPS
>> Emulated stp: 48619.21 RPS
>>
>> Grep (lower is better)
>> ----------------------
>> No uprobe: 2.165s
>> Single-stepped STP: 15.314s
>> Emualted STP: 2.216s
>>
>> Additionally, a profiling of the entry instruction for all leaf and
>> non-leaf function, the ratio of 'stp fp, lr, [sp, #imm]' is larger than
>> 50%. So simulting the STP on the function entry is a more viable option
>> for uprobe.
>>
>> In the first version [1], it used a uaccess routine to simulate the STP
>> that push fp/lr into stack, which use double STTR instructions for
>> memory store. But as Mark pointed out, this approach can't simulate the
>> correct single-atomicity and ordering properties of STP, especiallly
>> when it interacts with MTE, POE, etc. So this patch uses a more complex
> 
> Does all those effects matter if the thread is stopped after
> breakpoint? This is pushing to stack, right? Other threads are not
> supposed to access that memory anyways (not the well-defined ones, at
> least, I suppose). Do we really need all these complications for

I have raised the same question in my reply to Mark. Since the STP
simulation focuses on the uprobe/uretprob at function entry, which
push two registers onto *stack*. I believe it might not require strict
alignment with the exact property of STP. However, as you know, Mark
stand by his comments about STP simulation, which is why I send this
patch out. Although the gain is not good as the uaccess version, it
still offer some better result than the current XOL code.

> uprobes? We use a similar approach in x86-64, see emulate_push_stack()
> in arch/x86/kernel/uprobes.c and it works great in practice (and has

Yes, I've noticed the X86 routine. Actually. The CPU-specific difference
lies in Arm64 CPUs with PAN enabled. Due to security reasons, it doesn't
support STP (storing pairs of registers to memory) when accessing userpsace
address. This leads to kernel has to use STTR instructions (storing single
register to unprivileged memory) twice, which can't meet the atomicity
and ordering properties of original STP at userspace. In future, if Arm64
would add some instruction for storing pairs of registers to unprivileged
memory, it ought to replace this inefficient approach.

> been for years by now). Would be nice to keep things simple knowing
> that this is specifically for this rather well-defined and restricted
> uprobe/uretprobe use case.
> 
> Sorry, I can't help reviewing this, but I have a hunch that we might
> be over-killing it with this approach, no?

This approach fails to obtain the max benefit from simuation indeed.

> 
> 
>> and inefficient approach that acquires user stack pages, maps them to
>> kernel address space, and allows kernel to use STP directly push fp/lr
>> into the stack pages.
>>
>> xol-stp
>> -------
>> uprobe-nop      ( 1 cpus):    1.566 ± 0.006M/s  (  1.566M/s/cpu)
>> uprobe-push     ( 1 cpus):    0.868 ± 0.001M/s  (  0.868M/s/cpu)
>> uprobe-ret      ( 1 cpus):    1.629 ± 0.001M/s  (  1.629M/s/cpu)
>> uretprobe-nop   ( 1 cpus):    0.871 ± 0.001M/s  (  0.871M/s/cpu)
>> uretprobe-push  ( 1 cpus):    0.616 ± 0.001M/s  (  0.616M/s/cpu)
>> uretprobe-ret   ( 1 cpus):    0.878 ± 0.002M/s  (  0.878M/s/cpu)
>>
>> simulated-stp
>> -------------
>> uprobe-nop      ( 1 cpus):    1.544 ± 0.001M/s  (  1.544M/s/cpu)
>> uprobe-push     ( 1 cpus):    1.128 ± 0.002M/s  (  1.128M/s/cpu)
>> uprobe-ret      ( 1 cpus):    1.550 ± 0.005M/s  (  1.550M/s/cpu)
>> uretprobe-nop   ( 1 cpus):    0.872 ± 0.004M/s  (  0.872M/s/cpu)
>> uretprobe-push  ( 1 cpus):    0.714 ± 0.001M/s  (  0.714M/s/cpu)
>> uretprobe-ret   ( 1 cpus):    0.896 ± 0.001M/s  (  0.896M/s/cpu)
>>
>> The profiling results based on the upstream kernel with spinlock
>> optimization patches [2] reveals the simulation of STP increase the
>> uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu) and
>> uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).
>>
>> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com/
>> [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
>> [2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@huawei.com/
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/arm64/include/asm/insn.h            |  1 +
>>  arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
>>  arch/arm64/kernel/probes/decode-insn.h   |  1 +
>>  arch/arm64/kernel/probes/simulate-insn.c | 89 ++++++++++++++++++++++++
>>  arch/arm64/kernel/probes/simulate-insn.h |  1 +
>>  arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
>>  arch/arm64/lib/insn.c                    |  5 ++
>>  7 files changed, 134 insertions(+)
>>
> 
> [...]
> 
> 

-- 
BR
Liao, Chang

