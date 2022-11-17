Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9B62E2B3
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiKQRQ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 12:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbiKQRQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 12:16:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9267819F;
        Thu, 17 Nov 2022 09:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 936FAB82161;
        Thu, 17 Nov 2022 17:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E601C433D7;
        Thu, 17 Nov 2022 17:16:21 +0000 (UTC)
Date:   Thu, 17 Nov 2022 12:16:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-ID: <20221117121617.4e1529d3@gandalf.local.home>
In-Reply-To: <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
References: <20221108220651.24492-1-revest@chromium.org>
        <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Nov 2022 18:41:26 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Even with all optimization the performance overhead is not acceptable.
> It feels to me that folks are still thinking about bpf trampoline
> as a tracing facility.
> It's a lot more than that. It needs to run 24/7 with zero overhead.

It obviously doesn't have zero overhead.

And correctness and maintainability trumps micro-optimizations.

> It needs to replace the kernel functions and be invoked

What do you mean by "replace the kernel functions"? You mean an existing
kernel function can be replaced by a bpf program? Like live patching?

This seems rather dangerous, and how does one know that their system has
integrity? Is there a feature to sign bpf programs before they can be added?

Also, it may be time to bring in the lawyers. If a bpf program can replace
an existing kernel function, then it has definitely passed the "user space"
exception to the GPL, where user space must use the system call interface.
By injecting executable code into the kernel, especially something that
replaces kernel functionality, it becomes arguably derived from the kernel
itself. And the BPF program must be GPL.

Allowing proprietary BPF programs to replace kernel functionality looks
like a clear violation and circumvention of the GPL. But I could be
mistaken. As I said, it's time to bring in the lawyers on this one.

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

Please explain why? The recursion protection lock is a simply bit operation
on the task struct which is used to protect against recursion at the same
context. Which if you do not have, will likely happen, and the only hint of
it is that the system triple faults and reboots. If you are only hooking to
one function, then it is easy to figure this out. But with the multi work
being done, that is no longer the case.

Hooking to functions is *extremely* intrusive. And protection against
errors is a must have, and not an option.

> 
> bpf trampoline has to allow recursion in some cases.
> See __bpf_prog_enter*() flavors.

The recursion lock allows recursions, but not at the same context. That is,
interrupt against normal context is fine. But really, you should not have
it within the same context. How do you verify that you do not run out of
stack?

> 
> bpf trampoline also has to use migrate_disable instead of preemption
> and rcu_read_lock() in some cases and rcu_read_lock_trace() in others.
> 
> bpf trampoline must never allocate memory or grab locks.

Neither should fprobes / ftrace.

-- Steve

> 
> All of these mandatory features exclude fprobe, ftrace, rethook
> from possible options.
> 
> Let's figure out how to address concerns with direct calls:
