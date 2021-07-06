Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA13BC789
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhGFH6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGFH6J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 03:58:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B0EC061574;
        Tue,  6 Jul 2021 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PHmwfF66DF3ND/ZlAeaO0Y+ydd1OV8Qn7m+HyKVviH0=; b=mDFoN6jKwbzJOcU3MKwK7TiDSw
        TApWi0MZ26WSrA2OOgCBdYlgbApezWRB+u7yMnh7d5For8iLhQNieNbezlv8KsfG2Tbw+PiG0bKaR
        PlEVyhQb6dgQNZjPwnBf2/KSz4gbwPCcRNGImP3fd5oUpZeZl3BL/Vl4x6gU9ZOMfygiaJ8Bc8396
        ahg4qJ7Bt1i5GXiOt4oSeOoq5IBSgCxOyQlRrFaJiqTFbnyY9pi28n70w7QYErcD2FV5iB1wMSJl5
        vDy5JRGXLap/ow0H/UbcEbwTOCzoOXSVW7sLp77yvU7Y6hGpfCJCOmbfLUMNOtGyEhZuXeXU2xHeu
        kfKLCqTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0fv8-00EyhE-0s; Tue, 06 Jul 2021 07:55:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A7B33001DC;
        Tue,  6 Jul 2021 09:55:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44BD2200E1E68; Tue,  6 Jul 2021 09:55:03 +0200 (CEST)
Date:   Tue, 6 Jul 2021 09:55:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400002631.506599.2413605639666466945.stgit@devnote2>
 <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
 <20210706004257.9e282b98f447251a380f658f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706004257.9e282b98f447251a380f658f@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 06, 2021 at 12:42:57AM +0900, Masami Hiramatsu wrote:
> On Mon, 5 Jul 2021 13:36:14 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jun 18, 2021 at 04:07:06PM +0900, Masami Hiramatsu wrote:
> > > @@ -549,7 +548,15 @@ bool unwind_next_frame(struct unwind_state *state)
> > >  					 (void *)orig_ip);
> > >  			goto err;
> > >  		}
> > > -
> > > +		/*
> > > +		 * There is a small chance to interrupt at the entry of
> > > +		 * kretprobe_trampoline where the ORC info doesn't exist.
> > > +		 * That point is right after the RET to kretprobe_trampoline
> > > +		 * which was modified return address. So the @addr_p must
> > > +		 * be right before the regs->sp.
> > > +		 */
> > > +		state->ip = unwind_recover_kretprobe(state, state->ip,
> > > +				(unsigned long *)(state->sp - sizeof(long)));
> > >  		state->regs = (struct pt_regs *)sp;
> > >  		state->prev_regs = NULL;
> > >  		state->full_regs = true;
> > > @@ -562,6 +569,9 @@ bool unwind_next_frame(struct unwind_state *state)
> > >  					 (void *)orig_ip);
> > >  			goto err;
> > >  		}
> > > +		/* See UNWIND_HINT_TYPE_REGS case comment. */
> > > +		state->ip = unwind_recover_kretprobe(state, state->ip,
> > > +				(unsigned long *)(state->sp - sizeof(long)));
> > >  
> > >  		if (state->full_regs)
> > >  			state->prev_regs = state->regs;
> > 
> > Why doesn't the ftrace case have this? That is, why aren't both return
> > trampolines having the same general shape?
> 
> Ah, this strongly depends what the trampoline code does.
> For the kretprobe case, the PUSHQ at the entry of the kretprobe_trampoline()
> does not covered by UNWIND_HINT_FUNC. Thus it needs to find 'correct_ret_addr'
> by the frame pointer (which is next to the sp).
> 
>         "kretprobe_trampoline:\n"
> #ifdef CONFIG_X86_64
>         /* Push fake return address to tell the unwinder it's a kretprobe */
>         "       pushq $kretprobe_trampoline\n"
>         UNWIND_HINT_FUNC
> 
> But I'm not so sure how ftrace treat it. It seems that the return_to_handler()
> doesn't care such case. (anyway, return_to_handler() does not return but jump
> to the original call-site, in that case, the information will be lost.)

I find it bothersome (OCD, sorry :-) that both return trampolines behave
differently. Doubly so because I know people (Steve in particular) have
been talking about unifying them.

Steve, can you clarify the ftrace side here? Afaict return_to_handler()
is similarly affected.
