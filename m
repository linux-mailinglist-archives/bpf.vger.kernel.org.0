Return-Path: <bpf+bounces-33528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D525D91E7E5
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 20:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3375AB2367B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03EE16F0D1;
	Mon,  1 Jul 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW+lKXo0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4418E16E882;
	Mon,  1 Jul 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859217; cv=none; b=fWs82wHzz/miTDXNOL+VGiPfVeWGOuz9osK7MzUIISrZYQUEqV9OVDADgIirajjizzY1LWMKdd+YvrhjzP3clgnY17DuLUUVjukUJYE/qm2oWu0cDg3M9l2kBzETXGLwKvsoC0uwiB9uXShb0VMcoLQ+ddNAeVdXRRn6Obh7yJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859217; c=relaxed/simple;
	bh=YWrBx29R0c65U4WFrfcrcQPdKQrnBF4uPKA/07DchZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvuP7aTPkqTJYPz0oHVayt4/C+uBoVFD87fYkUyAfFK8yK+urAf6FOWT6lrty2IAwIlHnkvs6L/KR+o2f0f/Rw4vGDHBa9QuPcatctNgyB3VdFuGBNzs2YkHOs01jPbeC3d/zHS1BAfq7h7MAXFXOqy4b4qfyXTVzWiLc6238Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW+lKXo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B6AC116B1;
	Mon,  1 Jul 2024 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719859216;
	bh=YWrBx29R0c65U4WFrfcrcQPdKQrnBF4uPKA/07DchZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aW+lKXo050uPeYsZjhdkenXFQf+s/CXnOpDVeYmhjxlrrI7rrFZuIqnwt3mxocRB2
	 A/BB3QcWm2PYeGlMD+1+SLCyrxZ+3NfQs9FPZuHv7KRJ9iyd2cbL2+H+hhI2JcedW3
	 pDyclZH8ieGJCcWCIMZAGgHVIvIXbaIzFxXGo1sGA2ViYO2KL8AlZ/2oxEEgkijcDt
	 2Dlnnx6f01SYDX0HgAB5z5Z4lYUeRlb+Gd+Fe410svHzqiiveo2bnl0NyzZIOVCwxh
	 uhRh0Tg0/R0MZLOYhK2OA3Z9GREgzWnIAA8vPdeiX/ZXTY/oZxD74Bp3zDlTemM5Ba
	 Sh9EHOsASbirA==
Date: Tue, 2 Jul 2024 00:04:23 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Masahiro Yamada <masahiroy@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 02/11] powerpc/ftrace: Unify 32-bit and 64-bit
 ftrace entry code
Message-ID: <hwit6chsxkrn57pbl7k4yx6eu62ao2im3dolm4kmgpprr5ljtm@w6denhl7xvj3>
References: <cover.1718908016.git.naveen@kernel.org>
 <f2d5d66d47b28474b6224613787757fed3e92d3d.1718908016.git.naveen@kernel.org>
 <D2E2T58ECN7G.1CFVM4AI1ZESG@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2E2T58ECN7G.1CFVM4AI1ZESG@gmail.com>

On Mon, Jul 01, 2024 at 06:57:12PM GMT, Nicholas Piggin wrote:
> On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> > On 32-bit powerpc, gcc generates a three instruction sequence for
> > function profiling:
> > 	mflr	r0
> > 	stw	r0, 4(r1)
> > 	bl	_mcount
> >
> > On kernel boot, the call to _mcount() is nop-ed out, to be patched back
> > in when ftrace is actually enabled. The 'stw' instruction therefore is
> > not necessary unless ftrace is enabled. Nop it out during ftrace init.
> >
> > When ftrace is enabled, we want the 'stw' so that stack unwinding works
> > properly. Perform the same within the ftrace handler, similar to 64-bit
> > powerpc.
> >
> > For 64-bit powerpc, early versions of gcc used to emit a three
> > instruction sequence for function profiling (with -mprofile-kernel) with
> > a 'std' instruction to mimic the 'stw' above. Address that scenario also
> > by nop-ing out the 'std' instruction during ftrace init.
> 
> Cool! Could 32-bit use the 2-insn sequence as well if it had
> -mprofile-kernel, out of curiosity?

Yes! It actually already does with the previous change to add support 
for -fpatchable-function-entry. Commit 0f71dcfb4aef ("powerpc/ftrace: 
Add support for -fpatchable-function-entry") changelog describes this:

    This changes the profiling instructions used on ppc32. The default -pg
    option emits an additional 'stw' instruction after 'mflr r0' and before
    the branch to _mcount 'bl _mcount'. This is very similar to the original
    -mprofile-kernel implementation on ppc64le, where an additional 'std'
    instruction was used to save LR to its save location in the caller's
    stackframe. Subsequently, this additional store was removed in later
    compiler versions for performance reasons. The same reasons apply for
    ppc32 so we only patch in a 'mflr r0'.


> 
> >
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> >  arch/powerpc/kernel/trace/ftrace.c       | 6 ++++--
> >  arch/powerpc/kernel/trace/ftrace_entry.S | 4 ++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
> > index d8d6b4fd9a14..463bd7531dc8 100644
> > --- a/arch/powerpc/kernel/trace/ftrace.c
> > +++ b/arch/powerpc/kernel/trace/ftrace.c
> > @@ -241,13 +241,15 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> >  		/* Expected sequence: 'mflr r0', 'stw r0,4(r1)', 'bl _mcount' */
> >  		ret = ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
> >  		if (!ret)
> > -			ret = ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)));
> > +			ret = ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)),
> > +						 ppc_inst(PPC_RAW_NOP()));
> >  	} else if (IS_ENABLED(CONFIG_MPROFILE_KERNEL)) {
> >  		/* Expected sequence: 'mflr r0', ['std r0,16(r1)'], 'bl _mcount' */
> >  		ret = ftrace_read_inst(ip - 4, &old);
> >  		if (!ret && !ppc_inst_equal(old, ppc_inst(PPC_RAW_MFLR(_R0)))) {
> >  			ret = ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
> > -			ret |= ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, 16)));
> > +			ret |= ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, 16)),
> > +						  ppc_inst(PPC_RAW_NOP()));
> 
> So this is the old style path... Should you check the mflr validate
> result first? Also do you know what GCC version, roughly? Maybe we
> could have a comment here and eventually deprecate it.

Sure, this is gcc v5.5 for sure. gcc v6.3 doesn't seem to emit the 
additional 'std' instruction.

> 
> You could split this change into its own patch.

Indeed. I will do that.

> 
> >  		}
> >  	} else {
> >  		return -EINVAL;
> > diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
> > index 76dbe9fd2c0f..244a1c7bb1e8 100644
> > --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> > +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> > @@ -33,6 +33,8 @@
> >   * and then arrange for the ftrace function to be called.
> >   */
> >  .macro	ftrace_regs_entry allregs
> > +	/* Save the original return address in A's stack frame */
> > +	PPC_STL		r0, LRSAVE(r1)
> >  	/* Create a minimal stack frame for representing B */
> >  	PPC_STLU	r1, -STACK_FRAME_MIN_SIZE(r1)
> >  
> > @@ -44,8 +46,6 @@
> >  	SAVE_GPRS(3, 10, r1)
> >  
> >  #ifdef CONFIG_PPC64
> > -	/* Save the original return address in A's stack frame */
> > -	std	r0, LRSAVE+SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE(r1)
> >  	/* Ok to continue? */
> >  	lbz	r3, PACA_FTRACE_ENABLED(r13)
> >  	cmpdi	r3, 0
> 
> That seems right to me.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Naveen

