Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958653A72CA
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 02:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhFOAIe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 20:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhFOAIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Jun 2021 20:08:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A705A60FEA;
        Tue, 15 Jun 2021 00:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623715590;
        bh=RMii/VLLTCvCVHMFN18fdNCg3G9EDAUjvrxZCNvuRiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eM8VGoGxy9VEGIi37hrK9bCogcybs+WFEIp5s1KM+D/nkUtkRhZzJglMixPb2Ywgl
         PUkeX6o/AR2d8OKT5cHbsUaSosbRVnxWEbVw7yjBukm8OQFPK9ms3ZgrCRvUVPFPlY
         RuTguB4fu4PaN7A5ks+skd9K49g7t0p1krCpj5F4LJ2n3kAlcocWih3rYL5HIENKbK
         p1bG0cvT0aycIKs2cLLqKZ5URSmXYcT7Jc9yXbU6bybHqQRBzp9rSvnu/APbQZ1HCG
         K1+IoIq8qcOPAI4JryPVkPuWVXQO1lvITATzvQVUWfBrxULh+Zq+PmDfkLE/o6H72m
         OOzw932zSr3fQ==
Date:   Tue, 15 Jun 2021 09:06:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org,
        bpf@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, kernel-team@fb.com,
        kuba@kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Abhishek Sagar <sagar.abhishek@gmail.com>, tglx@linutronix.de,
        X86 ML <x86@kernel.org>, yhs@fb.com
Subject: Re: [PATCH -tip v7 03/13] kprobes: treewide: Remove
 trampoline_address from kretprobe_trampoline_handler()
Message-Id: <20210615090626.f2b536ce7c5cf8b31264451c@kernel.org>
In-Reply-To: <1623685371.y5qy4nxer2.naveen@linux.ibm.com>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
        <162209757191.436794.12654958417415894884.stgit@devnote2>
        <1623685371.y5qy4nxer2.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 14 Jun 2021 21:16:26 +0530
"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:

> Hi Masami,
> 
> Masami Hiramatsu wrote:
> > Remove trampoline_address from kretprobe_trampoline_handler().
> > Instead of passing the address, kretprobe_trampoline_handler()
> > can use new kretprobe_trampoline_addr().
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Tested-by: Andrii Nakryik <andrii@kernel.org>
> > ---
> >  Changes in v3:
> >    - Remove wrong kretprobe_trampoline declaration from
> >      arch/x86/include/asm/kprobes.h.
> >  Changes in v2:
> >    - Remove arch_deref_entry_point() from comment.
> > ---
> >  arch/arc/kernel/kprobes.c          |    2 +-
> >  arch/arm/probes/kprobes/core.c     |    3 +--
> >  arch/arm64/kernel/probes/kprobes.c |    3 +--
> >  arch/csky/kernel/probes/kprobes.c  |    2 +-
> >  arch/ia64/kernel/kprobes.c         |    5 ++---
> >  arch/mips/kernel/kprobes.c         |    3 +--
> >  arch/parisc/kernel/kprobes.c       |    4 ++--
> >  arch/powerpc/kernel/kprobes.c      |    2 +-
> >  arch/riscv/kernel/probes/kprobes.c |    2 +-
> >  arch/s390/kernel/kprobes.c         |    2 +-
> >  arch/sh/kernel/kprobes.c           |    2 +-
> >  arch/sparc/kernel/kprobes.c        |    2 +-
> >  arch/x86/include/asm/kprobes.h     |    1 -
> >  arch/x86/kernel/kprobes/core.c     |    2 +-
> >  include/linux/kprobes.h            |   18 +++++++++++++-----
> >  kernel/kprobes.c                   |    3 +--
> >  16 files changed, 29 insertions(+), 27 deletions(-)
> > 
> 
> <snip>
> 
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index d65c041b5c22..65dadd4238a2 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -205,15 +205,23 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
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
> > +	return dereference_function_descriptor(kretprobe_trampoline);
> 
> I'm afraid this won't work correctly. For kernel functions, please use 
> dereference_kernel_function_descriptor() which checks if the function 
> has a descriptor before dereferencing it.

Oops, there is *kernel_function* version, I didn't notice that.
Thank you for reviewing! I'll fix that.

> 
> 
> Thanks,
> Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
