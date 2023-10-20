Return-Path: <bpf+bounces-12876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B097D193E
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 00:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B31728279A
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DEF2B757;
	Fri, 20 Oct 2023 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ot/144jq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE735505;
	Fri, 20 Oct 2023 22:38:38 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4B791;
	Fri, 20 Oct 2023 15:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kPveCGwDQzw44KmBN2s9cemxnEV3T4s1jd00sY+o42s=; b=Ot/144jqhOJN6lYzObeZBWQQQK
	KMAppdfBgjam/SzvvzJvCxkAQc7W5p89PBjFU4uEik5SYKQIeXbMDOcSAQxqLEURFdLzJaVfeFd0p
	NdWFMULtXPrxDQvfsTFU5G5HB03o/qtFPSCbZHbR1ZA3XKl1D1bmiHlrlDgPuTqdpHQM7TumOlV7e
	AKp8xTbEcacx2yiihNZx5yr3w5PPWJYlLthnPonZFmg2qH77Si8AN0o7wdWotkyVgleDRMTFNes0N
	r7CS2pf6DmhXn4TywNvs0lBgnMFwJfbRYh0wID9QKSfkLofwZE9pyqydjTqRFQKbNzfZD+nZpHyAD
	wjD8Duwg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qty8V-000Jy7-Ka; Sat, 21 Oct 2023 00:38:31 +0200
Received: from [178.197.249.50] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qty8V-000ICz-6o; Sat, 21 Oct 2023 00:38:31 +0200
Subject: Re: [PATCH bpf-next v2 1/7] netkit, bpf: Add bpf programmable net
 device
To: Andrew Lunn <andrew@lunn.ch>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, toke@kernel.org
References: <20231019204919.4203-1-daniel@iogearbox.net>
 <20231019204919.4203-2-daniel@iogearbox.net>
 <33467f55-4bbf-4078-af21-d91c6aab82ee@lunn.ch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f57df221-0790-3a93-c7e2-d85136fb07c8@iogearbox.net>
Date: Sat, 21 Oct 2023 00:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <33467f55-4bbf-4078-af21-d91c6aab82ee@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27067/Fri Oct 20 09:48:05 2023)

On 10/21/23 12:18 AM, Andrew Lunn wrote:
>> +static void netkit_get_drvinfo(struct net_device *dev,
>> +			       struct ethtool_drvinfo *info)
>> +{
>> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
>> +	strscpy(info->version, "n/a", sizeof(info->version));
> 
> If you don't put anything in version, the core will put in the git
> hash of the kernel. Its more useful than "n/a".

Thanks, I wasn't aware of this! Agree that this is better!

>> +	ether_setup(dev);
>> +	dev->min_mtu = ETH_MIN_MTU;
> 
> ether_setup() sets min_mtu to ETH_MIN_MTU.

Will fix.

>> +static int netkit_new_link(struct net *src_net, struct net_device *dev,
>> +			   struct nlattr *tb[], struct nlattr *data[],
>> +			   struct netlink_ext_ack *extack)
>> +{
> 
> ...
> 
>> +	err = register_netdevice(peer);
>> +	put_net(net);
>> +	if (err < 0)
>> +		goto err_register_peer;
>> +
>> +	netif_carrier_off(peer);
>> +
>> +	err = rtnl_configure_link(peer, ifmp, 0, NULL);
>> +	if (err < 0)
>> +		goto err_configure_peer;
> 
> Seeing code after calling register_netdevice() often means bugs. The
> interface is live, and in use before the function even returns. The
> kernel can try to get an IP address, mount an NFS root etc. This might
> be safe, because you have two linked interfaces here, and the other
> one is not yet registered. Maybe some comment about this would be
> good, or can the rtnl_configure_link() be done earlier?

I'll check if it's possible to reorder resp. add a comment if not.

>> +
>> +	if (mode == NETKIT_L2)
>> +		eth_hw_addr_random(dev);
>> +	if (tb[IFLA_IFNAME])
>> +		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
>> +	else
>> +		snprintf(dev->name, IFNAMSIZ, "m%%d");
>> +
>> +	err = register_netdevice(dev);
>> +	if (err < 0)
>> +		goto err_configure_peer;
> 
> We have the same here, but now we have both peers registers, the
> kernel could of configured both up in order to find its NFS root etc.
> Is it safe to have packets flowing at this point? Before the remaining
> configuration happens?

They would be dropped in xmit if the peer is linked yet.

>> +	netif_carrier_off(dev);
>> +
>> +	nk = netdev_priv(dev);
>> +	nk->primary = true;
>> +	nk->policy = default_prim;
>> +	nk->mode = mode;
>> +	if (nk->mode == NETKIT_L2)
>> +		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
>> +	bpf_mprog_bundle_init(&nk->bundle);
>> +	RCU_INIT_POINTER(nk->active, NULL);
>> +	rcu_assign_pointer(nk->peer, peer);
>> +
>> +	nk = netdev_priv(peer);
>> +	nk->primary = false;
>> +	nk->policy = default_peer;
>> +	nk->mode = mode;
>> +	if (nk->mode == NETKIT_L2)
>> +		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
>> +	bpf_mprog_bundle_init(&nk->bundle);
>> +	RCU_INIT_POINTER(nk->active, NULL);
>> +	rcu_assign_pointer(nk->peer, dev);
>> +	return 0;
>> +err_configure_peer:
>> +	unregister_netdevice(peer);
>> +	return err;
>> +err_register_peer:
>> +	free_netdev(peer);
>> +	return err;
>> +}

Thanks,
Daniel

