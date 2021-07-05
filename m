Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D153BC125
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhGEPpi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 11:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhGEPph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 11:45:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 885F9613C1;
        Mon,  5 Jul 2021 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625499780;
        bh=aD6J7wwTkd61kTD+YwKULBV5n12ddnDruf6BnlnuTWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCNMDoMDhQ2wMpmN9RARXSdRUbarHsBSqXjBYzVz7WJMfPaB8IGGeX7UmgOF0mna2
         b6OIgpWM9cYIYPRaPFVm0+kMLV8nhUfH4mpd9jedJ78esavfDRwug3o7cNM0PPKJIp
         WysteeLoGKNKK+zxsamgNhAbuK5qeGbDnJ83no3TGnyeMZYg95IysbtYErZZCaHOcw
         uYuQks9iveRmvZOP24S5ECMD9DjoX2xho/bzkcKGv9RoVFTtEGqbKq/E1AjFEc5tjY
         pS+0eFNY7ZkiMQ0ASrLTQIp91v9k90qposfQrRjPUDhOgM9gGqdYRdRhTlAq5E5oYc
         AORBYg4FHanEA==
Date:   Tue, 6 Jul 2021 00:42:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20210706004257.9e282b98f447251a380f658f@kernel.org>
In-Reply-To: <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162400002631.506599.2413605639666466945.stgit@devnote2>
        <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Jul 2021 13:36:14 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jun 18, 2021 at 04:07:06PM +0900, Masami Hiramatsu wrote:
> > @@ -549,7 +548,15 @@ bool unwind_next_frame(struct unwind_state *state)
> >  					 (void *)orig_ip);
> >  			goto err;
> >  		}
> > -
> > +		/*
> > +		 * There is a small chance to interrupt at the entry of
> > +		 * kretprobe_trampoline where the ORC info doesn't exist.
> > +		 * That point is right after the RET to kretprobe_trampoline
> > +		 * which was modified return address. So the @addr_p must
> > +		 * be right before the regs->sp.
> > +		 */
> > +		state->ip = unwind_recover_kretprobe(state, state->ip,
> > +				(unsigned long *)(state->sp - sizeof(long)));
> >  		state->regs = (struct pt_regs *)sp;
> >  		state->prev_regs = NULL;
> >  		state->full_regs = true;
> > @@ -562,6 +569,9 @@ bool unwind_next_frame(struct unwind_state *state)
> >  					 (void *)orig_ip);
> >  			goto err;
> >  		}
> > +		/* See UNWIND_HINT_TYPE_REGS case comment. */
> > +		state->ip = unwind_recover_kretprobe(state, state->ip,
> > +				(unsigned long *)(state->sp - sizeof(long)));
> >  
> >  		if (state->full_regs)
> >  			state->prev_regs = state->regs;
> 
> Why doesn't the ftrace case have this? That is, why aren't both return
> trampolines having the same general shape?

Ah, this strongly depends what the trampoline code does.
For the kretprobe case, the PUSHQ at the entry of the kretprobe_trampoline()
does not covered by UNWIND_HINT_FUNC. Thus it needs to find 'correct_ret_addr'
by the frame pointer (which is next to the sp).

        "kretprobe_trampoline:\n"
#ifdef CONFIG_X86_64
        /* Push fake return address to tell the unwinder it's a kretprobe */
        "       pushq $kretprobe_trampoline\n"
        UNWIND_HINT_FUNC

But I'm not so sure how ftrace treat it. It seems that the return_to_handler()
doesn't care such case. (anyway, return_to_handler() does not return but jump
to the original call-site, in that case, the information will be lost.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
