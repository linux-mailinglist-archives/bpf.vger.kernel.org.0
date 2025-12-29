Return-Path: <bpf+bounces-77467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950FCE6138
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 08:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB3A53005E99
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D82D5416;
	Mon, 29 Dec 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rRyX1MbD"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739412D2384
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992011; cv=none; b=ByhdyGpNWp7UpxoQw0k+EDY8Uhlr9eQxEjKJuLo5acbTKddLEyUa1Lc6gj4eu/WuJAMCPQ70sls6qSCGBQ+6dQLLSfIU5VmcEyjR31ELI3ixFqmnjWH1hjlZ81XL8eaGEdNXKSeOPhveSSvn8qXkHndIiu6KboAEROoXNoQ1RMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992011; c=relaxed/simple;
	bh=WI8FHWlGOA0apArL90hv+or5DrLzqtQvm7rbFbZqsg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0DKj1CC9OEQe9oqUV1FfI9uc3LZddCfvcp+8tTLFBfUozajPGtvblJDZtasDIiKPHKQ4guKbbeacRsNePqaOZm37MrL03eYsrAkmgyH01oQCkvN082fdci3cN8mIS/qRjhPGf+iz9twIwvIPTZtlwA60wfgte79r71icgddW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rRyX1MbD; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Dec 2025 15:06:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766991995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7wYXeRdkMXIDCqoZ8ixYV6t3eQyv/SnG1ouQyq18Sg=;
	b=rRyX1MbDOz0al40sqpYvj65fYFxMBERpuGtKnyLbb7IRaLp4by+kNCctx1gtLzgkj0/joB
	LBEkH+UpOVhI5oYjsLdbCcp4KWoxebd1tGFKZtuZyhShV3HXDx7jj1y2qZdnIyvA05qKlG
	+DZ+7Tg2rYfu4a6tAhh/jT5TOf+zoFQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Guo <dongtai.guo@linux.dev>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman	 <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Tiezhu Yang	 <yangtiezhu@loongson.cn>, Hengqi Chen
 <hengqi.chen@gmail.com>, Huacai Chen	 <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Youling Tang	 <tangyouling@loongson.cn>,
 bpf@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>, Bing
 Huang	 <huangbing@kylinos.cn>
Subject: Re: [PATCH] LoongArch: BPF: Fix sign extension for 12-bit
 immediates
Message-ID: <20251229150619.0000195f@linux.dev>
In-Reply-To: <130f896382dc8f56ead371208d9809ec06c7400c.camel@xry111.site>
References: <20251103-1-v1-1-20e6641a57da@linux.dev>
	<130f896382dc8f56ead371208d9809ec06c7400c.camel@xry111.site>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 19 Dec 2025 17:33:17 +0800
Xi Ruoyao <xry111@xry111.site> wrote:

> On Mon, 2025-11-03 at 16:42 +0800, george wrote:
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
> >  arch/loongarch/net/bpf_jit.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/loongarch/net/bpf_jit.h
> > b/arch/loongarch/net/bpf_jit.h index
> > 5697158fd1645fdc3d83f598b00a9e20dfaa8f6d..f1398eb135b69ae61a27ed81f80b4bb0788cf0a0
> > 100644 --- a/arch/loongarch/net/bpf_jit.h +++
> > b/arch/loongarch/net/bpf_jit.h @@ -122,7 +122,8 @@ static inline
> > void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
> > /* addiw rd, $zero, imm_11_0 */ if (is_signed_imm12(imm)) {
> >  		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> > -		goto zext;
> > +		emit_sext_32(ctx, rd, is32);  
> 
> The addi.w instruction already produces the sign-extended value.  Why
> do we need to sign-extend it again?
> 
Hi Ruoyao,
I tried, it's not easy to do that. 
It's better merge this patch, then consider next step.

Thanks!

