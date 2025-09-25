Return-Path: <bpf+bounces-69651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE9BB9CE52
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD44E2E4C07
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CA527F732;
	Thu, 25 Sep 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXq1KQPi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A21397;
	Thu, 25 Sep 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760167; cv=none; b=K4l+517WWR50Kjo7FqpfrbECq950C5PnVjIzKfJZlwqI2KWc8P2WKZjGyRImDS+7Z0woREY5UWjzenqB6rkATIO0rVvfI+tUdr8LNxepc8aK9pw4uKi8/D7BSrrZ1BaAwV33lD241NAuHFAbTeOfrf/s80pXYLrUkOM+QZzIl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760167; c=relaxed/simple;
	bh=JUYEaLzxyG+KenfolO80NYZ50xZnpkoD1bMdpPXjErM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QULi1WVGOnjDp+FoSH46Z0aNSCTr/0o8MKe4loZ90JxugtkZXfvktQifrvorZ5CTUApzl+I3OqMtXfZc5Xp688XlCLjNE+Dm9ynhNf3ynsN/QoJvDNinQXFKO4HnsExhqVgNcspMdTbHMOu166voRHWh88YjAI2fkgDriaZvcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXq1KQPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8ACC4CEE7;
	Thu, 25 Sep 2025 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758760167;
	bh=JUYEaLzxyG+KenfolO80NYZ50xZnpkoD1bMdpPXjErM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WXq1KQPipdikAVghdweatNYBpp27vtIW9dXZTzfqGGuo2WYs/40Ss5Zi5oIfeIPYC
	 IFwO4Li82JUZCLDaQmsVZnvGvmuCT7RGQSVHlE72OwZrYFvsAfQHAHGXNWiJGkH1/M
	 A5nk7UnMhd4QlNXuAXzpM+ncgHDuSsa8W6sCnVA8UO6pP2bBa/1bSer8ccilLOBpI3
	 i8+DGqYI0NcB8JDI0PMdOFdLpwJod528vfMqs4lfQC1UXDdt+FuDyJAaD3rlbXtUMT
	 7831C8TXmLZqtt6WqIpGetkoX5exHOITy6Gr1jHTcMJhKBWUQbkklLdg8dbj+z8yiC
	 RDSN7DkPnWZrw==
Date: Wed, 24 Sep 2025 17:29:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2025-09-23
Message-ID: <20250924172924.72c85b24@kernel.org>
In-Reply-To: <35282ea2-7ccb-450a-aa78-491f2e84cbf3@linux.dev>
References: <20250924050303.2466356-1-martin.lau@linux.dev>
	<20250924151831.66c38c74@kernel.org>
	<35282ea2-7ccb-450a-aa78-491f2e84cbf3@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:09:52 -0700 Martin KaFai Lau wrote:
> On 9/24/25 3:18 PM, Jakub Kicinski wrote:
> > 74: (15) if r1 == 0x20 goto pc+309 384: frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R1=32 R2=0xfffffeff R3=scalar(smin=0xffffffff80000000,smax=0x7fffffff) R4=16 R5=1 R6=2 R7=ctx() R8=pkt(off=34,r=42) R9=scalar() R10=fp0 fp-336=mmmmmmmm
> > ; switch (*val) { @ xdp_native.bpf.c:594
> > 384: (b7) r4 = 32                     ; frame1: R4_w=32
> > 385: (05) goto pc+1
> > 387: (7b) *(u64 *)(r10 -352) = r5     ; frame1: R5=1 R10=fp0 fp-352_w=1
> > 388: (1f) r8 -= r9  
> 
> The "hdr_len = (void *)udph_ptr - data + sizeof(struct udphdr);" calculation 
> needs to reload the ctx->data after filter_udphdr(). Amery will send a fix.

Phew! no compiler update needed :) Thank you!

