Return-Path: <bpf+bounces-62254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B8AF72AB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601717AF245
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FD12E4995;
	Thu,  3 Jul 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfwugwhy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9222E4279;
	Thu,  3 Jul 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542868; cv=none; b=R8vG3bADVGHDqWWv2wNIBtsQwdaiAe+AKF+ahtaXLjUJ7eDf5zF8Dc0GiRB3jTxHYD4HqggAb95W0K42NOaLxdox2F/Ma4gT2iCuDe6oZ00r/u2+0lZ4bJyXsC3rxP7PdciXqrQo2QZVYHhso9kHJRYMMJGhQBVYx/sDdmSLHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542868; c=relaxed/simple;
	bh=FzrFno3HDT5rbQBIfWlmtU7HWlWzFpzClCAfuDmDn8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uu4nxDWHaoLPOpwDqgFTbNdVD/Y9/eNhywXJItWv0TP8A/JT/TrUjFik/tFhI08dPwkUqNCS8coL+FDerlejqCDSO/6t7S/55Nwfb9qFzSP/6A1L9qRxole3EFr+r2XV6Pol9Wl3XCUoBsI8duMx5AAizTFr4BepsGR2Y1Yhk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zfwugwhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D6EC4CEED;
	Thu,  3 Jul 2025 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751542867;
	bh=FzrFno3HDT5rbQBIfWlmtU7HWlWzFpzClCAfuDmDn8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zfwugwhy+wdUYhl0Hn1UAGuI5Yv+lNiEl2TS7y44hhXj1CvHNeHJDsrom/w45CPZf
	 zICPUqWdSDWo7J2Z/KICMUtcD7Uf1uPCgCUY4Nx6M+9D2APF0P5IcgJ0PDwSjnqBsC
	 5obInYBk+bi7bgMzwOtNfg/28fezmznd14w7eO98xZnuzk1SKwXx8es0cG8Lo7iU8q
	 JgH3KNwgKyP7WCPMtC81pHdRduJWmEO4Luhb/TUdHbxg5gunj/RmMlIDeXkTmKLFmr
	 F8G9R8I/1I41JwGAfgwT0W5aDDkYUL8zMfW6lTStsrgJ+FMiG/x06FOvfZEWFTMBQE
	 4jqLTesGt2ckw==
Message-ID: <85eee028-2784-4bcd-b9a9-9e1bdf0799f3@kernel.org>
Date: Thu, 3 Jul 2025 13:41:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 3/7] net: xdp: Add kfuncs to store hw metadata
 in xdp_buff
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <175146831297.1421237.17665319427079757435.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <175146831297.1421237.17665319427079757435.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/07/2025 16.58, Jesper Dangaard Brouer wrote:
> From: Lorenzo Bianconi<lorenzo@kernel.org>
> 
> Introduce the following kfuncs to store hw metadata provided by the NIC
> into the xdp_buff struct:
> 
> - rx-hash: bpf_xdp_store_rx_hash
> - rx-vlan: bpf_xdp_store_rx_vlan
> - rx-hw-ts: bpf_xdp_store_rx_ts
> 
> Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer<hawk@kernel.org>
> ---
>   include/net/xdp.h |    5 +++++
>   net/core/xdp.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index bd3110fc7ef8..1ffba57714ea 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -963,12 +963,57 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
[...]
> +__bpf_kfunc int bpf_xdp_store_rx_ts(struct xdp_md *ctx, u64 ts)
> +{
> +	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	struct skb_shared_hwtstamps *shwt = &sinfo->hwtstamps;
> +
> +	shwt->hwtstamp = ts;

Here we are storing into the SKB shared_info struct.  This is located at
the SKB data tail.  Thus, this will very likely cause a cache-miss.

What about storing it into xdp->rx_meta and then starting a prefetch for
shared_info?  (and updating patch-4 that moved it into SKB)

(Reviewers should be aware that writing into the xdp_frame headroom
(xdp->rx_meta) likely isn't a cache-miss, because all drivers does a
prefetchw for this memory prior to running BPF-prog).


> +	xdp->flags |= XDP_FLAGS_META_RX_TS;
> +
> +	return 0;
> +}

