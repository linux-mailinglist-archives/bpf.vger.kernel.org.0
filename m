Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E2B5F8233
	for <lists+bpf@lfdr.de>; Sat,  8 Oct 2022 03:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJHB4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 21:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJHB4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 21:56:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF516C5884
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 18:56:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MkpC33sHtzl7Rl
        for <bpf@vger.kernel.org>; Sat,  8 Oct 2022 09:54:39 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgBXqnPN2EBjopH3Bw--.9920S2;
        Sat, 08 Oct 2022 09:56:32 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local>
 <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com>
 <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
 <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
 <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
Message-ID: <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com>
Date:   Sat, 8 Oct 2022 09:56:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgBXqnPN2EBjopH3Bw--.9920S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43Ar45Zw45Gr48Gr43trb_yoW5tFW5pF
        WfJF1qkF1UJrW0ywsFqr45uF1fA34fXw4UXry5Kr45Zr1UJFyIqw4kWF4agFWrur1kWa1j
        q3sFkrySk3sFy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/29/2022 11:22 AM, Alexei Starovoitov wrote:
> On Wed, Sep 28, 2022 at 1:46 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
>>> On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>
>>> Looks like the perf is lost on atomic_inc/dec.
>>> Try a partial revert of mem_alloc.
>>> In particular to make sure
>>> commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
>>> is reverted and call_rcu is in place,
>>> but percpu counter optimization is still there.
>>> Also please use 'map_perf_test 4'.
>>> I doubt 1000 vs 10240 will make a difference, but still.
>>>
>> I have tried the following two setups:
>> (1) Don't use bpf_mem_alloc in hash-map and use per-cpu counter in hash-map
>> # Samples: 1M of event 'cycles:ppp'
>> # Event count (approx.): 1041345723234
>> #
>> # Overhead  Command          Shared Object                                Symbol
>> # ........  ...............  ...........................................
>> ...............................................
>> #
>>     10.36%  map_perf_test    [kernel.vmlinux]                             [k]
>> bpf_map_get_memcg.isra.0
> That is per-cpu counter and it's consuming 10% ?!
> Something is really odd in your setup.
> A lot of debug configs?
Sorry for the late reply. Just back to work from a long vacation.

My local .config is derived from Fedora distribution. It indeed has some DEBUG
related configs. Will turn these configs off to check it again :)
>>      9.82%  map_perf_test    [kernel.vmlinux]                             [k]
>> bpf_map_kmalloc_node
>>      4.24%  map_perf_test    [kernel.vmlinux]                             [k]
>> check_preemption_disabled
> clearly debug build.
> Please use production build.
check_preemption_disabled is due to CONFIG_DEBUG_PREEMPT. And it is enabled on
Fedora distribution.
>>      2.86%  map_perf_test    [kernel.vmlinux]                             [k]
>> htab_map_update_elem
>>      2.80%  map_perf_test    [kernel.vmlinux]                             [k]
>> __kmalloc_node
>>      2.72%  map_perf_test    [kernel.vmlinux]                             [k]
>> htab_map_delete_elem
>>      2.30%  map_perf_test    [kernel.vmlinux]                             [k]
>> memcg_slab_post_alloc_hook
>>      2.21%  map_perf_test    [kernel.vmlinux]                             [k]
>> entry_SYSCALL_64
>>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
>> syscall_exit_to_user_mode
>>      2.12%  map_perf_test    [kernel.vmlinux]                             [k] jhash
>>      2.11%  map_perf_test    [kernel.vmlinux]                             [k]
>> syscall_return_via_sysret
>>      2.05%  map_perf_test    [kernel.vmlinux]                             [k]
>> alloc_htab_elem
>>      1.94%  map_perf_test    [kernel.vmlinux]                             [k]
>> _raw_spin_lock_irqsave
>>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
>> preempt_count_add
>>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
>> preempt_count_sub
>>      1.87%  map_perf_test    [kernel.vmlinux]                             [k]
>> call_rcu
SNIP
>> Maybe add a not-immediate-reuse flag support to bpf_mem_alloc is reason. What do
>> you think ?
> We've discussed it twice already. It's not an option due to OOM
> and performance considerations.
> call_rcu doesn't scale to millions a second.
Understand. I was just trying to understand the exact performance overhead of
call_rcu(). If the overhead of map operations are much greater than the overhead
of call_rcu(), I think calling call_rcu() one millions a second will be not a
problem and  it also makes the implementation of qp-trie being much simpler. The
OOM problem is indeed a problem, although it is also possible for the current
implementation, so I will try to implement the lookup procedure which handles
the reuse problem.

Regards.
Tao
> .

