Return-Path: <bpf+bounces-75022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A0C6C35F
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 02:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC0F935A373
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76021B9C0;
	Wed, 19 Nov 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DpWckhKv"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33CD3BB44
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514332; cv=none; b=ufLrCVDwefAYIaPz5JK2phyCKaVkEvjCD32YIHFPAWouckewxmwhIxo5eBZ+PmUmVtUMi7EQhyMV5CdJy7wemlCmh/npjdH4C3auvzL2FUOi9CvW7fuZELEhdBAo45U+7TFRwa8ctSCjd1deMvYp1PaDiQTSWZrrdnd4QtU/Ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514332; c=relaxed/simple;
	bh=GQkI0Hm6hrKgqQua0+yCX2gkHCBglF3qw/TpNF74Ztc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPfWJGYG6Wxp+CaQqV6L4R53zvdWt7NT/47wGSZZ2UfNXw8iSLZMWmVUlm3IzGnH6pgAd9zHVTfJv+OY2BalEvSNYhpSe8Fl3oaLEJ9af9GrA35mbHZZktgwUTuFUY+mqxcx2njauV+HlrbZpeAFxLNhKD9YGNELDFdRSkGqPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DpWckhKv; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763514317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5wYqjeHoo9ER/PgwZoV292FvoOjlZcgdq1u9ZtOA74=;
	b=DpWckhKvp+NJ70lK6cM1cUHiFkfw0klwepF2GHTESo26Wp5O+O9nDpYRq+G0iOpqH+pU6I
	HmlMKJ7X0kShbsOQzGG9IKchODQ2gVsSIi48Ni5hpIS0aQg38C7SxjkRjnW+R1rDXMjB+O
	vEjAzp4GzfObRmpal/pcdTMkRiwSRMU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v3 2/6] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
Date: Wed, 19 Nov 2025 09:05:05 +0800
Message-ID: <5056669.31r3eYUQgx@7950hx>
In-Reply-To: <aRzs1GGLCm5svW5_@krava>
References:
 <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <20251118123639.688444-3-dongml2@chinatelecom.cn> <aRzs1GGLCm5svW5_@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/19 06:01, Jiri Olsa wrote:
> On Tue, Nov 18, 2025 at 08:36:30PM +0800, Menglong Dong wrote:
> > Implement the DYNAMIC_FTRACE_WITH_JMP for x86_64. In ftrace_call_replace,
> > we will use JMP32_INSN_OPCODE instead of CALL_INSN_OPCODE if the address
> > should use "jmp".
> > 
> > Meanwhile, adjust the direct call in the ftrace_regs_caller. The RSB is
> > balanced in the "jmp" mode. Take the function "foo" for example:
> > 
> >  original_caller:
> >  call foo -> foo:
> >          call fentry -> fentry:
> >                  [do ftrace callbacks ]
> >                  move tramp_addr to stack
> >                  RET -> tramp_addr
> >                          tramp_addr:
> >                          [..]
> >                          call foo_body -> foo_body:
> >                                  [..]
> >                                  RET -> back to tramp_addr
> >                          [..]
> >                          RET -> back to original_caller
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  arch/x86/Kconfig            |  1 +
> >  arch/x86/kernel/ftrace.c    |  7 ++++++-
> >  arch/x86/kernel/ftrace_64.S | 12 +++++++++++-
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index fa3b616af03a..462250a20311 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -230,6 +230,7 @@ config X86
> >  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
> >  	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
> >  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64
> >  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
> >  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
> >  	select HAVE_EBPF_JIT
> > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > index 4450acec9390..0543b57f54ee 100644
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -74,7 +74,12 @@ static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
> >  	 * No need to translate into a callthunk. The trampoline does
> >  	 * the depth accounting itself.
> >  	 */
> > -	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
> > +	if (ftrace_is_jmp(addr)) {
> > +		addr = ftrace_jmp_get(addr);
> > +		return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
> > +	} else {
> > +		return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
> > +	}
> >  }
> >  
> >  static int ftrace_verify_code(unsigned long ip, const char *old_code)
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 823dbdd0eb41..a132608265f6 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
> >  	ANNOTATE_NOENDBR
> >  	RET
> >  
> > +1:
> > +	testb	$1, %al
> > +	jz	2f
> > +	andq $0xfffffffffffffffe, %rax
> > +	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
> > +	restore_mcount_regs
> > +	/* Restore flags */
> > +	popfq
> > +	RET
> 
> is this hunk the reason for the 0x1 jmp-bit you set in the address?

Exactly!

> 
> I wonder if we introduced new flag in dyn_ftrace::flags for this,
> then we'd need to have extra ftrace trampoline for jmp ftrace_ops

We don't introduce new dyn_ftrace::flags. I tried to introduce
FTRACE_FL_JMP and FTRACE_FL_JMP_EN for this propose before I
added the jmp-bit to the address. It's hard to do it this way.

First, we need to introduce a ftrace_regs_jmp_caller, which will
be used for the "jmp" mode. However, it's difficult when we need
to change a call_address to jmp_address in __modify_ftrace_direct(),
as it will change the "entry->direct" directly. And maybe we need
reconstruct the direct call to implement it this way.

I were almost giving up before I thought the jmp-bit, which allow
us the update the address from call mode to jmp mode atomically.

Thanks!
Menglong Dong

> 
> jirka
> 
> 





