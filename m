Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9BF3AB6D2
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhFQPEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 11:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233104AbhFQPEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 11:04:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 386E6610A3;
        Thu, 17 Jun 2021 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942163;
        bh=z1iyLhNJsf7wtbsK5AmP9LuCmt80iLYAIIgiUSThkRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mm8n+Tlbxe2H14BC1lijg42X/bWhlB+XtItSgLm9Fb8/9MioxRxj6Rg3MZQCqqt2B
         BNZzK3hsNMmKmZZ7a1ORDbjU5lzS4bEE932nlB5xg3DZ3fwj8++O5jgbrnBcRBXNFK
         4BvyBLrYovGKEwflMQHGFfjE8cy9BTqcP/5iDkZaP204BQ8qCioWg7ahpok558d524
         1lucS75wb7jK9VFFrpJDLVmY/Zjqj3RtdF96MzxRe1iUgNB09XvhEiYVNhAe5krmBg
         JxcY8nNQYJQY7u1wR69KDUJ9yMhcgPjmVnLHIeGh/M5BjW1/zmI7ccRVr7DZh9F7iD
         WFmIJSdx7uHRw==
Date:   Fri, 18 Jun 2021 00:02:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-Id: <20210618000239.f95de17418beae6d84ce783d@kernel.org>
In-Reply-To: <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
        <162209762943.436794.874947392889792501.stgit@devnote2>
        <20210617043909.fgu2lhnkxflmy5mk@treble>
        <20210617044032.txng4enhiduacvt6@treble>
        <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 17 Jun 2021 23:40:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 16 Jun 2021 23:40:32 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Wed, Jun 16, 2021 at 11:39:11PM -0500, Josh Poimboeuf wrote:
> > > On Thu, May 27, 2021 at 03:40:29PM +0900, Masami Hiramatsu wrote:
> > > > To simplify the stacktrace with pt_regs from kretprobe handler,
> > > > set the correct return address to the instruction pointer in
> > > > the pt_regs before calling kretprobe handlers.
> > > > 
> > > > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Tested-by: Andrii Nakryik <andrii@kernel.org>
> > > > ---
> > > >  Changes in v3:
> > > >   - Cast the correct_ret_addr to unsigned long.
> > > > ---
> > > >  kernel/kprobes.c |    3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > index 54e5b89aad67..1598aca375c9 100644
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -1914,6 +1914,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> > > >  		BUG_ON(1);
> > > >  	}
> > > >  
> > > > +	/* Set the instruction pointer to the correct address */
> > > > +	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> > > > +
> > > >  	/* Run them. */
> > > >  	first = current->kretprobe_instances.first;
> > > >  	while (first) {
> > > > 
> > > 
> > > Hi Masami,
> > > 
> > > I know I suggested this patch, but I believe it would only be useful in
> > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > think that would be tricky to pull off correctly.  Instead, we have
> > > UNWIND_HINT_FUNC, which is working fine.
> > > 
> > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > reading regs->ip after all.
> > 
> > ... and I guess this means patches 6-8 are no longer necessary.
> 
> OK, I also confirmed that dropping those patche does not make any change
> on the stacktrace. 
> Let me update the series without those. 

Oops, Andrii, can you also test the kernel without this patch?
(you don't need to drop patch 6-8) 
This changes the kretprobe to pass the return address via regs->ip to handler.
Dynamic-event doesn't use it, but I'm not sure bcc is using it or not.

Thank you,

> 
> Thank you,
> 
> > 
> > -- 
> > Josh
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
