Return-Path: <bpf+bounces-13298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20C7D7C2D
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 07:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C867F1C20EA3
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 05:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A90C2D5;
	Thu, 26 Oct 2023 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xf6L22jC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E30C15F
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 05:26:14 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4DDE
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:26:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so650811a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698297970; x=1698902770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtXyM8fj5sYisnLlIIl95PpWU5S/CUUzFbXA9YbH/Y8=;
        b=xf6L22jCaJyQ51VEgtkLOG+kE9WMTvxLFBKp5rozMnxKUbSv9bhSLed6TjOZeT7l/2
         nWZd5D5zIILxyccomXTERAl8kSmxqIH0IggFreZozDwtOdNwExiYxyWVWKje2d1Mf1V8
         eaT36Z9UCdB/mJ+/b/SdJo6sTODSuCpOzl6zi4+3wTQb2llRPiEYoMPZAlt0QVrEy8CB
         tBb4uym0X/XMiA01pTp82KbQaLC/VlZHI41NJZ4TtF2IezEbSjCpWWz4OPohjFoSMmQT
         3tRDc7cXt41fnvs3iLPJW19oJv1xg2eF30j+/+XWyTc4F61siUzj/cfMIvMC4Ks8WEXS
         YFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297970; x=1698902770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtXyM8fj5sYisnLlIIl95PpWU5S/CUUzFbXA9YbH/Y8=;
        b=tX8Y1nPqcsBkAnBs3nju40f/rHvZCCxW0Z2X2pWNrEnQfGj/LxTsclWC1gWEJxyJuG
         u8JZ2QtK066YZ105CC3orZoL5ZVBI97NEFxEUUbK8EutDJuaTkSURDeLvRDGlGsWsg0b
         V0IAmMPLcCurAA4/YqkJADBzFGnh3l/P7dNHfeQYqZwsfw9EvSRfY1+h2zaaUDw6zRcH
         LDtKTUdOivltDG3ZGFjSISHnpAcLJD9+lNHeO+sGhwT89uyrum94rblPiFyvAbI9LBSk
         YdBXYctiYl3rVAFD9IdDkTPCpdaKVPwo9CxFVMqe/A49JZAbXU7VhHvLYrdqVJWwEWl/
         egjw==
X-Gm-Message-State: AOJu0YzdEE2erFolynftB0gnunZB7PNre0xKpYDUZlnuEtpHhEV+HtSO
	84AK9w/arnenyFtPm9hh2Vj+vg==
X-Google-Smtp-Source: AGHT+IFl6trbTB7bLePjEPzggFNnMVyA/BmEWUlUvagV1Ci+n3oz8T7QOVteDBFvM+wWTgcnGXtPLw==
X-Received: by 2002:a17:906:7951:b0:99b:ed44:1a79 with SMTP id l17-20020a170906795100b0099bed441a79mr16391186ejo.3.1698297970270;
        Wed, 25 Oct 2023 22:26:10 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906011a00b009ae69c303aasm10926268eje.137.2023.10.25.22.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:26:09 -0700 (PDT)
Date: Thu, 26 Oct 2023 07:26:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
	andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
	toke@kernel.org, kuba@kernel.org, andrew@lunn.ch,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Message-ID: <ZTn4cOgrCOZAvIUO@nanopsycho>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ZTk4ec8CBh92PZvs@nanopsycho>
 <5df35b1b-0a63-a73f-7a32-c6c87f4676cc@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df35b1b-0a63-a73f-7a32-c6c87f4676cc@blackwall.org>

Wed, Oct 25, 2023 at 09:21:01PM CEST, razor@blackwall.org wrote:
>On 10/25/23 18:47, Jiri Pirko wrote:
>> Tue, Oct 24, 2023 at 11:48:58PM CEST, daniel@iogearbox.net wrote:
>> > This work adds a new, minimal BPF-programmable device called "netkit"
>[snip]
>> 
>> Couple of nitpicks below:
>> 
>> [..]
>> 
>> 
>
>Hi,
>Thanks for the review. I know about the nits below but decided against
>changing them, more below each...
>
>> > +static int netkit_check_policy(int policy, struct nlattr *tb,
>> > +			       struct netlink_ext_ack *extack)
>> > +{
>> > +	switch (policy) {
>> > +	case NETKIT_PASS:
>> > +	case NETKIT_DROP:
>> > +		return 0;
>> > +	default:
>> 
>> Isn't this job for netlink policy?
>> 
>> 
>
>This cannot be handled by policies AFAIK, because only 2 sparse values from
>more are allowed. We could potentially do it through validate() but

Perhaps good time to extend the netlink validation for list
of values allowed?



>it's the same minus the explicit policy type info. IMO this approach is good.
>
>> > +		NL_SET_ERR_MSG_ATTR(extack, tb,
>> > +				    "Provided default xmit policy not supported");
>> > +		return -EINVAL;
>> > +	}
>> > +}
>> > +
>> > +static int netkit_check_mode(int mode, struct nlattr *tb,
>> > +			     struct netlink_ext_ack *extack)
>> > +{
>> > +	switch (mode) {
>> > +	case NETKIT_L2:
>> > +	case NETKIT_L3:
>> > +		return 0;
>> > +	default:
>> 
>> Isn't this job for netlink policy?
>> 
>> 
>
>This one can be handled by policy indeed, but then we lose the nice user
>error. Again can be done through validate(), but it's the same and we
>lose explicit policy type information.

But the netlink validator setups the extack properly. What's wrong with
that?



>
>> > +		NL_SET_ERR_MSG_ATTR(extack, tb,
>> > +				    "Provided device mode can only be L2 or L3");
>> > +		return -EINVAL;
>> > +	}
>> > +}
>> > +
>> > +static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
>> > +			   struct netlink_ext_ack *extack)
>> > +{
>> > +	struct nlattr *attr = tb[IFLA_ADDRESS];
>> > +
>> > +	if (!attr)
>> > +		return 0;
>> > +	NL_SET_ERR_MSG_ATTR(extack, attr,
>> > +			    "Setting Ethernet address is not supported");
>> > +	return -EOPNOTSUPP;
>> > +}
>> > +
>> > +static struct rtnl_link_ops netkit_link_ops;
>> > +
>> > +static int netkit_new_link(struct net *src_net, struct net_device *dev,
>> > +			   struct nlattr *tb[], struct nlattr *data[],
>> > +			   struct netlink_ext_ack *extack)
>> > +{
>> > +	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
>> > +	enum netkit_action default_prim = NETKIT_PASS;
>> > +	enum netkit_action default_peer = NETKIT_PASS;
>> > +	enum netkit_mode mode = NETKIT_L3;
>> > +	unsigned char ifname_assign_type;
>> > +	struct ifinfomsg *ifmp = NULL;
>> > +	struct net_device *peer;
>> > +	char ifname[IFNAMSIZ];
>> > +	struct netkit *nk;
>> > +	struct net *net;
>> > +	int err;
>> > +
>> > +	if (data) {
>> > +		if (data[IFLA_NETKIT_MODE]) {
>> > +			attr = data[IFLA_NETKIT_MODE];
>> > +			mode = nla_get_u32(attr);
>> > +			err = netkit_check_mode(mode, attr, extack);
>> > +			if (err < 0)
>> > +				return err;
>> > +		}
>> > +		if (data[IFLA_NETKIT_PEER_INFO]) {
>> > +			attr = data[IFLA_NETKIT_PEER_INFO];
>> > +			ifmp = nla_data(attr);
>> > +			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
>> > +			if (err < 0)
>> > +				return err;
>> > +			err = netkit_validate(peer_tb, NULL, extack);
>> > +			if (err < 0)
>> > +				return err;
>> > +			tbp = peer_tb;
>> > +		}
>> > +		if (data[IFLA_NETKIT_POLICY]) {
>> > +			attr = data[IFLA_NETKIT_POLICY];
>> > +			default_prim = nla_get_u32(attr);
>> > +			err = netkit_check_policy(default_prim, attr, extack);
>> > +			if (err < 0)
>> > +				return err;
>> > +		}
>> > +		if (data[IFLA_NETKIT_PEER_POLICY]) {
>> > +			attr = data[IFLA_NETKIT_PEER_POLICY];
>> > +			default_peer = nla_get_u32(attr);
>> > +			err = netkit_check_policy(default_peer, attr, extack);
>> > +			if (err < 0)
>> > +				return err;
>> > +		}
>> > +	}
>> > +
>> > +	if (ifmp && tbp[IFLA_IFNAME]) {
>> > +		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
>> > +		ifname_assign_type = NET_NAME_USER;
>> > +	} else {
>> > +		strscpy(ifname, "nk%d", IFNAMSIZ);
>> > +		ifname_assign_type = NET_NAME_ENUM;
>> > +	}
>> > +
>> > +	net = rtnl_link_get_net(src_net, tbp);
>> > +	if (IS_ERR(net))
>> > +		return PTR_ERR(net);
>> > +
>> > +	peer = rtnl_create_link(net, ifname, ifname_assign_type,
>> > +				&netkit_link_ops, tbp, extack);
>> > +	if (IS_ERR(peer)) {
>> > +		put_net(net);
>> > +		return PTR_ERR(peer);
>> > +	}
>> > +
>> > +	netif_inherit_tso_max(peer, dev);
>> > +
>> > +	if (mode == NETKIT_L2)
>> > +		eth_hw_addr_random(peer);
>> > +	if (ifmp && dev->ifindex)
>> > +		peer->ifindex = ifmp->ifi_index;
>> > +
>> > +	nk = netkit_priv(peer);
>> > +	nk->primary = false;
>> > +	nk->policy = default_peer;
>> > +	nk->mode = mode;
>> > +	bpf_mprog_bundle_init(&nk->bundle);
>> > +	RCU_INIT_POINTER(nk->active, NULL);
>> > +	RCU_INIT_POINTER(nk->peer, NULL);
>> 
>> Aren't these already 0?
>> 
>> 
>
>Yep, they are. Here decided in favor of explicit show of values, although
>it's minor and I'm fine either way.

It is always confusing to see this. Reader might think this is necessary
as if the mem was not previuosly cleared. The general approach is to
rely on mem being zeroed, not sure why this is different.


>
>> > +
>> > +	err = register_netdevice(peer);
>> > +	put_net(net);
>> > +	if (err < 0)
>> > +		goto err_register_peer;
>> > +	netif_carrier_off(peer);
>> > +	if (mode == NETKIT_L2)
>> > +		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
>> > +
>> > +	err = rtnl_configure_link(peer, NULL, 0, NULL);
>> > +	if (err < 0)
>> > +		goto err_configure_peer;
>> > +
>> > +	if (mode == NETKIT_L2)
>> > +		eth_hw_addr_random(dev);
>> > +	if (tb[IFLA_IFNAME])
>> > +		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
>> > +	else
>> > +		strscpy(dev->name, "nk%d", IFNAMSIZ);
>> > +
>> > +	nk = netkit_priv(dev);
>> > +	nk->primary = true;
>> > +	nk->policy = default_prim;
>> > +	nk->mode = mode;
>> > +	bpf_mprog_bundle_init(&nk->bundle);
>> > +	RCU_INIT_POINTER(nk->active, NULL);
>> > +	RCU_INIT_POINTER(nk->peer, NULL);
>> > +
>> > +	err = register_netdevice(dev);
>> > +	if (err < 0)
>> > +		goto err_configure_peer;
>> > +	netif_carrier_off(dev);
>> > +	if (mode == NETKIT_L2)
>> > +		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
>> > +
>> > +	rcu_assign_pointer(netkit_priv(dev)->peer, peer);
>> > +	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
>> > +	return 0;
>> > +err_configure_peer:
>> > +	unregister_netdevice(peer);
>> > +	return err;
>> > +err_register_peer:
>> > +	free_netdev(peer);
>> > +	return err;
>> > +}
>> > +
>> 
>> [..]
>
>Cheers,
> Nik
>

