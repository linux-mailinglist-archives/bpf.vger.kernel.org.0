Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147FA607E66
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJUSuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 14:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJUSuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 14:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481A5723C;
        Fri, 21 Oct 2022 11:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E598061E60;
        Fri, 21 Oct 2022 18:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372D9C433D6;
        Fri, 21 Oct 2022 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666378203;
        bh=MIMk8SykGtHu+JTAbFVSE1Qacg13FwxfgiTIJ0aoahs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WGZc+y5LARC/x5z6wooSAa9pmaYMba9XUckBwbtotub0Nnen6fZoTmjE52CTegJye
         777gCJq0VsQKIHXzsriNrhHFYGU/8xDrirP3ZElVxxN4yYPu9pjiTn2+LWaL4FdXFN
         IjEqJkCL/we7LCE3NuDLzfMFcvP32UB4exBVtyOC64d1goKsWSP4lCKjigNqU0CfXc
         oXcwbV/iJvQfBioFaSOp5agohTWoFwEh0d4krGL6lizyfIzXEuMXSY4FiXKUdXOmkd
         hkHI7NtWuy9RcLEncUYSkD08faYcaAcH8AKuayMjHcbigrTtJ9LeYY4nN/+JO6Dqcw
         kgpumB9cLDplw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CA29B5C0543; Fri, 21 Oct 2022 11:50:02 -0700 (PDT)
Date:   Fri, 21 Oct 2022 11:50:02 -0700
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
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] Remove unnecessary RCU grace period
 chaining
Message-ID: <20221021185002.GP5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221014113946.965131-1-houtao@huaweicloud.com>
 <20221017133941.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <0b01d904-523e-14de-71fa-23bf23d2743f@huaweicloud.com>
 <20221018150824.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <da44591b-71d3-1cf4-fb68-1218d7a531b7@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da44591b-71d3-1cf4-fb68-1218d7a531b7@huaweicloud.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 03:08:21PM +0800, Hou Tao wrote:
> Hi,
> 
> On 10/18/2022 11:08 PM, Paul E. McKenney wrote:
> > On Tue, Oct 18, 2022 at 03:31:20PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 10/17/2022 9:39 PM, Paul E. McKenney wrote:
> >>> On Fri, Oct 14, 2022 at 07:39:42PM +0800, Hou Tao wrote:
> SNIP
> >>>
> >> Thanks for the review. But it seems I missed another possible use case for
> >> rcu_trace_implies_rcu_gp() in bpf memory allocator. The code snippet for
> >> free_mem_alloc() is as following:
> >>
> >> static void free_mem_alloc(struct bpf_mem_alloc *ma)
> >> {
> >>         /* waiting_for_gp lists was drained, but __free_rcu might
> >>          * still execute. Wait for it now before we freeing percpu caches.
> >>          */
> >>         rcu_barrier_tasks_trace();
> >>         rcu_barrier();
> >>         free_mem_alloc_no_barrier(ma);
> >> }
> >>
> >> It uses rcu_barrier_tasks_trace() and rcu_barrier() to wait for the completion
> >> of pending call_rcu_tasks_trace()s and call_rcu()s. I think it is also safe to
> >> check rcu_trace_implies_rcu_gp() in free_mem_alloc() and if it is true, there is
> >> no need to call rcu_barrier().
> >>
> >> static void free_mem_alloc(struct bpf_mem_alloc *ma)
> >> {
> >>         /* waiting_for_gp lists was drained, but __free_rcu_tasks_trace()
> >>          * or __free_rcu() might still execute. Wait for it now before we
> >>          * freeing percpu caches.
> >>          */
> >>         rcu_barrier_tasks_trace();
> >>         if (!rcu_trace_implies_rcu_gp())
> >>                 rcu_barrier();
> >>         free_mem_alloc_no_barrier(ma);
> >> }
> >>
> >> Does the above change look good to you ? If it is, I will post v3 to include the
> >> above change and add your Reviewed-by tag.
> > Unfortunately, although synchronize_rcu_tasks_trace() implies
> > that synchronize_rcu(), there is no relationship between the
> > callbacks.  Furthermore, rcu_barrier_tasks_trace() does not imply
> > synchronize_rcu_tasks_trace().
> 
> Yes. I see. And according to the code, if there is not pending cb,
> rcu_barrier_tasks_trace() will returned immediately. It is also possible
> rcu_tasks_trace kthread is in the middle of grace period waiting when invoking
> rcu_barrier_task_trace(), so rcu_barrier_task_trace() does not imply
> synchronize_rcu_tasks_trace().

Very good!

> > So the above change really would break things.  Please do not do it.
> 
> However I am a little confused about the conclusion. If only considering the
> invocations of call_rcu() and call_rcu_tasks_trace() in kernel/bpf/memalloc.c, I
> think it is safe to do so, right ? Because if  rcu_trace_implies_rcu_gp() is
> true, there will be no invocation of call_rcu() and rcu_barrier_tasks_trace()
> will wait for the completion of pending call_rcu_tasks_trace(). If
> rcu_trace_implies_rcu_gp(), rcu_barrier_tasks_trace() and rcu_barrier() will do
> the job. If considering the invocations of call_rcu() in other places, I think
> it is definitely unsafe to do that, right ?

Agreed, I am being cautious and pessimistic in assuming that there are
other call_rcu() invocations.  On the other hand, my caution and pessimism
is based on their having been other call_rcu() invocations in the past.
So please verify that there are none before making this sort of change.

							Thanx, Paul

> > You could use workqueues or similar to make the rcu_barrier_tasks_trace()
> > and the rcu_barrier() wait concurrently, though.  This would of course
> > require some synchronization.
> Thanks for the suggestion. Will check it later.
> >
> > 							Thanx, Paul
> >
> >>>> Change Log:
> >>>>
> >>>> v2:
> >>>>  * codify the implication of RCU Tasks Trace grace period instead of
> >>>>    assuming for it
> >>>>
> >>>> v1: https://lore.kernel.org/bpf/20221011071128.3470622-1-houtao@huaweicloud.com
> >>>>
> >>>> Hou Tao (3):
> >>>>   bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
> >>>>   bpf: Use rcu_trace_implies_rcu_gp() in local storage map
> >>>>   bpf: Use rcu_trace_implies_rcu_gp() for program array freeing
> >>>>
> >>>> Paul E. McKenney (1):
> >>>>   rcu-tasks: Provide rcu_trace_implies_rcu_gp()
> >>>>
> >>>>  include/linux/rcupdate.h       | 12 ++++++++++++
> >>>>  kernel/bpf/bpf_local_storage.c | 13 +++++++++++--
> >>>>  kernel/bpf/core.c              |  8 +++++++-
> >>>>  kernel/bpf/memalloc.c          | 15 ++++++++++-----
> >>>>  kernel/rcu/tasks.h             |  2 ++
> >>>>  5 files changed, 42 insertions(+), 8 deletions(-)
> >>>>
> >>>> -- 
> >>>> 2.29.2
> >>>>
> >>> .
> 
