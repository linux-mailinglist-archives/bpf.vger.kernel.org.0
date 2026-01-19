Return-Path: <bpf+bounces-79448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF136D3A77C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 12:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C8B30D78B1
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD56318ED8;
	Mon, 19 Jan 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L/0ULze4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD48319604
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823574; cv=none; b=saxpcbSGQPS/eGCY3B/Ic6FOcAz+yFk1sus4rW4kqiXahJMfNRIpWjAmZi/xaxsg6MOw6EhOLlrvtHwepWIewnnPFr/mew6Vo0PyZUjpa/FSBDdEJ2OgP28uNVqy8UW6aRS6LgOPLPfShTiZpNGXFv07UIYt4veRPFpDXMWwKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823574; c=relaxed/simple;
	bh=XjmEkDhy70C9BPaUIKs8e1nglyFuMhkb7Yn1iqBTdVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rh9V7uUIpzvX6i22yi2WXQrbjTgMZ0ueQmffUHNwobzuw6kd4XV9MYeK3ci2FfOqmyLOFYyfT8+mYEBTtD3Bw4b36bg7yqQ/HpZl4soXFvkgYUjWoXn3o/MQ9KhIYQvY5iJKxHEVxUK0DmHWeoj5oiYd0Qxm2uElPQ5avo0IXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L/0ULze4; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-1244bce2c17so291409c88.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823565; x=1769428365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=lrbnuowTqpRGVUnOTTJi6zJvSUlLN+8CztrOKCNANJyeOaAwDbEwDEXvnXXbJPtKBR
         RgOSdVZpGxiM6G6FcZM49GbiFj9vAUimhSs6TWw8A46UidUH7d9K05ttrMShEpPNWzmC
         nOD0FhtchzmMn6vD9nAxIvDBUXK8FGxh64tuOTVmkNuqB53eKyIw7WOXoazWMRGs5xOf
         dfUQin5xMyza0TB79FgdydhXhd2G9+n0UTfTVVorOHrqqJeo1I/nvUJhQpds0gaLjS0G
         XWP4NuFy6QGfUH4W2ebjsUK5OSaRxYFO9FAHT9UeLxjYXlqcAouF3BSmJ1jqL43girsL
         k0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEl+N/usoQSfD5iYOWW/EfvoF6cUm5I964RDZwo7c7+gIvSS7fhS0A+chWemd1IGDRO1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wYWZhHT0ISLV3ucgRaCxrF3zXW2WaDh6oLRXYP4tD0OkEaRS
	8FOoAE3ddNqrWPUCq/IURqhB2PiUMbkF+QNOFxodb7nXFJbdKqW+2E4jI0aaZHq6AgF4zYuE9XH
	UsxtLAqrxOJdr0f/uBGCxc9jsdX0dS8mZ70dkQ3NzHjNeWFjryjKDN+Axj2ZRbAJha5UgKta6fv
	zCy+5Gu7LEYagHaXzHOHU2FYENxECZHw+VaDD5CDNkyWO25xXF6LdgjKgAKqW1KmFgSXazNL1bv
	WzIWPxq2btV0nKGxXoN+LtYihg=
X-Gm-Gg: AZuq6aIfQwgOJbdhkRhYnTCpRDgsWIpEC4JDukbng/vWTb8WN4c4EyMG4nS5YToLnlv
	b2Dfc6v0+kyYDET1/HEmw+lU9AMBZbFrMXmK2N1LNChiUmmtnl/xOXpsw6bT5ieXh/8wYgUlOqI
	1BW7lBHk/h8OZHaE0nf1hCRrYUZ9e79Vc8JIfZhv5aP1iY1ocfXiZUWZdoyONwHm1/czRlEmSUG
	UHIUd7Jrcc+J9LH8ytKrt25UWIjV1M3/pWkv8dzJznSIYKAWrtAdL3h9cPql05GiIXc6Gg3T7+4
	eNlijhlmHsIBf5x5BjdFzlxcdm1FRdiLaCVhgk0HFIpvHFldT3COLEIZBqIvKFO1M0mVyUZt1JL
	3zWVzlMUqyYvjNLSklk/dMaI8yK/yB17ntKeDglmFsPHGq2rRxlb/gt4qsSbA5qIz5GGfMxVw0e
	CH/QjN2MNXw/HmT686qF9pJ+YeHz/sVs6Xh99azP+9C9WQTOHuxGS8pnxLc0U=
X-Received: by 2002:a05:7301:1f10:b0:2ae:5245:d50e with SMTP id 5a478bee46e88-2b6b4114382mr3947077eec.8.1768823564617;
        Mon, 19 Jan 2026 03:52:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b6b34ffff6sm1195507eec.3.2026.01.19.03.52.44
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a182d4e1so106440585a.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823563; x=1769428363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=L/0ULze4jUuTK3NnnsdfA30AFlBBNzLImM5y1tRDE0KsmR+Q9QOvniERFwlFV47qCt
         iX6cF1kUYzGjSACQ1z2t20b1t9V+tYLtzi8I+9UhO87l3Np1V3JgpE22KgN804rel1OO
         YiRlv5MLiV32RW4ewPvocwOmGk/hrmxoz5Sf0=
X-Forwarded-Encrypted: i=1; AJvYcCVZ1y75vz1YaaPPO9Ap3HSb30KC9K09+PftKq6RmIztJsTfwIce6fwtzFAAquAg0I+5MLQ=@vger.kernel.org
X-Received: by 2002:a05:620a:2a05:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6a67bc788mr1083869985a.9.1768823561509;
        Mon, 19 Jan 2026 03:52:41 -0800 (PST)
X-Received: by 2002:a05:620a:2a05:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6a67bc788mr1083863185a.9.1768823559509;
        Mon, 19 Jan 2026 03:52:39 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:38 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 19 Jan 2026 11:49:10 +0000
Message-ID: <20260119114910.1414976-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Backport to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c51377a15..e79bce6db 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -125,17 +125,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.43.7


