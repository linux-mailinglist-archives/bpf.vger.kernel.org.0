Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7594766370C
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 03:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAJCCH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 9 Jan 2023 21:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjAJCCF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 21:02:05 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46E19281
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 18:01:52 -0800 (PST)
X-QQ-mid: bizesmtp76t1673316088txxif9ex
Received: from smtpclient.apple ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 10 Jan 2023 10:01:26 +0800 (CST)
X-QQ-SSF: 01000000000000708000000A0000000
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [bpf-next v1] bpf: hash map, suppress lockdep warning
From:   Tonghao Zhang <tong@infragraf.org>
In-Reply-To: <bfca0dc4-dd69-2bb1-5f61-b6cdd5e4d5ea@huawei.com>
Date:   Tue, 10 Jan 2023 10:01:25 +0800
Cc:     Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <742CC2BA-EF20-42CC-A760-24D480007E9A@infragraf.org>
References: <20230105112749.38421-1-tong@infragraf.org>
 <6004bbc1-54a8-0141-04af-0a5fba82e6ee@huawei.com>
 <a13aed2a-9033-5176-64ce-4e3429bba6f4@huawei.com>
 <E9EDA733-793B-4B39-AA82-34D3CB419E01@infragraf.org>
 <bfca0dc4-dd69-2bb1-5f61-b6cdd5e4d5ea@huawei.com>
To:     Hou Tao <houtao1@huawei.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 9, 2023, at 5:12 PM, Hou Tao <houtao1@huawei.com> wrote:
> 
> Hi,
> 
> On 1/9/2023 2:10 PM, Tonghao Zhang wrote:
>> 
>>> On Jan 6, 2023, at 12:19 PM, Hou Tao <houtao1@huawei.com> wrote:
>>> 
>>> Hi,
>>> 
>>> On 1/6/2023 10:13 AM, Xu Kuohai wrote:
>>>> On 1/5/2023 7:27 PM, tong@infragraf.org wrote:
>>>>> From: Tonghao Zhang <tong@infragraf.org>
>>>>> 
>>>>> The lock may be taken in both NMI and non-NMI contexts.
>>>>> There is a lockdep warning (inconsistent lock state), if
>>>>> enable lockdep. For performance, this patch doesn't use trylock,
>>>>> and disable lockdep temporarily.
>>>>> 
>>>>> [   82.474075] ================================
>>>>> [   82.474076] WARNING: inconsistent lock state
>>>>> [   82.474090] 6.1.0+ #48 Tainted: G            E
>>>>> [   82.474093] --------------------------------
>>>>> [   82.474100] inconsistent {INITIAL USE} -> {IN-NMI} usage.
>>>>> [   82.474101] kprobe-load/1740 [HC1[1]:SC0[0]:HE0:SE1] takes:
>>>>> [   82.474105] ffff88860a5cf7b0 (&htab->lockdep_key){....}-{2:2}, at:
>>>>> htab_lock_bucket+0x61/0x6c
>>>>> [   82.474120] {INITIAL USE} state was registered at:
>>>>> [   82.474122]   mark_usage+0x1d/0x11d
>>>>> [   82.474130]   __lock_acquire+0x3c9/0x6ed
>>>>> [   82.474131]   lock_acquire+0x23d/0x29a
>>>>> [   82.474135]   _raw_spin_lock_irqsave+0x43/0x7f
>>>>> [   82.474148]   htab_lock_bucket+0x61/0x6c
>>>>> [   82.474151]   htab_map_update_elem+0x11e/0x220
>>>>> [   82.474155]   bpf_map_update_value+0x267/0x28e
>>>>> [   82.474160]   map_update_elem+0x13e/0x17d
>>>>> [   82.474164]   __sys_bpf+0x2ae/0xb2e
>>>>> [   82.474167]   __do_sys_bpf+0xd/0x15
>>>>> [   82.474171]   do_syscall_64+0x6d/0x84
>>>>> [   82.474174]   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>> [   82.474178] irq event stamp: 1496498
>>>>> [   82.474180] hardirqs last  enabled at (1496497): [<ffffffff817eb9d9>]
>>>>> syscall_enter_from_user_mode+0x63/0x8d
>>>>> [   82.474184] hardirqs last disabled at (1496498): [<ffffffff817ea6b6>]
>>>>> exc_nmi+0x87/0x109
>>>>> [   82.474187] softirqs last  enabled at (1446698): [<ffffffff81a00347>]
>>>>> __do_softirq+0x347/0x387
>>>>> [   82.474191] softirqs last disabled at (1446693): [<ffffffff810b9b06>]
>>>>> __irq_exit_rcu+0x67/0xc6
>>>>> [   82.474195]
>>>>> [   82.474195] other info that might help us debug this:
>>>>> [   82.474196]  Possible unsafe locking scenario:
>>>>> [   82.474196]
>>>>> [   82.474197]        CPU0
>>>>> [   82.474198]        ----
>>>>> [   82.474198]   lock(&htab->lockdep_key);
>>>>> [   82.474200]   <Interrupt>
>>>>> [   82.474200]     lock(&htab->lockdep_key);
>>>>> [   82.474201]
>>>>> [   82.474201]  *** DEADLOCK ***
>>>>> [   82.474201]
>>>>> [   82.474202] no locks held by kprobe-load/1740.
>>>>> [   82.474203]
>>>>> [   82.474203] stack backtrace:
>>>>> [   82.474205] CPU: 14 PID: 1740 Comm: kprobe-load Tainted: G           
>>>>> E      6.1.0+ #48
>>>>> [   82.474208] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>>>> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>>>>> [   82.474213] Call Trace:
>>>>> [   82.474218]  <NMI>
>>>>> [   82.474224]  dump_stack_lvl+0x57/0x81
>>>>> [   82.474228]  lock_acquire+0x1f4/0x29a
>>>>> [   82.474233]  ? htab_lock_bucket+0x61/0x6c
>>>>> [   82.474237]  ? rcu_read_lock_held_common+0xe/0x38
>>>>> [   82.474245]  _raw_spin_lock_irqsave+0x43/0x7f
>>>>> [   82.474249]  ? htab_lock_bucket+0x61/0x6c
>>>>> [   82.474253]  htab_lock_bucket+0x61/0x6c
>>>>> [   82.474257]  htab_map_update_elem+0x11e/0x220
>>>>> [   82.474264]  bpf_prog_df326439468c24a9_bpf_prog1+0x41/0x45
>>>>> [   82.474276]  bpf_trampoline_6442457183_0+0x43/0x1000
>>>>> [   82.474283]  nmi_handle+0x5/0x254
>>>>> [   82.474289]  default_do_nmi+0x3d/0xf6
>>>>> [   82.474293]  exc_nmi+0xa1/0x109
>>>>> [   82.474297]  end_repeat_nmi+0x16/0x67
>>>>> [   82.474300] RIP: 0010:cpu_online+0xa/0x12
>>>>> [   82.474308] Code: 08 00 00 00 39 c6 0f 43 c6 83 c0 07 83 e0 f8 c3 cc cc cc
>>>>> cc 0f 1f 44 00 00 31 c0 c3 cc cc cc cc 89 ff 48 0f a3 3d 5f 52 75 01 <0f> 92
>>>>> c0 c3 cc cc cc cc 55 48 89 e5 41 57 49 89 f7 41 56 49 896
>>>>> [   82.474310] RSP: 0018:ffffc9000131bd38 EFLAGS: 00000283
>>>>> [   82.474313] RAX: ffff88860b85fe78 RBX: 0000000000102cc0 RCX: 0000000000000008
>>>>> [   82.474315] RDX: 0000000000000004 RSI: ffff88860b85fe78 RDI: 000000000000000e
>>>>> [   82.474316] RBP: 00000000ffffffff R08: 0000000000102cc0 R09: 00000000ffffffff
>>>>> [   82.474318] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888100042200
>>>>> [   82.474320] R13: 0000000000000004 R14: ffffffff81271dc2 R15: ffff88860b85fe78
>>>>> [   82.474322]  ? kvmalloc_node+0x44/0xd2
>>>>> [   82.474333]  ? cpu_online+0xa/0x12
>>>>> [   82.474338]  ? cpu_online+0xa/0x12
>>>>> [   82.474342]  </NMI>
>>>>> [   82.474343]  <TASK>
>>>>> [   82.474343]  trace_kmalloc+0x7c/0xe6
>>>>> [   82.474347]  ? kvmalloc_node+0x44/0xd2
>>>>> [   82.474350]  __kmalloc_node+0x9a/0xaf
>>>>> [   82.474354]  kvmalloc_node+0x44/0xd2
>>>>> [   82.474359]  kvmemdup_bpfptr+0x29/0x66
>>>>> [   82.474363]  map_update_elem+0x119/0x17d
>>>>> [   82.474370]  __sys_bpf+0x2ae/0xb2e
>>>>> [   82.474380]  __do_sys_bpf+0xd/0x15
>>>>> [   82.474384]  do_syscall_64+0x6d/0x84
>>>>> [   82.474387]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>> [   82.474391] RIP: 0033:0x7fe75d4f752d
>>>>> [   82.474394] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89
>>>>> f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>>>>> 01 f0 ff ff 73 01 c3 48 8b 0d 2b 79 2c 00 f7 d8 64 89 018
>>>>> [   82.474396] RSP: 002b:00007ffe95d1cd78 EFLAGS: 00000246 ORIG_RAX:
>>>>> 0000000000000141
>>>>> [   82.474398] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe75d4f752d
>>>>> [   82.474400] RDX: 0000000000000078 RSI: 00007ffe95d1cd80 RDI: 0000000000000002
>>>>> [   82.474401] RBP: 00007ffe95d1ce30 R08: 0000000000000000 R09: 0000000000000004
>>>>> [   82.474403] R10: 00007ffe95d1cd80 R11: 0000000000000246 R12: 00000000004007f0
>>>>> [   82.474405] R13: 00007ffe95d1cf10 R14: 0000000000000000 R15: 0000000000000000
>>>>> [   82.474412]  </TASK>
>>>>> 
>>>>> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
>>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>>>> Cc: Song Liu <song@kernel.org>
>>>>> Cc: Yonghong Song <yhs@fb.com>
>>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>>> Cc: KP Singh <kpsingh@kernel.org>
>>>>> Cc: Stanislav Fomichev <sdf@google.com>
>>>>> Cc: Hao Luo <haoluo@google.com>
>>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>>> Cc: Hou Tao <houtao1@huawei.com>
>>>>> ---
>>>>> previous discussion:
>>>>> https://lore.kernel.org/all/20221121100521.56601-2-xiangxia.m.yue@gmail.com/
>>>>> ---
>>>>>  kernel/bpf/hashtab.c | 16 ++++++++++++++++
>>>>>  1 file changed, 16 insertions(+)
>>>>> 
>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>> index 974f104f47a0..146433c9bd1a 100644
>>>>> --- a/kernel/bpf/hashtab.c
>>>>> +++ b/kernel/bpf/hashtab.c
>>>>> @@ -161,6 +161,19 @@ static inline int htab_lock_bucket(const struct bpf_htab
>>>>> *htab,
>>>>>          return -EBUSY;
>>>>>      }
>>>>>  +    /*
>>>>> +     * The lock may be taken in both NMI and non-NMI contexts.
>>>>> +     * There is a lockdep warning (inconsistent lock state), if
>>>>> +     * enable lockdep. The potential deadlock happens when the
>>>>> +     * lock is contended from the same cpu. map_locked rejects
>>>>> +     * concurrent access to the same bucket from the same CPU.
>>>>> +     * When the lock is contended from a remote cpu, we would
>>>>> +     * like the remote cpu to spin and wait, instead of giving
>>>>> +     * up immediately. As this gives better throughput. So replacing
>>>>> +     * the current raw_spin_lock_irqsave() with trylock sacrifices
>>>>> +     * this performance gain. lockdep_off temporarily.
>>>>> +     */
>>>>> +    lockdep_off();
>>>> seems it's better to define map_locked as a raw spin lock and use
>>>> trylock(map_locked[hash])
>>>> to check if this cpu has locked the bucket.
>>> Redefining map_locked as per-cpu raw spinlock array seems a good idea, so we
>> Yes, one question, do this drop performance compared with atomic.
> According to the implementation on x86-64, __this_cpu_inc_return() uses xadd()
> and raw_spin_trylock() uses preempt_disable() and atomic_try_cmpxchg_acquire()
> to do its work, so it seems that __this_cpu_inc_return() will be cheaper. But
> not sure whether or not the performance of htab update will be influenced.
>>> don't need to call lock_acquire() and lock_release() manually. But lockdep_off()
>>> is still needed here, else there will always be lockdep warning.
> Considering lockdep_off() is always needed here, maybe only using lockdep_off()
> and lockdep_on() will be enough ?
Yes, I think it’s enough to fix this warning.
>>>>>      raw_spin_lock_irqsave(&b->raw_lock, flags);
>>>>>      *pflags = flags;
>>>>>  @@ -172,7 +185,10 @@ static inline void htab_unlock_bucket(const struct
>>>>> bpf_htab *htab,
>>>>>                        unsigned long flags)
>>>>>  {
>>>>>      hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>>>>> +
>>>>>      raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>>>>> +    lockdep_on();
>>>>> +
>>>>>      __this_cpu_dec(*(htab->map_locked[hash]));
>>>>>      preempt_enable();
>>>>>  }
>>>> .
>> 
>> .

