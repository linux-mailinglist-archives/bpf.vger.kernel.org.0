Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D25602F2B
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 17:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJRPIa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJRPI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 11:08:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2448FDCAC3;
        Tue, 18 Oct 2022 08:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E17B81F70;
        Tue, 18 Oct 2022 15:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FBAC433D7;
        Tue, 18 Oct 2022 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666105704;
        bh=uQ71n2yHyt3Vm2nyfySFXCMiNXt4ocCVpPKxwNbf2bk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kL5pmhQFWvBzJMPvTyMgRASEU28/yjWhGxlxeKtDuq/+fqcOV/SjTUnAT+8qnk1dx
         G3B7mPz6vnpDrozmYrBSVhSOclxrDM29PzXY/KkQkQzkmjdlxhSLFGeYdA9O7KXxua
         DHtgxwThO/hDtbr2E3x96SfHJ79L73q+uwuG4RwTFj0phEgEavT3viy7qEZXWaB12o
         RGaffPVXuVBOrOU5fwDX4Bq9mlYck3JpeA32ISFsR0F9IodhClEF4/hI+28qTQJyN/
         QNjd+B/p6jCSwE7wHc0PGxSp8GnKnnikNdXobmiHRyGYfChx9AJSTfOgqOuJ7CbfbK
         MGqUlbQEMODOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 72D1D5C0528; Tue, 18 Oct 2022 08:08:24 -0700 (PDT)
Date:   Tue, 18 Oct 2022 08:08:24 -0700
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
Message-ID: <20221018150824.GP5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221014113946.965131-1-houtao@huaweicloud.com>
 <20221017133941.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <0b01d904-523e-14de-71fa-23bf23d2743f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b01d904-523e-14de-71fa-23bf23d2743f@huaweicloud.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 03:31:20PM +0800, Hou Tao wrote:
> Hi,
> 
> On 10/17/2022 9:39 PM, Paul E. McKenney wrote:
> > On Fri, Oct 14, 2022 at 07:39:42PM +0800, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Hi,
> >>
> >> Now bpf uses RCU grace period chaining to wait for the completion of
> >> access from both sleepable and non-sleepable bpf program: calling
> >> call_rcu_tasks_trace() firstly to wait for a RCU-tasks-trace grace
> >> period, then in its callback calls call_rcu() or kfree_rcu() to wait for
> >> a normal RCU grace period.
> >>
> >> According to the implementation of RCU Tasks Trace, it inovkes
> >> ->postscan_func() to wait for one RCU-tasks-trace grace period and
> >> rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
> >> normal RCU grace period in turn, so one RCU-tasks-trace grace period
> >> will imply one normal RCU grace period. To codify the implication,
> >> introduces rcu_trace_implies_rcu_gp() in patch #1. And using it in patch
> >> #2~#4 to remove unnecessary call_rcu() or kfree_rcu() in bpf subsystem.
> >> Other two uses of call_rcu_tasks_trace() are unchanged: for
> >> __bpf_prog_put_rcu() there is no gp chain and for
> >> __bpf_tramp_image_put_rcu_tasks() it chains RCU tasks trace GP and RCU
> >> tasks GP.
> >>
> >> An alternative way to remove these unnecessary RCU grace period
> >> chainings is using the RCU polling API to check whether or not a normal
> >> RCU grace period has passed (e.g. get_state_synchronize_rcu()). But it
> >> needs an unsigned long space for each free element or each call, and
> >> it is not affordable for local storage element, so as for now always
> >> rcu_trace_implies_rcu_gp().
> >>
> >> Comments are always welcome.
> > For #2-#4:
> >
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > (#1 already has my Signed-off-by, in case anyone was wondering.)
> Thanks for the review. But it seems I missed another possible use case for
> rcu_trace_implies_rcu_gp() in bpf memory allocator. The code snippet for
> free_mem_alloc() is as following:
> 
> static void free_mem_alloc(struct bpf_mem_alloc *ma)
> {
>         /* waiting_for_gp lists was drained, but __free_rcu might
>          * still execute. Wait for it now before we freeing percpu caches.
>          */
>         rcu_barrier_tasks_trace();
>         rcu_barrier();
>         free_mem_alloc_no_barrier(ma);
> }
> 
> It uses rcu_barrier_tasks_trace() and rcu_barrier() to wait for the completion
> of pending call_rcu_tasks_trace()s and call_rcu()s. I think it is also safe to
> check rcu_trace_implies_rcu_gp() in free_mem_alloc() and if it is true, there is
> no need to call rcu_barrier().
> 
> static void free_mem_alloc(struct bpf_mem_alloc *ma)
> {
>         /* waiting_for_gp lists was drained, but __free_rcu_tasks_trace()
>          * or __free_rcu() might still execute. Wait for it now before we
>          * freeing percpu caches.
>          */
>         rcu_barrier_tasks_trace();
>         if (!rcu_trace_implies_rcu_gp())
>                 rcu_barrier();
>         free_mem_alloc_no_barrier(ma);
> }
> 
> Does the above change look good to you ? If it is, I will post v3 to include the
> above change and add your Reviewed-by tag.

Unfortunately, although synchronize_rcu_tasks_trace() implies
that synchronize_rcu(), there is no relationship between the
callbacks.  Furthermore, rcu_barrier_tasks_trace() does not imply
synchronize_rcu_tasks_trace().

So the above change really would break things.  Please do not do it.

You could use workqueues or similar to make the rcu_barrier_tasks_trace()
and the rcu_barrier() wait concurrently, though.  This would of course
require some synchronization.

							Thanx, Paul

> >> Change Log:
> >>
> >> v2:
> >>  * codify the implication of RCU Tasks Trace grace period instead of
> >>    assuming for it
> >>
> >> v1: https://lore.kernel.org/bpf/20221011071128.3470622-1-houtao@huaweicloud.com
> >>
> >> Hou Tao (3):
> >>   bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
> >>   bpf: Use rcu_trace_implies_rcu_gp() in local storage map
> >>   bpf: Use rcu_trace_implies_rcu_gp() for program array freeing
> >>
> >> Paul E. McKenney (1):
> >>   rcu-tasks: Provide rcu_trace_implies_rcu_gp()
> >>
> >>  include/linux/rcupdate.h       | 12 ++++++++++++
> >>  kernel/bpf/bpf_local_storage.c | 13 +++++++++++--
> >>  kernel/bpf/core.c              |  8 +++++++-
> >>  kernel/bpf/memalloc.c          | 15 ++++++++++-----
> >>  kernel/rcu/tasks.h             |  2 ++
> >>  5 files changed, 42 insertions(+), 8 deletions(-)
> >>
> >> -- 
> >> 2.29.2
> >>
> > .
> 
