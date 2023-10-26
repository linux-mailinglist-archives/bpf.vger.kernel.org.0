Return-Path: <bpf+bounces-13301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B37D7CCE
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 08:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DA6281EE0
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C81173E;
	Thu, 26 Oct 2023 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="HY9cktuY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AD8472
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 06:21:53 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74C187
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 23:21:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dd70c5401so335603f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 23:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698301310; x=1698906110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdMyLmIgnuubyki8FRxtEdcZp5JvVpN2Pq4ugcFH7q0=;
        b=HY9cktuYTYQKm3fWTTQmJwPGMMeMwYTqkSPwZNRl2ARkfitn/cQvqyGNgvRo8i7Fch
         wJo9WEVJc2B1noQnxDwETvgjXQmkYacYymMOk8gZm2yU8NcKZmrBgkQlJh5IfntCDVHy
         RCXJGepcsfth1YolmrbdmGa9+n/Q/Yc1JpWy33ZL1EbJTpj+inrvrmuANPljiNdytCh/
         jIuqkUe7zMPT/dUAtLuH9l0azws2TdoUuabHeLcM/h6KUZpnI0MvEXCjjRskRKy092YM
         RBBETNKH9GP+RaDxKmq5LPWVAUaWmhUVBBEzQuCe7DdrsvVw2K/m18GH+R7QlXa6r1kt
         4Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698301310; x=1698906110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdMyLmIgnuubyki8FRxtEdcZp5JvVpN2Pq4ugcFH7q0=;
        b=xGcJX5s1Fhptu43CvyO6pJI3DMHxKPbaHvfEt+KNnEp2sqXAwZGcxxMmKoK74sqcPF
         CKC05za4xiHVOyZQfbrZ/VR8jaG+dV2T/6uXkTDnJSBZYgc4R+30g+Ns+14xS6ve32/U
         h+7L8xwGUT3AXRLiAlXnxGeS6NJOMOWwYt6ZBk8fqMsCBHiSYUtW8fhLhq7Lg0u5Vtry
         fZ8CpQ8Zv/p0bjavqi0UxJX3uZq9zC+BPSHp/WpVrHHcvYpzFGNuoWvWZBOwgJwA4CF/
         XS/ES69SncCtb7seV96yaiNrzZz2AUPpQq6BTXCp+WVPILzqTX09YqlU25Betfuh9Y6G
         p0/g==
X-Gm-Message-State: AOJu0YzQcg8QZ038e7TjNGg51vXC8fdLvA2S4e5vje6ChdsdLPV/ARyA
	NimAlSjzzlXK0F1FEy/4U6qlsw==
X-Google-Smtp-Source: AGHT+IH/BKhgzqxD4jNWeq8H+CetF97Gscugw1tvdpjsqHEGUF9dKVdlu/6DexUvv2wLcxBcIctWcg==
X-Received: by 2002:a5d:574f:0:b0:322:707e:a9fd with SMTP id q15-20020a5d574f000000b00322707ea9fdmr13561594wrw.34.1698301309917;
        Wed, 25 Oct 2023 23:21:49 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id e16-20020adfef10000000b0032d8354fb43sm13600671wro.76.2023.10.25.23.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 23:21:49 -0700 (PDT)
Message-ID: <ba294077-8734-8ff3-d914-c4baa3821c2f@blackwall.org>
Date: Thu, 26 Oct 2023 09:21:48 +0300
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
To: Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net> <ZTk4ec8CBh92PZvs@nanopsycho>
 <5df35b1b-0a63-a73f-7a32-c6c87f4676cc@blackwall.org>
 <ZTn4cOgrCOZAvIUO@nanopsycho>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZTn4cOgrCOZAvIUO@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/23 08:26, Jiri Pirko wrote:
> Wed, Oct 25, 2023 at 09:21:01PM CEST, razor@blackwall.org wrote:
>> On 10/25/23 18:47, Jiri Pirko wrote:
>>> Tue, Oct 24, 2023 at 11:48:58PM CEST, daniel@iogearbox.net wrote:
>>>> This work adds a new, minimal BPF-programmable device called "netkit"
>> [snip]
>>>
>>> Couple of nitpicks below:
>>>
>>> [..]
>>>
>>>
>>
>> Hi,
>> Thanks for the review. I know about the nits below but decided against
>> changing them, more below each...
>>
>>>> +static int netkit_check_policy(int policy, struct nlattr *tb,
>>>> +			       struct netlink_ext_ack *extack)
>>>> +{
>>>> +	switch (policy) {
>>>> +	case NETKIT_PASS:
>>>> +	case NETKIT_DROP:
>>>> +		return 0;
>>>> +	default:
>>>
>>> Isn't this job for netlink policy?
>>>
>>>
>>
>> This cannot be handled by policies AFAIK, because only 2 sparse values from
>> more are allowed. We could potentially do it through validate() but
> 
> Perhaps good time to extend the netlink validation for list
> of values allowed?
> 
> 
> 
>> it's the same minus the explicit policy type info. IMO this approach is good.
>>
>>>> +		NL_SET_ERR_MSG_ATTR(extack, tb,
>>>> +				    "Provided default xmit policy not supported");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int netkit_check_mode(int mode, struct nlattr *tb,
>>>> +			     struct netlink_ext_ack *extack)
>>>> +{
>>>> +	switch (mode) {
>>>> +	case NETKIT_L2:
>>>> +	case NETKIT_L3:
>>>> +		return 0;
>>>> +	default:
>>>
>>> Isn't this job for netlink policy?
>>>
>>>
>>
>> This one can be handled by policy indeed, but then we lose the nice user
>> error. Again can be done through validate(), but it's the same and we
>> lose explicit policy type information.
> 
> But the netlink validator setups the extack properly. What's wrong with
> that?
> 
> 

"integer out of range" vs "Provided device mode can only be L2 or L3" ?
I like the second one better and it's more informative. The way to get 
it is to use NLA_POLICY_VALIDATE_FN() as type and provide custom 
validate() callback, which is identical to the current solution, I see 
no added value in changing it.

> 
>>
>>>> +		NL_SET_ERR_MSG_ATTR(extack, tb,
>>>> +				    "Provided device mode can only be L2 or L3");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
>>>> +			   struct netlink_ext_ack *extack)
>>>> +{
>>>> +	struct nlattr *attr = tb[IFLA_ADDRESS];
>>>> +
>>>> +	if (!attr)
>>>> +		return 0;
>>>> +	NL_SET_ERR_MSG_ATTR(extack, attr,
>>>> +			    "Setting Ethernet address is not supported");
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static struct rtnl_link_ops netkit_link_ops;
>>>> +
>>>> +static int netkit_new_link(struct net *src_net, struct net_device *dev,
>>>> +			   struct nlattr *tb[], struct nlattr *data[],
>>>> +			   struct netlink_ext_ack *extack)
>>>> +{
>>>> +	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
>>>> +	enum netkit_action default_prim = NETKIT_PASS;
>>>> +	enum netkit_action default_peer = NETKIT_PASS;
>>>> +	enum netkit_mode mode = NETKIT_L3;
>>>> +	unsigned char ifname_assign_type;
>>>> +	struct ifinfomsg *ifmp = NULL;
>>>> +	struct net_device *peer;
>>>> +	char ifname[IFNAMSIZ];
>>>> +	struct netkit *nk;
>>>> +	struct net *net;
>>>> +	int err;
>>>> +
>>>> +	if (data) {
>>>> +		if (data[IFLA_NETKIT_MODE]) {
>>>> +			attr = data[IFLA_NETKIT_MODE];
>>>> +			mode = nla_get_u32(attr);
>>>> +			err = netkit_check_mode(mode, attr, extack);
>>>> +			if (err < 0)
>>>> +				return err;
>>>> +		}
>>>> +		if (data[IFLA_NETKIT_PEER_INFO]) {
>>>> +			attr = data[IFLA_NETKIT_PEER_INFO];
>>>> +			ifmp = nla_data(attr);
>>>> +			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
>>>> +			if (err < 0)
>>>> +				return err;
>>>> +			err = netkit_validate(peer_tb, NULL, extack);
>>>> +			if (err < 0)
>>>> +				return err;
>>>> +			tbp = peer_tb;
>>>> +		}
>>>> +		if (data[IFLA_NETKIT_POLICY]) {
>>>> +			attr = data[IFLA_NETKIT_POLICY];
>>>> +			default_prim = nla_get_u32(attr);
>>>> +			err = netkit_check_policy(default_prim, attr, extack);
>>>> +			if (err < 0)
>>>> +				return err;
>>>> +		}
>>>> +		if (data[IFLA_NETKIT_PEER_POLICY]) {
>>>> +			attr = data[IFLA_NETKIT_PEER_POLICY];
>>>> +			default_peer = nla_get_u32(attr);
>>>> +			err = netkit_check_policy(default_peer, attr, extack);
>>>> +			if (err < 0)
>>>> +				return err;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (ifmp && tbp[IFLA_IFNAME]) {
>>>> +		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
>>>> +		ifname_assign_type = NET_NAME_USER;
>>>> +	} else {
>>>> +		strscpy(ifname, "nk%d", IFNAMSIZ);
>>>> +		ifname_assign_type = NET_NAME_ENUM;
>>>> +	}
>>>> +
>>>> +	net = rtnl_link_get_net(src_net, tbp);
>>>> +	if (IS_ERR(net))
>>>> +		return PTR_ERR(net);
>>>> +
>>>> +	peer = rtnl_create_link(net, ifname, ifname_assign_type,
>>>> +				&netkit_link_ops, tbp, extack);
>>>> +	if (IS_ERR(peer)) {
>>>> +		put_net(net);
>>>> +		return PTR_ERR(peer);
>>>> +	}
>>>> +
>>>> +	netif_inherit_tso_max(peer, dev);
>>>> +
>>>> +	if (mode == NETKIT_L2)
>>>> +		eth_hw_addr_random(peer);
>>>> +	if (ifmp && dev->ifindex)
>>>> +		peer->ifindex = ifmp->ifi_index;
>>>> +
>>>> +	nk = netkit_priv(peer);
>>>> +	nk->primary = false;
>>>> +	nk->policy = default_peer;
>>>> +	nk->mode = mode;
>>>> +	bpf_mprog_bundle_init(&nk->bundle);
>>>> +	RCU_INIT_POINTER(nk->active, NULL);
>>>> +	RCU_INIT_POINTER(nk->peer, NULL);
>>>
>>> Aren't these already 0?
>>>
>>>
>>
>> Yep, they are. Here decided in favor of explicit show of values, although
>> it's minor and I'm fine either way.
> 
> It is always confusing to see this. Reader might think this is necessary
> as if the mem was not previuosly cleared. The general approach is to
> rely on mem being zeroed, not sure why this is different.
> 
> 

Oh come on :) you really believe someone reading this code would start 
inferring about netdev_alloc mem zeroing instead of getting a mental 
picture of the expected state? Anyway, as I said I think this is way too
minor and it's fine either way, we can remove the explicit 
initialization and rely on the implicit one.

>>
>>>> +
>>>> +	err = register_netdevice(peer);
>>>> +	put_net(net);
>>>> +	if (err < 0)
>>>> +		goto err_register_peer;
>>>> +	netif_carrier_off(peer);
>>>> +	if (mode == NETKIT_L2)
>>>> +		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
>>>> +
>>>> +	err = rtnl_configure_link(peer, NULL, 0, NULL);
>>>> +	if (err < 0)
>>>> +		goto err_configure_peer;
>>>> +
>>>> +	if (mode == NETKIT_L2)
>>>> +		eth_hw_addr_random(dev);
>>>> +	if (tb[IFLA_IFNAME])
>>>> +		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
>>>> +	else
>>>> +		strscpy(dev->name, "nk%d", IFNAMSIZ);
>>>> +
>>>> +	nk = netkit_priv(dev);
>>>> +	nk->primary = true;
>>>> +	nk->policy = default_prim;
>>>> +	nk->mode = mode;
>>>> +	bpf_mprog_bundle_init(&nk->bundle);
>>>> +	RCU_INIT_POINTER(nk->active, NULL);
>>>> +	RCU_INIT_POINTER(nk->peer, NULL);
>>>> +
>>>> +	err = register_netdevice(dev);
>>>> +	if (err < 0)
>>>> +		goto err_configure_peer;
>>>> +	netif_carrier_off(dev);
>>>> +	if (mode == NETKIT_L2)
>>>> +		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
>>>> +
>>>> +	rcu_assign_pointer(netkit_priv(dev)->peer, peer);
>>>> +	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
>>>> +	return 0;
>>>> +err_configure_peer:
>>>> +	unregister_netdevice(peer);
>>>> +	return err;
>>>> +err_register_peer:
>>>> +	free_netdev(peer);
>>>> +	return err;
>>>> +}
>>>> +
>>>
>>> [..]
>>
>> Cheers,
>> Nik
>>


