Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271DE309510
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 13:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhA3MLJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 07:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhA3MLJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 07:11:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7952664DDC;
        Sat, 30 Jan 2021 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612008628;
        bh=p3IJGlMdtX9I1kgadKwx0x2GqQLSItjvV7ppyHSL2/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eWZuYfUnlm3B3qwR+nwqP+w0gYbO9+bUsDyh+xYlwkQ97lly0HU2gEsq2+ALvgDyu
         bk7uKVZoUzv7USeAxTzux0oY2trIxfTQhUzhuJLL1+sZMsxKs+n+JYfgK4TXfl/fb1
         V8uwJuxxyhGcWJRySXg1HY1ZfgJpPsFqWMdiDqaHQNajll48gWKIjVh51LAjb/5r2P
         9SV5iBOLXzUgR6EIN7KIFD0iNrJCXYNFnWDCmdANjRtP8XGd44JGGZdDKPlsnOr1qg
         P5tMF7Px9hk0uhvZy7tOkDOdYqZ+uqgQY6KG5NkonkLrWDtXRC6ZsdHkulGNhSi95S
         JdAhhaBRFPJpQ==
Date:   Sat, 30 Jan 2021 21:10:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28
 ("x86: Replace ist_enter() with nmi_enter()")
Message-Id: <20210130211022.d64c4caaf6667ec70a871420@kernel.org>
In-Reply-To: <20210130030840.hodq2ixpkdoue5jd@ast-mbp.dhcp.thefacebook.com>
References: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
        <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
        <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
        <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
        <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
        <20210129105952.74dc8464@gandalf.local.home>
        <20210129162438.GC8912@worktop.programming.kicks-ass.net>
        <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
        <20210129175943.GH8912@worktop.programming.kicks-ass.net>
        <20210130110249.61fdad8f0cfe51a121c72302@kernel.org>
        <20210130030840.hodq2ixpkdoue5jd@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Jan 2021 19:08:40 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Sat, Jan 30, 2021 at 11:02:49AM +0900, Masami Hiramatsu wrote:
> > On Fri, 29 Jan 2021 18:59:43 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, Jan 29, 2021 at 09:45:48AM -0800, Alexei Starovoitov wrote:
> > > > Same things apply to bpf side. We can statically prove safety for
> > > > ftrace and kprobe attaching whereas to deal with NMI situation we
> > > > have to use run-time checks for recursion prevention, etc.
> > > 
> > > I have no idea what you're saying. You can attach to functions that are
> > > called with random locks held, you can create kprobes in some very
> > > sensitive places.
> > > 
> > > What can you staticlly prove about that?
> > 
> > For the bpf and the kprobe tracer, if a probe hits in the NMI context,
> > it can call the handler with another handler processing events.
> > 
> > kprobes is carefully avoiding the deadlock by checking recursion
> > with per-cpu variable. But if the handler is shared with the other events
> > like tracepoints, it needs to its own recursion cheker too.
> > 
> > So, Alexei, maybe you need something like this instead of in_nmi() check.
> > 
> > DEFINE_PER_CPU(bool, under_running_bpf);
> > 
> > common_handler()
> > {
> > 	if (__this_cpu_read(under_running_bpf))
> > 		return;
> > 	__this_cpu_write(under_running_bpf, true);
> > 	/* execute bpf prog */
> > 	__this_cpu_write(under_running_bpf, false);	
> > }
> > 
> > Does this work for you?
> 
> This exactly check is already in trace_call_bpf.
> Right after if (in_nmi()).
> See bpf_prog_active. It serves different purpose though.
> Simply removing if (in_nmi()) from trace_call_bpf is a bit scary.
> I need to analyze all code paths first.

OK, if bpf already avoids its recursion, other considerable case is
that some resources are shared among bpf_prog and other parts. Since
asynchronous NMI can occur anywhere, such resource usage can conflict
with bpf_prog.

Kprobes had similar issue, so I set a dummy kprobes to current_kprobes
for protecting such critical sections.
See kprobe_busy_begin()/end() and where those are used.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
