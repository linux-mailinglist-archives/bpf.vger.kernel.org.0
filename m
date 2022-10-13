Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224425FE25D
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJMTFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJMTFJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 15:05:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58553E762;
        Thu, 13 Oct 2022 12:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E954B8206C;
        Thu, 13 Oct 2022 19:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D82C433C1;
        Thu, 13 Oct 2022 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665687903;
        bh=Vfg0pHyFhzSGiZooHQpx8VPimTooAQ6v8ioBWe/XJuI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UAPrL+Ou1YRUs/2ZYbI/Gg+o1Hu2JhseHFIPThXL5Nv+BN0TwIN97xdLir83hUbtk
         QWoFh0pYd9rVE+9jhMv73Ei4LYT58IXHNbDL7anSyI1BaHdoxlmgcpJIMJoAOTfUbC
         sPnEFZ+fSZYOhr4k4M3CZZoQF0TPfEQ7nEXNlpK4sdxvfpIy3r0qwImgU2VPTj2z4M
         L/7Y3yBYKdzBTsp82fGYUOn6K42+FzsRLWT4QBBWP0WLxbYPfPinqPg1TLQvBp5W/X
         VZ44TN8R03etw8Efi/KTxSDgzAP0rQpRC4sadTgwCTyPsMeZleUO8YJmgdV8l5getX
         MQOW85wUr2L/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC5C35C32BF; Thu, 13 Oct 2022 12:04:57 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:04:57 -0700
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
Message-ID: <20221013190457.GA4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
 <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
 <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
 <1e253bfb-1413-ffb4-a11c-c6c1fa43bce0@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e253bfb-1413-ffb4-a11c-c6c1fa43bce0@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 09:41:46AM +0800, Hou Tao wrote:
> Hi,
> 
> On 10/13/2022 12:11 AM, Paul E. McKenney wrote:
> > On Wed, Oct 12, 2022 at 05:26:26PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 10/12/2022 2:36 PM, Paul E. McKenney wrote:
> SNIP
> >> As said above, for bpf memory allocator it may be OK because it frees elements
> >> in batch, but for bpf local storage and its element these memories are freed
> >> individually. So I think if the implication of RCU tasks trace grace period will
> >> not be changed in the foreseeable future, adding rcu_trace_implies_rcu_gp() and
> >> using it in bpf is a good idea. What do you think ?
> > Maybe the BPF memory allocator does it one way and BPF local storage
> > does it another way.
> 
> Another question. Just find out that there are new APIs for RCU polling (e.g.
> get_state_synchronize_rcu_full()). According to comments, the advantage of new
> API is that it will never miss a passed grace period. So for this case is
> get_state_synchronize_rcu() enough ? Or should I switch to use
> get_state_synchronize_rcu_full() instead ?

I suggest starting with get_state_synchronize_rcu(), and moving to the
_full() variants only if experience shows that it is necessary.

Please note that these functions work with normal RCU, that is,
call_rcu(), but not call_rcu_tasks(), call_rcu_tasks_trace(), or
call_rcu_rude().  Please note also that SRCU has its own set of polling
APIs, for example, get_state_synchronize_srcu().

								Thanx, Paul

> Regards
> > How about if I produce a patch for rcu_trace_implies_rcu_gp() and let
> > you carry it with your series?  That way I don't have an unused function
> > in -rcu and you don't have to wait for me to send it upstream?
> >
> > 							Thanx, Paul
> >
> >>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>>>> ---
> >>>>>>  kernel/bpf/memalloc.c | 17 ++++++-----------
> >>>>>>  1 file changed, 6 insertions(+), 11 deletions(-)
> >>>>>>
> >>>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >>>>>> index 5f83be1d2018..6f32dddc804f 100644
> >>>>>> --- a/kernel/bpf/memalloc.c
> >>>>>> +++ b/kernel/bpf/memalloc.c
> >>>>>> @@ -209,6 +209,9 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
> >>>>>>  	kfree(obj);
> >>>>>>  }
> >>>>>>  
> >>>>>> +/* Now RCU Tasks grace period implies RCU grace period, so no need to do
> >>>>>> + * an extra call_rcu().
> >>>>>> + */
> >>>>>>  static void __free_rcu(struct rcu_head *head)
> >>>>>>  {
> >>>>>>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> >>>>>> @@ -220,13 +223,6 @@ static void __free_rcu(struct rcu_head *head)
> >>>>>>  	atomic_set(&c->call_rcu_in_progress, 0);
> >>>>>>  }
> >>>>>>  
> >>>>>> -static void __free_rcu_tasks_trace(struct rcu_head *head)
> >>>>>> -{
> >>>>>> -	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> >>>>>> -
> >>>>>> -	call_rcu(&c->rcu, __free_rcu);
> >>>>>> -}
> >>>>>> -
> >>>>>>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)
> >>>>>>  {
> >>>>>>  	struct llist_node *llnode = obj;
> >>>>>> @@ -252,11 +248,10 @@ static void do_call_rcu(struct bpf_mem_cache *c)
> >>>>>>  		 * from __free_rcu() and from drain_mem_cache().
> >>>>>>  		 */
> >>>>>>  		__llist_add(llnode, &c->waiting_for_gp);
> >>>>>> -	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> >>>>>> -	 * Then use call_rcu() to wait for normal progs to finish
> >>>>>> -	 * and finally do free_one() on each element.
> >>>>>> +	/* Use call_rcu_tasks_trace() to wait for both sleepable and normal
> >>>>>> +	 * progs to finish and finally do free_one() on each element.
> >>>>>>  	 */
> >>>>>> -	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
> >>>>>> +	call_rcu_tasks_trace(&c->rcu, __free_rcu);
> >>>>>>  }
> >>>>>>  
> >>>>>>  static void free_bulk(struct bpf_mem_cache *c)
> >>>>>> -- 
> >>>>>> 2.29.2
> >>>>>>
> 
