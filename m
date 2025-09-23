Return-Path: <bpf+bounces-69312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA35BB93E32
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BBDF7AF9E9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFDF246BB4;
	Tue, 23 Sep 2025 01:33:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1586329
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591232; cv=none; b=Ddb+sTR2tm8r14chVIqihA5ymZTCPxNdTRCnuIKdua2doNVmUU8K9QjDovtReEL68IaG5Izl9bYN2stmBl3KkChLCT4Icf8W5+VfMEnvdW5WwfFhqEpDK3ATZOHtBM0WH/pI8qQDXtV5NV4xPBpeNhauqfbHP5lOnwrixMnXXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591232; c=relaxed/simple;
	bh=GqNpKEzhkBgG6IlO5Hg6iMFUxNwGMbs/1h0AnlEZ170=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qpSpF5fUNh4fujJuKAfCchZLesWxtm/gPJQwqrGY1vobigHvZVtHOHDgQcQUu/ukX0VupWLXq5tm+F3bFz401VZXTZfXLFd5bjuzbSxA5Lkho7m4FxGDZlkOv9hIMEbnTjTp50W/gCEFUJ4qzD8wMbuvwT97JCHnTUYJv/Kjzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cW2Yx3vFwzKHMb7
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:33:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0B79A1A0D3C
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:33:46 +0800 (CST)
Received: from [10.174.177.163] (unknown [10.174.177.163])
	by APP3 (Coremail) with SMTP id _Ch0CgDXbz70+NFoELD9AQ--.10031S2;
	Tue, 23 Sep 2025 09:33:44 +0800 (CST)
Subject: Re: [PATCH bpf v3 6/9] bpf: Switch to bpf mem allocator for LPM trie
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241206110622.1161752-1-houtao@huaweicloud.com>
 <20241206110622.1161752-7-houtao@huaweicloud.com>
 <CAEf4BzaSbd2kKWL7ZT0WctsdiWq7wJG5NXT3TGxJzBGnP91T3A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <acebb5f8-d669-5fa7-aad5-41f6ec508609@huaweicloud.com>
Date: Tue, 23 Sep 2025 09:33:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaSbd2kKWL7ZT0WctsdiWq7wJG5NXT3TGxJzBGnP91T3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDXbz70+NFoELD9AQ--.10031S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1fKF1rXFyrWr1DGr43Awb_yoWxuFW8pF
	ZIgayfAr4DXrWj9wn7tF4DurWjvw48Kr4UG3Z3WFyrZFyYvrnxGr18Ar40vFyY9FyxC3Z3
	tF1Utr9Ivr1DZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 9/20/2025 5:28 AM, Andrii Nakryiko wrote:
> On Fri, Dec 6, 2024 at 2:54 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Multiple syzbot warnings have been reported. These warnings are mainly
>> about the lock order between trie->lock and kmalloc()'s internal lock.
>> See report [1] as an example:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.10.0-rc7-syzkaller-00003-g4376e966ecb7 #0 Not tainted
>> ------------------------------------------------------
>> syz.3.2069/15008 is trying to acquire lock:
>> ffff88801544e6d8 (&n->list_lock){-.-.}-{2:2}, at: get_partial_node ...
>>
>> but task is already holding lock:
>> ffff88802dcc89f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem ...
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (&trie->lock){-.-.}-{2:2}:
>>        __raw_spin_lock_irqsave
>>        _raw_spin_lock_irqsave+0x3a/0x60
>>        trie_delete_elem+0xb0/0x820
>>        ___bpf_prog_run+0x3e51/0xabd0
>>        __bpf_prog_run32+0xc1/0x100
>>        bpf_dispatcher_nop_func
>>        ......
>>        bpf_trace_run2+0x231/0x590
>>        __bpf_trace_contention_end+0xca/0x110
>>        trace_contention_end.constprop.0+0xea/0x170
>>        __pv_queued_spin_lock_slowpath+0x28e/0xcc0
>>        pv_queued_spin_lock_slowpath
>>        queued_spin_lock_slowpath
>>        queued_spin_lock
>>        do_raw_spin_lock+0x210/0x2c0
>>        __raw_spin_lock_irqsave
>>        _raw_spin_lock_irqsave+0x42/0x60
>>        __put_partials+0xc3/0x170
>>        qlink_free
>>        qlist_free_all+0x4e/0x140
>>        kasan_quarantine_reduce+0x192/0x1e0
>>        __kasan_slab_alloc+0x69/0x90
>>        kasan_slab_alloc
>>        slab_post_alloc_hook
>>        slab_alloc_node
>>        kmem_cache_alloc_node_noprof+0x153/0x310
>>        __alloc_skb+0x2b1/0x380
>>        ......
>>
>> -> #0 (&n->list_lock){-.-.}-{2:2}:
>>        check_prev_add
>>        check_prevs_add
>>        validate_chain
>>        __lock_acquire+0x2478/0x3b30
>>        lock_acquire
>>        lock_acquire+0x1b1/0x560
>>        __raw_spin_lock_irqsave
>>        _raw_spin_lock_irqsave+0x3a/0x60
>>        get_partial_node.part.0+0x20/0x350
>>        get_partial_node
>>        get_partial
>>        ___slab_alloc+0x65b/0x1870
>>        __slab_alloc.constprop.0+0x56/0xb0
>>        __slab_alloc_node
>>        slab_alloc_node
>>        __do_kmalloc_node
>>        __kmalloc_node_noprof+0x35c/0x440
>>        kmalloc_node_noprof
>>        bpf_map_kmalloc_node+0x98/0x4a0
>>        lpm_trie_node_alloc
>>        trie_update_elem+0x1ef/0xe00
>>        bpf_map_update_value+0x2c1/0x6c0
>>        map_update_elem+0x623/0x910
>>        __sys_bpf+0x90c/0x49a0
>>        ...
>>
>> other info that might help us debug this:
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&trie->lock);
>>                                lock(&n->list_lock);
>>                                lock(&trie->lock);
>>   lock(&n->list_lock);
>>
>>  *** DEADLOCK ***
>>
>> [1]: https://syzkaller.appspot.com/bug?extid=9045c0a3d5a7f1b119f7
>>
>> A bpf program attached to trace_contention_end() triggers after
>> acquiring &n->list_lock. The program invokes trie_delete_elem(), which
>> then acquires trie->lock. However, it is possible that another
>> process is invoking trie_update_elem(). trie_update_elem() will acquire
>> trie->lock first, then invoke kmalloc_node(). kmalloc_node() may invoke
>> get_partial_node() and try to acquire &n->list_lock (not necessarily the
>> same lock object). Therefore, lockdep warns about the circular locking
>> dependency.
>>
>> Invoking kmalloc() before acquiring trie->lock could fix the warning.
>> However, since BPF programs call be invoked from any context (e.g.,
>> through kprobe/tracepoint/fentry), there may still be lock ordering
>> problems for internal locks in kmalloc() or trie->lock itself.
>>
>> To eliminate these potential lock ordering problems with kmalloc()'s
>> internal locks, replacing kmalloc()/kfree()/kfree_rcu() with equivalent
>> BPF memory allocator APIs that can be invoked in any context. The lock
>> ordering problems with trie->lock (e.g., reentrance) will be handled
>> separately.
>>
>> Three aspects of this change require explanation:
>>
>> 1. Intermediate and leaf nodes are allocated from the same allocator.
>> Since the value size of LPM trie is usually small, using a single
>> alocator reduces the memory overhead of the BPF memory allocator.
>>
>> 2. Leaf nodes are allocated before disabling IRQs. This handles cases
>> where leaf_size is large (e.g., > 4KB - 8) and updates require
>> intermediate node allocation. If leaf nodes were allocated in
>> IRQ-disabled region, the free objects in BPF memory allocator would not
>> be refilled timely and the intermediate node allocation may fail.
>>
>> 3. Paired migrate_{disable|enable}() calls for node alloc and free. The
>> BPF memory allocator uses per-CPU struct internally, these paired calls
>> are necessary to guarantee correctness.
>>
>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/lpm_trie.c | 71 +++++++++++++++++++++++++++++--------------
>>  1 file changed, 48 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>> index 9ba6ae145239..f850360e75ce 100644
>> --- a/kernel/bpf/lpm_trie.c
>> +++ b/kernel/bpf/lpm_trie.c
>> @@ -15,6 +15,7 @@
>>  #include <net/ipv6.h>
>>  #include <uapi/linux/btf.h>
>>  #include <linux/btf_ids.h>
>> +#include <linux/bpf_mem_alloc.h>
>>
>>  /* Intermediate node */
>>  #define LPM_TREE_NODE_FLAG_IM BIT(0)
>> @@ -22,7 +23,6 @@
>>  struct lpm_trie_node;
>>
>>  struct lpm_trie_node {
>> -       struct rcu_head rcu;
>>         struct lpm_trie_node __rcu      *child[2];
>>         u32                             prefixlen;
>>         u32                             flags;
>> @@ -32,6 +32,7 @@ struct lpm_trie_node {
>>  struct lpm_trie {
>>         struct bpf_map                  map;
>>         struct lpm_trie_node __rcu      *root;
>> +       struct bpf_mem_alloc            ma;
>>         size_t                          n_entries;
>>         size_t                          max_prefixlen;
>>         size_t                          data_size;
>> @@ -287,17 +288,18 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
> Hey Hao,

Hi Andrii,

Actually my name is Hou Tao :)
>
> We recently got a warning from trie_lookup_elem() triggered by
>
> rcu_dereference_check(trie->root, rcu_read_lock_bh_held())
>
> check in trie_lookup_elem, when LPM trie map was used from a sleepable
> BPF program.
>
> It seems like it can be just converted to bpf_rcu_lock_held(), because
> with your switch to bpf_mem_alloc all the nodes are now both RCU and
> RCU Tasks Trace protected, is my thinking correct?
>
> Can you please double check? Thanks!

No. Although the node is freed after one RCU GP and one RCU Task Trace
GP, the reuse of node happens after one RCU GP. Therefore, for the
sleepable program when it looks up the trie, it may find and try to read
a reused node, the returned result will be unexpected due to the reuse.

>
> [...]


