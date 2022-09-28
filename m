Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55225ED37A
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 05:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiI1D1j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 23:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiI1D12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 23:27:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF25E106A34
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 20:27:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mchhd31DJzl8bV
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 11:25:37 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDngmwXvzNjWXEJBg--.13S2;
        Wed, 28 Sep 2022 11:27:23 +0800 (CST)
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
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <81cae2d7-189d-0db2-f306-e015b48165a0@huaweicloud.com>
Date:   Wed, 28 Sep 2022 11:27:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDngmwXvzNjWXEJBg--.13S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFykuw45tw1kXFW7AF45Awb_yoWrWrW5pr
        WUuF1DGr1kJrn7uwn5t34xJFy3X3WFvFyUWa45tr45C340gwnagay8tay5ua4UA34xJwsF
        qryDJ3s3Cw4vyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
> On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> A quick benchmark show the performance is bad when using subtree lock for lookup:
>>
>> Randomly-generated binary data (key size=255, max entries=16K, key length
>> range:[1, 255])
>> * no lock
>> qp-trie lookup   (1  thread)   10.250 ± 0.009M/s (drops 0.006 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (2  thread)   20.466 ± 0.009M/s (drops 0.010 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (4  thread)   41.211 ± 0.010M/s (drops 0.018 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (8  thread)   82.933 ± 0.409M/s (drops 0.031 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (16 thread)  162.615 ± 0.842M/s (drops 0.070 ± 0.000M/s mem
>> 0.000 MiB)
>>
>> * subtree lock
>> qp-trie lookup   (1  thread)    8.990 ± 0.506M/s (drops 0.006 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (2  thread)   15.908 ± 0.141M/s (drops 0.004 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (4  thread)   27.551 ± 0.025M/s (drops 0.019 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (8  thread)   42.040 ± 0.241M/s (drops 0.018 ± 0.000M/s mem
>> 0.000 MiB)
>> qp-trie lookup   (16 thread)   50.884 ± 0.171M/s (drops 0.012 ± 0.000M/s mem
>> 0.000 MiB)
> That's indeed significant.
> But I interpret it differently.
> Since single thread perf is close enough while 16 thread
> suffers 3x it means the lock mechanism is inefficient.
> It means update/delete performance equally doesn't scale.
>
>> Strings in /proc/kallsyms (key size=83, max entries=170958)
>> * no lock
>> qp-trie lookup   (1  thread)    4.096 ± 0.234M/s (drops 0.249 ± 0.014M/s mem
>> 0.000 MiB)
>>
>> * subtree lock
>> qp-trie lookup   (1  thread)    4.454 ± 0.108M/s (drops 0.271 ± 0.007M/s mem
>> 0.000 MiB)
> Here a single thread with spin_lock is _faster_ than without.
It is a little strange because there is not any overhead for lockless lookup for
now. I thought it may be due to CPU boost or something similar. Will check it again.
> So it's not about the cost of spin_lock, but its contention.
> So all the complexity to do lockless lookup
> needs to be considered in this context.
> Looks like update/delete don't scale anyway.
Yes.
> So lock-less lookup complexity is justified only
> for the case with a lot of concurrent lookups and
> little update/delete.
> When bpf hash map was added the majority of tracing use cases
> had # of lookups == # of updates == # of deletes.
> For qp-trie we obviously cannot predict,
> but should not pivot strongly into lock-less lookup without data.
> The lock-less lookup should have reasonable complexity.
> Otherwise let's do spin_lock and work on a different locking scheme
> for all operations (lookup/update/delete).
For lpm-trie, does the use case in cillium [0] has many lockless lookups and few
updates/deletions ? So I think the use case is applicable for qp-trie as well.
Before steering towards spin_lock, let's implement a demo for lock-less lookup
to see its complexity. For spin-lock way, I had implemented a hand-over-hand
lock but the lookup was still lockless, but it doesn't scale well as well.
>
>> I can not reproduce the phenomenon that call_rcu consumes 100% of all cpus in my
>> local environment, could you share the setup for it ?
>>
>> The following is the output of perf report (--no-children) for "./map_perf_test
>> 4 72 10240 100000" on a x86-64 host with 72-cpus:
>>
>>     26.63%  map_perf_test    [kernel.vmlinux]                             [k]
>> alloc_htab_elem
>>     21.57%  map_perf_test    [kernel.vmlinux]                             [k]
>> htab_map_update_elem
> Looks like the perf is lost on atomic_inc/dec.
> Try a partial revert of mem_alloc.
> In particular to make sure
> commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
> is reverted and call_rcu is in place,
> but percpu counter optimization is still there.
> Also please use 'map_perf_test 4'.
> I doubt 1000 vs 10240 will make a difference, but still.
Will do. The suggestion is reasonable. But when max_entries=1000,
use_percpu_counter will be false.

