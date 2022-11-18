Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5689F62FA06
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiKRQSo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 11:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRQSk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 11:18:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9711CFCD3;
        Fri, 18 Nov 2022 08:18:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF2C23A;
        Fri, 18 Nov 2022 08:18:43 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3EC63F663;
        Fri, 18 Nov 2022 08:18:34 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:18:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chris Mason <clm@meta.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <Y3ewWJITWH2b4ihI@FVFF77S0Q05N.cambridge.arm.com>
References: <20221108220651.24492-1-revest@chromium.org>
 <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home>
 <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 04:55:12PM -0500, Chris Mason wrote:
> On 11/17/22 12:16 PM, Steven Rostedt wrote:
> > On Wed, 16 Nov 2022 18:41:26 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > > Even with all optimization the performance overhead is not acceptable.
> > > It feels to me that folks are still thinking about bpf trampoline
> > > as a tracing facility.
> > > It's a lot more than that. It needs to run 24/7 with zero overhead.
> > 
> > It obviously doesn't have zero overhead.
> > 
> > And correctness and maintainability trumps micro-optimizations.
> 
> During the bpf office hours today Mark Rutland and Florent had some
> great ideas about how to wire things up.  I'm sure Mark will need some
> time to write it all down but it was a fun call.

I'd hoped to write that up today, but I haven't had enough time yet, so I'll
try to write up that proposal next week.

The rough idea was to *somehow* rejig the per-callsite ftrace_ops code I've
been working on to permit (but not require) the use of custom trampolines. As
mentioned during the call I want to ensure that this doesn't adversely affect
regular ftrace usage, and I'd also like to ensure that the regular ftrace code
is able to gain form those changes (without the need for trampolines). AFAICT,
that's likely to require some rework to the way direct functions are managed.

The WIP code for per-callsite ftrace_ops is at:

 https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops

To be clear, my comments were purely about the *mechanism* we end up
implementing. I do have concerns w.r.t. overriding arbitrary parts of the
kernel.

Thanks,
Mark.
