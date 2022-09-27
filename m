Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599F95EB859
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 05:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiI0DMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 23:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiI0DL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 23:11:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656D71BED
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 20:08:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mc4Jv5j3PzKJtB
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:06:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgA3BSknaTJjw0mNBQ--.44545S2;
        Tue, 27 Sep 2022 11:08:27 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local>
 <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com>
Date:   Tue, 27 Sep 2022 11:08:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgA3BSknaTJjw0mNBQ--.44545S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJr43AFW7urW3uF43tFWkWFg_yoWDKFW8pF
        WxJF1UJrWUJr1rJr1xtr1UJFyUJw15Jw4UJr1rJFyUCr1UJr1S9r10qr4jgF15Ar4xJw1j
        qr1UXw4Uur1UZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/27/2022 9:19 AM, Alexei Starovoitov wrote:
> On Mon, Sep 26, 2022 at 09:18:46PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 9/26/2022 9:25 AM, Alexei Starovoitov wrote:
>>> On Sat, Sep 24, 2022 at 09:36:07PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>> SNIP
>>>> For atomic ops and kmalloc overhead, I think I can reuse the idea from
>>>> patchset "bpf: BPF specific memory allocator". I have given bpf_mem_alloc
>>>> a simple try and encounter some problems. One problem is that
>>>> immediate reuse of freed object in bpf memory allocator. Because qp-trie
>>>> uses bpf memory allocator to allocate and free qp_trie_branch, if
>>>> qp_trie_branch is reused immediately, the lookup procedure may oops due
>>>> to the incorrect content in qp_trie_branch. And another problem is the
>>>> size limitation in bpf_mem_alloc() is 4096. It may be a little small for
>>>> the total size of key size and value size, but maybe I can use two
>>>> separated bpf_mem_alloc for key and value.
>>> 4096 limit for key+value size would be an acceptable trade-off.
>>> With kptrs the user will be able to extend value to much bigger sizes
>>> while doing <= 4096 allocation at a time. Larger allocations are failing
>>> in production more often than not. Any algorithm relying on successful
>>>  >= 4096 allocation is likely to fail. kvmalloc is a fallback that
>>> the kernel is using, but we're not there yet in bpf land.
>>> The benefits of bpf_mem_alloc in qp-trie would be huge though.
>>> qp-trie would work in all contexts including sleepable progs.
>>> As presented the use cases for qp-trie are quite limited.
>>> If I understand correctly the concern for not using bpf_mem_alloc
>>> is that qp_trie_branch can be reused. Can you provide an exact scenario
>>> that will casue issuses?
>> The usage of branch node during lookup is as follows:
>> (1) check the index field of branch node which records the position of nibble in
>> which the keys of child nodes are different
>> (2) calculate the index of child node by using the nibble value of lookup key in
>> index position
>> (3) get the pointer of child node by dereferencing the variable-length pointer
>> array in branch node
>>
>> Because both branch node and leaf node have variable length, I used one
>> bpf_mem_alloc for these two node types, so if a leaf node is reused as a branch
>> node, the pointer got in step 3 may be invalid.
>>
>> If using separated bpf_mem_alloc for branch node and leaf node, it may still be
>> problematic because the updates to a reused branch node are not atomic and
>> branch nodes with different child node will reuse the same object due to size
>> alignment in allocator, so the lookup procedure below may get an uninitialized
>> pointer in the pointer array:
>>
>> lookup procedure                                update procedure
>>
>>
>> // three child nodes, 48-bytes
>> branch node x
>>                                                               //  four child
>> nodes, 56-bytes
>>                                                               reuse branch node x
>>                                                               x->bitmap = 0xf
>> // got an uninitialized pointer
>> x->nodes[3]
>>                                                               Initialize
>> x->nodes[0~3]
> Looking at lookup:
> +	while (is_branch_node(node)) {
> +		struct qp_trie_branch *br = node;
> +		unsigned int bitmap;
> +		unsigned int iip;
> +
> +		/* When byte index equals with key len, the target key
> +		 * may be in twigs->nodes[0].
> +		 */
> +		if (index_to_byte_index(br->index) > data_len)
> +			goto done;
> +
> +		bitmap = calc_br_bitmap(br->index, data, data_len);
> +		if (!(bitmap & br->bitmap))
> +			goto done;
> +
> +		iip = calc_twig_index(br->bitmap, bitmap);
> +		node = rcu_dereference_check(br->nodes[iip], rcu_read_lock_bh_held());
> +	}
>
> To be safe the br->index needs to be initialized after br->nodex and br->bitmap.
> While deleting the br->index can be set to special value which would mean
> restart the lookup from the beginning.
> As you're suggesting with smp_rmb/wmb pairs the lookup will only see valid br.
> Also the race is extremely tight, right?
> After brb->nodes[iip] + is_branch_node that memory needs to deleted on other cpu
> after spin_lock and reused in update after another spin_lock.
> Without artifical big delay it's hard to imagine how nodes[iip] pointer
> would be initialized to some other qp_trie_branch or leaf during delete,
> then memory reused and nodes[iip] is initialized again with the same address.
> Theoretically possible, but unlikely, right?
> And with correct ordering of scrubbing and updates to
> br->nodes, br->bitmap, br->index it can be made safe.
The reuse of node not only introduces the safety problem (e.g. access an invalid
pointer), but also incur the false negative problem (e.g. can not find an
existent element) as show below:

lookup A in X on CPU1            update X on CPU 2

     [ branch X v1 ]                   
 leaf A | leaf B | leaf C
                                                 [ branch X v2 ]
                                               leaf A | leaf B | leaf C | leaf D
                                                 
                                                  // free and reuse branch X v1
                                                  [ branch X v1 ]
                                                leaf O | leaf P | leaf Q
// leaf A can not be found
> We can add a sequence number to qp_trie_branch as well and read it before and after.
> Every reuse would inc the seq.
> If seq number differs, re-read the node pointer form parent.
A seq number on qp_trie_branch is a good idea. Will try it. But we also need to
consider the starvation of lookup by update/deletion. Maybe need fallback to the
subtree spinlock after some reread.
>> The problem may can be solved by zeroing the unused or whole part of allocated
>> object. Maybe adding a paired smp_wmb() and smp_rmb() to ensure the update of
>> node array happens before the update of bitmap is also OK and the cost will be
>> much cheaper in x86 host.
> Something like this, right.
> We can also consider doing lookup under spin_lock. For a large branchy trie
> the cost of spin_lock maybe negligible.
Do you meaning adding an extra spinlock to qp_trie_branch to protect again reuse
or taking the subtree spinlock during lookup ? IMO the latter will make the
lookup performance suffer, but I will check it as well.
>
>> Beside lookup procedure, get_next_key() from syscall also lookups trie
>> locklessly. If the branch node is reused, the order of returned keys may be
>> broken. There is also a parent pointer in branch node and it is used for reverse
>> lookup during get_next_key, the reuse may lead to unexpected skip in iteration.
> qp_trie_lookup_next_node can be done under spin_lock.
> Iterating all map elements is a slow operation anyway.
OK. Taking subtree spinlock is simpler but the scalability will be bad. Not sure
whether or not the solution for lockless lookup will work for get_next_key. Will
check.
>
>>> Instead of call_rcu in qp_trie_branch_free (which will work only for
>>> regular progs and have high overhead as demonstrated by mem_alloc patches)
>>> the qp-trie freeing logic can scrub that element, so it's ready to be
>>> reused as another struct qp_trie_branch.
>>> I guess I'm missing how rcu protects this internal data structures of qp-trie.
>>> The rcu_read_lock of regular bpf prog helps to stay lock-less during lookup?
>>> Is that it?
>> Yes. The update is made atomic by copying the parent branch node to a new branch
>> node and replacing the pointer to the parent branch node by the new branch node,
>> so the lookup procedure either find the old branch node or the new branch node.
>>> So to make qp-trie work in sleepable progs the algo would need to
>>> be changed to do both call_rcu and call_rcu_task_trace everywhere
>>> to protect these inner structs?
>>> call_rcu_task_trace can take long time. So qp_trie_branch-s may linger
>>> around. So quick update/delete (in sleepable with call_rcu_task_trace)
>>> may very well exhaust memory. With bpf_mem_alloc we don't have this issue
>>> since rcu_task_trace gp is observed only when freeing into global mem pool.
>>> Say qp-trie just uses bpf_mem_alloc for qp_trie_branch.
>>> What is the worst that can happen? qp_trie_lookup_elem will go into wrong
>>> path, but won't crash, right? Can we do hlist_nulls trick to address that?
>>> In other words bpf_mem_alloc reuse behavior is pretty much SLAB_TYPESAFE_BY_RCU.
>>> Many kernel data structures know how to deal with such object reuse.
>>> We can have a private bpf_mem_alloc here for qp_trie_branch-s only and
>>> construct a logic in a way that obj reuse is not problematic.
>> As said above, qp_trie_lookup_elem may be OK with SLAB_TYPESAFE_BY_RCU. But I
>> don't know how to do it for get_next_key because the iteration result needs to
>> be ordered and can not skip existed elements before the iterations begins.
> imo it's fine to spin_lock in get_next_key.
> We should measure the lock overhead in lookup. It might be acceptable too.
Will check that.
>
>> If removing immediate reuse from bpf_mem_alloc, beside the may-decreased
>> performance, is there any reason we can not do that ?
> What do you mean?
> Always do call_rcu + call_rcu_tasks_trace for every bpf_mem_free ?
Yes. Does doing call_rcu() + call_rcu_task_trace in batch help just like
free_bulk does ?
> As I said above:
> " call_rcu_task_trace can take long time. So qp_trie_branch-s may linger
>   around. So quick update/delete (in sleepable with call_rcu_task_trace)
>   may very well exhaust memory.
> "
> As an exercise try samples/bpf/map_perf_test on non-prealloc hashmap
> before mem_alloc conversion. Just regular call_rcu consumes 100% of all cpus.
> With call_rcu_tasks_trace it's worse. It cannot sustain such flood.
> .
Will check the result of map_perf_test. But it seems bpf_mem_alloc may still
exhaust memory if __free_rcu_tasks_trace() can not called timely, Will take a
close lookup on that.

