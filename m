Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17141A8D
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2019 05:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406364AbfFLDFT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jun 2019 23:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404957AbfFLDFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 23:05:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50A2C8553D;
        Wed, 12 Jun 2019 03:05:08 +0000 (UTC)
Received: from treble (ovpn-120-37.rdu2.redhat.com [10.10.120.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AB7D7DFCA;
        Wed, 12 Jun 2019 03:05:03 +0000 (UTC)
Date:   Tue, 11 Jun 2019 22:05:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kairui Song <kasong@redhat.com>, Alexei Starovoitov <ast@fb.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190612030501.7tbsjy353g7l74ej@treble>
References: <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <20190524085319.GE2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190524085319.GE2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 12 Jun 2019 03:05:18 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 24, 2019 at 10:53:19AM +0200, Peter Zijlstra wrote:
> > For ORC, I'm thinking we may be able to just require that all generated
> > code (BPF and others) always use frame pointers.  Then when ORC doesn't
> > recognize a code address, it could try using the frame pointer as a
> > fallback.
> 
> Yes, this seems like a sensible approach. We'd also have to audit the
> ftrace and kprobe trampolines, IIRC they only do framepointer setup for
> CONFIG_FRAME_POINTER currently, which should be easy to fix (after the
> patches I have to fix the FP generation in the first place:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/wip

Right now, ftrace has a special hook in the ORC unwinder
(orc_ftrace_find).  It would be great if we could get rid of that in
favor of the "always use frame pointers" approach.  I'll hold off on
doing the kpatch/kprobe trampoline conversions in my patches since it
would conflict with yours.

Though, hm, because of pt_regs I guess ORC would need to be able to
decode an encoded frame pointer?  I was hoping we could leave those
encoded frame pointers behind in CONFIG_FRAME_POINTER-land forever...

Here are my latest BPF unwinder patches in case anybody wants a sneak
peek:

  https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=bpf-orc-fix

-- 
Josh
