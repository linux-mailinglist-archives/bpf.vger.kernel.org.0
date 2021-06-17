Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683153AB62C
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFQOmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 10:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFQOmN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 10:42:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AB90610EA;
        Thu, 17 Jun 2021 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623940805;
        bh=DuloBXiAXa8E55JQLkThi/HShz77I2A5WiXoBs7eIts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=reA2Tf4N+00RWrxP7K1Q4/OHaaHuX8gp/oRgzh+Q90SVGjmeA2p/cwTddYQBlrDg/
         jmlIhElcOCMAF3VlJdjNDiplBTT6Rp0tNRyWnzZAOI5MmiZ36MK9auTnu75mH1j/L4
         IlqpAmMVb5Auy9BTgAdrrrxC683MaZBaDA+T/EddXaSNURctc8JA+kGU67zzMpQ6lj
         +//AcQ4z2CrSWDCub/3TAHX1goo4BztgflPeW4Iiky6b80cf7afLcTt8wbqDNXvUHb
         OVRxPdrbPC6YgQk9wW/IwhcVQgT0ZtcxiWEmTUyiZmipWM3x+G2eWFYxkQ0PMtTxnu
         FaCMmWryIp+2w==
Date:   Thu, 17 Jun 2021 23:40:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-Id: <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
In-Reply-To: <20210617044032.txng4enhiduacvt6@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
        <162209762943.436794.874947392889792501.stgit@devnote2>
        <20210617043909.fgu2lhnkxflmy5mk@treble>
        <20210617044032.txng4enhiduacvt6@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 16 Jun 2021 23:40:32 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Jun 16, 2021 at 11:39:11PM -0500, Josh Poimboeuf wrote:
> > On Thu, May 27, 2021 at 03:40:29PM +0900, Masami Hiramatsu wrote:
> > > To simplify the stacktrace with pt_regs from kretprobe handler,
> > > set the correct return address to the instruction pointer in
> > > the pt_regs before calling kretprobe handlers.
> > > 
> > > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Tested-by: Andrii Nakryik <andrii@kernel.org>
> > > ---
> > >  Changes in v3:
> > >   - Cast the correct_ret_addr to unsigned long.
> > > ---
> > >  kernel/kprobes.c |    3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index 54e5b89aad67..1598aca375c9 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -1914,6 +1914,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> > >  		BUG_ON(1);
> > >  	}
> > >  
> > > +	/* Set the instruction pointer to the correct address */
> > > +	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> > > +
> > >  	/* Run them. */
> > >  	first = current->kretprobe_instances.first;
> > >  	while (first) {
> > > 
> > 
> > Hi Masami,
> > 
> > I know I suggested this patch, but I believe it would only be useful in
> > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > think that would be tricky to pull off correctly.  Instead, we have
> > UNWIND_HINT_FUNC, which is working fine.
> > 
> > So I'd suggest dropping this patch, as the unwinder isn't actually
> > reading regs->ip after all.
> 
> ... and I guess this means patches 6-8 are no longer necessary.

OK, I also confirmed that dropping those patche does not make any change
on the stacktrace. 
Let me update the series without those. 

Thank you,

> 
> -- 
> Josh
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
