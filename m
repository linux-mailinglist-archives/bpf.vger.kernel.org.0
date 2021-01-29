Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77227308F3F
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 22:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhA2VZm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 16:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhA2VZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 16:25:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F39964E00;
        Fri, 29 Jan 2021 21:24:56 +0000 (UTC)
Date:   Fri, 29 Jan 2021 16:24:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210129162454.293523c6@gandalf.local.home>
In-Reply-To: <20210129140103.3ce971b7@gandalf.local.home>
References: <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
        <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
        <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
        <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
        <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
        <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
        <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
        <20210129105952.74dc8464@gandalf.local.home>
        <20210129162438.GC8912@worktop.programming.kicks-ass.net>
        <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
        <20210129140103.3ce971b7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Jan 2021 14:01:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 29 Jan 2021 18:59:43 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jan 29, 2021 at 09:45:48AM -0800, Alexei Starovoitov wrote:  
> > > Same things apply to bpf side. We can statically prove safety for
> > > ftrace and kprobe attaching whereas to deal with NMI situation we
> > > have to use run-time checks for recursion prevention, etc.    
> > 
> > I have no idea what you're saying. You can attach to functions that are
> > called with random locks held, you can create kprobes in some very
> > sensitive places.
> > 
> > What can you staticlly prove about that?  
> 
> I think the main difference is, if you attach a kprobe or ftrace function,
> you can theoretically analyze the location before you do the attachment.
> 
> Does, the NMI context mean "in_nmi()" returns true? Because there's cases
> in ftrace callbacks where that is checked (like the stack tracer). And
> having ftrace return true for "in_nmi()" will break a lot of existing
> utilities.

Specifically, kprobe and ftrace callbacks may have this:

	if (in_nmi())
		return;

	raw_spin_lock_irqsave(&lock, flags);
	[..]
	raw_spin_unlock_irqrestore(&lock, flags);

Which is totally fine to have, but the above only works if "in_nmi()"
returns true only if you are in a real NMI.

The stack tracer code does exactly the above.

-- Steve
