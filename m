Return-Path: <bpf+bounces-67044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED2B3C519
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824345A53FF
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 22:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF22C11D2;
	Fri, 29 Aug 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1q1yefJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC32874F6;
	Fri, 29 Aug 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507198; cv=none; b=si2rjJtFIbO73Ave304HWGBkZT0+iKBxobeg2VxdCQWMr2JnxQmQ0ODefQYn7OVJqS9ea0TZNidW+f3yEoVgVjS0noamM6p+gqfcptDPyMUseQfnaGJginfDO5WqTFhhsTUQpIstHCT7tgHVc9BvPvBU80zjcrvaCyDP7FrYjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507198; c=relaxed/simple;
	bh=/dFVOutQ049ZKsF0GOUTUNJq1MoFTKksuVmpNbG7AwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC0Ddovkafp2myJr/zLt1ifoEI8s6a6hMN7Y8SgqhCp7dzWZaLUlRmxlVuxRN7j1Inaa2193UchorvUT56TNWM25k/X7P1sdK2FqMwDVLNsTym3YniKFk24r9xOTgf/tx/NI+d2nF1ezaiQTd6lRYNnC8+v9hksVIiQPV65f/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1q1yefJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EBEC4CEF0;
	Fri, 29 Aug 2025 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756507198;
	bh=/dFVOutQ049ZKsF0GOUTUNJq1MoFTKksuVmpNbG7AwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1q1yefJqXEokjlduDXUH9vjhf1YrWFOIdpeQhAPIDrAPfV95mjUWGtWb+GzRCU9a
	 Dou9d7MtxO+l/4t16SEMPCCMEjdiySwTAAHbbGxvC3EEHWraSOp7iMKsRITQUrpjL/
	 dQ9L5l6q4aFqOYqwq1pI54TuOz2yM57dGxJ148EelFUdsA3YDed5srSLA+nwaoVzfO
	 +ngAVMBbeF2sPzppbXrGaPICBgcmVD2ltu5a0d/L9IcegSbgOoXrf58ui5OzhqsRfG
	 9cLY/iGh2XECcgBkYM4FfAErP1aVitnvC8yl5ViARUzScRH7v5gzefjhfEtL18BnJ0
	 Al2KtxSMY41rA==
Date: Fri, 29 Aug 2025 15:39:57 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Message-ID: <aLIsPRq-1eX87NUq@x130>
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>

On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
>From: Christoph Paasch <cpaasch@openai.com>
>
>mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
>bytes from the page-pool to the skb's linear part. Those 256 bytes
>include part of the payload.
>
>When attempting to do GRO in skb_gro_receive, if headlen > data_offset
>(and skb->head_frag is not set), we end up aggregating packets in the
>frag_list.
>
>This is of course not good when we are CPU-limited. Also causes a worse
>skb->len/truesize ratio,...
>
>So, let's avoid copying parts of the payload to the linear part. We use
>eth_get_headlen() to parse the headers and compute the length of the
>protocol headers, which will be used to copy the relevant bits ot the
>skb's linear part.
>
>We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
>stack needs to call pskb_may_pull() later on, we don't need to reallocate
>memory.
>
>This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
>LRO enabled):
>
>BEFORE:
>=======
>(netserver pinned to core receiving interrupts)
>$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> 87380  16384 262144    60.01    32547.82
>
>(netserver pinned to adjacent core receiving interrupts)
>$ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> 87380  16384 262144    60.00    52531.67
>
>AFTER:
>======
>(netserver pinned to core receiving interrupts)
>$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> 87380  16384 262144    60.00    52896.06
>
>(netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> 87380  16384 262144    60.00    85094.90
>
>Additional tests across a larger range of parameters w/ and w/o LRO, w/
>and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
>TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
>better performance with this patch.
>
>Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>


