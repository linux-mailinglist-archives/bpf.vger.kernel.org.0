Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3414769745E
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjBOCgJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 21:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBOCgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 21:36:07 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36830E9F;
        Tue, 14 Feb 2023 18:36:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PGhym4HP8z4f3jM3;
        Wed, 15 Feb 2023 10:36:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgD3qa0ORexjGqiSDg--.36300S2;
        Wed, 15 Feb 2023 10:36:02 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
 <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
 <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo>
 <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
 <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <19bf22cd-2344-4029-a2ee-ce4bcc1db048@huaweicloud.com>
Date:   Wed, 15 Feb 2023 10:35:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgD3qa0ORexjGqiSDg--.36300S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4fWFyfGr43ArW5Ww48Zwb_yoWrZF43pr
        Z3JF15JryUXr1rGryrJr1UtryUJr4rXw1UJr1FqFWDAw15Gr1YgF1kXrWjgF4Dur4vqr1Y
        qr1Yqr18ZFyYkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        LOTS_OF_MONEY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2/12/2023 12:33 AM, Alexei Starovoitov wrote:
> On Fri, Feb 10, 2023 at 5:10 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Hou, are you plannning to resubmit this change? I also hit this while testing my
>>>> changes on bpf-next.
>>> Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
>>> The former will take a long time to settle.
>>> The latter is trivial.
>>> To unblock yourself just add GFP_ZERO in an extra patch?
>> Sorry for the long delay. Just find find out time to do some tests to compare
>> the performance of bzero and ctor. After it is done, will resubmit on next week.
> I still don't like ctor as a concept. In general the callbacks in the critical
> path are guaranteed to be slow due to retpoline overhead.
> Please send a patch to add GFP_ZERO.
I see. Will do. But i think it is better to know the coarse overhead of these
two methods, so I hack map_perf_test to support customizable value size for
hash_map_alloc and do some benchmarks to show the overheads of ctor and
GFP_ZERO. These benchmark are conducted on a KVM-VM with 8-cpus, it seems when
the number of allocated elements is small, the overheads of ctor and bzero are
basically the same, but when the number of allocated element increases (e.g.,
half full), the overhead of ctor will be bigger. For big value size, the
overhead of ctor and zero are basically the same, and it seems due to the main
overhead comes from slab allocation. The following is the detailed results:

* ./map_perf_test 4 8 8192 10000 $value_size

Key of htab is thread pid, so only 8 elements are allocated.

| value_size | 8      | 256    | 4K     | 16K    | 64K    | 256K   |
| --         | --     | --     | --     | --     | --     | --     |
| base       | 256604 | 261112 | 173646 | 74195  | 23138  | 6275   |
| bzero      | 253362 | 257563 | 171445 | 73303  | 22949  | 6249   |
| ctor       | 264570 | 258246 | 175048 | 72511  | 23004  | 6270   |

* ./map_perf_test 4 8 8192 100 $value_size

The key is still thread pid, so only 8 elements are allocated. decrease the loop
count to 100 to show the overhead of first allocation.

| value_size | 8      | 256    | 4K     | 16K    | 64K    | 256K   |
| --         | --     | --     | --     | --     | --     | --     |
| base       | 135662 | 137742 | 87043  | 36265  | 12501  | 4450   |
| bzero      | 139993 | 134920 | 94570  | 37190  | 12543  | 4131   |
| ctor       | 147949 | 141825 | 94321  | 38240  | 13131  | 4248   |

* ./map_perf_test 4 8 8192 1000 $value_size

Create 512 different keys per-thread, so the hash table will be half-full. Also
decrease the loop count to 1K.

| value_size | 8      | 256    | 4K     | 16K    | 64K    | 256K   |
| --         | --     | --     | --     | --     | --     | --     |
| base       | 4234   | 4289   | 1478   | 510    | 168    | 46     |
| bzero      | 3792   | 4002   | 1473   | 515    | 161    | 37     |
| ctor       | 3846   | 2198   | 1269   | 499    | 161    | 42     |

* ./map_perf_test 4 8 8192 100 $value_size

Create 512 different keys per-thread, so the hash table will be half-full. Also
decrease the loop count to 100.

| value_size | 8      | 256    | 4K     | 16K    | 64K    | 256K   |
| --         | --     | --     | --     | --     | --     | --     |
| base       | 3669   | 3419   | 1272   | 476    | 168    | 44     |
| bzero      | 3468   | 3499   | 1274   | 476    | 150    | 36     |
| ctor       | 2235   | 2312   | 1128   | 452    | 145    | 35     |
>
> Also I realized that we can make the BPF_REUSE_AFTER_RCU_GP flag usable
> without risking OOM by only waiting for normal rcu GP and not rcu_tasks_trace.
> This approach will work for inner nodes of qptrie, since bpf progs
> never see pointers to them. It will work for local storage
> converted to bpf_mem_alloc too. It wouldn't need to use its own call_rcu.
> It's also safe without uaf caveat in sleepable progs and sleepable progs
> can use explicit bpf_rcu_read_lock() when they want to avoid uaf.
> So please respin the set with rcu gp only and that new flag.
> .

