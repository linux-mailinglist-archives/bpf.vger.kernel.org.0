Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0D4270F
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2019 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfFLNK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jun 2019 09:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbfFLNK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 09:10:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24A420874;
        Wed, 12 Jun 2019 13:10:24 +0000 (UTC)
Date:   Wed, 12 Jun 2019 09:10:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kairui Song <kasong@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190612091023.6bccf262@gandalf.local.home>
In-Reply-To: <20190612030501.7tbsjy353g7l74ej@treble>
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
        <20190612030501.7tbsjy353g7l74ej@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 11 Jun 2019 22:05:01 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Right now, ftrace has a special hook in the ORC unwinder
> (orc_ftrace_find).  It would be great if we could get rid of that in
> favor of the "always use frame pointers" approach.  I'll hold off on
> doing the kpatch/kprobe trampoline conversions in my patches since it
> would conflict with yours.

Basically, IIUC, what you are saying is that the ftrace trampoline
should always store the %sp in %rb even when CONFIG_FRAME_POINTER is not
enabled? And this can allow you to remove the ftrace specific code from
the orc unwinder?

-- Steve


> 
> Though, hm, because of pt_regs I guess ORC would need to be able to
> decode an encoded frame pointer?  I was hoping we could leave those
> encoded frame pointers behind in CONFIG_FRAME_POINTER-land forever...

