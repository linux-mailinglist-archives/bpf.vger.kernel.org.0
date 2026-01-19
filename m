Return-Path: <bpf+bounces-79438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6822FD3A305
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F18B53007C36
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF22773FF;
	Mon, 19 Jan 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gieT5L7g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CB35580B
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814983; cv=none; b=jOYbobfgjbDKsCsyxHHJv32z4qnQMLNYI0gMsek2BRlJfamvf9WnrRG21AYa3pllsJI47iwm6vs6zdwo+uaz2Aioo7VfueQv2Mgvc6D7OqITJAWGx5NVWYFZmct3FSefdZ6W/elEz2GNHu+YhJkDdE/q+pWjokjaT8XkQfglIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814983; c=relaxed/simple;
	bh=5U08ymozzcGqOa+0/gOyD2WLxOYPTrL6M+fxBFoORbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lykCUpNL7IpLm94Y8I91wWnNyAIvr9NhAjE8EJIMljj0Suaic9uMB7oYf95wXXOVlFVuE39+pysYxQ+d7L1nOT/Lk+TarXpHJ3spZufalGWj+ScMW9Fc3DaqPqJi6x+sBqfSZYrQV7QBmhDCJ8aDLmjIzojqTpLxloUag8UtATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gieT5L7g; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34e825b0c42so248017a91.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814979; x=1769419779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz5ffcVS1QdI0IyJJ74d4ERRSZLiOHbia+pSPo7WObM=;
        b=qV5IAUOaViMIsc+E0QE0GBGywxKX8npVq4ULouGvVEnm9MYw6KAWDBW+UuMoDxw/y7
         aXBhp4+aletp2tP+rgWjF+/ce8m2uCCg+d2S5us24bzCVN2bUqjMO9TuqJzhIGRtn/vg
         jtEw2d/cIJhnt6CZjeaicfC2E157jIj5HxCnX5uYc0ANGGzZHCrLrtXew4sQ6T0VxLfF
         c5E16CT2dbFK1ZfZZocZYP8RQ/omGQmY4lHREx2HEnl0vHkKP1cCRi4jswCwC+FjM67v
         Gw7DcUabxLU2K3/VNHea8Z9byrriru5tMHTMPvxBLT3Jo7jcrg1twzS1Mvv0DSJV9sMY
         F3tw==
X-Forwarded-Encrypted: i=1; AJvYcCWhA0n/RXwBZn1lFvdPblXFf6FB3sKHuIm5qPSP/fII1ld74o/iLY2Q3z5ZHnpv34q+73M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnt8hrKfz0yQg0nOeRMZgh1L4T9nsjMlh9t5UCX7oPfQZz1Wec
	qHqdHHx2qIOYhI/FJkk12plbBG92QLGXcJPVig6/HwJQSWw7kv+j+7/4A3pZOXR33c2BUA5GSlt
	QFThvMGausosS9DB52zmSuQarPO2KkngoVxN/nDcimkaFvz06TpoZEcVnBg5dZHcxE5GABB6Sde
	bh+I359iNJ2zX9JHI/mdhwEGkuYNWRrXeod0gayAORTFsgJbxn8FAH5k5elyDrLxZZuN3WBnBN6
	oG3VvIn4oVnUfR6VZi6kEQmh/k=
X-Gm-Gg: AZuq6aLxcGqbvyZk+8AH2SSEGyGzA8gBQfG37yi0XsDWQW+bZ5ed6OIsv6AVNtUIQ0M
	PW3ctXZJJEJhPGQhQJAf2M+Mss237BMew2HgD1lGYjvxW9jWpNVns5TWRfJY5Xz8Ev8k9RMtFhj
	kxdtTgFv3LJCm7EQHaoj+sJLOk88i62zcbD7/YiKTf8ZCwQ+EylHJD3fEaYpOmTOWxX202i9O0q
	JbwhOCHxPeJE0wbofaQfozOlnWwMhcMfZIqquJCWc1FMEiwb71rWzCJhmyOKZt/SqlYwksfmS0F
	baxwVHiGdWq3oSiAP6ZAXSbFkw6+g+9zmQfiB1drCdyqMHG3URtfhtaBzZd99aFDJho49nClqSq
	TcyjBSbJZDsHYFoggvMQ548sIVS/D7/PPPOtM5kBMkgM/ITONTuxIHCXbdujT3KHJG9WjzRQ3eT
	dvzLY/18JI5nrXdBP7OFj7Xch9aK5dR2lVxerHpNiIy5NO2uPQ95Qqumqap6GykQ==
X-Received: by 2002:a17:90b:4a83:b0:340:b8f2:24fa with SMTP id 98e67ed59e1d1-35272ed090bmr6090277a91.2.1768814978781;
        Mon, 19 Jan 2026 01:29:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-352730403ffsm1396070a91.2.2026.01.19.01.29.38
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8888ae5976aso16972446d6.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814977; x=1769419777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz5ffcVS1QdI0IyJJ74d4ERRSZLiOHbia+pSPo7WObM=;
        b=gieT5L7gnqNMRsILTR5L8mmzeaCvwgIuAY+VgbRiXsntn2Ah2mx9iKrZVDMMAY16Ct
         FfxWIqKo0Keprdo/G0NlRSZmppPGTbLXpY8+wjt9xH6YwhMkVVUs2hOVOD+k25gasiyy
         kcLvJwDn9l8ylT9wBFHldQNG8WhMIUVyKz3kU=
X-Forwarded-Encrypted: i=1; AJvYcCV+Wl3a3WIQPAeevadrPC7DjjFtwSFRX+/LlKXD9dVhxC9d3kVZBzB1gwIWFa1cOPzEHNc=@vger.kernel.org
X-Received: by 2002:a05:6214:4c92:b0:894:2b9f:ccc6 with SMTP id 6a1803df08f44-8942dd90f52mr96288406d6.3.1768814977356;
        Mon, 19 Jan 2026 01:29:37 -0800 (PST)
X-Received: by 2002:a05:6214:4c92:b0:894:2b9f:ccc6 with SMTP id 6a1803df08f44-8942dd90f52mr96288106d6.3.1768814976839;
        Mon, 19 Jan 2026 01:29:36 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:36 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 3/5] net/bonding: Implement ndo_sk_get_lower_dev
Date: Mon, 19 Jan 2026 09:26:00 +0000
Message-ID: <20260119092602.1414468-4-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7 ]

Add ndo_sk_get_lower_dev() implementation for bond interfaces.

Support only for the cases where the socket's and SKBs' hash
yields identical value for the whole connection lifetime.

Here we restrict it to L3+4 sockets only, with
xmit_hash_policy==LAYER34 and bond modes xor/802.3ad.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/net/bonding/bond_main.c | 93 +++++++++++++++++++++++++++++++++
 include/net/bonding.h           |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b4b2e6a7fdd4..fb30378cffce 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -301,6 +301,19 @@ netdev_tx_t bond_dev_queue_xmit(struct bonding *bond, struct sk_buff *skb,
 	return dev_queue_xmit(skb);
 }
 
+bool bond_sk_check(struct bonding *bond)
+{
+	switch (BOND_MODE(bond)) {
+	case BOND_MODE_8023AD:
+	case BOND_MODE_XOR:
+		if (bond->params.xmit_policy == BOND_XMIT_POLICY_LAYER34)
+			return true;
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
 /*---------------------------------- VLAN -----------------------------------*/
 
 /* In the following 2 functions, bond_vlan_rx_add_vid and bond_vlan_rx_kill_vid,
@@ -4723,6 +4736,85 @@ static struct net_device *bond_xmit_get_slave(struct net_device *master_dev,
 	return NULL;
 }
 
+static void bond_sk_to_flow(struct sock *sk, struct flow_keys *flow)
+{
+	switch (sk->sk_family) {
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		if (sk->sk_ipv6only ||
+		    ipv6_addr_type(&sk->sk_v6_daddr) != IPV6_ADDR_MAPPED) {
+			flow->control.addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
+			flow->addrs.v6addrs.src = inet6_sk(sk)->saddr;
+			flow->addrs.v6addrs.dst = sk->sk_v6_daddr;
+			break;
+		}
+		fallthrough;
+#endif
+	default: /* AF_INET */
+		flow->control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
+		flow->addrs.v4addrs.src = inet_sk(sk)->inet_rcv_saddr;
+		flow->addrs.v4addrs.dst = inet_sk(sk)->inet_daddr;
+		break;
+	}
+
+	flow->ports.src = inet_sk(sk)->inet_sport;
+	flow->ports.dst = inet_sk(sk)->inet_dport;
+}
+
+/**
+ * bond_sk_hash_l34 - generate a hash value based on the socket's L3 and L4 fields
+ * @sk: socket to use for headers
+ *
+ * This function will extract the necessary field from the socket and use
+ * them to generate a hash based on the LAYER34 xmit_policy.
+ * Assumes that sk is a TCP or UDP socket.
+ */
+static u32 bond_sk_hash_l34(struct sock *sk)
+{
+	struct flow_keys flow;
+	u32 hash;
+
+	bond_sk_to_flow(sk, &flow);
+
+	/* L4 */
+	memcpy(&hash, &flow.ports.ports, sizeof(hash));
+	/* L3 */
+	return bond_ip_hash(hash, &flow);
+}
+
+static struct net_device *__bond_sk_get_lower_dev(struct bonding *bond,
+						  struct sock *sk)
+{
+	struct bond_up_slave *slaves;
+	struct slave *slave;
+	unsigned int count;
+	u32 hash;
+
+	slaves = rcu_dereference(bond->usable_slaves);
+	count = slaves ? READ_ONCE(slaves->count) : 0;
+	if (unlikely(!count))
+		return NULL;
+
+	hash = bond_sk_hash_l34(sk);
+	slave = slaves->arr[hash % count];
+
+	return slave->dev;
+}
+
+static struct net_device *bond_sk_get_lower_dev(struct net_device *dev,
+						struct sock *sk)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct net_device *lower = NULL;
+
+	rcu_read_lock();
+	if (bond_sk_check(bond))
+		lower = __bond_sk_get_lower_dev(bond, sk);
+	rcu_read_unlock();
+
+	return lower;
+}
+
 static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bonding *bond = netdev_priv(dev);
@@ -4859,6 +4951,7 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_fix_features	= bond_fix_features,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_xmit_slave	= bond_xmit_get_slave,
+	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,
 };
 
 static const struct device_type bond_type = {
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 82d128c0fe6d..871920db4e51 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -273,6 +273,8 @@ struct bond_vlan_tag {
 	unsigned short	vlan_id;
 };
 
+bool bond_sk_check(struct bonding *bond);
+
 /**
  * Returns NULL if the net_device does not belong to any of the bond's slaves
  *
-- 
2.43.7


