Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484A86070B2
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJUHIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 03:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJUHIa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 03:08:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5416D56C;
        Fri, 21 Oct 2022 00:08:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MtwVL0qQHzKFf2;
        Fri, 21 Oct 2022 15:06:02 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgA35S1lRVJjg4rAAA--.1991S2;
        Fri, 21 Oct 2022 15:08:25 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 0/4] Remove unnecessary RCU grace period
 chaining
To:     paulmck@kernel.org
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org
References: <20221014113946.965131-1-houtao@huaweicloud.com>
 <20221017133941.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <0b01d904-523e-14de-71fa-23bf23d2743f@huaweicloud.com>
 <20221018150824.GP5600@paulmck-ThinkPad-P17-Gen-1>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <da44591b-71d3-1cf4-fb68-1218d7a531b7@huaweicloud.com>
Date:   Fri, 21 Oct 2022 15:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221018150824.GP5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgA35S1lRVJjg4rAAA--.1991S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1kZFykZw4DGr4rCr4DJwb_yoWrAF4UpF
        s2kF1DAr98Crs5Kw1Sqr17u3yjy3s5Ww12q34kXa4j9rn0yryjvrsFqryYgF1YvrZ3Aa42
        yrn0yw13u3WUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/18/2022 11:08 PM, Paul E. McKenney wrote:
> On Tue, Oct 18, 2022 at 03:31:20PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 10/17/2022 9:39 PM, Paul E. McKenney wrote:
>>> On Fri, Oct 14, 2022 at 07:39:42PM +0800, Hou Tao wrote:
SNIP
>>>
>> Thanks for the review. But it seems I missed another possible use case for
>> rcu_trace_implies_rcu_gp() in bpf memory allocator. The code snippet for
>> free_mem_alloc() is as following:
>>
>> static void free_mem_alloc(struct bpf_mem_alloc *ma)
>> {
>>         /* waiting_for_gp lists was drained, but __free_rcu might
>>          * still execute. Wait for it now before we freeing percpu caches.
>>          */
>>         rcu_barrier_tasks_trace();
>>         rcu_barrier();
>>         free_mem_alloc_no_barrier(ma);
>> }
>>
>> It uses rcu_barrier_tasks_trace() and rcu_barrier() to wait for the completion
>> of pending call_rcu_tasks_trace()s and call_rcu()s. I think it is also safe to
>> check rcu_trace_implies_rcu_gp() in free_mem_alloc() and if it is true, there is
>> no need to call rcu_barrier().
>>
>> static void free_mem_alloc(struct bpf_mem_alloc *ma)
>> {
>>         /* waiting_for_gp lists was drained, but __free_rcu_tasks_trace()
>>          * or __free_rcu() might still execute. Wait for it now before we
>>          * freeing percpu caches.
>>          */
>>         rcu_barrier_tasks_trace();
>>         if (!rcu_trace_implies_rcu_gp())
>>                 rcu_barrier();
>>         free_mem_alloc_no_barrier(ma);
>> }
>>
>> Does the above change look good to you ? If it is, I will post v3 to include the
>> above change and add your Reviewed-by tag.
> Unfortunately, although synchronize_rcu_tasks_trace() implies
> that synchronize_rcu(), there is no relationship between the
> callbacks.  Furthermore, rcu_barrier_tasks_trace() does not imply
> synchronize_rcu_tasks_trace().
Yes. I see. And according to the code, if there is not pending cb,
rcu_barrier_tasks_trace() will returned immediately. It is also possible
rcu_tasks_trace kthread is in the middle of grace period waiting when invoking
rcu_barrier_task_trace(), so rcu_barrier_task_trace() does not imply
synchronize_rcu_tasks_trace().
>
> So the above change really would break things.  Please do not do it.
However I am a little confused about the conclusion. If only considering the
invocations of call_rcu() and call_rcu_tasks_trace() in kernel/bpf/memalloc.c, I
think it is safe to do so, right ? Because if  rcu_trace_implies_rcu_gp() is
true, there will be no invocation of call_rcu() and rcu_barrier_tasks_trace()
will wait for the completion of pending call_rcu_tasks_trace(). If
rcu_trace_implies_rcu_gp(), rcu_barrier_tasks_trace() and rcu_barrier() will do
the job. If considering the invocations of call_rcu() in other places, I think
it is definitely unsafe to do that, right ?
>
> You could use workqueues or similar to make the rcu_barrier_tasks_trace()
> and the rcu_barrier() wait concurrently, though.  This would of course
> require some synchronization.
Thanks for the suggestion. Will check it later.
>
> 							Thanx, Paul
>
>>>> Change Log:
>>>>
>>>> v2:
>>>>  * codify the implication of RCU Tasks Trace grace period instead of
>>>>    assuming for it
>>>>
>>>> v1: https://lore.kernel.org/bpf/20221011071128.3470622-1-houtao@huaweicloud.com
>>>>
>>>> Hou Tao (3):
>>>>   bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
>>>>   bpf: Use rcu_trace_implies_rcu_gp() in local storage map
>>>>   bpf: Use rcu_trace_implies_rcu_gp() for program array freeing
>>>>
>>>> Paul E. McKenney (1):
>>>>   rcu-tasks: Provide rcu_trace_implies_rcu_gp()
>>>>
>>>>  include/linux/rcupdate.h       | 12 ++++++++++++
>>>>  kernel/bpf/bpf_local_storage.c | 13 +++++++++++--
>>>>  kernel/bpf/core.c              |  8 +++++++-
>>>>  kernel/bpf/memalloc.c          | 15 ++++++++++-----
>>>>  kernel/rcu/tasks.h             |  2 ++
>>>>  5 files changed, 42 insertions(+), 8 deletions(-)
>>>>
>>>> -- 
>>>> 2.29.2
>>>>
>>> .

