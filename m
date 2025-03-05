Return-Path: <bpf+bounces-53394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE3A50C0C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088793B0837
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02502571C3;
	Wed,  5 Mar 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="RI+/h5ml"
X-Original-To: bpf@vger.kernel.org
Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BC2566D0;
	Wed,  5 Mar 2025 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204573; cv=none; b=qoc2sLc3KZi4LQ+XiVOvd497Y9pWr0x+N99EEI5xwMFYIDR1631vosDhq2Xt6Env+8oWPPzIpxutlous/3/B/B+4bU8vKwPsyTCc785tNzZo7FeuzrCrhMzpzJKb1ZdPCNVoOR8P/MoCmggFctQOFfLXtqaIWNkcXsv9rTQdwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204573; c=relaxed/simple;
	bh=WYEC+ArfSwlKN3FeDLKk0TQMOhpIceugzbJo5Kd8ysc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOXDGoKO3wFoPPW2tFyXpRI/TqTETtWJ7579ZLzZn4xwBSXlo8IaHb1+rQW98z3iaJfbxBDOc04Ilro2rBfx1vBscGkucTPpoUasQ3ir7kW2daScV360EdUAUpQvS5xLVwrwomA2MM0jvWq1+x20KRbdX/keP5LAvQYYdGYX+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=RI+/h5ml; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x0KQuzyFQUEThFLdYlVvZUJ1cH4hBNZAmoJdDiFksag=; b=RI+/h5mlwDs65E0J/YyCgTt05p
	a//6ia9q7THHUJjoOvsmkpQr52QzRjnYVtgNBGH+dTSvVXju2HjaUP30mnI4VLvlMfrNn9FnnhTmr
	+tv+B9/4GtcBM88IRfc6S0l7fbJXX/wnygN3l0PkoOx7ZlndkhxJAnvKBkjWP4Ckx3yk=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx11lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tpuDg-000000006hj-2m9f;
	Wed, 05 Mar 2025 20:15:53 +0100
Message-ID: <c0adcf60-4fb5-411f-84ef-e409cecf8a75@engleder-embedded.com>
Date: Wed, 5 Mar 2025 20:15:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
To: Joe Damato <jdamato@fastly.com>
Cc: vitaly.lifshits@intel.com, avigailx.dahan@intel.com,
 anthony.l.nguyen@intel.com, stable@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20250305180901.128286-1-jdamato@fastly.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250305180901.128286-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 05.03.25 19:09, Joe Damato wrote:
> In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
> queues were incorrectly unmapped from their NAPI instances. After
> discussion on the mailing list and the introduction of a test to codify
> the expected behavior, we can see that the unmapping causes the
> check_xsk test to fail:
> 
> NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py
> 
> [...]
>    # Check|     ksft_eq(q.get('xsk', None), {},
>    # Check failed None != {} xsk attr on queue we configured
>    not ok 4 queues.check_xsk
> 
> After this commit, the test passes:
> 
>    ok 4 queues.check_xsk
> 
> Note that the test itself is only in net-next, so I tested this change
> by applying it to my local net-next tree, booting, and running the test.
> 
> Cc: stable@vger.kernel.org
> Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_xdp.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
> index 13bbd3346e01..869815f48ac1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -86,7 +86,6 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
>   		napi_disable(napi);
>   	}
>   
> -	igc_set_queue_napi(adapter, queue_id, NULL);
>   	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>   	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
>   
> @@ -136,7 +135,6 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
>   	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
>   	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>   	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> -	igc_set_queue_napi(adapter, queue_id, napi);
>   
>   	if (needs_reset) {
>   		napi_enable(napi);
> 
> base-commit: 3c9231ea6497dfc50ac0ef69fff484da27d0df66

igc_set_queue_napi() could be made static as it only used within
igc_main.c after this change.

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

