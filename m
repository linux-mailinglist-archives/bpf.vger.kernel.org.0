Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DC158D550
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 10:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiHIIZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHIIZY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 04:25:24 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FCF2B
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 01:25:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M25gw57MFzKrTH
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 16:23:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAXAb3pGfJiFQp7AA--.26839S2;
        Tue, 09 Aug 2022 16:25:17 +0800 (CST)
From:   houtao <houtao@huaweicloud.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Add support for qp-trie map
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>
References: <20220726130005.3102470-1-houtao1@huawei.com>
 <CAEf4BzYdC=G0CzbiXm4gnT5EKHuGfAiFnYRyzf0nNeuAU-T4pw@mail.gmail.com>
Message-ID: <1efd3943-4068-24ab-dd57-e42b5958106c@huaweicloud.com>
Date:   Tue, 9 Aug 2022 16:25:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYdC=G0CzbiXm4gnT5EKHuGfAiFnYRyzf0nNeuAU-T4pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAXAb3pGfJiFQp7AA--.26839S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFyxtF1kCr47AryxtF4DCFg_yoW8Jr1DXo
        WrGrW7X3y8Kw12ya4q9wn7Wa45Cr97Ga43XrsxXws8XF98tFWq9345Cws3WFZIvF13Wr17
        Z3s0q3s8WrZ5Krn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/3/2022 6:38 AM, Andrii Nakryiko wrote:
> On Tue, Jul 26, 2022 at 5:42 AM Hou Tao <houtao1@huawei.com> wrote:
>> Hi,
>>
> Hey, sorry I'm catching up on upstream and there is just too many
> complicated patch sets coming in, so it takes time to get through
> them.
>
> I think you did a great job with this implementation, it's certainly
> worth submitting as non-RFC for proper upstream review. I know that
> some people didn't get your patches, they got into spam somehow. So I
> think it would be great to just resubmit it as non-RFC so that it
> appears in patchworks as to-be-reviewew patches and hopefully will get
> a wider audience to review this.
Thanks for your encouragement.
The spam email is due to some misconfiguration in email servers of our company,
but it can not be fixed soon, so I change to use another email account and hope
that will fix the spam problem.

> I've tried to answer some questions below, but would definitely like
> more people to chime in. I haven't went through implementation in
> details, but superficially it looks pretty clean and certainly ready
> for proper non-RFC review.
>
> One point about user API would be to maybe instead use bpf_dynptr as
> an interface for specifying variable-sized lookup key instead of
> hard-coded
>  bpf_qp_trie_key. Please check recent work by Joanne on bpf_dynptr.
Will check how to archive that. Does that means we will have real
variable-length key instead of fixed-allocated-length key with
variable-used-length ?
> In short: looks great, I think it's certainly worth adding this as BPF
> map type. Please submit as non-RFC and go through a proper review
> process. Looking forward (even if that means reviewing 1000k lines of
> dense algorithmic code :) ).
Thanks. :)
>> The initial motivation for qp-trie map is to reduce memory usage for
>> string keys special those with large differencies in length as
>> discussed in [0]. And as a big-endian lexicographical ordered map, it
>> can also be used for any binary data with fixed or variable length.
>>
>> Now the basic functionality of qp-trie is ready, so posting a RFC version
>> to get more feedback or suggestions about qp-trie. Specially feedback
>> about the following questions:
>>
>> (1) Application scenario for qp-trie
>> Andrii had proposed to re-implement lpm-trie by using qp-trie. The
>> advantage would be the speed up of lookup operations due to lower tree
>> depth of qp-trie. Maybe the performance of update could also be improved
>> although in cillium there is a big lock during lpm-trie update [1]. Is
> Well, using qp-trie approach as an internal implementation of lpm-trie
> is probably a major win already, what's wrong with that?
I am OK with that. My concern is that you had mentioned that qp-trie could be
used to remove the global lock in lpm-trie, but now there are still subtree
locks in qp-trie, so I am not sure whether the scalability of qp-trie is still a
problem. I had searched users of lpm-trie in github and only found Cilium. In
its source code [0], the update and deletion procedure of lpm-trie are protected
by a big lock, so may be the global lock is not a big issue right now.

[0]:
https://github.com/cilium/cilium/blob/5145e31cd65db3361f6538d5f5f899440b769070/pkg/datapath/prefilter/prefilter.go#L123
>> there any other use cases for qp-trie ? Specially those cases which need
>> both ordering and memory efficiency or cases in which jhash() of htab
>> creates too much collisions and qp-trie lookup performances better than
>> hash-table lookup as shown below:
> I'm thinking about qp-trie as dynamically growable lookup table.
> That's a pretty big use case already. There is an RB tree proposal
> under review right now which would also satisfy dynamically growable
> criteria, but its focus is slightly different and it remains to be
> seen how convenient it will be as general-purpose resizable
> alternative to hashmap. But from benchmarks I've found online, RB tree
> will definitely use more memory than qp-trie.
qp-trie is also RCU-read safe which is hard for rb-tree to archive. I also hope
qp-trie will have better lookup performance than rb-tree.
> Ordered property seems also very useful, but I don't yet have specific
> use case for that. But once we have data structure like this in BPF,
> I'm sure use cases will pop up.
For ordered map, next() and prev() helpers will be useful, but now these is no
such support. Embedded rb_node in program-defined structure may make it easier
to implement such helpers. Maybe we can also add such helpers for qp-trie in the
next-step ?

>>   Randomly-generated binary data with variable length (length range=[1, 256] entries=16K)
>>
>>   htab lookup      (1  thread)    5.062 ± 0.004M/s (drops 0.002 ± 0.000M/s mem 8.125 MiB)
>>   htab lookup      (2  thread)   10.256 ± 0.017M/s (drops 0.006 ± 0.000M/s mem 8.114 MiB)
>>   htab lookup      (4  thread)   20.383 ± 0.006M/s (drops 0.009 ± 0.000M/s mem 8.117 MiB)
>>   htab lookup      (8  thread)   40.727 ± 0.093M/s (drops 0.010 ± 0.000M/s mem 8.123 MiB)
>>   htab lookup      (16 thread)   81.333 ± 0.311M/s (drops 0.020 ± 0.000M/s mem 8.122 MiB)
>>
>>   qp-trie lookup   (1  thread)   10.161 ± 0.008M/s (drops 0.006 ± 0.000M/s mem 4.847 MiB)
>>   qp-trie lookup   (2  thread)   20.287 ± 0.024M/s (drops 0.007 ± 0.000M/s mem 4.828 MiB)
>>   qp-trie lookup   (4  thread)   40.784 ± 0.020M/s (drops 0.015 ± 0.000M/s mem 4.071 MiB)
>>   qp-trie lookup   (8  thread)   81.165 ± 0.013M/s (drops 0.040 ± 0.000M/s mem 4.045 MiB)
>>   qp-trie lookup   (16 thread)  159.955 ± 0.014M/s (drops 0.108 ± 0.000M/s mem 4.495 MiB)
>>
> Kind of surprised that qp-tire is twice as fast as hashmap. Do you
> have any idea why hashmap is slower? Was htab pre-allocated? What was
> it's max_entries?
The hash table is not pre-allocated and pre-allocation doesn't help for lookup
performance in the benchmark. max_entries is 16K, and if set max_entries to 4K
or 128K, the performance win of qp-trie is almost the same (worse when data set
is bigger).

The better performance is due to two reasons:
(1) height of qp-trie is low due to the randomly-generated data
The top-most branch nodes in qp-trie are almost full and have 16 or 17 child
nodes. If using /proc/kallsyms as input data set, the number of child nodes of
top-most branch nodes are just about 2~4.

(2) large difference between used length of key
The max key size is 256, but the range of valid data length is [1, 255] and the
unused part is zeroed. For htab-lookup, it has to compare 256 bytes each time
during list traverse, but qp-trie only needs to compare the used length of key.

>>   * non-zero drops is due to duplicated keys in generated keys.
>>
>> (2) more fine-grained lock in qp-trie
>> Now qp-trie is divided into 256 sub-trees by using the first character of
> character -> byte, it's not always strings, right?
Yes, qp-trie supports arbitrary bytes array as the key.
>> key and one sub-tree is protected one spinlock. From the data below,
>> although the update/delete speed of qp-trie is slower compare with hash
>> table, but it scales similar with hash table. So maybe 256-locks is a
>> good enough solution ?
>>
>>   Strings in /proc/kallsyms
>>   htab update      (1  thread)    2.850 ± 0.129M/s (drops 0.000 ± 0.000M/s mem 33.564 MiB)
>>   htab update      (2  thread)    4.363 ± 0.031M/s (drops 0.000 ± 0.000M/s mem 33.563 MiB)
>>   htab update      (4  thread)    6.306 ± 0.096M/s (drops 0.000 ± 0.000M/s mem 33.718 MiB)
>>   htab update      (8  thread)    6.611 ± 0.026M/s (drops 0.000 ± 0.000M/s mem 33.627 MiB)
>>   htab update      (16 thread)    6.390 ± 0.015M/s (drops 0.000 ± 0.000M/s mem 33.564 MiB)
>>   qp-trie update   (1  thread)    1.157 ± 0.099M/s (drops 0.000 ± 0.000M/s mem 18.333 MiB)
>>   qp-trie update   (2  thread)    1.920 ± 0.062M/s (drops 0.000 ± 0.000M/s mem 18.293 MiB)
>>   qp-trie update   (4  thread)    2.630 ± 0.050M/s (drops 0.000 ± 0.000M/s mem 18.472 MiB)
>>   qp-trie update   (8  thread)    3.171 ± 0.027M/s (drops 0.000 ± 0.000M/s mem 18.301 MiB)
>>   qp-trie update   (16 thread)    3.782 ± 0.036M/s (drops 0.000 ± 0.000M/s mem 19.040 MiB)
> qp-trie being slower than htab matches my expectation and what I
> observed when trying to use qp-trie with libbpf. But I think for a lot
> of cases memory vs CPU tradeoff, coupled with ability to dynamically
> grow qp-trie will make this data structure worthwhile.
>
>
>> (3) Improve memory efficiency further
>> When using strings in BTF string section as a data set for qp-trie, the
>> slab memory usage showed in cgroup memory.stats file is about 11MB for
>> qp-trie and 15MB for hash table as shown below. However the theoretical
>> memory usage for qp-trie is ~6.8MB (is ~4.9MB if removing "parent" & "rcu"
>> fields from qp_trie_branch) and the extra memory usage (about 38% of total
>> usage) mainly comes from internal fragment in slab (namely 2^n alignment
>> for allocation) and overhead in kmem-cgroup accounting. We can reduce the
>> internal fragment by creating separated kmem_cache for qp_trie_branch with
>> different child nodes, but not sure whether it is worthy or not.
>>
> Please CC Paul McKenney (paulmck@kernel.org) for your non-RFC patch
> set and maybe he has some good idea how to avoid having rcu_head in
> each leaf node. Maybe some sort of per-CPU queue of to-be-rcu-freed
> elements, so that we don't have to keep 16 bytes in each leaf and
> branch node?
Will cc Paul. I found a head-less kfree_rcu() which only needs a pointer, but
its downside is the calling context needs to sleepable, so it doesn't fit. And
it seems that BPF specific memory allocator from Alexei can also help to remove
rcu_head in bpf map element, right ?
>> And in order to prevent allocating a rcu_head for each leaf node, now only
>> branch node is RCU-freed, so when replacing a leaf node, a new branch node
>> and a new leaf node will be allocated instead of replacing the old leaf
>> node and RCU-freed the old leaf node. Also not sure whether or not it is
>> worthy.
>>
>>   Strings in BTF string section (entries=115980):
>>   htab lookup      (1  thread)    9.889 ± 0.006M/s (drops 0.000 ± 0.000M/s mem 15.069 MiB)
>>   qp-trie lookup   (1  thread)    5.132 ± 0.002M/s (drops 0.000 ± 0.000M/s mem 10.721 MiB)
>>
>>   All files under linux kernel source directory (entries=74359):
>>   htab lookup      (1  thread)    8.418 ± 0.077M/s (drops 0.000 ± 0.000M/s mem 14.207 MiB)
>>   qp-trie lookup   (1  thread)    4.966 ± 0.003M/s (drops 0.000 ± 0.000M/s mem 9.355 MiB)
>>
>>   Domain names for Alexa top million web site (entries=1000000):
>>   htab lookup      (1  thread)    4.551 ± 0.043M/s (drops 0.000 ± 0.000M/s mem 190.761 MiB)
>>   qp-trie lookup   (1  thread)    2.804 ± 0.017M/s (drops 0.000 ± 0.000M/s mem 83.194 MiB)
>>
>> Comments and suggestions are always welcome.
>>
>> Regards,
>> Tao
>>
>> [0]: https://lore.kernel.org/bpf/CAEf4Bzb7keBS8vXgV5JZzwgNGgMV0X3_guQ_m9JW3X6fJBDpPQ@mail.gmail.com/
>> [1]: https://github.com/cilium/cilium/blob/5145e31cd65db3361f6538d5f5f899440b769070/pkg/datapath/prefilter/prefilter.go#L123
>>
>> Hou Tao (3):
>>   bpf: Add support for qp-trie map
>>   selftests/bpf: add a simple test for qp-trie
>>   selftests/bpf: add benchmark for qp-trie map
>>
>
>>  include/linux/bpf_types.h                     |    1 +
>>  include/uapi/linux/bpf.h                      |    8 +
>>  kernel/bpf/Makefile                           |    1 +
>>  kernel/bpf/bpf_qp_trie.c                      | 1064 +++++++++++++++++
>>  tools/include/uapi/linux/bpf.h                |    8 +
>>  tools/testing/selftests/bpf/Makefile          |    5 +-
>>  tools/testing/selftests/bpf/bench.c           |   10 +
>>  .../selftests/bpf/benchs/bench_qp_trie.c      |  499 ++++++++
>>  .../selftests/bpf/benchs/run_bench_qp_trie.sh |   55 +
>>  .../selftests/bpf/prog_tests/str_key.c        |   69 ++
>>  .../selftests/bpf/progs/qp_trie_bench.c       |  218 ++++
>>  tools/testing/selftests/bpf/progs/str_key.c   |   85 ++
>>  12 files changed, 2022 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/bpf/bpf_qp_trie.c
>>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
>>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/str_key.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/str_key.c
>>
>> --
>> 2.29.2
>>
> .

