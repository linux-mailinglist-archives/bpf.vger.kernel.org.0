Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D03350C86
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 04:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhDACUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 22:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232763AbhDACT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 22:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 581F96101E;
        Thu,  1 Apr 2021 02:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617243595;
        bh=TBc2r00bRbjoWI5OI+E4Q5iVyqcKdlKmpAtKOk03Czc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E4MmUjjq/Jl8z0TJynah29oPYPpdc4ScpMPRJgPjgjWM+IOERYzUE7Ufup0vxx31k
         Sqr9lCm+p07v529O1vIZgY8CeHMYnhlOZ2sU9tAtAtedzib1n9q3vtlXRAL5Y1ySS5
         Vr8+t30g5WOEGbVxdykC9m798MnPd1Hul9joOOHoVvaajDDfLb0L4J8467FA87hA7x
         Ju0LkPcHHKS1QmHnrZ1S6Om/HfbPRPCJ00YfDAxptIGffbFMvBLUh1FWoa1p2qt2OW
         S0hfDYHoFCPuxAa5kqcxJILN0E0WrWMESYMAtcaEK5QPnAVlw6mjLn6edUSQIWKoWt
         W0I5TAPNU0ziQ==
Date:   Thu, 1 Apr 2021 11:19:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH -tip 3/3] x86/kprobes,orc: Unwind optprobe
 trampoline correctly
Message-Id: <20210401111950.79b61063e8c87d6a39ec371e@kernel.org>
In-Reply-To: <20210401104452.e442afd995d32afecf991301@kernel.org>
References: <161716946413.721514.4057380464113663840.stgit@devnote2>
        <161716949640.721514.14252504351086671126.stgit@devnote2>
        <20210331155736.qyuph7sgabmqqmq3@treble>
        <20210401104452.e442afd995d32afecf991301@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 1 Apr 2021 10:44:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 31 Mar 2021 10:57:36 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Wed, Mar 31, 2021 at 02:44:56PM +0900, Masami Hiramatsu wrote:
> > > +#ifdef CONFIG_UNWINDER_ORC
> > > +unsigned long recover_optprobe_trampoline(unsigned long addr, unsigned long *sp)
> > > +{
> > > +	unsigned long offset, entry, probe_addr;
> > > +	struct optimized_kprobe *op;
> > > +	struct orc_entry *orc;
> > > +
> > > +	entry = find_kprobe_optinsn_slot_entry(addr);
> > > +	if (!entry)
> > > +		return addr;
> > > +
> > > +	offset = addr - entry;
> > > +
> > > +	/* Decode arg1 and get the optprobe */
> > > +	op = (void *)extract_set_arg1((void *)(entry + TMPL_MOVE_IDX));
> > > +	if (!op)
> > > +		return addr;
> > > +
> > > +	probe_addr = (unsigned long)op->kp.addr;
> > > +
> > > +	if (offset < TMPL_END_IDX) {
> > > +		orc = orc_find((unsigned long)optprobe_template_func + offset);
> > > +		if (!orc || orc->sp_reg != ORC_REG_SP)
> > > +			return addr;
> > > +		/*
> > > +		 * Since optprobe trampoline doesn't push caller on the stack,
> > > +		 * need to decrement 1 stack entry size
> > > +		 */
> > > +		*sp += orc->sp_offset - sizeof(long);
> > > +		return probe_addr;
> > > +	} else {
> > > +		return probe_addr + offset - TMPL_END_IDX;
> > > +	}
> > > +}
> > > +#endif
> > 
> > Hm, I'd like to avoid intertwining kprobes and ORC like this.
> > 
> > ORC unwinds other generated code by assuming the generated code uses a
> > frame pointer.  Could we do that here?
> 
> No, because the optprobe is not a function call. I considered to make
> it call, but since it has to execute copied instructions directly on
> the trampoline code (without changing stack frame) it is not possible.
> 
> > With CONFIG_FRAME_POINTER, unwinding works because SAVE_REGS_STRING has
> > ENCODE_FRAME_POINTER, but that's not going to work for ORC.
> 
> Even in that case, the problem is that any interrupt can happen
> before doing ENCODE_FRAME_POINTER. I think this ENCODE_FRAME_POINTER
> in the SAVE_REGS_STRING is for probing right before the target
> function setup a frame pointer.
> 
> > Instead of these patches, can we 'push %rbp; mov %rsp, %rbp' at the
> > beginning of the template and 'pop %rbp' at the end?
> 
> No, since the trampoline code is not called, it is jumped into.
> This means there is no "return address" in the stack. If we setup
> the frame, there is no return address, thus it might stop there.
> (Moreover, optprobe can copy multiple instructins on trampoline
> buffer, since relative jump consumes 5bytes. where is the "return address"?)
> 
> > 
> > I guess SAVE_REGS_STRING would need to be smart enough to push the
> > original saved version of %rbp.  Of course then that breaks the
> > kretprobe_trampoline() usage, so it may need to be a separate macro.
> > 
> > [ Or make the same change to kretprobe_trampoline().  Then the other
> >   patch set wouldn't be needed either ;-) ]
> 
> Hmm, I don't think it is a good idea which making such change on the
> optimized (hot) path only for the stack tracing. Moreover, that maybe
> not transparent with the stack made by int3.
> 
> > Of course the downside is, when you get an interrupt during the frame
> > pointer setup, unwinding is broken.  But I think that's acceptable for
> > generated code.  We've lived with that limitation for all code, with
> > CONFIG_FRAME_POINTER, for many years.
> 
> But above code can fix such issue too. To fix a corner case, non-generic
> code may be required, even it is not so simple.

Hmm, I would like to confirm your policy on ORC unwinder. If it doesn't
care the stacktrace from the interrupt handler, I think your suggestion
is OK. But in that case, from a developer viewpoint, I need to recommend
users to configure CONFIG_UNWIND_FRAME=y when CONFIG_KPROBES=y.

> > Eventually we may want to have a way to register generated code (and the
> > ORC for it).

I see, but the generated code usually does not have a generic way to
handle it. E.g. bpf has a solid entry point, but kretprobe trampoline's
entry point is any "RET", optprobe trampoline's entry point is a jump
which is also generated (patched) ...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
