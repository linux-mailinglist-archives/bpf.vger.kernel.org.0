Return-Path: <bpf+bounces-14993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE7F7E9CBB
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 14:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD861C208F7
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F61DDF4;
	Mon, 13 Nov 2023 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gOsg6C9g"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA91C682;
	Mon, 13 Nov 2023 13:05:47 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDCE1711;
	Mon, 13 Nov 2023 05:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=S2QB/D8qbGnOXgub3tW2tyXFsw8pLhFhuPGOEZKu9PE=; b=gOsg6C9gHKBTpNFZ1FdjTgNE5E
	0rx/eBVI4Wp7cC+lKUCndr/Kn6IE2kzI6DY756Dw1XLxbgzskKZf918xFm6pdf2d4abtTTdNCGB5k
	SReMui5DVELepnoffB4r1B1B58gnPpsOoFOgdito55h0O6IA3T8GxTVOdM3oUKjIdfF1GUaozD6iw
	xtXcivSPPvw49akBxta+MHozycYHCyCHltLDIe5sQjEoKv/sRMyEtbvJycS3PXnJCcjD6V8iWNGyC
	fsQ77fuJyu3yn4o2ey5YE8nFzyDaOuWv7spT4EvtRNv/7bGP0pDpbm82P7ZgHAlvBHDsjlBU1xTdM
	VY1rqIdQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2WdJ-00061H-9e; Mon, 13 Nov 2023 14:05:41 +0100
Received: from [194.230.158.57] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2WdI-0007Ie-RA; Mon, 13 Nov 2023 14:05:41 +0100
Subject: Re: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and
 convert veth & vrf
To: Simon Horman <horms@kernel.org>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
 sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 David Ahern <dsahern@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-3-daniel@iogearbox.net>
 <20231113100305.GO705326@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc269865-d3c7-f8e6-9a61-25794f5ae220@iogearbox.net>
Date: Mon, 13 Nov 2023 14:05:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113100305.GO705326@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

On 11/13/23 11:03 AM, Simon Horman wrote:
> On Sun, Nov 12, 2023 at 09:30:03PM +0100, Daniel Borkmann wrote:
>> Move {l,t,d}stats allocation to the core and let netdevs pick the stats
>> type they need. That way the driver doesn't have to bother with error
>> handling (allocation failure checking, making sure free happens in the
>> right spot, etc) - all happening in the core.
>>
>> Co-developed-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: David Ahern <dsahern@kernel.org>
> 
> Hi Daniel,
> 
> sorry I was a bit to hasty in hitting the send button for my previous
> message. I have a some more minor feedback on this series.
> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 0d548431f3fa..75db81496db5 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -10049,6 +10049,44 @@ void netif_tx_stop_all_queues(struct net_device *dev)
>>   }
>>   EXPORT_SYMBOL(netif_tx_stop_all_queues);
>>   
>> +static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
>> +{
>> +	void __percpu *v;
>> +
>> +	switch (dev->pcpu_stat_type) {
>> +	case NETDEV_PCPU_STAT_NONE:
>> +		return 0;
>> +	case NETDEV_PCPU_STAT_LSTATS:
>> +		v = dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
>> +		break;
>> +	case NETDEV_PCPU_STAT_TSTATS:
>> +		v = dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
>> +		break;
>> +	case NETDEV_PCPU_STAT_DSTATS:
>> +		v = dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
>> +		break;
>> +	}
>> +
>> +	return v ? 0 : -ENOMEM;
> 
> Perhaps this cannot happen, but if none of the cases in the switch
> statement are met, then v will be uninitialised here.
> 
> As flagged by Smatch.

Good point, I'll add a guard in case someone tries to set an invalid value
outside of the enum.

>> +}
>> +
> 
> ...
> 
>> @@ -10469,6 +10513,7 @@ void netdev_run_todo(void)
>>   		WARN_ON(rcu_access_pointer(dev->ip_ptr));
>>   		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
>>   
>> +		netdev_do_free_pcpu_stats(dev);
>>   		if (dev->priv_destructor)
>>   			dev->priv_destructor(dev);
>>   		if (dev->needs_free_netdev)
> 
> nit: the hunk above seems unnecessary; one blank line is enough.

I'm not sure which one you mean?

Thanks,
Daniel

