Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235D62FAA5
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 17:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiKRQp2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 11:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiKRQp0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 11:45:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6A27B24;
        Fri, 18 Nov 2022 08:45:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5868162670;
        Fri, 18 Nov 2022 16:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CB0C43147;
        Fri, 18 Nov 2022 16:45:21 +0000 (UTC)
Date:   Fri, 18 Nov 2022 11:45:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20221118114519.2711d890@gandalf.local.home>
In-Reply-To: <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
References: <20221108220651.24492-1-revest@chromium.org>
        <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
        <20221117121617.4e1529d3@gandalf.local.home>
        <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
        <20221117174030.0170cd36@gandalf.local.home>
        <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
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

On Fri, 18 Nov 2022 16:34:50 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > Not alarmist, but concern as being able to modify what a kernel function can
> > do is not something I take lightly.  
> 
> FWIW, given that the aim here seems to be to expose all kernel internals to be
> overridden arbitrarily, I'm also concerned that there's a huge surface area for
> issues with maintainability, robustness/correctness, and security.
> 
> I really don't want to be stuck in a position where someone argues that all
> kernel internal functions are ABI and need to stay around as-is to be hooked by
> eBPF, and I hope that we all agree that there are no guarantees on that front.

My biggest concern is changing functionality of arbitrary functions by BPF.
I would much rather limit what functions BPF could change with some
annotation.

int __bpf_modify foo()
{
	...
}


That way if somethings not working, you can see directly in the code that
the function could be modified by a BPF program, instead of getting some
random bug report because a function returned an unexpected result that the
code of that function could never produce.

-- Steve
