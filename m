Return-Path: <bpf+bounces-11019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE157B16FA
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E10B3281750
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8874434183;
	Thu, 28 Sep 2023 09:16:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84CF51A;
	Thu, 28 Sep 2023 09:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E72C433C7;
	Thu, 28 Sep 2023 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695892611;
	bh=L6mZfwQdaq0m5WNJx+7YXACdgZssao/dUwT3ovZOkig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fHfnyekRoEuIQNfxptx4xOH4mv4CZaEJKukWWmJJtP8fB/8EogMrwnDlRZsYbJNm4
	 FoSLc0GEt/VAUdJGSoLi4kwntsgQ6CxKn4ZJkLTB6SWKzznORyPmGn8TB3vOLP/J7m
	 SlqJFsx0H1unQt+2hnpomUowlAHF/RenvnYVaifzZq87Lq5oS5Ep57kwqbmf+JEhfQ
	 GodQKtWGW6FaYPpI+5TpBNbIx/P4BG5SKdm3sE+9ODD/4pzeY8Ja0uWLRf4rEcAmlC
	 3oV7v4FQjAAICEZuqI9IE+q7JH9w9lkD6buJTdzI46t9Fhb4Zao9BSKtsbxzqDaEKW
	 AN49+lJ5tDwow==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2EABBE262E2; Thu, 28 Sep 2023 11:16:25 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@kernel.org, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com, Daniel
 Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/8] meta, bpf: Add bpf programmable meta device
In-Reply-To: <20230926055913.9859-2-daniel@iogearbox.net>
References: <20230926055913.9859-1-daniel@iogearbox.net>
 <20230926055913.9859-2-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Sep 2023 11:16:25 +0200
Message-ID: <877coa8xp2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> This work adds a new, minimal BPF-programmable device called "meta" we
> recently presented at LSF/MM/BPF. The latter name derives from the Greek
> =CE=BC=CE=B5=CF=84=CE=AC, encompassing a wide array of meanings such as "=
on top of", "beyond".
> Given business logic is defined by BPF, this device can have many meaning=
s.
> The core idea is that BPF programs are executed within the drivers xmit
> routine and therefore e.g. in case of containers/Pods moving BPF processi=
ng
> closer to the source.

I like the concept, but I think we should change the name (as I believe
I also mentioned back when you presented it at LSF/MM/BPF). I know this
is basically bikeshedding, but I nevertheless think it is important, for
a couple of reasons:

- As you say, meta has a specific meaning, and this device is not a
  "meta" device in the common sense of the word: it is not tied to other
  devices (so it's not 'on top of' anything), and it is not "about"
  anything (as in metadata). It is just a device type that is programmed
  by BPF, so let's call it that.

- It's not discoverable; how are people supposed to figure out that they
  should go look for a 'meta' device? We also already have multiple
  things called 'metadata', so this is just going to create even more
  confusion (as we also discussed in relation to 'xdp hints').

- It squats on a pretty widely used term throughout the kernel
  (CONFIG_META, 'meta' as the module name). This is related to the above
  point; seeing something named 'meta' in lsmod, the natural assumption
  wouldn't be that it's a network driver.

I think we should just name the driver 'bpfnet'; it's not pretty, but
it's obvious and descriptive. Optionally we could teach 'ip' to
understand just 'bpf' as the device type, so you could go 'ip link add
type bpf' and get one of these.

> One of the goals was that in case of Pod egress traffic, this allows to
> move BPF programs from hostns tcx ingress into the device itself, providi=
ng
> earlier drop or forward mechanisms, for example, if the BPF program
> determines that the skb must be sent out of the node, then a redirect to
> the physical device can take place directly without going through per-CPU
> backlog queue. This helps to shift processing for such traffic from softi=
rq
> to process context, leading to better scheduling decisions and better
> performance.

So my only reservation to having this tied to a BPF-only device like
this is basically that if this is indeed such a big win, shouldn't we
try to make the stack operate in this mode by default? I assume you did
the analysis of what it would take to change veth to operate in this
mode; so what was the reason you decided to create a new device type
instead?

(I seem to recall at the presentation that you made a general reference
to veth being 'too complex', but complexity can be managed, so I'm more
thinking about whether there's any specific reason why changing veth
wouldn't work at all?)

[...]

Some comments on the code below:

> --- /dev/null
> +++ b/drivers/net/meta.c
> @@ -0,0 +1,734 @@
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
> +#include <net/meta.h>
> +#include <net/dst.h>
> +#include <net/tcx.h>
> +
> +#define DRV_NAME	"meta"
> +#define DRV_VERSION	"1.0"

Looking at veth as an example, this will probably never get updated :)

So wouldn't it be better to use the kernel version as the driver
version? That way there will at least be some information in this field.
I guess we could make the same change for veth.

> +struct meta {
> +	/* Needed in fast-path */
> +	struct net_device __rcu *peer;
> +	struct bpf_mprog_entry __rcu *active;
> +	enum meta_action policy;
> +	struct bpf_mprog_bundle	bundle;
> +	/* Needed in slow-path */
> +	enum meta_mode mode;
> +	bool primary;
> +	u32 headroom;
> +};
> +
> +static void meta_scrub_minimum(struct sk_buff *skb)
> +{
> +	skb->skb_iif =3D 0;
> +	skb->ignore_df =3D 0;
> +	skb->priority =3D 0;
> +	skb_dst_drop(skb);
> +	skb_ext_reset(skb);
> +	nf_reset_ct(skb);
> +	nf_reset_trace(skb);
> +	nf_skip_egress(skb, true);
> +	ipvs_reset(skb);
> +}

Same question as Stanislav here :)

> +static __always_inline int
> +meta_run(const struct meta *meta, const struct bpf_mprog_entry *entry,
> +	 struct sk_buff *skb, enum meta_action ret)
> +{
> +	const struct bpf_mprog_fp *fp;
> +	const struct bpf_prog *prog;
> +
> +	bpf_mprog_foreach_prog(entry, fp, prog) {
> +		bpf_compute_data_pointers(skb);
> +		ret =3D bpf_prog_run(prog, skb);
> +		if (ret !=3D META_NEXT)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +static netdev_tx_t meta_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	enum meta_action ret =3D READ_ONCE(meta->policy);
> +	netdev_tx_t ret_dev =3D NET_XMIT_SUCCESS;
> +	const struct bpf_mprog_entry *entry;
> +	struct net_device *peer;
> +
> +	rcu_read_lock();
> +	peer =3D rcu_dereference(meta->peer);
> +	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
> +		     !pskb_may_pull(skb, ETH_HLEN) ||
> +		     skb_orphan_frags(skb, GFP_ATOMIC)))
> +		goto drop;
> +	meta_scrub_minimum(skb);
> +	skb->dev =3D peer;
> +	entry =3D rcu_dereference(meta->active);
> +	if (entry)
> +		ret =3D meta_run(meta, entry, skb, ret);
> +	switch (ret) {
> +	case META_NEXT:
> +	case META_PASS:
> +		skb->pkt_type =3D PACKET_HOST;
> +		skb->protocol =3D eth_type_trans(skb, skb->dev);
> +		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
> +		__netif_rx(skb);
> +		break;
> +	case META_REDIRECT:
> +		skb_do_redirect(skb);
> +		break;
> +	case META_DROP:

Why the aliases for the constants? Might as well reuse the TCX names?

> +	default:
> +drop:
> +		ret_dev =3D NET_XMIT_DROP;
> +		dev_core_stats_tx_dropped_inc(dev);
> +		kfree_skb(skb);
> +		break;
> +	}
> +	rcu_read_unlock();
> +	return ret_dev;
> +}
> +
> +static int meta_open(struct net_device *dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct net_device *peer =3D rtnl_dereference(meta->peer);
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
> +static int meta_close(struct net_device *dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct net_device *peer =3D rtnl_dereference(meta->peer);
> +
> +	netif_carrier_off(dev);
> +	if (peer)
> +		netif_carrier_off(peer);
> +	return 0;
> +}
> +
> +static int meta_get_iflink(const struct net_device *dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct net_device *peer;
> +	int iflink =3D 0;
> +
> +	rcu_read_lock();
> +	peer =3D rcu_dereference(meta->peer);
> +	if (peer)
> +		iflink =3D peer->ifindex;
> +	rcu_read_unlock();
> +	return iflink;
> +}
> +
> +static void meta_set_multicast_list(struct net_device *dev)
> +{
> +}

The function name indicates there is some functionality envisioned here?
Why is the function empty?

> +static void meta_set_headroom(struct net_device *dev, int headroom)
> +{
> +	struct meta *meta =3D netdev_priv(dev), *meta2;
> +	struct net_device *peer;
> +
> +	if (headroom < 0)
> +		headroom =3D NET_SKB_PAD;
> +
> +	rcu_read_lock();
> +	peer =3D rcu_dereference(meta->peer);
> +	if (unlikely(!peer))
> +		goto out;
> +
> +	meta2 =3D netdev_priv(peer);
> +	meta->headroom =3D headroom;
> +	headroom =3D max(meta->headroom, meta2->headroom);
> +
> +	peer->needed_headroom =3D headroom;
> +	dev->needed_headroom =3D headroom;
> +out:
> +	rcu_read_unlock();
> +}
> +
> +static struct net_device *meta_peer_dev(struct net_device *dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +
> +	return rcu_dereference(meta->peer);
> +}
> +
> +static struct net_device *meta_peer_dev_rtnl(struct net_device *dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +
> +	return rcu_dereference_rtnl(meta->peer);
> +}
> +
> +static const struct net_device_ops meta_netdev_ops =3D {
> +	.ndo_open		=3D meta_open,
> +	.ndo_stop		=3D meta_close,
> +	.ndo_start_xmit		=3D meta_xmit,
> +	.ndo_set_rx_mode	=3D meta_set_multicast_list,
> +	.ndo_set_rx_headroom	=3D meta_set_headroom,
> +	.ndo_get_iflink		=3D meta_get_iflink,
> +	.ndo_get_peer_dev	=3D meta_peer_dev,
> +	.ndo_features_check	=3D passthru_features_check,
> +};
> +
> +static void meta_get_drvinfo(struct net_device *dev,
> +			     struct ethtool_drvinfo *info)
> +{
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->version, DRV_VERSION, sizeof(info->version));
> +}
> +
> +static const struct ethtool_ops meta_ethtool_ops =3D {
> +	.get_drvinfo		=3D meta_get_drvinfo,
> +};
> +
> +static void meta_setup(struct net_device *dev)
> +{
> +	static const netdev_features_t meta_features_hw_vlan =3D
> +		NETIF_F_HW_VLAN_CTAG_TX |
> +		NETIF_F_HW_VLAN_CTAG_RX |
> +		NETIF_F_HW_VLAN_STAG_TX |
> +		NETIF_F_HW_VLAN_STAG_RX;
> +	static const netdev_features_t meta_features =3D
> +		meta_features_hw_vlan |
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
> +	dev->min_mtu =3D ETH_MIN_MTU;
> +	dev->max_mtu =3D ETH_MAX_MTU;
> +
> +	dev->flags |=3D IFF_NOARP;
> +	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
> +	dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
> +	dev->priv_flags |=3D IFF_PHONY_HEADROOM;
> +	dev->priv_flags |=3D IFF_NO_QUEUE;

What happens if someone attaches a qdisc to the device in spite of this?

> +	dev->priv_flags |=3D IFF_META;
> +
> +	dev->ethtool_ops =3D &meta_ethtool_ops;
> +	dev->netdev_ops  =3D &meta_netdev_ops;
> +
> +	dev->features |=3D meta_features | NETIF_F_LLTX;
> +	dev->hw_features =3D meta_features;
> +	dev->hw_enc_features =3D meta_features;
> +	dev->mpls_features =3D NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
> +	dev->vlan_features =3D dev->features & ~meta_features_hw_vlan;
> +
> +	dev->needs_free_netdev =3D true;
> +
> +	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> +}
> +
> +static struct net *meta_get_link_net(const struct net_device *dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct net_device *peer =3D rtnl_dereference(meta->peer);
> +
> +	return peer ? dev_net(peer) : dev_net(dev);
> +}
> +
> +static int meta_check_policy(int policy, struct nlattr *tb,
> +			     struct netlink_ext_ack *extack)
> +{
> +	switch (policy) {
> +	case META_PASS:
> +	case META_DROP:
> +		return 0;
> +	default:
> +		NL_SET_ERR_MSG_ATTR(extack, tb,
> +				    "Provided default xmit policy not supported");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int meta_check_mode(int mode, struct nlattr *tb,
> +			   struct netlink_ext_ack *extack)
> +{
> +	switch (mode) {
> +	case META_L2:
> +	case META_L3:
> +		return 0;
> +	default:
> +		NL_SET_ERR_MSG_ATTR(extack, tb,
> +				    "Provided device mode can only be L2 or L3");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int meta_validate(struct nlattr *tb[], struct nlattr *data[],
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *attr =3D tb[IFLA_ADDRESS];
> +
> +	if (!attr)
> +		return 0;
> +	NL_SET_ERR_MSG_ATTR(extack, attr,
> +			    "Setting Ethernet address is not supported");
> +	return -EOPNOTSUPP;
> +}
> +
> +static struct rtnl_link_ops meta_link_ops;
> +
> +static int meta_new_link(struct net *src_net, struct net_device *dev,
> +			 struct nlattr *tb[], struct nlattr *data[],
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp =3D tb, *attr;
> +	enum meta_action default_prim =3D META_PASS;
> +	enum meta_action default_peer =3D META_PASS;
> +	unsigned char name_assign_type;
> +	enum meta_mode mode =3D META_L3;
> +	struct ifinfomsg *ifmp =3D NULL;
> +	struct net_device *peer;
> +	char ifname[IFNAMSIZ];
> +	struct meta *meta;
> +	struct net *net;
> +	int err;
> +
> +	if (data) {
> +		if (data[IFLA_META_MODE]) {
> +			attr =3D data[IFLA_META_MODE];
> +			mode =3D nla_get_u32(attr);
> +			err =3D meta_check_mode(mode, attr, extack);
> +			if (err < 0)
> +				return err;
> +		}
> +		if (data[IFLA_META_PEER_INFO]) {
> +			attr =3D data[IFLA_META_PEER_INFO];
> +			ifmp =3D nla_data(attr);
> +			err =3D rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
> +			if (err < 0)
> +				return err;
> +			err =3D meta_validate(peer_tb, NULL, extack);
> +			if (err < 0)
> +				return err;
> +			tbp =3D peer_tb;
> +		}
> +		if (data[IFLA_META_POLICY]) {
> +			attr =3D data[IFLA_META_POLICY];
> +			default_prim =3D nla_get_u32(attr);
> +			err =3D meta_check_policy(default_prim, attr, extack);
> +			if (err < 0)
> +				return err;
> +		}
> +		if (data[IFLA_META_PEER_POLICY]) {
> +			attr =3D data[IFLA_META_PEER_POLICY];
> +			default_peer =3D nla_get_u32(attr);
> +			err =3D meta_check_policy(default_peer, attr, extack);
> +			if (err < 0)
> +				return err;
> +		}
> +	}
> +
> +	if (ifmp && tbp[IFLA_IFNAME]) {
> +		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
> +		name_assign_type =3D NET_NAME_USER;
> +	} else {
> +		snprintf(ifname, IFNAMSIZ, "m%%d");
> +		name_assign_type =3D NET_NAME_ENUM;
> +	}
> +
> +	net =3D rtnl_link_get_net(src_net, tbp);
> +	if (IS_ERR(net))
> +		return PTR_ERR(net);
> +
> +	peer =3D rtnl_create_link(net, ifname, name_assign_type,
> +				&meta_link_ops, tbp, extack);
> +	if (IS_ERR(peer)) {
> +		put_net(net);
> +		return PTR_ERR(peer);
> +	}
> +
> +	if (mode =3D=3D META_L2)
> +		eth_hw_addr_random(peer);
> +	if (ifmp && dev->ifindex)
> +		peer->ifindex =3D ifmp->ifi_index;
> +
> +	netif_inherit_tso_max(peer, dev);
> +
> +	err =3D register_netdevice(peer);
> +	put_net(net);
> +	if (err < 0)
> +		goto err_register_peer;
> +
> +	netif_carrier_off(peer);
> +
> +	err =3D rtnl_configure_link(peer, ifmp, 0, NULL);
> +	if (err < 0)
> +		goto err_configure_peer;
> +
> +	if (mode =3D=3D META_L2)
> +		eth_hw_addr_random(dev);
> +	if (tb[IFLA_IFNAME])
> +		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
> +	else
> +		snprintf(dev->name, IFNAMSIZ, "m%%d");
> +
> +	err =3D register_netdevice(dev);
> +	if (err < 0)
> +		goto err_configure_peer;
> +
> +	netif_carrier_off(dev);
> +
> +	meta =3D netdev_priv(dev);
> +	meta->primary =3D true;
> +	meta->policy =3D default_prim;
> +	meta->mode =3D mode;
> +	if (meta->mode =3D=3D META_L2)
> +		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
> +	bpf_mprog_bundle_init(&meta->bundle);
> +	RCU_INIT_POINTER(meta->active, NULL);
> +	rcu_assign_pointer(meta->peer, peer);
> +
> +	meta =3D netdev_priv(peer);
> +	meta->primary =3D false;
> +	meta->policy =3D default_peer;
> +	meta->mode =3D mode;
> +	if (meta->mode =3D=3D META_L2)
> +		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
> +	bpf_mprog_bundle_init(&meta->bundle);
> +	RCU_INIT_POINTER(meta->active, NULL);
> +	rcu_assign_pointer(meta->peer, dev);
> +	return 0;
> +err_configure_peer:
> +	unregister_netdevice(peer);
> +	return err;
> +err_register_peer:
> +	free_netdev(peer);
> +	return err;
> +}
> +
> +static struct bpf_mprog_entry *meta_entry_fetch(struct net_device *dev,
> +						bool bundle_fallback)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct bpf_mprog_entry *entry;
> +
> +	ASSERT_RTNL();
> +	entry =3D rcu_dereference_rtnl(meta->active);
> +	if (entry)
> +		return entry;
> +	if (bundle_fallback)
> +		return &meta->bundle.a;
> +	return NULL;
> +}
> +
> +static void meta_entry_update(struct net_device *dev, struct bpf_mprog_e=
ntry *entry)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +
> +	ASSERT_RTNL();
> +	rcu_assign_pointer(meta->active, entry);
> +}
> +
> +static void meta_entry_sync(void)
> +{
> +	synchronize_rcu();
> +}
> +
> +static struct net_device *meta_dev_fetch(struct net *net, u32 ifindex, u=
32 which)
> +{
> +	struct net_device *dev;
> +	struct meta *meta;
> +
> +	ASSERT_RTNL();
> +
> +	switch (which) {
> +	case BPF_META_PRIMARY:
> +	case BPF_META_PEER:
> +		break;
> +	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dev =3D __dev_get_by_index(net, ifindex);
> +	if (!dev)
> +		return ERR_PTR(-ENODEV);
> +	if (!(dev->priv_flags & IFF_META))
> +		return ERR_PTR(-ENXIO);

I don't really think a new flag value is needed here? Can't you just
make this check if (dev->netdev_ops =3D=3D &meta_netdev_ops) ?
> +
> +	meta =3D netdev_priv(dev);
> +	if (!meta->primary)
> +		return ERR_PTR(-EACCES);
> +	if (which =3D=3D BPF_META_PRIMARY)
> +		return dev;
> +	return meta_peer_dev_rtnl(dev);
> +}
> +
> +int meta_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_mprog_entry *entry, *entry_new;
> +	struct bpf_prog *replace_prog =3D NULL;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rtnl_lock();
> +	dev =3D meta_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
> +			     attr->attach_type);
> +	if (IS_ERR(dev)) {
> +		ret =3D PTR_ERR(dev);
> +		goto out;
> +	}
> +	entry =3D meta_entry_fetch(dev, true);
> +	if (attr->attach_flags & BPF_F_REPLACE) {
> +		replace_prog =3D bpf_prog_get_type(attr->replace_bpf_fd,
> +						 prog->type);
> +		if (IS_ERR(replace_prog)) {
> +			ret =3D PTR_ERR(replace_prog);
> +			replace_prog =3D NULL;
> +			goto out;
> +		}
> +	}
> +	ret =3D bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_prog,
> +			       attr->attach_flags, attr->relative_fd,
> +			       attr->expected_revision);
> +	if (!ret) {
> +		if (entry !=3D entry_new) {
> +			meta_entry_update(dev, entry_new);
> +			meta_entry_sync();
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
> +int meta_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_mprog_entry *entry, *entry_new;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rtnl_lock();
> +	dev =3D meta_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
> +			     attr->attach_type);
> +	if (IS_ERR(dev)) {
> +		ret =3D PTR_ERR(dev);
> +		goto out;
> +	}
> +	entry =3D meta_entry_fetch(dev, false);
> +	if (!entry) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +	ret =3D bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->attach_fl=
ags,
> +			       attr->relative_fd, attr->expected_revision);
> +	if (!ret) {
> +		if (!bpf_mprog_total(entry_new))
> +			entry_new =3D NULL;
> +		meta_entry_update(dev, entry_new);
> +		meta_entry_sync();
> +		bpf_mprog_commit(entry);
> +	}
> +out:
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +int meta_prog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr)
> +{
> +	struct bpf_mprog_entry *entry;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rtnl_lock();
> +	dev =3D meta_dev_fetch(current->nsproxy->net_ns, attr->query.target_ifi=
ndex,
> +			     attr->query.attach_type);
> +	if (IS_ERR(dev)) {
> +		ret =3D PTR_ERR(dev);
> +		goto out;
> +	}
> +	entry =3D meta_entry_fetch(dev, false);
> +	if (!entry) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +	ret =3D bpf_mprog_query(attr, uattr, entry);
> +out:
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +static void meta_release_all(struct net_device *dev)
> +{
> +	struct bpf_mprog_entry *entry;
> +	struct bpf_tuple tuple =3D {};
> +	struct bpf_mprog_fp *fp;
> +	struct bpf_mprog_cp *cp;
> +
> +	entry =3D meta_entry_fetch(dev, false);
> +	if (!entry)
> +		return;
> +	meta_entry_update(dev, NULL);
> +	meta_entry_sync();
> +	bpf_mprog_foreach_tuple(entry, fp, cp, tuple) {
> +		bpf_prog_put(tuple.prog);
> +	}
> +}
> +
> +static void meta_del_link(struct net_device *dev, struct list_head *head)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct net_device *peer =3D rtnl_dereference(meta->peer);
> +
> +	RCU_INIT_POINTER(meta->peer, NULL);
> +	meta_release_all(dev);
> +	unregister_netdevice_queue(dev, head);
> +	if (peer) {
> +		meta =3D netdev_priv(peer);
> +		RCU_INIT_POINTER(meta->peer, NULL);
> +		meta_release_all(peer);
> +		unregister_netdevice_queue(peer, head);
> +	}
> +}
> +
> +static int meta_change_link(struct net_device *dev, struct nlattr *tb[],
> +			    struct nlattr *data[],
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct net_device *peer =3D rtnl_dereference(meta->peer);
> +	enum meta_action policy;
> +	struct nlattr *attr;
> +	int err;
> +
> +	if (!meta->primary) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Meta settings can be changed only through the primary device"=
);
> +		return -EACCES;
> +	}
> +
> +	if (data[IFLA_META_MODE]) {
> +		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_META_MODE],
> +				    "Meta operating mode cannot be changed after device creation");
> +		return -EACCES;
> +	}
> +
> +	if (data[IFLA_META_POLICY]) {
> +		attr =3D data[IFLA_META_POLICY];
> +		policy =3D nla_get_u32(attr);
> +		err =3D meta_check_policy(policy, attr, extack);
> +		if (err)
> +			return err;
> +		WRITE_ONCE(meta->policy, policy);
> +	}
> +
> +	if (data[IFLA_META_PEER_POLICY]) {
> +		err =3D -EOPNOTSUPP;
> +		attr =3D data[IFLA_META_PEER_POLICY];
> +		policy =3D nla_get_u32(attr);
> +		if (peer)
> +			err =3D meta_check_policy(policy, attr, extack);
> +		if (err)
> +			return err;
> +		meta =3D netdev_priv(peer);
> +		WRITE_ONCE(meta->policy, policy);
> +	}
> +
> +	return 0;
> +}
> +
> +static size_t meta_get_size(const struct net_device *dev)
> +{
> +	return nla_total_size(sizeof(u32)) + /* IFLA_META_POLICY */
> +	       nla_total_size(sizeof(u32)) + /* IFLA_META_PEER_POLICY */
> +	       nla_total_size(sizeof(u8))  + /* IFLA_META_PRIMARY */
> +	       nla_total_size(sizeof(u32)) + /* IFLA_META_MODE */
> +	       0;
> +}
> +
> +static int meta_fill_info(struct sk_buff *skb, const struct net_device *=
dev)
> +{
> +	struct meta *meta =3D netdev_priv(dev);
> +	struct net_device *peer =3D rtnl_dereference(meta->peer);
> +
> +	if (nla_put_u8(skb, IFLA_META_PRIMARY, meta->primary))
> +		return -EMSGSIZE;
> +	if (nla_put_u32(skb, IFLA_META_POLICY, meta->policy))
> +		return -EMSGSIZE;
> +	if (nla_put_u32(skb, IFLA_META_MODE, meta->mode))
> +		return -EMSGSIZE;
> +
> +	if (peer) {
> +		meta =3D netdev_priv(peer);
> +		if (nla_put_u32(skb, IFLA_META_PEER_POLICY, meta->policy))
> +			return -EMSGSIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nla_policy meta_policy[IFLA_META_MAX + 1] =3D {
> +	[IFLA_META_PEER_INFO]	=3D { .len =3D sizeof(struct ifinfomsg) },
> +	[IFLA_META_POLICY]	=3D { .type =3D NLA_U32 },
> +	[IFLA_META_MODE]	=3D { .type =3D NLA_U32 },
> +	[IFLA_META_PEER_POLICY]	=3D { .type =3D NLA_U32 },
> +	[IFLA_META_PRIMARY]	=3D { .type =3D NLA_REJECT,
> +				    .reject_message =3D "Primary attribute is read-only" },
> +};
> +
> +static struct rtnl_link_ops meta_link_ops =3D {
> +	.kind		=3D DRV_NAME,
> +	.priv_size	=3D sizeof(struct meta),
> +	.setup		=3D meta_setup,
> +	.newlink	=3D meta_new_link,
> +	.dellink	=3D meta_del_link,
> +	.changelink	=3D meta_change_link,
> +	.get_link_net	=3D meta_get_link_net,
> +	.get_size	=3D meta_get_size,
> +	.fill_info	=3D meta_fill_info,
> +	.policy		=3D meta_policy,
> +	.validate	=3D meta_validate,
> +	.maxtype	=3D IFLA_META_MAX,
> +};
> +
> +static __init int meta_init(void)
> +{
> +	BUILD_BUG_ON((int)META_NEXT !=3D (int)TCX_NEXT ||
> +		     (int)META_PASS !=3D (int)TCX_PASS ||
> +		     (int)META_DROP !=3D (int)TCX_DROP ||
> +		     (int)META_REDIRECT !=3D (int)TCX_REDIRECT);
> +
> +	return rtnl_link_register(&meta_link_ops);
> +}
> +
> +static __exit void meta_exit(void)
> +{
> +	rtnl_link_unregister(&meta_link_ops);
> +}
> +
> +module_init(meta_init);
> +module_exit(meta_exit);
> +
> +MODULE_DESCRIPTION("BPF-programmable meta device");
> +MODULE_AUTHOR("Daniel Borkmann <daniel@iogearbox.net>");
> +MODULE_AUTHOR("Nikolay Aleksandrov <razor@blackwall.org>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_RTNL_LINK(DRV_NAME);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7e520c14eb8c..af0f23ed8d51 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1701,6 +1701,7 @@ struct net_device_ops {
>   * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
>   *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
>   *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
> + * @IFF_META: device is a meta device
>   */
>  enum netdev_priv_flags {
>  	IFF_802_1Q_VLAN			=3D 1<<0,
> @@ -1737,6 +1738,7 @@ enum netdev_priv_flags {
>  	IFF_TX_SKB_NO_LINEAR		=3D BIT_ULL(31),
>  	IFF_CHANGE_PROTO_DOWN		=3D BIT_ULL(32),
>  	IFF_SEE_ALL_HWTSTAMP_REQUESTS	=3D BIT_ULL(33),
> +	IFF_META			=3D BIT_ULL(34),
>  };
>=20=20
>  #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
> diff --git a/include/net/meta.h b/include/net/meta.h
> new file mode 100644
> index 000000000000..20fc61d05970
> --- /dev/null
> +++ b/include/net/meta.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2023 Isovalent */
> +#ifndef __NET_META_H
> +#define __NET_META_H
> +
> +#include <linux/bpf.h>
> +
> +#ifdef CONFIG_META
> +int meta_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> +int meta_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
> +int meta_prog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr);
> +#else
> +static inline int meta_prog_attach(const union bpf_attr *attr,
> +				   struct bpf_prog *prog)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int meta_prog_detach(const union bpf_attr *attr,
> +				   struct bpf_prog *prog)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int meta_prog_query(const union bpf_attr *attr,
> +				  union bpf_attr __user *uattr)
> +{
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_META */
> +#endif /* __NET_META_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 5f13db15a3c7..00a875720e84 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1047,6 +1047,8 @@ enum bpf_attach_type {
>  	BPF_TCX_INGRESS,
>  	BPF_TCX_EGRESS,
>  	BPF_TRACE_UPROBE_MULTI,
> +	BPF_META_PRIMARY,
> +	BPF_META_PEER,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>=20=20
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index fac351a93aed..ec099c6c51e0 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -756,6 +756,31 @@ struct tunnel_msg {
>  	__u32 ifindex;
>  };
>=20=20
> +/* META section */
> +enum meta_action {
> +	META_NEXT	=3D -1,
> +	META_PASS	=3D 0,
> +	META_DROP	=3D 2,
> +	META_REDIRECT	=3D 7,
> +};
> +
> +enum meta_mode {
> +	META_L2,
> +	META_L3,
> +};
> +
> +enum {
> +	IFLA_META_UNSPEC,
> +	IFLA_META_PEER_INFO,
> +	IFLA_META_PRIMARY,
> +	IFLA_META_POLICY,
> +	IFLA_META_PEER_POLICY,
> +	IFLA_META_MODE,
> +	__IFLA_META_MAX,
> +};
> +
> +#define IFLA_META_MAX	(__IFLA_META_MAX - 1)
> +
>  /* VXLAN section */
>=20=20
>  /* include statistics in the dump */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 85c1d908f70f..51baf4355c39 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -35,8 +35,9 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/memcontrol.h>
>  #include <linux/trace_events.h>
> -#include <net/netfilter/nf_bpf_link.h>
>=20=20
> +#include <net/netfilter/nf_bpf_link.h>
> +#include <net/meta.h>
>  #include <net/tcx.h>
>=20=20
>  #define IS_FD_ARRAY(map) ((map)->map_type =3D=3D BPF_MAP_TYPE_PERF_EVENT=
_ARRAY || \
> @@ -3720,6 +3721,8 @@ attach_type_to_prog_type(enum bpf_attach_type attac=
h_type)
>  		return BPF_PROG_TYPE_LSM;
>  	case BPF_TCX_INGRESS:
>  	case BPF_TCX_EGRESS:
> +	case BPF_META_PRIMARY:
> +	case BPF_META_PEER:
>  		return BPF_PROG_TYPE_SCHED_CLS;
>  	default:
>  		return BPF_PROG_TYPE_UNSPEC;
> @@ -3771,7 +3774,9 @@ static int bpf_prog_attach_check_attach_type(const =
struct bpf_prog *prog,
>  		return 0;
>  	case BPF_PROG_TYPE_SCHED_CLS:
>  		if (attach_type !=3D BPF_TCX_INGRESS &&
> -		    attach_type !=3D BPF_TCX_EGRESS)
> +		    attach_type !=3D BPF_TCX_EGRESS &&
> +		    attach_type !=3D BPF_META_PRIMARY &&
> +		    attach_type !=3D BPF_META_PEER)

PRIMARY and PEER basically correspond to INGRESS and EGRESS in terms of
which packets the program sees, right? So why not just reuse ingress and
egress designators, the fact that it's a "peer" attachment is mostly an
implementation detail, isn't it? Or should 'mirred' redirection to the
device inside a container also be supported? (is it?)

Reusing it (and special-casing the tcx attachment) would prevent people
from accidentally attaching a tcx program on top of the device (which
AFAICT if otherwise possible, right?). Or maybe this is a feature?

-Toke

