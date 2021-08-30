Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CC3FB405
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 12:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhH3Kpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbhH3Kpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73124C0617AD;
        Mon, 30 Aug 2021 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aiU9aRtlntDrYtI69EeFKT48DQZRScU3KZPsIUVSnwk=; b=uvKOZ0v9Fu903Hkqfj62B+bDLz
        MUrzfD6kOeElWC1NecA9k2aXXQ9UAsGYRv/i5JUloDGGGju7nKNDICQ6SuOgIEK/O1huWJP3rFA7k
        nWaiQdARmln7EZpTNA66MBFPNW5VnViZhqS0VE/96rza8dm+3NGYWqr+/hcVVUvKKHoB1yfujMeWv
        VtwxD4cwi8kXpb92tYtSFIZ05PFfB9/gMKkHyyxLabrjJ0L99oZFPdf/5RQO2mhMVTjegDTeNx2AJ
        dNsPMQzCtjSIRpPXaF/WDLYNdFDtp47dSy/vKoEcL0BpELJcPP95L0UIt3fMf2f6JpHw8WG8Nc9pa
        dEqoOZtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKelK-0001oe-Hy; Mon, 30 Aug 2021 10:43:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22F7C98186D; Mon, 30 Aug 2021 12:43:34 +0200 (CEST)
Date:   Mon, 30 Aug 2021 12:43:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <20210830104334.GJ4353@worktop.programming.kicks-ass.net>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826221306.2280066-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 03:13:04PM -0700, Song Liu wrote:

> Some data on intel_pmu_lbr_disable_all() and perf_pmu_disable().
> 
> With this patch, when fexit program triggers, intel_pmu_lbr_disable_all is
> used to stop the LBR, and the LBR is stopped after 6 extra branch records
> (see the full trace below). If we replace intel_pmu_lbr_disable_all in
> intel_pmu_snapshot_branch_stack() with perf_pmu_disable, the LBR is stopped
> after 19 extra branch records. This is still acceptable for systems with 32
> LBR entries. But for systems with fewer entries, all the entries before
> fexit are flushed. Therefore, I suggest we take the short cut and stop LBR
> asap.
> 
> 
> LBR snapshot captured when we use intel_pmu_lbr_disable_all():
> 
> ID: 0 from intel_pmu_lbr_disable_all.part.10+37 to intel_pmu_lbr_disable_all.part.10+72
> ID: 1 from intel_pmu_lbr_disable_all.part.10+33 to intel_pmu_lbr_disable_all.part.10+37
> ID: 2 from intel_pmu_snapshot_branch_stack+51 to intel_pmu_lbr_disable_all.part.10+0
> ID: 3 from __bpf_prog_enter+53 to intel_pmu_snapshot_branch_stack+0
> ID: 4 from __bpf_prog_enter+8 to __bpf_prog_enter+38
> ID: 5 from __brk_limit+473903158 to __bpf_prog_enter+0
> ID: 6 from bpf_fexit_loop_test1+22 to __brk_limit+473903139
> ID: 7 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> ID: 8 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> ID: 9 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> 
> 
> LBR snapshot captured when we use perf_pmu_disable():
> 
> ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
> ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
> ID: 2 from intel_pmu_disable_all+15 to intel_pmu_lbr_disable_all+0
> ID: 3 from intel_pmu_pebs_disable_all+30 to intel_pmu_disable_all+15
> ID: 4 from intel_pmu_disable_all+10 to intel_pmu_pebs_disable_all+0
> ID: 5 from __intel_pmu_disable_all+49 to intel_pmu_disable_all+10
> ID: 6 from intel_pmu_disable_all+5 to __intel_pmu_disable_all+0
> ID: 7 from x86_pmu_disable+61 to intel_pmu_disable_all+0
> ID: 8 from x86_pmu_disable+38 to x86_pmu_disable+41
> ID: 9 from __x86_indirect_thunk_rax+16 to x86_pmu_disable+0
> ID: 10 from __x86_indirect_thunk_rax+0 to __x86_indirect_thunk_rax+12
> ID: 11 from perf_pmu_disable.part.122+4 to __x86_indirect_thunk_rax+0
> ID: 12 from perf_pmu_disable+23 to perf_pmu_disable.part.122+0
> ID: 13 from intel_pmu_snapshot_branch_stack+45 to perf_pmu_disable+0
> ID: 14 from x86_get_pmu+35 to intel_pmu_snapshot_branch_stack+39
> ID: 15 from intel_pmu_snapshot_branch_stack+34 to x86_get_pmu+0
> ID: 16 from __bpf_prog_enter+53 to intel_pmu_snapshot_branch_stack+0
> ID: 17 from __bpf_prog_enter+8 to __bpf_prog_enter+38
> ID: 18 from __brk_limit+478056502 to __bpf_prog_enter+0
> ID: 19 from bpf_fexit_loop_test1+22 to __brk_limit+478056483
> ID: 20 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> ID: 21 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13

Well, if you're willing to do something like:

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index ac6fd2dabf6a2..a29649e7241cc 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6283,8 +6283,11 @@ __init int intel_pmu_init(void)
>  			x86_pmu.lbr_nr = 0;
>  	}
> 
> -	if (x86_pmu.lbr_nr)
> +	if (x86_pmu.lbr_nr) {
>  		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);

		if (x86_pmu.disable_all == intel_pmu_disable_all)

> +		static_call_update(perf_snapshot_branch_stack,
> +				   intel_pmu_snapshot_branch_stack);
> +	}
> 
>  	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 9e6d6eaeb4cb6..7d4fe1d6e79ff 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1862,3 +1862,16 @@ EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
>  struct event_constraint vlbr_constraint =
>  	__EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT, (1ULL << INTEL_PMC_IDX_FIXED_VLBR),
>  			  FIXED_EVENT_FLAGS, 1, 0, PERF_X86_EVENT_LBR_SELECT);
> +
> +int intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	intel_pmu_lbr_disable_all();
> +	intel_pmu_lbr_read();
> +	memcpy(br_snapshot->entries, cpuc->lbr_entries,
> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
> +	br_snapshot->nr = x86_pmu.lbr_nr;
> +	intel_pmu_lbr_enable_all(false);
> +	return 0;
> +}

Then the above can assume perfmon > v2 and we can either inline
__intel_pmu_disable_all() or simply do the
wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL).

One thing that needs checking, intel_pmu_disable_all() also clears
MSR_IA32_PEBS_ENABLE, is that really needed if we just want to inhibit
PMIs ? That is, will the PEBS machinery still trigger PMI if GLOBAL_CTRL
== 0 ?

