Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406763F74D2
	for <lists+bpf@lfdr.de>; Wed, 25 Aug 2021 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhHYMLO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Aug 2021 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhHYMLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Aug 2021 08:11:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75392C061757;
        Wed, 25 Aug 2021 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8QAd+m0xXfOgmAHHNjQ6ok1qU8bS1qOWA/P3vU/O1ws=; b=VzWYxZTzWbuE97q7cLTQ5kB/Ox
        HI8EbLyKbcWCpaEZUbwrZ/Ukr+X9SFI5XsMeCfGe3ZTupkvXKa8c/Ig1k0FUpPWRMmdq+IOmP6Um5
        wlabmLfmjpCJ6PYPexvn+abWnq3U+kt5OZ/HxqGKJi8JN3YWMwHpl0/HxUZjDtGAQOlh+vtBkg2ho
        eZOh00zFu6FTeeQ0wYLZ87xKlhEYmmp/g7YHf2LiWodg4fwjsez0rLHgrGsbQ7CSonG/1S2afrJj+
        H8qVzUNgNAUZHhgnhgjWZUhidrjabbr8AHH0jTfhZ25SyGDGwvvsKIdzWfVarkrrk7xB8te3K2PPy
        J2tgIAxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIrid-00CH69-WD; Wed, 25 Aug 2021 12:09:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 832E4300252;
        Wed, 25 Aug 2021 14:09:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61004200E4A29; Wed, 25 Aug 2021 14:09:23 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:09:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YSYy87ta1GpXCCzk@hirez.programming.kicks-ass.net>
References: <20210824060157.3889139-1-songliubraving@fb.com>
 <20210824060157.3889139-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824060157.3889139-2-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 23, 2021 at 11:01:55PM -0700, Song Liu wrote:

>  arch/x86/events/intel/core.c |  5 ++++-
>  arch/x86/events/intel/lbr.c  | 12 ++++++++++++
>  arch/x86/events/perf_event.h |  2 ++
>  include/linux/perf_event.h   | 33 +++++++++++++++++++++++++++++++++
>  kernel/events/core.c         | 28 ++++++++++++++++++++++++++++
>  5 files changed, 79 insertions(+), 1 deletion(-)

No PowerPC support :/

> +void intel_pmu_snapshot_branch_stack(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	intel_pmu_lbr_disable_all();
> +	intel_pmu_lbr_read();
> +	memcpy(this_cpu_ptr(&perf_branch_snapshot_entries), cpuc->lbr_entries,
> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
> +	*this_cpu_ptr(&perf_branch_snapshot_size) = x86_pmu.lbr_nr;
> +	intel_pmu_lbr_enable_all(false);
> +}

Still has the layering violation and issues vs PMI.

> +#ifdef CONFIG_HAVE_STATIC_CALL
> +DECLARE_STATIC_CALL(perf_snapshot_branch_stack,
> +		    perf_default_snapshot_branch_stack);
> +#else
> +extern void (*perf_snapshot_branch_stack)(void);
> +#endif

That's weird, static call should work unconditionally, and fall back to
a regular function pointer exactly like you do here. Search for:
"Generic Implementation" in include/linux/static_call.h

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 011cc5069b7ba..b42cc20451709 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

> +#ifdef CONFIG_HAVE_STATIC_CALL
> +DEFINE_STATIC_CALL(perf_snapshot_branch_stack,
> +		   perf_default_snapshot_branch_stack);
> +#else
> +void (*perf_snapshot_branch_stack)(void) = perf_default_snapshot_branch_stack;
> +#endif

Idem.

Something like:

DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack, void (*)(void));

with usage like: static_call_cond(perf_snapshot_branch_stack)();

Should unconditionally work.

> +int perf_read_branch_snapshot(void *buf, size_t len)
> +{
> +	int cnt;
> +
> +	memcpy(buf, *this_cpu_ptr(&perf_branch_snapshot_entries),
> +	       min_t(u32, (u32)len,
> +		     sizeof(struct perf_branch_entry) * MAX_BRANCH_SNAPSHOT));
> +	cnt =  *this_cpu_ptr(&perf_branch_snapshot_size);
> +
> +	return (cnt > 0) ? cnt : -EOPNOTSUPP;
> +}

Doesn't seem used at all..

