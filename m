Return-Path: <bpf+bounces-13264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878857D741E
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B7E2811A1
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D1631A6A;
	Wed, 25 Oct 2023 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="nZO+Rq3G"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548610FB
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 19:21:07 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8E181
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 12:21:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso868715e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698261664; x=1698866464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZeFE0Y3RTsNPSWpwG0pPpvB5TY22Vs8cL1zRduVJQI=;
        b=nZO+Rq3GBh1kIm8UwShleEUbLI7J5blMtpuSegqfd+n9O4PikNnqix2g5j7I9rWALY
         qC/4J6sB6VuTJNwHPPw02B6Myz5stAM0r/l349+euvyJbMIn79yvcjQWZWqZcpHTHxYZ
         6qsdOiwqzpfiGYSpmdD1sh94rqELUzTpVpaCdzpO1sJ/aXDUdlrlhd0rdvETzGFhsN3t
         SNIP+QpIgItDwoo6+pmUiXu2GffVdY5FmGHIUqxmMrUYFVlqDF6IqYe9v1L5QmA/F7ch
         hAIEpM5aKXD8KveHYvOQmloGLCicgXnoPotmCtAqCHW9KsgIUSZ2wYO1glaJflbQessx
         PBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698261664; x=1698866464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZeFE0Y3RTsNPSWpwG0pPpvB5TY22Vs8cL1zRduVJQI=;
        b=vlvJM9J6MKHKf5APqg640t0yh0hLRiyY24A9CC9HUxNiwUSLZQCBkMeKbH7e0Eh59B
         BabtlRwlZmHmVvFMFN8ImeK0TC7+qu34ornMio3PRJvjh3PZeTsduRabuykn5gHQY5r1
         pYKMM7Av/iswA8W799T/4xehcL1p5lGRhXLBPd16taDVBNW1o/LhYGtOOzAF0k3rbcsl
         MaThQksqiu30U9xI7hDBLg9fdaXgxuTBWMagt075jywD6Z0dLdQlCHwMc8I8NituPCQy
         62Te45D9yMImCpZaVIihWKNo05jz+wM3zLUe9vPupspNsPbGnSCetaK8LInpeknBfZ83
         yynw==
X-Gm-Message-State: AOJu0Yz9BAVOgXwV5owxdvez3wLhUvFon30xx3TGFBF+wqNzMsVW2pUW
	WtxbHSfp59RFBJm3d0KIsAsMpg==
X-Google-Smtp-Source: AGHT+IGuFKnAK36FoIkBRyvP9N3CIuzl4+UZMScUzdR5TGWifA5JwQtedPHgcTUyfk+4snz/dR+qww==
X-Received: by 2002:a05:600c:4747:b0:405:359a:c950 with SMTP id w7-20020a05600c474700b00405359ac950mr12760519wmo.19.1698261663559;
        Wed, 25 Oct 2023 12:21:03 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b00405442edc69sm522021wmb.14.2023.10.25.12.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 12:21:03 -0700 (PDT)
Message-ID: <5df35b1b-0a63-a73f-7a32-c6c87f4676cc@blackwall.org>
Date: Wed, 25 Oct 2023 22:21:01 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net> <ZTk4ec8CBh92PZvs@nanopsycho>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZTk4ec8CBh92PZvs@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/23 18:47, Jiri Pirko wrote:
> Tue, Oct 24, 2023 at 11:48:58PM CEST, daniel@iogearbox.net wrote:
>> This work adds a new, minimal BPF-programmable device called "netkit"
[snip]
> 
> Couple of nitpicks below:
> 
> [..]
> 
> 

Hi,
Thanks for the review. I know about the nits below but decided against
changing them, more below each...

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

This cannot be handled by policies AFAIK, because only 2 sparse values 
from more are allowed. We could potentially do it through validate() but
it's the same minus the explicit policy type info. IMO this approach is 
good.

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

This one can be handled by policy indeed, but then we lose the nice user 
error. Again can be done through validate(), but it's the same and we
lose explicit policy type information.

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

Yep, they are. Here decided in favor of explicit show of values, 
although it's minor and I'm fine either way.

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

Cheers,
  Nik


