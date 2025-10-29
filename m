Return-Path: <bpf+bounces-72686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D4C1885B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 07:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFBC64F6E97
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD1B3074B4;
	Wed, 29 Oct 2025 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W6Jnz+qt"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50133993
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720625; cv=none; b=cGNVeDH3KmWZlUIXMPRT2T+oyxtylDUa+cegp4co0KIjyXIYD151GmANEZinGAuuXuZEbWveUsQl2znecZcRYubmVn/upFfqY3sjBLNgF+UKJ+qf+fs+7O67bpCI+0yA1cIOqCxLTCAsXjC07LbGVIjgigUUlNfvy1DUA+AmsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720625; c=relaxed/simple;
	bh=b1QvLqawxjDiGrhxtjc3TAtZvqFJOFah5H1Z8aXGLqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D95E0M1OYkCNJeiTdJdManjpf13B7CUZBjjZsq5MhFG1jodqhJO6Cx+MT1CpT1OQt0259FJxiq2lA1+q7ic+7NxELr8WpSKExZQvJqrSEse/TCw8a0tp7u4E4yQfP1cJ8u96N8+FLrPKaQ8QGXSpheFvxbdWMAdNuxLzmp8sUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W6Jnz+qt; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761720619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SXKsYDX3YdEq/6UqV1sgRzcORjhBF3522kd5Cn3Ku4=;
	b=W6Jnz+qtFrUha+R3e1L2Fpxt0QxMlmiIGxAQJ2RrES8No1HvCOvrDRIZiDP+on+6kUPPNr
	MjqVLaUXcC1+0WVJR1xHQRIST9tEXTpLDQY57nvw2Tjb7KQ7WYykT0BlwcX0iTjE3j69kj
	2iL2COljLfirA5/7L4SeM21wgCkibeo=
Date: Wed, 29 Oct 2025 14:49:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 patchwork-bot+netdevbpf@kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251026154000.34151-1-leon.hwang@linux.dev>
 <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
 <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 29/10/25 04:22, Andrii Nakryiko wrote:
> On Tue, Oct 28, 2025 at 11:10 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>
>> Hello:
>>
>> This series was applied to bpf/bpf-next.git (master)
>> by Andrii Nakryiko <andrii@kernel.org>:
>>
>> On Sun, 26 Oct 2025 23:39:56 +0800 you wrote:
>>> In the discussion thread
>>> "[PATCH bpf-next v9 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps"[1],
>>> it was pointed out that missing calls to bpf_obj_free_fields() could
>>> lead to memory leaks.
>>>
>>> A selftest was added to confirm that this is indeed a real issue - the
>>> refcount of BPF_KPTR_REF field is not decremented when
>>> bpf_obj_free_fields() is missing after copy_map_value[,_long]().
>>>
>>> [...]
>>
>> Here is the summary with links:
>>   - [bpf,v3,1/4] bpf: Free special fields when update [lru_,]percpu_hash maps
>>     https://git.kernel.org/bpf/bpf-next/c/f6de8d643ff1
>>   - [bpf,v3,2/4] bpf: Free special fields when update hash maps with BPF_F_LOCK
>>     https://git.kernel.org/bpf/bpf-next/c/c7fcb7972196
>>   - [bpf,v3,3/4] bpf: Free special fields when update local storage maps
>>     (no matching commit)
>>   - [bpf,v3,4/4] selftests/bpf: Add tests to verify freeing the special fields when update hash and local storage maps
>>     https://git.kernel.org/bpf/bpf-next/c/d5a7e7af14cc
>>
>
> Ok, I had to drop this from bpf-next after all. First,
> kptr_refcount_leak/cgroup_storage_refcount_leak needs to be adjusted
> due to that one line removal in patch 3.

Ack.

>
> But what's worse, we started getting deadlock warning when running one
> of the tests, see [0]:
>

Oops.

> [  418.260323] bpf_testmod: oh no, recursing into test_1, recursion_misses 1
>   [  424.982201]
>   [  424.982207] ================================
>   [  424.982216] WARNING: inconsistent lock state
>   [  424.982219] 6.18.0-rc1-gbb1b9387787c-dirty #1 Tainted: G        W  OE
>   [  424.982221] --------------------------------
>   [  424.982223] inconsistent {INITIAL USE} -> {IN-NMI} usage.
>   [  424.982225] new_name/11207 [HC1[1]:SC0[0]:HE0:SE1] takes:
>   [  424.982229] ffffe8ffffd9c000 (&loc_l->lock){....}-{2:2}, at:
> bpf_lru_pop_free+0x2c6/0x1a50
>   [  424.982244] {INITIAL USE} state was registered at:
>   [  424.982246]   lock_acquire+0x154/0x2d0
>   [  424.982252]   _raw_spin_lock_irqsave+0x39/0x60
>   [  424.982259]   bpf_lru_pop_free+0x2c6/0x1a50
>   [  424.982262]   htab_lru_map_update_elem+0x17e/0xa90
>   [  424.982266]   bpf_map_update_value+0x5aa/0x1230
>   [  424.982272]   __sys_bpf+0x33b4/0x4ef0
>   [  424.982275]   __x64_sys_bpf+0x78/0xe0
>   [  424.982278]   do_syscall_64+0x6a/0x2f0
>   [  424.982282]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [  424.982287] irq event stamp: 236
>   [  424.982288] hardirqs last  enabled at (235): [<ffffffff959e4e70>]
> do_syscall_64+0x30/0x2f0
>   [  424.982292] hardirqs last disabled at (236): [<ffffffff959e65df>]
> exc_nmi+0x7f/0x110
>   [  424.982296] softirqs last  enabled at (0): [<ffffffff933fe7cf>]
> copy_process+0x1c3f/0x6ab0
>   [  424.982302] softirqs last disabled at (0): [<0000000000000000>] 0x0
>   [  424.982305]
>   [  424.982305] other info that might help us debug this:
>   [  424.982306]  Possible unsafe locking scenario:
>   [  424.982306]
>   [  424.982307]        CPU0
>   [  424.982308]        ----
>   [  424.982309]   lock(&loc_l->lock);
>   [  424.982311]   <Interrupt>
>   [  424.982312]     lock(&loc_l->lock);
>   [  424.982314]
>   [  424.982314]  *** DEADLOCK ***
>   [  424.982314]
>   [  424.982315] no locks held by new_name/11207.
>   [  424.982317]
>   [  424.982317] stack backtrace:
>   [  424.982326] CPU: 1 UID: 0 PID: 11207 Comm: new_name Tainted: G
>     W  OE       6.18.0-rc1-gbb1b9387787c-dirty #1 PREEMPT(full)
>   [  424.982332] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>   [  424.982334] Hardware name: QEMU Ubuntu 25.04 PC (i440FX + PIIX,
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   [  424.982337] Call Trace:
>   [  424.982340]  <NMI>
>   [  424.982342]  dump_stack_lvl+0x5d/0x80
>   [  424.982356]  print_usage_bug.part.0+0x22b/0x2c0
>   [  424.982360]  lock_acquire+0x278/0x2d0
>   [  424.982364]  ? __irq_work_queue_local+0x133/0x360
>   [  424.982371]  ? bpf_lru_pop_free+0x2c6/0x1a50
>   [  424.982375]  _raw_spin_lock_irqsave+0x39/0x60
>   [  424.982379]  ? bpf_lru_pop_free+0x2c6/0x1a50
>   [  424.982382]  bpf_lru_pop_free+0x2c6/0x1a50

Right, this is the classic NMI vs spinlock deadlock:

Process Context (CPU 0)         NMI Context (CPU 0)
=======================         ===================

    syscall()
       |
       +-> htab_lru_map_update_elem()
       |
       +-> bpf_lru_pop_free()
       |
       +-> spin_lock_irqsave(&lock)
       |   +-------------------+
       |   | LOCK ACQUIRED [Y] |
       |   | IRQs DISABLED     |
       |   +-------------------+
       |
       +-> [Critical Section]
       |   |
       |   | Working with LRU...
       |   |
       |   |                      +-----------------------+
       |   |<---------------------+ ! NMI FIRES!          |
       |   |                      +-----------------------+
       |   |                      | (IRQs disabled but    |
       |   |                      |  NMI ignores that!)   |
       |   |                      +-----------------------+
       |   |                                 |
       |   | [INTERRUPTED]                   |
       |   | [Context saved]                 |
       |   |                                 v
       |   |                     perf_event_nmi_handler()
       |   |                                 |
       |   |                                 +-> BPF program
       |   |                                 |
       |   |                                 +-> htab_lru_map_
       |   |                                 |   update_elem()
       |   |                                 |
       |   |                                 +-> bpf_lru_pop_
       |   |                                 |   free()
       |   |                                 |
       |   |                                 +-> spin_lock_
       |   |                                 |   irqsave(&lock)
       |   |                                 |   +------------+
       |   |                                 |   | TRIES TO   |
       |   |                                 |   | ACQUIRE    |
       |   |                                 |   | SAME LOCK! |
       |   |                                 |   +------------+
       |   |                                 |        |
       |   |                                 |        v
       |   |                                 |   +------------+
       |   |<--------------------------------+---+ ! DEADLOCK |
       |   |                                 |   +------------+
       |   |                                 |   | Lock held  |
       |   | Still holding lock...           |   | by process |
       |   | Waiting for NMI to finish ---+  |   | context    |
       |   |                              |  |   |            |
       |   |                              |  |   | NMI waits  |
       |   |                              |  |   | for same   |
       |   |                              |  |   | lock       |
       |   |                              |  |   +------------+
       |   |                              |  |        |
       |   |                              |  |        v
       |   |                              |  |   [Spin forever]
       |   |                              |  |        |
       |   |                              |  +--------+
       |   |                              |  (Circular wait)
       |   |                              |
       |   |                              +-> SYSTEM HUNG
       |   |
       |   +-> [Never reached]
       |
       +-> spin_unlock_irqrestore(&lock)
           [Never reached]


+---------------------------------------------------------------------+
|                       DEADLOCK SUMMARY                              |
+---------------------------------------------------------------------+
|                                                                     |
| Process Context: Holds &loc_l->lock, waiting for NMI to finish      |
|                                                                     |
| NMI Context:     Trying to acquire &loc_l->lock                     |
|                  (same lock, same CPU)                              |
|                                                                     |
| Result:          Both contexts wait for each other = DEADLOCK       |
|                                                                     |
+---------------------------------------------------------------------+

We can fix this by converting the raw_spinlock_t to trylock-based
approach, similar to the fix for ringbuf in
commit a650d38915c1 ("bpf: Convert ringbuf map to rqspinlock").

In bpf_common_lru_pop_free(), we could use:

    if (!raw_res_spin_lock_irqsave(&loc_l->lock, flags))
        return NULL;

However, this deadlock is pre-existing and not introduced by this
series. It's better to send a separate fix for this deadlock.

Hi Menglong, could you follow up on the deadlock fix?

Thanks,
Leon

>   [  424.982387]  ? arch_irq_work_raise+0x3f/0x60
>   [  424.982394]  ? __pfx___irq_work_queue_local+0x10/0x10
>   [  424.982399]  htab_lru_map_update_elem+0x17e/0xa90
>   [  424.982405]  ? __pfx_htab_lru_map_update_elem+0x10/0x10
>   [  424.982408]  ? __kasan_check_byte+0x16/0x60
>   [  424.982414]  ? __htab_map_lookup_elem+0x95/0x220
>   [  424.982420]  bpf_prog_2c77131b3c031599_oncpu_lru_map+0xe4/0x168
>   [  424.982423]  __perf_event_overflow+0x8e8/0xea0
>   [  424.982430]  ? __pfx___perf_event_overflow+0x10/0x10
>   [  424.982436]  handle_pmi_common+0x3fe/0x810
>   [  424.982441]  ? __pfx_handle_pmi_common+0x10/0x10
>   [  424.982452]  ? __pfx_intel_bts_interrupt+0x10/0x10
>   [  424.982458]  intel_pmu_handle_irq+0x1c5/0x5d0
>   [  424.982461]  ? lock_acquire+0x1ef/0x2d0
>   [  424.982465]  ? nmi_handle.part.0+0x2f/0x380
>   [  424.982469]  perf_event_nmi_handler+0x3e/0x70
>   [  424.982476]  nmi_handle.part.0+0x13f/0x380
>   [  424.982480]  ? trace_rcu_watching+0x105/0x170
>   [  424.982486]  default_do_nmi+0x3b/0x110
>   [  424.982490]  ? irqentry_nmi_enter+0x6f/0x80
>   [  424.982493]  exc_nmi+0xe3/0x110
>   [  424.982497]  end_repeat_nmi+0xf/0x53
>   [  424.982502] RIP: 0010:fput_close_sync+0x56/0x1a0
>   [  424.982509] Code: 48 89 e5 48 c7 04 24 b3 8a b5 41 48 c7 44 24 08
> 5c a2 3e 96 48 c1 ed 03 48 c7 44 24 10 10 a7 e0 93 42 c7 44 2d 00 f1
> f1 f1 f1 <42> c7 44 2d 04 00 f3 f3 f3 65 48 8b 05 91 98 56 04 48 89 44
> 24 58
>   [  424.982513] RSP: 0018:ffffc900099d7e88 EFLAGS: 00000a06
>   [  424.982517] RAX: 0000000000000000 RBX: ffff888109fb48c0 RCX:
> 0000000000000000
>   [  424.982520] RDX: 1ffff110099572bb RSI: 0000000000000008 RDI:
> ffff888109fb4a20
>   [  424.982522] RBP: 1ffff9200133afd1 R08: ffff888109fb48c0 R09:
> ffff888109278b40
>   [  424.982524] R10: ffff888109fb4920 R11: 0000000000000000 R12:
> 0000000000000003
>   [  424.982526] R13: dffffc0000000000 R14: 0000000000000003 R15:
> 0000000000000000
>   [  424.982532]  ? fput_close_sync+0x56/0x1a0
>   [  424.982537]  ? fput_close_sync+0x56/0x1a0
>   [  424.982541]  </NMI>
>   [  424.982542]  <TASK>
>   [  424.982544]  ? __pfx_fput_close_sync+0x10/0x10
>   [  424.982548]  ? do_raw_spin_unlock+0x59/0x250
>   [  424.982553]  __x64_sys_close+0x7d/0xd0
>   [  424.982559]  do_syscall_64+0x6a/0x2f0
>   [  424.982563]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [  424.982566] RIP: 0033:0x7faae0f88fe2
>   [  424.982569] Code: 08 0f 85 71 3a ff ff 49 89 fb 48 89 f0 48 89 d7
> 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24
> 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00
> 00 66
>   [  424.982571] RSP: 002b:00007ffe58ee5b08 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
>   [  424.982574] RAX: ffffffffffffffda RBX: 00007faae0a6cb00 RCX:
> 00007faae0f88fe2
>   [  424.982577] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000072
>   [  424.982579] RBP: 00007ffe58ee5b30 R08: 0000000000000000 R09:
> 0000000000000000
>   [  424.982581] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000008
>   [  424.982583] R13: 0000000000000000 R14: 0000556f5e250c90 R15:
> 00007faae11e9000
>   [  424.982588]  </TASK>
>   [  424.982606] perf: interrupt took too long (14417 > 12551),
> lowering kernel.perf_event_max_sample_rate to 13000
>
> We'll need to figure this out first.
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/18884827710/job/53898669092
>
>> You are awesome, thank you!
>> --
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>
>>

