Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFE41FF6
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2019 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfFLIyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jun 2019 04:54:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbfFLIyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 04:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DX/8C5iPqro7r1mMnPX+ipmA3A/CBB6VQR50M3FGzco=; b=F95PB4+p5JUAzXjmnWgrl96Me
        kJ0qo/iMAQOz9m7GDAkW9INg3OhbW6riHwB6NXrVEY+0CpDYvrBOfga0YqJtk5NnTNxAQ5mzvHFbi
        X2AphJOsAhvHzNhoApoUTd21k8GVgUJmpgXmg50ZjMC769dCOs939h5yZ/6KSF15rRSBtXG6ggyT1
        pGETfaDcWYoprry8vXfMsr+e1pNLgsawCNQZvKY2r1F2Vpmtge8zAqaJjROFwyA+mX4Cakl7kVJ+F
        hsylT918Fk6WqLxEPbMVDxLl6VYmXDq0cUAEB1RyZwwC3Ss9OcP/+CgrtSwpTmrXU+2XqVOGKzYYD
        M+nQJGUhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haz1V-0005Zz-Re; Wed, 12 Jun 2019 08:54:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A6EB20564E2A; Wed, 12 Jun 2019 10:54:23 +0200 (CEST)
Date:   Wed, 12 Jun 2019 10:54:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>, Alexei Starovoitov <ast@fb.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190612085423.GE3436@hirez.programming.kicks-ass.net>
References: <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <20190524085319.GE2589@hirez.programming.kicks-ass.net>
 <20190612030501.7tbsjy353g7l74ej@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612030501.7tbsjy353g7l74ej@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 11, 2019 at 10:05:01PM -0500, Josh Poimboeuf wrote:
> On Fri, May 24, 2019 at 10:53:19AM +0200, Peter Zijlstra wrote:
> > > For ORC, I'm thinking we may be able to just require that all generated
> > > code (BPF and others) always use frame pointers.  Then when ORC doesn't
> > > recognize a code address, it could try using the frame pointer as a
> > > fallback.
> > 
> > Yes, this seems like a sensible approach. We'd also have to audit the
> > ftrace and kprobe trampolines, IIRC they only do framepointer setup for
> > CONFIG_FRAME_POINTER currently, which should be easy to fix (after the
> > patches I have to fix the FP generation in the first place:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/wip
> 
> Right now, ftrace has a special hook in the ORC unwinder
> (orc_ftrace_find).  It would be great if we could get rid of that in
> favor of the "always use frame pointers" approach.  I'll hold off on
> doing the kpatch/kprobe trampoline conversions in my patches since it
> would conflict with yours.
> 
> Though, hm, because of pt_regs I guess ORC would need to be able to
> decode an encoded frame pointer?  I was hoping we could leave those
> encoded frame pointers behind in CONFIG_FRAME_POINTER-land forever...

Ah, I see.. could a similar approach work for the kprobe trampolines
perhaps?

> Here are my latest BPF unwinder patches in case anybody wants a sneak
> peek:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=bpf-orc-fix

On a quick read-through, that looks good to me. A minor nit:

			/* mov dst_reg, %r11 */
			EMIT_mov(dst_reg, AUX_REG);

The disparity between %r11 and AUX_REG is jarring. I understand the
whole bpf register mapping thing, but it is just weird when reading
this.

Other than that, the same note as before, the 32bit JIT still seems
buggered, but I'm not sure you (or anybody else) cares enough about that
to fix it though. It seems to use ebp as its own frame pointer, which
completely defeats an unwinder.
