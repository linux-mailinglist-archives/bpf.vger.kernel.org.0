Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5730DBE9
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhBCNxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 08:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbhBCNxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 08:53:16 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FDF64DDA;
        Wed,  3 Feb 2021 13:52:33 +0000 (UTC)
Date:   Wed, 3 Feb 2021 08:52:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210203085232.402e2e35@oasis.local.home>
In-Reply-To: <20210203223328.9e99548d19d482ac2e2cda81@kernel.org>
References: <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
        <20210129140103.3ce971b7@gandalf.local.home>
        <20210129162454.293523c6@gandalf.local.home>
        <YBUYsFlxjsQxuvfB@hirez.programming.kicks-ass.net>
        <20210130074410.6384c2e2@oasis.local.home>
        <YBktVT+z7sV/vEPU@hirez.programming.kicks-ass.net>
        <20210202095249.5abd6780@gandalf.local.home>
        <YBmBu0c24RjNYFet@hirez.programming.kicks-ass.net>
        <20210202115623.08e8164d@gandalf.local.home>
        <YBmaStZn9XEU0QE+@hirez.programming.kicks-ass.net>
        <20210202160513.38ada3a7@gandalf.local.home>
        <20210203223328.9e99548d19d482ac2e2cda81@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 3 Feb 2021 22:33:28 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Ah, that is what I worried about. ftrace and kprobes handler usually want to
> know "what is the actual status of the system where the probe hits".
> 
> If the new kernel_exception_enter() for ftrace/kprobes or any other kernel
> instrumention does
> 
>   __preempt_count_add(KEX_OFFSET + NMI_OFFSET + HARDIRQ_OFFSET);
> 
> And we can distinguish the KEX from NMI, and get the original status of the context.
> What would you think about?

Oh, that reminds me about the obvious difference between an NMI and a
ftrace handler. A ftrace handler doesn't disable interrupts nor
preemption. Thus, if you set "in_nmi" to a ftrace handler, and an
interrupt (or NMI) comes in, then any ftrace handlers called by the
interrupt / NMI will be ignored, since it will think it is recursing
from NMI context.

-- Steve
