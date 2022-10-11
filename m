Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E825FAF13
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJKJHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJKJHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 05:07:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF80487F96;
        Tue, 11 Oct 2022 02:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFF96B81263;
        Tue, 11 Oct 2022 09:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F92C433D7;
        Tue, 11 Oct 2022 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665479264;
        bh=BNSsknk44ZAqLbT4HFUMJezP4rdmd2IhcfoYoM79mBk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tq+bYeUJYqPSinlI/0I72zOf45kW1DtMIEFwE1pq3VoYTEueiNZfWfNQX+w1VFSIi
         r5dbcRZll8OGqpMVAG/d3rqegCossvc1fIldC3zaxzP6bwKR15cD7B4HxOi7gsNv2C
         10rgrdEYOf9jgrewzXJ1DaY7yPB2zhnNsHBXkS5jUThC7QewPy5C5h6qyw5AzdWEjy
         Hqe3PrlAsCoLsD6wIhH796xPHKRovO5QJ53pwJBoFB/XHnJKOL4eCPQkpdGjWWYK5S
         O67tCYubzPtS/BkHrwKjL3vwUpexBNYL70KS+W+fN9z7WGhCqQWvbFJ+A/AwDgknfE
         PxoReukCD30UA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1165E5C1959; Tue, 11 Oct 2022 02:07:42 -0700 (PDT)
Date:   Tue, 11 Oct 2022 02:07:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
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
        John Fastabend <john.fastabend@gmail.com>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Free elements after one
 RCU-tasks-trace grace period
Message-ID: <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011071128.3470622-2-houtao@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 03:11:26PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> According to the implementation of RCU Tasks Trace, it inovkes
> ->postscan_func() to wait for one RCU-tasks-trace grace period and
> rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
> normal RCU grace period in turn, so one RCU-tasks-trace grace period
> will imply one RCU grace period.
> 
> So there is no need to do call_rcu() again in the callback of
> call_rcu_tasks_trace() and it can just free these elements directly.

This is true, but this is an implementation detail that is not guaranteed
in future versions of the kernel.  But if this additional call_rcu()
is causing trouble, I could add some API member that returned true in
kernels where it does happen to be the case that call_rcu_tasks_trace()
implies a call_rcu()-style grace period.

The BPF memory allocator could then complain or adapt, as appropriate.

Thoughts?

							Thanx, Paul

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/memalloc.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 5f83be1d2018..6f32dddc804f 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -209,6 +209,9 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
>  	kfree(obj);
>  }
>  
> +/* Now RCU Tasks grace period implies RCU grace period, so no need to do
> + * an extra call_rcu().
> + */
>  static void __free_rcu(struct rcu_head *head)
>  {
>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> @@ -220,13 +223,6 @@ static void __free_rcu(struct rcu_head *head)
>  	atomic_set(&c->call_rcu_in_progress, 0);
>  }
>  
> -static void __free_rcu_tasks_trace(struct rcu_head *head)
> -{
> -	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> -
> -	call_rcu(&c->rcu, __free_rcu);
> -}
> -
>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>  {
>  	struct llist_node *llnode = obj;
> @@ -252,11 +248,10 @@ static void do_call_rcu(struct bpf_mem_cache *c)
>  		 * from __free_rcu() and from drain_mem_cache().
>  		 */
>  		__llist_add(llnode, &c->waiting_for_gp);
> -	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> -	 * Then use call_rcu() to wait for normal progs to finish
> -	 * and finally do free_one() on each element.
> +	/* Use call_rcu_tasks_trace() to wait for both sleepable and normal
> +	 * progs to finish and finally do free_one() on each element.
>  	 */
> -	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
> +	call_rcu_tasks_trace(&c->rcu, __free_rcu);
>  }
>  
>  static void free_bulk(struct bpf_mem_cache *c)
> -- 
> 2.29.2
> 
