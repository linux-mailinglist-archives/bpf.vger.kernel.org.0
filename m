Return-Path: <bpf+bounces-26307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE889DFB9
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7827CB37FD5
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4228D1369A4;
	Tue,  9 Apr 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UXu4Psta"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02C7C6D4;
	Tue,  9 Apr 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677289; cv=none; b=qPgs1skoWVrsJr66B+Qkda7hT1PGJkxJFMqTzgYuMUI/TRHS0gLpTzP3DnVRa7TpImIzhovLMbzxXhV9bOAMlvWnH43RJM7RwmmTJGMhIH9XXVGUQWLIdBhBHJnLYS1+2TBXrwvcvrW+PoxD+PplapBy/LbWqhX/+iDseq62jLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677289; c=relaxed/simple;
	bh=qhCYA/5Ka78x/AhOEj073SAa9gtAsUKx6yUxVJ3iM8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHczYvfysFOHbgSeGiUyNt7ORBh3GnDHi5t/rrR44bSqq0/pTOf2IqGiV7TKDziEi+j4iru5wLj3kGjxeC7Th4bLppv0PVjSePKek8C/QHMoRSgm/R+Mo9ThVKzeAatQFLy/3rK5f8tDjgAt3kCkdggaVQa7xxCIC/7rgLGs9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UXu4Psta; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=18Odz/5yLBDcln/iNt3WMBtL6a1+w4gU5ncEqjhL9JA=; b=UXu4PstavMyKGBNeMIrboZ3j4v
	pqIOaBALuH4pvMSA+AbjJcVpjVdejndi0OAob9ppo/Js8PcvGlFxAwoiJCi9+had5PB0bqJnaKK9q
	fzY5UuBysctH63R+sae+xUEAhrZ7hqejFahNaq/kVEZwmGqidRewDT5cAL8E4RLQO7bi1BIYROS09
	26eipawvX2yzStNDvL9+AJ7qzCCorEziCUp2OIzdBKifPgUuixDOovySr1ba/Y07ZHatPwGuqF1rV
	UHTPCrAbY+tMtFgqKcwYKT8PKLPTWKb0VKINq0AD9V+6KKszJtzT11xkoj7BEUBcSHci+Z1vbq4eX
	cDEHTCXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37506)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ruDai-0006ih-0B;
	Tue, 09 Apr 2024 16:40:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ruDah-0005Ad-Kb; Tue, 09 Apr 2024 16:40:55 +0100
Date: Tue, 9 Apr 2024 16:40:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay12@gmail.com
Subject: Re: [PATCH bpf] arm32, bpf: Fix sign-extension mov instruction
Message-ID: <ZhVhh3bDTQ+sks6b@shell.armlinux.org.uk>
References: <20240409095038.26356-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409095038.26356-1-puranjay@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 09, 2024 at 09:50:38AM +0000, Puranjay Mohan wrote:
> The current implementation of the mov instruction with sign extension
> clobbers the source register because it sign extends the source and then
> moves it to the destination.
> 
> Fix this by moving the src to a temporary register before doing the sign
> extension only if src is not an emulated register (on the scratch stack).
> 
> Also fix the emit_a32_movsx_r64() to put the register back on scratch
> stack if that register is emulated on stack.

It would be good to include in the commit message an example or two of
the resulting assembly code so that it's clear what the expected
generation is. Instead, I'm going to have to work it out myself, but
I'm quite sure this is information you already have.

> Fixes: fc832653fa0d ("arm32, bpf: add support for sign-extension mov instruction")
> Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000e9a8d80615163f2a@google.com/
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm/net/bpf_jit_32.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 1d672457d02f..8fde6ab66cb4 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -878,6 +878,13 @@ static inline void emit_a32_mov_r(const s8 dst, const s8 src, const u8 off,
>  
>  	rt = arm_bpf_get_reg32(src, tmp[0], ctx);
>  	if (off && off != 32) {
> +		/* If rt is not a stacked register, move it to tmp, so it doesn't get clobbered by
> +		 * the shift operations.
> +		 */
> +		if (rt == src) {
> +			emit(ARM_MOV_R(tmp[0], rt), ctx);
> +			rt = tmp[0];
> +		}

This change is adding inefficiency, don't we want to have the JIT
creating as efficient code as possible within the bounds of
reasonableness?

>  		emit(ARM_LSL_I(rt, rt, 32 - off), ctx);
>  		emit(ARM_ASR_I(rt, rt, 32 - off), ctx);

LSL and ASR can very easily take a different source register to the
destination register. All this needs to be is:

		emit(ARM_LSL_I(tmp[0], rt, 32 - off), ctx);
		emit(ARM_ASR_I(tmp[0], tmp[0], 32 - off), ctx);
		rt = tmp[0];

This will generate:

		lsl	tmp[0], src, #32-off
		asr	tmp[0], tmp[0], #32-off

and then the store to the output register will occur.

What about the high-32 bits of the register pair - should that be
taking any value?

>  	}

I notice in passing that the comments are out of sync with the
code - please update the comments along with code changes.

> @@ -919,15 +926,15 @@ static inline void emit_a32_movsx_r64(const bool is64, const u8 off, const s8 ds
>  	const s8 *tmp = bpf2a32[TMP_REG_1];
>  	const s8 *rt;
>  
> -	rt = arm_bpf_get_reg64(dst, tmp, ctx);
> -
>  	emit_a32_mov_r(dst_lo, src_lo, off, ctx);
>  	if (!is64) {
>  		if (!ctx->prog->aux->verifier_zext)
>  			/* Zero out high 4 bytes */
>  			emit_a32_mov_i(dst_hi, 0, ctx);
>  	} else {
> +		rt = arm_bpf_get_reg64(dst, tmp, ctx);
>  		emit(ARM_ASR_I(rt[0], rt[1], 31), ctx);
> +		arm_bpf_put_reg64(dst, rt, ctx);
>  	}
>  }

Why oh why oh why are we emitting code to read the source register
(which may be a load), then write it to the destination (which may
be a store) to only then immediately reload from the destination
to then do the sign extension? This is madness.

Please... apply some thought to the code generation from the JIT...
or I will remove you from being a maintainer of this code. I spent
time crafting some parts of the JIT to generate efficient code and
I'm seeing that a lot of that work is now being thrown away by
someone who seemingly doesn't care about generating "good" code.

Why not read the source 32-bit register (potentially into a temporary
register), store it to the destination low register, then do the
sign extension into the destination high register or zero the high
register. We _could_ be a bit more optimal here by checking whether
dst_hi is a stacked register and use that directly for the ASR
instruction, omitting the need to move it there afterwards - whether
that's worth it or not depends on the performance we expect from this
eBPF opcode.

	rt = arm_bpf_get_reg32(src_lo, tmp[1], ctx);
	/* rt may be either src[1] or tmp[1] */

	/* write dst_lo */
	arm_bpf_put_reg32(dst_lo, rt, ctx)

	if (is64) {
		emit(ARM_ASR_I(tmp[0], rt, 31), ctx);
		arm_bpf_put_reg32(dst_hi, tmp[0], ctx);
	} else if (!ctx->prog->aux->verifier_zext) {
		emit_a32_mov_i(dst_hi, 0, ctx);
	}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

