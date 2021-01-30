Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1EC309528
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 13:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhA3Mo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 07:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhA3Mox (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 07:44:53 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63E564E09;
        Sat, 30 Jan 2021 12:44:11 +0000 (UTC)
Date:   Sat, 30 Jan 2021 07:44:10 -0500
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
Message-ID: <20210130074410.6384c2e2@oasis.local.home>
In-Reply-To: <YBUYsFlxjsQxuvfB@hirez.programming.kicks-ass.net>
References: <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
        <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
        <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
        <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
        <20210129105952.74dc8464@gandalf.local.home>
        <20210129162438.GC8912@worktop.programming.kicks-ass.net>
        <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
        <20210129140103.3ce971b7@gandalf.local.home>
        <20210129162454.293523c6@gandalf.local.home>
        <YBUYsFlxjsQxuvfB@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 30 Jan 2021 09:28:32 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jan 29, 2021 at 04:24:54PM -0500, Steven Rostedt wrote:
> > Specifically, kprobe and ftrace callbacks may have this:
> > 
> > 	if (in_nmi())
> > 		return;
> > 
> > 	raw_spin_lock_irqsave(&lock, flags);
> > 	[..]
> > 	raw_spin_unlock_irqrestore(&lock, flags);
> > 
> > Which is totally fine to have,  
> 
> Why? There's a distinct lack of explaining here.
> 
> Note that we ripped out all such dodgy locking from kretprobes.

Actually, I think you helped explain the distinction. You mention
"kretpobes" do you mean the infrastructure of kretprobes or all its
users?

The infrastructure of ftrace and kprobes can work in any context, it
does not mean that the callbacks must. Again, these are more like
exceptions. Why have "in_nmi()"? If anything that can be called by an
NMI should just work, right? That's basically your argument for having
ftrace and kprobes set "in_nmi".

You can have locking in NMIs if the locking is *only* in NMI handlers,
right? If that's the case, then so should ftrace and kprobe callbacks.

The stack tracer checks the size of the stack, compares it to the
largest recorded size, and if it's bigger, it will save the stack. But
if this happens on two CPUs at the same time, only one can do the
recording at the same time. To synchronize this, a spin lock must be
taken. Similar to spin locks in an NMI.

But the problem here is, the callbacks can also be done from an NMI
context, so if we are in NMI, we don't want to take any locks, and
simply don't record the stack traces from NMIs.

The more I think about it, the more I hate the idea that ftrace
callbacks and kprobes are considered NMIs. Simply because they are not!

-- Steve

