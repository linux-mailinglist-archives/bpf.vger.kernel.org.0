Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC23FCAC0
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhHaP0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhHaP0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 11:26:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA0C061575;
        Tue, 31 Aug 2021 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uwTrTbDOHkMVsLsXLuJcKBuRojYiovx3RxkvNr4JkMg=; b=kjxY+506AsKcbc56c4Db88UNyP
        mAffMHWYJi+LpHja+OyORAKzOUK8ha4Ey/H1HwPXBL8ggcP/zW7hPehvqLPWBbe4JEThAkkD3k5pP
        WF03Z3VvU9ldXavXGUkqVVoejtZ4dlvP0jhhm7oyRhZ7y9lU3M660mGs2tZXRA5f/5mrlKjdmBdB4
        bCPpZMbFYQqrCdoB3EdZ5ba1O1ZU9NOvazzaQQ/tdEKjoCukrYzzoKQDMMfge8hOweqYuGbqWwx3U
        lwQXQlnEHDaXqxUUj/MVblTNbkyFXn97hnhMtwWdHDGNQAnet4r4ydnCEQdGEd52Tj9Tr9RoZYXgA
        mwSHerJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL5cm-001KP4-UO; Tue, 31 Aug 2021 15:24:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFB1E300109;
        Tue, 31 Aug 2021 17:24:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FE1820AEBF37; Tue, 31 Aug 2021 17:24:26 +0200 (CEST)
Date:   Tue, 31 Aug 2021 17:24:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YS5Jqr60qHZ14+2g@hirez.programming.kicks-ass.net>
References: <20210830214106.4142056-1-songliubraving@fb.com>
 <20210830214106.4142056-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830214106.4142056-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 02:41:04PM -0700, Song Liu wrote:

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index ac6fd2dabf6a2..d28d0e12c112c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2155,9 +2155,9 @@ static void __intel_pmu_disable_all(void)
>  
>  static void intel_pmu_disable_all(void)
>  {
> +	intel_pmu_lbr_disable_all();
>  	__intel_pmu_disable_all();
>  	intel_pmu_pebs_disable_all();
> -	intel_pmu_lbr_disable_all();
>  }

Hurmph... I'm not sure about that, I'd rather you sprinkle a few
__always_inline to ensure no actual function is called while you disable
things in the correct order.

You now still have a hole vs PMI.

> +static int
> +intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);

Note that this requires preemption is disabled, then look at the
call-sites in your next patch and spot the problem...

> +
> +	intel_pmu_disable_all();
> +	intel_pmu_lbr_read();
> +	memcpy(br_snapshot->entries, cpuc->lbr_entries,
> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
> +	br_snapshot->nr = x86_pmu.lbr_nr;
> +	intel_pmu_enable_all(0);
> +	return 0;
> +}
> +
>  /*
>   * Workaround for:
>   *   Intel Errata AAK100 (model 26)
> @@ -6283,9 +6297,15 @@ __init int intel_pmu_init(void)
>  			x86_pmu.lbr_nr = 0;
>  	}
>  
> -	if (x86_pmu.lbr_nr)
> +	if (x86_pmu.lbr_nr) {
>  		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
>  
> +		/* only support branch_stack snapshot for perfmon >= v2 */
> +		if (x86_pmu.disable_all == intel_pmu_disable_all)
								  {
> +			static_call_update(perf_snapshot_branch_stack,
> +					   intel_pmu_snapshot_branch_stack);

		}

> +	}
> +
>  	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
>  
>  	/* Support full width counters using alternative MSR range */

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 011cc5069b7ba..22807864e913b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13437,3 +13437,6 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
>  	.threaded	= true,
>  };
>  #endif /* CONFIG_CGROUP_PERF */
> +
> +DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack,
> +			perf_snapshot_branch_stack_t);

I'll squint and accept 82 characters :-)
