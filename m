Return-Path: <bpf+bounces-13256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B17D7232
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919C7B21069
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB42E652;
	Wed, 25 Oct 2023 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gGunIJjC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F5522C;
	Wed, 25 Oct 2023 17:20:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8237C111;
	Wed, 25 Oct 2023 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oEGZpra13q0UzR+qNcAu0Ru3954KLITO409Cp5EdwJc=; b=gGunIJjCv9dgcaLdU3P89SvlYz
	QnTxiWRWbzpQEGeA2XDS0OUiAyDUKkW+0VC6uQLP0ZUTpNO2Zd9EtxKDEKxm9DDivN2i9htP6lUbB
	yHGODSYD6nOqq4r7/Ye496VFTs86q5iFrQhACoMPa28vfE4I//B84G4yFhFQgi6SrD+a2oLg93CtM
	L8XYxX2vFi5wRJieHE7COrWh/THXH0uWBdwUXMb+an2OXKE+dyU448kZmf6N+W6X0CVTsV1zhX7NA
	8NO02Nibpar6qIzCIIb8wcm6+zFI/sqfo2loG3UxGkbB15cvsB/7LXVjZVyPv2jfsqufDrEZdbURG
	qM4nUeZQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvhY2-0001iq-Ch; Wed, 25 Oct 2023 19:20:02 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvhY1-000PGj-TM; Wed, 25 Oct 2023 19:20:01 +0200
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
To: Jiri Pirko <jiri@resnulli.us>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, toke@kernel.org, kuba@kernel.org,
 andrew@lunn.ch, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?=
 <toke@redhat.com>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net> <ZTk4ec8CBh92PZvs@nanopsycho>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7dcf130e-db64-34bc-5207-15e4a4963bc0@iogearbox.net>
Date: Wed, 25 Oct 2023 19:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZTk4ec8CBh92PZvs@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27072/Wed Oct 25 09:45:37 2023)

On 10/25/23 5:47 PM, Jiri Pirko wrote:
> Tue, Oct 24, 2023 at 11:48:58PM CEST, daniel@iogearbox.net wrote:
[...]
>> comes with a primary and a peer device. Only the primary device, typically
>> residing in hostns, can manage BPF programs for itself and its peer. The
>> peer device is designated for containers/Pods and cannot attach/detach
>> BPF programs. Upon the device creation, the user can set the default policy
>> to 'pass' or 'drop' for the case when no BPF program is attached.
> 
> It looks to me that you only need the host (primary) netdevice to be
> used as a handle to attach the bpf programs. Because the bpf program
> can (and probably in real use case will) redirect to uplink/another
> pod netdevice skipping the host (primary) netdevice, correct?
> 
> If so, why can't you do just single device mode from start finding a
> different sort of bpf attach handle? (not sure which)

The first point where we switch netns from a K8s Pod is out of the netdevice.
For the CNI case the vast majority has one but there could also be multi-
homing for Pods where there may be two or more, and from a troubleshooting
PoV aka tcpdump et al, it is the most natural point. Other attach handle
inside the Pod doesn't really fit given from policy PoV it also must be
unreachable for apps inside the Pod itself.

>> Additionally, the device can be operated in L3 (default) or L2 mode. The
>> management of BPF programs is done via bpf_mprog, so that multi-attach is
>> supported right from the beginning with similar API and dependency controls
>> as tcx. For details on the latter see commit 053c8e1f235d ("bpf: Add generic
>> attach/detach/query API for multi-progs"). tc BPF compatibility is provided,
>> so that existing programs can be easily migrated.
>>
>> Going forward, we plan to use netkit devices in Cilium as the main device
>> type for connecting Pods. They will be operated in L3 mode in order to
>> simplify a Pod's neighbor management and the peer will operate in default
>> drop mode, so that no traffic is leaving between the time when a Pod is
>> brought up by the CNI plugin and programs attached by the agent.
>> Additionally, the programs we attach via tcx on the physical devices are
>> using bpf_redirect_peer() for inbound traffic into netkit device, hence the
>> latter is also supporting the ndo_get_peer_dev callback. Similarly, we use
>> bpf_redirect_neigh() for the way out, pushing from netkit peer to phys device
>> directly. Also, BIG TCP is supported on netkit device. For the follow-up
>> work in single device mode, we plan to convert Cilium's cilium_host/_net
>> devices into a single one.
>>
>> An extensive test suite for checking device operations and the BPF program
>> and link management API comes as BPF selftests in this series.
> 
> Couple of nitpicks below:

Thanks for looking into those, I'll look into it and send a small cleanup on
the two.

>> +static int netkit_check_policy(int policy, struct nlattr *tb,
>> +			       struct netlink_ext_ack *extack)
>> +{
>> +	switch (policy) {
>> +	case NETKIT_PASS:
>> +	case NETKIT_DROP:
>> +		return 0;
>> +	default:
> 
> Isn't this job for netlink policy?
> 
> 
>> +		NL_SET_ERR_MSG_ATTR(extack, tb,
>> +				    "Provided default xmit policy not supported");
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int netkit_check_mode(int mode, struct nlattr *tb,
>> +			     struct netlink_ext_ack *extack)
>> +{
>> +	switch (mode) {
>> +	case NETKIT_L2:
>> +	case NETKIT_L3:
>> +		return 0;
>> +	default:
> 
> Isn't this job for netlink policy?
> 
> 
>> +		NL_SET_ERR_MSG_ATTR(extack, tb,
>> +				    "Provided device mode can only be L2 or L3");
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
>> +			   struct netlink_ext_ack *extack)
>> +{
>> +	struct nlattr *attr = tb[IFLA_ADDRESS];
>> +
>> +	if (!attr)
>> +		return 0;
>> +	NL_SET_ERR_MSG_ATTR(extack, attr,
>> +			    "Setting Ethernet address is not supported");
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static struct rtnl_link_ops netkit_link_ops;
>> +
>> +static int netkit_new_link(struct net *src_net, struct net_device *dev,
>> +			   struct nlattr *tb[], struct nlattr *data[],
>> +			   struct netlink_ext_ack *extack)
>> +{
>> +	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
>> +	enum netkit_action default_prim = NETKIT_PASS;
>> +	enum netkit_action default_peer = NETKIT_PASS;
>> +	enum netkit_mode mode = NETKIT_L3;
>> +	unsigned char ifname_assign_type;
>> +	struct ifinfomsg *ifmp = NULL;
>> +	struct net_device *peer;
>> +	char ifname[IFNAMSIZ];
>> +	struct netkit *nk;
>> +	struct net *net;
>> +	int err;
>> +
>> +	if (data) {
>> +		if (data[IFLA_NETKIT_MODE]) {
>> +			attr = data[IFLA_NETKIT_MODE];
>> +			mode = nla_get_u32(attr);
>> +			err = netkit_check_mode(mode, attr, extack);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		if (data[IFLA_NETKIT_PEER_INFO]) {
>> +			attr = data[IFLA_NETKIT_PEER_INFO];
>> +			ifmp = nla_data(attr);
>> +			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
>> +			if (err < 0)
>> +				return err;
>> +			err = netkit_validate(peer_tb, NULL, extack);
>> +			if (err < 0)
>> +				return err;
>> +			tbp = peer_tb;
>> +		}
>> +		if (data[IFLA_NETKIT_POLICY]) {
>> +			attr = data[IFLA_NETKIT_POLICY];
>> +			default_prim = nla_get_u32(attr);
>> +			err = netkit_check_policy(default_prim, attr, extack);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +		if (data[IFLA_NETKIT_PEER_POLICY]) {
>> +			attr = data[IFLA_NETKIT_PEER_POLICY];
>> +			default_peer = nla_get_u32(attr);
>> +			err = netkit_check_policy(default_peer, attr, extack);
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +	}
>> +
>> +	if (ifmp && tbp[IFLA_IFNAME]) {
>> +		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
>> +		ifname_assign_type = NET_NAME_USER;
>> +	} else {
>> +		strscpy(ifname, "nk%d", IFNAMSIZ);
>> +		ifname_assign_type = NET_NAME_ENUM;
>> +	}
>> +
>> +	net = rtnl_link_get_net(src_net, tbp);
>> +	if (IS_ERR(net))
>> +		return PTR_ERR(net);
>> +
>> +	peer = rtnl_create_link(net, ifname, ifname_assign_type,
>> +				&netkit_link_ops, tbp, extack);
>> +	if (IS_ERR(peer)) {
>> +		put_net(net);
>> +		return PTR_ERR(peer);
>> +	}
>> +
>> +	netif_inherit_tso_max(peer, dev);
>> +
>> +	if (mode == NETKIT_L2)
>> +		eth_hw_addr_random(peer);
>> +	if (ifmp && dev->ifindex)
>> +		peer->ifindex = ifmp->ifi_index;
>> +
>> +	nk = netkit_priv(peer);
>> +	nk->primary = false;
>> +	nk->policy = default_peer;
>> +	nk->mode = mode;
>> +	bpf_mprog_bundle_init(&nk->bundle);
>> +	RCU_INIT_POINTER(nk->active, NULL);
>> +	RCU_INIT_POINTER(nk->peer, NULL);
> 
> Aren't these already 0?
> 
> 
>> +
>> +	err = register_netdevice(peer);
>> +	put_net(net);
>> +	if (err < 0)
>> +		goto err_register_peer;
>> +	netif_carrier_off(peer);
>> +	if (mode == NETKIT_L2)
>> +		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
>> +
>> +	err = rtnl_configure_link(peer, NULL, 0, NULL);
>> +	if (err < 0)
>> +		goto err_configure_peer;
>> +
>> +	if (mode == NETKIT_L2)
>> +		eth_hw_addr_random(dev);
>> +	if (tb[IFLA_IFNAME])
>> +		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
>> +	else
>> +		strscpy(dev->name, "nk%d", IFNAMSIZ);
>> +
>> +	nk = netkit_priv(dev);
>> +	nk->primary = true;
>> +	nk->policy = default_prim;
>> +	nk->mode = mode;
>> +	bpf_mprog_bundle_init(&nk->bundle);
>> +	RCU_INIT_POINTER(nk->active, NULL);
>> +	RCU_INIT_POINTER(nk->peer, NULL);
>> +
>> +	err = register_netdevice(dev);
>> +	if (err < 0)
>> +		goto err_configure_peer;
>> +	netif_carrier_off(dev);
>> +	if (mode == NETKIT_L2)
>> +		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
>> +
>> +	rcu_assign_pointer(netkit_priv(dev)->peer, peer);
>> +	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
>> +	return 0;
>> +err_configure_peer:
>> +	unregister_netdevice(peer);
>> +	return err;
>> +err_register_peer:
>> +	free_netdev(peer);
>> +	return err;
>> +}
>> +
> 
> [..]
> 


