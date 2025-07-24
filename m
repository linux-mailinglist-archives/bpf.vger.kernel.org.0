Return-Path: <bpf+bounces-64227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE815B0FE20
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 02:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A161CC73E9
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32876F9C1;
	Thu, 24 Jul 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDWZ22Op"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2B4430;
	Thu, 24 Jul 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316389; cv=none; b=n2pOJA0nwPXNqWF+tzPIfTBdX67Uffu4lBiCKsdW5/aHxtWd9/L+OZ9DJS7PPrSJuWhMtKpTKdTonhbBI/eibU3r6Mudjvm6B5cDDUkaQUE/RfQZ4LE1LlQeanbR8xSaUcLmzSV1eWs287kTeSWEP7wA5LKLWBmXW0LzsVGHqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316389; c=relaxed/simple;
	bh=NtHxaMnN5aPuveNsuyUdcuILPJrVtVSf0qXi3bKHF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dN/3MBYhdzFLNHIQNMI/lotc1g0HNdHj+WPeiSzjI432v3hZKKKDMWv2ghmQ0OSwdKRNzzH+JNCiNY3ZK51ca+dKXZtD8VBOel+oFHQNjEiFtK8p8folv6hl+3wi1hHh2gPb8LPDgXzv0xVH4YxLmOQsXWIJqlY1YsI2F50f/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDWZ22Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD4BC4CEE7;
	Thu, 24 Jul 2025 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753316389;
	bh=NtHxaMnN5aPuveNsuyUdcuILPJrVtVSf0qXi3bKHF/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CDWZ22OpxTaQfb34su+edsg9+mDZy9BbyeKsWF2RRppprjH2vrNCfuuAOljkQVObA
	 Z/vPSSlcxUgpManz4hDTufyZ5t8zw5kCINf9XjrpCK8xPrMOANGbjokkNaSEUhFx8L
	 a+CsTVI6yD4AoZT4E7Kh+vPXYQWpmJaYJenz8Bh+XqD1DBQbsDoomKq9qwjHIrpLzV
	 Awbql54Mf0GIuIfuC+EEzzHWVB6HF/zx2bESvmwNkUicswxoxhhii61eW6MF/2mkcX
	 ALN9PBesmIsYesPJ5GtKHllzB4714FoKz+86/tj2maNTa18VUkWMb+HRvtTdKwE0SN
	 PQLglTEQPB4Dg==
Date: Wed, 23 Jul 2025 17:19:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <namcao@linutronix.de>, <jacob.e.keller@intel.com>, <sdf@fomichev.me>,
 <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
 <ast@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix skb handling for
 XDP_PASS
Message-ID: <20250723171947.76995990@kernel.org>
In-Reply-To: <20250721124918.3347679-1-m-malladi@ti.com>
References: <20250721124918.3347679-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 18:19:18 +0530 Meghana Malladi wrote:
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 12f25cec6255..a0e7def33e8e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -757,15 +757,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
>  		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
>  
>  		*xdp_state = emac_run_xdp(emac, &xdp, page, &pkt_len);
> -		if (*xdp_state == ICSSG_XDP_PASS)
> -			skb = xdp_build_skb_from_buff(&xdp);
> -		else
> +		if (*xdp_state != ICSSG_XDP_PASS)
>  			goto requeue;
> -	} else {
> -		/* prepare skb and send to n/w stack */
> -		skb = napi_build_skb(pa, PAGE_SIZE);
>  	}
>  
> +	/* prepare skb and send to n/w stack */
> +	skb = napi_build_skb(pa, PAGE_SIZE);
>  	if (!skb) {
>  		ndev->stats.rx_dropped++;
>  		page_pool_recycle_direct(pool, page);

I'm not sure this is correct. We seem to hardcode headroom to
PRUETH_HEADROOM lower in this function. If XDP adds or removes
network headers and then returns XDP_PASS we'll look for the packet 
at the wrong offset.

We just merged some XDP tests, could you try running 
tools/testing/selftests/drivers/net/xdp.py ? 
Some general instructions can be found here:
https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

Not sure how stable the test is for all NICs but I think the 
 xdp.test_xdp_native_adjst_head_grow_data
test case will exercise what I'm suspecting will fail.

