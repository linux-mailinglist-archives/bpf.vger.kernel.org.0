Return-Path: <bpf+bounces-13253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C57D712D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 17:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7790C281D8D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310E2C87D;
	Wed, 25 Oct 2023 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QPhzU/5Z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7F2AB54
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 15:47:12 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66878131
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:47:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so919403966b.3
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698248828; x=1698853628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt7St37rIKseWM3KjSEFy+jlXydYiULEJ1tiZmCsQbs=;
        b=QPhzU/5ZAuXzg5ZXhIptvqBKFXPPNA7p7p5U0KDawQHP0Kfa6SYdP5M/FCvc+5duOI
         q+pV6Fov3J05NoalzMg7a1bsWXprbXCD5YtwZRITy5xd+zn7QEsyWALvLBDVUWedx4+M
         JNH5JoL2xAKSFKWC4VY9QzZNIVNwoLv1vea+AJaOfPuR14kyf5qFfJpNYno5pg4hdzuP
         b1FNXIzko1l3xF1yBUKVR97IVyyRd5/QzaVUHZVepzGTKu0n681L4AUfqw9uWNsFBAS8
         +OoM70gyRUAjnn/f72ugFwhj1MsAFsCcJFaJGqq113BAB+lEVSzs1o24HJWvTuGnnoDC
         U5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698248828; x=1698853628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt7St37rIKseWM3KjSEFy+jlXydYiULEJ1tiZmCsQbs=;
        b=oztyOSSdRimPp7x9xYjps86NvZ7llqYJ6gx6AiVf75TBtEKPID+4kxS0nsUGIheB4d
         PLuC1/+DRrGspKIP6rE3SgIdkgErmsCGeR5/Xd9MPBgMDXF4bOnHiDMqjU2RxWlY3VwN
         ppiY77fd3WCZSkWkyptbwVu6tBavOcFIkOl9rGezPYRAAEGDSHvVaNWIw0ibNyU4/VPQ
         y+aCjJ9ZvtdqcMdLQ+Ac6K9uG8VloocFAZpyLug1m/375udvt+Vh7LsUzPbsQ4YJN/oC
         N7IMiaSlYDFIw36z5u1VY40VB6uXMrNzC2EqgVNJyqSa4mEXD51lm+B2CwEmEuVj4p0H
         I6Gw==
X-Gm-Message-State: AOJu0Yyhmwcs9JjodnMmxwjQC61vJLmvV3qfi+Js29/3cZyQDyHqdz8U
	e5MvTjAStaCAbGoeiqkNIslbpQ==
X-Google-Smtp-Source: AGHT+IHAS0YwqqQ+OKqxlR5ZgvGYHtOqaDNLMTPyOA3e867qhf78U8qg48nDaB/X2usvqMGaCOB5YQ==
X-Received: by 2002:a17:907:9403:b0:9bd:a5a3:3328 with SMTP id dk3-20020a170907940300b009bda5a33328mr13208921ejc.13.1698248827647;
        Wed, 25 Oct 2023 08:47:07 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906251900b009ca522853ecsm5035529ejb.58.2023.10.25.08.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:47:07 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:47:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
	john.fastabend@gmail.com, sdf@google.com, toke@kernel.org,
	kuba@kernel.org, andrew@lunn.ch,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Message-ID: <ZTk4ec8CBh92PZvs@nanopsycho>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024214904.29825-2-daniel@iogearbox.net>

Tue, Oct 24, 2023 at 11:48:58PM CEST, daniel@iogearbox.net wrote:
>This work adds a new, minimal BPF-programmable device called "netkit"
>(former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
>core idea is that BPF programs are executed within the drivers xmit routine
>and therefore e.g. in case of containers/Pods moving BPF processing closer
>to the source.
>
>One of the goals was that in case of Pod egress traffic, this allows to
>move BPF programs from hostns tcx ingress into the device itself, providing
>earlier drop or forward mechanisms, for example, if the BPF program
>determines that the skb must be sent out of the node, then a redirect to
>the physical device can take place directly without going through per-CPU
>backlog queue. This helps to shift processing for such traffic from softirq
>to process context, leading to better scheduling decisions/performance (see
>measurements in the slides).
>
>In this initial version, the netkit device ships as a pair, but we plan to
>extend this further so it can also operate in single device mode. The pair

Single device mode should work how?


>comes with a primary and a peer device. Only the primary device, typically
>residing in hostns, can manage BPF programs for itself and its peer. The
>peer device is designated for containers/Pods and cannot attach/detach
>BPF programs. Upon the device creation, the user can set the default policy
>to 'pass' or 'drop' for the case when no BPF program is attached.

It looks to me that you only need the host (primary) netdevice to be
used as a handle to attach the bpf programs. Because the bpf program
can (and probably in real use case will) redirect to uplink/another
pod netdevice skipping the host (primary) netdevice, correct?

If so, why can't you do just single device mode from start finding a
different sort of bpf attach handle? (not sure which)


>
>Additionally, the device can be operated in L3 (default) or L2 mode. The
>management of BPF programs is done via bpf_mprog, so that multi-attach is
>supported right from the beginning with similar API and dependency controls
>as tcx. For details on the latter see commit 053c8e1f235d ("bpf: Add generic
>attach/detach/query API for multi-progs"). tc BPF compatibility is provided,
>so that existing programs can be easily migrated.
>
>Going forward, we plan to use netkit devices in Cilium as the main device
>type for connecting Pods. They will be operated in L3 mode in order to
>simplify a Pod's neighbor management and the peer will operate in default
>drop mode, so that no traffic is leaving between the time when a Pod is
>brought up by the CNI plugin and programs attached by the agent.
>Additionally, the programs we attach via tcx on the physical devices are
>using bpf_redirect_peer() for inbound traffic into netkit device, hence the
>latter is also supporting the ndo_get_peer_dev callback. Similarly, we use
>bpf_redirect_neigh() for the way out, pushing from netkit peer to phys device
>directly. Also, BIG TCP is supported on netkit device. For the follow-up
>work in single device mode, we plan to convert Cilium's cilium_host/_net
>devices into a single one.
>
>An extensive test suite for checking device operations and the BPF program
>and link management API comes as BPF selftests in this series.
>

Couple of nitpicks below:

[..]


>+static int netkit_check_policy(int policy, struct nlattr *tb,
>+			       struct netlink_ext_ack *extack)
>+{
>+	switch (policy) {
>+	case NETKIT_PASS:
>+	case NETKIT_DROP:
>+		return 0;
>+	default:

Isn't this job for netlink policy?


>+		NL_SET_ERR_MSG_ATTR(extack, tb,
>+				    "Provided default xmit policy not supported");
>+		return -EINVAL;
>+	}
>+}
>+
>+static int netkit_check_mode(int mode, struct nlattr *tb,
>+			     struct netlink_ext_ack *extack)
>+{
>+	switch (mode) {
>+	case NETKIT_L2:
>+	case NETKIT_L3:
>+		return 0;
>+	default:

Isn't this job for netlink policy?


>+		NL_SET_ERR_MSG_ATTR(extack, tb,
>+				    "Provided device mode can only be L2 or L3");
>+		return -EINVAL;
>+	}
>+}
>+
>+static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
>+			   struct netlink_ext_ack *extack)
>+{
>+	struct nlattr *attr = tb[IFLA_ADDRESS];
>+
>+	if (!attr)
>+		return 0;
>+	NL_SET_ERR_MSG_ATTR(extack, attr,
>+			    "Setting Ethernet address is not supported");
>+	return -EOPNOTSUPP;
>+}
>+
>+static struct rtnl_link_ops netkit_link_ops;
>+
>+static int netkit_new_link(struct net *src_net, struct net_device *dev,
>+			   struct nlattr *tb[], struct nlattr *data[],
>+			   struct netlink_ext_ack *extack)
>+{
>+	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
>+	enum netkit_action default_prim = NETKIT_PASS;
>+	enum netkit_action default_peer = NETKIT_PASS;
>+	enum netkit_mode mode = NETKIT_L3;
>+	unsigned char ifname_assign_type;
>+	struct ifinfomsg *ifmp = NULL;
>+	struct net_device *peer;
>+	char ifname[IFNAMSIZ];
>+	struct netkit *nk;
>+	struct net *net;
>+	int err;
>+
>+	if (data) {
>+		if (data[IFLA_NETKIT_MODE]) {
>+			attr = data[IFLA_NETKIT_MODE];
>+			mode = nla_get_u32(attr);
>+			err = netkit_check_mode(mode, attr, extack);
>+			if (err < 0)
>+				return err;
>+		}
>+		if (data[IFLA_NETKIT_PEER_INFO]) {
>+			attr = data[IFLA_NETKIT_PEER_INFO];
>+			ifmp = nla_data(attr);
>+			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
>+			if (err < 0)
>+				return err;
>+			err = netkit_validate(peer_tb, NULL, extack);
>+			if (err < 0)
>+				return err;
>+			tbp = peer_tb;
>+		}
>+		if (data[IFLA_NETKIT_POLICY]) {
>+			attr = data[IFLA_NETKIT_POLICY];
>+			default_prim = nla_get_u32(attr);
>+			err = netkit_check_policy(default_prim, attr, extack);
>+			if (err < 0)
>+				return err;
>+		}
>+		if (data[IFLA_NETKIT_PEER_POLICY]) {
>+			attr = data[IFLA_NETKIT_PEER_POLICY];
>+			default_peer = nla_get_u32(attr);
>+			err = netkit_check_policy(default_peer, attr, extack);
>+			if (err < 0)
>+				return err;
>+		}
>+	}
>+
>+	if (ifmp && tbp[IFLA_IFNAME]) {
>+		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
>+		ifname_assign_type = NET_NAME_USER;
>+	} else {
>+		strscpy(ifname, "nk%d", IFNAMSIZ);
>+		ifname_assign_type = NET_NAME_ENUM;
>+	}
>+
>+	net = rtnl_link_get_net(src_net, tbp);
>+	if (IS_ERR(net))
>+		return PTR_ERR(net);
>+
>+	peer = rtnl_create_link(net, ifname, ifname_assign_type,
>+				&netkit_link_ops, tbp, extack);
>+	if (IS_ERR(peer)) {
>+		put_net(net);
>+		return PTR_ERR(peer);
>+	}
>+
>+	netif_inherit_tso_max(peer, dev);
>+
>+	if (mode == NETKIT_L2)
>+		eth_hw_addr_random(peer);
>+	if (ifmp && dev->ifindex)
>+		peer->ifindex = ifmp->ifi_index;
>+
>+	nk = netkit_priv(peer);
>+	nk->primary = false;
>+	nk->policy = default_peer;
>+	nk->mode = mode;
>+	bpf_mprog_bundle_init(&nk->bundle);
>+	RCU_INIT_POINTER(nk->active, NULL);
>+	RCU_INIT_POINTER(nk->peer, NULL);

Aren't these already 0?


>+
>+	err = register_netdevice(peer);
>+	put_net(net);
>+	if (err < 0)
>+		goto err_register_peer;
>+	netif_carrier_off(peer);
>+	if (mode == NETKIT_L2)
>+		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
>+
>+	err = rtnl_configure_link(peer, NULL, 0, NULL);
>+	if (err < 0)
>+		goto err_configure_peer;
>+
>+	if (mode == NETKIT_L2)
>+		eth_hw_addr_random(dev);
>+	if (tb[IFLA_IFNAME])
>+		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
>+	else
>+		strscpy(dev->name, "nk%d", IFNAMSIZ);
>+
>+	nk = netkit_priv(dev);
>+	nk->primary = true;
>+	nk->policy = default_prim;
>+	nk->mode = mode;
>+	bpf_mprog_bundle_init(&nk->bundle);
>+	RCU_INIT_POINTER(nk->active, NULL);
>+	RCU_INIT_POINTER(nk->peer, NULL);
>+
>+	err = register_netdevice(dev);
>+	if (err < 0)
>+		goto err_configure_peer;
>+	netif_carrier_off(dev);
>+	if (mode == NETKIT_L2)
>+		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
>+
>+	rcu_assign_pointer(netkit_priv(dev)->peer, peer);
>+	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
>+	return 0;
>+err_configure_peer:
>+	unregister_netdevice(peer);
>+	return err;
>+err_register_peer:
>+	free_netdev(peer);
>+	return err;
>+}
>+

[..]

