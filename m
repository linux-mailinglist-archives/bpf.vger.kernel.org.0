Return-Path: <bpf+bounces-13144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93D7D58D2
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83AF281B18
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C83A290;
	Tue, 24 Oct 2023 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUdO4JI+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A03A296
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 16:40:20 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C9B170E
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 09:40:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6b1cec068a9so4753053b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698165613; x=1698770413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt/uTtXrgACEfXEtWGgkAOpZEv01TLxeimd0PkICOtU=;
        b=cUdO4JI+hNuJJ16wjUhlgqqTJd54QDY1Q41OJVT621c+3ZzAc7smA2vXeZdJZRad72
         jYT8S15V36ediKV0gdg5ADA7JwMwqFFdHIGXbrftMv/9cm3IKujQfr8KN/9RLincOW2G
         j35MDzl/LV8r+F0V55jhcZDWdmjK/7RRGRwbH+E5JKa6U9qJksIfmzi2gpGoou41IS+q
         zctqI3SB/x3rajhJrGCQ2ML3VqPi1yVkG3q6N8BmhIZXA6gTdXtOVq7smt3vYIMNV+ug
         lWPuC5r6FurB1O3Wupxs4sc5f3Id2KtSVgVDKyhjJgX5tfSrS+S8x0d060OJH3KoVuJX
         4jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165613; x=1698770413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt/uTtXrgACEfXEtWGgkAOpZEv01TLxeimd0PkICOtU=;
        b=WBb+M7yYN5MQmpoNwsM6maQ+mkkrRFVDPPUZx/CZB3hLHCoZjAPpT4AaXIxnNlbWiJ
         SU1as65ppFWLpLTg2KOvY8foZlFywvHblP9cwrxQKvUWAkOlBAnZ5TpGEJrkhO4P40yL
         Eeku57djbr8PSWeMCTKGpGqWp2sliI8FLlpofJTFzvqh7nHbsI5sk4ZFOYaKA71VLj7t
         pU1WloV+rjgxRFlKnQDxo9czVOoy9g02Hw59x0aXOLwRtSMMnZWQg+qxmlG/lTSBwo4e
         64N8LiJYMe1o7KLVDPHdKq2UcpDWqLgYpPliVifILvCKgXmKvES8NBgpX5vP0O8PZzKR
         AlQw==
X-Gm-Message-State: AOJu0YyKXroOUNUXmeHQRuTttgH2TlaaJCzXXQ+ns0mTPQuNrCyvJN0T
	SDxnKy+XgEhlMyqaXv4JrAZrt40=
X-Google-Smtp-Source: AGHT+IFgmWXhLuyo39+MvlVm1/bsvhIjh/7Ty0LStNJkCvRJg890zhTXuaI2gucx223siUhBRX+zzRk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:80d6:b0:693:4071:cd64 with SMTP id
 ei22-20020a056a0080d600b006934071cd64mr293019pfb.1.1698165613395; Tue, 24 Oct
 2023 09:40:13 -0700 (PDT)
Date: Tue, 24 Oct 2023 09:40:11 -0700
In-Reply-To: <20231023171856.18324-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231023171856.18324-1-daniel@iogearbox.net> <20231023171856.18324-2-daniel@iogearbox.net>
Message-ID: <ZTfza8hC_79X10F8@google.com>
Subject: Re: [PATCH bpf-next v3 1/7] netkit, bpf: Add bpf programmable net device
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com, toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="utf-8"

On 10/23, Daniel Borkmann wrote:
> This work adds a new, minimal BPF-programmable device called "netkit"
> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
> core idea is that BPF programs are executed within the drivers xmit routine
> and therefore e.g. in case of containers/Pods moving BPF processing closer
> to the source.
> 
> One of the goals was that in case of Pod egress traffic, this allows to
> move BPF programs from hostns tcx ingress into the device itself, providing
> earlier drop or forward mechanisms, for example, if the BPF program
> determines that the skb must be sent out of the node, then a redirect to
> the physical device can take place directly without going through per-CPU
> backlog queue. This helps to shift processing for such traffic from softirq
> to process context, leading to better scheduling decisions/performance (see
> measurements in the slides).
> 
> In this initial version, the netkit device ships as a pair, but we plan to
> extend this further so it can also operate in single device mode. The pair
> comes with a primary and a peer device. Only the primary device, typically
> residing in hostns, can manage BPF programs for itself and its peer. The
> peer device is designated for containers/Pods and cannot attach/detach
> BPF programs. Upon the device creation, the user can set the default policy
> to 'forward' or 'drop' for the case when no BPF program is attached.
> 
> Additionally, the device can be operated in L3 (default) or L2 mode. The
> management of BPF programs is done via bpf_mprog, so that multi-attach is
> supported right from the beginning with similar API and dependency controls
> as tcx. For details on the latter see commit 053c8e1f235d ("bpf: Add generic
> attach/detach/query API for multi-progs"). tc BPF compatibility is provided,
> so that existing programs can be easily migrated.
> 
> Going forward, we plan to use netkit devices in Cilium as the main device
> type for connecting Pods. They will be operated in L3 mode in order to
> simplify a Pod's neighbor management and the peer will operate in default
> drop mode, so that no traffic is leaving between the time when a Pod is
> brought up by the CNI plugin and programs attached by the agent.
> Additionally, the programs we attach via tcx on the physical devices are
> using bpf_redirect_peer() for inbound traffic into netkit device, hence the
> latter is also supporting the ndo_get_peer_dev callback. Similarly, we use
> bpf_redirect_neigh() for the way out, pushing from netkit peer to phys device
> directly. Also, BIG TCP is supported on netkit device. For the follow-up
> work in single device mode, we plan to convert Cilium's cilium_host/_net
> devices into a single one.
> 
> An extensive test suite for checking device operations and the BPF program
> and link management API comes as BPF selftests in this series.
> 
> Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://github.com/borkmann/iproute2/tree/pr/netkit
> Link: http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkmann.pdf (24ff.)
> ---
>  MAINTAINERS                    |   9 +
>  drivers/net/Kconfig            |   9 +
>  drivers/net/Makefile           |   1 +
>  drivers/net/netkit.c           | 934 +++++++++++++++++++++++++++++++++
>  include/net/netkit.h           |  38 ++
>  include/uapi/linux/bpf.h       |  14 +
>  include/uapi/linux/if_link.h   |  24 +
>  kernel/bpf/syscall.c           |  30 +-
>  tools/include/uapi/linux/bpf.h |  14 +
>  9 files changed, 1068 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/net/netkit.c
>  create mode 100644 include/net/netkit.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ed33b9df8b3d..43be6197e655 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3795,6 +3795,15 @@ L:	bpf@vger.kernel.org
>  S:	Odd Fixes
>  K:	(?:\b|_)bpf(?:\b|_)
>  
> +BPF [NETKIT] (BPF-programmable network device)
> +M:	Daniel Borkmann <daniel@iogearbox.net>
> +M:	Nikolay Aleksandrov <razor@blackwall.org>
> +L:	bpf@vger.kernel.org
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	drivers/net/netkit.c
> +F:	include/net/netkit.h
> +
>  BPF [NETWORKING] (struct_ops, reuseport)
>  M:	Martin KaFai Lau <martin.lau@linux.dev>
>  L:	bpf@vger.kernel.org
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 44eeb5d61ba9..af0da4bb429b 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -448,6 +448,15 @@ config NLMON
>  	  diagnostics, etc. This is mostly intended for developers or support
>  	  to debug netlink issues. If unsure, say N.
>  
> +config NETKIT
> +	bool "BPF-programmable network device"
> +	depends on BPF_SYSCALL
> +	help
> +	  The netkit device is a virtual networking device where BPF programs
> +	  can be attached to the device(s) transmission routine in order to
> +	  implement the driver's internal logic. The device can be configured
> +	  to operate in L3 or L2 mode. If unsure, say N.
> +
>  config NET_VRF
>  	tristate "Virtual Routing and Forwarding (Lite)"
>  	depends on IP_MULTIPLE_TABLES
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 8a83db32509d..7cab36f94782 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO) += mdio.o
>  obj-$(CONFIG_NET) += loopback.o
>  obj-$(CONFIG_NETDEV_LEGACY_INIT) += Space.o
>  obj-$(CONFIG_NETCONSOLE) += netconsole.o
> +obj-$(CONFIG_NETKIT) += netkit.o
>  obj-y += phy/
>  obj-y += pse-pd/
>  obj-y += mdio/
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> new file mode 100644
> index 000000000000..faf756702aa1
> --- /dev/null
> +++ b/drivers/net/netkit.c
> @@ -0,0 +1,934 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2023 Isovalent */
> +
> +#include <linux/netdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/etherdevice.h>
> +#include <linux/filter.h>
> +#include <linux/netfilter_netdev.h>
> +#include <linux/bpf_mprog.h>
> +
> +#include <net/netkit.h>
> +#include <net/dst.h>
> +#include <net/tcx.h>
> +
> +#define DRV_NAME "netkit"
> +
> +struct netkit {
> +	/* Needed in fast-path */
> +	struct net_device __rcu *peer;
> +	struct bpf_mprog_entry __rcu *active;
> +	enum netkit_action policy;
> +	struct bpf_mprog_bundle	bundle;
> +
> +	/* Needed in slow-path */
> +	enum netkit_mode mode;
> +	bool primary;
> +	u32 headroom;
> +};
> +
> +struct netkit_link {
> +	struct bpf_link link;
> +	struct net_device *dev;
> +	u32 location;
> +};
> +
> +static __always_inline int
> +netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
> +	   enum netkit_action ret)
> +{
> +	const struct bpf_mprog_fp *fp;
> +	const struct bpf_prog *prog;
> +
> +	bpf_mprog_foreach_prog(entry, fp, prog) {
> +		bpf_compute_data_pointers(skb);
> +		ret = bpf_prog_run(prog, skb);
> +		if (ret != NETKIT_NEXT)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +static void netkit_prep_forward(struct sk_buff *skb, bool xnet)
> +{
> +	skb_scrub_packet(skb, xnet);
> +	skb->priority = 0;
> +	nf_skip_egress(skb, true);
> +}
> +
> +static struct netkit *netkit_priv(const struct net_device *dev)
> +{
> +	return netdev_priv(dev);
> +}
> +
> +static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	enum netkit_action ret = READ_ONCE(nk->policy);
> +	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
> +	const struct bpf_mprog_entry *entry;
> +	struct net_device *peer;
> +
> +	rcu_read_lock();
> +	peer = rcu_dereference(nk->peer);
> +	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
> +		     !pskb_may_pull(skb, ETH_HLEN) ||
> +		     skb_orphan_frags(skb, GFP_ATOMIC)))
> +		goto drop;
> +	netkit_prep_forward(skb, !net_eq(dev_net(dev), dev_net(peer)));
> +	skb->dev = peer;
> +	entry = rcu_dereference(nk->active);
> +	if (entry)
> +		ret = netkit_run(entry, skb, ret);
> +	switch (ret) {
> +	case NETKIT_NEXT:
> +	case NETKIT_PASS:
> +		skb->protocol = eth_type_trans(skb, skb->dev);
> +		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
> +		__netif_rx(skb);
> +		break;
> +	case NETKIT_REDIRECT:
> +		skb_do_redirect(skb);
> +		break;
> +	case NETKIT_DROP:
> +	default:
> +drop:
> +		kfree_skb(skb);
> +		dev_core_stats_tx_dropped_inc(dev);
> +		ret_dev = NET_XMIT_DROP;
> +		break;
> +	}
> +	rcu_read_unlock();
> +	return ret_dev;
> +}
> +
> +static int netkit_open(struct net_device *dev)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	struct net_device *peer = rtnl_dereference(nk->peer);
> +
> +	if (!peer)
> +		return -ENOTCONN;
> +	if (peer->flags & IFF_UP) {
> +		netif_carrier_on(dev);
> +		netif_carrier_on(peer);
> +	}
> +	return 0;
> +}
> +
> +static int netkit_close(struct net_device *dev)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	struct net_device *peer = rtnl_dereference(nk->peer);
> +
> +	netif_carrier_off(dev);
> +	if (peer)
> +		netif_carrier_off(peer);
> +	return 0;
> +}
> +
> +static int netkit_get_iflink(const struct net_device *dev)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	struct net_device *peer;
> +	int iflink = 0;
> +
> +	rcu_read_lock();
> +	peer = rcu_dereference(nk->peer);
> +	if (peer)
> +		iflink = peer->ifindex;
> +	rcu_read_unlock();
> +	return iflink;
> +}
> +
> +static void netkit_set_multicast(struct net_device *dev)
> +{
> +	/* Nothing to do, we receive whatever gets pushed to us! */
> +}
> +
> +static void netkit_set_headroom(struct net_device *dev, int headroom)
> +{
> +	struct netkit *nk = netkit_priv(dev), *nk2;
> +	struct net_device *peer;
> +
> +	if (headroom < 0)
> +		headroom = NET_SKB_PAD;
> +
> +	rcu_read_lock();
> +	peer = rcu_dereference(nk->peer);
> +	if (unlikely(!peer))
> +		goto out;
> +
> +	nk2 = netkit_priv(peer);
> +	nk->headroom = headroom;
> +	headroom = max(nk->headroom, nk2->headroom);
> +
> +	peer->needed_headroom = headroom;
> +	dev->needed_headroom = headroom;
> +out:
> +	rcu_read_unlock();
> +}
> +
> +static struct net_device *netkit_peer_dev(struct net_device *dev)
> +{
> +	return rcu_dereference(netkit_priv(dev)->peer);
> +}
> +
> +static const struct net_device_ops netkit_netdev_ops = {
> +	.ndo_open		= netkit_open,
> +	.ndo_stop		= netkit_close,
> +	.ndo_start_xmit		= netkit_xmit,
> +	.ndo_set_rx_mode	= netkit_set_multicast,
> +	.ndo_set_rx_headroom	= netkit_set_headroom,
> +	.ndo_get_iflink		= netkit_get_iflink,
> +	.ndo_get_peer_dev	= netkit_peer_dev,
> +	.ndo_features_check	= passthru_features_check,
> +};
> +
> +static void netkit_get_drvinfo(struct net_device *dev,
> +			       struct ethtool_drvinfo *info)
> +{
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +}
> +
> +static const struct ethtool_ops netkit_ethtool_ops = {
> +	.get_drvinfo		= netkit_get_drvinfo,
> +};
> +
> +static void netkit_setup(struct net_device *dev)
> +{
> +	static const netdev_features_t netkit_features_hw_vlan =
> +		NETIF_F_HW_VLAN_CTAG_TX |
> +		NETIF_F_HW_VLAN_CTAG_RX |
> +		NETIF_F_HW_VLAN_STAG_TX |
> +		NETIF_F_HW_VLAN_STAG_RX;
> +	static const netdev_features_t netkit_features =
> +		netkit_features_hw_vlan |
> +		NETIF_F_SG |
> +		NETIF_F_FRAGLIST |
> +		NETIF_F_HW_CSUM |
> +		NETIF_F_RXCSUM |
> +		NETIF_F_SCTP_CRC |
> +		NETIF_F_HIGHDMA |
> +		NETIF_F_GSO_SOFTWARE |
> +		NETIF_F_GSO_ENCAP_ALL;
> +
> +	ether_setup(dev);
> +	dev->max_mtu = ETH_MAX_MTU;
> +
> +	dev->flags |= IFF_NOARP;
> +	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
> +	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +	dev->priv_flags |= IFF_PHONY_HEADROOM;
> +	dev->priv_flags |= IFF_NO_QUEUE;
> +
> +	dev->ethtool_ops = &netkit_ethtool_ops;
> +	dev->netdev_ops  = &netkit_netdev_ops;
> +
> +	dev->features |= netkit_features | NETIF_F_LLTX;
> +	dev->hw_features = netkit_features;
> +	dev->hw_enc_features = netkit_features;
> +	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
> +	dev->vlan_features = dev->features & ~netkit_features_hw_vlan;
> +
> +	dev->needs_free_netdev = true;
> +
> +	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> +}
> +
> +static struct net *netkit_get_link_net(const struct net_device *dev)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	struct net_device *peer = rtnl_dereference(nk->peer);
> +
> +	return peer ? dev_net(peer) : dev_net(dev);
> +}
> +
> +static int netkit_check_policy(int policy, struct nlattr *tb,
> +			       struct netlink_ext_ack *extack)
> +{
> +	switch (policy) {
> +	case NETKIT_PASS:
> +	case NETKIT_DROP:
> +		return 0;
> +	default:
> +		NL_SET_ERR_MSG_ATTR(extack, tb,
> +				    "Provided default xmit policy not supported");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int netkit_check_mode(int mode, struct nlattr *tb,
> +			     struct netlink_ext_ack *extack)
> +{
> +	switch (mode) {
> +	case NETKIT_L2:
> +	case NETKIT_L3:
> +		return 0;
> +	default:
> +		NL_SET_ERR_MSG_ATTR(extack, tb,
> +				    "Provided device mode can only be L2 or L3");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *attr = tb[IFLA_ADDRESS];
> +
> +	if (!attr)
> +		return 0;
> +	NL_SET_ERR_MSG_ATTR(extack, attr,
> +			    "Setting Ethernet address is not supported");
> +	return -EOPNOTSUPP;
> +}
> +
> +static struct rtnl_link_ops netkit_link_ops;
> +
> +static int netkit_new_link(struct net *src_net, struct net_device *dev,
> +			   struct nlattr *tb[], struct nlattr *data[],
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
> +	enum netkit_action default_prim = NETKIT_PASS;
> +	enum netkit_action default_peer = NETKIT_PASS;
> +	enum netkit_mode mode = NETKIT_L3;
> +	unsigned char ifname_assign_type;
> +	struct ifinfomsg *ifmp = NULL;
> +	struct net_device *peer;
> +	char ifname[IFNAMSIZ];
> +	struct netkit *nk;
> +	struct net *net;
> +	int err;
> +
> +	if (data) {
> +		if (data[IFLA_NETKIT_MODE]) {
> +			attr = data[IFLA_NETKIT_MODE];
> +			mode = nla_get_u32(attr);
> +			err = netkit_check_mode(mode, attr, extack);
> +			if (err < 0)
> +				return err;
> +		}
> +		if (data[IFLA_NETKIT_PEER_INFO]) {
> +			attr = data[IFLA_NETKIT_PEER_INFO];
> +			ifmp = nla_data(attr);
> +			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
> +			if (err < 0)
> +				return err;
> +			err = netkit_validate(peer_tb, NULL, extack);
> +			if (err < 0)
> +				return err;
> +			tbp = peer_tb;
> +		}
> +		if (data[IFLA_NETKIT_POLICY]) {
> +			attr = data[IFLA_NETKIT_POLICY];
> +			default_prim = nla_get_u32(attr);
> +			err = netkit_check_policy(default_prim, attr, extack);
> +			if (err < 0)
> +				return err;
> +		}
> +		if (data[IFLA_NETKIT_PEER_POLICY]) {
> +			attr = data[IFLA_NETKIT_PEER_POLICY];
> +			default_peer = nla_get_u32(attr);
> +			err = netkit_check_policy(default_peer, attr, extack);
> +			if (err < 0)
> +				return err;
> +		}
> +	}
> +
> +	if (ifmp && tbp[IFLA_IFNAME]) {
> +		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
> +		ifname_assign_type = NET_NAME_USER;
> +	} else {
> +		strscpy(ifname, "nk%d", IFNAMSIZ);
> +		ifname_assign_type = NET_NAME_ENUM;
> +	}
> +
> +	net = rtnl_link_get_net(src_net, tbp);
> +	if (IS_ERR(net))
> +		return PTR_ERR(net);
> +
> +	peer = rtnl_create_link(net, ifname, ifname_assign_type,
> +				&netkit_link_ops, tbp, extack);
> +	if (IS_ERR(peer)) {
> +		put_net(net);
> +		return PTR_ERR(peer);
> +	}
> +
> +	netif_inherit_tso_max(peer, dev);
> +
> +	if (mode == NETKIT_L2)
> +		eth_hw_addr_random(peer);
> +	if (ifmp && dev->ifindex)
> +		peer->ifindex = ifmp->ifi_index;
> +
> +	nk = netkit_priv(peer);
> +	nk->primary = false;
> +	nk->policy = default_peer;
> +	nk->mode = mode;
> +	bpf_mprog_bundle_init(&nk->bundle);
> +	RCU_INIT_POINTER(nk->active, NULL);
> +	RCU_INIT_POINTER(nk->peer, NULL);
> +
> +	err = register_netdevice(peer);
> +	put_net(net);
> +	if (err < 0)
> +		goto err_register_peer;
> +	netif_carrier_off(peer);
> +	if (mode == NETKIT_L2)
> +		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
> +
> +	err = rtnl_configure_link(peer, NULL, 0, NULL);
> +	if (err < 0)
> +		goto err_configure_peer;
> +
> +	if (mode == NETKIT_L2)
> +		eth_hw_addr_random(dev);
> +	if (tb[IFLA_IFNAME])
> +		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
> +	else
> +		strscpy(dev->name, "nk%d", IFNAMSIZ);
> +
> +	nk = netkit_priv(dev);
> +	nk->primary = true;
> +	nk->policy = default_prim;
> +	nk->mode = mode;
> +	bpf_mprog_bundle_init(&nk->bundle);
> +	RCU_INIT_POINTER(nk->active, NULL);
> +	RCU_INIT_POINTER(nk->peer, NULL);
> +
> +	err = register_netdevice(dev);
> +	if (err < 0)
> +		goto err_configure_peer;
> +	netif_carrier_off(dev);
> +	if (mode == NETKIT_L2)
> +		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
> +
> +	rcu_assign_pointer(netkit_priv(dev)->peer, peer);
> +	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
> +	return 0;
> +err_configure_peer:
> +	unregister_netdevice(peer);
> +	return err;
> +err_register_peer:
> +	free_netdev(peer);
> +	return err;
> +}
> +
> +static struct bpf_mprog_entry *netkit_entry_fetch(struct net_device *dev,
> +						  bool bundle_fallback)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	struct bpf_mprog_entry *entry;
> +
> +	ASSERT_RTNL();
> +	entry = rcu_dereference_rtnl(nk->active);
> +	if (entry)
> +		return entry;
> +	if (bundle_fallback)
> +		return &nk->bundle.a;
> +	return NULL;
> +}
> +
> +static void netkit_entry_update(struct net_device *dev,
> +				struct bpf_mprog_entry *entry)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +
> +	ASSERT_RTNL();
> +	rcu_assign_pointer(nk->active, entry);
> +}
> +
> +static void netkit_entry_sync(void)
> +{
> +	synchronize_rcu();
> +}
> +
> +static struct net_device *netkit_dev_fetch(struct net *net, u32 ifindex, u32 which)
> +{
> +	struct net_device *dev;
> +	struct netkit *nk;
> +
> +	ASSERT_RTNL();
> +
> +	switch (which) {
> +	case BPF_NETKIT_PRIMARY:
> +	case BPF_NETKIT_PEER:
> +		break;
> +	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dev = __dev_get_by_index(net, ifindex);
> +	if (!dev)
> +		return ERR_PTR(-ENODEV);
> +	if (dev->netdev_ops != &netkit_netdev_ops)
> +		return ERR_PTR(-ENXIO);
> +
> +	nk = netkit_priv(dev);
> +	if (!nk->primary)
> +		return ERR_PTR(-EACCES);
> +	if (which == BPF_NETKIT_PEER) {
> +		dev = rcu_dereference_rtnl(nk->peer);
> +		if (!dev)
> +			return ERR_PTR(-ENODEV);
> +	}
> +	return dev;
> +}
> +
> +int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_mprog_entry *entry, *entry_new;
> +	struct bpf_prog *replace_prog = NULL;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rtnl_lock();
> +	dev = netkit_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
> +			       attr->attach_type);
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		goto out;
> +	}
> +	entry = netkit_entry_fetch(dev, true);
> +	if (attr->attach_flags & BPF_F_REPLACE) {
> +		replace_prog = bpf_prog_get_type(attr->replace_bpf_fd,
> +						 prog->type);
> +		if (IS_ERR(replace_prog)) {
> +			ret = PTR_ERR(replace_prog);
> +			replace_prog = NULL;
> +			goto out;
> +		}
> +	}
> +	ret = bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_prog,
> +			       attr->attach_flags, attr->relative_fd,
> +			       attr->expected_revision);
> +	if (!ret) {
> +		if (entry != entry_new) {
> +			netkit_entry_update(dev, entry_new);
> +			netkit_entry_sync();
> +		}
> +		bpf_mprog_commit(entry);
> +	}
> +out:
> +	if (replace_prog)
> +		bpf_prog_put(replace_prog);
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +int netkit_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_mprog_entry *entry, *entry_new;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rtnl_lock();
> +	dev = netkit_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
> +			       attr->attach_type);
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		goto out;
> +	}
> +	entry = netkit_entry_fetch(dev, false);
> +	if (!entry) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +	ret = bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->attach_flags,
> +			       attr->relative_fd, attr->expected_revision);
> +	if (!ret) {
> +		if (!bpf_mprog_total(entry_new))
> +			entry_new = NULL;
> +		netkit_entry_update(dev, entry_new);
> +		netkit_entry_sync();
> +		bpf_mprog_commit(entry);
> +	}
> +out:
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
> +{
> +	struct net_device *dev;
> +	int ret;
> +
> +	rtnl_lock();
> +	dev = netkit_dev_fetch(current->nsproxy->net_ns,
> +			       attr->query.target_ifindex,
> +			       attr->query.attach_type);
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		goto out;
> +	}
> +	ret = bpf_mprog_query(attr, uattr, netkit_entry_fetch(dev, false));
> +out:
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +static struct netkit_link *netkit_link(const struct bpf_link *link)
> +{
> +	return container_of(link, struct netkit_link, link);
> +}
> +
> +static int netkit_link_prog_attach(struct bpf_link *link, u32 flags,
> +				   u32 id_or_fd, u64 revision)
> +{
> +	struct netkit_link *nkl = netkit_link(link);
> +	struct bpf_mprog_entry *entry, *entry_new;
> +	struct net_device *dev = nkl->dev;
> +	int ret;
> +
> +	ASSERT_RTNL();
> +	entry = netkit_entry_fetch(dev, true);
> +	ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, flags,
> +			       id_or_fd, revision);
> +	if (!ret) {
> +		if (entry != entry_new) {
> +			netkit_entry_update(dev, entry_new);
> +			netkit_entry_sync();
> +		}
> +		bpf_mprog_commit(entry);
> +	}
> +	return ret;
> +}
> +
> +static void netkit_link_release(struct bpf_link *link)
> +{
> +	struct netkit_link *nkl = netkit_link(link);
> +	struct bpf_mprog_entry *entry, *entry_new;
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rtnl_lock();
> +	dev = nkl->dev;
> +	if (!dev)
> +		goto out;
> +	entry = netkit_entry_fetch(dev, false);
> +	if (!entry) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +	ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0);
> +	if (!ret) {
> +		if (!bpf_mprog_total(entry_new))
> +			entry_new = NULL;
> +		netkit_entry_update(dev, entry_new);
> +		netkit_entry_sync();
> +		bpf_mprog_commit(entry);
> +		nkl->dev = NULL;
> +	}
> +out:
> +	WARN_ON_ONCE(ret);
> +	rtnl_unlock();
> +}
> +
> +static int netkit_link_update(struct bpf_link *link, struct bpf_prog *nprog,
> +			      struct bpf_prog *oprog)
> +{
> +	struct netkit_link *nkl = netkit_link(link);
> +	struct bpf_mprog_entry *entry, *entry_new;
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rtnl_lock();
> +	dev = nkl->dev;
> +	if (!dev) {
> +		ret = -ENOLINK;
> +		goto out;
> +	}
> +	if (oprog && link->prog != oprog) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +	oprog = link->prog;
> +	if (oprog == nprog) {
> +		bpf_prog_put(nprog);
> +		goto out;
> +	}
> +	entry = netkit_entry_fetch(dev, false);
> +	if (!entry) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +	ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
> +			       BPF_F_REPLACE | BPF_F_ID,
> +			       link->prog->aux->id, 0);
> +	if (!ret) {
> +		WARN_ON_ONCE(entry != entry_new);
> +		oprog = xchg(&link->prog, nprog);
> +		bpf_prog_put(oprog);
> +		bpf_mprog_commit(entry);
> +	}
> +out:
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +static void netkit_link_dealloc(struct bpf_link *link)
> +{
> +	kfree(netkit_link(link));
> +}
> +
> +static void netkit_link_fdinfo(const struct bpf_link *link, struct seq_file *seq)
> +{
> +	const struct netkit_link *nkl = netkit_link(link);
> +	u32 ifindex = 0;
> +
> +	rtnl_lock();
> +	if (nkl->dev)
> +		ifindex = nkl->dev->ifindex;
> +	rtnl_unlock();
> +
> +	seq_printf(seq, "ifindex:\t%u\n", ifindex);
> +	seq_printf(seq, "attach_type:\t%u (%s)\n",
> +		   nkl->location,
> +		   nkl->location == BPF_NETKIT_PRIMARY ? "primary" : "peer");
> +}
> +
> +static int netkit_link_fill_info(const struct bpf_link *link,
> +				 struct bpf_link_info *info)
> +{
> +	const struct netkit_link *nkl = netkit_link(link);
> +	u32 ifindex = 0;
> +
> +	rtnl_lock();
> +	if (nkl->dev)
> +		ifindex = nkl->dev->ifindex;
> +	rtnl_unlock();
> +
> +	info->netkit.ifindex = ifindex;
> +	info->netkit.attach_type = nkl->location;
> +	return 0;
> +}
> +
> +static int netkit_link_detach(struct bpf_link *link)
> +{
> +	netkit_link_release(link);
> +	return 0;
> +}
> +
> +static const struct bpf_link_ops netkit_link_lops = {
> +	.release	= netkit_link_release,
> +	.detach		= netkit_link_detach,
> +	.dealloc	= netkit_link_dealloc,
> +	.update_prog	= netkit_link_update,
> +	.show_fdinfo	= netkit_link_fdinfo,
> +	.fill_link_info	= netkit_link_fill_info,
> +};
> +
> +static int netkit_link_init(struct netkit_link *nkl,
> +			    struct bpf_link_primer *link_primer,
> +			    const union bpf_attr *attr,
> +			    struct net_device *dev,
> +			    struct bpf_prog *prog)
> +{
> +	bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
> +		      &netkit_link_lops, prog);
> +	nkl->location = attr->link_create.attach_type;
> +	nkl->dev = dev;
> +	return bpf_link_prime(&nkl->link, link_primer);
> +}
> +
> +int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_link_primer link_primer;
> +	struct netkit_link *nkl;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rtnl_lock();
> +	dev = netkit_dev_fetch(current->nsproxy->net_ns,
> +			       attr->link_create.target_ifindex,
> +			       attr->link_create.attach_type);
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		goto out;
> +	}
> +	nkl = kzalloc(sizeof(*nkl), GFP_KERNEL_ACCOUNT);
> +	if (!nkl) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	ret = netkit_link_init(nkl, &link_primer, attr, dev, prog);
> +	if (ret) {
> +		kfree(nkl);
> +		goto out;
> +	}

The series looks great! FWIW:
Acked-by: Stanislav Fomichev <sdf@google.com>

One small question I have is:
We now (and after introduction of tcx) seem to store non-refcounted
dev pointers in the bpf_link(s). Is it guaranteed that the dev will
outlive the link?

> +	ret = netkit_link_prog_attach(&nkl->link,
> +				      attr->link_create.flags,
> +				      attr->link_create.netkit.relative_fd,
> +				      attr->link_create.netkit.expected_revision);
> +	if (ret) {
> +		nkl->dev = NULL;
> +		bpf_link_cleanup(&link_primer);
> +		goto out;

What happens to nkl here? Do we leak it?

> +	}
> +	ret = bpf_link_settle(&link_primer);
> +out:
> +	rtnl_unlock();
> +	return ret;
> +}

