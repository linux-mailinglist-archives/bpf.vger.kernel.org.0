Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E678625432
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 08:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiKKHAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 02:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKHAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 02:00:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCB65865;
        Thu, 10 Nov 2022 23:00:45 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7qN10zY6zHtk9;
        Fri, 11 Nov 2022 15:00:17 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 15:00:42 +0800
Message-ID: <f6d87d0e-4773-d27a-dd50-139307460b4c@huawei.com>
Date:   Fri, 11 Nov 2022 15:00:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v4] bpf: Initialize same number of free nodes for
 each pcpu_freelist
Content-Language: en-US
To:     wuqiang <wuqiang.matt@bytedance.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
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
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <83161e5e-5aa4-acdc-630b-95274bfb47d3@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 11/11/2022 11:53 AM, wuqiang wrote:
> On 2022/11/10 20:21, Xu Kuohai wrote:
>> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
>> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
>> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
>> and num_possible_cpus() == 32, CPU 0~27 each gets 9 free nodes, CPU 28 gets
>> 4 free nodes, CPU 29~31 get 0 free nodes, while in fact each CPU should get
>> 8 nodes equally.
>>
>> This patch initializes nr_elems / num_possible_cpus() free nodes for each
>> CPU firstly, then allocates the remaining free nodes by one for each CPU
>> until no free nodes left.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
>> v4: Remove unneeded min()
>> v3: Simplify code as suggested by Andrii
>> v2: Update commit message and add Yonghong's ack
>> ---
>>   kernel/bpf/percpu_freelist.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
>> index b6e7f5c5b9ab..27f2c4aff623 100644
>> --- a/kernel/bpf/percpu_freelist.c
>> +++ b/kernel/bpf/percpu_freelist.c
>> @@ -100,22 +100,22 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>>                   u32 nr_elems)
>>   {
>>       struct pcpu_freelist_head *head;
>> -    int i, cpu, pcpu_entries;
>> +    unsigned int cpu, cpu_idx, i, j, n, m;
>> -    pcpu_entries = nr_elems / num_possible_cpus() + 1;
>> -    i = 0;
>> +    n = nr_elems / num_possible_cpus();
>> +    m = nr_elems % num_possible_cpus();
>> +
>> +    cpu_idx = 0;
>>       for_each_possible_cpu(cpu) {
>> -again:
>> -        head = per_cpu_ptr(s->freelist, cpu);
>> -        /* No locking required as this is not visible yet. */
>> -        pcpu_freelist_push_node(head, buf);
>> -        i++;
>> -        buf += elem_size;
>> -        if (i == nr_elems)
>> -            break;
>> -        if (i % pcpu_entries)
>> -            goto again;
>> +        j = n + (cpu_idx < m ? 1 : 0);
>> +        for (i = 0; i < j; i++) {
>> +            head = per_cpu_ptr(s->freelist, cpu);
> 
> Better move it out of "i-loop",

OK, will do

> and rename "j" to a meaningful name to avoid
> possible misuse.
> 
The loop is short enough to be readable and "j" is not used elsewhere, so I
think it's good to keep the name simple.

>> +            /* No locking required as this is not visible yet. */
>> +            pcpu_freelist_push_node(head, buf);
>> +            buf += elem_size;
>> +        }
>> +        cpu_idx++;
>>       }
>>   }
> 
> .

