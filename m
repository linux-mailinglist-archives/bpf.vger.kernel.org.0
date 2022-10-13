Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBCF5FE255
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJMTCG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 15:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiJMTBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 15:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398511A95A;
        Thu, 13 Oct 2022 12:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6804361935;
        Thu, 13 Oct 2022 19:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865F6C433D6;
        Thu, 13 Oct 2022 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665687646;
        bh=q5r2a0Dg9d191ZSoAHgA3aIgn5v3wJh53ckgsrvi0ls=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TCzx4VVEXjZWJ9wZHoq+R8SLuDGMGVuNRc1aPYgYr2sRzS01WA+Gl7yofu+yG9CTx
         t6SD+JFB3fpEje6o7vDWCG9de4ntIUYxmuaOTUcGNeUb7HlxP///uP9kewvBZyAyKV
         LU1B7NTJce3H24F8gRne7a3tM+1RdBfIc3mpTN6s/4U3ugwPiFm4JFwRejAZeA0m7y
         eAxgTWF2abpjasCVYWFvJqn10Va2cZWUhtG3MZgCsY4wUVhqojqk2dJkHEu2nOuI2j
         Sb4cdtY3ufMbkAbyr/z4PQJEUItMagpzoOnnqdXrhFPpsImof9A+td/HkqSN16C4gT
         SpMWN9V+Y/QQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 53A565C32BF; Thu, 13 Oct 2022 12:00:41 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:00:41 -0700
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
Message-ID: <20221013190041.GZ4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
 <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
 <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
 <ca5f2973-e8b5-0d73-fd23-849f0dfc4347@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5f2973-e8b5-0d73-fd23-849f0dfc4347@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 09:25:31AM +0800, Hou Tao wrote:
> Hi,
> 
> On 10/13/2022 12:11 AM, Paul E. McKenney wrote:
> > On Wed, Oct 12, 2022 at 05:26:26PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 10/12/2022 2:36 PM, Paul E. McKenney wrote:
> >>> On Tue, Oct 11, 2022 at 07:31:28PM +0800, Hou Tao wrote:
> >>>> Hi,
> >>>>
> >>>> On 10/11/2022 5:07 PM, Paul E. McKenney wrote:
> >>>>> On Tue, Oct 11, 2022 at 03:11:26PM +0800, Hou Tao wrote:
> >>>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>>
> >>>>>> According to the implementation of RCU Tasks Trace, it inovkes
> >>>>>> ->postscan_func() to wait for one RCU-tasks-trace grace period and
> >>>>>> rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
> >>>>>> normal RCU grace period in turn, so one RCU-tasks-trace grace period
> >>>>>> will imply one RCU grace period.
> >>>>>>
> >>>>>> So there is no need to do call_rcu() again in the callback of
> >>>>>> call_rcu_tasks_trace() and it can just free these elements directly.
> >>>>> This is true, but this is an implementation detail that is not guaranteed
> >>>>> in future versions of the kernel.  But if this additional call_rcu()
> >>>>> is causing trouble, I could add some API member that returned true in
> >>>>> kernels where it does happen to be the case that call_rcu_tasks_trace()
> >>>>> implies a call_rcu()-style grace period.
> >>>>>
> >>>>> The BPF memory allocator could then complain or adapt, as appropriate.
> >>>>>
> >>>>> Thoughts?
> >>>> It is indeed an implementation details. But In an idle KVM guest, for memory
> >>>> reclamation in bpf memory allocator a RCU tasks trace grace period is about 30ms
> >>>> and RCU grace period is about 20 ms. Under stress condition, the grace period
> >>>> will be much longer. If the extra RCU grace period can be removed, these memory
> >>>> can be reclaimed more quickly and it will be beneficial for memory pressure.
> >>> I understand the benefits.  We just need to get a safe way to take
> >>> advantage of them.
> >>>
> >>>> Now it seems we can use RCU poll APIs (e.g. get_state_synchronize_rcu() and
> >>>> poll_state_synchronize_rcu() ) to check whether or not a RCU grace period has
> >>>> passed. But It needs to add at least one unsigned long into the freeing object.
> >>>> The extra memory overhead may be OK for bpf memory allocator, but it is not for
> >>>> small object. So could you please show example on how these new APIs work ? Does
> >>>> it need to modify the to-be-free object ?
> >>> Good point on the polling APIs, more on this below.
> >>>
> >>> I was thinking in terms of an API like this:
> >>>
> >>> 	static inline bool rcu_trace_implies_rcu_gp(void)
> >>> 	{
> >>> 		return true;
> >>> 	}
> >>>
> >>> Along with comments on the synchronize_rcu() pointing at the
> >>> rcu_trace_implies_rcu_gp().
> >> It is a simple API and the modifications for call_rcu_tasks_trace() users will
> >> also be simple. The callback of call_rcu_tasks_trace() will invoke
> >> rcu_trace_implies_rcu_gp(), and it returns true, the callback invokes the
> >> callback for call_rcu() directly, else it does so through call_rcu().
> > Sounds good!
> >
> > Please note that if the callback function just does kfree() or equivalent,
> > this will work fine.  If it acquires spinlocks, you may need to do
> > local_bh_disable() before invoking it directly and local_bh_enable()
> > afterwards.
> What is the purpose for invoking local_bh_disable() ? Is it trying to ensure the
> callback is called under soft-irq context or something else ? For all I know,
> task rcu already invokes its callback with soft-irq disabled.
> >
> >>> Another approach is to wait for the grace periods concurrently, but this
> >>> requires not one but two rcu_head structures.
> >> Beside the extra space usage, does it also complicate the logic in callback
> >> function because it needs to handle the concurrency problem ?
> > Definitely!!!
> >
> > Perhaps something like this:
> >
> > 	static void cbf(struct rcu_head *rhp)
> > 	{
> > 		p = container_of(rhp, ...);
> >
> > 		if (atomic_dec_and_test(&p->cbs_awaiting))
> > 			kfree(p);
> > 	}
> >
> > 	atomic_set(&p->cbs_awating, 2);
> > 	call_rcu(p->rh1, cbf);
> > 	call_rcu_tasks_trace(p->rh2, cbf);
> >
> > Is this worth it?  I have no idea.  I must defer to you.
> I still prefer the simple solution.
> >
> >>> Back to the polling API.  Are these things freed individually, or can
> >>> they be grouped?  If they can be grouped, the storage for the grace-period
> >>> state could be associated with the group.
> >> As said above, for bpf memory allocator it may be OK because it frees elements
> >> in batch, but for bpf local storage and its element these memories are freed
> >> individually. So I think if the implication of RCU tasks trace grace period will
> >> not be changed in the foreseeable future, adding rcu_trace_implies_rcu_gp() and
> >> using it in bpf is a good idea. What do you think ?
> > Maybe the BPF memory allocator does it one way and BPF local storage
> > does it another way.
> Why not. Maybe bpf expert think the space overhead is also reasonable in the BPF
> local storage case.
> >
> > How about if I produce a patch for rcu_trace_implies_rcu_gp() and let
> > you carry it with your series?  That way I don't have an unused function
> > in -rcu and you don't have to wait for me to send it upstream?
> Sound reasonable to me. Also thanks for your suggestions.

Here you go!  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 2eac2f7a9a6d8921e8084a6acdffa595e99dbd17
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Oct 13 11:54:13 2022 -0700

    rcu-tasks: Provide rcu_trace_implies_rcu_gp()
    
    As an accident of implementation, an RCU Tasks Trace grace period also
    acts as an RCU grace period.  However, this could change at any time.
    This commit therefore creates an rcu_trace_implies_rcu_gp() that currently
    returns true to codify this accident.  Code relying on this accident
    must call this function to verify that this accident is still happening.
    
    Reported-by: Hou Tao <houtao@huaweicloud.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Martin KaFai Lau <martin.lau@linux.dev>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 08605ce7379d7..8822f06e4b40c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -240,6 +240,18 @@ static inline void exit_tasks_rcu_start(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
+/**
+ * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
+ *
+ * As an accident of implementation, an RCU Tasks Trace grace period also
+ * acts as an RCU grace period.  However, this could change at any time.
+ * Code relying on this accident must call this function to verify that
+ * this accident is still happening.
+ *
+ * You have been warned!
+ */
+static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
+
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b0b885e071fa8..fe9840d90e960 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1535,6 +1535,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
+
+	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
 	synchronize_rcu();
 	// Any tasks that exit after this point will set
 	// TRC_NEED_QS_CHECKED in ->trc_reader_special.b.need_qs.
