Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610546239D9
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 03:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiKJCj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 21:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiKJCjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 21:39:25 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255713EAD;
        Wed,  9 Nov 2022 18:39:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N75dL0p1bz4f3mWP;
        Thu, 10 Nov 2022 10:39:18 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP2 (Coremail) with SMTP id Syh0CgCHnLdYZGxj3g0UAQ--.21205S2;
        Thu, 10 Nov 2022 10:39:21 +0800 (CST)
Message-ID: <9caf3639-97f7-367f-a4a2-1c31b271d620@huaweicloud.com>
Date:   Thu, 10 Nov 2022 10:39:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2] bpf: Initialize same number of free nodes for
 each pcpu_freelist
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221108142207.4079521-1-xukuohai@huaweicloud.com>
 <CAEf4BzYjkP_xjaEErXwe5mG9pV+HQHKwY3hTamKH6zQTZrobLw@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4BzYjkP_xjaEErXwe5mG9pV+HQHKwY3hTamKH6zQTZrobLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCHnLdYZGxj3g0UAQ--.21205S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUAry8Xw4rWFWxuFy7Awb_yoW5CrWrpF
        4fJ3WUtwn5Xr98uw4rW3W7WrW3twsrGr17Wa98KF15Ary3tFyvqr1vkFs0qrWxWr17Zr1F
        yr4q9FZrZa4UXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/10/2022 7:56 AM, Andrii Nakryiko wrote:
> On Tue, Nov 8, 2022 at 6:05 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> pcpu_freelist_populate() initializes nr_elems / num_possible_cpus() + 1
>> free nodes for some CPUs, and then possibly one CPU with fewer nodes,
>> followed by remaining cpus with 0 nodes. For example, when nr_elems == 256
>> and num_possible_cpus() == 32, if CPU 0 is the current cpu, CPU 0~27
>> each gets 9 free nodes, CPU 28 gets 4 free nodes, CPU 29~31 get 0 free
>> nodes, while in fact each CPU should get 8 nodes equally.
>>
>> This patch initializes nr_elems / num_possible_cpus() free nodes for each
>> CPU firstly, then allocates the remaining free nodes by one for each CPU
>> until no free nodes left.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
>> v2: Update commit message and add Yonghong's ack
>> ---
>>   kernel/bpf/percpu_freelist.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
>> index b6e7f5c5b9ab..89e84f7381cc 100644
>> --- a/kernel/bpf/percpu_freelist.c
>> +++ b/kernel/bpf/percpu_freelist.c
>> @@ -100,12 +100,15 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>>                              u32 nr_elems)
>>   {
>>          struct pcpu_freelist_head *head;
>> -       int i, cpu, pcpu_entries;
>> +       int i, cpu, pcpu_entries, remain_entries;
>> +
>> +       pcpu_entries = nr_elems / num_possible_cpus();
>> +       remain_entries = nr_elems % num_possible_cpus();
>>
>> -       pcpu_entries = nr_elems / num_possible_cpus() + 1;
>>          i = 0;
>>
>>          for_each_possible_cpu(cpu) {
>> +               int j = i + pcpu_entries + (remain_entries-- > 0 ? 1 : 0);
>>   again:
>>                  head = per_cpu_ptr(s->freelist, cpu);
>>                  /* No locking required as this is not visible yet. */
>> @@ -114,7 +117,7 @@ void pcpu_freelist_populate(struct pcpu_freelist *s, void *buf, u32 elem_size,
>>                  buf += elem_size;
>>                  if (i == nr_elems)
>>                          break;
>> -               if (i % pcpu_entries)
>> +               if (i < j)
>>                          goto again;
>>          }
> 
> this loop's logic is quite hard to follow, if we are fixing it, can we
> simplify it maybe? something like:
> 
> int cpu, cpu_idx, i, j, n, m;
> 
> n = nr_elems / num_possible_cpus();
> m = nr_elems % num_possible_cpus();
> 
> for_each_possible_cpu(cpu) {
>      i = n + (cpu_idx < m ? 1 : 0);
>      for (j = 0; j < i; j++) {
>          head = per_cpu_ptr(s->freelist, cpu);
>          pcpu_freelist_push_node(head, buf);
>          buf += elem_size;
>      }
>      cpu_idx++;
> }
> 
> 
> no gotos, no extra ifs: for each cpu we determine correct number of
> elements to allocate, then just allocate them in a straightforward
> loop
> 

that's great, will update to:

int cpu, cpu_idx, i, j, n, m;

n = nr_elems / num_possible_cpus();
m = nr_elems % num_possible_cpus();

for_each_possible_cpu(cpu) {
       j = min(n + (cpu_idx < m ? 1 : 0), nr_elems);
       for (i = 0; i < j; i++) {
           head = per_cpu_ptr(s->freelist, cpu);
           pcpu_freelist_push_node(head, buf);
           buf += elem_size;
       }
       nr_elems -= j;
       cpu_idx++;
}

>>   }
>> --
>> 2.30.2
>>

