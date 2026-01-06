Return-Path: <bpf+bounces-77909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E279ECF6642
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 02:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 680E6302BF6C
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 01:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B95224B0E;
	Tue,  6 Jan 2026 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZhKOGEwT"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC511D5160
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664671; cv=none; b=TLzKRSFnsQT/r0wI/2t6TSb8u5iRSeqqSBgyMKwhq8Qh6FUGsId0vg3hD3goEn7UViKqxDFYs4urnsIp4SALIF0hgzbCbvu9m9U9MiREDo3Th2KmZnyoPZ8AT2Qlykcx66nQWpK20VL6vuQlcb14H9feZf/FfoiUn/S6p7TyDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664671; c=relaxed/simple;
	bh=XDT3YsSndGZ3dT6mtYQIgkaBur370JJH1rruyrfiZMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8CnhL+k/lljSnnbX2G1Gmn6zIMMuus4ZxhsB7faff2X4dkCa9Zw9ruv+Gt/FV8o0VeNthgv+/x8ztrHtALBmhqffXA5qbfsnI3EafbtGtt6+ckAkSFo20tndPbAbLbii0XvEO8kzz/Qv7olvluSZXH8ljjaTAhnxbR+TZb0TsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZhKOGEwT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767664657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b5QfZCkossx3RfNN0wl6K3wnugBDe1dp1/qX9Ix0/s=;
	b=ZhKOGEwTdZwp0QmvljAwBVoBkZBvc0uo/iZDPnnoolGEfXN945R//rRIlLq6VupDBMexDm
	pMd5NTFsE4jTpRUg9FXqA1T+cQbrxAxF6XNAY0kbZhRXXaLic83holRXxGjHaIi3hDHmDj
	Cf2obCt1dSc34/l+x8sgfs24DrO62zU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Tue, 06 Jan 2026 09:57:25 +0800
Message-ID: <4704048.LvFx2qVVIh@7940hx>
In-Reply-To: <08ab237ad7da8d1f6494cb434d9a5a46a599462c.camel@gmail.com>
References:
 <20260104131635.27621-1-dongml2@chinatelecom.cn>
 <20260104131635.27621-2-dongml2@chinatelecom.cn>
 <08ab237ad7da8d1f6494cb434d9a5a46a599462c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/6 01:45 Eduard Zingerman <eddyz87@gmail.com> write:
> On Sun, 2026-01-04 at 21:16 +0800, Menglong Dong wrote:
> > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> > to obtain better performance. The instruction we use here is:
> > 
> >   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - check the variable type in emit_ldx_percpu_r0 with __verify_pcpu_ptr
> > - remove the usage of const_current_task
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index e3b1c4b1d550..f5ff7c77aad7 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1300,6 +1300,25 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
> >  	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
> >  }
> >  
> > +static void __emit_ldx_percpu_r0(u8 **pprog, __force unsigned long ptr)
> > +{
> > +	u8 *prog = *pprog;
> > +
> > +	/* mov rax, gs:[ptr] */
> > +	EMIT2(0x65, 0x48);
> > +	EMIT2(0x8B, 0x04);
> > +	EMIT1(0x25);
> > +	EMIT((u32)ptr, 4);
> > +
> > +	*pprog = prog;
> > +}
> > +
> > +#define emit_ldx_percpu_r0(prog, variable)					\
> > +	do {									\
> > +		__verify_pcpu_ptr(&(variable));					\
> > +		__emit_ldx_percpu_r0(&prog, (__force unsigned long)&(variable));\
> > +	} while (0)
> > +
> >  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
> >  			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
> >  {
> > @@ -2441,6 +2460,12 @@ st:			if (is_imm8(insn->off))
> >  		case BPF_JMP | BPF_CALL: {
> >  			u8 *ip = image + addrs[i - 1];
> >  
> > +			if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
> > +						   insn->imm == BPF_FUNC_get_current_task_btf)) {
> 
> I think this should be guarded by IS_ENABLED(CONFIG_SMP).
> The current.h:get_current() used
> arch/x86/include/asm/percpu.h:this_cpu_read_stable() that is unrolled
> to __raw_cpu_read_stable(), which uses __force_percpu_arg(), which uses
> __force_percpu_prefix, which is defined differently depending on CONFIG_SMP.

Yeah, I missed this part. I'll use BPF_MOV64_PERCPU_REG() in
the next version, which should avoid this problem.

Thanks!
Menglong Dong

> 
> > +				emit_ldx_percpu_r0(prog, current_task);
> > +				break;
> > +			}
> > +
> >  			func = (u8 *) __bpf_call_base + imm32;
> >  			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
> >  				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> > @@ -4082,3 +4107,14 @@ bool bpf_jit_supports_timed_may_goto(void)
> >  {
> >  	return true;
> >  }
> > +
> > +bool bpf_jit_inlines_helper_call(s32 imm)
> > +{
> > +	switch (imm) {
> > +	case BPF_FUNC_get_current_task:
> > +	case BPF_FUNC_get_current_task_btf:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> 





