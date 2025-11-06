Return-Path: <bpf+bounces-73772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BAC38D50
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 03:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5CD4E1436
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D1238149;
	Thu,  6 Nov 2025 02:14:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9DF1BBBE5
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395273; cv=none; b=d7aavdGQQV/SrnqHmhaY+tebSVrSTw5RdN4R/PKHmbUeY/5O+oodxkVDAYvQx/uoPPMLOic1kWejmlVX3WPz10Zn+OlZ9ytHe5nRt/AhszoUS6IzuDa63ZonbheOepgi0V5NNqZjCicE3Y1xHMA4QZC7pHdTRV1mw4JILs2BikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395273; c=relaxed/simple;
	bh=1sFdyW9qRISVAMYUOyXqr12NEvALF0ncq6EI6DWkUzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0KergJsZrytRy9V5/X7czIBaH/tAdxIAQJwxxJER259W8qGF3+as2oKr+ZgMW1YuL7sJfAlC8ueKyPgLvJMg2Sl0P28yGZkJY7jmRcworrI4V+PNBem3Cab2IuxkBtkd+VG6pOn1FXWd+WiVD4AfwrS1zdIAKal7Uyp7d/iAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d25NJ3qRxzYQtyT
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 10:14:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2C8A81A0847
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 10:14:26 +0800 (CST)
Received: from [10.67.108.204] (unknown [10.67.108.204])
	by APP1 (Coremail) with SMTP id cCh0CgCH90p+BAxpuP5ICw--.12892S2;
	Thu, 06 Nov 2025 10:14:23 +0800 (CST)
Message-ID: <6a8bb167-17af-471d-aaaa-9219a7c41583@huaweicloud.com>
Date: Thu, 6 Nov 2025 10:14:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20251105100302.2968475-1-pulehui@huaweicloud.com>
 <a0acd787192bef94c7da88c40c4693bc67876b32.camel@gmail.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <a0acd787192bef94c7da88c40c4693bc67876b32.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCH90p+BAxpuP5ICw--.12892S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWfXw4Utr1UurW7uw47XFb_yoWfXr1UpF
	yrJa1UCr48G348Jr4fAr4jgr43Jan2y3W8Ar97tr4FqF4YqrykXFyUGw42kF9I9r1kAr17
	J3WUZ3s0yryqyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/11/6 7:33, Eduard Zingerman wrote:
> On Wed, 2025-11-05 at 10:03 +0000, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Syzkaller triggers an invalid memory access issue following fault
>> injection in update_effective_progs. The issue can be described as
>> follows:
>>
>> __cgroup_bpf_detach
>>    update_effective_progs
>>      compute_effective_progs
>>        bpf_prog_array_alloc <-- fault inject
>>    purge_effective_progs
>>      /* change to dummy_bpf_prog */
>>      array->items[index] = &dummy_bpf_prog.prog
>>
>> ---softirq start---
>> __do_softirq
>>    ...
>>      __cgroup_bpf_run_filter_skb
>>        __bpf_prog_run_save_cb
>>          bpf_prog_run
>>            stats = this_cpu_ptr(prog->stats)
>>            /* invalid memory access */
>>            flags = u64_stats_update_begin_irqsave(&stats->syncp)
>> ---softirq end---
>>
>>    static_branch_dec(&cgroup_bpf_enabled_key[atype])
>>
>> The reason is that fault injection caused update_effective_progs to fail
>> and then changed the original prog into dummy_bpf_prog.prog in
>> purge_effective_progs. Then a softirq came, and accessing the members of
>> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
>>
>> To fix it, we can skip executing the prog when it's dummy_bpf_prog.prog.
>>
>> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Is there a link for syzkaller report?


Hi Eduard,

This is a local syzkaller test, and I have attached the report at the 
end of the email.

> 
> [...]
> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 248f517d66d0..baad33b34cef 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -77,7 +77,9 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>>   	item = &array->items[0];
>>   	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>   	while ((prog = READ_ONCE(item->prog))) {
>> -		run_ctx.prog_item = item;
>> +		run_ctx.prog_item = item++;
>> +		if (prog == &dummy_bpf_prog.prog)
>> +			continue;
> 
> Will the following fix the issue?
> 
>      diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>      index d595fe512498..c7c9c78f171a 100644
>      --- a/kernel/bpf/core.c
>      +++ b/kernel/bpf/core.c
>      @@ -2536,11 +2536,14 @@ static unsigned int __bpf_prog_ret1(const void *ctx,
>              return 1;
>       }
> 
>      +DEFINE_PER_CPU(struct bpf_prog_stats, __dummy_stats);
>      +
>       static struct bpf_prog_dummy {
>              struct bpf_prog prog;
>       } dummy_bpf_prog = {
>              .prog = {
>                      .bpf_func = __bpf_prog_ret1,
>      +               .stats = &__dummy_stats,
>              },
>       };
> 
> Or that's too much memory wasted?

In 160 cores system, it will waste 5K bytes for this dummy.

And also, this solution will not suit for 5.10.0 or lower LTS version, 
as the bpf_prog_stats is embedded in struct bpf_prog_aux, and bpf->aux 
is empty at this time, which will trigger a null pointer access.

> 
> [...]
Report:

[  120.618153][ T3281] FAULT_INJECTION: forcing a failure.
[  120.618153][ T3281] name failslab, interval 1, probability 0, space 
0, times 0
[  120.619946][ T3281] CPU: 1 UID: 0 PID: 3281 Comm: syz.3.476 Not 
tainted 6.18.0-rc4+ #48 PREEMPT(voluntary)
[  120.619967][ T3281] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  120.619979][ T3281] Call Trace:
[  120.619984][ T3281]  <TASK>
[  120.619993][ T3281]  dump_stack_lvl+0xfa/0x120
[  120.620017][ T3281]  should_fail_ex+0x162/0x170
[  120.620049][ T3281]  should_failslab+0x49/0x70
[  120.620071][ T3281]  __kmalloc_noprof+0xcd/0x870
[  120.620092][ T3281]  ? bpf_prog_array_alloc+0x4b/0x60
[  120.620117][ T3281]  ? bpf_prog_array_alloc+0x4b/0x60
[  120.620133][ T3281]  ? prog_list_length.isra.0+0x71/0xa0
[  120.620155][ T3281]  bpf_prog_array_alloc+0x4b/0x60
[  120.620174][ T3281]  compute_effective_progs+0xc1/0x350
[  120.620212][ T3281]  update_effective_progs+0x61/0x1a0
[  120.620239][ T3281]  __cgroup_bpf_detach+0x147/0x340
[  120.620269][ T3281]  bpf_cgroup_link_release.part.0+0x44/0x2d0
[  120.620297][ T3281]  bpf_cgroup_link_release+0x26/0x30
[  120.620322][ T3281]  bpf_link_free+0x6e/0x120
[  120.620351][ T3281]  ? __pfx_bpf_link_release+0x10/0x10
[  120.620379][ T3281]  bpf_link_release+0x39/0x50
[  120.620416][ T3281]  __fput+0x1e3/0x510
[  120.620450][ T3281]  task_work_run+0x9e/0x100
[  120.620481][ T3281]  do_exit+0x2f9/0x820
[  120.620505][ T3281]  ? get_signal+0x4fc/0xf50
[  120.620525][ T3281]  ? __lock_release.isra.0+0x5d/0x170
[  120.620553][ T3281]  do_group_exit+0x59/0xf0
[  120.620582][ T3281]  get_signal+0xf1d/0xf50
[  120.620619][ T3281]  arch_do_signal_or_restart+0x34/0x1b0
[  120.620651][ T3281]  ? __x64_sys_futex+0xbe/0x300
[  120.620680][ T3281]  ? __x64_sys_futex+0xc7/0x300
[  120.620712][ T3281]  ? fput+0x5a/0xf0
[  120.620742][ T3281]  exit_to_user_mode_loop+0xa4/0x160
[  120.620773][ T3281]  do_syscall_64+0x1f2/0x5a0
[  120.620804][ T3281]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  120.620823][ T3281] RIP: 0033:0x7f494a7b772d
[  120.620835][ T3281] Code: Unable to access opcode bytes at 
0x7f494a7b7703.
[  120.620843][ T3281] RSP: 002b:00007f494b61cc48 EFLAGS: 00000246 
ORIG_RAX: 00000000000000ca
[  120.620858][ T3281] RAX: fffffffffffffe00 RBX: 00007f494a9e5fa0 RCX: 
00007f494a7b772d
[  120.620870][ T3281] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
00007f494a9e5fa8
[  120.620880][ T3281] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[  120.620890][ T3281] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007f494a9e5fa8
[  120.620901][ T3281] R13: 00007f494a9e5fac R14: 00007f494a9e6038 R15: 
00007f494b61cd40
...
[  120.653922][ T2249] BUG: unable to handle page fault for address: 
ffff8882b2cf2000
[  120.654996][ T2249] #PF: supervisor write access in kernel mode
[  120.655843][ T2249] #PF: error_code(0x0002) - not-present page
[  120.656678][ T2249] PGD e201067 P4D e201067 PUD 0
[  120.657380][ T2249] Oops: Oops: 0002 [#1] SMP PTI
[  120.658069][ T2249] CPU: 1 UID: 0 PID: 2249 Comm: kworker/1:5 Not 
tainted 6.18.0-rc4+ #48 PREEMPT(voluntary)
[  120.659466][ T2249] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  120.661153][ T2249] Workqueue: mld mld_ifc_work
[  120.661821][ T2249] RIP: 0010:__bpf_prog_run_save_cb+0xe8/0x160
[  120.662682][ T2249] Code: 6a b3 ff 48 8d 73 60 48 89 ef 49 89 c5 48 
8b 43 48 e8 9c 81 6a 05 41 89 c4 e8 a4 6a b3 ff 48 8b 53 38 65 48 03 15 
b0 38 78 0b <48> ff 02 4c 29 e8 48 01 42 08 e9 79 ff ff ff e8 54 0db
[  120.665354][ T2249] RSP: 0018:ffffc90003f5fb38 EFLAGS: 00010286
[  120.666204][ T2249] RAX: 0000001c19e24793 RBX: ffffffff89710ee0 RCX: 
ffffffff813d923e
[  120.667309][ T2249] RDX: ffff8882b2cf2000 RSI: ffffffff813d9247 RDI: 
0000000000000001
[  120.668417][ T2249] RBP: ffff8881072b3c00 R08: 0000000000000001 R09: 
0000000000000000
[  120.669522][ T2249] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000001
[  120.670627][ T2249] R13: 0000001c19e246f0 R14: ffffffff89710ee0 R15: 
0000000000000000
[  120.671734][ T2249] FS:  0000000000000000(0000) 
GS:ffff8882b2cf2000(0000) knlGS:0000000000000000
[  120.672974][ T2249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  120.673899][ T2249] CR2: ffff8882b2cf2000 CR3: 000000010adce000 CR4: 
00000000000006f0
[  120.675001][ T2249] Call Trace:
[  120.675468][ T2249]  <TASK>
[  120.675882][ T2249]  ? lock_is_held_type+0x9e/0x120
[  120.676609][ T2249]  __cgroup_bpf_run_filter_skb+0x488/0xab0
[  120.677444][ T2249]  ip6_finish_output+0x37c/0x8b0
[  120.678148][ T2249]  ip6_output+0x135/0x4b0
[  120.678770][ T2249]  NF_HOOK.constprop.0+0x7f/0x580
[  120.679489][ T2249]  mld_sendpack+0x214/0x500
[  120.680138][ T2249]  mld_send_cr+0x38e/0x630
[  120.680780][ T2249]  mld_ifc_work+0x37/0x150
[  120.681416][ T2249]  process_one_work+0x341/0xa80
[  120.682121][ T2249]  worker_thread+0x2b0/0x560
[  120.682791][ T2249]  ? __pfx_worker_thread+0x10/0x10
[  120.683527][ T2249]  kthread+0x18f/0x370
[  120.684115][ T2249]  ? ret_from_fork+0x2c/0x340
[  120.684788][ T2249]  ? __pfx_kthread+0x10/0x10
[  120.685449][ T2249]  ret_from_fork+0x2d3/0x340
[  120.686105][ T2249]  ? __pfx_kthread+0x10/0x10
[  120.686765][ T2249]  ret_from_fork_asm+0x1a/0x30
[  120.687459][ T2249]  </TASK>
[  120.687888][ T2249] Modules linked in:
[  120.688447][ T2249] CR2: ffff8882b2cf2000
[  120.689031][ T2249] ---[ end trace 0000000000000000 ]---


