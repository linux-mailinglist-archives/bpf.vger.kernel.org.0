Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA36266B1
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 04:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiKLDtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 22:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKLDtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 22:49:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDACE2A;
        Fri, 11 Nov 2022 19:48:58 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8M4S5g5tz15MWD;
        Sat, 12 Nov 2022 11:48:40 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 11:48:56 +0800
Message-ID: <325d89c4-7189-63bb-5a5b-ee9a01d7823d@huawei.com>
Date:   Sat, 12 Nov 2022 11:48:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v4] bpf: Initialize same number of free nodes for
 each pcpu_freelist
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     wuqiang <wuqiang.matt@bytedance.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221110122128.105214-1-xukuohai@huawei.com>
 <83161e5e-5aa4-acdc-630b-95274bfb47d3@bytedance.com>
 <f6d87d0e-4773-d27a-dd50-139307460b4c@huawei.com>
 <CAEf4BzYG_Rw_vNWK1pX9WJPdWw8c4nxtQPFwisX13iepHT+7KQ@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAEf4BzYG_Rw_vNWK1pX9WJPdWw8c4nxtQPFwisX13iepHT+7KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/12/2022 4:12 AM, Andrii Nakryiko wrote:
> On Thu, Nov 10, 2022 at 11:00 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>>
>> On 11/11/2022 11:53 AM, wuqiang wrote:
>>> On 2022/11/10 20:21, Xu Kuohai wrote:
>>>> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
>>>> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
>>>> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
>>>> and num_possible_cpus() == 32, CPU 0~27 each gets 9 free nodes, CPU 28 gets
>>>> 4 free nodes, CPU 29~31 get 0 free nodes, while in fact each CPU should get
>>>> 8 nodes equally.
>>>>
>>>> This patch initializes nr_elems / num_possible_cpus() free nodes for each
>>>> CPU firstly, then allocates the remaining free nodes by one for each CPU
>>>> until no free nodes left.
>>>>
>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>> v4: Remove unneeded min()
>>>> v3: Simplify code as suggested by Andrii
>>>> v2: Update commit message and add Yonghong's ack
>>>> ---
>>>>    kernel/bpf/percpu_freelist.c | 26 +++++++++++++-------------
>>>>    1 file changed, 13 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
>>>> index b6e7f5c5b9ab..27f2c4aff623 100644
>>>> --- a/kernel/bpf/percpu_freelist.c
>>>> +++ b/kernel/bpf/percpu_freelist.c
>>>> @@ -100,22 +100,22 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>>>>                    u32 nr_elems)
>>>>    {
>>>>        struct pcpu_freelist_head *head;
>>>> -    int i, cpu, pcpu_entries;
>>>> +    unsigned int cpu, cpu_idx, i, j, n, m;
>>>> -    pcpu_entries = nr_elems / num_possible_cpus() + 1;
>>>> -    i = 0;
>>>> +    n = nr_elems / num_possible_cpus();
>>>> +    m = nr_elems % num_possible_cpus();
>>>> +
>>>> +    cpu_idx = 0;
>>>>        for_each_possible_cpu(cpu) {
>>>> -again:
>>>> -        head = per_cpu_ptr(s->freelist, cpu);
>>>> -        /* No locking required as this is not visible yet. */
>>>> -        pcpu_freelist_push_node(head, buf);
>>>> -        i++;
>>>> -        buf += elem_size;
>>>> -        if (i == nr_elems)
>>>> -            break;
>>>> -        if (i % pcpu_entries)
>>>> -            goto again;
>>>> +        j = n + (cpu_idx < m ? 1 : 0);
>>>> +        for (i = 0; i < j; i++) {
>>>> +            head = per_cpu_ptr(s->freelist, cpu);
>>>
>>> Better move it out of "i-loop",
>>
>> OK, will do
>>
> 
> I did that while applying. Also added
> 
> Fixes: e19494edab82 ("bpf: introduce percpu_freelist")
> 
> Please don't forget to add Fixes tag for future patches.
>

OK, thanks for the kind reminder

> Applied to bpf tree.
> 
>>> and rename "j" to a meaningful name to avoid
>>> possible misuse.
>>>
>> The loop is short enough to be readable and "j" is not used elsewhere, so I
>> think it's good to keep the name simple.
>>
>>>> +            /* No locking required as this is not visible yet. */
>>>> +            pcpu_freelist_push_node(head, buf);
>>>> +            buf += elem_size;
>>>> +        }
>>>> +        cpu_idx++;
>>>>        }
>>>>    }
>>>
>>> .
>>
> .

