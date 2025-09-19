Return-Path: <bpf+bounces-68980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F8B8B57D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47965A7BBA
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1292D592E;
	Fri, 19 Sep 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="adBndu3I"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC22BD5A1;
	Fri, 19 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317530; cv=none; b=A25UOyP3yiniCiDB+nzZDZOsLFNHutamm+EEAFKTxvr9aqBCyhPYhJh9g6pWvEFprMgZ/ftXA5pyRUCKbmkwDXArHwMAp90/HWE/yQrkV1mHvi89E7xVkdhEOisozXVYx3fPApk2QRpzr/QmtXyqtLV+r5tosH6BbQwrG1ct4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317530; c=relaxed/simple;
	bh=/E77UpHv/HKwE/YmkWEdxCihzq+S1kHmFYr7hK7b5G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6B7AH5Ad7oSR6QHAgcSGNuQ2wani1mu7K7NIfivYm+mPakm0HyS5o64XHsdyd7NB6K2E95DAKUnRA6Bl9w+somB7GpH4kh0MiMreenfCEEmoA9tk8bASAzxINJbTqloO9AyEqybICi+WXxpwOlB+ndpA4uad3OfealP7SGLSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=adBndu3I; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=g9nPKTWZafwAz6Th6419DPE6gjosXLUGUoGbmMvZly8=; b=adBndu3I4k5kSG/oy0ejWxF+U7
	7QLGDKJZmR5m4zf6iSt7m2B8zjGDuctcjNnt/QGBBCnbyVEDNJqFHm2SxxLIjT3j7Sx+sC5FagzYW
	uTZrI1Y/yxaDUqfL9QXjV3TQaWWWjhpBuQS9z3rHszd01rRDZn3FLs7kURz40HuwBRq7IUeU54IAx
	U7QveCilRaA48FZSLMTgUb9csFtUxALMLAa5tCFgIQkxl9uNAaUQTz1jc1JqoEF6g6sgoYZrEkPgf
	+Z6qlI7Y58EV2jt6qDu2rgD1mYU7gkS9ho28+iK5ciYyPqO+0Pl49q6+dC2Qf45Woc+3gZKuBigOQ
	89yOM1bA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzihz-000Nq5-2Q;
	Fri, 19 Sep 2025 23:31:59 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 05/20] net, ynl: Implement netdev_nl_bind_queue_doit
Date: Fri, 19 Sep 2025 23:31:38 +0200
Message-ID: <20250919213153.103606-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

From: David Wei <dw@davidwei.uk>

Implement netdev_nl_bind_queue_doit() that creates a mapped rxq in a
virtual netdev and then binds it to a real rxq in a physical netdev
by setting the peer pointer in netdev_rx_queue.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/netdev-genl.c | 117 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b0aea27bf84e..ed0ce3dbfc6f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1122,6 +1122,123 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 
 int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	u32 src_ifidx, src_qid, dst_ifidx, dst_qid;
+	struct netdev_rx_queue *src_rxq, *dst_rxq;
+	struct net_device *src_dev, *dst_dev;
+	struct netdev_nl_sock *priv;
+	struct sk_buff *rsp;
+	int err = 0;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_DST_IFINDEX))
+		return -EINVAL;
+
+	src_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX]);
+	src_qid = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID]);
+	dst_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_DST_IFINDEX]);
+	if (dst_ifidx == src_ifidx) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination driver cannot be same as source driver");
+		return -EOPNOTSUPP;
+	}
+
+	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_genlmsg_free;
+	}
+
+	mutex_lock(&priv->lock);
+
+	src_dev = netdev_get_by_index_lock(genl_info_net(info), src_ifidx);
+	if (!src_dev) {
+		err = -ENODEV;
+		goto err_unlock_sock;
+	}
+	if (!netif_device_present(src_dev)) {
+		err = -ENODEV;
+		goto err_unlock_src_dev;
+	}
+	if (!src_dev->dev.parent) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source driver is a virtual device");
+		goto err_unlock_src_dev;
+	}
+	if (!src_dev->queue_mgmt_ops) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source driver does not support queue management operations");
+		goto err_unlock_src_dev;
+	}
+	if (src_qid >= src_dev->num_rx_queues) {
+		err = -ERANGE;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source driver queue out of range");
+		goto err_unlock_src_dev;
+	}
+
+	src_rxq = __netif_get_rx_queue(src_dev, src_qid);
+	if (src_rxq->peer) {
+		err = -EBUSY;
+		NL_SET_ERR_MSG(info->extack,
+			       "Source driver queue already bound");
+		goto err_unlock_src_dev;
+	}
+
+	dst_dev = netdev_get_by_index_lock(genl_info_net(info), dst_ifidx);
+	if (!dst_dev) {
+		err = -ENODEV;
+		goto err_unlock_src_dev;
+	}
+	if (!dst_dev->queue_mgmt_ops ||
+	    !dst_dev->queue_mgmt_ops->ndo_queue_create) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination driver does not support queue management operations");
+		goto err_unlock_dst_dev;
+	}
+
+	err = dst_dev->queue_mgmt_ops->ndo_queue_create(dst_dev);
+	if (err <= 0) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Destination driver unable to create a new queue");
+		goto err_unlock_dst_dev;
+	}
+
+	dst_qid = err - 1;
+	dst_rxq = __netif_get_rx_queue(dst_dev, dst_qid);
+
+	netdev_rx_queue_peer(src_dev, src_rxq, dst_rxq);
+
+	nla_put_u32(rsp, NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID, dst_qid);
+	genlmsg_end(rsp, hdr);
+
+	netdev_unlock(dst_dev);
+	netdev_unlock(src_dev);
+	mutex_unlock(&priv->lock);
+
+	return genlmsg_reply(rsp, info);
+
+err_unlock_dst_dev:
+	netdev_unlock(dst_dev);
+err_unlock_src_dev:
+	netdev_unlock(src_dev);
+err_unlock_sock:
+	mutex_unlock(&priv->lock);
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
 }
 
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
-- 
2.43.0


