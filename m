Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4528C5FC30A
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJLJ0e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 05:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLJ0d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 05:26:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8809237C3;
        Wed, 12 Oct 2022 02:26:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MnS0K5srzzl96v;
        Wed, 12 Oct 2022 17:24:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAnDdJCiEZjg0iZAA--.28502S2;
        Wed, 12 Oct 2022 17:26:30 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Free elements after one RCU-tasks-trace
 grace period
To:     paulmck@kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
 <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
Date:   Wed, 12 Oct 2022 17:26:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAnDdJCiEZjg0iZAA--.28502S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrykJr17Gw1xuw47ZFyfCrg_yoW7CFy8pF
        W7GF1DCr4DZrs0kwn2vr17CFZIy395K3W2qa40y3s5Crn0kryDuF1jyFy5uFyF9rs3Ga12
        vF1qywnxX3WUZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/12/2022 2:36 PM, Paul E. McKenney wrote:
> On Tue, Oct 11, 2022 at 07:31:28PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 10/11/2022 5:07 PM, Paul E. McKenney wrote:
>>> On Tue, Oct 11, 2022 at 03:11:26PM +0800, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> According to the implementation of RCU Tasks Trace, it inovkes
>>>> ->postscan_func() to wait for one RCU-tasks-trace grace period and
>>>> rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
>>>> normal RCU grace period in turn, so one RCU-tasks-trace grace period
>>>> will imply one RCU grace period.
>>>>
>>>> So there is no need to do call_rcu() again in the callback of
>>>> call_rcu_tasks_trace() and it can just free these elements directly.
>>> This is true, but this is an implementation detail that is not guaranteed
>>> in future versions of the kernel.  But if this additional call_rcu()
>>> is causing trouble, I could add some API member that returned true in
>>> kernels where it does happen to be the case that call_rcu_tasks_trace()
>>> implies a call_rcu()-style grace period.
>>>
>>> The BPF memory allocator could then complain or adapt, as appropriate.
>>>
>>> Thoughts?
>> It is indeed an implementation details. But In an idle KVM guest, for memory
>> reclamation in bpf memory allocator a RCU tasks trace grace period is about 30ms
>> and RCU grace period is about 20 ms. Under stress condition, the grace period
>> will be much longer. If the extra RCU grace period can be removed, these memory
>> can be reclaimed more quickly and it will be beneficial for memory pressure.
> I understand the benefits.  We just need to get a safe way to take
> advantage of them.
>
>> Now it seems we can use RCU poll APIs (e.g. get_state_synchronize_rcu() and
>> poll_state_synchronize_rcu() ) to check whether or not a RCU grace period has
>> passed. But It needs to add at least one unsigned long into the freeing object.
>> The extra memory overhead may be OK for bpf memory allocator, but it is not for
>> small object. So could you please show example on how these new APIs work ? Does
>> it need to modify the to-be-free object ?
> Good point on the polling APIs, more on this below.
>
> I was thinking in terms of an API like this:
>
> 	static inline bool rcu_trace_implies_rcu_gp(void)
> 	{
> 		return true;
> 	}
>
> Along with comments on the synchronize_rcu() pointing at the
> rcu_trace_implies_rcu_gp().
It is a simple API and the modifications for call_rcu_tasks_trace() users will
also be simple. The callback of call_rcu_tasks_trace() will invoke
rcu_trace_implies_rcu_gp(), and it returns true, the callback invokes the
callback for call_rcu() directly, else it does so through call_rcu().
>
> Another approach is to wait for the grace periods concurrently, but this
> requires not one but two rcu_head structures.
Beside the extra space usage, does it also complicate the logic in callback
function because it needs to handle the concurrency problem ?
>
> Back to the polling API.  Are these things freed individually, or can
> they be grouped?  If they can be grouped, the storage for the grace-period
> state could be associated with the group.
As said above, for bpf memory allocator it may be OK because it frees elements
in batch, but for bpf local storage and its element these memories are freed
individually. So I think if the implication of RCU tasks trace grace period will
not be changed in the foreseeable future, adding rcu_trace_implies_rcu_gp() and
using it in bpf is a good idea. What do you think ?
>
> 							Thanx, Paul
>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>> ---
>>>>  kernel/bpf/memalloc.c | 17 ++++++-----------
>>>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>>> index 5f83be1d2018..6f32dddc804f 100644
>>>> --- a/kernel/bpf/memalloc.c
>>>> +++ b/kernel/bpf/memalloc.c
>>>> @@ -209,6 +209,9 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
>>>>  	kfree(obj);
>>>>  }
>>>>  
>>>> +/* Now RCU Tasks grace period implies RCU grace period, so no need to do
>>>> + * an extra call_rcu().
>>>> + */
>>>>  static void __free_rcu(struct rcu_head *head)
>>>>  {
>>>>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>>>> @@ -220,13 +223,6 @@ static void __free_rcu(struct rcu_head *head)
>>>>  	atomic_set(&c->call_rcu_in_progress, 0);
>>>>  }
>>>>  
>>>> -static void __free_rcu_tasks_trace(struct rcu_head *head)
>>>> -{
>>>> -	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>>>> -
>>>> -	call_rcu(&c->rcu, __free_rcu);
>>>> -}
>>>> -
>>>>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>>>>  {
>>>>  	struct llist_node *llnode = obj;
>>>> @@ -252,11 +248,10 @@ static void do_call_rcu(struct bpf_mem_cache *c)
>>>>  		 * from __free_rcu() and from drain_mem_cache().
>>>>  		 */
>>>>  		__llist_add(llnode, &c->waiting_for_gp);
>>>> -	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
>>>> -	 * Then use call_rcu() to wait for normal progs to finish
>>>> -	 * and finally do free_one() on each element.
>>>> +	/* Use call_rcu_tasks_trace() to wait for both sleepable and normal
>>>> +	 * progs to finish and finally do free_one() on each element.
>>>>  	 */
>>>> -	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
>>>> +	call_rcu_tasks_trace(&c->rcu, __free_rcu);
>>>>  }
>>>>  
>>>>  static void free_bulk(struct bpf_mem_cache *c)
>>>> -- 
>>>> 2.29.2
>>>>

