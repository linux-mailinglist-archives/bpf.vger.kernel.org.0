Return-Path: <bpf+bounces-47341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0636B9F8239
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B920A16588C
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76501B6544;
	Thu, 19 Dec 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YztEenBW"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B81A42D8;
	Thu, 19 Dec 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629976; cv=none; b=cebLJBuljTFMI5xaJmiTUf0vcKt65Pb6nIr9NQkriYikubTnnOM4yOpBD88af7O4ccYZyEAQhL9JvfFRb5EQ2XuOm6H/+ENMvi+3cEs0Fjn2LOW+1jcw58MD6gHKAldtmigescK0NFojDFw3Gj7DKAVBVhV0CWKXZlLfEIw8BFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629976; c=relaxed/simple;
	bh=nMtNF8jgMV12hHMHxmoGPD7EdBlEfeZcMkMpfEqDSwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+ir6+QB75LNmuGQmc7Khuo314HZZE+Oaz1rc6pLofnkfWSoZaCUDF7RBMQYnWOMrJKchUHnJ8SIuuWQ2Zj15DWGV+zr0lG2dxfxwoSzD/EpqimeBPJwADbemmwdrl67YWaBrJBm89Urg/MwwhCmoIBXnXWi728uq+KOu/0GA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YztEenBW; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=faeUG6yKFS2gk3F1aCroSJO9YLzCZLggD/KHRlKDqdU=; b=YztEenBW9vUwI7ZOHTTE1eQPoK
	kAqsldKMD972BepQD8ZR+Knux9gChJVXQrI7NpBT1Ob/2MVzWDxnl+H6Ec1LrkvtFir5KaeUai1f/
	ZalEC9WKz4Xe2niyzXx6LDO5KT0LFbXxKgEw7mBX0qBSPj62A6ttwF1prDvetbSJTVv9mbyCA0qYN
	8Ngvk9GLKPk+lFNSaYyTeRY4+j/8PrzC8oss0aLWDMfUcfwJcpOhTXViEcwjeeXnVQDxbAWBDKNi6
	woNdAFMKNh1tQvCgRf2nfj7P1F0QSXRcWiNK0lnrZRFPjdB+3rNLNU37KN+96tPftaeXzQdGbu8Pu
	dpPNJhqw==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tOKUj-000MmT-03; Thu, 19 Dec 2024 18:39:29 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/3] netkit: Allow for configuring needed_{head,tail}room
Date: Thu, 19 Dec 2024 18:39:26 +0100
Message-ID: <20241219173928.464437-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27492/Thu Dec 19 10:44:32 2024)

Allow the user to configure needed_{head,tail}room for both netkit
devices. The idea is similar to 163e529200af ("veth: implement
ndo_set_rx_headroom") with the difference that the two parameters
can be specified upon device creation. By default the current behavior
stays as is which is needed_{head,tail}room is 0.

In case of Cilium, for example, the netkit devices are not enslaved
into a bridge or openvswitch device (rather, BPF-based redirection
is used out of tcx), and as such these parameters are not propagated
into the Pod's netns via peer device.

Given Cilium can run in vxlan/geneve tunneling mode (needed_headroom)
and/or be used in combination with WireGuard (needed_{head,tail}room),
allow the Cilium CNI plugin to specify these two upon netkit device
creation.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c               | 66 +++++++++++++++++++-----------
 include/uapi/linux/if_link.h       |  2 +
 tools/include/uapi/linux/if_link.h |  2 +
 3 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index c1d881dc6409..fb290dcfbc96 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -338,6 +338,7 @@ static int netkit_new_link(struct net *peer_net, struct net_device *dev,
 	enum netkit_scrub scrub_peer = NETKIT_SCRUB_DEFAULT;
 	enum netkit_mode mode = NETKIT_L3;
 	unsigned char ifname_assign_type;
+	u16 headroom = 0, tailroom = 0;
 	struct ifinfomsg *ifmp = NULL;
 	struct net_device *peer;
 	char ifname[IFNAMSIZ];
@@ -371,6 +372,10 @@ static int netkit_new_link(struct net *peer_net, struct net_device *dev,
 			if (err < 0)
 				return err;
 		}
+		if (data[IFLA_NETKIT_HEADROOM])
+			headroom = nla_get_u16(data[IFLA_NETKIT_HEADROOM]);
+		if (data[IFLA_NETKIT_TAILROOM])
+			tailroom = nla_get_u16(data[IFLA_NETKIT_TAILROOM]);
 	}
 
 	if (ifmp && tbp[IFLA_IFNAME]) {
@@ -390,6 +395,14 @@ static int netkit_new_link(struct net *peer_net, struct net_device *dev,
 		return PTR_ERR(peer);
 
 	netif_inherit_tso_max(peer, dev);
+	if (headroom) {
+		peer->needed_headroom = headroom;
+		dev->needed_headroom = headroom;
+	}
+	if (tailroom) {
+		peer->needed_tailroom = tailroom;
+		dev->needed_tailroom = tailroom;
+	}
 
 	if (mode == NETKIT_L2 && !(ifmp && tbp[IFLA_ADDRESS]))
 		eth_hw_addr_random(peer);
@@ -401,6 +414,7 @@ static int netkit_new_link(struct net *peer_net, struct net_device *dev,
 	nk->policy = policy_peer;
 	nk->scrub = scrub_peer;
 	nk->mode = mode;
+	nk->headroom = headroom;
 	bpf_mprog_bundle_init(&nk->bundle);
 
 	err = register_netdevice(peer);
@@ -426,6 +440,7 @@ static int netkit_new_link(struct net *peer_net, struct net_device *dev,
 	nk->policy = policy_prim;
 	nk->scrub = scrub_prim;
 	nk->mode = mode;
+	nk->headroom = headroom;
 	bpf_mprog_bundle_init(&nk->bundle);
 
 	err = register_netdevice(dev);
@@ -850,7 +865,18 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	struct net_device *peer = rtnl_dereference(nk->peer);
 	enum netkit_action policy;
 	struct nlattr *attr;
-	int err;
+	int err, i;
+	struct {
+		u32 attr;
+		char *name;
+	} fixed_params[] = {
+		{ IFLA_NETKIT_MODE,       "operating mode" },
+		{ IFLA_NETKIT_SCRUB,      "scrubbing" },
+		{ IFLA_NETKIT_PEER_SCRUB, "peer scrubbing" },
+		{ IFLA_NETKIT_PEER_INFO,  "peer info" },
+		{ IFLA_NETKIT_HEADROOM,   "headroom" },
+		{ IFLA_NETKIT_TAILROOM,   "tailroom" },
+	};
 
 	if (!nk->primary) {
 		NL_SET_ERR_MSG(extack,
@@ -858,28 +884,14 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 		return -EACCES;
 	}
 
-	if (data[IFLA_NETKIT_MODE]) {
-		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_MODE],
-				    "netkit link operating mode cannot be changed after device creation");
-		return -EACCES;
-	}
-
-	if (data[IFLA_NETKIT_SCRUB]) {
-		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_SCRUB],
-				    "netkit scrubbing cannot be changed after device creation");
-		return -EACCES;
-	}
-
-	if (data[IFLA_NETKIT_PEER_SCRUB]) {
-		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_SCRUB],
-				    "netkit scrubbing cannot be changed after device creation");
-		return -EACCES;
-	}
-
-	if (data[IFLA_NETKIT_PEER_INFO]) {
-		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
-				    "netkit peer info cannot be changed after device creation");
-		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(fixed_params); i++) {
+		attr = data[fixed_params[i].attr];
+		if (attr) {
+			NL_SET_ERR_MSG_ATTR_FMT(extack, attr,
+						"netkit link %s cannot be changed after device creation",
+						fixed_params[i].name);
+			return -EACCES;
+		}
 	}
 
 	if (data[IFLA_NETKIT_POLICY]) {
@@ -914,6 +926,8 @@ static size_t netkit_get_size(const struct net_device *dev)
 	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_PEER_SCRUB */
 	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_MODE */
 	       nla_total_size(sizeof(u8))  + /* IFLA_NETKIT_PRIMARY */
+	       nla_total_size(sizeof(u16)) + /* IFLA_NETKIT_HEADROOM */
+	       nla_total_size(sizeof(u16)) + /* IFLA_NETKIT_TAILROOM */
 	       0;
 }
 
@@ -930,6 +944,10 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		return -EMSGSIZE;
 	if (nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
 		return -EMSGSIZE;
+	if (nla_put_u16(skb, IFLA_NETKIT_HEADROOM, dev->needed_headroom))
+		return -EMSGSIZE;
+	if (nla_put_u16(skb, IFLA_NETKIT_TAILROOM, dev->needed_tailroom))
+		return -EMSGSIZE;
 
 	if (peer) {
 		nk = netkit_priv(peer);
@@ -947,6 +965,8 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 	[IFLA_NETKIT_MODE]		= NLA_POLICY_MAX(NLA_U32, NETKIT_L3),
 	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
 	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
+	[IFLA_NETKIT_HEADROOM]		= { .type = NLA_U16 },
+	[IFLA_NETKIT_TAILROOM]		= { .type = NLA_U16 },
 	[IFLA_NETKIT_SCRUB]		= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
 	[IFLA_NETKIT_PEER_SCRUB]	= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
 	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 2575e0cd9b48..2fa2c265dcba 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1315,6 +1315,8 @@ enum {
 	IFLA_NETKIT_MODE,
 	IFLA_NETKIT_SCRUB,
 	IFLA_NETKIT_PEER_SCRUB,
+	IFLA_NETKIT_HEADROOM,
+	IFLA_NETKIT_TAILROOM,
 	__IFLA_NETKIT_MAX,
 };
 #define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 8516c1ccd57a..7e46ca4cd31b 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1315,6 +1315,8 @@ enum {
 	IFLA_NETKIT_MODE,
 	IFLA_NETKIT_SCRUB,
 	IFLA_NETKIT_PEER_SCRUB,
+	IFLA_NETKIT_HEADROOM,
+	IFLA_NETKIT_TAILROOM,
 	__IFLA_NETKIT_MAX,
 };
 #define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
-- 
2.43.0


