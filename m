Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDE649F27
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 13:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiLLMyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 07:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiLLMyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 07:54:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848411C3A;
        Mon, 12 Dec 2022 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NrJN3HB6BI8k1eR97eek+yZFQ38Fc65bnwKa0BSmECU=; b=BU9W4je0TLGA/InMMAsdjDiNgj
        bJO+HpizPTenwbqPE/qPWiD4tpv/QKQNsfhd8LoE+MmoiHktSB3kX+uEPMZz/im5hJMRenvtTMRDp
        K3QckLi4Ztzug4rYwdQjVB1cu0nEfEjyZxW2HDrDkTlVzFt57D+JqrZm7Xqq+pIg2SFQVUzKjTXq6
        qv4g5w80TxZnZSdlNnJnWgNqKPcBW2Jfp5VVhOJFtgAJFU/gn7psO1QsQwMlU2xs8PxgdJb5zOIGy
        ny8030yitpq5PT6T5222lOanVkQPT5O+C4oxQtyPRt+rHcUVry2a08fMinCPh0mFTWFV4ZrLlOCaI
        YYugyY2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4iJp-00B3ES-QC; Mon, 12 Dec 2022 12:54:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 235AD300299;
        Mon, 12 Dec 2022 13:53:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 024FA200FB979; Mon, 12 Dec 2022 13:53:55 +0100 (CET)
Date:   Mon, 12 Dec 2022 13:53:55 +0100
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
Message-ID: <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
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

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d06ada2341cb..cfbfc47692eb 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -131,6 +131,7 @@
>  	*(__dl_sched_class)			\
>  	*(__rt_sched_class)			\
>  	*(__fair_sched_class)			\
> +	*(__ext_sched_class)			\
>  	*(__idle_sched_class)			\
>  	__sched_class_lowest = .;
>  

> @@ -9654,8 +9675,13 @@ void __init sched_init(void)
>  	int i;
>  
>  	/* Make sure the linker didn't screw up */
> -	BUG_ON(&idle_sched_class != &fair_sched_class + 1 ||
> -	       &fair_sched_class != &rt_sched_class + 1 ||
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	BUG_ON(&idle_sched_class != &ext_sched_class + 1 ||
> +	       &ext_sched_class != &fair_sched_class + 1);
> +#else
> +	BUG_ON(&idle_sched_class != &fair_sched_class + 1);
> +#endif
> +	BUG_ON(&fair_sched_class != &rt_sched_class + 1 ||
>  	       &rt_sched_class   != &dl_sched_class + 1);
>  #ifdef CONFIG_SMP
>  	BUG_ON(&dl_sched_class != &stop_sched_class + 1);

Perhaps the saner way to write this is:

#ifdef CONFIG_SMP
	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));
#endif
	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
#ifdef CONFIG_...
	BUG_ON(!sched_class_above(&fair_sched_class, &ext_sched_class));
	BUG_ON(!sched_class_above(&ext_sched_class, &idle_sched_class));
#endif

> +static inline const struct sched_class *next_active_class(const struct sched_class *class)
> +{
> +	class++;
> +	if (!scx_enabled() && class == &ext_sched_class)
> +		class++;
> +	return class;
> +}
> +
> +#define for_active_class_range(class, _from, _to)				\
> +	for (class = (_from); class != (_to); class = next_active_class(class))
> +
> +#define for_each_active_class(class)						\
> +	for_active_class_range(class, __sched_class_highest, __sched_class_lowest)
> +
> +/*
> + * SCX requires a balance() call before every pick_next_task() call including
> + * when waking up from idle.
> + */
> +#define for_balance_class_range(class, prev_class, end_class)			\
> +	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
> +			       &ext_sched_class : (prev_class), (end_class))
> +

This seems quite insane; why not simply make the ext methods effective
no-ops? Both balance and pick explicitly support that already, no?

> @@ -5800,10 +5812,13 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>  	 * We can terminate the balance pass as soon as we know there is
>  	 * a runnable task of @class priority or higher.
>  	 */
> -	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
>  		if (class->balance(rq, prev, rf))
>  			break;
>  	}
> +#else
> +	/* SCX needs the balance call even in UP, call it explicitly */

This, *WHY* !?!

> +	balance_scx_on_up(rq, prev, rf);
>  #endif
>  
>  	put_prev_task(rq, prev);
> @@ -5818,6 +5833,9 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	const struct sched_class *class;
>  	struct task_struct *p;
>  
> +	if (scx_enabled())
> +		goto restart;
> +
>  	/*
>  	 * Optimization: we know that if all tasks are in the fair class we can
>  	 * call that function directly, but only if the @prev task wasn't of a
> @@ -5843,7 +5861,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  restart:
>  	put_prev_task_balance(rq, prev, rf);
>  
> -	for_each_class(class) {
> +	for_each_active_class(class) {
>  		p = class->pick_next_task(rq);
>  		if (p)
>  			return p;
> @@ -5876,7 +5894,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
>  	const struct sched_class *class;
>  	struct task_struct *p;
>  
> -	for_each_class(class) {
> +	for_each_active_class(class) {
>  		p = class->pick_task(rq);
>  		if (p)
>  			return p;


But this.. afaict that means that:

 - the whole EXT thing is incompatible with SCHED_CORE
 - the whole EXT thing can be trivially starved by the presence of a
   single CFS/BATCH/IDLE task.

Both seems like deal breakers.
