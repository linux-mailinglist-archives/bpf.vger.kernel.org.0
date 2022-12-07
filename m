Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A627646419
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiLGW2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 17:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGW2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 17:28:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5E185652;
        Wed,  7 Dec 2022 14:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B9A961CCD;
        Wed,  7 Dec 2022 22:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB9AC433C1;
        Wed,  7 Dec 2022 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670452117;
        bh=rZzWKvvsu8qEpfjteSA5HZMcj3XTNXI0526/I2tBxz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DivAyv7hrTx6EJ3OFKXdvILw1yS0rSLCipgrIevQxwbBohXvO1GwdwiMLRuJ2VqBH
         cw51ddYchvPAzzkRhLR2b7iuihFfCMmTDsbv8AuvfIJWWw9c5q6vRpe/kR3vO3wNVl
         fDbfC71WBv+1K5Q6jCaU7HxY5ID+bF6/5D11mBvYExOf0/7VeCH+Xy2EwXfIpiqb9l
         TBZlvXBqT8wUGrinWL9BfUFaeA7OVWoZWu1xAg50gXrYQuS3NqycG+oY1LORr7H5yi
         iTJ6U6LiBUbb+7naTIHD6eNoHoadnWhu3/0jlfJfiGhzLioFcrb/bDsEEW7D4c9SUI
         hsUimiKIEOFFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 43FBA5C0952; Wed,  7 Dec 2022 14:28:37 -0800 (PST)
Date:   Wed, 7 Dec 2022 14:28:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
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
Message-ID: <20221207222837.GK4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-3-houtao@huaweicloud.com>
 <2eac2a50-40bd-3430-039f-58947d7c7af5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eac2a50-40bd-3430-039f-58947d7c7af5@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 10:24:55AM +0800, Hou Tao wrote:
> Forget to cc Paul and RCU maillist for more comments.
> 
> On 12/6/2022 12:29 PM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > If there are pending rcu callback, free_mem_alloc() will use
> > rcu_barrier_tasks_trace() and rcu_barrier() to wait for the pending
> > __free_rcu_tasks_trace() and __free_rcu() callback.
> >
> > If rcu_trace_implies_rcu_gp() is true, there will be no pending
> > __free_rcu(), so it will be OK to skip rcu_barrier() as well.

The bit about there being no pending __free_rcu() is guaranteed by
your algorithm, correct?  As in you have something like this somewhere
else in the code?

	if (!rcu_trace_implies_rcu_gp())
		call_rcu(...);

Or am I missing something more subtle?

							Thanx, Paul

> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  kernel/bpf/memalloc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 7daf147bc8f6..d43991fafc4f 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -464,9 +464,17 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
> >  {
> >  	/* waiting_for_gp lists was drained, but __free_rcu might
> >  	 * still execute. Wait for it now before we freeing percpu caches.
> > +	 *
> > +	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
> > +	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
> > +	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
> > +	 * so if call_rcu(head, __free_rcu) is skipped due to
> > +	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
> > +	 * using rcu_trace_implies_rcu_gp() as well.
> >  	 */
> >  	rcu_barrier_tasks_trace();
> > -	rcu_barrier();
> > +	if (!rcu_trace_implies_rcu_gp())
> > +		rcu_barrier();
> >  	free_mem_alloc_no_barrier(ma);
> >  }
> >  
> 
