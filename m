Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F294614A50
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 13:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKAMIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKAMIJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 08:08:09 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2C2700
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 05:08:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N1pcq1gCGzKGJC
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 20:05:31 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDXb9QcDGFjOtK_BA--.37832S2;
        Tue, 01 Nov 2022 20:08:00 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tony Finch <dot@dotat.at>
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
 <a4eaa33b-016e-b880-cfe6-16ccef7d2141@dotat.at>
 <CAEf4Bzaj_fUp7z=pERqX5rXrDVSORSXn3m64KKs78MoNy2jNPg@mail.gmail.com>
Message-ID: <e031ba2b-59f9-bf87-d88a-cbfb10ab50a5@huaweicloud.com>
Date:   Tue, 1 Nov 2022 20:07:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzaj_fUp7z=pERqX5rXrDVSORSXn3m64KKs78MoNy2jNPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDXb9QcDGFjOtK_BA--.37832S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr48Cw4xGFWrAFW8XF1kKrg_yoWxWr4rpF
        WFgayjy34DJa4xCw4vvw1UJayFy3y8JFW5GF15G3ykAFZ8uF97Kr1fKa1Y9as7ur4fC340
        qrs0y347ZFWDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/28/2022 2:52 AM, Andrii Nakryiko wrote:
> On Wed, Oct 19, 2022 at 10:01 AM Tony Finch <dot@dotat.at> wrote:
>> Hello all,
>>
>> I have just found out about this qp-trie work, and I'm pleased to hear
>> that it is looking promising for you!
>>
> This is a very nice data structure, so thank you for doing a great job
> explaining it in your post!
Sorry for the late reply. Stilling digging into other problems. Also thanks Tony
for his job on qp.git.
>
>> I have a few very broad observations:
>>
>> The "q" in qp-trie doesn't have to stand for "quadbit". There's a tradeoff
>> between branch factor, maximum key length, and size of branch node. The
>> greater the branch factor, the fewer indirections needed to traverse the
>> tree; but if you go too wide then prefetching is less effective and branch
>> nodes get bigger. I found that 5 bits was the sweet spot (32 wide bitmap,
>> 30ish bit key length) - indexing 5 bit mouthfuls out of the key is HORRID
>> but it was measurably faster than 4 bits. 6 bits (64 bits of bitmap) grew
>> nodes from 16 bytes to 24 bytes, and it ended up slower.
>>
>> Your interior nodes are much bigger than mine, so you might find the
>> tradeoff is different. I encourage you to try it out.
parent field in qp_trie_branch is used to support non-recursive iteration and
rcu_head is used for RCU memory freeing.
> True, but I think for (at least initial) simplicity, sticking to
> half-bytes would simplify the code and let us figure out BPF and
> kernel-specific issues without having to worry about the correctness
> of the qp-trie core logic itself.
Agreed.
>
>> I saw there has been some discussion about locking and RCU. My current
>> project is integrating a qp-trie into BIND, with the aim of replacing its
>> old red-black tree for searching DNS records. It's based on a concurrent
>> qp-trie that I prototyped in NSD (a smaller and simpler DNS server than
>> BIND). My strategy is based on a custom allocator for interior nodes. This
>> has two main effects:
>>
>>   * Node references are now 32 bit indexes into the allocator's pool,
>>     instead of 64 bit pointers; nodes are 12 bytes instead of 16 bytes.
>>
>>   * The allocator supports copy-on-write and safe memory reclamation with
>>     a fairly small overhead, 3 x 32 bit counters per memory chunk (each
>>     chunk is roughly page sized).
>>
>> I wrote some notes when the design was new, but things have changed since
>> then.
>>
>> https://dotat.at/@/2021-06-23-page-based-gc-for-qp-trie-rcu.html
>>
>> For memory reclamation the interior nodes get moved / compacted. It's a
>> kind of garbage collector, but easy-mode because the per-chunk counters
>> accurately indicate when compaction is worthwhile. I've written some notes
>> on my several failed GC experiments; the last / current attempt seems (by
>> and large) good enough.
>>
>> https://dotat.at/@/2022-06-22-compact-qp.html
>>
>> For exterior / leaf nodes, I'm using atomic refcounts to know when they
>> can be reclaimed. The caller is responsible for COWing its leaves when
>> necessary.
>>
>> Updates to the tree are transactional in style, and do not block readers:
>> a single writer gets the write mutex, makes whatever changes it needs
>> (copying as required), then commits by flipping the tree's root. After a
>> commit it can free unused chunks. (Compaction can be part of an update
>> transaction or a transaction of its own.)
>>
>> I'm currently using a reader-writer lock for the tree root, but I designed
>> it with liburcu in mind, while trying to keep things simple.
>>
>> This strategy is very heavily biased in favour of readers, which suits DNS
>> servers. I don't know enough about BPF to have any idea what kind of
>> update traffic you need to support.
> These are some nice ideas, I did a quick read on your latest blog
> posts, missed those updates since last time I checked your blog.
>
> One limitation that we have in the BPF world is that BPF programs can
> be run in extremely restrictive contexts (e.g., NMI), in which things
> that user-space can assume will almost always succeed (like memory
> allocation), are not allowed. We do have BPF-specific memory
> allocator, but even it can fail to allocate memory, depending on
> allocation patterns. So we need to think if this COW approach is
> acceptable. I'd love for Hou Tao to think about this and chime in,
> though, as he spent a lot of time thinking about particulars.
Current implementation of BPF_MAP_TYPE_QP_TRIE is already COWed. When adding or
deleting a leaf node, its parent interior node will be copied to a new interior
node, the pointer to the old parent node (in the grand-parent interior node)
will be updated by the new parent node, and the old parent node will be RCU-freed.
According to above description, COW in qp-trie means all nodes on the path from
the root node to the leaf node are COWed, so I think current COW implementation
is better for bpf map usage scenario. But I will check the qp-trie code in BIND
[0] later.

0:
https://gitlab.isc.org/isc-projects/bind9/-/commit/ecc555e6ec763c4f8f2495864ec08749202fff1a#65b4d67ce64e9195e41ac43d78af5156f9ebb779_0_553
> But very basically, ultimate memory and performance savings are
> perhaps less important in trying to fit qp-trie into BPF framework. We
> can iterate after with optimizations and improvements, but first we
> need to get the things correct and well-behaved.
Understand.
>
>> At the moment I am reworking and simplifying my transaction and
>> reclamation code and it's all very broken. I guess this isn't the best
>> possible time to compare notes on qp-trie variants, but I'm happy to hear
>> from others who have code and ideas to share.
> It would be great if you can lend your expertise in reviewing at least
> generic qp-trie parts, but also in helping to figure out the overall
> concurrency approach we can take in kernel/BPF land (depending on your
> familiarity with kernel specifics, of course).
>
> Thanks for offering the latest on qp-trie, exciting to see more
> production applications of qp-trie and that you are still actively
> working on this!
Yes, it would be great if Tony could help to review or co-design bpf qp-trie map.
>> --
>> Tony Finch  <dot@dotat.at>  https://dotat.at/
>> Mull of Kintyre to Ardnamurchan Point: East or southeast 4 to 6,
>> increasing 6 to gale 8 for a time. Smooth or slight in eastern
>> shelter, otherwise slight or moderate. Rain or showers. Good,
>> occasionally poor.

