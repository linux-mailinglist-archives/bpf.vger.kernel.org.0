Return-Path: <bpf+bounces-31475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE68FDC38
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 03:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122DF1F251D8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 01:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0B12E5D;
	Thu,  6 Jun 2024 01:42:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD24C97
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717638120; cv=none; b=Lf5Gruxw6RsVSJQTVcLV6YcEHidnGhWF3eNi2cktjKfMEoD1+E+LNyTI+TfYrRlUU+I/VcwqQ3Vwa1CSq2PFtD0AeoG3rUSL7GXlSGZ4TiHijmPXiRvN58NgSA97KVctGgWLUj1kCKQm67/6S+lpxWqfFvjrk3414zy+FlObjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717638120; c=relaxed/simple;
	bh=lY/J68KjwJ/RKt3thyTBN5zFt5jUcXH3JCoSR1JHRG0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XAQ5S7PF4g69eQimUO9pIGvZVDybMRtOd5QNYouPanKdER8uGKNrJgHhWqTklOzrPibvWsoM/K6UHlFvV5bGTMYWuOzwuiO6Szd0aI6RxBuIURyGUcCZ8ZYENRYfF3k5N87Q3UXLVBU7i8TXOI/MrRg2NEWtwyISitAgp3ngtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vvn9r5y4Kz4f3jXh
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 09:41:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 84BB81A0181
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 09:41:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDXOPzUE2FmwHQ6PA--.27107S2;
	Thu, 06 Jun 2024 09:41:44 +0800 (CST)
Subject: Re: qp-trie? Re: [PATCH bpf-next 06/10] bpf: Add support for qp-trie
 map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>,
 KP Singh <kpsingh@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Lorenz Bauer <oss@lmb.io>, "Paul E . McKenney" <paulmck@kernel.org>,
 Hou Tao <houtao1@huawei.com>
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
 <20220917153125.2001645-7-houtao@huaweicloud.com>
 <CAADnVQ+0eTwL_iJo8Y79GHB-8zAgNCV7Ka9Mza1b+8ENOShBvw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3a21310f-e5ec-c9fb-86a8-6eeecb0b6975@huaweicloud.com>
Date: Thu, 6 Jun 2024 09:41:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+0eTwL_iJo8Y79GHB-8zAgNCV7Ka9Mza1b+8ENOShBvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDXOPzUE2FmwHQ6PA--.27107S2
X-Coremail-Antispam: 1UD129KBjvAXoWfAw4UGw13Kr1DCF15XFWfGrg_yoWrGryrAo
	WfJr4xtrn7Gr1UZF18G3saqry3u3yDWFyDAFsIgwsI9F15t3Wj93yUCa1fJF4jgF48GF43
	Xa4xX34DArW8Krnxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI
	62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Alexei,

On 6/5/2024 9:48 PM, Alexei Starovoitov wrote:
> Hi Hou,
>
> Are you still working on qp-trie ?
> All prerequisites (like bpf_mem_alloc support) have landed.
> Anything keeping you from respinning this set?

Sorry, it is paused due to my limited time for bpf subsystem recently. 
During the limited time for bpf subsystem, I am still trying to resolve
the huge memory usage for global bpf_mem_alloc. The problem can be
demonstrated by using the bpf_ma benchmark [1] and it happens as follows:

(1) there are intensive allocation/free calls for global bpf_mem_alloc
in one period on a specific CPU
(2) there is not any call afterwards on this CPU
(3) these two RCU callbacks in bpf memory allocator end, and it will not
be called anymore, because there is not unit_free()/unit_free_rcu() call
on the CPU
(4) but there will be many objects in free_by_rcu and free_by_rcu_ttrace
which are not freed.

I am working on a patch-set which tries to resolve the problem by the
following two methods:
(1) track the active refcount of global bpf memory allocator hold by bpf
programs and bpf maps and invoke a new bpf_mem_alloc_flush() API to
flush freeable objects in these lists when the active refcount goes down
as zero.
(2) try to call call_rcu_tasks_trace() nested if there are freeable
objects in the free_by_rcu_ttrace, because bpf_mem_alloc_flush may leave
these freeable objects due to concurrency with __free_by_rcu().

I hope the RFC patch-set for global bpf memory allocator will be posted
before next week. After that, I will try to continue my work on qp-trie.

Thanks.

[1]:
https://lore.kernel.org/bpf/20231221141501.3588586-1-houtao@huaweicloud.com/
>
> Thanks!
>
> On Sat, Sep 17, 2022 at 8:13 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The initial motivation for qp-trie map is to reduce memory usage for
>> string keys specially those with large differencies in length. Moreover
>> as a big-endian lexicographic-ordered map, qp-trie can also be used for
>> any binary data with fixed or variable length.
>>
>> The memory efficiency of qp-tries comes partly from the design of qp-trie
>> which doesn't save key for branch node and uses sparse array to save leaf
>> nodes, partly comes from the support of bpf_dynptr-typed key: only the
>> used part in key is saved.
>>
>> But the memory efficiency and ordered keys come with cost: for strings
>> (e.g. symbol names in /proc/kallsyms) the lookup performance of qp-trie
>> is about 30% or more slower compared with hash-table. But the lookup
>> performance is not always bad than hash-table, for randomly generated
>> binary data set with big differencies in length, the lookup performance
>> of qp-trie will be twice as good as hash-table as showed in the
>> following benchmark.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  include/linux/bpf_types.h      |    1 +
>>  include/uapi/linux/bpf.h       |    1 +
>>  kernel/bpf/Makefile            |    1 +
>>  kernel/bpf/bpf_qp_trie.c       | 1055 ++++++++++++++++++++++++++++++++
>>  tools/include/uapi/linux/bpf.h |    1 +
>>  5 files changed, 1059 insertions(+)
>>  create mode 100644 kernel/bpf/bpf_qp_trie.c
>>
>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>> index 2b9112b80171..a73d47f83d74 100644
>> --- a/include/linux/bpf_types.h
>> +++ b/include/linux/bpf_types.h
>> @@ -126,6 +126,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>>  #endif
>>  BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
>>  BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>> +BPF_MAP_TYPE(BPF_MAP_TYPE_QP_TRIE, qp_trie_map_ops)
>>
>>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 77a2828f8148..e35e70b5cf0d 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -928,6 +928,7 @@ enum bpf_map_type {
>>         BPF_MAP_TYPE_INODE_STORAGE,
>>         BPF_MAP_TYPE_TASK_STORAGE,
>>         BPF_MAP_TYPE_BLOOM_FILTER,
>> +       BPF_MAP_TYPE_QP_TRIE,
>>  };
>>
>>  /* Note that tracing related programs such as
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 341c94f208f4..8419f44fea50 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_i
>>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>>  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>> +obj-$(CONFIG_BPF_SYSCALL) += bpf_qp_trie.o
>>  obj-${CONFIG_BPF_LSM}    += bpf_inode_storage.o
>>  obj-$(CONFIG_BPF_SYSCALL) += disasm.o
>>  obj-$(CONFIG_BPF_JIT) += trampoline.o
>> diff --git a/kernel/bpf/bpf_qp_trie.c b/kernel/bpf/bpf_qp_trie.c
>> new file mode 100644
>> index 000000000000..4f56f69360ce
>> --- /dev/null
>> +++ b/kernel/bpf/bpf_qp_trie.c
>> @@ -0,0 +1,1055 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Derived from qp.c in https://github.com/fanf2/qp.git
>> + *
>> + * Copyright (C) 2022. Huawei Technologies Co., Ltd
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/rcupdate.h>
>> +#include <linux/bpf.h>
>> +#include <linux/btf.h>
>> +#include <linux/btf_ids.h>
>> +
>> +/* qp-trie (quadbit popcount trie) is a memory efficient trie. Unlike
>> + * normal trie which uses byte as lookup key, qp-trie interprets its keys
>> + * as quadbit/nibble array and uses one nibble each time during lookup.
>> + * The most significant nibble (upper nibble) of byte N in the key will
>> + * be the 2*N element of nibble array, and the least significant nibble
>> + * (lower nibble) of byte N will be the 2*N+1 element in nibble array.
>> + *
>> + * For normal trie, it may have 256 child nodes, and for qp-trie one branch
>> + * node may have 17 child nodes. #0 child node is special because it must
>> + * be a leaf node and its key is the same as the branch node. #1~#16 child
>> + * nodes represent leaf nodes or branch nodes which have different keys
>> + * with parent node. The key of branch node is the common prefix for these
>> + * child nodes, and the index of child node minus one is the value of first
>> + * different nibble between these child nodes.
>> + *
>> + * qp-trie reduces memory usage through two methods:
>> + * (1) Branch node doesn't store the key. It only stores the position of
>> + *     the first nibble which differentiates child nodes.
>> + * (2) Branch node doesn't store all 17 child nodes. It uses a bitmap and
>> + *     popcount() to implement a sparse array and only allocates memory
>> + *     for those present children.
>> + *
>> + * Like normal trie, qp-trie is also ordered and is in big-endian
>> + * lexicographic order. If traverse qp-trie in a depth-first way, it will
>> + * return a string of ordered keys.
>> + *
>> + * The following diagrams show the construction of a tiny qp-trie:
>> + *
>> + * (1) insert abc
>> + *
>> + *          [ leaf node: abc ]
>> + *
>> + * (2) insert abc_d
>> + *
>> + * The first different nibble between "abc" and "abc_d" is the upper nibble
>> + * of character '_' (0x5), and its position in nibble array is 6
>> + * (starts from 0).
>> + *
>> + *          [ branch node ] bitmap: 0x41 diff pos: 6
>> + *                 |
>> + *                 *
>> + *             children
>> + *          [0]        [6]
>> + *           |          |
>> + *       [leaf: abc] [leaf: abc_d]
>> + *
>> + * (3) insert abc_e
>> + *
>> + * The first different nibble between "abc_d" and "abc_e" is the lower
>> + * nibble of character 'd'/'e', and its position in array is 9.
>> + *
>> + *          [ branch node ] bitmap: 0x41 diff pos: 6
>> + *                 |
>> + *                 *
>> + *             children
>> + *          [0]        [6]
>> + *           |          |
>> + *       [leaf: abc]    |
>> + *                      *
>> + *                [ branch node ] bitmap: 0x60 diff pos: 9
>> + *                      |
>> + *                      *
>> + *                   children
>> + *                [5]        [6]
>> + *                 |          |
>> + *          [leaf: abc_d]  [leaf: abc_e]
>> + */
>> +
>> +#define QP_TRIE_MANDATORY_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_DYNPTR_KEY)
>> +#define QP_TRIE_CREATE_FLAG_MASK (QP_TRIE_MANDATORY_FLAG_MASK | BPF_F_NUMA_NODE | \
>> +                                 BPF_F_ACCESS_MASK)
>> +
>> +/* bit[0] of nodes in qp_trie_branch is used to tell node type:
>> + *
>> + * bit[0]: 0-branch node
>> + * bit[0]: 1-leaf node
>> + *
>> + * Size of qp_trie_branch is already 2-bytes aligned, so only need to make
>> + * allocation of leaf node to be 2-bytes aligned.
>> + */
>> +#define QP_TRIE_LEAF_NODE_MASK 1UL
>> +#define QP_TRIE_LEAF_ALLOC_ALIGN 2
>> +
>> +/* To reduce memory usage, only qp_trie_branch is RCU-freed. To handle
>> + * freeing of the last leaf node, an extra qp_trie_branch node is
>> + * allocated. The branch node has only one child and its index is 0. It
>> + * is set as root node after adding the first leaf node.
>> + */
>> +#define QP_TRIE_ROOT_NODE_INDEX 0
>> +#define QP_TRIE_NON_ROOT_NODE_MASK 1
>> +
>> +#define QP_TRIE_NIBBLE_SHIFT 1
>> +#define QP_TRIE_BYTE_INDEX_SHIFT 2
>> +
>> +#define QP_TRIE_TWIGS_FREE_NONE_IDX 17
>> +
>> +struct qp_trie_branch {
>> +       /* The bottom two bits of index are used as special flags:
>> +        *
>> +        * bit[0]: 0-root, 1-not root
>> +        * bit[1]: 0-upper nibble, 1-lower nibble
>> +        *
>> +        * bit[2:31]: byte index for key
>> +        */
>> +       unsigned int index;
>> +       /* 17 bits are used to accommodate arbitrary keys, even when there are
>> +        * zero-bytes in these keys.
>> +        *
>> +        * bit[0]: a leaf node has the same key as the prefix of parent node
>> +        * bit[N]: a child node with the value of nibble at index as (N - 1)
>> +        */
>> +       unsigned int bitmap:17;
>> +       /* The index of leaf node will be RCU-freed together */
>> +       unsigned int to_free_idx:5;
>> +       struct qp_trie_branch __rcu *parent;
>> +       struct rcu_head rcu;
>> +       void __rcu *nodes[0];
>> +};
>> +
>> +#define QP_TRIE_NR_SUBTREE 256
>> +
>> +struct qp_trie {
>> +       struct bpf_map map;
>> +       atomic_t entries;
>> +       void __rcu *roots[QP_TRIE_NR_SUBTREE];
>> +       spinlock_t locks[QP_TRIE_NR_SUBTREE];
>> +};
>> +
>> +/* Internally use qp_trie_key instead of bpf_dynptr_kern
>> + * to reduce memory usage
>> + */
>> +struct qp_trie_key {
>> +       /* the length of blob data */
>> +       unsigned int len;
>> +       /* blob data */
>> +       unsigned char data[0];
>> +};
>> +
>> +struct qp_trie_diff {
>> +       unsigned int index;
>> +       unsigned int sibling_bm;
>> +       unsigned int new_bm;
>> +};
>> +
>> +static inline void *to_child_node(const struct qp_trie_key *key)
>> +{
>> +       return (void *)((long)key | QP_TRIE_LEAF_NODE_MASK);
>> +}
>> +
>> +static inline struct qp_trie_key *to_leaf_node(void *node)
>> +{
>> +       return (void *)((long)node & ~QP_TRIE_LEAF_NODE_MASK);
>> +}
>> +
>> +static inline bool is_branch_node(void *node)
>> +{
>> +       return !((long)node & QP_TRIE_LEAF_NODE_MASK);
>> +}
>> +
>> +static inline bool is_same_key(const struct qp_trie_key *k, const unsigned char *data,
>> +                              unsigned int len)
>> +{
>> +       return k->len == len && !memcmp(k->data, data, len);
>> +}
>> +
>> +static inline void *qp_trie_leaf_value(const struct qp_trie_key *key)
>> +{
>> +       return (void *)key + sizeof(*key) + key->len;
>> +}
>> +
>> +static inline unsigned int calc_twig_index(unsigned int mask, unsigned int bitmap)
>> +{
>> +       return hweight32(mask & (bitmap - 1));
>> +}
>> +
>> +static inline unsigned int calc_twig_nr(unsigned int bitmap)
>> +{
>> +       return hweight32(bitmap);
>> +}
>> +
>> +static inline unsigned int nibble_to_bitmap(unsigned char nibble)
>> +{
>> +       return 1U << (nibble + 1);
>> +}
>> +
>> +static inline unsigned int index_to_byte_index(unsigned int index)
>> +{
>> +       return index >> QP_TRIE_BYTE_INDEX_SHIFT;
>> +}
>> +
>> +static inline unsigned int calc_br_bitmap(unsigned int index, const unsigned char *data,
>> +                                         unsigned int len)
>> +{
>> +       unsigned int byte;
>> +       unsigned char nibble;
>> +
>> +       if (index == QP_TRIE_ROOT_NODE_INDEX)
>> +               return 1;
>> +
>> +       byte = index_to_byte_index(index);
>> +       if (byte >= len)
>> +               return 1;
>> +
>> +       nibble = data[byte];
>> +       /* lower nibble */
>> +       if ((index >> QP_TRIE_NIBBLE_SHIFT) & 1)
>> +               nibble &= 0xf;
>> +       else
>> +               nibble >>= 4;
>> +       return nibble_to_bitmap(nibble);
>> +}
>> +
>> +static void qp_trie_free_twigs_rcu(struct rcu_head *rcu)
>> +{
>> +       struct qp_trie_branch *twigs = container_of(rcu, struct qp_trie_branch, rcu);
>> +       unsigned int idx = twigs->to_free_idx;
>> +
>> +       if (idx != QP_TRIE_TWIGS_FREE_NONE_IDX)
>> +               kfree(to_leaf_node(rcu_access_pointer(twigs->nodes[idx])));
>> +       kfree(twigs);
>> +}
>> +
>> +static void qp_trie_branch_free(struct qp_trie_branch *twigs, unsigned int to_free_idx)
>> +{
>> +       twigs->to_free_idx = to_free_idx;
>> +       call_rcu(&twigs->rcu, qp_trie_free_twigs_rcu);
>> +}
>> +
>> +static inline struct qp_trie_branch *
>> +qp_trie_branch_new(struct bpf_map *map, unsigned int nr)
>> +{
>> +       struct qp_trie_branch *a;
>> +
>> +       a = bpf_map_kmalloc_node(map, sizeof(*a) + nr * sizeof(*a->nodes),
>> +                                GFP_NOWAIT | __GFP_NOWARN, map->numa_node);
>> +       return a;
>> +}
>> +
>> +static inline void qp_trie_assign_parent(struct qp_trie_branch *parent, void *node)
>> +{
>> +       if (is_branch_node(node))
>> +               rcu_assign_pointer(((struct qp_trie_branch *)node)->parent, parent);
>> +}
>> +
>> +static void qp_trie_update_parent(struct qp_trie_branch *parent, unsigned int nr)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < nr; i++)
>> +               qp_trie_assign_parent(parent, rcu_dereference_protected(parent->nodes[i], 1));
>> +}
>> +
>> +/* new_node can be either a leaf node or a branch node */
>> +static struct qp_trie_branch *
>> +qp_trie_branch_replace(struct bpf_map *map, struct qp_trie_branch *old, unsigned int bitmap,
>> +                      void *new_node)
>> +{
>> +       unsigned int nr = calc_twig_nr(old->bitmap);
>> +       unsigned int p = calc_twig_index(old->bitmap, bitmap);
>> +       struct qp_trie_branch *twigs;
>> +
>> +       twigs = qp_trie_branch_new(map, nr);
>> +       if (!twigs)
>> +               return NULL;
>> +
>> +       if (p)
>> +               memcpy(twigs->nodes, old->nodes, p * sizeof(*twigs->nodes));
>> +
>> +       rcu_assign_pointer(twigs->nodes[p], new_node);
>> +
>> +       if (nr - 1 > p)
>> +               memcpy(&twigs->nodes[p+1], &old->nodes[p+1], (nr - 1 - p) * sizeof(*twigs->nodes));
>> +
>> +       twigs->index = old->index;
>> +       twigs->bitmap = old->bitmap;
>> +       /* twigs will not be visible to reader until rcu_assign_pointer(), so
>> +        * use RCU_INIT_POINTER() here.
>> +        */
>> +       RCU_INIT_POINTER(twigs->parent, old->parent);
>> +
>> +       /* Initialize ->parent of parent node first, then update ->parent for
>> +        * child nodes after parent node is fully initialized.
>> +        */
>> +       qp_trie_update_parent(twigs, nr);
>> +
>> +       return twigs;
>> +}
>> +
>> +static struct qp_trie_branch *
>> +qp_trie_branch_insert(struct bpf_map *map, struct qp_trie_branch *old, unsigned int bitmap,
>> +                     const struct qp_trie_key *new)
>> +{
>> +       unsigned int nr = calc_twig_nr(old->bitmap);
>> +       unsigned int p = calc_twig_index(old->bitmap, bitmap);
>> +       struct qp_trie_branch *twigs;
>> +
>> +       twigs = qp_trie_branch_new(map, nr + 1);
>> +       if (!twigs)
>> +               return NULL;
>> +
>> +       if (p)
>> +               memcpy(twigs->nodes, old->nodes, p * sizeof(*twigs->nodes));
>> +
>> +       rcu_assign_pointer(twigs->nodes[p], to_child_node(new));
>> +
>> +       if (nr > p)
>> +               memcpy(&twigs->nodes[p+1], &old->nodes[p], (nr - p) * sizeof(*twigs->nodes));
>> +
>> +       twigs->bitmap = old->bitmap | bitmap;
>> +       twigs->index = old->index;
>> +       RCU_INIT_POINTER(twigs->parent, old->parent);
>> +
>> +       qp_trie_update_parent(twigs, nr + 1);
>> +
>> +       return twigs;
>> +}
>> +
>> +static struct qp_trie_branch *
>> +qp_trie_branch_remove(struct bpf_map *map, struct qp_trie_branch *old, unsigned int bitmap)
>> +{
>> +       unsigned int nr = calc_twig_nr(old->bitmap);
>> +       unsigned int p = calc_twig_index(old->bitmap, bitmap);
>> +       struct qp_trie_branch *twigs;
>> +
>> +       twigs = qp_trie_branch_new(map, nr - 1);
>> +       if (!twigs)
>> +               return NULL;
>> +
>> +       if (p)
>> +               memcpy(twigs->nodes, old->nodes, p * sizeof(*twigs->nodes));
>> +       if (nr - 1 > p)
>> +               memcpy(&twigs->nodes[p], &old->nodes[p+1], (nr - 1 - p) * sizeof(*twigs->nodes));
>> +
>> +       twigs->bitmap = old->bitmap & ~bitmap;
>> +       twigs->index = old->index;
>> +       RCU_INIT_POINTER(twigs->parent, old->parent);
>> +
>> +       qp_trie_update_parent(twigs, nr - 1);
>> +
>> +       return twigs;
>> +}
>> +
>> +static struct qp_trie_key *
>> +qp_trie_init_leaf_node(struct bpf_map *map, const struct bpf_dynptr_kern *k, void *v)
>> +{
>> +       unsigned int key_size, total;
>> +       struct qp_trie_key *new;
>> +
>> +       key_size = bpf_dynptr_get_size(k);
>> +       if (!key_size || key_size > (u32)map->map_extra)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       total = round_up(sizeof(*new) + key_size + map->value_size, QP_TRIE_LEAF_ALLOC_ALIGN);
>> +       new = bpf_map_kmalloc_node(map, total, GFP_NOWAIT | __GFP_NOWARN, map->numa_node);
>> +       if (!new)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       new->len = key_size;
>> +       memcpy(new->data, k->data + k->offset, key_size);
>> +       memcpy((void *)&new[1] + key_size, v, map->value_size);
>> +
>> +       return new;
>> +}
>> +
>> +static bool calc_prefix_len(const struct qp_trie_key *s_key, const struct qp_trie_key *n_key,
>> +                           unsigned int *index)
>> +{
>> +       unsigned int i, len = min(s_key->len, n_key->len);
>> +       unsigned char diff = 0;
>> +
>> +       for (i = 0; i < len; i++) {
>> +               diff = s_key->data[i] ^ n_key->data[i];
>> +               if (diff)
>> +                       break;
>> +       }
>> +
>> +       *index = (i << QP_TRIE_BYTE_INDEX_SHIFT) | QP_TRIE_NON_ROOT_NODE_MASK;
>> +       if (!diff)
>> +               return s_key->len == n_key->len;
>> +
>> +       *index += (diff & 0xf0) ? 0 : (1U << QP_TRIE_NIBBLE_SHIFT);
>> +       return false;
>> +}
>> +
>> +static int qp_trie_new_branch(struct qp_trie *trie, struct qp_trie_branch __rcu **parent,
>> +                             unsigned int bitmap, void *sibling, struct qp_trie_diff *d,
>> +                             const struct qp_trie_key *leaf)
>> +{
>> +       struct qp_trie_branch *new_child_twigs, *new_twigs, *old_twigs;
>> +       struct bpf_map *map;
>> +       unsigned int iip;
>> +       int err;
>> +
>> +       map = &trie->map;
>> +       if (atomic_inc_return(&trie->entries) > map->max_entries) {
>> +               err = -ENOSPC;
>> +               goto dec_entries;
>> +       }
>> +
>> +       new_child_twigs = qp_trie_branch_new(map, 2);
>> +       if (!new_child_twigs) {
>> +               err = -ENOMEM;
>> +               goto dec_entries;
>> +       }
>> +
>> +       new_child_twigs->index = d->index;
>> +       new_child_twigs->bitmap = d->sibling_bm | d->new_bm;
>> +
>> +       iip = calc_twig_index(new_child_twigs->bitmap, d->sibling_bm);
>> +       RCU_INIT_POINTER(new_child_twigs->nodes[iip], sibling);
>> +       rcu_assign_pointer(new_child_twigs->nodes[!iip], to_child_node(leaf));
>> +       RCU_INIT_POINTER(new_child_twigs->parent, NULL);
>> +
>> +       old_twigs = rcu_dereference_protected(*parent, 1);
>> +       new_twigs = qp_trie_branch_replace(map, old_twigs, bitmap, new_child_twigs);
>> +       if (!new_twigs) {
>> +               err = -ENOMEM;
>> +               goto free_child_twigs;
>> +       }
>> +
>> +       qp_trie_assign_parent(new_child_twigs, sibling);
>> +       rcu_assign_pointer(*parent, new_twigs);
>> +       qp_trie_branch_free(old_twigs, QP_TRIE_TWIGS_FREE_NONE_IDX);
>> +
>> +       return 0;
>> +
>> +free_child_twigs:
>> +       kfree(new_child_twigs);
>> +dec_entries:
>> +       atomic_dec(&trie->entries);
>> +       return err;
>> +}
>> +
>> +static int qp_trie_ext_branch(struct qp_trie *trie, struct qp_trie_branch __rcu **parent,
>> +                             const struct qp_trie_key *new, unsigned int bitmap)
>> +{
>> +       struct qp_trie_branch *old_twigs, *new_twigs;
>> +       struct bpf_map *map;
>> +       int err;
>> +
>> +       map = &trie->map;
>> +       if (atomic_inc_return(&trie->entries) > map->max_entries) {
>> +               err = -ENOSPC;
>> +               goto dec_entries;
>> +       }
>> +
>> +       old_twigs = rcu_dereference_protected(*parent, 1);
>> +       new_twigs = qp_trie_branch_insert(map, old_twigs, bitmap, new);
>> +       if (!new_twigs) {
>> +               err = -ENOMEM;
>> +               goto dec_entries;
>> +       }
>> +
>> +       rcu_assign_pointer(*parent, new_twigs);
>> +       qp_trie_branch_free(old_twigs, QP_TRIE_TWIGS_FREE_NONE_IDX);
>> +
>> +       return 0;
>> +
>> +dec_entries:
>> +       atomic_dec(&trie->entries);
>> +       return err;
>> +}
>> +
>> +static int qp_trie_add_leaf_node(struct qp_trie *trie, struct qp_trie_branch __rcu **parent,
>> +                                const struct qp_trie_key *new)
>> +{
>> +       struct bpf_map *map = &trie->map;
>> +       struct qp_trie_branch *twigs;
>> +       int err;
>> +
>> +       if (atomic_inc_return(&trie->entries) > map->max_entries) {
>> +               err = -ENOSPC;
>> +               goto dec_entries;
>> +       }
>> +
>> +       twigs = qp_trie_branch_new(map, 1);
>> +       if (!twigs) {
>> +               err = -ENOMEM;
>> +               goto dec_entries;
>> +       }
>> +       twigs->index = QP_TRIE_ROOT_NODE_INDEX;
>> +       twigs->bitmap = 1;
>> +       RCU_INIT_POINTER(twigs->parent, NULL);
>> +       rcu_assign_pointer(twigs->nodes[0], to_child_node(new));
>> +
>> +       rcu_assign_pointer(*parent, twigs);
>> +
>> +       return 0;
>> +dec_entries:
>> +       atomic_dec(&trie->entries);
>> +       return err;
>> +}
>> +
>> +static int qp_trie_rep_leaf_node(struct qp_trie *trie, struct qp_trie_branch __rcu **parent,
>> +                                const struct qp_trie_key *new, unsigned int bitmap)
>> +{
>> +       struct qp_trie_branch *old_twigs, *new_twigs;
>> +       struct bpf_map *map = &trie->map;
>> +
>> +       /* Only branch node is freed by RCU, so replace the old branch node
>> +        * and free the old leaf node together with the old branch node.
>> +        */
>> +       old_twigs = rcu_dereference_protected(*parent, 1);
>> +       new_twigs = qp_trie_branch_replace(map, old_twigs, bitmap, to_child_node(new));
>> +       if (!new_twigs)
>> +               return -ENOMEM;
>> +
>> +       rcu_assign_pointer(*parent, new_twigs);
>> +
>> +       qp_trie_branch_free(old_twigs, calc_twig_index(old_twigs->bitmap, bitmap));
>> +
>> +       return 0;
>> +}
>> +
>> +static int qp_trie_remove_leaf(struct qp_trie *trie, struct qp_trie_branch __rcu **parent,
>> +                              unsigned int bitmap, const struct qp_trie_key *node)
>> +{
>> +       struct bpf_map *map = &trie->map;
>> +       struct qp_trie_branch *new, *old;
>> +       unsigned int nr;
>> +
>> +       old = rcu_dereference_protected(*parent, 1);
>> +       nr = calc_twig_nr(old->bitmap);
>> +       if (nr > 2) {
>> +               new = qp_trie_branch_remove(map, old, bitmap);
>> +               if (!new)
>> +                       return -ENOMEM;
>> +       } else {
>> +               new = NULL;
>> +       }
>> +
>> +       rcu_assign_pointer(*parent, new);
>> +
>> +       qp_trie_branch_free(old, calc_twig_index(old->bitmap, bitmap));
>> +
>> +       atomic_dec(&trie->entries);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qp_trie_merge_node(struct qp_trie *trie, struct qp_trie_branch __rcu **grand_parent,
>> +                             struct qp_trie_branch *parent, unsigned int parent_bitmap,
>> +                             unsigned int bitmap)
>> +{
>> +       struct qp_trie_branch *old_twigs, *new_twigs;
>> +       struct bpf_map *map = &trie->map;
>> +       void *new_sibling;
>> +       unsigned int iip;
>> +
>> +       iip = calc_twig_index(parent->bitmap, bitmap);
>> +       new_sibling = rcu_dereference_protected(parent->nodes[!iip], 1);
>> +
>> +       old_twigs = rcu_dereference_protected(*grand_parent, 1);
>> +       new_twigs = qp_trie_branch_replace(map, old_twigs, parent_bitmap, new_sibling);
>> +       if (!new_twigs)
>> +               return -ENOMEM;
>> +
>> +       rcu_assign_pointer(*grand_parent, new_twigs);
>> +
>> +       qp_trie_branch_free(old_twigs, QP_TRIE_TWIGS_FREE_NONE_IDX);
>> +       qp_trie_branch_free(parent, iip);
>> +
>> +       atomic_dec(&trie->entries);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qp_trie_alloc_check(union bpf_attr *attr)
>> +{
>> +       if (!bpf_capable())
>> +               return -EPERM;
>> +
>> +       if ((attr->map_flags & QP_TRIE_MANDATORY_FLAG_MASK) != QP_TRIE_MANDATORY_FLAG_MASK ||
>> +           attr->map_flags & ~QP_TRIE_CREATE_FLAG_MASK ||
>> +           !bpf_map_flags_access_ok(attr->map_flags))
>> +               return -EINVAL;
>> +
>> +       if (!attr->max_entries || !attr->value_size)
>> +               return -EINVAL;
>> +
>> +       /* Key and value are allocated together in qp_trie_init_leaf_node() */
>> +       if (round_up((u64)sizeof(struct qp_trie_key) + (u32)attr->map_extra + attr->value_size,
>> +                    QP_TRIE_LEAF_ALLOC_ALIGN) >= KMALLOC_MAX_SIZE)
>> +               return -E2BIG;
>> +
>> +       return 0;
>> +}
>> +
>> +static struct bpf_map *qp_trie_alloc(union bpf_attr *attr)
>> +{
>> +       struct qp_trie *trie;
>> +       unsigned int i;
>> +
>> +       trie = bpf_map_area_alloc(sizeof(*trie), bpf_map_attr_numa_node(attr));
>> +       if (!trie)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       /* roots are zeroed by bpf_map_area_alloc() */
>> +       for (i = 0; i < QP_TRIE_NR_SUBTREE; i++)
>> +               spin_lock_init(&trie->locks[i]);
>> +
>> +       atomic_set(&trie->entries, 0);
>> +       bpf_map_init_from_attr(&trie->map, attr);
>> +
>> +       return &trie->map;
>> +}
>> +
>> +static void qp_trie_free_subtree(void *root)
>> +{
>> +       struct qp_trie_branch *parent = NULL;
>> +       struct qp_trie_key *cur = NULL;
>> +       void *node = root;
>> +
>> +       /*
>> +        * Depth-first deletion
>> +        *
>> +        * 1. find left-most key and its parent
>> +        * 2. get next sibling Y from parent
>> +        * (a) Y is leaf node: continue
>> +        * (b) Y is branch node: goto step 1
>> +        * (c) no more sibling: backtrace upwards if parent is not NULL and
>> +        *     goto step 1
>> +        */
>> +       do {
>> +               while (is_branch_node(node)) {
>> +                       parent = node;
>> +                       node = rcu_dereference_raw(parent->nodes[0]);
>> +               }
>> +
>> +               cur = to_leaf_node(node);
>> +               while (parent) {
>> +                       unsigned int iip, bitmap, nr;
>> +                       void *ancestor;
>> +
>> +                       bitmap = calc_br_bitmap(parent->index, cur->data, cur->len);
>> +                       iip = calc_twig_index(parent->bitmap, bitmap) + 1;
>> +                       nr = calc_twig_nr(parent->bitmap);
>> +
>> +                       for (; iip < nr; iip++) {
>> +                               kfree(cur);
>> +
>> +                               node = rcu_dereference_raw(parent->nodes[iip]);
>> +                               if (is_branch_node(node))
>> +                                       break;
>> +
>> +                               cur = to_leaf_node(node);
>> +                       }
>> +                       if (iip < nr)
>> +                               break;
>> +
>> +                       ancestor = rcu_dereference_raw(parent->parent);
>> +                       kfree(parent);
>> +                       parent = ancestor;
>> +               }
>> +       } while (parent);
>> +
>> +       kfree(cur);
>> +}
>> +
>> +static void qp_trie_free(struct bpf_map *map)
>> +{
>> +       struct qp_trie *trie = container_of(map, struct qp_trie, map);
>> +       unsigned int i;
>> +
>> +       /* Wait for the pending qp_trie_free_twigs_rcu() */
>> +       rcu_barrier();
>> +
>> +       for (i = 0; i < ARRAY_SIZE(trie->roots); i++) {
>> +               void *root = rcu_dereference_raw(trie->roots[i]);
>> +
>> +               if (root)
>> +                       qp_trie_free_subtree(root);
>> +       }
>> +       bpf_map_area_free(trie);
>> +}
>> +
>> +static inline void qp_trie_copy_leaf(const struct qp_trie_key *leaf, struct bpf_dynptr_kern *key)
>> +{
>> +       memcpy(key->data + key->offset, leaf->data, leaf->len);
>> +       bpf_dynptr_set_size(key, leaf->len);
>> +}
>> +
>> +static void qp_trie_copy_min_key_from(void *root, struct bpf_dynptr_kern *key)
>> +{
>> +       void *node;
>> +
>> +       node = root;
>> +       while (is_branch_node(node))
>> +               node = rcu_dereference(((struct qp_trie_branch *)node)->nodes[0]);
>> +
>> +       qp_trie_copy_leaf(to_leaf_node(node), key);
>> +}
>> +
>> +static int qp_trie_lookup_min_key(struct qp_trie *trie, unsigned int from,
>> +                                 struct bpf_dynptr_kern *key)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = from; i < ARRAY_SIZE(trie->roots); i++) {
>> +               void *root = rcu_dereference(trie->roots[i]);
>> +
>> +               if (root) {
>> +                       qp_trie_copy_min_key_from(root, key);
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       return -ENOENT;
>> +}
>> +
>> +static int qp_trie_next_twigs_index(struct qp_trie_branch *twigs, unsigned int bitmap)
>> +{
>> +       unsigned int idx, nr, next;
>> +
>> +       /* bitmap may not in twigs->bitmap */
>> +       idx = calc_twig_index(twigs->bitmap, bitmap);
>> +       nr = calc_twig_nr(twigs->bitmap);
>> +
>> +       next = idx;
>> +       if (twigs->bitmap & bitmap)
>> +               next += 1;
>> +
>> +       if (next >= nr)
>> +               return -1;
>> +       return next;
>> +}
>> +
>> +static int qp_trie_lookup_next_node(struct qp_trie *trie, const struct bpf_dynptr_kern *key,
>> +                                   struct bpf_dynptr_kern *next_key)
>> +{
>> +       const struct qp_trie_key *found;
>> +       struct qp_trie_branch *parent;
>> +       const unsigned char *data;
>> +       unsigned int data_len;
>> +       void *node, *next;
>> +
>> +       /* Non-existent key, so restart from the beginning */
>> +       data = key->data + key->offset;
>> +       node = rcu_dereference(trie->roots[*data]);
>> +       if (!node)
>> +               return qp_trie_lookup_min_key(trie, 0, next_key);
>> +
>> +       parent = NULL;
>> +       data_len = bpf_dynptr_get_size(key);
>> +       while (is_branch_node(node)) {
>> +               struct qp_trie_branch *br = node;
>> +               unsigned int iip, bitmap;
>> +
>> +               bitmap = calc_br_bitmap(br->index, data, data_len);
>> +               if (bitmap & br->bitmap)
>> +                       iip = calc_twig_index(br->bitmap, bitmap);
>> +               else
>> +                       iip = 0;
>> +
>> +               parent = br;
>> +               node = rcu_dereference(br->nodes[iip]);
>> +       }
>> +       found = to_leaf_node(node);
>> +       if (!is_same_key(found, data, data_len))
>> +               return qp_trie_lookup_min_key(trie, 0, next_key);
>> +
>> +       /* Pair with store release in rcu_assign_pointer(*parent, twigs) to
>> +        * ensure reading node->parent will not return the old parent if
>> +        * the node is found by following the newly-created parent.
>> +        */
>> +       smp_rmb();
>> +
>> +       next = NULL;
>> +       while (parent) {
>> +               unsigned int bitmap;
>> +               int next_idx;
>> +
>> +               bitmap = calc_br_bitmap(parent->index, data, data_len);
>> +               next_idx = qp_trie_next_twigs_index(parent, bitmap);
>> +               if (next_idx >= 0) {
>> +                       next = rcu_dereference(parent->nodes[next_idx]);
>> +                       break;
>> +               }
>> +               parent = rcu_dereference(parent->parent);
>> +       }
>> +
>> +       /* Goto next sub-tree */
>> +       if (!next)
>> +               return qp_trie_lookup_min_key(trie, *data + 1, next_key);
>> +
>> +       if (!is_branch_node(next))
>> +               qp_trie_copy_leaf(to_leaf_node(next), next_key);
>> +       else
>> +               qp_trie_copy_min_key_from(next, next_key);
>> +
>> +       return 0;
>> +}
>> +
>> +/* Called from syscall */
>> +static int qp_trie_get_next_key(struct bpf_map *map, void *key, void *next_key)
>> +{
>> +       struct qp_trie *trie = container_of(map, struct qp_trie, map);
>> +       int err;
>> +
>> +       if (!key)
>> +               err = qp_trie_lookup_min_key(trie, 0, next_key);
>> +       else
>> +               err = qp_trie_lookup_next_node(trie, key, next_key);
>> +       return err;
>> +}
>> +
>> +/* Called from syscall or from eBPF program */
>> +static void *qp_trie_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +       struct qp_trie *trie = container_of(map, struct qp_trie, map);
>> +       const struct bpf_dynptr_kern *dynptr_key = key;
>> +       const struct qp_trie_key *found;
>> +       const unsigned char *data;
>> +       unsigned int data_len;
>> +       void *node, *value;
>> +
>> +       /* Dynptr with zero length is possible, but is invalid for qp-trie */
>> +       data_len = bpf_dynptr_get_size(dynptr_key);
>> +       if (!data_len)
>> +               return NULL;
>> +
>> +       data = dynptr_key->data + dynptr_key->offset;
>> +       node = rcu_dereference_check(trie->roots[*data], rcu_read_lock_bh_held());
>> +       if (!node)
>> +               return NULL;
>> +
>> +       value = NULL;
>> +       while (is_branch_node(node)) {
>> +               struct qp_trie_branch *br = node;
>> +               unsigned int bitmap;
>> +               unsigned int iip;
>> +
>> +               /* When byte index equals with key len, the target key
>> +                * may be in twigs->nodes[0].
>> +                */
>> +               if (index_to_byte_index(br->index) > data_len)
>> +                       goto done;
>> +
>> +               bitmap = calc_br_bitmap(br->index, data, data_len);
>> +               if (!(bitmap & br->bitmap))
>> +                       goto done;
>> +
>> +               iip = calc_twig_index(br->bitmap, bitmap);
>> +               node = rcu_dereference_check(br->nodes[iip], rcu_read_lock_bh_held());
>> +       }
>> +
>> +       found = to_leaf_node(node);
>> +       if (is_same_key(found, data, data_len))
>> +               value = qp_trie_leaf_value(found);
>> +done:
>> +       return value;
>> +}
>> +
>> +/* Called from syscall or from eBPF program */
>> +static int qp_trie_update_elem(struct bpf_map *map, void *key, void *value, u64 flags)
>> +{
>> +       struct qp_trie *trie = container_of(map, struct qp_trie, map);
>> +       const struct qp_trie_key *leaf_key, *new_key;
>> +       struct qp_trie_branch __rcu **parent;
>> +       struct qp_trie_diff d;
>> +       unsigned int bitmap;
>> +       void __rcu **node;
>> +       spinlock_t *lock;
>> +       unsigned char c;
>> +       bool equal;
>> +       int err;
>> +
>> +       if (flags > BPF_EXIST)
>> +               return -EINVAL;
>> +
>> +       /* The content of key may change, so copy it firstly */
>> +       new_key = qp_trie_init_leaf_node(map, key, value);
>> +       if (IS_ERR(new_key))
>> +               return PTR_ERR(new_key);
>> +
>> +       c = new_key->data[0];
>> +       lock = &trie->locks[c];
>> +       spin_lock(lock);
>> +       parent = (struct qp_trie_branch __rcu **)&trie->roots[c];
>> +       if (!rcu_dereference_protected(*parent, 1)) {
>> +               if (flags == BPF_EXIST) {
>> +                       err = -ENOENT;
>> +                       goto unlock;
>> +               }
>> +               err = qp_trie_add_leaf_node(trie, parent, new_key);
>> +               goto unlock;
>> +       }
>> +
>> +       bitmap = 1;
>> +       node = &rcu_dereference_protected(*parent, 1)->nodes[0];
>> +       while (is_branch_node(rcu_dereference_protected(*node, 1))) {
>> +               struct qp_trie_branch *br = rcu_dereference_protected(*node, 1);
>> +               unsigned int iip;
>> +
>> +               bitmap = calc_br_bitmap(br->index, new_key->data, new_key->len);
>> +               if (bitmap & br->bitmap)
>> +                       iip = calc_twig_index(br->bitmap, bitmap);
>> +               else
>> +                       iip = 0;
>> +               parent = (struct qp_trie_branch __rcu **)node;
>> +               node = &br->nodes[iip];
>> +       }
>> +
>> +       leaf_key = to_leaf_node(rcu_dereference_protected(*node, 1));
>> +       equal = calc_prefix_len(leaf_key, new_key, &d.index);
>> +       if (equal) {
>> +               if (flags == BPF_NOEXIST) {
>> +                       err = -EEXIST;
>> +                       goto unlock;
>> +               }
>> +               err = qp_trie_rep_leaf_node(trie, parent, new_key, bitmap);
>> +               goto unlock;
>> +       }
>> +
>> +       d.sibling_bm = calc_br_bitmap(d.index, leaf_key->data, leaf_key->len);
>> +       d.new_bm = calc_br_bitmap(d.index, new_key->data, new_key->len);
>> +
>> +       bitmap = 1;
>> +       parent = (struct qp_trie_branch __rcu **)&trie->roots[c];
>> +       node = &rcu_dereference_protected(*parent, 1)->nodes[0];
>> +       while (is_branch_node(rcu_dereference_protected(*node, 1))) {
>> +               struct qp_trie_branch *br = rcu_dereference_protected(*node, 1);
>> +               unsigned int iip;
>> +
>> +               if (d.index < br->index)
>> +                       goto new_branch;
>> +
>> +               parent = (struct qp_trie_branch __rcu **)node;
>> +               if (d.index == br->index) {
>> +                       if (flags == BPF_EXIST) {
>> +                               err = -ENOENT;
>> +                               goto unlock;
>> +                       }
>> +                       err = qp_trie_ext_branch(trie, parent, new_key, d.new_bm);
>> +                       goto unlock;
>> +               }
>> +
>> +               bitmap = calc_br_bitmap(br->index, new_key->data, new_key->len);
>> +               iip = calc_twig_index(br->bitmap, bitmap);
>> +               node = &br->nodes[iip];
>> +       }
>> +
>> +new_branch:
>> +       if (flags == BPF_EXIST) {
>> +               err = -ENOENT;
>> +               goto unlock;
>> +       }
>> +       err = qp_trie_new_branch(trie, parent, bitmap, rcu_dereference_protected(*node, 1),
>> +                                &d, new_key);
>> +unlock:
>> +       spin_unlock(lock);
>> +       if (err)
>> +               kfree(new_key);
>> +       return err;
>> +}
>> +
>> +/* Called from syscall or from eBPF program */
>> +static int qp_trie_delete_elem(struct bpf_map *map, void *key)
>> +{
>> +       struct qp_trie *trie = container_of(map, struct qp_trie, map);
>> +       unsigned int bitmap, parent_bitmap, data_len, nr;
>> +       struct qp_trie_branch __rcu **parent, **grand_parent;
>> +       const struct bpf_dynptr_kern *dynptr_key;
>> +       const struct qp_trie_key *found;
>> +       const unsigned char *data;
>> +       void __rcu **node;
>> +       spinlock_t *lock;
>> +       unsigned char c;
>> +       int err;
>> +
>> +       dynptr_key = key;
>> +       data_len = bpf_dynptr_get_size(dynptr_key);
>> +       if (!data_len)
>> +               return -EINVAL;
>> +
>> +       err = -ENOENT;
>> +       data = dynptr_key->data + dynptr_key->offset;
>> +       c = *data;
>> +       lock = &trie->locks[c];
>> +       spin_lock(lock);
>> +       parent = (struct qp_trie_branch __rcu **)&trie->roots[c];
>> +       if (!*parent)
>> +               goto unlock;
>> +
>> +       grand_parent = NULL;
>> +       parent_bitmap = bitmap = 1;
>> +       node = &rcu_dereference_protected(*parent, 1)->nodes[0];
>> +       while (is_branch_node(rcu_dereference_protected(*node, 1))) {
>> +               struct qp_trie_branch *br = rcu_dereference_protected(*node, 1);
>> +               unsigned int iip;
>> +
>> +               if (index_to_byte_index(br->index) > data_len)
>> +                       goto unlock;
>> +
>> +               parent_bitmap = bitmap;
>> +               bitmap = calc_br_bitmap(br->index, data, data_len);
>> +               if (!(bitmap & br->bitmap))
>> +                       goto unlock;
>> +
>> +               grand_parent = parent;
>> +               parent = (struct qp_trie_branch __rcu **)node;
>> +               iip = calc_twig_index(br->bitmap, bitmap);
>> +               node = &br->nodes[iip];
>> +       }
>> +
>> +       found = to_leaf_node(rcu_dereference_protected(*node, 1));
>> +       if (!is_same_key(found, data, data_len))
>> +               goto unlock;
>> +
>> +       nr = calc_twig_nr(rcu_dereference_protected(*parent, 1)->bitmap);
>> +       if (nr != 2)
>> +               err = qp_trie_remove_leaf(trie, parent, bitmap, found);
>> +       else
>> +               err = qp_trie_merge_node(trie, grand_parent, rcu_dereference_protected(*parent, 1),
>> +                                        parent_bitmap, bitmap);
>> +unlock:
>> +       spin_unlock(lock);
>> +       return err;
>> +}
>> +
>> +static int qp_trie_check_btf(const struct bpf_map *map,
>> +                            const struct btf *btf,
>> +                            const struct btf_type *key_type,
>> +                            const struct btf_type *value_type)
>> +{
>> +       return 0;
>> +}
>> +
>> +BTF_ID_LIST_SINGLE(qp_trie_map_btf_ids, struct, qp_trie)
>> +const struct bpf_map_ops qp_trie_map_ops = {
>> +       .map_alloc_check = qp_trie_alloc_check,
>> +       .map_alloc = qp_trie_alloc,
>> +       .map_free = qp_trie_free,
>> +       .map_get_next_key = qp_trie_get_next_key,
>> +       .map_lookup_elem = qp_trie_lookup_elem,
>> +       .map_update_elem = qp_trie_update_elem,
>> +       .map_delete_elem = qp_trie_delete_elem,
>> +       .map_meta_equal = bpf_map_meta_equal,
>> +       .map_check_btf = qp_trie_check_btf,
>> +       .map_btf_id = &qp_trie_map_btf_ids[0],
>> +};
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 600c3fcee37a..1591f0df46f3 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -928,6 +928,7 @@ enum bpf_map_type {
>>         BPF_MAP_TYPE_INODE_STORAGE,
>>         BPF_MAP_TYPE_TASK_STORAGE,
>>         BPF_MAP_TYPE_BLOOM_FILTER,
>> +       BPF_MAP_TYPE_QP_TRIE,
>>  };
>>
>>  /* Note that tracing related programs such as
>> --
>> 2.29.2
>>


