Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A139D3F18A8
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbhHSL7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 07:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhHSL7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 07:59:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE752C061575;
        Thu, 19 Aug 2021 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pRsyB7CLFbiWCWtNNYvYvOJlpHqB369aROjMV8RfXbw=; b=l1jlu5EZgp4GKpzmGDKmEB0EtK
        MwnbW+CyIasQrjBGnjBcznPAJxhjt/pXw12scouBOjLv1yoEasR1e1RiPa2iMASkwtlXtPbOMzlCl
        LcGDSvsFwITjpTG+4Xqb8ITrucsbriI5YVokZRbQ3V55H9je1X8QKriJXSdLaVuuNL8fTmxhEtZSL
        LUyJvzPJWlFsAbINmlNwQRHQZKhd4mHOVVUj6E3ocPPYQFHSBa0LSWBLoNLtTG3wzmPwL5zyrJQ8X
        ggnBGqDdNDEAdJivkqlAD/6HnygHMXbCKvr6Cr6NsbNTSxNRtipAWP5YMEntJArpo9/jm0z6AIjN7
        zrAaq6dA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGgfo-0052Yn-C2; Thu, 19 Aug 2021 11:57:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDAB830009A;
        Thu, 19 Aug 2021 13:57:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D22C1200B42A0; Thu, 19 Aug 2021 13:57:26 +0200 (CEST)
Date:   Thu, 19 Aug 2021 13:57:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Like Xu <like.xu@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Message-ID: <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
 <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 18, 2021 at 04:46:32PM +0000, Song Liu wrote:

> > Urgghhh.. I so really hate BPF specials like this.
> 
> I don't really like this design either. But it does show that LBR can be
> very useful in non-PMI scenario. 
> 
> > Also, the PMI race
> > you describe is because you're doing abysmal layer violations. If you'd
> > have used perf_pmu_disable() that wouldn't have been a problem.
> 
> Do you mean instead of disable/enable lbr, we disable/enable the whole 
> pmu? 

Yep, that way you're serialized against PMIs. It's what all of the perf
core does.

> > I'd much rather see a generic 'fake/inject' PMI facility, something that
> > works across the board and isn't tied to x86/intel.
> 
> How would that work? Do we have a function to trigger PMI from software, 
> and then gather the LBR data after the PMI? This does sound like a much
> cleaner solution. Where can I find code examples that fake/inject PMI?

We don't yet have anything like it; but it would look a little like:

void perf_inject_event(struct perf_event *event, struct pt_regs *regs)
{
	struct perf_sample_data data;
	struct pmu *pmu = event->pmu;
	unsigned long flags;

	local_irq_save(flags);
	perf_pmu_disable(pmu);

	perf_sample_data_init(&data, 0, 0);
	/*
	 * XXX or a variant with more _ that starts at the overflow
	 * handler...
	 */
	__perf_event_overflow(event, 0, &data, regs);

	perf_pmu_enable(pmu);
	local_irq_restore(flags);
}

But please consider carefully, I haven't...

> There is another limitation right now: we need to enable LBR with a 
> hardware perf event (cycles, etc.). However, unless we use the event for 
> something else, it wastes a hardware counter. So I was thinking to allow
> software event, i.e. dummy event, to enable LBR. Does this idea sound 
> sane to you?

We have a VLBR dummy event, but I'm not sure it does exactly as you
want. However, we should also consider Power, which also has the branch
stack feature.

You can't really make a software event with LBR on, because then it
wouldn't be a software event anymore. You'll need some hybrid like
thing, which will be yuck and I suspect it needs arch support one way or
the other :/
