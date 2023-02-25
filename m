Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5596A2780
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 07:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjBYGXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 01:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYGXp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 01:23:45 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D52624480
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 22:23:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PNxXj30Sbz4f3knY
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 14:23:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6thqflj1oAcEQ--.12260S2;
        Sat, 25 Feb 2023 14:23:32 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
Subject: [LSF/MM/BPF TOPIC] Make bpf memory allocator more robust
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>, linux-mm@kvack.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        David Vernet <void@manifault.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>
Message-ID: <2d29f66f-fcb1-ec76-c74f-d12495a9516f@huaweicloud.com>
Date:   Sat, 25 Feb 2023 14:23:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgBnF6thqflj1oAcEQ--.12260S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GryUGw13Aryktw1xtFy7KFg_yoW7tF1UpF
        WfK3y3Gr90qFn7C34vqw17Ga4YywsYqr15Gr1Fvw15u3y3Wry7ur4SvayYvFy5uFsrGa4U
        trnFvF1DZ3ykXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf memory allocator was introduced in v6.1 by Alexei Starovoitov [0]. Its main
purpose is to provide an any-context allocator for bpf program which can be
attached to anywhere (e.g., __kmalloc()) and any context (e.g., the NMI context
through perf_event_overflow()). Before that, only pre-allocated hash map is
usable for these contexts but it incurs memory waste because typically hash
table is sparse. In addition to the memory saving, it also increases the
performance of dynamically allocated hash map significantly and makes the
hash-map usable for sleep-able program. As more use cases of bpf memory
allocator emerges, it seems that there are some problems that need to be
discussed and fixed.

The first problem is the immediate reuse of elements in bpf memory allocator. 
The reason for immediate reuse is to prevent OOM for typical usage scenario for
bpf hash map, but it introduces use-after-free problem [1] for
dynamically-allocated hash table although the problems existed for pre-allocated
hash-table since it was introduced. For hash-table, the reuse problem may be
acceptable for hash table, but the reuse makes introducing new use cases more
difficult.

For example, in bpf-qp-trie [2] the internal nodes of qp-trie are managed by bpf
memory allocator, if internal node used during lookup is freed and reused, the
lookup procedure may panic or return an incorrect result. Although I have
already implemented a qp-trie demo in which two version numbers are added for
each internal node to ensure its validity: one version is saved in its parent
node and another in itself, but I am not sure about its correctness. bpf_cpumask
was introduced recently [3] is another example, in bpf_cpumask_kptr_get() it
checks the validity of bpf_cpumask by checking whether or not its usage is zero,
but I don't know how does it handle the reuse of bpf_cpumask if the cpumask is
freed and then reused by another bpf_cpumask_create() call.

Alexei proposed using BPF_MA_REUSE_AFTER_GP [4] to solve the reuse problem. For
bpf ma with BPF_MA_REUSE_AFTER_GP, the freed objects are reused only after one
RCU grace period and are returned back to slab system after one-RCU-grace-period
and one-RCU-tasks-trace grace period. So for bpf programs which care about reuse
problem, these programs can use bpf_rcu_read_{lock,unlock}() to access these
freed objects safely and for  those which doesn't care, there will be safely
use-after-free because these objects have not been returned to slab subsystem. I
was worried about the possibility of OOM for BPF_MA_REUSE_AFTER_GP, so I
proposed using BPF_MA_FREE_AFTER_GP [5] to directly return these freed objects
to slab system after one RCU grace period and enforce the accesses of these
objects are protected by bpf_rcu_read_{lock,unlock}(). But if
BPF_MA_FREE_AFTER_GP is used by local storage, it may break existing sleep-able
program. Currently, I am working on BPF_MA_REUSE_AFTER_GP  with Martin. Hope to
work out an RFC soon.

Another problem is the potential OOM problem. bpf memory allocator is more
suitable for the following case: alloc, free, alloc, free on the same CPU. The
above use case is also the typical use case for hash table, but for other use
cases, bpf memory allocator doesn't handle the scenario well and may incur OOM.
One such use case is batched allocation and batched freeing on same CPU.
According to [6], for a small hash table, the peak memory for this use case can
increase to 860MB or more. Another use case is allocation and free are done on
different CPUs [6]. Memory usage exposure can easily occur for such case,
because there is no reuse and these freed objects can only be returned to
subsystem after one RCU tasks-trace grace period.

I think the potential OOM problem can be attacked by two ways. One is returning
these freed objects to slab system timely. Although some work (e.g., skip
unnecessary call_rcu for freeing [7]) has been done, but I think it is not
enough. For example, for bpf_global_ma, because it will not be destroyed like
bpf ma in hash-tab, so there may still be freed objects in per-cpu free_by_rcu
list and will not be freed if there is no free operations on this CPU
afterwards. Also there is no ways to limit the memory usage of bpf_global_ma
because its usage is accounted under root memcg, so maybe a shrinker is also
needed to free some memory back to slab system. Another example is CPU hot-plug.
Because bpf memory allocator is a per-CPU allocator, so when one CPU is offline,
all freed elements need be returned to slab system and when the CPU is online,
we may need to do pre-fill for it. Another approach is to try to reuse freed
object if possible. One fix [6] had already been done to fix the batched
allocation and freed case, but for the case of allocation and freeing on
different CPUs, it seems we may need to share freed object among multiple CPUs 
and do it cheaply.

Not sure whether or not the issues above are important enough for a session, but
I think a discussion in mail-list will be helpful as well.

0: https://lore.kernel.org/bpf/20220902211058.60789-1-alexei.starovoitov@gmail.com/
1: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
2: https://lore.kernel.org/bpf/20220924133620.4147153-1-houtao@huaweicloud.com/
3: https://lore.kernel.org/bpf/20230125143816.721952-1-void@manifault.com/
4:
https://lore.kernel.org/bpf/CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com/
5: https://lore.kernel.org/bpf/2a58c4a8-781f-6d84-e72a-f8b7117762b4@huaweicloud.com/
6: https://lore.kernel.org/bpf/20221209010947.3130477-1-houtao@huaweicloud.com/
7: https://lore.kernel.org/bpf/20221014113946.965131-3-houtao@huaweicloud.com/

