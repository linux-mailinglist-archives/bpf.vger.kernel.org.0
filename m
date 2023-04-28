Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA36F103C
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 04:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjD1CQX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 22:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjD1CQW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 22:16:22 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE726B1;
        Thu, 27 Apr 2023 19:16:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q6x6l5gY5z4f3pBh;
        Fri, 28 Apr 2023 10:16:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgC3Iy5tLEtknJQ1Hw--.51049S2;
        Fri, 28 Apr 2023 10:16:17 +0800 (CST)
Subject: Re: [RFC bpf-next v2 1/4] selftests/bpf: Add benchmark for bpf memory
 allocator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-2-houtao@huaweicloud.com>
 <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <6887e058-45e5-bbec-088a-ebc43bb066c9@huaweicloud.com>
 <20230427042049.a6knzkteidm2dfm3@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <a1880e4b-8659-7480-6260-61f30dd393cd@huaweicloud.com>
Date:   Fri, 28 Apr 2023 10:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230427042049.a6knzkteidm2dfm3@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgC3Iy5tLEtknJQ1Hw--.51049S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur43AFyrKF45Kr4fKry3Arb_yoW5ur1Upa
        yrKayUKr1kGFsFyr1vvws7tF12yan5J3sxKr1Dt34UCr98WFn3ZFyIqFW3uF18CryrCa4U
        XF4jqry3u3Z5uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2
        xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Jr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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

Hi,

On 4/27/2023 12:20 PM, Alexei Starovoitov wrote:
> On Sun, Apr 23, 2023 at 09:55:24AM +0800, Hou Tao wrote:
>>>> ./bench htab-mem --use-case $name --max-entries 16384 \
>>>> 	--full 50 -d 7 -w 3 --producers=8 --prod-affinity=0-7
>>>>
>>>> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
>>>> | --                  | --         | --                   | --                |
>>>> | no_op               | 1129       | 1.15                 | 1.15              |
>>>> | overwrite           | 24.37      | 2.07                 | 2.97              |
>>>> | batch_add_batch_del | 10.58      | 2.91                 | 3.36              |
>>>> | add_del_on_diff_cpu | 13.14      | 380.66               | 633.99            |
>>> large mem for diff_cpu case needs to be investigated.
>> The main reason is that tasks-trace RCU GP is slow and there is only one
>> inflight free callback, so the CPUs which only do element addition will allocate
>> new memory from slab continuously and the CPUs which only do element deletion
>> will free these elements continuously through call_tasks_trace_rcu(), but due to
>> the slowness of tasks-trace RCU GP, these freed elements could not be freed back
>> to slab subsystem timely.
> I see. Now it makes sense. It's slow call_tasks_trace_rcu and not at all "memory can never be reused."
> Please explain things clearly in commit log.
Will fix the commit message.
>
>>>> +{
>>>> +	__u64 *value;
>>>> +
>>>> +	if (ctx->from >= ctx->max)
>>>> +		return 1;
>>>> +
>>>> +	value = bpf_map_lookup_elem(&array, &ctx->from);
>>>> +	if (value)
>>>> +		bpf_map_update_elem(&htab, &ctx->from, value, flags);
>>> What is a point of doing lookup from giant array of en element with zero value
>>> to copy it into htab?
>>> Why not to use single zero inited elem for all htab ops?
>> I want to check how does the different size of value effect the benchmark
>> result, so I choose a variable-size value.
> Not following. All elements of the array have the same size.
> Are you saying you were not able to figure out how to supply a single 'value'
> of variable size? Try array of max_entries=1.
> Do not do unnecessary and confusing bpf_map_lookup_elem(&array, &ctx->from);.
My bad. I misunderstood your meaning. Yes, even though the value size is
variable, but using an array with only one element is enough for this
benchmark.
>
>>> Each loop will run 16k times and every time you step += 4.
>>> So 3/4 of these 16k runs it will be hitting if (ctx->from >= ctx->max) condition.
>>> What are you measuring?
>> As explained in the commit message, I am trying to let different deletion and
>> deletion CPU pairs operate on the different subsets of hash-table elements.
>> Assuming there are 16 elements in the htab and there are 8 CPUs and 8 threads,
>> the following is the operation subset for each CPU:
>>
>> CPU 0:  0 4 8 12 (do deletion)
>> CPU 1:  0 4 8 12 (do addition)
>>
>> CPU 2:  1 5 9 13
>> CPU 3:  1 5 9 13
>>
>> CPU 4:  2 6 10 14
>> CPU 5:  2 6 10 14
>>
>> CPU 6:  3 7 11 15
>> CPU 7:  3 7 11 15
> That part is clear, but
>
>>>> +	__sync_fetch_and_add(&loop_cnt, 1);
> this doesn't match the rest. loop_cnt is inremented 4 times faster.
> So it's not comparable to other tests.
In the previous two cases, loop_cnt is increased when nr_entries /
nr_thread elements are deleted and then added (or opposite). For
add_del_on_diff_cpu case, loop_cnt will be increased twice when
nr_entries / nr_thread * 2 are added and then deleted. So I think the
result is roughly comparable to other tests.


