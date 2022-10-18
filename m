Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF876025BE
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJRHb3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJRHb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 03:31:28 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067763855;
        Tue, 18 Oct 2022 00:31:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ms58J5JsRz6PmLW;
        Tue, 18 Oct 2022 15:29:04 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgA3HdJIVk5jpyHSAQ--.60233S2;
        Tue, 18 Oct 2022 15:31:23 +0800 (CST)
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
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <0b01d904-523e-14de-71fa-23bf23d2743f@huaweicloud.com>
Date:   Tue, 18 Oct 2022 15:31:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221017133941.GF5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgA3HdJIVk5jpyHSAQ--.60233S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45ZF4kAFy7ury5tw1UJrb_yoWrWF47pF
        W8KFn8CryUZr4Fk3Zayr17C3yUJ395Ww1UXa4xXa48Zrn8AryjvFnFqr1YgF15trZ5A34a
        yrn0yr1Uu3WUZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/17/2022 9:39 PM, Paul E. McKenney wrote:
> On Fri, Oct 14, 2022 at 07:39:42PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> Now bpf uses RCU grace period chaining to wait for the completion of
>> access from both sleepable and non-sleepable bpf program: calling
>> call_rcu_tasks_trace() firstly to wait for a RCU-tasks-trace grace
>> period, then in its callback calls call_rcu() or kfree_rcu() to wait for
>> a normal RCU grace period.
>>
>> According to the implementation of RCU Tasks Trace, it inovkes
>> ->postscan_func() to wait for one RCU-tasks-trace grace period and
>> rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
>> normal RCU grace period in turn, so one RCU-tasks-trace grace period
>> will imply one normal RCU grace period. To codify the implication,
>> introduces rcu_trace_implies_rcu_gp() in patch #1. And using it in patch
>> #2~#4 to remove unnecessary call_rcu() or kfree_rcu() in bpf subsystem.
>> Other two uses of call_rcu_tasks_trace() are unchanged: for
>> __bpf_prog_put_rcu() there is no gp chain and for
>> __bpf_tramp_image_put_rcu_tasks() it chains RCU tasks trace GP and RCU
>> tasks GP.
>>
>> An alternative way to remove these unnecessary RCU grace period
>> chainings is using the RCU polling API to check whether or not a normal
>> RCU grace period has passed (e.g. get_state_synchronize_rcu()). But it
>> needs an unsigned long space for each free element or each call, and
>> it is not affordable for local storage element, so as for now always
>> rcu_trace_implies_rcu_gp().
>>
>> Comments are always welcome.
> For #2-#4:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>
> (#1 already has my Signed-off-by, in case anyone was wondering.)
Thanks for the review. But it seems I missed another possible use case for
rcu_trace_implies_rcu_gp() in bpf memory allocator. The code snippet for
free_mem_alloc() is as following:

static void free_mem_alloc(struct bpf_mem_alloc *ma)
{
        /* waiting_for_gp lists was drained, but __free_rcu might
         * still execute. Wait for it now before we freeing percpu caches.
         */
        rcu_barrier_tasks_trace();
        rcu_barrier();
        free_mem_alloc_no_barrier(ma);
}

It uses rcu_barrier_tasks_trace() and rcu_barrier() to wait for the completion
of pending call_rcu_tasks_trace()s and call_rcu()s. I think it is also safe to
check rcu_trace_implies_rcu_gp() in free_mem_alloc() and if it is true, there is
no need to call rcu_barrier().

static void free_mem_alloc(struct bpf_mem_alloc *ma)
{
        /* waiting_for_gp lists was drained, but __free_rcu_tasks_trace()
         * or __free_rcu() might still execute. Wait for it now before we
         * freeing percpu caches.
         */
        rcu_barrier_tasks_trace();
        if (!rcu_trace_implies_rcu_gp())
                rcu_barrier();
        free_mem_alloc_no_barrier(ma);
}

Does the above change look good to you ? If it is, I will post v3 to include the
above change and add your Reviewed-by tag.
>
>> Change Log:
>>
>> v2:
>>  * codify the implication of RCU Tasks Trace grace period instead of
>>    assuming for it
>>
>> v1: https://lore.kernel.org/bpf/20221011071128.3470622-1-houtao@huaweicloud.com
>>
>> Hou Tao (3):
>>   bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
>>   bpf: Use rcu_trace_implies_rcu_gp() in local storage map
>>   bpf: Use rcu_trace_implies_rcu_gp() for program array freeing
>>
>> Paul E. McKenney (1):
>>   rcu-tasks: Provide rcu_trace_implies_rcu_gp()
>>
>>  include/linux/rcupdate.h       | 12 ++++++++++++
>>  kernel/bpf/bpf_local_storage.c | 13 +++++++++++--
>>  kernel/bpf/core.c              |  8 +++++++-
>>  kernel/bpf/memalloc.c          | 15 ++++++++++-----
>>  kernel/rcu/tasks.h             |  2 ++
>>  5 files changed, 42 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.29.2
>>
> .

