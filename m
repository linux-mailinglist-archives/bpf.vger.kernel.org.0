Return-Path: <bpf+bounces-77138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D8CCF1CE
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D08B4304B007
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D52F069D;
	Fri, 19 Dec 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P0cgSdvE"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0642C027B;
	Fri, 19 Dec 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136074; cv=none; b=FTl4qs+9PTQaIDz7zEHWQ+6+/3jwwNoYIhSkmhiBqWGTlgH/rsN42iM3BnWXdmqM/fmkBJ1atKXKXYPnd8GDQcpTOpAkkqsRYz0Chy+/+UxVBwDQHcTAUH6XrqZ/s4tbHGi1KDdf14yRfpFYRB/aE7zFr4xT+DUFyfz0ej4XrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136074; c=relaxed/simple;
	bh=tZbe5PciUf3wrKwje+TLFvO5/sos0oMgwqBkBReVCGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ul5urxwixBl09KLEAuhmOmHGAbRnkJmjpda2i9eqPg/8afjyZ7cgqmvO9OvTXwkVwGSQtEG11qDU553CM2vdf7MtfLry7z1a0Osqf/ckI+e/tL2fl7e7N6riF3z43KMlHi9LfSjye24mxjzXw734jWSDNVgDuEOwiMcA7/YzB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P0cgSdvE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 17:20:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766136052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN4kjXfQjmilgJ9oI88PPXhsYrF82KsW7VxcsgUA39Q=;
	b=P0cgSdvEKfP1l83gPvX3ax3zXL5cUIdjuRuKjX641I5EK/6ZqvFCV/cigDbYXMllQZpgKd
	iTczcu0Rq2DCNIChx1b+6OPWImLXPzPIa3+Q/X4wPwWT/owabyeDzwLzQfrNRZLs5G0xgc
	ru9cdbafbKb/yOEnHUWEp421XDm9hF8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Guo <dongtai.guo@linux.dev>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 bpf@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH] LoongArch: BPF: Fix sign extension for 12-bit
 immediates
Message-ID: <20251219172039.00007242@linux.dev>
In-Reply-To: <CAEyhmHQoLF9dcZ2CaasrpeH7RMiaQKyo0pFTrr7Nt1T64+dhuw@mail.gmail.com>
References: <20251103-1-v1-1-20e6641a57da@linux.dev>
	<CAEyhmHQoLF9dcZ2CaasrpeH7RMiaQKyo0pFTrr7Nt1T64+dhuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 4 Nov 2025 14:53:04 +0800
Hengqi Chen <hengqi.chen@gmail.com> wrote:

> On Mon, Nov 3, 2025 at 4:42 PM george <dongtai.guo@linux.dev> wrote:
> >
> > From: George Guo <guodongtai@kylinos.cn>
> >
> > When loading immediate values that fit within 12-bit signed range,
> > the move_imm function incorrectly used zero extension instead of
> > sign extension.
> >
> > The bug was exposed when scx_simple scheduler failed with -EINVAL
> > in ops.init() after passing node = -1 to scx_bpf_create_dsq().
> > Due to incorrect sign extension, `node >= (int)nr_node_ids`
> > evaluated to true instead of false, causing BPF program failure.
> >  
> 
> Which bpf prog are you referring to?

this bpf prog: ./tools/sched_ext/build/bin/scx_simple

> > Verified by testing with the scx_simple scheduler (located in
> > tools/sched_ext/). After building with `make` and running
> > ./tools/sched_ext/build/bin/scx_simple, the scheduler now
> > initializes successfully with this fix.
> >
> > Fix this by using sign extension (sext) instead of zero extension
> > for signed immediate values in move_imm.
> >
> > Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> > Reported-by: Bing Huang <huangbing@kylinos.cn>
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > ---
> > Signed-off-by: george <dongtai.guo@linux.dev>
> > ---
> >  arch/loongarch/net/bpf_jit.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.h
> > b/arch/loongarch/net/bpf_jit.h index
> > 5697158fd1645fdc3d83f598b00a9e20dfaa8f6d..f1398eb135b69ae61a27ed81f80b4bb0788cf0a0
> > 100644 --- a/arch/loongarch/net/bpf_jit.h +++
> > b/arch/loongarch/net/bpf_jit.h @@ -122,7 +122,8 @@ static inline
> > void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
> > /* addiw rd, $zero, imm_11_0 */ if (is_signed_imm12(imm)) {
> >                 emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> > -               goto zext;
> > +               emit_sext_32(ctx, rd, is32);
> > +               return;
> >         }  
> 
> This causes kernel panic on existing bpf selftests.
Hi Hengqi,
I tried there would kerenl panic even without the patch in kernle 6.18. 

The patch is needed, please consider merging it.

Thanks！
> >
> >         /* ori rd, $zero, imm_11_0 */
> >
> > ---
> > base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> > change-id: 20251103-1-96faa240e8f4
> >
> > Best regards,
> > --
> > george <dongtai.guo@linux.dev>
> >  


