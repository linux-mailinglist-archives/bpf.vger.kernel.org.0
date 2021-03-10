Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99C3341C7
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhCJPm5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 10:42:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233161AbhCJPmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 10:42:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4036B64F60;
        Wed, 10 Mar 2021 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615390951;
        bh=JOdkfpOFS6fkbawiuazEFw2CCzjQJ0pFxL/CxofoRsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g30NPMXI2QdxxB3J5nI4sNuTRLMmKcIBMwtc1w6cjCcbVNCrQaHVE/FFqSTIsV7Uw
         PBl9u99YWK1AgetTrcBpdZXt7k7Gb7Wup0NKvQ4oyL3NRkZJsA3bioiTLR/K5YGnmV
         OKHniCiQyibtS9p+VpgAYzqkwPlw6B3uJXfZBtPMQDWNx7CrHSDps7RHUcPp763+ZT
         9px+SHHydWAMuQjV4EhJr3pwMsKpJ43LGqGJ1uoJhchNm0Mn8uYCMs6L8sunSUWz0v
         LjH8rc/XkpP1w/NY2Ak8jzYeC0WSwhZudGVgIwg4uEM0grOFNpQiWeysB7fF965wHT
         43FgiSPgD82gw==
Date:   Thu, 11 Mar 2021 00:42:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 3/5] kprobes: treewide: Remove trampoline_address
 from kretprobe_trampoline_handler()
Message-Id: <20210311004225.77e844ff8170108bfb75b470@kernel.org>
In-Reply-To: <alpine.LSU.2.21.2103101258070.18547@pobox.suse.cz>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <161495876994.346821.11468535974887762132.stgit@devnote2>
        <alpine.LSU.2.21.2103101258070.18547@pobox.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Mar 2021 15:21:01 +0100 (CET)
Miroslav Benes <mbenes@suse.cz> wrote:

> Hi Masami,
> 
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -205,15 +205,23 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> >  				   struct pt_regs *regs);
> >  extern int arch_trampoline_kprobe(struct kprobe *p);
> >  
> > +void kretprobe_trampoline(void);
> > +/*
> > + * Since some architecture uses structured function pointer,
> > + * use arch_deref_entry_point() to get real function address.
> 
> s/arch_deref_entry_point/dereference_function_descriptor/ ?

Ah, I missed it. Thanks!

> 
> > + */
> > +static nokprobe_inline void *kretprobe_trampoline_addr(void)
> > +{
> > +	return dereference_function_descriptor(kretprobe_trampoline);
> > +}
> > +
> 
> Would it make sense to use this in s390 and powerpc reliable unwinders?
> 
> Both
> 
> arch/s390/kernel/stacktrace.c:arch_stack_walk_reliable()
> arch/powerpc/kernel/stacktrace.c:__save_stack_trace_tsk_reliable()
> 
> have
> 
> 	if (state.ip == (unsigned long)kretprobe_trampoline)
> 		return -EINVAL;
> 
> which you wanted to hide previously if I am not mistaken.

I think, if "ip" means "instruction pointer", it should point
the real instruction address, which is dereferenced from function
descriptor. So using kretprobe_trampoline_addr() is good.

But of course, it depends on the architecture. I'm not familiar
with the powerpc and s390, I need those maintainer's help...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
