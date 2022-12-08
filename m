Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C005C646681
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLHB1W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLHB1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:27:13 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF8900CE;
        Wed,  7 Dec 2022 17:27:11 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NSGj574MGz4f3lXp;
        Thu,  8 Dec 2022 09:27:05 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDHuqlpPZFjuJX0Bg--.18210S2;
        Thu, 08 Dec 2022 09:27:08 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/2] bpf: Skip rcu_barrier() if
 rcu_trace_implies_rcu_gp() is true
To:     paulmck@kernel.org, Hou Tao <houtao1@huawei.com>
Cc:     bpf@vger.kernel.org, rcu@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-3-houtao@huaweicloud.com>
 <2eac2a50-40bd-3430-039f-58947d7c7af5@huawei.com>
 <20221207222837.GK4001@paulmck-ThinkPad-P17-Gen-1>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <266a8113-b003-71a8-c7e1-70af87b7ffa7@huaweicloud.com>
Date:   Thu, 8 Dec 2022 09:27:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221207222837.GK4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDHuqlpPZFjuJX0Bg--.18210S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyruF4xGrWkCryDKFWUXFb_yoW8try3pF
        4IgFyUKr15uF4jkwnavr12vrWjvr9Yg3W2qa4kWryUZr9Ikr9rWrnFyry5WF1Fyrs5Ca4a
        yrnI9F15t3WUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 12/8/2022 6:28 AM, Paul E. McKenney wrote:
> On Wed, Dec 07, 2022 at 10:24:55AM +0800, Hou Tao wrote:
>> Forget to cc Paul and RCU maillist for more comments.
>>
>> On 12/6/2022 12:29 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> If there are pending rcu callback, free_mem_alloc() will use
>>> rcu_barrier_tasks_trace() and rcu_barrier() to wait for the pending
>>> __free_rcu_tasks_trace() and __free_rcu() callback.
>>>
>>> If rcu_trace_implies_rcu_gp() is true, there will be no pending
>>> __free_rcu(), so it will be OK to skip rcu_barrier() as well.
> The bit about there being no pending __free_rcu() is guaranteed by
> your algorithm, correct?  As in you have something like this somewhere
> else in the code?
>
> 	if (!rcu_trace_implies_rcu_gp())
> 		call_rcu(...);
>
> Or am I missing something more subtle?
Yes. It is guaranteed by the implementation of bpf mem allocator: if
rcu_trace_implies_rcu_gp() is true, there will be no call_rcu() in bpf memory
allocator.
>
> 							Thanx, Paul
>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  kernel/bpf/memalloc.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index 7daf147bc8f6..d43991fafc4f 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>>> @@ -464,9 +464,17 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
>>>  {
>>>  	/* waiting_for_gp lists was drained, but __free_rcu might
>>>  	 * still execute. Wait for it now before we freeing percpu caches.
>>> +	 *
>>> +	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
>>> +	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
>>> +	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
>>> +	 * so if call_rcu(head, __free_rcu) is skipped due to
>>> +	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
>>> +	 * using rcu_trace_implies_rcu_gp() as well.
>>>  	 */
>>>  	rcu_barrier_tasks_trace();
>>> -	rcu_barrier();
>>> +	if (!rcu_trace_implies_rcu_gp())
>>> +		rcu_barrier();
>>>  	free_mem_alloc_no_barrier(ma);
>>>  }
>>>  

