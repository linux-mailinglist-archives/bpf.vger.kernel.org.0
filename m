Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AB400ACC
	for <lists+bpf@lfdr.de>; Sat,  4 Sep 2021 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhIDKUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Sep 2021 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhIDKUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Sep 2021 06:20:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C9C061575;
        Sat,  4 Sep 2021 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5R7GYZx+aBiCE582nXkLQEdaHmoBPPfbt7yTR5oZBE=; b=JjKzpp7aDuZbtXkDdUq/VeGCde
        DsyFTO9TrKCHJ/TchCVMYyQSOc7W6Me2+EOr1yEaWaDtWf8Dm8B2frXhToYjBKhsdDOIP0joSECaG
        aRz/iSu3Guu+Cy5R/HMHoS2eYFMP05BER5mw2PtaiR/JmgCwkX5EWhoxFdiqH4oezF30okywUmS1k
        HSDWX3jXJgUPJFzQvNdlqD/R2tHdF/v4VWUb8AgKf3XhELsCnaHctUQV++jxQ6n/KzPvFJLP4pW5l
        Gjc+SgoKYpy1WOu4MjCQ+hIGH/nsZSlt4rdUFhjw9WJU2NAF4nY4V0VHMr30rMcUzsVBZyFzrBUNj
        eRc0oPiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMSks-005EM9-Hw; Sat, 04 Sep 2021 10:18:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BFE5986283; Sat,  4 Sep 2021 12:18:34 +0200 (CEST)
Date:   Sat, 4 Sep 2021 12:18:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <20210904101834.GC4323@worktop.programming.kicks-ass.net>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com>
 <YTHcXDhYDFsw9GQX@hirez.programming.kicks-ass.net>
 <6BA620C1-D311-4992-8119-68A740ABA8BC@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6BA620C1-D311-4992-8119-68A740ABA8BC@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 03, 2021 at 04:45:29PM +0000, Song Liu wrote:
> Hi Peter,
> 
> > On Sep 3, 2021, at 1:27 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Thu, Sep 02, 2021 at 09:57:04AM -0700, Song Liu wrote:
> > 
> >> +static int
> >> +intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> >> +{
> >> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> >> +
> >> +	intel_pmu_disable_all();
> >> +	intel_pmu_lbr_read();
> >> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> >> +
> >> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> >> +	intel_pmu_enable_all(0);
> >> +	return cnt;
> >> +}
> > 
> > Given this disables the PMI from 'random' contexts, should we not add
> > IRQ disabling around this to avoid really bad behaviour?
> 
> Do you mean we should add (instead of not add) IRQ disable?

Yeah, I tihnk we want local_irq_save()/restore() here.
