Return-Path: <bpf+bounces-43638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D39B78F0
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 11:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47889281FC3
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4FB199EAB;
	Thu, 31 Oct 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITg18VAY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641E196C6C;
	Thu, 31 Oct 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371558; cv=none; b=OtxYI3Dnm6LT7EEdALR6qnSX49FpXEhMYLYj7kmjUvk40UnrGxhx+lfX16wOxHl5eQ6Nl+F1CtabVuEY9tBIX8znu6N8mYYKtOwwAQsRhLg4XeleMQnKzMQTVi7y08FYa9og0MrZ4ahKF6n5yucWC9etZZ5GG7o402dbD2KrTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371558; c=relaxed/simple;
	bh=e3NwIyutMyokydHhlXvb6bTk6HTn9gNp/5ERXhD4/P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTnsjd4ZKj5sGvnDH1UvQlEh+Qo3cwFLl1F4ubeItfst0tqV19x/MnksQ5Hx7iMvvX3GDiFzUNQ9a8BaCG0+M3gXi/2nxkc/nslGq9qugt6igUS6QZllRZ29NYJm+aI3WFAUYl3L55Ywm+R9PVnDDYYJ6EBih56KJvxZ9H1e8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITg18VAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A24C4CEEB;
	Thu, 31 Oct 2024 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730371557;
	bh=e3NwIyutMyokydHhlXvb6bTk6HTn9gNp/5ERXhD4/P4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ITg18VAYGWK9YQMBF4+NYJ3EdIOswqwvpdpsRRZ3B2xBM4/QFdzqJSm5MAk1AsAmi
	 /Gx7w2MMBIXo655tTSMNGEx6GoM/aifRcr7SJW9ko12yaWVaa+pX9KlCHShoqC3y3q
	 1iDf+KnGaVY8mP97g87FohIrObzSzvZFRyVApo1Sh7XZT51pQt1V89eGaBdpXUd+OO
	 2QnZIzb0Chlg1/Jn5+4rBBjISZKDg08dvrcIuXCO2qtVB6Nwoxe2mDah8CSUx24Tsp
	 wzGPhAMOUSUGOWJeiGTxAiPR3znNeXM2qxuTw0OInIj3TVcvgtVsT3b93nM3aKoGyC
	 2mgjcCGmjE5fQ==
Message-ID: <6b7dd983-c948-4c54-b221-4dbf4a2f1bee@kernel.org>
Date: Thu, 31 Oct 2024 12:45:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix multi queue Rx
 on J7
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Md Danish Anwar <danishanwar@ti.com>,
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241030-am65-cpsw-multi-rx-j7-fix-v2-1-bc54087b0856@kernel.org>
 <20241030191738.5bd12ccc@fedora.home>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241030191738.5bd12ccc@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Maxime,

On 30/10/2024 20:17, Maxime Chevallier wrote:
> Hello Roger,
> 
> On Wed, 30 Oct 2024 15:53:58 +0200
> Roger Quadros <rogerq@kernel.org> wrote:
> 
>> On J7 platforms, setting up multiple RX flows was failing
>> as the RX free descriptor ring 0 is shared among all flows
>> and we did not allocate enough elements in the RX free descriptor
>> ring 0 to accommodate for all RX flows.
>>
>> This issue is not present on AM62 as separate pair of
>> rings are used for free and completion rings for each flow.
>>
>> Fix this by allocating enough elements for RX free descriptor
>> ring 0.
>>
>> However, we can no longer rely on desc_idx (descriptor based
>> offsets) to identify the pages in the respective flows as
>> free descriptor ring includes elements for all flows.
>> To solve this, introduce a new swdata data structure to store
>> flow_id and page. This can be used to identify which flow (page_pool)
>> and page the descriptor belonged to when popped out of the
>> RX rings.
> 
> [...]
> 
>> @@ -339,7 +339,7 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
>>  	struct device *dev = common->dev;
>>  	dma_addr_t desc_dma;
>>  	dma_addr_t buf_dma;
>> -	void *swdata;
>> +	struct am65_cpsw_swdata *swdata;
> 
> There's a reverse xmas-tree issue here, where variables should be
> declared from the longest line to the shortest.

Will fix.
> 
> [...]
> 
>>  static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
>>  {
>> -	struct am65_cpsw_rx_flow *flow = data;
>> +	struct am65_cpsw_rx_chn *rx_chn = data;
>>  	struct cppi5_host_desc_t *desc_rx;
>> -	struct am65_cpsw_rx_chn *rx_chn;
>> +	struct am65_cpsw_swdata *swdata;
>>  	dma_addr_t buf_dma;
>>  	u32 buf_dma_len;
>> -	void *page_addr;
>> -	void **swdata;
>> -	int desc_idx;
>> +	struct page *page;
>> +	u32 flow_id;
> 
> Here as well

ok.

> 
> [...]
> 
>>  	rx_chn->rx_chn = k3_udma_glue_request_rx_chn(dev, "rx", &rx_cfg);
>> @@ -2455,10 +2441,12 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
>>  		flow = &rx_chn->flows[i];
>>  		flow->id = i;
>>  		flow->common = common;
>> +		flow->irq = -EINVAL;
> 
> I've tried to follow the code and I don't get that assignment for the
> irq field, does it really have to do with the current change or is it
> another issue that's being fixed ?
> 
> Sorry if I missed the point here.

You are right. This change is unrelated to the subject.
I will split it out into another patch. It is meant to fix a problem in the error path.

> 
> Thanks,
> 
> Maxime

-- 
cheers,
-roger

