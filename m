Return-Path: <bpf+bounces-30026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA88C9C1B
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E0E28303C
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87C51C40;
	Mon, 20 May 2024 11:30:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BF1B948;
	Mon, 20 May 2024 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716204659; cv=none; b=M+W0yM7cWEP1AvWXlFY3k/6p23DMD52XUzenZNt2V3pDggOGVUn6elX0fNcIVqwl+cKMNrglqPm8cvfvFY4yfs1PawSK5+tpqJb9Uh1O43gXtsDASxbXrZjaDgmJZAluh2vN9zu9mtI5kow0mpFvlllXSPTS67BNcl/YqsHmAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716204659; c=relaxed/simple;
	bh=X/phojaVeuUHKXrMyDkOORqEJcoUYYV9se/Ha00FVqQ=;
	h=Subject:To:References:From:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nUllqiPUhpbow47ieGSoqBKo89QgJEV8CwyXD6r/8+0SfxQY64sZAtqH67uvnhTnbwiqXFO1eE5py/qvbs+/O8jCJVPKZHMgiHFDV6x3X9Y8vMFDXRBttK9XFuaX/PN+xvpUby3ZGtfP0/bViXtPbSfwLJZZzV0yYTX+kwiUYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vjb3P6tzpz4f3lDH;
	Mon, 20 May 2024 19:30:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5AA3B1A016E;
	Mon, 20 May 2024 19:30:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAHav1mNEtmdvUGNg--.4978S2;
	Mon, 20 May 2024 19:30:49 +0800 (CST)
Subject: Re: [syzbot] [bpf?] possible deadlock in get_page_from_freelist
To: syzbot <syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com>
References: <000000000000c051d80616195f15@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Message-ID: <1bb1b6fc-d856-1a1a-bf8f-13a961f72c68@huaweicloud.com>
Date: Mon, 20 May 2024 19:30:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000000000000c051d80616195f15@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAHav1mNEtmdvUGNg--.4978S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jry7Cw1UJrWrGF17WF1DGFg_yoWfJFyfpF
	ZxGrWfAr4Fqa4UZ3yxtr109rWkZw45Gr43GFs7WryrZF1avry7Krs2vrnFvFyFkFWIkF98
	trn09rZ5Kw18Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 4/15/2024 10:28 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7efd0a74039f Merge tag 'ata-6.9-rc4' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1358aeed180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7f061d2d16154538c58
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-7efd0a74.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/39eb4e17e7f0/vmlinux-7efd0a74.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b9a08c36e0ca/bzImage-7efd0a74.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/7645 is trying to acquire lock:
> ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue_buddy mm/page_alloc.c:2730 [inline]
> ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue mm/page_alloc.c:2911 [inline]
> ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
>
> but task is already holding lock:
> ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xdd0 kernel/bpf/lpm_trie.c:324
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&trie->lock){-.-.}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>        trie_delete_elem+0xb0/0x7e0 kernel/bpf/lpm_trie.c:451
>        ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
>        __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
>        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>        __bpf_prog_run include/linux/filter.h:657 [inline]
>        bpf_prog_run include/linux/filter.h:664 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>        bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
>        __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
>        trace_contention_end.constprop.0+0xea/0x170 include/trace/events/lock.h:122
>        __pv_queued_spin_lock_slowpath+0x266/0xc80 kernel/locking/qspinlock.c:560
>        pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
>        queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>        queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>        do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
>        _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
>        rmqueue_bulk mm/page_alloc.c:2131 [inline]
>        __rmqueue_pcplist+0x5a8/0x1b00 mm/page_alloc.c:2826
>        rmqueue_pcplist mm/page_alloc.c:2868 [inline]
>        rmqueue mm/page_alloc.c:2905 [inline]
>        get_page_from_freelist+0xbaa/0x3780 mm/page_alloc.c:3314
>        __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
>        __alloc_pages_node include/linux/gfp.h:238 [inline]
>        alloc_pages_node include/linux/gfp.h:261 [inline]
>        alloc_slab_page mm/slub.c:2175 [inline]
>        allocate_slab mm/slub.c:2338 [inline]
>        new_slab+0xcc/0x3a0 mm/slub.c:2391
>        ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
>        __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
>        __slab_alloc_node mm/slub.c:3663 [inline]
>        slab_alloc_node mm/slub.c:3835 [inline]
>        __do_kmalloc_node mm/slub.c:3965 [inline]
>        __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:3986
>        kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
>        __alloc_skb+0x164/0x380 net/core/skbuff.c:668
>        alloc_skb include/linux/skbuff.h:1313 [inline]
>        nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
>        nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
>        nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:850
>        process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
>        process_scheduled_works kernel/workqueue.c:3335 [inline]
>        worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
>        kthread+0x2c1/0x3a0 kernel/kthread.c:388
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> -> #0 (&zone->lock){-.-.}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain kernel/locking/lockdep.c:3869 [inline]
>        __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>        lock_acquire kernel/locking/lockdep.c:5754 [inline]
>        lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>        rmqueue_buddy mm/page_alloc.c:2730 [inline]
>        rmqueue mm/page_alloc.c:2911 [inline]
>        get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
>        __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
>        __alloc_pages_node include/linux/gfp.h:238 [inline]
>        alloc_pages_node include/linux/gfp.h:261 [inline]
>        __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3911
>        __do_kmalloc_node mm/slub.c:3954 [inline]
>        __kmalloc_node.cold+0x5/0x5f mm/slub.c:3973
>        kmalloc_node include/linux/slab.h:648 [inline]
>        bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
>        lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
>        trie_update_elem+0x1ef/0xdd0 kernel/bpf/lpm_trie.c:333
>        bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
>        map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
>        __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
>        __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
>        __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
>        __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&trie->lock);
>                                lock(&zone->lock);
>                                lock(&trie->lock);
>   lock(&zone->lock);
>
>  *** DEADLOCK ***
>
> 2 locks held by syz-executor.2/7645:
>  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
>  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x24b/0x6c0 kernel/bpf/syscall.c:202
>  #1: ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xdd0 kernel/bpf/lpm_trie.c:324

The normal lock sequence is trie->lock and then zone->lock, the syzbot
constructs a reversed lock sequence by attaching a bpf program to
trace_contention_end() on zone->lock and calls trie_delete_elem() in the
bpf program, so the dead-lock is indeed possible.

There are two feasible ways to fix the problem:
1) switch from bpf_map_kmalloc_node()/kfree to bpf memory allocator for
lpm trie
2) add a dead-lock checking map just like hash-table does and also need
to make lockdep be happy with the try-lock mechanism.

I prefer 1), but it could not eliminate the dead-lock completely,
because the syzbot may construct a bpf program which invokes
trie_delete_elem(), attach to  trace_contention_end() on trie->lock and
leads to a dead-lock, so will fix the syzbot report by 2).


