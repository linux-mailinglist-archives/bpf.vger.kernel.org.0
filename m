Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E813BD9AB
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhGFPO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 11:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhGFPOX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 11:14:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED2C619AE;
        Tue,  6 Jul 2021 15:11:43 +0000 (UTC)
Date:   Tue, 6 Jul 2021 11:11:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 11/13] x86/unwind: Recover kretprobe trampoline
 entry
Message-ID: <20210706111136.7c5e9843@oasis.local.home>
In-Reply-To: <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162400002631.506599.2413605639666466945.stgit@devnote2>
        <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
        <20210706004257.9e282b98f447251a380f658f@kernel.org>
        <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 6 Jul 2021 09:55:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > But I'm not so sure how ftrace treat it. It seems that the return_to_handler()
> > doesn't care such case. (anyway, return_to_handler() does not return but jump
> > to the original call-site, in that case, the information will be lost.)  
> 
> I find it bothersome (OCD, sorry :-) that both return trampolines behave
> differently. Doubly so because I know people (Steve in particular) have
> been talking about unifying them.

They were developed separately, and designed differently with different
goals in mind. Yes, I want to unify them, but trying to get the
different goals together, compounded by the fact that almost every arch
also implemented them differently (in which case, we need to find a way
to do it one arch at a time), makes the process extremely frustrating.

> 
> Steve, can you clarify the ftrace side here? Afaict return_to_handler()
> is similarly affected.

I'm not exactly sure what the issue is. As Masami stated, kretprobe
uses a ret to return to the calling function, but ftrace uses a jmp.

kretprobe return tracing is more complex than the function graph return
tracing is (which is one of the issues I need to overcome to unify
them), and when the function graph return trampoline was created, it
did things as simple as possible (and before ORC existed).

Is this something to worry about now, or should we look to fix his in
the unifying process?

-- Steve
