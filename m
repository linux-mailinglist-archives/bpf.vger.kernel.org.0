Return-Path: <bpf+bounces-41089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A5992645
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81C51F22D4A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255818B462;
	Mon,  7 Oct 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHJGVYgo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101EA17622F;
	Mon,  7 Oct 2024 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287257; cv=none; b=m14juAzq07ZLchLm55MdgdTL3JoZP7qRNCvmPHVllAuNP5WFDeWf3g30pKInxvAIpwH1xazB7ELlPXEuv0FPeG3auSwn9Rzj2Q0uO66uU2wmcRgilf6CAcJkXunQWq6sKLKb6bc6sjofl8ZuGgvBSoyllrwSVxr5haEiFdlzekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287257; c=relaxed/simple;
	bh=YNCtkgPLk5vixANYLvHvRat7WChfPnSZ2kkrOZT5uOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlBiQjSFbE2SO3DNDj0cMotkD0ag+ZBYK2SCaT94yttTTunUjYG9FqR01now8lGcX86uq4fuovW7ZG7lHuYPQysn0Qsq9etYYa7k2OUwJ2AOR5EuzXbxXUjwK03n/ryUoac+L6MZ+8xzmJHbyHmpg90uRKccGqcGvQMdtaSzvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHJGVYgo; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-207115e3056so36483795ad.2;
        Mon, 07 Oct 2024 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287255; x=1728892055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j6xFB2yFKO5XV/9BnNs+EofRW0XdrjU9aIO3XW5rMk=;
        b=CHJGVYgoWAKqvB6HpGxsh/oO8Nvvp2j7EQWia2BNOE1cqrCUTV3N4nUCzcUWVECugU
         a0HBOjICKijsFUVOEkCXrPUCjzg1cCdkbe3zu5fA4ON+FmnQ/s3DFjGrT4FlC198fdZf
         uzVFnl32u0PY/YXFIzcMkBmDAzEKMhJBHxBK7i2lscvc7y4aNHgUyJvUT4GuHTKX9KC5
         kjKCen5PRUpHQU0bBVuudyJ45Z4mPcOmcQjKR01YEVlFlvZ/UmJ4KK9yk0qCmGeK249X
         6GaljX3GyHM1tDdAl83B/cZNNiZUFVI3rXQKwPq3+f4r5MXhZs5mTswTCg8cpvbge3h7
         bDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287255; x=1728892055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3j6xFB2yFKO5XV/9BnNs+EofRW0XdrjU9aIO3XW5rMk=;
        b=jryQ9lHdQTQ7vxsHEueiLlyjwvN+RWj4/if6Z7GBc5UqMd485IDzRLdHnud1KirFaF
         qN1HLgQs0BKrtsFJzbnn7VajDo3AcPVFVjBRB/hnpXHtAPqxJCEwv/3XMpMyLqAh4hse
         lezb4Ajkz08Lv7L+FQv3QCDmMRITnbkaZJvE6puKAMRapiAZwYugVarSRYvFFFJVEni7
         BB3Mw0mpUVSe4xDVPQA66xVUzKgJHGLmJYik4A9XzkSG+B18J7Hp/kC60TsJRpUIWZEj
         KtWQxhlyXRszLleI43rCIRjKKqZzsUYVK3WWiGtz2XbnKAC9JAnvS7X40UJMW8N5LNo5
         3W9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0g6QN2Bg5i/jYhFrV6ny8PYUHWOpcSFA+tNlWzHvkE5Gv1gFEASeIyR7jTJVOuVtLwysyBVrh@vger.kernel.org, AJvYcCVTHdoGVkiyWB6YQwuxO2r0nM1DGUtpY47DsJi1nsM5gaqP+a2mGT8jyOuE245HJGylDIQ=@vger.kernel.org, AJvYcCX4xcu+qEgeZyWO8UoYsKymE4HF1ztvo5+3rjPr5XPhH6GkRhP4dCT2eB7mZBAdcfXCR/ydqOAILJIBBQ8g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/h60f9gnAYtSNIPmyRYwj73Lr4FpB/TcxGF2FDwbGhmmie91
	ZHzUrX3JtR6vgDO+jgTjS3nl4T1GWIJu9YN9gvHcH0ThLWHzBn+S
X-Google-Smtp-Source: AGHT+IFZNdqmDMRaWeQrZGDy9jZ2H4fh7Yw5Q5rECkDHnj7pEjZGZvxIviCpZ1AmC/vQlz7wTzvSFA==
X-Received: by 2002:a17:902:ce88:b0:206:a913:96a7 with SMTP id d9443c01a7336-20bff04acb3mr144662455ad.44.1728287255352;
        Mon, 07 Oct 2024 00:47:35 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:47:34 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	dsahern@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dongml2@chinatelecom.cn,
	bigeasy@linutronix.de,
	toke@redhat.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 2/7] net: ip: make ip_route_input_mc() return drop reason
Date: Mon,  7 Oct 2024 15:46:57 +0800
Message-Id: <20241007074702.249543-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007074702.249543-1-dongml2@chinatelecom.cn>
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e49b4ce1804a..76940ca7c178 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1696,8 +1696,9 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 }
 
 /* called in rcu_read_lock() section */
-static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			     u8 tos, struct net_device *dev, int our)
+static enum skb_drop_reason
+ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  u8 tos, struct net_device *dev, int our)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
@@ -1707,7 +1708,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	err = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
 	if (err)
-		return err;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (our)
 		flags |= RTCF_LOCAL;
@@ -1718,7 +1719,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	rth = rt_dst_alloc(dev_net(dev)->loopback_dev, flags, RTN_MULTICAST,
 			   false);
 	if (!rth)
-		return -ENOBUFS;
+		return SKB_DROP_REASON_NOMEM;
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	rth->dst.tclassid = itag;
@@ -1734,7 +1735,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, &rth->dst);
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 
@@ -2440,12 +2441,12 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	 * route cache entry is created eventually.
 	 */
 	if (ipv4_is_multicast(daddr)) {
+		enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 		int our = 0;
-		int err = -EINVAL;
 
 		if (!in_dev)
-			return err;
+			return -EINVAL;
 		our = ip_check_mc_rcu(in_dev, daddr, saddr,
 				      ip_hdr(skb)->protocol);
 
@@ -2466,11 +2467,11 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     IN_DEV_MFORWARD(in_dev))
 #endif
 		   ) {
-			err = ip_route_input_mc(skb, daddr, saddr,
-						inet_dscp_to_dsfield(dscp),
-						dev, our);
+			reason = ip_route_input_mc(skb, daddr, saddr,
+						   inet_dscp_to_dsfield(dscp),
+						   dev, our);
 		}
-		return err;
+		return reason ? -EINVAL : 0;
 	}
 
 	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
-- 
2.39.5


