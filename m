Return-Path: <bpf+bounces-12873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B766C7D18FB
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 00:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEF21C2106E
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89660347B0;
	Fri, 20 Oct 2023 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KoEz2Xot"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C6321A4;
	Fri, 20 Oct 2023 22:18:57 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3DFA;
	Fri, 20 Oct 2023 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZRn4sojkLKlXH8c8iRB9GqmKd0ho38wtF3tcngALaVI=; b=KoEz2XotWPCyj8047aBrwRqHY/
	FiUfLcb4hbI9ZgZmtl8uNr602qabqVdsDFeO+HxeIjlReJvgX5gKAptelXZZkOKhqj1urFhQwFpWC
	w2G4620XYlb/GFUAvOcKukCWwumUpDT/W4czMtYFrzxGrDSLinDfLOz79wXuRmTAHclk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qtxpV-002pea-L4; Sat, 21 Oct 2023 00:18:53 +0200
Date: Sat, 21 Oct 2023 00:18:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
	john.fastabend@gmail.com, sdf@google.com, toke@kernel.org
Subject: Re: [PATCH bpf-next v2 1/7] netkit, bpf: Add bpf programmable net
 device
Message-ID: <33467f55-4bbf-4078-af21-d91c6aab82ee@lunn.ch>
References: <20231019204919.4203-1-daniel@iogearbox.net>
 <20231019204919.4203-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019204919.4203-2-daniel@iogearbox.net>

> +static void netkit_get_drvinfo(struct net_device *dev,
> +			       struct ethtool_drvinfo *info)
> +{
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->version, "n/a", sizeof(info->version));

If you don't put anything in version, the core will put in the git
hash of the kernel. Its more useful than "n/a".

> +	ether_setup(dev);
> +	dev->min_mtu = ETH_MIN_MTU;

ether_setup() sets min_mtu to ETH_MIN_MTU.

> +static int netkit_new_link(struct net *src_net, struct net_device *dev,
> +			   struct nlattr *tb[], struct nlattr *data[],
> +			   struct netlink_ext_ack *extack)
> +{

...

> +	err = register_netdevice(peer);
> +	put_net(net);
> +	if (err < 0)
> +		goto err_register_peer;
> +
> +	netif_carrier_off(peer);
> +
> +	err = rtnl_configure_link(peer, ifmp, 0, NULL);
> +	if (err < 0)
> +		goto err_configure_peer;

Seeing code after calling register_netdevice() often means bugs. The
interface is live, and in use before the function even returns. The
kernel can try to get an IP address, mount an NFS root etc. This might
be safe, because you have two linked interfaces here, and the other
one is not yet registered. Maybe some comment about this would be
good, or can the rtnl_configure_link() be done earlier?

> +
> +	if (mode == NETKIT_L2)
> +		eth_hw_addr_random(dev);
> +	if (tb[IFLA_IFNAME])
> +		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
> +	else
> +		snprintf(dev->name, IFNAMSIZ, "m%%d");
> +
> +	err = register_netdevice(dev);
> +	if (err < 0)
> +		goto err_configure_peer;

We have the same here, but now we have both peers registers, the
kernel could of configured both up in order to find its NFS root etc.
Is it safe to have packets flowing at this point? Before the remaining
configuration happens?

> +
> +	netif_carrier_off(dev);
> +
> +	nk = netdev_priv(dev);
> +	nk->primary = true;
> +	nk->policy = default_prim;
> +	nk->mode = mode;
> +	if (nk->mode == NETKIT_L2)
> +		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
> +	bpf_mprog_bundle_init(&nk->bundle);
> +	RCU_INIT_POINTER(nk->active, NULL);
> +	rcu_assign_pointer(nk->peer, peer);
> +
> +	nk = netdev_priv(peer);
> +	nk->primary = false;
> +	nk->policy = default_peer;
> +	nk->mode = mode;
> +	if (nk->mode == NETKIT_L2)
> +		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
> +	bpf_mprog_bundle_init(&nk->bundle);
> +	RCU_INIT_POINTER(nk->active, NULL);
> +	rcu_assign_pointer(nk->peer, dev);
> +	return 0;
> +err_configure_peer:
> +	unregister_netdevice(peer);
> +	return err;
> +err_register_peer:
> +	free_netdev(peer);
> +	return err;
> +}


  Andrew

