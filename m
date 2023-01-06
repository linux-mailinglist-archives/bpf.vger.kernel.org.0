Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6416465FA8B
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 05:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjAFEBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 23:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAFEBU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 23:01:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3FDF60
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 20:01:18 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Np8fC6zJbzqTd9;
        Fri,  6 Jan 2023 11:56:35 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 12:01:16 +0800
Subject: Re: [bpf-next v1] bpf: hash map, suppress lockdep warning
To:     Tonghao Zhang <tong@infragraf.org>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230105112749.38421-1-tong@infragraf.org>
 <785a918e-5908-d999-8eb5-ae749b239d64@huawei.com>
 <323BABB0269C740E+0CA62C2D-131E-4A00-B8FE-C21F74ED068D@infragraf.org>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <848718f8-1070-8cd7-bb01-aa60d11b26c1@huawei.com>
Date:   Fri, 6 Jan 2023 12:01:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <323BABB0269C740E+0CA62C2D-131E-4A00-B8FE-C21F74ED068D@infragraf.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 1/5/2023 10:26 PM, Tonghao Zhang wrote:
>
> ﻿在 2023/1/5 下午8:06，“Hou Tao”<houtao1@huawei.com> 写入:
>
>     Hi,
>
>     On 1/5/2023 7:27 PM, tong@infragraf.org wrote:
>     > From: Tonghao Zhang <tong@infragraf.org>
>     >
>     > The lock may be taken in both NMI and non-NMI contexts.
>     > There is a lockdep warning (inconsistent lock state), if
>     > enable lockdep. For performance, this patch doesn't use trylock,
>     > and disable lockdep temporarily.
>     >
>     > [   82.474075] ================================
>     > [   82.474076] WARNING: inconsistent lock state
>     > [   82.474090] 6.1.0+ #48 Tainted: G            E
>     > [   82.474093] --------------------------------
>     > [   82.474100] inconsistent {INITIAL USE} -> {IN-NMI} usage.
>     > [   82.474101] kprobe-load/1740 [HC1[1]:SC0[0]:HE0:SE1] takes:
>     > [   82.474105] ffff88860a5cf7b0 (&htab->lockdep_key){....}-{2:2}, at: htab_lock_bucket+0x61/0x6c
>     > [   82.474120] {INITIAL USE} state was registered at:
>     > [   82.474122]   mark_usage+0x1d/0x11d
>     > [   82.474130]   __lock_acquire+0x3c9/0x6ed
>     > [   82.474131]   lock_acquire+0x23d/0x29a
>     > [   82.474135]   _raw_spin_lock_irqsave+0x43/0x7f
>     > [   82.474148]   htab_lock_bucket+0x61/0x6c
>     > [   82.474151]   htab_map_update_elem+0x11e/0x220
>     > [   82.474155]   bpf_map_update_value+0x267/0x28e
>     > [   82.474160]   map_update_elem+0x13e/0x17d
>     > [   82.474164]   __sys_bpf+0x2ae/0xb2e
>     > [   82.474167]   __do_sys_bpf+0xd/0x15
>     > [   82.474171]   do_syscall_64+0x6d/0x84
>     > [   82.474174]   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>     > [   82.474178] irq event stamp: 1496498
>     > [   82.474180] hardirqs last  enabled at (1496497): [<ffffffff817eb9d9>] syscall_enter_from_user_mode+0x63/0x8d
>     > [   82.474184] hardirqs last disabled at (1496498): [<ffffffff817ea6b6>] exc_nmi+0x87/0x109
>     > [   82.474187] softirqs last  enabled at (1446698): [<ffffffff81a00347>] __do_softirq+0x347/0x387
>     > [   82.474191] softirqs last disabled at (1446693): [<ffffffff810b9b06>] __irq_exit_rcu+0x67/0xc6
>     > [   82.474195]
>     > [   82.474195] other info that might help us debug this:
>     > [   82.474196]  Possible unsafe locking scenario:
>     > [   82.474196]
>     > [   82.474197]        CPU0
>     > [   82.474198]        ----
>     > [   82.474198]   lock(&htab->lockdep_key);
>     > [   82.474200]   <Interrupt>
>     > [   82.474200]     lock(&htab->lockdep_key);
>     > [   82.474201]
>     > [   82.474201]  *** DEADLOCK ***
>     > [   82.474201]
>     > [   82.474202] no locks held by kprobe-load/1740.
>     > [   82.474203]
>     > [   82.474203] stack backtrace:
>     > [   82.474205] CPU: 14 PID: 1740 Comm: kprobe-load Tainted: G            E      6.1.0+ #48
>     > [   82.474208] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>     > [   82.474213] Call Trace:
>     > [   82.474218]  <NMI>
>     > [   82.474224]  dump_stack_lvl+0x57/0x81
>     > [   82.474228]  lock_acquire+0x1f4/0x29a
>     > [   82.474233]  ? htab_lock_bucket+0x61/0x6c
>     > [   82.474237]  ? rcu_read_lock_held_common+0xe/0x38
>     > [   82.474245]  _raw_spin_lock_irqsave+0x43/0x7f
>     > [   82.474249]  ? htab_lock_bucket+0x61/0x6c
>     > [   82.474253]  htab_lock_bucket+0x61/0x6c
>     > [   82.474257]  htab_map_update_elem+0x11e/0x220
>     > [   82.474264]  bpf_prog_df326439468c24a9_bpf_prog1+0x41/0x45
>     > [   82.474276]  bpf_trampoline_6442457183_0+0x43/0x1000
>     > [   82.474283]  nmi_handle+0x5/0x254
>     > [   82.474289]  default_do_nmi+0x3d/0xf6
>     > [   82.474293]  exc_nmi+0xa1/0x109
>     > [   82.474297]  end_repeat_nmi+0x16/0x67
>     > [   82.474300] RIP: 0010:cpu_online+0xa/0x12
>   
SNIP
>     > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>     > index 974f104f47a0..146433c9bd1a 100644
>     > --- a/kernel/bpf/hashtab.c
>     > +++ b/kernel/bpf/hashtab.c
>     > @@ -161,6 +161,19 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>     >  		return -EBUSY;
>     >  	}
>     >  
>     > +	/*
>     > +	 * The lock may be taken in both NMI and non-NMI contexts.
>     > +	 * There is a lockdep warning (inconsistent lock state), if
>     > +	 * enable lockdep. The potential deadlock happens when the
>     > +	 * lock is contended from the same cpu. map_locked rejects
>     > +	 * concurrent access to the same bucket from the same CPU.
>     > +	 * When the lock is contended from a remote cpu, we would
>     > +	 * like the remote cpu to spin and wait, instead of giving
>     > +	 * up immediately. As this gives better throughput. So replacing
>     > +	 * the current raw_spin_lock_irqsave() with trylock sacrifices
>     > +	 * this performance gain. lockdep_off temporarily.
>     > +	 */
>     > +	lockdep_off();
>     >  	raw_spin_lock_irqsave(&b->raw_lock, flags);
>     >  	*pflags = flags;
>     Only use lockdep_off() and lockdep_on() to wrap
>     raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() will be enough.
> Hi Do you mean that:
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 974f104f47a0..cae4417a3894 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -161,7 +161,9 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>                 return -EBUSY;
>         }
>
> +       lockdep_off();
>         raw_spin_lock_irqsave(&b->raw_lock, flags);
> +       lockdep_on();
>         *pflags = flags;
>
>         return 0;
> @@ -172,7 +174,11 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>                                       unsigned long flags)
>  {
>         hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
> +
> +       lockdep_off();
>         raw_spin_unlock_irqrestore(&b->raw_lock, flags);
> +       lockdep_on();
> +
Yes.
>         __this_cpu_dec(*(htab->map_locked[hash]));
>         preempt_enable();
>  }
>
> This way, do we off/on the lockdep frequently. ? Thai is why I off the lockdep in htab_lock_bucket and on it again in htab_unlock_bucket.
The performance will not be a problem because the purpose of LOCKDEP is for
debugging. Also the implementation of lockdep_off() is trivial, it only
increases current->lockdep_recursion.

And beside using lockdep_off() and lockdep_on() to disable checking on bucket
spin lock, we also need to add lock_acquire() and lock_release() before calling
__this_cpu_inc_return() and __this_cpu_dec().
>
>
>     >  
>     > @@ -172,7 +185,10 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>     >  				      unsigned long flags)
>     >  {
>     >  	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>     > +
>     >  	raw_spin_unlock_irqrestore(&b->raw_lock, flags);
>     > +	lockdep_on();
>     > +
>     >  	__this_cpu_dec(*(htab->map_locked[hash]));
>     >  	preempt_enable();
>     >  }
>
>
>
>
>
> .

