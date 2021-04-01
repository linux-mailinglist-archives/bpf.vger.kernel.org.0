Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAF350C10
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 03:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhDABpa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 21:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhDABo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 21:44:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 826F160FE9;
        Thu,  1 Apr 2021 01:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617241498;
        bh=6uAZf7jnS4WPD6/B+kSOrMJE0qkekO89/Q0nhpXiQ2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H763UPfOd5WptWDE3TKkg8T7g9iOn46oHu6L+1MxxNlyWu/Kp2e0qxo/14pnDlgm+
         iJkWoK3x3zM3GD2Wnyw2lSG2ijTCs4bKSg1eMs2YYfRjMwq8MYNRKvjryqmxJcOq34
         0QU10E2uV8aLkmtWrciKjBn5JAwdFmQUf2ojEuiSn5rG3XE3VKeuWABNAYPKlcEDZg
         Cs4CfdMr9spK1JfcnDWL1+Olvw9z0PW/03O0XH6T4YLowqQC+7ltFxTbUioU601joG
         r5dMUpFfkiCKRxxHME851MT6NsfCGGaRf2/yXzmYLXGE0vcOd3/+sNx9N6Hz57efFj
         hiZRgn8crKfgw==
Date:   Thu, 1 Apr 2021 10:44:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH -tip 3/3] x86/kprobes,orc: Unwind optprobe
 trampoline correctly
Message-Id: <20210401104452.e442afd995d32afecf991301@kernel.org>
In-Reply-To: <20210331155736.qyuph7sgabmqqmq3@treble>
References: <161716946413.721514.4057380464113663840.stgit@devnote2>
        <161716949640.721514.14252504351086671126.stgit@devnote2>
        <20210331155736.qyuph7sgabmqqmq3@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 31 Mar 2021 10:57:36 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Mar 31, 2021 at 02:44:56PM +0900, Masami Hiramatsu wrote:
> > +#ifdef CONFIG_UNWINDER_ORC
> > +unsigned long recover_optprobe_trampoline(unsigned long addr, unsigned long *sp)
> > +{
> > +	unsigned long offset, entry, probe_addr;
> > +	struct optimized_kprobe *op;
> > +	struct orc_entry *orc;
> > +
> > +	entry = find_kprobe_optinsn_slot_entry(addr);
> > +	if (!entry)
> > +		return addr;
> > +
> > +	offset = addr - entry;
> > +
> > +	/* Decode arg1 and get the optprobe */
> > +	op = (void *)extract_set_arg1((void *)(entry + TMPL_MOVE_IDX));
> > +	if (!op)
> > +		return addr;
> > +
> > +	probe_addr = (unsigned long)op->kp.addr;
> > +
> > +	if (offset < TMPL_END_IDX) {
> > +		orc = orc_find((unsigned long)optprobe_template_func + offset);
> > +		if (!orc || orc->sp_reg != ORC_REG_SP)
> > +			return addr;
> > +		/*
> > +		 * Since optprobe trampoline doesn't push caller on the stack,
> > +		 * need to decrement 1 stack entry size
> > +		 */
> > +		*sp += orc->sp_offset - sizeof(long);
> > +		return probe_addr;
> > +	} else {
> > +		return probe_addr + offset - TMPL_END_IDX;
> > +	}
> > +}
> > +#endif
> 
> Hm, I'd like to avoid intertwining kprobes and ORC like this.
> 
> ORC unwinds other generated code by assuming the generated code uses a
> frame pointer.  Could we do that here?

No, because the optprobe is not a function call. I considered to make
it call, but since it has to execute copied instructions directly on
the trampoline code (without changing stack frame) it is not possible.

> With CONFIG_FRAME_POINTER, unwinding works because SAVE_REGS_STRING has
> ENCODE_FRAME_POINTER, but that's not going to work for ORC.

Even in that case, the problem is that any interrupt can happen
before doing ENCODE_FRAME_POINTER. I think this ENCODE_FRAME_POINTER
in the SAVE_REGS_STRING is for probing right before the target
function setup a frame pointer.

> Instead of these patches, can we 'push %rbp; mov %rsp, %rbp' at the
> beginning of the template and 'pop %rbp' at the end?

No, since the trampoline code is not called, it is jumped into.
This means there is no "return address" in the stack. If we setup
the frame, there is no return address, thus it might stop there.
(Moreover, optprobe can copy multiple instructins on trampoline
buffer, since relative jump consumes 5bytes. where is the "return address"?)

> 
> I guess SAVE_REGS_STRING would need to be smart enough to push the
> original saved version of %rbp.  Of course then that breaks the
> kretprobe_trampoline() usage, so it may need to be a separate macro.
> 
> [ Or make the same change to kretprobe_trampoline().  Then the other
>   patch set wouldn't be needed either ;-) ]

Hmm, I don't think it is a good idea which making such change on the
optimized (hot) path only for the stack tracing. Moreover, that maybe
not transparent with the stack made by int3.

> Of course the downside is, when you get an interrupt during the frame
> pointer setup, unwinding is broken.  But I think that's acceptable for
> generated code.  We've lived with that limitation for all code, with
> CONFIG_FRAME_POINTER, for many years.

But above code can fix such issue too. To fix a corner case, non-generic
code may be required, even it is not so simple.

> 
> Eventually we may want to have a way to register generated code (and the
> ORC for it).
> 
> -- 
> Josh
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
