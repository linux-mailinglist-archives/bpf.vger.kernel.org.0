Return-Path: <bpf+bounces-27399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3078ACBCE
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B4D1F24350
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEF41465A8;
	Mon, 22 Apr 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NIne9CeN"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC97145FEE;
	Mon, 22 Apr 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784484; cv=none; b=qOm5ErGn1jT1d3is0G1lBg+ymGLzdEaSfstfC1uVJjJ9StpQ6BMu9t2FG4U3l+/AezDz9Z/QbBs6fyQfpii14b3fFAOWljYtAFLuglO2AQjXgpqRQAEO7sq25jFO/rgfsmRFEZ/VNFCzdtRwUaaDoS+Cj+46EuiI2Ah/FTepHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784484; c=relaxed/simple;
	bh=FXfIV83VVaJ0iL2g9EUYsAMxdoqWaYsdzgRWn2e/4fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgq/oBL7UitElEpA0p2D0dwcORXIofiR3I7czuVDVn9uB+35iMg+Bbow6r6+LSvQYcIiu2qFBNpnyqIHnojG4Yx01Z0fAXajOqOqpp+hkpoFIJnFUrOAIztZFlzVakyBvYbP9OxDAddhO6m93afzlKw72hJXHTnVw44muCDDmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NIne9CeN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ps4xwJmPltrMDsDtm0ARPbw6o3LbHGD6iblKXCQrbew=; b=NIne9CeNIBp1lr6ZQwrVefLVq9
	xmUD/7ZveMf1rNC0ttJNfGiW5RiQOKHMKo+V5fHaIX5N9KnMBwFSBqNjSRJCkocn6s6DbWVGWGX41
	tlGpRNOMie77NGsXOfZnAqL2vUOZHn/18xtBnVSLacqKMuVpOTvtDWyyo/51E1Y2kt+Yh742hTp5J
	9GYEmC0qSUpz6HzymNzsIIjenub9CEt6KuRWWYzsqmovipWq7gVSarZ6Wax7o5MK0wwSZ/J8Nob8o
	7Yy7+z0laWtpFODH3EjMCv5e10xr07q9tEXj7M4ynUmb950onbtVi4Wr8poR54X66htQeVFqBXyYY
	Z+qaUg6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33624)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ryrcj-00032A-2j;
	Mon, 22 Apr 2024 12:14:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ryrcj-0002PU-O7; Mon, 22 Apr 2024 12:14:13 +0100
Date: Mon, 22 Apr 2024 12:14:13 +0100
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
Subject: Re: [PATCH bpf] arm32, bpf: reimplement sign-extension mov
 instruction
Message-ID: <ZiZGhVQx2ei/7Xlx@shell.armlinux.org.uk>
References: <20240419182832.27707-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419182832.27707-1-puranjay@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 19, 2024 at 06:28:32PM +0000, Puranjay Mohan wrote:
> The current implementation of the mov instruction with sign extension
> has the following problems:
> 
>   1. It clobbers the source register if it is not stacked because it
>      sign extends the source and then moves it to the destination.
>   2. If the dst_reg is stacked, the current code doesn't write the value
>      back in case of 64-bit mov.
>   3. There is room for improvement by emitting fewer instructions.
> 
> The steps for fixing this and the instructions emitted by the JIT are
> explained below with examples in all combinations:
> 
> Case A: offset == 32:
> =====================
>   Case A.1: src and dst are stacked registers:
>   --------------------------------------------
>     1. Load src_lo into tmp_lo
>     2. Store tmp_lo into dst_lo
>     3. Sign extend tmp_lo into tmp_hi
>     4. Store tmp_hi to dst_hi
> 
>     Example: r3 = (s32)r3
> 	r3 is a stacked register
> 
> 	ldr     r6, [r11, #-16]	// Load r3_lo into tmp_lo
> 	// str to dst_lo is not emitted because src_lo == dst_lo
> 	asr     r7, r6, #31	// Sign extend tmp_lo into tmp_hi
> 	str     r7, [r11, #-12] // Store tmp_hi into r3_hi
> 
>   Case A.2: src is stacked but dst is not:
>   ----------------------------------------
>     1. Load src_lo into dst_lo
>     2. Sign extend dst_lo into dst_hi
> 
>     Example: r6 = (s32)r3
> 	r6 maps to {ARM_R5, ARM_R4} and r3 is stacked
> 
> 	ldr     r4, [r11, #-16] // Load r3_lo into r6_lo
> 	asr     r5, r4, #31	// Sign extend r6_lo into r6_hi
> 
>   Case A.3: src is not stacked but dst is stacked:
>   ------------------------------------------------
>     1. Store src_lo into dst_lo
>     2. Sign extend src_lo into tmp_hi
>     3. Store tmp_hi to dst_hi
> 
>     Example: r3 = (s32)r6
> 	r3 is stacked and r6 maps to {ARM_R5, ARM_R4}
> 
> 	str     r4, [r11, #-16] // Store r6_lo to r3_lo
> 	asr     r7, r4, #31	// Sign extend r6_lo into tmp_hi
> 	str     r7, [r11, #-12]	// Store tmp_hi to dest_hi
> 
>   Case A.4: Both src and dst are not stacked:
>   -------------------------------------------
>     1. Mov src_lo into dst_lo
>     2. Sign extend src_lo into dst_hi
> 
>     Example: (bf) r6 = (s32)r6
> 	r6 maps to {ARM_R5, ARM_R4}
> 
> 	// Mov not emitted because dst == src
> 	asr     r5, r4, #31 // Sign extend r6_lo into r6_hi
> 
> Case B: offset != 32:
> =====================
>   Case B.1: src and dst are stacked registers:
>   --------------------------------------------
>     1. Load src_lo into tmp_lo
>     2. Sign extend tmp_lo according to offset.
>     3. Store tmp_lo into dst_lo
>     4. Sign extend tmp_lo into tmp_hi
>     5. Store tmp_hi to dst_hi
> 
>     Example: r9 = (s8)r3
> 	r9 and r3 are both stacked registers
> 
> 	ldr     r6, [r11, #-16] // Load r3_lo into tmp_lo
> 	lsl     r6, r6, #24	// Sign extend tmp_lo
> 	asr     r6, r6, #24	// ..
> 	str     r6, [r11, #-56] // Store tmp_lo to r9_lo
> 	asr     r7, r6, #31	// Sign extend tmp_lo to tmp_hi
> 	str     r7, [r11, #-52] // Store tmp_hi to r9_hi
> 
>   Case B.2: src is stacked but dst is not:
>   ----------------------------------------
>     1. Load src_lo into dst_lo
>     2. Sign extend dst_lo according to offset.
>     3. Sign extend tmp_lo into dst_hi
> 
>     Example: r6 = (s8)r3
> 	r6 maps to {ARM_R5, ARM_R4} and r3 is stacked
> 
> 	ldr     r4, [r11, #-16] // Load r3_lo to r6_lo
> 	lsl     r4, r4, #24	// Sign extend r6_lo
> 	asr     r4, r4, #24	// ..
> 	asr     r5, r4, #31	// Sign extend r6_lo into r6_hi
> 
>   Case B.3: src is not stacked but dst is stacked:
>   ------------------------------------------------
>     1. Sign extend src_lo into tmp_lo according to offset.
>     2. Store tmp_lo into dst_lo.
>     3. Sign extend src_lo into tmp_hi.
>     4. Store tmp_hi to dst_hi.
> 
>     Example: r3 = (s8)r1
> 	r3 is stacked and r1 maps to {ARM_R3, ARM_R2}
> 
> 	lsl     r6, r2, #24 	// Sign extend r1_lo to tmp_lo
> 	asr     r6, r6, #24	// ..
> 	str     r6, [r11, #-16] // Store tmp_lo to r3_lo
> 	asr     r7, r6, #31	// Sign extend tmp_lo to tmp_hi
> 	str     r7, [r11, #-12] // Store tmp_hi to r3_hi
> 
>   Case B.4: Both src and dst are not stacked:
>   -------------------------------------------
>     1. Sign extend src_lo into dst_lo according to offset.
>     2. Sign extend dst_lo into dst_hi.
> 
>     Example: r6 = (s8)r1
> 	r6 maps to {ARM_R5, ARM_R4} and r1 maps to {ARM_R3, ARM_R2}
> 
> 	lsl     r4, r2, #24	// Sign extend r1_lo to r6_lo
> 	asr     r4, r4, #24	// ..
> 	asr     r5, r4, #31	// Sign extend r6_lo to r6_hi
> 
> Fixes: fc832653fa0d ("arm32, bpf: add support for sign-extension mov instruction")
> Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000e9a8d80615163f2a@google.com/
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

This looks really great, thanks for putting in the extra effort!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

