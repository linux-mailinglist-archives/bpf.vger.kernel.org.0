Return-Path: <bpf+bounces-31181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB058D7C42
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 09:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9D1283AB3
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7463D0D9;
	Mon,  3 Jun 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LwKH2/+P"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731E273FC;
	Mon,  3 Jun 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398739; cv=none; b=mdU9Pu7qb9R5gBs4ojEbP3wD+AJCFYp2E2ynM24m6X6dnDuwZjYtjzxSr6r156t4bXy9sdE6MiLDK0ot3IAJIeD5jBNzfjfpr3lqqMY3poBtCsIjKolKlTZ55waWa2fsLI6Fap+ab9RYu+rGcOZKGnlWunJjzjC5u3U55k5jNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398739; c=relaxed/simple;
	bh=K5IViHl6XkR10Z35kogX2Vt/64aVpmdkIYCy7hb1sd4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MBsp/LKtA5btgPVKCLESMEm/Ln3DTYCj0co/Q2uZ4o3NwOk2U2Ak4hXfXmu6Kshq63ZDhzzuLuTrOzS6E3E+o6s5W8YLEhxr6oeewliYmjFKVyJWPxy/s2bkdBm5YGrlnKKobKEuFR2/tHqRUR5ac3HYmWtXn3hw7UM+hM7sCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LwKH2/+P; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kjWxmoc3bAvHrdPwmw/wZhUJVWaEY3uIiyai03L5nIk=; b=LwKH2/+P972LY2unwqRa71Rx9s
	yJEUQiJNvcn8U9wdTb39ppVchMZyiyl2Ne++jQmtbjn8Gg6x0eqcO0R+hyOrw1DGvljE7H8dvF5VJ
	FB4BuTYmyzKSvf1Hl/E2Eq26y3LRIzTdogQHlDaeLA8WtSh7ELF289SngbKUD7YJ0vl/NiiswVPqO
	a7T/vDlrN0c8VtRyenJmOriYf2r2kI//si7WvkSSHkxFW1tuHxEvaQhPUpDuPMk7uZzSl52EAe7FN
	IhMi1gH2bQhFl/WSj6Dc3sfDgTtIaqTMMvf6Od7pzf7DCasHBua3W/YnGePEY7nLiwUCncpzOSrAq
	l154qJbA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sE1rT-000679-Ph; Mon, 03 Jun 2024 09:12:07 +0200
Received: from [178.197.248.29] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sE1rS-000E6l-00;
	Mon, 03 Jun 2024 09:12:07 +0200
Subject: Re: [PATCH net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 David Bauer <mail@david-bauer.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240531154137.26797-1-daniel@iogearbox.net>
 <ZlwvYesTLZVR5ezQ@shredder>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <56724e21-65a0-ea65-ed65-a24b68ed99df@iogearbox.net>
Date: Mon, 3 Jun 2024 09:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlwvYesTLZVR5ezQ@shredder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27294/Sun Jun  2 10:29:37 2024)

On 6/2/24 10:37 AM, Ido Schimmel wrote:
> On Fri, May 31, 2024 at 05:41:37PM +0200, Daniel Borkmann wrote:
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index f78dd0438843..7353f27b02dc 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -1605,6 +1605,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>>   			  struct vxlan_sock *vs,
>>   			  struct sk_buff *skb, __be32 vni)
>>   {
>> +	bool learning = vxlan->cfg.flags & VXLAN_F_LEARN;
>>   	union vxlan_addr saddr;
>>   	u32 ifindex = skb->dev->ifindex;
>>   
>> @@ -1616,8 +1617,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>>   	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
>>   		return false;
>>   
>> -	/* Ignore packets from invalid src-address */
>> -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
>> +	/* Ignore packets from invalid src-address when in learning mode,
>> +	 * otherwise let them through e.g. when originating from NOARP
>> +	 * devices with all-zero mac, etc.
>> +	 */
>> +	if (learning && !is_valid_ether_addr(eth_hdr(skb)->h_source))
>>   		return false;
>>   
>>   	/* Get address from the outer IP header */
>> @@ -1631,7 +1635,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>>   #endif
>>   	}
>>   
>> -	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
>> +	if (learning &&
>>   	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
>>   		return false;
> 
> Daniel, I think we can simply move this check out of the main path to
> vxlan_snoop() which is only called when learning is enabled:
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 7496c14e8329..89f3945b448f 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1446,6 +1446,10 @@ static bool vxlan_snoop(struct net_device *dev,
>          struct vxlan_fdb *f;
>          u32 ifindex = 0;
>   
> +       /* Ignore packets from invalid src-address */
> +       if (!is_valid_ether_addr(src_mac))
> +               return true;
> +
>   #if IS_ENABLED(CONFIG_IPV6)
>          if (src_ip->sa.sa_family == AF_INET6 &&
>              (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
> @@ -1616,10 +1620,6 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>          if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
>                  return false;
>   
> -       /* Ignore packets from invalid src-address */
> -       if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> -               return false;
> -
>          /* Get address from the outer IP header */
>          if (vxlan_get_sk_family(vs) == AF_INET) {
>                  saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
> 
> WDYT?

Makes sense, that looks better. Will send a v2, thanks Ido!

