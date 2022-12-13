Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8764B3B7
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiLMLEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiLMLET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:04:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67F1928F;
        Tue, 13 Dec 2022 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fYOzy/gUcxxXzkKA87qx2IW3m1L2Q171uzRWvTbvKRU=; b=PiyD44bm27wPMzLX9FrSsGiflk
        gZ76ezkF0kLRfI+NreMZZPbcydxTWCC5GNewm3/LVzcDrO7jnUPFedVEBo8X9lmDPklsGtzY3Ohc8
        It8ZJBqmcfWbI0dr3ACQFJoAzEGxS18RXWfqiEm8rq2axizRiHeBeI3Ee/VEOyTCWXLRIbGQ5n9Wk
        ZSXz5PmAOqL1rYAZQ4XDRJ+Ku7GRsYdMDt/sZluW1Kilre5K0r7zTH5hrfDWPeHACX0RKZq/Htp3a
        Btdj1Fbg0lWhz8221Z4U64wqC7Ws4SrK8xyJvUcwjxOdM8JXvadFtw++LkB4i9O05bWEfeNd3fWA9
        CnFxTTRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p534s-00A3Ue-FF; Tue, 13 Dec 2022 11:04:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A49C3300465;
        Tue, 13 Dec 2022 11:57:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1BA820BC8BEB; Tue, 13 Dec 2022 11:57:12 +0100 (CET)
Date:   Tue, 13 Dec 2022 11:57:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y5haiM8qx1eOLjIr@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
 <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 11:33:12AM -1000, Tejun Heo wrote:

> > > @@ -5800,10 +5812,13 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> > >  	 * We can terminate the balance pass as soon as we know there is
> > >  	 * a runnable task of @class priority or higher.
> > >  	 */
> > > -	for_class_range(class, prev->sched_class, &idle_sched_class) {
> > > +	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
> > >  		if (class->balance(rq, prev, rf))
> > >  			break;
> > >  	}
> > > +#else
> > > +	/* SCX needs the balance call even in UP, call it explicitly */
> > 
> > This, *WHY* !?!
> 
> This comes from the fact that there are no strict rq boundaries and the BPF
> scheduler can share scheduling queues across any subset of CPUs however they
> see fit. So, task <-> rq association is flexible until the very last moment
> the task gets picked for execution. For the dispatch path to support this,
> it needs to be able to migrate tasks across rq's which requires unlocking
> the current rq which can only be done in ->balance(). So, sched_ext uses
> ->balance() to run the dispatch path and thus needs it called even on UP.

Fundamentally none of that makes sense, on UP there is no placement,
there is only the one CPU, very little choice to be had.

> Given that UP doesn't need to transfer tasks across, it might be possible to
> move the whole dispatch operation into ->pick_next_task() but the current
> state would be different, so it's more complicated and will likely be more
> brittle.

That sounds like something is amiss, you fundamentally hold all the
right locks, there is only one.
