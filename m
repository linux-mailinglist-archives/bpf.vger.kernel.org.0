Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB0649EAA
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 13:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiLLMbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 07:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLLMbm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 07:31:42 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096CFF025;
        Mon, 12 Dec 2022 04:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f8oYEiclleUA/iIHGMwb4It2oiQV5nIwj7vFi55H19M=; b=aumS+oIizYg8zjnzoAAFLwNZUq
        ZfcBHIZUzxcaTcC2K3dZSYi/Rhd9ACFz+cE/X0etkbUbYN1B4IshMsxgjS0AuiYNPO03UEFUzA7xQ
        xbRHeQwk8g8DtYB8e73KlLGMOxgZXqA6wMVURMOusNEFrStNGf0bKJU+ZuD8sP9dzkNwqGjZNXzV6
        qWrruERj2WuZZ1AHPeWer8FZDRl1f0ecoxF1n7ZOEtqFA6SLR7FQN4nquVs6JNhlEi/WnSG2CKE1B
        5amol+vFDUrKUh5dgu45XRCyzl76+e2X2msERF4NGoJ7ZiWnfg0reOQVSl8PLEw+jbwIGbvAi2CY/
        bVVxRlkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4hxi-009m7S-BD; Mon, 12 Dec 2022 12:31:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AD9B300462;
        Mon, 12 Dec 2022 13:31:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D221E20248CFF; Mon, 12 Dec 2022 13:31:11 +0100 (CET)
Date:   Mon, 12 Dec 2022 13:31:11 +0100
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
Message-ID: <Y5cfD137arVsOdj7@hirez.programming.kicks-ass.net>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-15-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:22:56PM -1000, Tejun Heo wrote:
> @@ -11242,3 +11268,38 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
>  {
>          trace_sched_update_nr_running_tp(rq, count);
>  }
> +
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
> +			    struct sched_enq_and_set_ctx *ctx)
> +{
> +	struct rq *rq = task_rq(p);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	*ctx = (struct sched_enq_and_set_ctx){
> +		.p = p,
> +		.queue_flags = queue_flags | DEQUEUE_NOCLOCK,
> +		.queued = task_on_rq_queued(p),
> +		.running = task_current(rq, p),
> +	};
> +
> +	update_rq_clock(rq);
> +	if (ctx->queued)
> +		dequeue_task(rq, p, queue_flags);
> +	if (ctx->running)
> +		put_prev_task(rq, p);
> +}
> +
> +void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
> +{
> +	struct rq *rq = task_rq(ctx->p);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (ctx->queued)
> +		enqueue_task(rq, ctx->p, ctx->queue_flags);
> +	if (ctx->running)
> +		set_next_task(rq, ctx->p);
> +}
> +#endif	/* CONFIG_SCHED_CLASS_EXT */

So no. Like the whole __setscheduler_prio() thing, this doesn't make
sense outside of the core code, policy/class code should never need to
do this.

Also: https://lkml.kernel.org/r/20220330162228.GH14330@worktop.programming.kicks-ass.net
