Return-Path: <bpf+bounces-44450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA8A9C308B
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 03:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA35C1F2158E
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 02:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9113D896;
	Sun, 10 Nov 2024 02:08:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BA219FC;
	Sun, 10 Nov 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731204496; cv=none; b=EDgZNp8hbAKFFGojRmpywAsBW0snZ0YplPtyHW3/Gyz5qWmeuhJlI7bdJ+UnhThzwtKugKnvNMEnSB59R89fSzE9SJuZM9ML8+EWWbM1Qy2DfMf+9ISBc3wfiMXcW4J1d+kntizQC94hM1df8XZMEBOBkPIREvRVkKEZIPNg9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731204496; c=relaxed/simple;
	bh=YdIpBfTTBHS7IIpnl12h36yko6in3p6dx5CX2aS3+mk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RpqAp8zNZ7fDjM5I6K0fXF1dflrF1BIpQKWhkz9zbY5DTaSkfHN84frPSGraR2zKPGb6kTRF6c1p7kZ1Iad6rMSLy5CupZ5ZtZeSPmw0mY8zYVDb2KfCQTImp6wUbDiLyJ8qV8TeKM1LEu5bywGM6bm3XRVnGyHIp8s7tPwR3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XmGKl5gTFz4f3kk5;
	Sun, 10 Nov 2024 10:07:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C7F7D1A0194;
	Sun, 10 Nov 2024 10:08:08 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCXP7GAFTBn89lEBQ--.8077S2;
	Sun, 10 Nov 2024 10:08:04 +0800 (CST)
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Sebastian Sewior <bigeasy@linutronix.de>,
 clrkwllms@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
 Kunwu Chan <chentao@kylinos.cn>,
 syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <CAADnVQJ8KzVdScXM=qhdT4jMrZLBPpgd+pf1Fqyc-9TFnfabAg@mail.gmail.com>
 <78012426-80d2-4d77-23c4-ae000148fadd@huaweicloud.com>
 <CAADnVQK_FptUD17REjtT1wnRyxZ2dx6sZuePsJQES-q27NKKLA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ab0abca0-57b3-b379-0070-4625395c6707@huaweicloud.com>
Date: Sun, 10 Nov 2024 10:08:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQK_FptUD17REjtT1wnRyxZ2dx6sZuePsJQES-q27NKKLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCXP7GAFTBn89lEBQ--.8077S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4fWw18Gw4rCF43uF4kJFb_yoW3Jr1kpF
	WrAFZrAr4UXa4j9ay09w1ayayYqw45Kw43Gr93Wr1xZF12qrn7Xrs2yr1fZr9YgryvkF9x
	tr1qqFZ2gw18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/10/2024 8:04 AM, Alexei Starovoitov wrote:
> On Fri, Nov 8, 2024 at 6:46 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi Alexei,
>>
>> On 11/9/2024 4:22 AM, Alexei Starovoitov wrote:
>>> On Thu, Nov 7, 2024 at 10:32 PM Kunwu Chan <kunwu.chan@linux.dev> wrote:
>>>> From: Kunwu Chan <chentao@kylinos.cn>
>>>>
>>>> When PREEMPT_RT is enabled, 'spinlock_t' becomes preemptible
>>>> and bpf program has owned a raw_spinlock under a interrupt handler,
>>>> which results in invalid lock acquire context.
>>>>
>>>> [ BUG: Invalid wait context ]
>>>> 6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
>>>> -----------------------------
>>>> swapper/0/0 is trying to lock:
>>>> ffff8880261e7a00 (&trie->lock){....}-{3:3},
>>>> at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
>>>> other info that might help us debug this:
>>>> context-{3:3}
>>>> 5 locks held by swapper/0/0:
>>>>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
>>>> at: vp_vring_interrupt drivers/virtio/virtio_pci_common.c:80 [inline]
>>>>  #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3},
>>>> at: vp_interrupt+0x142/0x200 drivers/virtio/virtio_pci_common.c:113
>>>>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
>>>> at: spin_lock include/linux/spinlock.h:351 [inline]
>>>>  #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3},
>>>> at: stats_request+0x6f/0x230 drivers/virtio/virtio_balloon.c:438
>>>>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
>>>> at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>>>>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
>>>> at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>>>>  #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
>>>> at: __queue_work+0x199/0xf50 kernel/workqueue.c:2259
>>>>  #3: ffff8880b863dd18 (&pool->lock){-.-.}-{2:2},
>>>> at: __queue_work+0x759/0xf50
>>>>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
>>>> at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>>>>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
>>>> at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>>>>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
>>>> at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
>>>>  #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3},
>>>> at: bpf_trace_run1+0x1d6/0x520 kernel/trace/bpf_trace.c:2380
>>>> stack backtrace:
>>>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
>>>> 6.12.0-rc5-next-20241031-syzkaller #0
>>>> Hardware name: Google Compute Engine/Google Compute Engine,
>>>> BIOS Google 09/13/2024
>>>> Call Trace:
>>>>  <IRQ>
>>>>  __dump_stack lib/dump_stack.c:94 [inline]
>>>>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>>>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
>>>>  check_wait_context kernel/locking/lockdep.c:4898 [inline]
>>>>  __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
>>>>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>>>>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>>>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>>>>  trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
>>> This trace is from non-RT kernel where spin_lock == raw_spin_lock.
>> Yes. However, I think the reason for the warning is that lockdep
>> considers the case is possible under PREEMPT_RT and it violates the rule
>> of lock [1].
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=560af5dc839eef08a273908f390cfefefb82aa04
>>> I don't think Hou's explanation earlier is correct.
>>> https://lore.kernel.org/bpf/e14d8882-4760-7c9c-0cfc-db04eda494ee@huaweicloud.com/
>> OK. Is the bpf mem allocator part OK for you ?
>>>>  bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>>>>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>>>>  __bpf_prog_run include/linux/filter.h:701 [inline]
>>>>  bpf_prog_run include/linux/filter.h:708 [inline]
>>>>  __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
>>>>  bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
>>>>  trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqueue.h:59
>>>>  __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338
>>>>  queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
>>> here irqs are disabled, but raw_spin_lock in lpm should be fine.
>>>
>>>>  queue_work include/linux/workqueue.h:662 [inline]
>>>>  stats_request+0x1a3/0x230 drivers/virtio/virtio_balloon.c:441
>>>>  vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
>>>>  vp_vring_interrupt drivers/virtio/virtio_pci_common.c:82 [inline]
>>>>  vp_interrupt+0x192/0x200 drivers/virtio/virtio_pci_common.c:113
>>>>  __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
>>>>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>>>>  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
>>>>  handle_fasteoi_irq+0x48a/0xae0 kernel/irq/chip.c:720
>>>>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>>>>  handle_irq arch/x86/kernel/irq.c:247 [inline]
>>>>  call_irq_handler arch/x86/kernel/irq.c:259 [inline]
>>>>  __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
>>>>  common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
>>>>  </IRQ>
>>>>
>>>> Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
>>>> Closes: https://lore.kernel.org/bpf/6723db4a.050a0220.35b515.0168.GAE@google.com/
>>>> Fixes: 66150d0dde03 ("bpf, lpm: Make locking RT friendly")
>>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>>> ---
>>>>  kernel/bpf/lpm_trie.c | 12 ++++++------
>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>>>> index 9b60eda0f727..373cdcfa0505 100644
>>>> --- a/kernel/bpf/lpm_trie.c
>>>> +++ b/kernel/bpf/lpm_trie.c
>>>> @@ -35,7 +35,7 @@ struct lpm_trie {
>>>>         size_t                          n_entries;
>>>>         size_t                          max_prefixlen;
>>>>         size_t                          data_size;
>>>> -       spinlock_t                      lock;
>>>> +       raw_spinlock_t                  lock;
>>>>  };
>>> We're certainly not going back.
>> Only switching from spinlock_t to raw_spinlock_t is not enough, running
>> it under PREEMPT_RT after the change will still trigger the similar
>> lockdep warning. That is because kmalloc() may acquire a spinlock_t as
>> well. However, after changing the kmalloc and its variants to bpf memory
>> allocator, I think the switch to raw_spinlock_t will be safe. I have
>> already written a draft patch set. Will post after after polishing and
>> testing it. WDYT ?
> Switching lpm to bpf_mem_alloc would address the issue.
> Why do you want a switch to raw_spin_lock as well?
> kfree_rcu() is already done outside of the lock.

After switching to raw_spinlock_t, the lpm trie could be used under
interrupt context even under PREEMPT_RT.
> .


