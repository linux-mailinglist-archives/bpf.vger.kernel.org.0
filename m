Return-Path: <bpf+bounces-77144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F283CCF2A3
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC243067D33
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA02DCF6E;
	Fri, 19 Dec 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="TQ6n69mt"
X-Original-To: bpf@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6E2D7DDD;
	Fri, 19 Dec 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136817; cv=none; b=dvW/F848EoFOnf/z0jjY2AePeXRHnZ3dftvMzEEEnVELE7lK2G72CdVNdgCOV7uNic3PEESFuQtMwlvZ9b8C4b2COQ810Iz7qeke7RzWnCzOc/omBIwVVZ33c4MYlabicFO3t4iKkEdi3s5HHWvd4/PddXOhj0gRag8jmYSaUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136817; c=relaxed/simple;
	bh=D9nYmLSLDZXyDtSjVobaAnoY63elxp8sE2H3Mcvzq3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5G84Ow/HlxsXloKcXTEyjr+NqVhy/XHYIfE28/coRc7mOBKiV/ZCdCdc50cN/4AJdIWiTiEZdaIgL+w1/L/2CeaC6L1XVNfP12cD+uFCH6emX7ih4QiiH0VOeb9MQGqwz3NyIP+lW5dg5YI5BRvns7OAsNrGt8pk3HlyJwR6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=TQ6n69mt; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1766136805;
	bh=wVzUVVqTLkdAoDwnQSAhbIi3ug+hlCOq5+jkSTZA0rs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TQ6n69mtrPR+rDvg12SrotLgffnB6h+yC0WDEpYyD7rEzpXoyyC05x0NJ9vkll9c2
	 qmSp0EnfksvzZiZGFfODIv3au2RrLrXjgDa/xy1aaAZz+7Ss/nXkU9Bq2zHVd4cszt
	 IgmPUG+BFwP+mJNhXxDplOAsymbG+9W7y+E2S+ws=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 18D1B6725C;
	Fri, 19 Dec 2025 04:33:19 -0500 (EST)
Message-ID: <130f896382dc8f56ead371208d9809ec06c7400c.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: BPF: Fix sign extension for 12-bit immediates
From: Xi Ruoyao <xry111@xry111.site>
To: george <dongtai.guo@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Eduard
 Zingerman	 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Tiezhu Yang	
 <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, Huacai Chen	
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Youling Tang	
 <tangyouling@loongson.cn>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>, Bing
 Huang	 <huangbing@kylinos.cn>
Date: Fri, 19 Dec 2025 17:33:17 +0800
In-Reply-To: <20251103-1-v1-1-20e6641a57da@linux.dev>
References: <20251103-1-v1-1-20e6641a57da@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 16:42 +0800, george wrote:
> From: George Guo <guodongtai@kylinos.cn>
>=20
> When loading immediate values that fit within 12-bit signed range,
> the move_imm function incorrectly used zero extension instead of
> sign extension.
>=20
> The bug was exposed when scx_simple scheduler failed with -EINVAL
> in ops.init() after passing node =3D -1 to scx_bpf_create_dsq().
> Due to incorrect sign extension, `node >=3D (int)nr_node_ids`
> evaluated to true instead of false, causing BPF program failure.
>=20
> Verified by testing with the scx_simple scheduler (located in
> tools/sched_ext/). After building with `make` and running
> ./tools/sched_ext/build/bin/scx_simple, the scheduler now
> initializes successfully with this fix.
>=20
> Fix this by using sign extension (sext) instead of zero extension
> for signed immediate values in move_imm.
>=20
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Reported-by: Bing Huang <huangbing@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
> Signed-off-by: george <dongtai.guo@linux.dev>
> ---
> =C2=A0arch/loongarch/net/bpf_jit.h | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index 5697158fd1645fdc3d83f598b00a9e20dfaa8f6d..f1398eb135b69ae61a27ed81f=
80b4bb0788cf0a0 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -122,7 +122,8 @@ static inline void move_imm(struct jit_ctx *ctx, enum=
 loongarch_gpr rd, long imm
> =C2=A0	/* addiw rd, $zero, imm_11_0 */
> =C2=A0	if (is_signed_imm12(imm)) {
> =C2=A0		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> -		goto zext;
> +		emit_sext_32(ctx, rd, is32);

The addi.w instruction already produces the sign-extended value.  Why do
we need to sign-extend it again?

--=20
Xi Ruoyao <xry111@xry111.site>

