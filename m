Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16162DCDA
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 14:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiKQNeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 08:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQNd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 08:33:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3738701AF;
        Thu, 17 Nov 2022 05:33:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C7E361DDB;
        Thu, 17 Nov 2022 13:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3FDC433C1;
        Thu, 17 Nov 2022 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668692037;
        bh=3Yi5R38N4+PFdRdgrod2ezt04BBlSr1w0HNb7xyM9cY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m+CfeFclZaH24btvODt3J6ikPRl4CUAodjNFcA9HUpL9816Ai/+kEcs9natU9OC07
         mMGOkydKUkke9lqI1GuebPXxzNtqLaGjfuHK6jd0Opa3xe5jGzp7Oxg8rxvkjGt2PW
         TnBaWfpyOfLIFi14WUrgqOJF0XHI7lxjAvp2Vm2MTwGrxDLOFFUY2Ftl/JLR4toD7u
         MSdTQTJPqGS2qWAckcbXYKS0zGssU1qRPKR3EPsFXGN8RP7nc3RF4XzhF13xsulsvA
         H5Fngx9JBjTxmT8TKWmpmK97l3eDz2bf2A1HlTC7vqyJyNH/vlIXCdi9/kofEMzbZN
         th2E4gyfRsyYA==
Date:   Thu, 17 Nov 2022 22:33:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-Id: <20221117223353.431e29124ba51a72c3507ced@kernel.org>
In-Reply-To: <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
References: <20221108220651.24492-1-revest@chromium.org>
        <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Nov 2022 18:41:26 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Nov 8, 2022 at 2:07 PM Florent Revest <revest@chromium.org> wrote:
> >
> > Hi!
> >
> > With this RFC, I'd like to revive the conversation between BPF, ARM and tracing
> > folks on what BPF tracing (fentry/fexit/fmod_ret) could/should look like on
> > arm64.
> >
> > Current status of BPF tracing
> > =============================
> >
> > On currently supported architectures (like x86), BPF tracing programs are
> > called from a JITted BPF trampoline, itself called from the ftrace patch site
> > thanks to the ftrace "direct call" API. (or from the end of the ftrace
> > trampoline if a ftrace ops is also tracing that function, but this is
> > transparent to BPF)
> >
> > Thanks to Xu's work [1], we now have BPF trampolines on arm64 (these can be
> > used for struct ops programs already), but Xu's attempts at getting ftrace
> > direct calls support [2][3] on arm64 have been unsucessful so far so we still
> > do not support BPF tracing programs. This prompted me to try a different
> > approach. I'd like to collect feedback on it here.
> >
> > Why not direct calls ?
> > ======================
> >
> > Mark and Steven have not been too keen on getting direct calls on arm64 because:
> > - working around BL instruction's limited range introduces complexity [4]
> > - it's difficult to get reliable stacktraces right with direct calls [5]
> > - direct calls are complex to maintain on the arch/ftrace side [5]
> >
> > In the absence of ftrace direct calls support, BPF tracing programs would need
> > to be called from an ftrace ops instead. Note that the BPF callback signature
> > would have to be different, so we can't re-use trampolines (direct called
> > callbacks receive arguments in registers whereas ftrace ops callbacks receive
> > arguments in a struct ftrace_regs pointer)
> >
> > Why fprobe ?
> > ============
> >
> > Ftrace ops per-se only expose an API to hook before a function. There are two
> > systems built on top of ftrace ops that also allow hooking the function exit:
> > fprobe (using rethook) and the function graph tracer. There are plans from
> > Masami and Steven to unify these two systems but, as they stand, only fprobe
> > gives enough flexibility to implement BPF tracing.
> >
> > In order not to reinvent the wheel, if direct calls aren't available on the
> > arch, BPF could leverage fprobe to hook before and after the traced function.
> > Note that return hooking is implemented a bit differently than it is in BPF
> > trampolines. Instead of keeping arguments on a stack frame and calling the
> > traced function, rethook saves arguments in a memory pool and returns to the
> > traced function with a hijacked return pointer that will have its ret jump back
> > to the rethook trampoline.
> >
> > What about performances ?
> > =========================
> >
> > In its current state, a fprobe callback on arm64 is very expensive because:
> > 1- the ftrace trampoline saves all registers (including many unnecessary ones)
> > 2- it calls ftrace_ops_list_func which iterates over all ops and is very slow
> > 3- the fprobe ops unconditionally hooks a rethook
> > 4- rethook grabs memory from a freelist which is slow under high contention
> >
> > However, all the above points are currently being addressed:
> > 1- by Mark's series to save argument registers only [6]
> > 2- by Mark's series to call single ops directly [7]
> > 3- by Masami's patch to skip rethooks if not needed [8]
> > 4- Masami said the rethook freelist would be replaced by a per-task stack as
> >    part of its unification with the function graph tracer [9]
> >
> > I measured the costs of BPF on different approaches on my RPi4 here: [10]
> > tl;dr: the BPF "bench" takes a performance hit of:
> > - 28.6% w/ BPF tracing on direct calls (best case scenario for reference) [11]
> > - 66.8% w/ BPF on kprobe (just for reference)
> > - 62.6% w/ BPF tracing on fprobe without any optimizations (current state) [12]
> > - 34.1% w/ BPF tracing on fprobe with all optimizations (near-future state) [13]
> 
> Even with all optimization the performance overhead is not acceptable.
> It feels to me that folks are still thinking about bpf trampoline
> as a tracing facility.
> It's a lot more than that. It needs to run 24/7 with zero overhead.
> It needs to replace the kernel functions and be invoked
> millions times a second until the system is rebooted.
> In this environment every nanosecond counts.
> 
> Even if the fprobe side was completely free the patch 1 has so much
> overhead in copy of bpf_cookie, regs, etc that it's a non-starter
> for these use cases.
> 
> There are several other fundamental issues in this approach
> because of fprobe/ftrace.
> It has ftrace_test_recursion_trylock and disables preemption.
> Both are deal breakers.

I talked with Florent about this offline.
ftrace_test_recursion_trylock() is required for generic ftrace
use because user callback can call a function which can be
traced by ftrace. This means it can cause an infinite loop.
However, if user can ensure to check it by itself, I can add a
flag to avoid that trylock. (Of course, you can shoot your foot.)

I thought the preemption disabling was for accessing per-cpu,
but it is needed for rethook to get an object from an RCU
protected list.
Thus when we move on the per-task shadow stack, it can be
removed too.

> 
> bpf trampoline has to allow recursion in some cases.
> See __bpf_prog_enter*() flavors.
> 
> bpf trampoline also has to use migrate_disable instead of preemption
> and rcu_read_lock() in some cases and rcu_read_lock_trace() in others.

Is rcu_read_lock() better than preempt_disable()? 

> 
> bpf trampoline must never allocate memory or grab locks.

Note that ftrace_test_recursion_trylock() is just a bit operation
per-task, not taking a lock (nor atomic).

Thank you,

> 
> All of these mandatory features exclude fprobe, ftrace, rethook
> from possible options.
> 
> Let's figure out how to address concerns with direct calls:
> 
> > - working around BL instruction's limited range introduces complexity [4]
> > - it's difficult to get reliable stacktraces right with direct calls [5]
> > - direct calls are complex to maintain on the arch/ftrace side [5]


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
