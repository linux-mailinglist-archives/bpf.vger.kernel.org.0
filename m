Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1474930DB60
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 14:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhBCNee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 08:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhBCNeQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 08:34:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C832C64F60;
        Wed,  3 Feb 2021 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612359214;
        bh=XZj7mDrQP+rPOgqmalaKB74DR65xAbL5fJISLaH4o24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mJgTVWTunjnJgy+7Ky8HStxLhhswQvHy44xnsh5Yw+atc02TtfFiAI/DrIkuc5wxm
         eJyNVt78nw0c5vKatUuMI8jY4mICCh/nHmqtOpcs3sxQ5ROThw93R4rLseoVcW+dF9
         at5Shobxoa2hqeSiPYLt/nN8I7P4mLbu4OkhLfYwmJxCgtB4u7QNaEemuXIMAaqMri
         WV5yf+ViAvpnNRdTqnvhy1ByP+LjZKt2XShnoG7d8Y5uH4tcMCt+SFMD/UDkczWP02
         /bQoqEXFcoxi0kOsZBD84rUS41OAZuitbAVh0T7Ez8dpdb5HLqjirP2H2eIYOi/3e4
         Zkf6q7/hHUOFg==
Date:   Wed, 3 Feb 2021 22:33:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28
 ("x86: Replace ist_enter() with nmi_enter()")
Message-Id: <20210203223328.9e99548d19d482ac2e2cda81@kernel.org>
In-Reply-To: <20210202160513.38ada3a7@gandalf.local.home>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Feb 2021 16:05:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2 Feb 2021 19:30:34 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > That does mean that kprobes are then fundamentally running from
> > in_nmi(), which is what started all this.
> 
> I just thought about the fact that tracing records the context of the
> function it is called in. If you set "in_nmi()" for all ftrace handlers,
> then all functions will look like they are in an NMI context during tracing.
> 
> That is, the preempt count is checked to fill in the flags in the ring
> buffer that denotes what context the event (in this case the function) was
> called in.

Ah, that is what I worried about. ftrace and kprobes handler usually want to
know "what is the actual status of the system where the probe hits".

If the new kernel_exception_enter() for ftrace/kprobes or any other kernel
instrumention does

  __preempt_count_add(KEX_OFFSET + NMI_OFFSET + HARDIRQ_OFFSET);

And we can distinguish the KEX from NMI, and get the original status of the context.
What would you think about?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
