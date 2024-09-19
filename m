Return-Path: <bpf+bounces-40089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7F897C750
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D6289B16
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A219DF8C;
	Thu, 19 Sep 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om9r37ag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4A19CD0F;
	Thu, 19 Sep 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739001; cv=none; b=PoKLzSou/mAXxJ6nKMPd9a1YChcYUJ/tnYvnn93QPmim+V+APhxpzkLTYZMtyQ5KLJlR9Km8kD6jdHxqfDpcOcnqAZpNade/m+2/ZxPmZKR8enm9CMGG0JN80KinM/9i82SGB56nTSzvHdelPC/mG5di8riWt5hzaNrjwEU0OwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739001; c=relaxed/simple;
	bh=YqEogfeJLe9c/3bfq2XxyWEglvHt5kZYl7TE1QySazM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhhFkhCJ/AB+OdVxzM4Yk1ek8C2cWiBJIYoDEDTDNArcJXcYF1zRQL+9mYyOvcHu/lG1pHVsc8GsW3lK9X0Bnt3+23q2b1w07TQZexTxuvYSDUkn0ixLLod6u45Fce3dsVAwMocIpA0u45dTr/jO/CIrdjEvXHKyS5fnWrQ/Tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om9r37ag; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-718e3c98b5aso452842b3a.0;
        Thu, 19 Sep 2024 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738976; x=1727343776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiHzu+ulvjky3wzgvQb46nJbDFBRKyZby3oN41FMw90=;
        b=Om9r37agyzlNK0ODYoQ7y7Hz3W3aANEC5JNt8gESy4FIvKqybXJbH1uw/A+izohIXz
         DGkbPadTKXBoO8SR1stpWa9hIoTVvmCXYe7Iz8TogEjfmwgFmujr16EqP/3XJRijUVpD
         lmm+S3YGHXnj9jdJjKUuqxIv8e/vRvzhu8Cfg3m5M9vS9NZWfs30ux22QlItYcgKgZrk
         1q6MXz/EmOiOSFcT99bb/T06+w+dJmtEx1VuSs5fMDj1biiQPH1E0kmTjHRaW3eEYnek
         osNYn/ZRqe0hxySkvSgbRJ4KDjOSlRimdxbzdVOfx6wBkSuXXK19+av2xrMkOOJNNulM
         vteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738976; x=1727343776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiHzu+ulvjky3wzgvQb46nJbDFBRKyZby3oN41FMw90=;
        b=FZyDGQUG1y1yes+OiO/09K8quaCvpg2WxV6wFbX4cid1gY15IAcqYO9nClk+z2E5Xr
         96wNUz6WytNgsW1lUdh1VOc8kS72eJ0qq1kPC9+Ow4ieZLdMy1f6kJn14gRJ038mAPQt
         w5aSluhA+ihbe3SecLsqFto+Vkwj0VPMatEkLLNxI04d0c6012aQ372TE7vJvuRH1luZ
         n5Z6lq492/L0NL1ToyVO/akvFr6Q18L3ssBzA1TLwisMyKgiLPsPzE37HfgTWVwZB7Ee
         QIX2NO7MYREYY5I6uz1Llnx5hNKHojmWq1CdBvEkq8gvf924hbr90nJHZXhvsr14h04X
         pzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPl6jmTMhQ34wcebB0s9Hdrq9lppZi3yJ22NL58/H8GXm0Dr3fzNoiTAWghpHf4ID12ADT8KnjrvYZdHsf@vger.kernel.org, AJvYcCXKZcwN/mUZYRJxI2e6bwNoU71JK9Xg5PVdTg/FrDxpafFAaZw6X9XzytkkdjG2c4+rEPw=@vger.kernel.org, AJvYcCXQX0t5jJ1RDg88+NPMSmJVv4wAeBmdkfDltcd+fKU+hQZx71kEqIorOgtc9iscS+ChUvq+nIAq@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHUs7PTKpeO+nzFnWOx0Q73CYjYq5ojhdXD+vL8cZ/zeXrxqi
	ASVrcNYZPU1kmvoy8CBmTz3wYXeXoEwXKJDYphNXTMzp2a73H5ER
X-Google-Smtp-Source: AGHT+IH7ANk7LXkUzm00s2JI1I12YeLDmyWArXvS90FG/fLxbxsSuUjx0W37x6a0U8NFoAGyW2g0fA==
X-Received: by 2002:a05:6a00:1a93:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-719261cb441mr36998322b3a.22.1726738975778;
        Thu, 19 Sep 2024 02:42:55 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:42:55 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
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
Subject: [RFC PATCH net-next 3/7] net: ip: add drop reason to ip_route_input_slow()
Date: Thu, 19 Sep 2024 17:41:43 +0800
Message-Id: <20240919094147.328737-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919094147.328737-1-dongml2@chinatelecom.cn>
References: <20240919094147.328737-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input_slow() support skb drop reason by
adding the pointer of drop reason to its functions aeguments.

Following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_INVALID_DEST
  SKB_DROP_REASON_IP_LOCALNET

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h | 19 +++++++++++++++++++
 net/ipv4/route.c              | 32 ++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 4748680e8c88..3d1b09f70bbd 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -76,6 +76,10 @@
 	FN(INVALID_PROTO)		\
 	FN(IP_INADDRERRORS)		\
 	FN(IP_INNOROUTES)		\
+	FN(IP_LOCAL_SOURCE)		\
+	FN(IP_INVALID_SOURCE)		\
+	FN(IP_INVALID_DEST)		\
+	FN(IP_LOCALNET)			\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -365,6 +369,21 @@ enum skb_drop_reason {
 	 * IPSTATS_MIB_INADDRERRORS
 	 */
 	SKB_DROP_REASON_IP_INNOROUTES,
+	/** @SKB_DROP_REASON_IP_LOCAL_SOURCE: the source ip is local */
+	SKB_DROP_REASON_IP_LOCAL_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_SOURCE: the source ip is invalid:
+	 * 1) source ip is multicast or limited broadcast
+	 * 2) source ip is zero and not IGMP
+	 */
+	SKB_DROP_REASON_IP_INVALID_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_DEST: the dest ip is invalid:
+	 * 1) dest ip is 0
+	 */
+	SKB_DROP_REASON_IP_INVALID_DEST,
+	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
+	SKB_DROP_REASON_IP_LOCALNET,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 385efe6d71a7..ab70917c62e5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2202,8 +2202,10 @@ static struct net_device *ip_rt_get_dev(struct net *net,
 
 static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			       u8 tos, struct net_device *dev,
-			       struct fib_result *res)
+			       struct fib_result *res,
+			       enum skb_drop_reason *reason)
 {
+	enum skb_drop_reason __reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct flow_keys *flkeys = NULL, _flkeys;
 	struct net    *net = dev_net(dev);
@@ -2231,8 +2233,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		fl4.flowi4_tun_key.tun_id = 0;
 	skb_dst_drop(skb);
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		__reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
 	res->fi = NULL;
 	res->table = NULL;
@@ -2242,21 +2246,29 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	/* Accept zero addresses only to limited broadcast;
 	 * I even do not know to fix it or not. Waiting for complains :-)
 	 */
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		__reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(daddr))
+	if (ipv4_is_zeronet(daddr)) {
+		__reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 	/* Following code try to avoid calling IN_DEV_NET_ROUTE_LOCALNET(),
 	 * and call it once if daddr or/and saddr are loopback addresses
 	 */
 	if (ipv4_is_loopback(daddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			__reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_destination;
+		}
 	} else if (ipv4_is_loopback(saddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			__reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_source;
+		}
 	}
 
 	/*
@@ -2315,7 +2327,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 make_route:
 	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, tos, flkeys);
-out:	return err;
+out:
+	if (reason && err)
+		*reason = __reason;
+	return err;
 
 brd_input:
 	if (skb->protocol != htons(ETH_P_IP))
@@ -2406,6 +2421,7 @@ out:	return err;
 
 e_nobufs:
 	err = -ENOBUFS;
+	__reason = SKB_DROP_REASON_NOMEM;
 	goto out;
 
 martian_source:
@@ -2462,7 +2478,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return err;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, tos, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, tos, dev, res, reason);
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5


