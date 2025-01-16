Return-Path: <bpf+bounces-49046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB386A13969
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 12:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C040168DDD
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E01DE4DF;
	Thu, 16 Jan 2025 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpVg+sTg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B419FA92;
	Thu, 16 Jan 2025 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028185; cv=none; b=nUZ37yGh8aV6aUqEv3OiGQDDfiJIpWyzipj44jKTCTkhx95hk6G6sRdUBpGINVTvm1chcWV0T6NBHLY3Qg8VcjThVh4XLAhClXAlElyLBVqfWEHnXrWZdXCoEL3htm9o6axmDlDPTcojgkvCFT0NtHLFK4oCi1kobfKBYnjhapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028185; c=relaxed/simple;
	bh=7rknpNPcPjYzUygRvRZKZvmVmYvpn7W3UgSjBzXfRPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXD/rUYCDFyYK66LQETTl1N8HHLIJB0XK0rrFcWsmoM/Y6Z+gMrKqq1JYiyIazzOwC+4DP5l0Q8XuqV0UqnI6FUaqXCXUfdws/NpeFzpvaaV2URTTxpDm4Jd2q4AwFN8VGuV0stto22EIE9dI64ty1xpGIoPCW+vQQk6B5Cn6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpVg+sTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD04AC4CED6;
	Thu, 16 Jan 2025 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737028184;
	bh=7rknpNPcPjYzUygRvRZKZvmVmYvpn7W3UgSjBzXfRPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PpVg+sTggp0pv+2ieXo6buYA4+4Ffca71AAjJ9yci777yEwpFUSMfkCOHgKzuPpXc
	 zUovPnZ08phPRl9uzOsdGtns6+jCoLfgVSV0bbX+skr2hAGafpPZnjyXZ62ZAHLyKK
	 /u2Njy7yzW3fTF5gv2Ocjo87M0lfj2L6jT4N7rJHHLLucfCVqsoJElfErZsQAAblEr
	 Kp/COdWgZwplkd6gJn0tRIHEgFlhVuT2V1/AFQxY7Qk8pBkyNzP4ntSWzAc1ql3qVk
	 88EyYZrFAqNI1xcYAoNzfkByal5NCLTXlxsm6SBeWRiZEIUJ2KsCMrPIiyjv3K3Tdw
	 cX6S7YCTEuHzw==
Message-ID: <4a461367-5b5d-4716-8c54-dc41c10b7ee7@kernel.org>
Date: Thu, 16 Jan 2025 13:49:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: ethernet: am65-cpsw: call
 netif_carrier_on/off() when appropriate
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, danishanwar@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
 <20250115-am65-cpsw-streamline-v1-1-326975c36935@kernel.org>
 <20250115181318.2dd11693@fedora.home>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250115181318.2dd11693@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/01/2025 19:13, Maxime Chevallier wrote:
> Hello Roger,
> 
> On Wed, 15 Jan 2025 18:43:00 +0200
> Roger Quadros <rogerq@kernel.org> wrote:
> 
>> Call netif_carrier_on/off when link is up/down.
>> When link is up only wake TX netif queue if network device is
>> running.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index dcb6662b473d..36c29d3db329 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -2155,6 +2155,7 @@ static void am65_cpsw_nuss_mac_link_down(struct phylink_config *config, unsigned
>>  	cpsw_sl_ctl_clr(port->slave.mac_sl, mac_control);
>>  
>>  	am65_cpsw_qos_link_down(ndev);
>> +	netif_carrier_off(ndev);
> 
> You shouldn't need to do that, phylink does that for you :
> https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/net/phy/phylink.c#L1434
> 
> Are you facing any specific problem that motivates that patch ?

No. I overlooked it.

> 
>>  	netif_tx_stop_all_queues(ndev);
>>  }
>>  
>> @@ -2196,7 +2197,9 @@ static void am65_cpsw_nuss_mac_link_up(struct phylink_config *config, struct phy
>>  	cpsw_ale_control_set(common->ale, port->port_id, ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
>>  
>>  	am65_cpsw_qos_link_up(ndev, speed);
>> -	netif_tx_wake_all_queues(ndev);
>> +	netif_carrier_on(ndev);
> 
> Same here, phylink will set the carrier on by itself.

Thanks for catching this. I'll drop this patch on next spin.

> 
> Thanks,
> 
> Maxime

-- 
cheers,
-roger


