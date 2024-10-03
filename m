Return-Path: <bpf+bounces-40853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3100B98F5C5
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93746B2343B
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A781AB51E;
	Thu,  3 Oct 2024 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mL6v54bn"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DE1A2557;
	Thu,  3 Oct 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978612; cv=none; b=hQIsS+z3Y6KyH7jv066vd87pg4NAL+VxhG0Zt9rTf/K89aBtxeZJwf8OXgcI8ATUriRirciw8YRa+Qg41U6DCttQXDDXbYk+2VeWKefNcdjwh+9WkQBTWMmR+LU8ikCJJS/tuTy/Heeaoh3KfZm/0suJ2jQWCW2yNX6cnC/B95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978612; c=relaxed/simple;
	bh=Tfp5OnB9e7liizN2dtvej40s57Lr2IEoAEiuzqP65qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cdN/4H0z+TsEOU0Ikb4PgZuq4tV6qXH0GCK/mJuPOOe3UpjoTTxni4CYH6+bR0csYRHPbKFvLuAAOiEirf3f7Zvy8AiOemD0dyF7pXdZ0HM6Tl/DJum2DzNedbaXldT1gIa1RslWkt88hnAIY6+JG7lrWqoe8WjETO2Vp77AYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mL6v54bn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=lZA4jsocJhUsB9aIeO2PIJ+q2EvVaxit66AZD9fwEzQ=; b=mL6v54bnuI/EWgbnMcbwqqgrty
	M/jWCC0nGrA3FYrJJ+Dh6BqKy+HePx5v0/Q+iUronc3zdZxhKLiYWxr38hBdfyOkZk1fxmAvoVqMS
	TbwC32wRHUfxzEbgHYQKfk3As8BZXLnAt+Ty+FXSMXQbWj7C2vike0vhA9EAaZlShRzsICCH0fAuk
	wMzZckAueI9IFu9D/Fqh9lcwF0MeHvUEw8UTmCxh/MLcPmqAhAlTt595o+dZpEM1wRDoMnjhh3zfE
	Y3W501afJEJ93opHxppK1R9+aSP7P6qA07sXJecocRGsBODN+7kkNeCdHdXpblqE6j+pCPJm7c2FQ
	u0QpdYJw==;
Received: from 44.249.197.178.dynamic.cust.swisscom.net ([178.197.249.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swQAb-0006DS-KR; Thu, 03 Oct 2024 20:03:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	jrife@google.com,
	tangchen.1@bytedance.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/4] netkit: Add option for scrubbing skb meta data
Date: Thu,  3 Oct 2024 20:03:17 +0200
Message-Id: <20241003180320.113002-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27416/Thu Oct  3 10:37:25 2024)

Jordan reported that when running Cilium with netkit in per-endpoint-routes
mode, network policy misclassifies traffic. In this direct routing mode
of Cilium which is used in case of GKE/EKS/AKS, the Pod's BPF program to
enforce policy sits on the netkit primary device's egress side.

The issue here is that in case of netkit's netkit_prep_forward(), it will
clear meta data such as skb->mark and skb->priority before executing the
BPF program. Thus, identity data stored in there from earlier BPF programs
(e.g. from tcx ingress on the physical device) gets cleared instead of
being made available for the primary's program to process. While for traffic
egressing the Pod via the peer device this might be desired, this is
different for the primary one where compared to tcx egress on the host
veth this information would be available.

To address this, add a new parameter for the device orchestration to
allow control of skb->mark and skb->priority scrubbing, to make the two
accessible from BPF (and eventually leave it up to the program to scrub).
By default, the current behavior is retained. For netkit peer this also
enables the use case where applications could cooperate/signal intent to
the BPF program.

Note that struct netkit has a 4 byte hole between policy and bundle which
is used here, in other words, struct netkit's first cacheline content used
in fast-path does not get moved around.

Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Reported-by: Jordan Rife <jrife@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://github.com/cilium/cilium/issues/34042
---
 drivers/net/netkit.c         | 92 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/if_link.h |  7 +++
 2 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 059269557d92..ac424db4ce02 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -20,6 +20,7 @@ struct netkit {
 	struct net_device __rcu *peer;
 	struct bpf_mprog_entry __rcu *active;
 	enum netkit_action policy;
+	enum netkit_scrub scrub;
 	struct bpf_mprog_bundle	bundle;
 
 	/* Needed in slow-path */
@@ -50,12 +51,24 @@ netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	return ret;
 }
 
-static void netkit_prep_forward(struct sk_buff *skb, bool xnet)
+static void netkit_xnet(struct sk_buff *skb)
 {
-	skb_scrub_packet(skb, xnet);
 	skb->priority = 0;
+	skb->mark = 0;
+}
+
+static void netkit_prep_forward(struct sk_buff *skb,
+				bool xnet, bool xnet_scrub)
+{
+	skb_scrub_packet(skb, false);
 	nf_skip_egress(skb, true);
 	skb_reset_mac_header(skb);
+	if (!xnet)
+		return;
+	ipvs_reset(skb);
+	skb_clear_tstamp(skb);
+	if (xnet_scrub)
+		netkit_xnet(skb);
 }
 
 static struct netkit *netkit_priv(const struct net_device *dev)
@@ -80,7 +93,8 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		     !pskb_may_pull(skb, ETH_HLEN) ||
 		     skb_orphan_frags(skb, GFP_ATOMIC)))
 		goto drop;
-	netkit_prep_forward(skb, !net_eq(dev_net(dev), dev_net(peer)));
+	netkit_prep_forward(skb, !net_eq(dev_net(dev), dev_net(peer)),
+			    nk->scrub);
 	eth_skb_pkt_type(skb, peer);
 	skb->dev = peer;
 	entry = rcu_dereference(nk->active);
@@ -311,6 +325,20 @@ static int netkit_check_mode(int mode, struct nlattr *tb,
 	}
 }
 
+static int netkit_check_scrub(int scrub, struct nlattr *tb,
+			      struct netlink_ext_ack *extack)
+{
+	switch (scrub) {
+	case NETKIT_SCRUB_DEFAULT:
+	case NETKIT_SCRUB_NONE:
+		return 0;
+	default:
+		NL_SET_ERR_MSG_ATTR(extack, tb,
+				    "Provided device scrub setting can only be default/none");
+		return -EINVAL;
+	}
+}
+
 static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
@@ -332,8 +360,10 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 			   struct netlink_ext_ack *extack)
 {
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
-	enum netkit_action default_prim = NETKIT_PASS;
-	enum netkit_action default_peer = NETKIT_PASS;
+	enum netkit_action policy_prim = NETKIT_PASS;
+	enum netkit_action policy_peer = NETKIT_PASS;
+	enum netkit_scrub scrub_prim = NETKIT_SCRUB_DEFAULT;
+	enum netkit_scrub scrub_peer = NETKIT_SCRUB_DEFAULT;
 	enum netkit_mode mode = NETKIT_L3;
 	unsigned char ifname_assign_type;
 	struct ifinfomsg *ifmp = NULL;
@@ -364,15 +394,29 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		}
 		if (data[IFLA_NETKIT_POLICY]) {
 			attr = data[IFLA_NETKIT_POLICY];
-			default_prim = nla_get_u32(attr);
-			err = netkit_check_policy(default_prim, attr, extack);
+			policy_prim = nla_get_u32(attr);
+			err = netkit_check_policy(policy_prim, attr, extack);
 			if (err < 0)
 				return err;
 		}
 		if (data[IFLA_NETKIT_PEER_POLICY]) {
 			attr = data[IFLA_NETKIT_PEER_POLICY];
-			default_peer = nla_get_u32(attr);
-			err = netkit_check_policy(default_peer, attr, extack);
+			policy_peer = nla_get_u32(attr);
+			err = netkit_check_policy(policy_peer, attr, extack);
+			if (err < 0)
+				return err;
+		}
+		if (data[IFLA_NETKIT_SCRUB]) {
+			attr = data[IFLA_NETKIT_SCRUB];
+			scrub_prim = nla_get_u32(attr);
+			err = netkit_check_scrub(scrub_prim, attr, extack);
+			if (err < 0)
+				return err;
+		}
+		if (data[IFLA_NETKIT_PEER_SCRUB]) {
+			attr = data[IFLA_NETKIT_PEER_SCRUB];
+			scrub_peer = nla_get_u32(attr);
+			err = netkit_check_scrub(scrub_peer, attr, extack);
 			if (err < 0)
 				return err;
 		}
@@ -409,7 +453,8 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 
 	nk = netkit_priv(peer);
 	nk->primary = false;
-	nk->policy = default_peer;
+	nk->policy = policy_peer;
+	nk->scrub = scrub_peer;
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
 
@@ -434,7 +479,8 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 
 	nk = netkit_priv(dev);
 	nk->primary = true;
-	nk->policy = default_prim;
+	nk->policy = policy_prim;
+	nk->scrub = scrub_prim;
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
 
@@ -874,6 +920,18 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 		return -EACCES;
 	}
 
+	if (data[IFLA_NETKIT_SCRUB]) {
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_SCRUB],
+				    "netkit scrubbing cannot be changed after device creation");
+		return -EACCES;
+	}
+
+	if (data[IFLA_NETKIT_PEER_SCRUB]) {
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_SCRUB],
+				    "netkit scrubbing cannot be changed after device creation");
+		return -EACCES;
+	}
+
 	if (data[IFLA_NETKIT_PEER_INFO]) {
 		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
 				    "netkit peer info cannot be changed after device creation");
@@ -908,8 +966,10 @@ static size_t netkit_get_size(const struct net_device *dev)
 {
 	return nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_POLICY */
 	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_PEER_POLICY */
-	       nla_total_size(sizeof(u8))  + /* IFLA_NETKIT_PRIMARY */
+	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_SCRUB */
+	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_PEER_SCRUB */
 	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_MODE */
+	       nla_total_size(sizeof(u8))  + /* IFLA_NETKIT_PRIMARY */
 	       0;
 }
 
@@ -924,11 +984,15 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		return -EMSGSIZE;
 	if (nla_put_u32(skb, IFLA_NETKIT_MODE, nk->mode))
 		return -EMSGSIZE;
+	if (nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
+		return -EMSGSIZE;
 
 	if (peer) {
 		nk = netkit_priv(peer);
 		if (nla_put_u32(skb, IFLA_NETKIT_PEER_POLICY, nk->policy))
 			return -EMSGSIZE;
+		if (nla_put_u32(skb, IFLA_NETKIT_PEER_SCRUB, nk->scrub))
+			return -EMSGSIZE;
 	}
 
 	return 0;
@@ -936,9 +1000,11 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
-	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
 	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
+	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
 	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
+	[IFLA_NETKIT_SCRUB]		= { .type = NLA_U32 },
+	[IFLA_NETKIT_PEER_SCRUB]	= { .type = NLA_U32 },
 	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
 					    .reject_message = "Primary attribute is read-only" },
 };
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 6dc258993b17..dfa2cb402644 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1292,6 +1292,11 @@ enum netkit_mode {
 	NETKIT_L3,
 };
 
+enum netkit_scrub {
+	NETKIT_SCRUB_NONE,
+	NETKIT_SCRUB_DEFAULT,
+};
+
 enum {
 	IFLA_NETKIT_UNSPEC,
 	IFLA_NETKIT_PEER_INFO,
@@ -1299,6 +1304,8 @@ enum {
 	IFLA_NETKIT_POLICY,
 	IFLA_NETKIT_PEER_POLICY,
 	IFLA_NETKIT_MODE,
+	IFLA_NETKIT_SCRUB,
+	IFLA_NETKIT_PEER_SCRUB,
 	__IFLA_NETKIT_MAX,
 };
 #define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
-- 
2.43.0


