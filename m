Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2F6F11AC
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 08:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjD1GOH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 02:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345267AbjD1GOG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 02:14:06 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D426A1;
        Thu, 27 Apr 2023 23:14:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q72P31mCCz4f3lwL;
        Fri, 28 Apr 2023 14:13:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgA3iBIlZEtkclZAHw--.1544S2;
        Fri, 28 Apr 2023 14:14:00 +0800 (CST)
Subject: Re: [RFC bpf-next v2 1/4] selftests/bpf: Add benchmark for bpf memory
 allocator
To:     paulmck@kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-2-houtao@huaweicloud.com>
 <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <6887e058-45e5-bbec-088a-ebc43bb066c9@huaweicloud.com>
 <20230427042049.a6knzkteidm2dfm3@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <4ef33ab5-0bb6-4877-bd75-7d34e71213fc@paulmck-laptop>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <c19d75de-60f3-73a3-4e41-cf273957e019@huaweicloud.com>
Date:   Fri, 28 Apr 2023 14:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4ef33ab5-0bb6-4877-bd75-7d34e71213fc@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgA3iBIlZEtkclZAHw--.1544S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1xGry7uF4rCFWxZr43Jrb_yoW8CFWfpa
        yrta43Jr4DAw429r10kws7Kr10yFs5G3s8XFnYqFZ0kr98WFyDCay2qr409ry5G348u34j
        vrWDXr9xu3Z8u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Paul,

On 4/27/2023 9:46 PM, Paul E. McKenney wrote:
> On Wed, Apr 26, 2023 at 09:20:49PM -0700, Alexei Starovoitov wrote:
>> On Sun, Apr 23, 2023 at 09:55:24AM +0800, Hou Tao wrote:
>>>>> ./bench htab-mem --use-case $name --max-entries 16384 \
>>>>> 	--full 50 -d 7 -w 3 --producers=8 --prod-affinity=0-7
>>>>>
>>>>> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
>>>>> | --                  | --         | --                   | --                |
>>>>> | no_op               | 1129       | 1.15                 | 1.15              |
>>>>> | overwrite           | 24.37      | 2.07                 | 2.97              |
>>>>> | batch_add_batch_del | 10.58      | 2.91                 | 3.36              |
>>>>> | add_del_on_diff_cpu | 13.14      | 380.66               | 633.99            |
>>>> large mem for diff_cpu case needs to be investigated.
>>> The main reason is that tasks-trace RCU GP is slow and there is only one
>>> inflight free callback, so the CPUs which only do element addition will allocate
>>> new memory from slab continuously and the CPUs which only do element deletion
>>> will free these elements continuously through call_tasks_trace_rcu(), but due to
>>> the slowness of tasks-trace RCU GP, these freed elements could not be freed back
>>> to slab subsystem timely.
>> I see. Now it makes sense. It's slow call_tasks_trace_rcu and not at all "memory can never be reused."
>> Please explain things clearly in commit log.
> Is this a benchmarking issue, or is this happening in real workloads?
It is just a benchmark issue. The add_del_on_diff_cpu case in the
benchmark simulates the hypothetical workload which will do hash map
addition and deletion on different CPUs.
>
> If the former, one trick I use in rcutorture's callback-flooding code is
> to pass the ready-to-be-freed memory directly back to the allocating CPU.
> Which might be what you were getting at with your "maybe stealing from
> free_list of other CPUs".
Thanks, it is a good idea. I could try it later.
>
> If this is happening in real workloads, then I would like to better
> understand that workload.
>
> 							Thanx, Paul
> .

