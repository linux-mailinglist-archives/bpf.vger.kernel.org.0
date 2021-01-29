Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6861E308A46
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 17:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhA2Qdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 11:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhA2Qbc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 11:31:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB1C0613D6;
        Fri, 29 Jan 2021 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yiqFfxPWjaBBtMQaM+MAoojFayOhd4kIg0RTmjiEmOo=; b=ojhbcyf9SCPvTLZTogs2KrgZ7S
        ZLPgcka/xchmQCpmMifqdDSJvVJBIYZqv1tVP1hGLOgXDG3yyTHsHUyk7sHcy6UVHTHomiQkRkdHi
        afcJH9vFuryu+jA+bv8n2Uge/Qf07cY/y052xTeFy4dVGac7ipDIiuE+N2R1j7455nvr0Ou/WC6jk
        MHL/HtK7hiYIow7RkUyHFE1hdSEj6Txqg+9pmpWjNI434Iu+PD+2BETXTIrH5QHKurF9GW+sbtXm2
        fcmNyfcnsOvPheKRb1o5nxILO5yksWW8IWKXwXUpJpl8b9jAvF+7gQ5KPSCIMF6OhGtj0NbvTdIrm
        lOCspA4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l5WZc-00A14C-Bi; Fri, 29 Jan 2021 16:24:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7521981070; Fri, 29 Jan 2021 17:24:38 +0100 (CET)
Date:   Fri, 29 Jan 2021 17:24:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210129162438.GC8912@worktop.programming.kicks-ass.net>
References: <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
 <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
 <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
 <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
 <20210129105952.74dc8464@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129105952.74dc8464@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 10:59:52AM -0500, Steven Rostedt wrote:
> On Fri, 29 Jan 2021 22:40:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > So what, they can all happen with random locks held. Marking them as NMI
> > > enables a whole bunch of sanity checks that are entirely appropriate.  
> > 
> > How about introducing an idea of Asynchronous NMI (ANMI) and Synchronous
> > NMI (SNMI)? kprobes and ftrace is synchronously called and can be controlled
> > (we can expect the context) but ANMI may be caused by asynchronous 
> > hardware events on any context.
> > 
> > If we can distinguish those 2 NMIs on preempt count, bpf people can easily
> > avoid the inevitable situation.
> 
> I don't like the name NMI IN SNMI, because they are not NMIs. They are
> actually more like kernel exceptions. Even page faults in the kernel is
> similar to a kprobe breakpoint or ftrace. It can happen anywhere, with any
> lock held. Perhaps we need a kernel exception context? Which by definition
> is synchronous.

What problem are you trying to solve? AFAICT all these contexts have the
same restrictions, why try and muck about with different names for the
same thing?
