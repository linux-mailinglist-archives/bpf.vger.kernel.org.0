Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E619B60105D
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJQNjp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJQNjo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 09:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA3193DC;
        Mon, 17 Oct 2022 06:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90CBB61149;
        Mon, 17 Oct 2022 13:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EA5C433D6;
        Mon, 17 Oct 2022 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666013981;
        bh=VWdsyJklIFqTKFzaZdG160rEOXJvSY1pTS3ruH0xx9Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iocHajVGnjaoi7KlkLktTXZ+e4bx9AD+KSesMhZ/aglmZAf+I90ZU0kCz3ES7F7t6
         fDFtGjqpaWOp7RllrRWBd/MHY24YaUikbFvCe+eVUaN5LMHSg7AZNx1K4dmoQEbESK
         omq6lelD8idiWvdBvZXuc9S1DnI2Ll3Aanju6yf7k2pCmGa+4s7nN5wt84Jwyq5ZQ7
         m5ohv3dsQjeB8o+1IGB6CyKtPUK0Q+iMjSv8gpdsGW+3T69h+tlNSb4mGGlLbTkpqY
         HBQlkeJp2FiT02pSXlOaUcUcVI2j9tZNjOg6ZZ4ok34t14t67vIbutIs93svt6nXvD
         0OsGGkknSou3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7CB565C0622; Mon, 17 Oct 2022 06:39:41 -0700 (PDT)
Date:   Mon, 17 Oct 2022 06:39:41 -0700
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
Message-ID: <20221017133941.GF5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221014113946.965131-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014113946.965131-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 14, 2022 at 07:39:42PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> Now bpf uses RCU grace period chaining to wait for the completion of
> access from both sleepable and non-sleepable bpf program: calling
> call_rcu_tasks_trace() firstly to wait for a RCU-tasks-trace grace
> period, then in its callback calls call_rcu() or kfree_rcu() to wait for
> a normal RCU grace period.
> 
> According to the implementation of RCU Tasks Trace, it inovkes
> ->postscan_func() to wait for one RCU-tasks-trace grace period and
> rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
> normal RCU grace period in turn, so one RCU-tasks-trace grace period
> will imply one normal RCU grace period. To codify the implication,
> introduces rcu_trace_implies_rcu_gp() in patch #1. And using it in patch
> #2~#4 to remove unnecessary call_rcu() or kfree_rcu() in bpf subsystem.
> Other two uses of call_rcu_tasks_trace() are unchanged: for
> __bpf_prog_put_rcu() there is no gp chain and for
> __bpf_tramp_image_put_rcu_tasks() it chains RCU tasks trace GP and RCU
> tasks GP.
> 
> An alternative way to remove these unnecessary RCU grace period
> chainings is using the RCU polling API to check whether or not a normal
> RCU grace period has passed (e.g. get_state_synchronize_rcu()). But it
> needs an unsigned long space for each free element or each call, and
> it is not affordable for local storage element, so as for now always
> rcu_trace_implies_rcu_gp().
> 
> Comments are always welcome.

For #2-#4:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

(#1 already has my Signed-off-by, in case anyone was wondering.)

> Change Log:
> 
> v2:
>  * codify the implication of RCU Tasks Trace grace period instead of
>    assuming for it
> 
> v1: https://lore.kernel.org/bpf/20221011071128.3470622-1-houtao@huaweicloud.com
> 
> Hou Tao (3):
>   bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
>   bpf: Use rcu_trace_implies_rcu_gp() in local storage map
>   bpf: Use rcu_trace_implies_rcu_gp() for program array freeing
> 
> Paul E. McKenney (1):
>   rcu-tasks: Provide rcu_trace_implies_rcu_gp()
> 
>  include/linux/rcupdate.h       | 12 ++++++++++++
>  kernel/bpf/bpf_local_storage.c | 13 +++++++++++--
>  kernel/bpf/core.c              |  8 +++++++-
>  kernel/bpf/memalloc.c          | 15 ++++++++++-----
>  kernel/rcu/tasks.h             |  2 ++
>  5 files changed, 42 insertions(+), 8 deletions(-)
> 
> -- 
> 2.29.2
> 
