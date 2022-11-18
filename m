Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6D62FA5B
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiKRQe5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiKRQe4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 11:34:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9FD55C763;
        Fri, 18 Nov 2022 08:34:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0174723A;
        Fri, 18 Nov 2022 08:35:02 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 506D03F663;
        Fri, 18 Nov 2022 08:34:53 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:34:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chris Mason <clm@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-ID: <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
References: <20221108220651.24492-1-revest@chromium.org>
 <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home>
 <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117174030.0170cd36@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 05:40:30PM -0500, Steven Rostedt wrote:
> On Thu, 17 Nov 2022 16:55:12 -0500
> Chris Mason <clm@meta.com> wrote:
> 
> > On 11/17/22 12:16 PM, Steven Rostedt wrote:

> > The short answer to your concerns is that you can't replace kernel
> > functions from proprietary BPF programs.  The LSM and TCP congestion
> > control features intentionally have GPL only support functions in the
> > way.  bpf_probe_read_kernel() is also GPL only and massively limits the
> > things that can be done from proprietary code.
> 
> ^^^^^^^^^^^^^^^^^
> 
> That's the part I wanted to hear. But just the fact of replacing a kernel
> function with BPF code seems a bit concerning.

> > This list of helpers is pretty current and details which ones are GPL only:
> > 
> > https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md#helpers
> > 
> > I know there's a long and glorious history of collaboration around these
> > parts of bpf and ftrace.  I really hope this time around we all come
> > away feeling like the technical discussion made both projects better.
> > Mark and Florent today certainly made me think that was the direction we
> > were headed.
> > 
> > Along these lines, I'm also hoping to avoid diving into old debates and
> > alarmist conclusions about GPL compliance and signed bpf programs. Or,
> 
> Not alarmist, but concern as being able to modify what a kernel function can
> do is not something I take lightly.

FWIW, given that the aim here seems to be to expose all kernel internals to be
overridden arbitrarily, I'm also concerned that there's a huge surface area for
issues with maintainability, robustness/correctness, and security.

I really don't want to be stuck in a position where someone argues that all
kernel internal functions are ABI and need to stay around as-is to be hooked by
eBPF, and I hope that we all agree that there are no guarantees on that front.

Thanks,
Mark.
