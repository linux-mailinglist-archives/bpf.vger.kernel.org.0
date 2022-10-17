Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFC600C56
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJQKXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 06:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJQKXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 06:23:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC95FF78;
        Mon, 17 Oct 2022 03:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E3C6B80EBC;
        Mon, 17 Oct 2022 10:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD5DC433C1;
        Mon, 17 Oct 2022 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666002208;
        bh=QLEHGCW7xXfc4Y5boWh9RvlBYFF23CeV0KDD6wxy52Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n62nZxvWty97PrIb3kgXodtLNqxbk+3LIuywgTHNFR74f9BsHPS1/n5UPHmyvojB9
         qqMgLXwO9s5EEQxb+L5+OgRTec/WfTzU/gjxsYMBlVy6jjE06zrH69V3HNEgwKC87u
         zf5c8YPgbvjyXXqMYJ9+gdRsZv3X8/LkbW4bNOMtLnts9yuQ/Tu/nSJME67KP75uZ1
         u6xEnXRsGITldb7MQchk/AhdcS2EQFzjigCMjB/Rmlrd2p7E6DwpYzhVeUJal+cCkP
         PZQdYCg8ZskEWvXlzwxYT4m/cP7gpeHrPVUvfjeE9QmSuIlMHPsF3lkDZb2iJegSDY
         lBE4OwhMvOOfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 551685C08EC; Mon, 17 Oct 2022 03:23:28 -0700 (PDT)
Date:   Mon, 17 Oct 2022 03:23:28 -0700
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
Message-ID: <20221017102328.GC5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
 <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
 <ca5f2973-e8b5-0d73-fd23-849f0dfc4347@huaweicloud.com>
 <20221013190041.GZ4221@paulmck-ThinkPad-P17-Gen-1>
 <08d09b15-5a6b-7f76-d53d-242fb20ed394@huaweicloud.com>
 <20221014121507.GB4221@paulmck-ThinkPad-P17-Gen-1>
 <05a580b3-02ca-a844-f553-400d842385d7@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a580b3-02ca-a844-f553-400d842385d7@huaweicloud.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 17, 2022 at 02:55:42PM +0800, Hou Tao wrote:
> Hi,
> 
> On 10/14/2022 8:15 PM, Paul E. McKenney wrote:
> > On Fri, Oct 14, 2022 at 12:20:19PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 10/14/2022 3:00 AM, Paul E. McKenney wrote:
> >>> On Thu, Oct 13, 2022 at 09:25:31AM +0800, Hou Tao wrote:
> >>>> Hi,
> >>>>
> >>>> On 10/13/2022 12:11 AM, Paul E. McKenney wrote:
> >>>>> On Wed, Oct 12, 2022 at 05:26:26PM +0800, Hou Tao wrote:
> >> SNIP
> >>>>> How about if I produce a patch for rcu_trace_implies_rcu_gp() and let
> >>>>> you carry it with your series?  That way I don't have an unused function
> >>>>> in -rcu and you don't have to wait for me to send it upstream?
> >>>> Sound reasonable to me. Also thanks for your suggestions.
> >>> Here you go!  Thoughts?
> >> It looks great and thanks for it.
> > Very good!  I will carry it in -rcu for some time, so please let me know
> > when/if you pull it into a series.
> Have already included the patch in v2 patch-set and send it out [0].
> 
> 0: https://lore.kernel.org/bpf/20221014113946.965131-1-houtao@huaweicloud.com/T/#t

Thank you, I will drop it from -rcu on my next rebase.  Should you need
to refer to it again, it will remain at tag rcutrace-rcu.2022.10.13a.

							Thanx, Paul

> >>> ------------------------------------------------------------------------
> >>>
> >>> commit 2eac2f7a9a6d8921e8084a6acdffa595e99dbd17
> >>> Author: Paul E. McKenney <paulmck@kernel.org>
> >>> Date:   Thu Oct 13 11:54:13 2022 -0700
> >>>
> >>>     rcu-tasks: Provide rcu_trace_implies_rcu_gp()
> >>>     
> >>>     As an accident of implementation, an RCU Tasks Trace grace period also
> >>>     acts as an RCU grace period.  However, this could change at any time.
> >>>     This commit therefore creates an rcu_trace_implies_rcu_gp() that currently
> >>>     returns true to codify this accident.  Code relying on this accident
> >>>     must call this function to verify that this accident is still happening.
> >>>     
> >>>     Reported-by: Hou Tao <houtao@huaweicloud.com>
> >>>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>>     Cc: Alexei Starovoitov <ast@kernel.org>
> >>>     Cc: Martin KaFai Lau <martin.lau@linux.dev>
> >>>
> >>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >>> index 08605ce7379d7..8822f06e4b40c 100644
> >>> --- a/include/linux/rcupdate.h
> >>> +++ b/include/linux/rcupdate.h
> >>> @@ -240,6 +240,18 @@ static inline void exit_tasks_rcu_start(void) { }
> >>>  static inline void exit_tasks_rcu_finish(void) { }
> >>>  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
> >>>  
> >>> +/**
> >>> + * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
> >>> + *
> >>> + * As an accident of implementation, an RCU Tasks Trace grace period also
> >>> + * acts as an RCU grace period.  However, this could change at any time.
> >>> + * Code relying on this accident must call this function to verify that
> >>> + * this accident is still happening.
> >>> + *
> >>> + * You have been warned!
> >>> + */
> >>> +static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
> >>> +
> >>>  /**
> >>>   * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
> >>>   *
> >>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >>> index b0b885e071fa8..fe9840d90e960 100644
> >>> --- a/kernel/rcu/tasks.h
> >>> +++ b/kernel/rcu/tasks.h
> >>> @@ -1535,6 +1535,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
> >>>  {
> >>>  	// Wait for late-stage exiting tasks to finish exiting.
> >>>  	// These might have passed the call to exit_tasks_rcu_finish().
> >>> +
> >>> +	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
> >>>  	synchronize_rcu();
> >>>  	// Any tasks that exit after this point will set
> >>>  	// TRC_NEED_QS_CHECKED in ->trc_reader_special.b.need_qs.
> > .
> 
