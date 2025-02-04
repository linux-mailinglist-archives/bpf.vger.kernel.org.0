Return-Path: <bpf+bounces-50434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53F4A2791F
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D121633ED
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E3216E17;
	Tue,  4 Feb 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MXlm2fWR"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB6216E0A;
	Tue,  4 Feb 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691782; cv=none; b=BU5NNYoXH1hH6n+dtLI4IM0tB0reBb8Tqrhg2EdpwCmzWdsdkV82bjKhWedkgK9VvQ7wjEpg4rJLR7q3FjDbVUGwQCwuscS39x/LqMO3IpjsrL9SOwG5473qII/yiI4hfIsysA4LI1f1wXJqfCmUFrlb5HZ8zpIUevtvzuVKt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691782; c=relaxed/simple;
	bh=3Ke5eagZV59IWXAgLydRewG6WgA9Rto97gmZt0jsBgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kUOYUcRKnT7I+V/19TcTApvRsuAR6b9EaMDBhtyB2dNjsbxWP0oDe8X4IuxY8jE/aiWed4nasoMxCTt9NdCHgR5kARbXxnO+VPQ3WJZ9eKVHKarCxT7yzWOCfVReTNgypks4Dy5V6EteaNb7AS2lbHGYeh9wMvXsNhhS7OmHmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MXlm2fWR; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 514HtllI3196784
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 4 Feb 2025 11:55:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738691747;
	bh=v/3toa1ComUbw9a49HidEIdUKwiCcGuMGyG57aTNhN8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MXlm2fWRMcTT683EB8AHaEpEbi3X/GV6Leem5ZoZK5wLMWTbJJ/rNymOiWkAj6WeR
	 At2s9AqpFwfZEAw+SPrjVnrhgxuqoE4552Hox+QNK2DcIQbVmylKoe86AsYdsc+xNh
	 AsZoTiNhOpPDe/xcgckk1D5kqt/GlZhyMXhOlWbE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 514HtlFm004039;
	Tue, 4 Feb 2025 11:55:47 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 11:55:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 11:55:47 -0600
Received: from [10.249.140.156] ([10.249.140.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 514HtdTZ063495;
	Tue, 4 Feb 2025 11:55:40 -0600
Message-ID: <f1cf5bfc-e767-4ced-9aad-76a578c53706@ti.com>
Date: Tue, 4 Feb 2025 23:25:39 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net 3/3] net: ti: icssg-prueth: Add AF_XDP
 support
To: Ido Schimmel <idosch@idosch.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <matthias.schiffer@ew.tq-group.com>, <dan.carpenter@linaro.org>,
        <rdunlap@infradead.org>, <diogo.ivo@siemens.com>,
        <schnelle@linux.ibm.com>, <glaroque@baylibre.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122124951.3072410-4-m-malladi@ti.com> <Z5J7kGFU_ZgneFAF@shredder>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <Z5J7kGFU_ZgneFAF@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 1/23/2025 10:55 PM, Ido Schimmel wrote:
> s/AF_XDP/XDP/ ? On Wed, Jan 22, 2025 at 06: 19: 51PM +0530, Meghana 
> Malladi wrote: > From: Roger Quadros <rogerq@ kernel. org> > > Add 
> native XDP support. We do not support zero copy yet. There are various 
> XDP features (e. g. , NETDEV_XDP_ACT_BASIC)
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> v9dnXbjPnQP15quJdjhJcrR0CoEiGINyhi1SO3vz-ZB8Sgif7YzLnG8ayC2XmAQz6g$>
> ZjQcmQRYFpfptBannerEnd
> 
> s/AF_XDP/XDP/ ?
> 

Will fix the typo.

> On Wed, Jan 22, 2025 at 06:19:51PM +0530, Meghana Malladi wrote:
>> From: Roger Quadros <rogerq@kernel.org>
>> 
>> Add native XDP support. We do not support zero copy yet.
> 
> There are various XDP features (e.g., NETDEV_XDP_ACT_BASIC) to tell the
> stack what the driver supports. I don't see any of them being set here.
> 

Ok, I will add the feature flags in the v2 patch series.

>> 
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> [...]
> 
>> +static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, int *xdp_state)
>>  {
>>  	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>>  	u32 buf_dma_len, pkt_len, port_id = 0;
>> @@ -560,10 +732,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>  	struct page *page, *new_page;
>>  	struct page_pool *pool;
>>  	struct sk_buff *skb;
>> +	struct xdp_buff xdp;
>>  	u32 *psdata;
>>  	void *pa;
>>  	int ret;
>>  
>> +	*xdp_state = 0;
>>  	pool = rx_chn->pg_pool;
>>  	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
>>  	if (ret) {
>> @@ -602,8 +776,17 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>  		goto requeue;
>>  	}
>>  
>> -	/* prepare skb and send to n/w stack */
>>  	pa = page_address(page);
>> +	if (emac->xdp_prog) {
>> +		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
>> +		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
>> +
>> +		*xdp_state = emac_run_xdp(emac, &xdp, page);
>> +		if (*xdp_state != ICSSG_XDP_PASS)
>> +			goto requeue;
>> +	}
>> +
>> +	/* prepare skb and send to n/w stack */
>>  	skb = build_skb(pa, prueth_rxbuf_total_len(pkt_len));
>>  	if (!skb) {
>>  		ndev->stats.rx_dropped++;
> 
> XDP program could have changed the packet length, but driver seems to be

This will be true given, emac->xdp_prog is not NULL. What about when XDP 
is not enabled ?

> building the skb using original length read from the descriptor.
> Consider using xdp_build_skb_from_buff()
> 


