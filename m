Return-Path: <bpf+bounces-53489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54CA55175
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572F016B02F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C221D3EE;
	Thu,  6 Mar 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bezdeka.de header.i=@bezdeka.de header.b="q82kf6lm"
X-Original-To: bpf@vger.kernel.org
Received: from mx1.bezdeka.de (mx1.bezdeka.de [5.181.50.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185B2139B1;
	Thu,  6 Mar 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.181.50.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278911; cv=none; b=YY2Zv3Us3dCW2XCTJy3BMKZcpQpvnoULTOo3Hi37jFYz8C++iu3N21D9D9gQjQwAD6ss18fSjQ+F2kt355bjRW3u8pfppVgDqDFn6a/q4BCrM1rk5I1J8ozjb5H5sso6SKe4YqzEb9py9h+cMLP/dMN4bCjHDhtmghRAfK8ZXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278911; c=relaxed/simple;
	bh=ePQ8fgR2Ol+QBJmaiwdkBzfqyre62w0pV7VP0pAL7u4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kwqp1Tp7Odf8jZQuHRGtl38dHPR/576Pf0NM1lQT2WM0Nkwe0sbBQbi6GT54MVr9x0LmRQRo5FNOjgpS76/asaj2WO9jb8WY1lCboWyYbG4q3MYJ2FX44I1xxQ9sc9nRIYytplld60+e2tVPyfEPlzPzLjCl84EpdCCG2bWkPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bezdeka.de; spf=pass smtp.mailfrom=bezdeka.de; dkim=pass (2048-bit key) header.d=bezdeka.de header.i=@bezdeka.de header.b=q82kf6lm; arc=none smtp.client-ip=5.181.50.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bezdeka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bezdeka.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bezdeka.de;
	s=mail201812; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ymJP0/xT4dIjoC4+iVCO8nK9r0zha61bXHc9VHBaPaE=; b=q82kf6lmkojePCD/vKq+7R2b9x
	hPERb6d1DvIUomd/fFr413UpPHoUzGr4VNiV2eQWWv2bHVDC1z2nnWsvQYJ8Vd0Kquk4POca+xfHc
	h3r2ZKALCgGQwcWeoYRazNvmkHc9MGQGxZAnxbfql5zspztkug5CO8jvr7X6KS+sIwM/8EBpyur4x
	3C9Fsxmx6HCEZT41l9B3kxDHavchRFlHLG/who1WMViP+rtT28a3ae7Eq8Y2s/4Ce1rCTG5gCtqc2
	DdCyG6o1QWP0M+nT7jeYQ+eNapCxk+9Bu6Sp2454wN/ulEzhsYMoS7y8FRDUMbglRIkIjclZH+uCm
	Wc2SMazw==;
Received: from web5.bezdeka.de ([2a03:4000:6b:b6::1] helo=email.bezdeka.de)
	by smtp.bezdeka.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <florian@bezdeka.de>)
	id 1tqE4R-00Dch6-38;
	Thu, 06 Mar 2025 17:27:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 17:27:38 +0100
From: florian@bezdeka.de
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, vitaly.lifshits@intel.com,
 avigailx.dahan@intel.com, anthony.l.nguyen@intel.com,
 stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
In-Reply-To: <20250305180901.128286-1-jdamato@fastly.com>
References: <20250305180901.128286-1-jdamato@fastly.com>
Message-ID: <796726995fe2c0e895188862321a0de8@bezdeka.de>
X-Sender: florian@bezdeka.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-User: florian@bezdeka.de
X-Authenticator: login

Hi Joe,

On 2025-03-05 19:09, Joe Damato wrote:
> In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
> queues were incorrectly unmapped from their NAPI instances. After
> discussion on the mailing list and the introduction of a test to codify
> the expected behavior, we can see that the unmapping causes the
> check_xsk test to fail:
> 
> NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py
> 
> [...]
>   # Check|     ksft_eq(q.get('xsk', None), {},
>   # Check failed None != {} xsk attr on queue we configured
>   not ok 4 queues.check_xsk
> 
> After this commit, the test passes:
> 
>   ok 4 queues.check_xsk
> 
> Note that the test itself is only in net-next, so I tested this change
> by applying it to my local net-next tree, booting, and running the 
> test.
> 
> Cc: stable@vger.kernel.org
> Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_xdp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c
> b/drivers/net/ethernet/intel/igc/igc_xdp.c
> index 13bbd3346e01..869815f48ac1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -86,7 +86,6 @@ static int igc_xdp_enable_pool(struct igc_adapter 
> *adapter,
>  		napi_disable(napi);
>  	}
> 
> -	igc_set_queue_napi(adapter, queue_id, NULL);
>  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> 
> @@ -136,7 +135,6 @@ static int igc_xdp_disable_pool(struct igc_adapter
> *adapter, u16 queue_id)
>  	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
>  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> -	igc_set_queue_napi(adapter, queue_id, napi);
> 
>  	if (needs_reset) {
>  		napi_enable(napi);

That doesn't look correct to me. You removed both invocations of
igc_set_queue_napi() from igc_xdp.c. Where is the napi mapping now
done (in case XDP is enabled)?

To me it seems flipped. igc_xdp_enable_pool() should do the mapping
(previously did the unmapping) and igc_xdp_disable_pool() should do
the unmapping (previously did the mapping). No?

Btw: I got this patch via stable. It doesn't make sense to send it
to stable where this patch does not apply.

> 
> base-commit: 3c9231ea6497dfc50ac0ef69fff484da27d0df66

