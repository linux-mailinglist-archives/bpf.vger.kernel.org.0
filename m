Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B362E895
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKQWkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQWkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:40:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180B5915D;
        Thu, 17 Nov 2022 14:40:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47A5D622B9;
        Thu, 17 Nov 2022 22:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB256C433D6;
        Thu, 17 Nov 2022 22:40:31 +0000 (UTC)
Date:   Thu, 17 Nov 2022 17:40:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Mason <clm@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <20221117174030.0170cd36@gandalf.local.home>
In-Reply-To: <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
References: <20221108220651.24492-1-revest@chromium.org>
        <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
        <20221117121617.4e1529d3@gandalf.local.home>
        <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
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

On Thu, 17 Nov 2022 16:55:12 -0500
Chris Mason <clm@meta.com> wrote:

> On 11/17/22 12:16 PM, Steven Rostedt wrote:
> > On Wed, 16 Nov 2022 18:41:26 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >   
> >> Even with all optimization the performance overhead is not acceptable.
> >> It feels to me that folks are still thinking about bpf trampoline
> >> as a tracing facility.
> >> It's a lot more than that. It needs to run 24/7 with zero overhead.  
> > 
> > It obviously doesn't have zero overhead.
> > 
> > And correctness and maintainability trumps micro-optimizations.  
> 
> During the bpf office hours today Mark Rutland and Florent had some
> great ideas about how to wire things up.  I'm sure Mark will need some
> time to write it all down but it was a fun call.

That's good to hear.

> 
> >   
> >> It needs to replace the kernel functions and be invoked  
> > 
> > What do you mean by "replace the kernel functions"? You mean an existing
> > kernel function can be replaced by a bpf program? Like live patching?
> > 
> > This seems rather dangerous, and how does one know that their system has
> > integrity? Is there a feature to sign bpf programs before they can be added?
> > 
> > Also, it may be time to bring in the lawyers. If a bpf program can replace
> > an existing kernel function, then it has definitely passed the "user space"
> > exception to the GPL, where user space must use the system call interface.
> > By injecting executable code into the kernel, especially something that
> > replaces kernel functionality, it becomes arguably derived from the kernel
> > itself. And the BPF program must be GPL.
> > 
> > Allowing proprietary BPF programs to replace kernel functionality looks
> > like a clear violation and circumvention of the GPL. But I could be
> > mistaken. As I said, it's time to bring in the lawyers on this one.  
> 
> https://docs.kernel.org/bpf/bpf_licensing.html answers most of your
> questions.  It was reviewed by lawyers and also discussed pretty
> extensively on the lists.
> 



> The short answer to your concerns is that you can't replace kernel
> functions from proprietary BPF programs.  The LSM and TCP congestion
> control features intentionally have GPL only support functions in the
> way.  bpf_probe_read_kernel() is also GPL only and massively limits the
> things that can be done from proprietary code.

^^^^^^^^^^^^^^^^^

That's the part I wanted to hear. But just the fact of replacing a kernel
function with BPF code seems a bit concerning.

> 
> This list of helpers is pretty current and details which ones are GPL only:
> 
> https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md#helpers
> 
> I know there's a long and glorious history of collaboration around these
> parts of bpf and ftrace.  I really hope this time around we all come
> away feeling like the technical discussion made both projects better.
> Mark and Florent today certainly made me think that was the direction we
> were headed.
> 
> Along these lines, I'm also hoping to avoid diving into old debates and
> alarmist conclusions about GPL compliance and signed bpf programs. Or,

Not alarmist, but concern as being able to modify what a kernel function can
do is not something I take lightly.

-- Steve

> if some part of those old debates is no longer valid, can we split
> it off into a well researched separate thread and focus on technical 
> bits here?
