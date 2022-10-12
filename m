Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25415FC8EB
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiJLQLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJLQLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 12:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D5A033F;
        Wed, 12 Oct 2022 09:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC8D61557;
        Wed, 12 Oct 2022 16:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC1DC433C1;
        Wed, 12 Oct 2022 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665591067;
        bh=5baChwl7p9R7fplrSmrngOXPqaPkRkzDUYbEwWZ0Q10=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SuoINakrZK0I+x8uRoRqPDBMveQ8mddWgiqdR4LPi+/6zdEaSQmA1TFU0UZUmdpY0
         mDdPTBEgz1hevFvm/YE4B/wfMIBd75AIBRRS2dmbSUGGdgL+EC9SR4Devpk9ciwbZs
         E3vSp5aj6JXqAc+TC916KUPpFA5iDoya6PD38fa6Umf3z9OKg6zyEdMk7mDOZWZxxm
         WHBRzA4OqfJkoihoWhkuQhRMiwy/jbTKVNoJ4QIL7mPX5pPzR+GPcafyzYQoFH1mTa
         FvE7C49sEcQGXTlGrWfhbg7x3MwIHF/0d7AlfCCuLEKldNgM7SkRr0VrYB7SKTiNOA
         wL68ylf5I7Kpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D0BF5C196D; Wed, 12 Oct 2022 09:11:03 -0700 (PDT)
Date:   Wed, 12 Oct 2022 09:11:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
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
Subject: Re: [PATCH bpf-next 1/3] bpf: Free elements after one
 RCU-tasks-trace grace period
Message-ID: <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
 <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 12, 2022 at 05:26:26PM +0800, Hou Tao wrote:
> Hi,
> 
> On 10/12/2022 2:36 PM, Paul E. McKenney wrote:
> > On Tue, Oct 11, 2022 at 07:31:28PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 10/11/2022 5:07 PM, Paul E. McKenney wrote:
> >>> On Tue, Oct 11, 2022 at 03:11:26PM +0800, Hou Tao wrote:
> >>>> From: Hou Tao <houtao1@huawei.com>
> >>>>
> >>>> According to the implementation of RCU Tasks Trace, it inovkes
> >>>> ->postscan_func() to wait for one RCU-tasks-trace grace period and
> >>>> rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
> >>>> normal RCU grace period in turn, so one RCU-tasks-trace grace period
> >>>> will imply one RCU grace period.
> >>>>
> >>>> So there is no need to do call_rcu() again in the callback of
> >>>> call_rcu_tasks_trace() and it can just free these elements directly.
> >>> This is true, but this is an implementation detail that is not guaranteed
> >>> in future versions of the kernel.  But if this additional call_rcu()
> >>> is causing trouble, I could add some API member that returned true in
> >>> kernels where it does happen to be the case that call_rcu_tasks_trace()
> >>> implies a call_rcu()-style grace period.
> >>>
> >>> The BPF memory allocator could then complain or adapt, as appropriate.
> >>>
> >>> Thoughts?
> >> It is indeed an implementation details. But In an idle KVM guest, for memory
> >> reclamation in bpf memory allocator a RCU tasks trace grace period is about 30ms
> >> and RCU grace period is about 20 ms. Under stress condition, the grace period
> >> will be much longer. If the extra RCU grace period can be removed, these memory
> >> can be reclaimed more quickly and it will be beneficial for memory pressure.
> > I understand the benefits.  We just need to get a safe way to take
> > advantage of them.
> >
> >> Now it seems we can use RCU poll APIs (e.g. get_state_synchronize_rcu() and
> >> poll_state_synchronize_rcu() ) to check whether or not a RCU grace period has
> >> passed. But It needs to add at least one unsigned long into the freeing object.
> >> The extra memory overhead may be OK for bpf memory allocator, but it is not for
> >> small object. So could you please show example on how these new APIs work ? Does
> >> it need to modify the to-be-free object ?
> > Good point on the polling APIs, more on this below.
> >
> > I was thinking in terms of an API like this:
> >
> > 	static inline bool rcu_trace_implies_rcu_gp(void)
> > 	{
> > 		return true;
> > 	}
> >
> > Along with comments on the synchronize_rcu() pointing at the
> > rcu_trace_implies_rcu_gp().
> 
> It is a simple API and the modifications for call_rcu_tasks_trace() users will
> also be simple. The callback of call_rcu_tasks_trace() will invoke
> rcu_trace_implies_rcu_gp(), and it returns true, the callback invokes the
> callback for call_rcu() directly, else it does so through call_rcu().

Sounds good!

Please note that if the callback function just does kfree() or equivalent,
this will work fine.  If it acquires spinlocks, you may need to do
local_bh_disable() before invoking it directly and local_bh_enable()
afterwards.

> > Another approach is to wait for the grace periods concurrently, but this
> > requires not one but two rcu_head structures.
> 
> Beside the extra space usage, does it also complicate the logic in callback
> function because it needs to handle the concurrency problem ?

Definitely!!!

Perhaps something like this:

	static void cbf(struct rcu_head *rhp)
	{
		p = container_of(rhp, ...);

		if (atomic_dec_and_test(&p->cbs_awaiting))
			kfree(p);
	}

	atomic_set(&p->cbs_awating, 2);
	call_rcu(p->rh1, cbf);
	call_rcu_tasks_trace(p->rh2, cbf);

Is this worth it?  I have no idea.  I must defer to you.

> > Back to the polling API.  Are these things freed individually, or can
> > they be grouped?  If they can be grouped, the storage for the grace-period
> > state could be associated with the group.
> 
> As said above, for bpf memory allocator it may be OK because it frees elements
> in batch, but for bpf local storage and its element these memories are freed
> individually. So I think if the implication of RCU tasks trace grace period will
> not be changed in the foreseeable future, adding rcu_trace_implies_rcu_gp() and
> using it in bpf is a good idea. What do you think ?

Maybe the BPF memory allocator does it one way and BPF local storage
does it another way.

How about if I produce a patch for rcu_trace_implies_rcu_gp() and let
you carry it with your series?  That way I don't have an unused function
in -rcu and you don't have to wait for me to send it upstream?

							Thanx, Paul

> >>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>> ---
> >>>>  kernel/bpf/memalloc.c | 17 ++++++-----------
> >>>>  1 file changed, 6 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >>>> index 5f83be1d2018..6f32dddc804f 100644
> >>>> --- a/kernel/bpf/memalloc.c
> >>>> +++ b/kernel/bpf/memalloc.c
> >>>> @@ -209,6 +209,9 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
> >>>>  	kfree(obj);
> >>>>  }
> >>>>  
> >>>> +/* Now RCU Tasks grace period implies RCU grace period, so no need to do
> >>>> + * an extra call_rcu().
> >>>> + */
> >>>>  static void __free_rcu(struct rcu_head *head)
> >>>>  {
> >>>>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> >>>> @@ -220,13 +223,6 @@ static void __free_rcu(struct rcu_head *head)
> >>>>  	atomic_set(&c->call_rcu_in_progress, 0);
> >>>>  }
> >>>>  
> >>>> -static void __free_rcu_tasks_trace(struct rcu_head *head)
> >>>> -{
> >>>> -	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> >>>> -
> >>>> -	call_rcu(&c->rcu, __free_rcu);
> >>>> -}
> >>>> -
> >>>>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)
> >>>>  {
> >>>>  	struct llist_node *llnode = obj;
> >>>> @@ -252,11 +248,10 @@ static void do_call_rcu(struct bpf_mem_cache *c)
> >>>>  		 * from __free_rcu() and from drain_mem_cache().
> >>>>  		 */
> >>>>  		__llist_add(llnode, &c->waiting_for_gp);
> >>>> -	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> >>>> -	 * Then use call_rcu() to wait for normal progs to finish
> >>>> -	 * and finally do free_one() on each element.
> >>>> +	/* Use call_rcu_tasks_trace() to wait for both sleepable and normal
> >>>> +	 * progs to finish and finally do free_one() on each element.
> >>>>  	 */
> >>>> -	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
> >>>> +	call_rcu_tasks_trace(&c->rcu, __free_rcu);
> >>>>  }
> >>>>  
> >>>>  static void free_bulk(struct bpf_mem_cache *c)
> >>>> -- 
> >>>> 2.29.2
> >>>>
> 
