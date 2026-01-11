Return-Path: <bpf+bounces-78492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A47D0E071
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 02:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 407EA300B6B4
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7111F4611;
	Sun, 11 Jan 2026 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcnFjEY7"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FBE1EF36E
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768096533; cv=none; b=WYiCJvRNZzWQc58e6aKQybulJ0JxP/as2nOAdaIN64FsWfsdvcDYog7JtAy8HQKaUntH7k+4VF3ofYTw6aOUgBKBb+l72IDOwNJgQKSNG6/f423+NU2pCeBm5MNB6dydOON6aORsA48mJvmlGLB33k5u03jIUfWuCCiBaGxfeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768096533; c=relaxed/simple;
	bh=xyAKM2qH6mR4SilETkaj33RNXFrNkJQhGxHK6tgGqns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbSTCrhaR6R/2/kTCb8mghuUnp3L+r+YXUIgaXXuyT9x75HxF8Dx9a2N+ZyoriTXIgPdR24gpjmyJOKe2mdsdhfgwo9MLsTYmKCSvBIp+V3dc1y7RoRITNf5ppEHnjV9BJh5TVZkf+i9IhHb0w/D2uBU9CnvL/oQdVGMK7CBiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcnFjEY7; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768096520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvQHbocNqZC5c16pNBSQv3SGQpCUORCgSh12YOLA3+k=;
	b=pcnFjEY7LL/4OU5wajjDNZJDj+/ea60YnIBPWIgUUeA43eBTLnlp5hXR7WLD+HgQ80UaJZ
	t36nZ8T899kuf1nCYKi8nTbmwfgXOlKPanYt4ELvGyWwiMdTYKbmGLhHfcndni/OGZVMVR
	8qUuvtgxrfxQGRjSpn00Lj9MAg6+2bE=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, andrii@kernel.org,
 bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
Date: Sun, 11 Jan 2026 09:54:57 +0800
Message-ID: <5959432.DvuYhMxLoT@7950hx>
In-Reply-To:
 <75ddb4013c7de3c454d564f3052afc81a0906226a17d75aa4301f750e3ef7723@mail.kernel.org>
References:
 <20260110141115.537055-6-dongml2@chinatelecom.cn>
 <75ddb4013c7de3c454d564f3052afc81a0906226a17d75aa4301f750e3ef7723@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/10 22:42, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 2640ec2157e1..a416050e0dd2 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1231,6 +1231,7 @@ enum {
> >
> >  #define BPF_TRAMP_M_NR_ARGS	0
> >  #define BPF_TRAMP_M_IS_RETURN	8
> > +#define BPF_TRAMP_M_COOKIE	9
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1b0292a03186..b91fd8af2393 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -22571,6 +22575,22 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
> >  		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
> >  		*cnt = 3;
> > +	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
> > +		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
> > +		/* inline bpf_session_cookie() for fsession:
> > +		 *   __u64 *bpf_session_cookie(void *ctx)
> > +		 *   {
> > +		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
> > +		 *       return &((u64 *)ctx)[-off];
> > +		 *   }
> > +		 */
> > +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_COOKIE);
> > +		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> > +		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> > +		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
> > +		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
>                         ^^^^^^^^
> 
> This inline code reads the cookie offset from (ctx[-1] >> 9) & 0xFF, but
> does the x86 trampoline actually store the cookie offset at bit position 9?
> 
> Looking at arch/x86/net/bpf_jit_comp.c in __arch_prepare_bpf_trampoline(),
> the trampoline stores nr_regs to the nregs_off location:
> 
>     emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
>     emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> 
> This sets ctx[-1] to a small value like 0x0000000000000006, with the high
> bits all zero. When the inline code executes:
> 
>     off = (ctx[-1] >> 9) & 0xFF  --> off = 0
> 
> The function then returns &ctx[-0] = ctx itself, which points to the
> function arguments instead of the session cookie.
> 
> Is there a missing dependency on a later commit in the series? Commit
> 983968c39241 ("bpf,x86: add fsession support for x86_64") appears to add
> the trampoline code that stores the cookie offset, but it comes after this
> commit in the patch series.

This is intentionally. The whole feature is partly architecture specific.
In this patch, we implement the common part, and in the
983968c39241 ("bpf,x86: add fsession support for x86_64"), we
implement the feature for x86_64.

If the current architecture doesn't implement this feature, the
fsession will not be usable, so this inline code will not be called,
which make sense.

Thanks!
Menglong Dong

> 
> > +		*cnt = 6;
> > +	}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20879693280
> 





