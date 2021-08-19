Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA873F1F87
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhHSSH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSSH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 14:07:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4B7C061575;
        Thu, 19 Aug 2021 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e2iRoCi+KN0OZNzh2nCq9xKtiscXhPTXxaEW3b7If+U=; b=E31ZYKb7eSR1MUwRGRSd1UKplh
        NbpE94z9KKfukD4po7Rcm8QQQ+IJLPrG8M5OY0NNxRVSH1w0SJ3QKW+5aeAY0upxlMX4nU9ofuzId
        Gr3qONxtxHg0cC4ntA4eOYoz41ktMS2dCfyyR4UYwg6lJ1ah1jLd1B2ThnumytXSivt1hV6LmLbhi
        KCfp0rcZMX6RzWHzf9T/zmFOI++wqMlwUtwzsCdgJHgeyVn3hCty6L7fANyjd4kdETBksBsq66jgR
        g5jBk2KVI5cS21beMGc+nVf4xswUf5J0pNMOLByVNhGglGP0o3S9CWWpG7fkC6dIHKeyrdu3LaePx
        mrTu71rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGmR5-00BAbi-L5; Thu, 19 Aug 2021 18:06:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94F0E3004B2;
        Thu, 19 Aug 2021 20:06:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F90D2CDCAC1A; Thu, 19 Aug 2021 20:06:37 +0200 (CEST)
Date:   Thu, 19 Aug 2021 20:06:37 +0200
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
Message-ID: <YR6dreGQSe4oQFBr@hirez.programming.kicks-ass.net>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
 <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
 <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
 <AB509D87-67C6-4B7F-AEFB-2324845C310C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB509D87-67C6-4B7F-AEFB-2324845C310C@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 19, 2021 at 04:46:20PM +0000, Song Liu wrote:
> > void perf_inject_event(struct perf_event *event, struct pt_regs *regs)
> > {
> > 	struct perf_sample_data data;
> > 	struct pmu *pmu = event->pmu;
> > 	unsigned long flags;
> > 
> > 	local_irq_save(flags);
> > 	perf_pmu_disable(pmu);
> > 
> > 	perf_sample_data_init(&data, 0, 0);
> > 	/*
> > 	 * XXX or a variant with more _ that starts at the overflow
> > 	 * handler...
> > 	 */
> > 	__perf_event_overflow(event, 0, &data, regs);
> > 
> > 	perf_pmu_enable(pmu);
> > 	local_irq_restore(flags);
> > }
> > 
> > But please consider carefully, I haven't...
> 
> Hmm... This is a little weird to me. 
> IIUC, we need to call perf_inject_event() after the software event, say
> a kretprobe, triggers. So it gonna look like:
> 
>   1. kretprobe trigger;
>   2. handler calls perf_inject_event();
>   3. PMI kicks in, and saves LBR;

This doesn't actually happen. I overlooked the fact that we need the PMI
to fill out @data for us.

>   4. after the PMI, consumer of LBR uses the saved data;

Normal overflow handler will have data->br_stack set, but I now realize
that the 'psuedo' code above will not get that. We need to somehow get
the arch bits involved; again :/

> However, given perf_inject_event() disables PMU, we can just save the LBR
> right there? And it should be a lot easier? Something like:
> 
>   1. kretprobe triggers;
>   2. handler calls perf_snapshot_lbr();
>      2.1 perf_pmu_disable(pmu);
>      2.2 saves LBR 
>      2.3 perf_pmu_enable(pmu);
>   3. consumer of LBR uses the saved data;
> 
> What is the downside of this approach? 

It would be perf_snapshot_branch_stack() and would require a new
(optional) pmu::method to set up the branch stack.

And if we're going to be adding new pmu::methods then I figure one that
does the whole sample state might be more useful.
