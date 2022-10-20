Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814E1605519
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 03:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJTBiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiJTBiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 21:38:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA56176BB1
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:38:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mt8mk25K4zl6y3
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:15:50 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgDnEDG8oVBjKCaCAA--.40093S2;
        Thu, 20 Oct 2022 09:17:52 +0800 (CST)
Subject: Re: [PATCH bpf 2/2] bpf: Use __llist_del_all() whenever possbile
 during memory draining
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221019115539.983394-1-houtao@huaweicloud.com>
 <20221019115539.983394-3-houtao@huaweicloud.com>
 <Y1BJXRgchDcxwKIJ@google.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <2f968cf9-d90c-3b8c-2dcf-21719ab46e69@huaweicloud.com>
Date:   Thu, 20 Oct 2022 09:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y1BJXRgchDcxwKIJ@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgDnEDG8oVBjKCaCAA--.40093S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47Cr1xtw45XFy3tFyfXrb_yoW5Xr4fpr
        93Gry5JrWUAFyvvw4UtwnrCr95Xr48Jay3G3yUuFy2yr13Xw4qqryxXw1jgw13ZrW8Xr13
        Jr1DWFn7uF45XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUOyCJDUUUU
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

On 10/20/2022 3:00 AM, sdf@google.com wrote:
> On 10/19, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>
>> Except for waiting_for_gp list, there are no concurrent operations on
>> free_by_rcu, free_llist and free_llist_extra lists, so use
>> __llist_del_all() instead of llist_del_all(). waiting_for_gp list can be
>> deleted by RCU callback concurrently, so still use llist_del_all().
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   kernel/bpf/memalloc.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 48e606aaacf0..7f45744a09f7 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -422,14 +422,17 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>>       /* No progs are using this bpf_mem_cache, but htab_map_free() called
>>        * bpf_mem_cache_free() for all remaining elements and they can be in
>>        * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
>> +     *
>> +     * Except for waiting_for_gp list, there are no concurrent operations
>> +     * on these lists, so it is safe to use __llist_del_all().
>>        */
>>       llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
>>           free_one(c, llnode);
>>       llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
>>           free_one(c, llnode);
>> -    llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist))
>> +    llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
>>           free_one(c, llnode);
>> -    llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
>> +    llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
>>           free_one(c, llnode);
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
Thanks for the Acked-by.
>
> Seems safe even without the previous patch? OTOH, do we really care
> about __lllist vs llist in the cleanup path? Might be safer to always
> do llist_del_all everywhere?
No. free_llist is manipulated by both irq work and memory draining concurrently
before patch #1. Using llist_del_all(&c->free_llist) also doesn't help because
irq work uses __llist_add/__llist_del helpers. Basically there is no difference
between __llist and list helper for cleanup patch, but I think it is better to 
clarity the possible concurrent accesses and codify these assumption.
>
>>   }
>
>> -- 
>> 2.29.2
>
> .

