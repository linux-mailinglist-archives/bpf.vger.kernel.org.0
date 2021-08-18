Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7E3F002A
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhHRJRK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhHRJRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Aug 2021 05:17:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39B9C061764;
        Wed, 18 Aug 2021 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BA4/xVLnaIPuATSnRGf49DCaYMo1+WItwkXiR/2kQnw=; b=IErH/qBGGW6WOy8h0UdsdyzTJ/
        KeDPtm007TIrgcS+9evjB+U+bYrdszrYhYll4O5sved0cQK6uQy8yiL8IP6VbF4jODyXcouUCW981
        hzBsNCf8Z7DJ1v46Nc1Mb2wdqYTNgv3QBALB7RYr9VKkyoLonvi1RM8zHMrgCbo6kwRtTCoVZCjlG
        /OAq9mktI6iecU7qVQbKZP3lEccE5DzM1In160sbEsYa1BnEm/vnJfNWcYfD7m0epk7NIA3uzIWK/
        EEaqoVfQTL8LuTRQd3EINpHSP5A99QGVGY+zZmZwzqtUUbzNb48tGRz4CPKxutg00/ibXEq9KqmFn
        N+mMK2MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGHfm-003dFm-E3; Wed, 18 Aug 2021 09:15:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2169D30009A;
        Wed, 18 Aug 2021 11:15:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 030E52027CE08; Wed, 18 Aug 2021 11:15:44 +0200 (CEST)
Date:   Wed, 18 Aug 2021 11:15:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kernel-team@fb.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Like Xu <like.xu@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Message-ID: <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
References: <20210818012937.2522409-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818012937.2522409-1-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 17, 2021 at 06:29:37PM -0700, Song Liu wrote:
> The typical way to access LBR is via hardware perf_event. For CPUs with
> FREEZE_LBRS_ON_PMI support, PMI could capture reliable LBR. On the other
> hand, LBR could also be useful in non-PMI scenario. For example, in
> kretprobe or bpf fexit program, LBR could provide a lot of information
> on what happened with the function.
> 
> In this RFC, we try to enable LBR for BPF program. This works like:
>   1. Create a hardware perf_event with PERF_SAMPLE_BRANCH_* on each CPU;
>   2. Call a new bpf helper (bpf_get_branch_trace) from the BPF program;
>   3. Before calling this bpf program, the kernel stops LBR on local CPU,
>      make a copy of LBR, and resumes LBR;
>   4. In the bpf program, the helper access the copy from #3.
> 
> Please see tools/testing/selftests/bpf/[progs|prog_tests]/get_call_trace.c
> for a detailed example. Not that, this process is far from ideal, but it
> allows quick prototype of this feature.
> 
> AFAICT, the biggest challenge here is that we are now sharing LBR in PMI
> and out of PMI, which could trigger some interesting race conditions.
> However, if we allow some level of missed/corrupted samples, this should
> still be very useful.
> 
> Please share your thoughts and comments on this. Thanks in advance!

> +int bpf_branch_record_read(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	intel_pmu_lbr_disable_all();
> +	intel_pmu_lbr_read();
> +	memcpy(this_cpu_ptr(&bpf_lbr_entries), cpuc->lbr_entries,
> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
> +	*this_cpu_ptr(&bpf_lbr_cnt) = x86_pmu.lbr_nr;
> +	intel_pmu_lbr_enable_all(false);
> +	return 0;
> +}

Urgghhh.. I so really hate BPF specials like this. Also, the PMI race
you describe is because you're doing abysmal layer violations. If you'd
have used perf_pmu_disable() that wouldn't have been a problem.

I'd much rather see a generic 'fake/inject' PMI facility, something that
works across the board and isn't tied to x86/intel.
