Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49FA646699
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLHBmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLHBmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:42:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684D90778;
        Wed,  7 Dec 2022 17:42:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9838BB8212E;
        Thu,  8 Dec 2022 01:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514ADC433B5;
        Thu,  8 Dec 2022 01:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670463732;
        bh=tpTCLGJyeiRNuantqgo8SYXrHBUZk3GTfa93gXzcr1k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lososBq9ZF6thMA2G77kr3DBpzKrcxrwEjDuWflpAGt8VzhIIXLhF3yslHJkgJlAW
         RbA4UODJ5ZOVk5PoPfBH1v5764zrmcFQMg0yDPw4vAyLBJ9r5gU8fjKVd34rMKH6OD
         mGLNi/isr/273C97QN15OR27M5ogZpSfYKVXrGUogAEBvL+zhZM0C3sBnamlDNGUlK
         dDukvR8HTaN4n6PibzNRkKT45THYOF1jEsG6UnBk2RnVFu3+1LAGiBWnCNGYYjNgEc
         n/gnri7bS0jS5GOsvmjA4JuPksQ/Pgb6rqIup7UwsTAnM1wy6lSNMjiolmtB5RF06s
         HpMrieaEL5E5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E62B35C0AEC; Wed,  7 Dec 2022 17:42:11 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:42:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org,
        rcu@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Skip rcu_barrier() if
 rcu_trace_implies_rcu_gp() is true
Message-ID: <20221208014211.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-3-houtao@huaweicloud.com>
 <2eac2a50-40bd-3430-039f-58947d7c7af5@huawei.com>
 <20221207222837.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <266a8113-b003-71a8-c7e1-70af87b7ffa7@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266a8113-b003-71a8-c7e1-70af87b7ffa7@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 08, 2022 at 09:27:05AM +0800, Hou Tao wrote:
> Hi,
> 
> On 12/8/2022 6:28 AM, Paul E. McKenney wrote:
> > On Wed, Dec 07, 2022 at 10:24:55AM +0800, Hou Tao wrote:
> >> Forget to cc Paul and RCU maillist for more comments.
> >>
> >> On 12/6/2022 12:29 PM, Hou Tao wrote:
> >>> From: Hou Tao <houtao1@huawei.com>
> >>>
> >>> If there are pending rcu callback, free_mem_alloc() will use
> >>> rcu_barrier_tasks_trace() and rcu_barrier() to wait for the pending
> >>> __free_rcu_tasks_trace() and __free_rcu() callback.
> >>>
> >>> If rcu_trace_implies_rcu_gp() is true, there will be no pending
> >>> __free_rcu(), so it will be OK to skip rcu_barrier() as well.
> > The bit about there being no pending __free_rcu() is guaranteed by
> > your algorithm, correct?  As in you have something like this somewhere
> > else in the code?
> >
> > 	if (!rcu_trace_implies_rcu_gp())
> > 		call_rcu(...);
> >
> > Or am I missing something more subtle?
> Yes. It is guaranteed by the implementation of bpf mem allocator: if
> rcu_trace_implies_rcu_gp() is true, there will be no call_rcu() in bpf memory
> allocator.

Very well, then from an RCU perspective:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> >>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>> ---
> >>>  kernel/bpf/memalloc.c | 10 +++++++++-
> >>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >>> index 7daf147bc8f6..d43991fafc4f 100644
> >>> --- a/kernel/bpf/memalloc.c
> >>> +++ b/kernel/bpf/memalloc.c
> >>> @@ -464,9 +464,17 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
> >>>  {
> >>>  	/* waiting_for_gp lists was drained, but __free_rcu might
> >>>  	 * still execute. Wait for it now before we freeing percpu caches.
> >>> +	 *
> >>> +	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
> >>> +	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
> >>> +	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
> >>> +	 * so if call_rcu(head, __free_rcu) is skipped due to
> >>> +	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
> >>> +	 * using rcu_trace_implies_rcu_gp() as well.
> >>>  	 */
> >>>  	rcu_barrier_tasks_trace();
> >>> -	rcu_barrier();
> >>> +	if (!rcu_trace_implies_rcu_gp())
> >>> +		rcu_barrier();
> >>>  	free_mem_alloc_no_barrier(ma);
> >>>  }
> >>>  
> 
