Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031662127F
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiKHNiI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 08:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiKHNiH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 08:38:07 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB7612AA3;
        Tue,  8 Nov 2022 05:38:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N68LJ6Z50z4f3jYl;
        Tue,  8 Nov 2022 21:38:00 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP4 (Coremail) with SMTP id gCh0CgAXO9i6W2pjdLm_AA--.5393S2;
        Tue, 08 Nov 2022 21:38:04 +0800 (CST)
Message-ID: <a9889f76-d667-7ef7-e2e8-f912b9ba2663@huaweicloud.com>
Date:   Tue, 8 Nov 2022 21:38:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] bpf: Initialize same number of free nodes for
 each pcpu_freelist
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221107085030.3901608-1-xukuohai@huaweicloud.com>
 <7c3f3057-033a-f871-bd5d-0ac0da2b18a0@meta.com>
From:   Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <7c3f3057-033a-f871-bd5d-0ac0da2b18a0@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXO9i6W2pjdLm_AA--.5393S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw15WFyxWFyUKFWxZF43KFg_yoW5Wr4xpr
        s5Ja4Utr98Wrn5Gw4rJw1UWFy3Jw4UJ3WDGw1rKF15ZrW5Jryqqr1UXrs0gFW7Wr4xZr1j
        yF1qqr9rZay7XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/8/2022 12:40 AM, Yonghong Song wrote:
> 
> 
> On 11/7/22 12:50 AM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
>> free nodes for each CPU except the last initialized CPU, always making
>> the last CPU get fewer free nodes. For example, when nr_elems == 256
> 
> ... free nodes for some cpus, and then possibly one cpu with fewer nodes, followed by remaining cpus with 0 nodes.
> 

Will update the commit message to describe it more accurately, thanks.

>> and num_possible_cpus() == 32, if CPU 0 is the current cpu, CPU 0~27
>> each gets 9 free nodes, CPU 28 gets 4 free nodes, CPU 29~31 get 0 free
>> nodes, while in fact each CPU should get 8 nodes equally.
>>
>> This patch initializes nr_elems / num_possible_cpus() free nodes for each
>> CPU firstly, and then allocates the remaining free nodes by one for each
>> CPU until no free nodes left.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> LGTM. Did you observe any performance issues?
>

No. I ran map_perf_test and did not observe any performance issues. I think
it's because the test cases are repeated in loops, so the pcpu_freelists become
stable and balanced after the first few loops.

> Acked-by: Yonghong Song <yhs@fb.com>
> 
>> ---
>>   kernel/bpf/percpu_freelist.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
>> index b6e7f5c5b9ab..89e84f7381cc 100644
>> --- a/kernel/bpf/percpu_freelist.c
>> +++ b/kernel/bpf/percpu_freelist.c
>> @@ -100,12 +100,15 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>>                   u32 nr_elems)
>>   {
>>       struct pcpu_freelist_head *head;
>> -    int i, cpu, pcpu_entries;
>> +    int i, cpu, pcpu_entries, remain_entries;
>> +
>> +    pcpu_entries = nr_elems / num_possible_cpus();
>> +    remain_entries = nr_elems % num_possible_cpus();
>> -    pcpu_entries = nr_elems / num_possible_cpus() + 1;
>>       i = 0;
>>       for_each_possible_cpu(cpu) {
>> +        int j = i + pcpu_entries + (remain_entries-- > 0 ? 1 : 0);
>>   again:
>>           head = per_cpu_ptr(s->freelist, cpu);
>>           /* No locking required as this is not visible yet. */
>> @@ -114,7 +117,7 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>>           buf += elem_size;
>>           if (i == nr_elems)
>>               break;
>> -        if (i % pcpu_entries)
>> +        if (i < j)
>>               goto again;
>>       }
>>   }

