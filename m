Return-Path: <bpf+bounces-14153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B41AB7E0B19
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54766B214AB
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6D25106;
	Fri,  3 Nov 2023 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="V5W0kvRt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F010249E2;
	Fri,  3 Nov 2023 22:28:02 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31400CA;
	Fri,  3 Nov 2023 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XVOAeQsfqVhCB2rsEIVMBgNmg3wnl1S1IxhvCErQyss=; b=V5W0kvRtzHb03leijUlehgWpsn
	XXZbHXtM05CToARaSn80b9luYpc9+8AGt9jKl+0zEeiGTROkOd50bbvXcv0WVuOREy7n+tPLCMsfz
	aY2xF9cx+W57Stuig6Qj+lrc3YrlZyzqxhkKroECTUNtgmYvpIJSPk6ptCUXaIninV/KtUJPps0cg
	4fEIgFMTVtYKKcHG9CEyDB3gwU1uzD9bVnGdkNMuafpsUnD50r6fn1jdbc8pP5l6dHVVELNguPDHV
	LEYz9+zC6VYYOULuRBzSpBmWD71K/N2bo9zg1XohxbD9LKj+YDbZgqhTSCyfx5bM/AQ/y4iMEPBai
	lLie/tUA==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qz2dy-000Cq8-94; Fri, 03 Nov 2023 23:27:58 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf 4/6] bpf, netkit: Add indirect call wrapper for fetching peer dev
Date: Fri,  3 Nov 2023 23:27:46 +0100
Message-Id: <20231103222748.12551-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231103222748.12551-1-daniel@iogearbox.net>
References: <20231103222748.12551-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27081/Fri Nov  3 08:43:47 2023)

ndo_get_peer_dev is used in tcx BPF fast path, therefore make use of
indirect call wrapper and therefore optimize the bpf_redirect_peer()
internal handling a bit. Add a small skb_get_peer_dev() wrapper which
utilizes the INDIRECT_CALL_1() macro instead of open coding.

Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/netkit.c |  3 ++-
 include/net/netkit.h |  6 ++++++
 net/core/filter.c    | 18 +++++++++++++-----
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index dc51c23b40f0..934c71a73b5c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -7,6 +7,7 @@
 #include <linux/filter.h>
 #include <linux/netfilter_netdev.h>
 #include <linux/bpf_mprog.h>
+#include <linux/indirect_call_wrapper.h>
 
 #include <net/netkit.h>
 #include <net/dst.h>
@@ -177,7 +178,7 @@ static void netkit_set_headroom(struct net_device *dev, int headroom)
 	rcu_read_unlock();
 }
 
-static struct net_device *netkit_peer_dev(struct net_device *dev)
+INDIRECT_CALLABLE_SCOPE struct net_device *netkit_peer_dev(struct net_device *dev)
 {
 	return rcu_dereference(netkit_priv(dev)->peer);
 }
diff --git a/include/net/netkit.h b/include/net/netkit.h
index 0ba2e6b847ca..9ec0163739f4 100644
--- a/include/net/netkit.h
+++ b/include/net/netkit.h
@@ -10,6 +10,7 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int netkit_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
 int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr);
+INDIRECT_CALLABLE_DECLARE(struct net_device *netkit_peer_dev(struct net_device *dev));
 #else
 static inline int netkit_prog_attach(const union bpf_attr *attr,
 				     struct bpf_prog *prog)
@@ -34,5 +35,10 @@ static inline int netkit_prog_query(const union bpf_attr *attr,
 {
 	return -EINVAL;
 }
+
+static inline struct net_device *netkit_peer_dev(struct net_device *dev)
+{
+	return NULL;
+}
 #endif /* CONFIG_NETKIT */
 #endif /* __NET_NETKIT_H */
diff --git a/net/core/filter.c b/net/core/filter.c
index 7aca28b7d0fd..dbf92b272022 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -81,6 +81,7 @@
 #include <net/xdp.h>
 #include <net/mptcp.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
+#include <net/netkit.h>
 #include <linux/un.h>
 
 #include "dev.h"
@@ -2468,6 +2469,16 @@ static const struct bpf_func_proto bpf_clone_redirect_proto = {
 DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
 EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
 
+static struct net_device *skb_get_peer_dev(struct net_device *dev)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (likely(ops->ndo_get_peer_dev))
+		return INDIRECT_CALL_1(ops->ndo_get_peer_dev,
+				       netkit_peer_dev, dev);
+	return NULL;
+}
+
 int skb_do_redirect(struct sk_buff *skb)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
@@ -2481,12 +2492,9 @@ int skb_do_redirect(struct sk_buff *skb)
 	if (unlikely(!dev))
 		goto out_drop;
 	if (flags & BPF_F_PEER) {
-		const struct net_device_ops *ops = dev->netdev_ops;
-
-		if (unlikely(!ops->ndo_get_peer_dev ||
-			     !skb_at_tc_ingress(skb)))
+		if (unlikely(!skb_at_tc_ingress(skb)))
 			goto out_drop;
-		dev = ops->ndo_get_peer_dev(dev);
+		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
 			     !(dev->flags & IFF_UP) ||
 			     net_eq(net, dev_net(dev))))
-- 
2.34.1


