Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6C5FE7DB
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 06:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJNEET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 00:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJNEES (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 00:04:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD5ED9B5;
        Thu, 13 Oct 2022 21:04:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MpXlB2tS6z6R53F;
        Fri, 14 Oct 2022 12:01:58 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAH7tK830hjXTD3AA--.62769S2;
        Fri, 14 Oct 2022 12:04:15 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Free elements after one RCU-tasks-trace
 grace period
To:     paulmck@kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
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
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
 <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
 <1e253bfb-1413-ffb4-a11c-c6c1fa43bce0@huaweicloud.com>
 <20221013190457.GA4221@paulmck-ThinkPad-P17-Gen-1>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <7660d71d-d0ed-2f86-471e-4254bb555638@huaweicloud.com>
Date:   Fri, 14 Oct 2022 12:04:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221013190457.GA4221@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAH7tK830hjXTD3AA--.62769S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5ur1fZF4xtw4xGr13CFg_yoWrWw17pF
        W7GF1UCr4DZr4Utw4Iqr17GFZ7t398tw17XrykJ34rArn0yryDAF4UJFy5WFyFyrWxCw42
        vr1Utr9xGF1UArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbG2NtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/14/2022 3:04 AM, Paul E. McKenney wrote:
> On Thu, Oct 13, 2022 at 09:41:46AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 10/13/2022 12:11 AM, Paul E. McKenney wrote:
>>> On Wed, Oct 12, 2022 at 05:26:26PM +0800, Hou Tao wrote:
>>>> Hi,
>>>>
>>>> On 10/12/2022 2:36 PM, Paul E. McKenney wrote:
>> SNIP
>>>> As said above, for bpf memory allocator it may be OK because it frees elements
>>>> in batch, but for bpf local storage and its element these memories are freed
>>>> individually. So I think if the implication of RCU tasks trace grace period will
>>>> not be changed in the foreseeable future, adding rcu_trace_implies_rcu_gp() and
>>>> using it in bpf is a good idea. What do you think ?
>>> Maybe the BPF memory allocator does it one way and BPF local storage
>>> does it another way.
>> Another question. Just find out that there are new APIs for RCU polling (e.g.
>> get_state_synchronize_rcu_full()). According to comments, the advantage of new
>> API is that it will never miss a passed grace period. So for this case is
>> get_state_synchronize_rcu() enough ? Or should I switch to use
>> get_state_synchronize_rcu_full() instead ?
> I suggest starting with get_state_synchronize_rcu(), and moving to the
> _full() variants only if experience shows that it is necessary.
>
> Please note that these functions work with normal RCU, that is,
> call_rcu(), but not call_rcu_tasks(), call_rcu_tasks_trace(), or
> call_rcu_rude().  Please note also that SRCU has its own set of polling
> APIs, for example, get_state_synchronize_srcu().
I see. Thanks for your suggestion and details explanations.
>
> 								Thanx, Paul
>
>> Regards
>>> How about if I produce a patch for rcu_trace_implies_rcu_gp() and let
>>> you carry it with your series?  That way I don't have an unused function
>>> in -rcu and you don't have to wait for me to send it upstream?
>>>
>>> 							Thanx, Paul
>>>
>>>>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>>>>>> ---
>>>>>>>>  kernel/bpf/memalloc.c | 17 ++++++-----------
>>>>>>>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>>>>>>> index 5f83be1d2018..6f32dddc804f 100644
>>>>>>>> --- a/kernel/bpf/memalloc.c
>>>>>>>> +++ b/kernel/bpf/memalloc.c
>>>>>>>> @@ -209,6 +209,9 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
>>>>>>>>  	kfree(obj);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +/* Now RCU Tasks grace period implies RCU grace period, so no need to do
>>>>>>>> + * an extra call_rcu().
>>>>>>>> + */
>>>>>>>>  static void __free_rcu(struct rcu_head *head)
>>>>>>>>  {
>>>>>>>>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>>>>>>>> @@ -220,13 +223,6 @@ static void __free_rcu(struct rcu_head *head)
>>>>>>>>  	atomic_set(&c->call_rcu_in_progress, 0);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> -static void __free_rcu_tasks_trace(struct rcu_head *head)
>>>>>>>> -{
>>>>>>>> -	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>>>>>>>> -
>>>>>>>> -	call_rcu(&c->rcu, __free_rcu);
>>>>>>>> -}
>>>>>>>> -
>>>>>>>>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>>>>>>>>  {
>>>>>>>>  	struct llist_node *llnode = obj;
>>>>>>>> @@ -252,11 +248,10 @@ static void do_call_rcu(struct bpf_mem_cache *c)
>>>>>>>>  		 * from __free_rcu() and from drain_mem_cache().
>>>>>>>>  		 */
>>>>>>>>  		__llist_add(llnode, &c->waiting_for_gp);
>>>>>>>> -	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
>>>>>>>> -	 * Then use call_rcu() to wait for normal progs to finish
>>>>>>>> -	 * and finally do free_one() on each element.
>>>>>>>> +	/* Use call_rcu_tasks_trace() to wait for both sleepable and normal
>>>>>>>> +	 * progs to finish and finally do free_one() on each element.
>>>>>>>>  	 */
>>>>>>>> -	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
>>>>>>>> +	call_rcu_tasks_trace(&c->rcu, __free_rcu);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>>  static void free_bulk(struct bpf_mem_cache *c)
>>>>>>>> -- 
>>>>>>>> 2.29.2
>>>>>>>>

