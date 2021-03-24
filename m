Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C0348580
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 00:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhCXXr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 19:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234936AbhCXXrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Mar 2021 19:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F74761A1B;
        Wed, 24 Mar 2021 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616629666;
        bh=v59vByxGJgHUIeCgl6iQF3cvCpnYou0eQu+z4+VM78o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G3A+zkz7210ziOxm83lOvNFO21FhzdWgPtySMCeO5Znex2w/S9GHonLO68eUSzrQW
         uXVpt5KN14vzJKKFXz3GfLEdwJvwiewrLLitdmzMoVQQ2KaDxu6v1pk+3a0NMrk7ez
         s9dKbiCW+ymshljVk9mb8fK9EwlPsrxfZWtA+ZheNOzdWK1k8hEdPImL4yqLnU9xYH
         W08x9sjlXtVgRcuTiCYTrBwStFF2Hn/KrauXRx05NjClqEK/ERWGKbeY27LIS6yUbU
         5SbQsVfUedJhfbGxtwEZZwTiLaFfjHecbPw4CUBo7xs0Reb6/WG97W1p+TuG9xDXUz
         NApD42hpZMSww==
Date:   Thu, 25 Mar 2021 08:47:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address
 at kretprobe_trampoline
Message-Id: <20210325084741.74bdb2b1d2ed00fe68840cea@kernel.org>
In-Reply-To: <20210324160143.wd43zribpeop2czn@treble>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639530062.895304.16962383429668412873.stgit@devnote2>
        <20210323223007.GG4746@worktop.programming.kicks-ass.net>
        <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
        <20210324160143.wd43zribpeop2czn@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Mar 2021 11:01:43 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Mar 24, 2021 at 10:40:58AM +0900, Masami Hiramatsu wrote:
> > On Tue, 23 Mar 2021 23:30:07 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Mon, Mar 22, 2021 at 03:41:40PM +0900, Masami Hiramatsu wrote:
> > > >  	".global kretprobe_trampoline\n"
> > > >  	".type kretprobe_trampoline, @function\n"
> > > >  	"kretprobe_trampoline:\n"
> > > >  #ifdef CONFIG_X86_64
> > > 
> > > So what happens if we get an NMI here? That is, after the RET but before
> > > the push? Then our IP points into the trampoline but we've not done that
> > > push yet.
> > 
> > Not only NMI, but also interrupts can happen. There is no cli/sti here.
> > 
> > Anyway, thanks for pointing!
> > I think in UNWIND_HINT_TYPE_REGS and UNWIND_HINT_TYPE_REGS_PARTIAL cases
> > ORC unwinder also has to check the state->ip and if it is kretprobe_trampoline,
> > it should be recovered.
> > What about this?
> 
> I think the REGS and REGS_PARTIAL cases can also be affected by function
> graph tracing.  So should they use the generic unwind_recover_ret_addr()
> instead of unwind_recover_kretprobe()?

Yes, but I'm not sure this parameter can be applied.
For example, it passed "state->sp - sizeof(unsigned long)" as where the
return address stored address. Is that same on ftrace graph too?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
