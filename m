Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7B606D1C
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 03:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJUBnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJUBnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 21:43:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EBB2339B0
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:43:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MtnH36JVJzKJfM
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 09:40:47 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgBnQHks+VFjnaxHAg--.60409S2;
        Fri, 21 Oct 2022 09:43:11 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Support for setting numa node in bpf memory
 allocator
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221020142247.1682009-1-houtao@huaweicloud.com>
 <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <212fbd46-7371-c3f9-e900-3a49d9fafab8@huaweicloud.com>
Date:   Fri, 21 Oct 2022 09:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgBnQHks+VFjnaxHAg--.60409S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy7GryUArWUZFWkGr4kWFg_yoW5CrW3pF
        W7Ka45ArsxXF17Gw1Ivw48Ga4rXw43WrsFk3yfWr9rZFWrXrn7Grs5XF15WF1YyrWjk3WF
        yFWqqw4fA34kZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
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

On 10/21/2022 2:01 AM, Hao Luo wrote:
> On Thu, Oct 20, 2022 at 6:57 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Since commit fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc."),
>> numa node setting for non-preallocated hash table is ignored. The reason
>> is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
>> is trivial to support numa node setting for bpf memory allocator.
>>
>> So adding support for setting numa node in bpf memory allocator and
>> updating hash map accordingly.
>>
>> Fixes: fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc.")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
> Looks good to me with a few nits.
>
> <...>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index fc116cf47d24..44c531ba9534 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
> <...>
>> +static inline bool is_valid_numa_node(int numa_node, bool percpu)
>> +{
>> +       return numa_node == NUMA_NO_NODE ||
>> +              (!percpu && (unsigned int)numa_node < nr_node_ids);
> Maybe also check node_online? There is a similar helper function in
> kernel/bpf/syscall.c.
Will factor out as a helper function and use it in bpf memory allocator in v2.
>
> It may help debugging if we could log the reason here, for example,
> PERCPU map but with numa_node specified.
Not sure about it, because the validity check must have been done in map related
code.

>
>> +}
>> +
>> +/* The initial prefill is running in the context of map creation process, so
>> + * if the preferred numa node is NUMA_NO_NODE, needs to use numa node of the
>> + * specific cpu instead.
>> + */
>> +static inline int get_prefill_numa_node(int numa_node, int cpu)
>> +{
>> +       int prefill_numa_node;
>> +
>> +       if (numa_node == NUMA_NO_NODE)
>> +               prefill_numa_node = cpu_to_node(cpu);
>> +       else
>> +               prefill_numa_node = numa_node;
>> +       return prefill_numa_node;
>>  }
> nit: an alternative implementation is
>
>  return numa_node == NUMA_NO_NODE ? cpu_to_node(cpu) : numa_node;
It is shorter and better. Will do it in v2.
>
>>  /* When size != 0 bpf_mem_cache for each cpu.
>> @@ -359,13 +383,17 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>>   * kmalloc/kfree. Max allocation size is 4096 in this case.
>>   * This is bpf_dynptr and bpf_kptr use case.
>>   */
> We added a parameter to this function, I think it is worth mentioning
> the 'numa_node' argument's behavior under different values of
> 'percpu'.
How about the following comments ?

 * For per-cpu allocator (percpu=true), the only valid value of numa_node is
 * NUMA_NO_NODE. For non-per-cpu allocator, if numa_node is NUMA_NO_NODE, the
 * preferred memory allocation node is the numa node where the allocating CPU
 * is located, else the preferred node is the specified numa_node.

>
>> -int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>> +int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, int numa_node,
>> +                      bool percpu)
>>  {
> <...>
>> --
>> 2.29.2
>>

