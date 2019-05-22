Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99252655A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfEVOCq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 10:02:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVOCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 10:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pjByW6gfyq8J56QOG3nVPteOmnGd+8AJq7yqIOVeIW8=; b=jSylTx+dtDY27R/9zyAtnQuGd
        2rpFdeiKeEUBOzSWnEjTXU0kWkDxxNhIio5aLeWAuTfZKggElDBRI1vEdPT6/ulUMBMWhoTvQY21G
        qTESaXQyXEz9+onCPfz5Z9FYfK1MK5Y4SFc80kIeNP7YZC8moG9tw52NJJjl1jrvdX2i7RCV9OxQc
        5ORLh13jaUCyCY5jdNCafQsoliiz7+zQT4yTExBCf0F+mLlKvQNwHI9jjOK4bz1M/Ph1zgJkNG6zU
        kcCifdfk7O91hPfKIvTmS+QQzwhjXgkaNqFXpyHPa4DiY2/v7RwlA4JW72IkJCwAnVYc2FLx7vp1z
        PGdr2DTig==;
Received: from [31.161.185.207] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTRpA-0005gp-DD; Wed, 22 May 2019 14:02:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9462984E09; Wed, 22 May 2019 16:02:33 +0200 (CEST)
Date:   Wed, 22 May 2019 16:02:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190522140233.GC16275@worktop.programming.kicks-ass.net>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 20, 2019 at 02:06:54AM +0800, Kairui Song wrote:
> On Fri, May 17, 2019 at 5:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
> > > Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
> > > some other bfp functions) is now broken, or, strating an unwind
> > > directly inside a bpf program will end up strangely. It have following
> > > kernel message:
> >
> > Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
> > follow.
> 
> bpf_get_stackid_tp will just use the regs passed to it from the trace
> point. And then it will eventually call perf_get_callchain to get the
> call chain.
> With a tracepoint we have the fake regs, so unwinder will start from
> where it is called, and use the fake regs as the indicator of the
> target frame it want, and keep unwinding until reached the actually
> callsite.
> 
> But if the stack trace is started withing a bpf func call then it's broken...

I'm confused.. how is this broken? Surely we should eventually find the
original stack frame and be good again, right?

> If the unwinder could trace back through the bpf func call then there
> will be no such problem.

Why couldn't it trace back through the bpf stuff? And how can we fix
that?
