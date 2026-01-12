Return-Path: <bpf+bounces-78514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB8D10B6F
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC4230779A1
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408F30FF06;
	Mon, 12 Jan 2026 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D3CQ3Mxy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBC3081C2
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199638; cv=none; b=gToyfREkpUBeJh9HQFcw5igZdXxMedOrGb5LdEUqfTjKESemm65G9mIjHmuedCEMJRxEK+uvgnmhoHw+ON3/D/4yM2F+gg4YW5zGjligSo9+WuXiFkHcr2famecRvBe/J5kv6SNrNjEdHda2xHLs85TfbaqjQpqdoY7fcqo9jTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199638; c=relaxed/simple;
	bh=RWuTHL2vG6VXYYw+aleWdAzTOjFVPPbKCGWiPi4YKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk5JIF5IB/oBPeFWhSQXTwqyZ7yS9vtTX9MSUfhXhstg+jh4WzkXTU+M4D2vfjOmDDFSLu3HKJ3L0wDw/TALxF0yRxnghWuhSqjGVHmKAGhed+badKWlNqbIKiMXERK7WERCOK6vFJ8a2iVxMx9NhTtwRkpUPM5aEZnkWDldL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D3CQ3Mxy; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-34c567db0a9so431639a91.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199636; x=1768804436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=mR9IVLyQm+7j1KBHxdgBzmIeRsZhPTzxv9bfOd/ATOMSX5FhpZCWYbrTgqgnL3geQ3
         bJYPGzeUxOgWIpcVuHadYk77XBom0+8nAmwudUvNunGKrb966/ZAzQ7/uDZVPx5awbB2
         xUx/HD7R1x9KXZiOqfwTWna0UuFE7nnaotLjasPh7X5hK1t17i3JP/wWiYKkesmoQ9W/
         aUBWb3EnExQT9mufiLhe0/s4LqH59Rg7Wbm/bDCoibeVZeojWZzIKXvGJ3GgqDhFK2pS
         MQawFsrM1UhbuPsk5cdw9WpI4pwenaS5OWSsayu+31aQHkg2VOwFFIMm2mE5Vz5Zmd/O
         jwag==
X-Forwarded-Encrypted: i=1; AJvYcCXPuUxXqp9rJF2GpHs/Zyd42mJnP+CFxC448MxVmwTzvHClp338sl7Qkmm/6MWYoDkpQzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBdGXw8xt3caVfC96HWONAEZHh6oAJztiwnZ1Z+vHacqijG2X
	zOnS7juWsXewN9PXTELD0JVTxukODBTyn3OPtk1MgqVkimKdBCZcfHXYVODYNAEcMT1meqkmmJH
	gjWRCA4QPioW7AsLx24CwCDkNIKhnLlGdBtgQYOVrvJZ1aq97+bYANjwEaspS8Q7VN+CMlFRao/
	LjkTGuqpsVuBQE3aRV4c+b57DUfBkhcNnvEmjd9373RhCOKH+6W+JJu21YRIqYJUgwbWwVEjeDp
	c1Hw54HH/JwAtZyOUpakUzZF6A=
X-Gm-Gg: AY/fxX5V7O/NRAH7UGfqc7hwOJlCs6s9MUzQ5yxgS7gF9FcUCOeSitsQMZvA0yGMbqS
	vaamR2JyUBiITJ0soLlJ0ILKBeMApZBXFm3V1Ot3M0+ZAykXqMo1hipMxi7D1FckLz9GN5mxNN+
	XBWoiQ6MoGPnV/7FY0HYs1o7TWCy0WU2jFBvjb07i0/yO/6KqglHetL0cNoo9TqKORt0upx5TVz
	8D4VU6sxWGj82gRNmPjvAsRUOm0eJN4P8b19McWPG78UaMsKGt2FUTjOl+n4tV30jSy66sDTXmX
	No+oYU/WLAkLjCX+izrqsWirYF7DQe/PAR/X8Li4saloBm888RWRpTcH1Jk0cUK/7Gb7RwRy5pF
	fJt4DOLwqYXMrU8vy5bWq3Cw91ZQOVmG2iyElcgVhbfwmUp7EFVCjA700GO/hOF17JcGzRqIBtz
	ybhtsBih5Gdu093p17yrKGUAtG8qNEUW9MhrqDP8PXvA5M7Zb2gEX+LRi8A8g=
X-Google-Smtp-Source: AGHT+IGiN1jzED2MdPAN7sK7pWgDThMOqr9HV/mNh+ZvUVCLogdhQYF9oBsRAAyfht3kC8gaAz4ocHx9tVek
X-Received: by 2002:a17:90a:fc46:b0:340:b8f2:250c with SMTP id 98e67ed59e1d1-34f68b47b08mr10645729a91.1.1768199636165;
        Sun, 11 Jan 2026 22:33:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5fb4ce76sm2550786a91.7.2026.01.11.22.33.55
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:33:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2ea2b51cfso142405085a.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199635; x=1768804435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=D3CQ3Mxye8QpcUZIhbG6wp4M0lYb2Ja3TYS0hWlLWGWeK2VuosaF3kOgrH50w+ZkQh
         iyVDyjmFecWmrkQmvkG6jLxDoL37g8RN4ABjXZ8dLd62Fi6y5Mzmn/h0TMf3q1bwnidQ
         FQ0F7LALUuOj2ExAkvj1yowUDV4gzpBbFLWfI=
X-Forwarded-Encrypted: i=1; AJvYcCWzzI/CLDvUrC1mcatKp3/he8cXfgomdw7m3vBRtOhPA7w6IypLE5fBcx1Glj7Y171R8X0=@vger.kernel.org
X-Received: by 2002:a05:620a:2886:b0:878:7b3e:7bbf with SMTP id af79cd13be357-8c38937a047mr1725531785a.3.1768199634869;
        Sun, 11 Jan 2026 22:33:54 -0800 (PST)
X-Received: by 2002:a05:620a:2886:b0:878:7b3e:7bbf with SMTP id af79cd13be357-8c38937a047mr1725529485a.3.1768199634468;
        Sun, 11 Jan 2026 22:33:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:53 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 2/3] net: netdevice: Add operation ndo_sk_get_lower_dev
Date: Mon, 12 Jan 2026 06:30:38 +0000
Message-ID: <20260112063039.2968980-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7]

ndo_sk_get_lower_dev returns the lower netdev that corresponds to
a given socket.
Additionally, we implement a helper netdev_sk_get_lowest_dev() to get
the lowest one in chain.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/linux/netdevice.h |  4 ++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3a3e77a18df..c9f2a88a6c83 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1435,6 +1435,8 @@ struct net_device_ops {
 	struct net_device*	(*ndo_get_xmit_slave)(struct net_device *dev,
 						      struct sk_buff *skb,
 						      bool all_slaves);
+	struct net_device*	(*ndo_sk_get_lower_dev)(struct net_device *dev,
+							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_set_features)(struct net_device *dev,
@@ -2914,6 +2916,8 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index c0dc524548ee..ad2be47b48a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8169,6 +8169,39 @@ struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 }
 EXPORT_SYMBOL(netdev_get_xmit_slave);
 
+static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
+						  struct sock *sk)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!ops->ndo_sk_get_lower_dev)
+		return NULL;
+	return ops->ndo_sk_get_lower_dev(dev, sk);
+}
+
+/**
+ * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
+ * @dev: device
+ * @sk: the socket
+ *
+ * %NULL is returned if no lower device is found.
+ */
+
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk)
+{
+	struct net_device *lower;
+
+	lower = netdev_sk_get_lower_dev(dev, sk);
+	while (lower) {
+		dev = lower;
+		lower = netdev_sk_get_lower_dev(dev, sk);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
 	struct netdev_adjacent *iter;
-- 
2.43.7


