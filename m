Return-Path: <bpf+bounces-44234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B53959C06A3
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12317B2325A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322912144DB;
	Thu,  7 Nov 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYCNnSe0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797222144A6;
	Thu,  7 Nov 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984233; cv=none; b=KMqS8whJ8y0HcnBN1snPkzrD1hm4hO/b3yHcsY8EyLVqPcZrnrsIHWBGwtHcgHgkdttNW+4CTcOr2I+LFCDxwsHdVrEMrsH1lsOAkcTX7f+Z+NJ1palzWbajjh2RBoDihMh/HhnkuAt4mhYgecGHeRKiRrRacoJMqutbrgraozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984233; c=relaxed/simple;
	bh=LAqzk3ZeLSZRqj1ByixV8/2cQzVAafDYcEAPajrW45Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7aVV2lJDgPiBQYNpNy9YC4xNwGheBystNqWjIV9vNWnwg2n49x8N+w8ZYbPoV3JZLqQOhX1nc9VQ30sWv3d8QaRPYm2PqIRu2FT+/M7IAN6x3dGYo7B+yu/clmu37CgcpoZCnbcD1D6Mp0Hn4+zv54gtS3EeYRz5G71qT6jaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYCNnSe0; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7f3f1849849so700989a12.1;
        Thu, 07 Nov 2024 04:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984231; x=1731589031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9fMwGGcbp4z4vwxeeXuhogVmcPVJ1v4SFojuZQbris=;
        b=ZYCNnSe0JPuBXo8pc//2wZ9moX8/YsZ4hpqN0I8wVt+mAok4ByIFN/59TzzvaJfE/5
         gwhSbjZrCetdvOMXc7ES9DR1JBbRAo7VxGMnCDjq2zvBfjSMwtAA3q7UfMUfW/k55dfA
         BpgN/S9SAchzE/GAc7r4ga/mnQwwts4cgBt4jyVcuIwRzFjEFDhjYgDt2n5L+5Qb12As
         ZUqU5Za7bnc+IaBzmdcAi9ZG+9fhZ1zUjTy4pHiwW/s/S5SL69tOJvySDOWW8CmXfeaF
         uZkq39wwOxlchX5aE3/Xtc0VAwv0uUBE3+v3hFtTaGUV4I2W/5X/jLKfNU8IcG61axGJ
         nD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984231; x=1731589031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9fMwGGcbp4z4vwxeeXuhogVmcPVJ1v4SFojuZQbris=;
        b=cxDuTF6ib9GTqsjZ3gNd6QMMqng5v2hXFIv8ogUiOjsNDm2n6VEDMxkJkK3UFr5733
         4oL4FVh3DZdctYdeBKcU6JeP2rqPTZJcfFPMWm+SSZCfFEldiZZEwNPwaayne5MIpbXo
         IqfI/8bsWb05HRfpoJm3c221sP2m0sbL9NfAoB/AxJP/HRr8HocTZSkZCsuefe+bW9N/
         yjfV6CVLiyQ2v4OPosF5aQsTNw1nOhoAjukJjSEUMoxJ8gaepqdlVbZ6PwkcoE1HnqBM
         1RRtsUWOtwLn3Y9dgqFQxP7yKPmJtUiIO5HqbGk0GfPTy3Sc3RgjilieGiZzOFrOQZP0
         HkeA==
X-Forwarded-Encrypted: i=1; AJvYcCVeDUMSj8YKopByYkLqq5naroyjTIwlswfwSuXCP19TDv/VK/9+ziGlLTzlAcz7tsHiriSdebZw@vger.kernel.org, AJvYcCW9OcBTXJB8qwVkA09ORpr++QSCBlgHBPcs/M/ihOz7rD7pPjjQTyUvjsV7k8i9am4tuko=@vger.kernel.org, AJvYcCWU4eeJcCX/HSQwTCvY3WUuRR0hb9plA7BuZLqHPhU5nwAPnm+V7HzeplyN0PTQpuBT70nF/iDrfreqQnVGNxnX@vger.kernel.org, AJvYcCWs7qxuOh3fmvf1xzqu55WI4ZyrCXqHmxUvGEVicdIIrwiP8nS4HFJ203W0JGwMi10YvdoN2DD2MvMDQ4Iy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9+60e5RNVmLH0pooc9daZhDIX2BW3l3GjSNTmpeLyxhLTFYjA
	ylIeXyEsYTjViyBw5d46MyygKFKaNPp+ZjjDcxi6cUj4+5+3noVe
X-Google-Smtp-Source: AGHT+IG+QOHt0ycOAwDcbC8TJ8OplkTJg1hkCdA4fgS8r4ZISfqNi0rcD93EkYDnOCy7nljxHuRf4Q==
X-Received: by 2002:a05:6a21:3384:b0:1db:dcc6:dd39 with SMTP id adf61e73a8af0-1dc17a82fb1mr1314337637.26.1730984230627;
        Thu, 07 Nov 2024 04:57:10 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:10 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	hawk@kernel.org,
	idosch@nvidia.com,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 4/9] net: ip: make ip_route_input_slow() return drop reasons
Date: Thu,  7 Nov 2024 20:55:56 +0800
Message-Id: <20241107125601.1076814-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
References: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input_slow() return skb drop reasons,
and following new skb drop reasons are added:

  SKB_DROP_REASON_IP_INVALID_DEST

The only caller of ip_route_input_slow() is ip_route_input_rcu(), and we
adjust it by making it return -EINVAL on error.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- use indentation after the out label
---
 include/net/dropreason-core.h |  6 ++++
 net/ipv4/route.c              | 56 ++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a2a1fb90e0e5..74624d369d48 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -79,6 +79,7 @@
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
 	FN(IP_LOCALNET)			\
+	FN(IP_INVALID_DEST)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -386,6 +387,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
 	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
 	SKB_DROP_REASON_IP_LOCALNET,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_DEST: the dest ip is invalid:
+	 * 1) dest ip is 0
+	 */
+	SKB_DROP_REASON_IP_INVALID_DEST,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 566acd08aedf..1c4727504909 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2204,9 +2204,10 @@ static struct net_device *ip_rt_get_dev(struct net *net,
  *	called with rcu_read_lock()
  */
 
-static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			       dscp_t dscp, struct net_device *dev,
-			       struct fib_result *res)
+static enum skb_drop_reason
+ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		    dscp_t dscp, struct net_device *dev,
+		    struct fib_result *res)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
@@ -2236,8 +2237,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		fl4.flowi4_tun_key.tun_id = 0;
 	skb_dst_drop(skb);
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
 	res->fi = NULL;
 	res->table = NULL;
@@ -2247,21 +2250,29 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	/* Accept zero addresses only to limited broadcast;
 	 * I even do not know to fix it or not. Waiting for complains :-)
 	 */
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(daddr))
+	if (ipv4_is_zeronet(daddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 	/* Following code try to avoid calling IN_DEV_NET_ROUTE_LOCALNET(),
 	 * and call it once if daddr or/and saddr are loopback addresses
 	 */
 	if (ipv4_is_loopback(daddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_destination;
+		}
 	} else if (ipv4_is_loopback(saddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_source;
+		}
 	}
 
 	/*
@@ -2316,19 +2327,26 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		err = -EHOSTUNREACH;
 		goto no_route;
 	}
-	if (res->type != RTN_UNICAST)
+	if (res->type != RTN_UNICAST) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 make_route:
 	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-out:	return err;
+	if (!err)
+		reason = SKB_NOT_DROPPED_YET;
+
+out:
+	return reason;
 
 brd_input:
-	if (skb->protocol != htons(ETH_P_IP))
-		goto e_inval;
+	if (skb->protocol != htons(ETH_P_IP)) {
+		reason = SKB_DROP_REASON_INVALID_PROTO;
+		goto out;
+	}
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = -EINVAL;
 		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
 						    dev, in_dev, &itag);
 		if (reason)
@@ -2349,7 +2367,7 @@ out:	return err;
 		rth = rcu_dereference(nhc->nhc_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
-			err = 0;
+			reason = SKB_NOT_DROPPED_YET;
 			goto out;
 		}
 	}
@@ -2386,7 +2404,7 @@ out:	return err;
 			rt_add_uncached_list(rth);
 	}
 	skb_dst_set(skb, &rth->dst);
-	err = 0;
+	reason = SKB_NOT_DROPPED_YET;
 	goto out;
 
 no_route:
@@ -2407,12 +2425,8 @@ out:	return err;
 				     &daddr, &saddr, dev->name);
 #endif
 
-e_inval:
-	err = -EINVAL;
-	goto out;
-
 e_nobufs:
-	err = -ENOBUFS;
+	reason = SKB_DROP_REASON_NOMEM;
 	goto out;
 
 martian_source:
@@ -2469,7 +2483,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return reason ? -EINVAL : 0;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5


