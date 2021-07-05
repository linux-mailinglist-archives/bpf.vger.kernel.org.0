Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96F83BBABB
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhGEKGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 06:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhGEKGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 06:06:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE968613C8;
        Mon,  5 Jul 2021 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625479414;
        bh=Q8/L2LRHglK2rXQ7PV40+1czQBiJ/w+Kx+K0KseNmao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XVf7rhMls18J9mYaKp4sO/vU7UNqO27Sea2F2RLPt6xM22kkJlLVMKD0NPBSdCzqw
         Ey/aI6wwkszdnn6rA/wC1ltyHxN0h+EY6dduRVFqDg9wqqo+CE7nb4doc/j3w6UQv4
         HLDnq16sZ3HLpRqccxQ8XPHzPlTBhPDkYHv+q1/L1otOHzgye1yO7mNZjbo96iF0YH
         PdsJI0dunM2qwyyhZljvTfXZ+SmMDUhs0lkC2lw0V11llGuXcmZs5lzMKnVBrGkmAY
         I7Qxt5vwMRb0LAdEGEr0z7sHvzNa7iHUKy/PfUT4Y9dpuk2ISXFjetSouZ64vLASs0
         XTG3BLYVVehbw==
Date:   Mon, 5 Jul 2021 19:03:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 03/13] kprobes: treewide: Remove
 trampoline_address from kretprobe_trampoline_handler()
Message-Id: <20210705190328.8cf3fb4397500f2dafb761f0@kernel.org>
In-Reply-To: <YOKut2jZ4f+oSKAI@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399994996.506599.17672270294950096639.stgit@devnote2>
        <YOKut2jZ4f+oSKAI@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ingo,

On Mon, 5 Jul 2021 09:03:19 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -197,15 +197,23 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> >  				   struct pt_regs *regs);
> >  extern int arch_trampoline_kprobe(struct kprobe *p);
> >  
> > +void kretprobe_trampoline(void);
> > +/*
> > + * Since some architecture uses structured function pointer,
> > + * use dereference_function_descriptor() to get real function address.
> > + */
> > +static nokprobe_inline void *kretprobe_trampoline_addr(void)
> > +{
> > +	return dereference_kernel_function_descriptor(kretprobe_trampoline);
> > +}
> 
> Could we please also make 'kretprobe_trampoline' harder to use 
> accidentally, such by naming it appropriately?
> 
> __kretprobe_trampoline would be a good first step I guess.

Good idea! Let me update it.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
