Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D929377
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbfEXIxl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 04:53:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46692 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389276AbfEXIxl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 04:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LXmpMTr3XlRy99COjSyRQeXMTTr9YPleMD/v1+k5tko=; b=FFhzeP6klPAGGecTbC7KSAl/S
        pN8lJ8PEZYEAdEN95JChOFyF98gYqQ4fIS7MUM1MK8ru4th8yMfJ6k5krhX/YvSCygYL2LHZzq4iE
        4T+/ZuToRYQinZY6kIgbroXkTNZwgi6PGFlUgRuHrZN07UKGvjOMjgdDg4C/bea4ANH1wDhHPKdfh
        vST04O7Y+1y6+uA68szMemv9ngVx6m3V96y7YKc3aARR5Z7Yxu0zA9V0M3zNRSgmmsIyGFpRW8bZ7
        LvYqjUddgy3A9wmNdBKyHijpMcWBp1qSF8UO3WA69QsPdPvt/RSF7ICTXiBx2xuuHIIZmNyZhpkof
        yy6DeQzBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hU5x4-00079T-5N; Fri, 24 May 2019 08:53:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D12CD201D3687; Fri, 24 May 2019 10:53:19 +0200 (CEST)
Date:   Fri, 24 May 2019 10:53:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>, Alexei Starovoitov <ast@fb.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190524085319.GE2589@hirez.programming.kicks-ass.net>
References: <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523152413.m2pbnamihu3s2c5s@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 23, 2019 at 10:24:13AM -0500, Josh Poimboeuf wrote:

> Here's the latest version which should fix it in all cases (based on
> tip/master):
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=bpf-orc-fix

That patch suffers an inconsitency, the comment states:

  'if they have "jump_table" in the name'

while the actual code implements:

  'if the name starts with "jump_table"'

Other than that, I suppose that works just fine ;-)

> There's no need to put special cases in the FP unwinder when we can
> instead just fix the frame pointer usage in the JIT code.
> 
> For ORC, I'm thinking we may be able to just require that all generated
> code (BPF and others) always use frame pointers.  Then when ORC doesn't
> recognize a code address, it could try using the frame pointer as a
> fallback.

Yes, this seems like a sensible approach. We'd also have to audit the
ftrace and kprobe trampolines, IIRC they only do framepointer setup for
CONFIG_FRAME_POINTER currently, which should be easy to fix (after the
patches I have to fix the FP generation in the first place:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/wip
)
