Return-Path: <bpf+bounces-42030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E010499EECB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A29DB2262B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73041D5142;
	Tue, 15 Oct 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSUI/B4s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A251B2196;
	Tue, 15 Oct 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001311; cv=none; b=DzNyPg6uuHwd0hqVg199kjQxdhxLAwnJXOvCw8dqeWbZ73GeIj7UQltjlJ0d0kXzou2rIuHIS8sbgdG+h6WcVFZoo8JNtkrDyq7EBdW1vhIJ9PxoI+D2k57f06kYT6D17MEJxbO1bo12Q1YfQRALCe9OD3/JAnfHBQDxgdO/aHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001311; c=relaxed/simple;
	bh=vuIVB6hj3sTojMcEzLdz2fDB0hk+PCA25oNYDh11e4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUJEGWErAH+z2V87hIF/o19nPt9H4SzkeoutwQ+S3ouQruaV/SpYSqqfSj/42IwxwANUNm4Xm64iw48bRpKcefIzPo0oeftFkjPge3NR/9+PxCqqkQom/TVSs4GpEeYgm7PG5wNLrrSJJb8Elp34WASHA2vvC0cAAKIqB6iltt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSUI/B4s; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20c70abba48so36186645ad.0;
        Tue, 15 Oct 2024 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001308; x=1729606108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT6uU9JqzHOOu2LSHqsbJX6hAIgV10uw9l8Y9B61PJY=;
        b=MSUI/B4sU3nXbQqWE1eRWi2+8j2oLFQ0a/93rNP6Gv0+NENaXLsdVZencibB6xXZPP
         V06+tejcPFbQH38APwUeiJs9biX/kTXHwer9Dpkr3TC+H6lOjMcV2ou/awWDcI+tcKTX
         Jw0ZHVpeGzK5YYzB061Qk88zG2ORtY3hZOcXDMwV/njNd9kFVkTNKttWjGdxxoeyRUbD
         yYTOrA05Q7QZARCFngZj9UgjdY91ywW1zi7GzpzXt+xtM2ZNdw2vw1/5F34g8Bi+aE3l
         SKuVoC04HwJ5XmoCKaXfd0r4pgnvgz3tOFPCocVtcrv/u+UfoWmNAq2G3U8/u+DPJiC8
         mC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001308; x=1729606108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CT6uU9JqzHOOu2LSHqsbJX6hAIgV10uw9l8Y9B61PJY=;
        b=xAbm50dNtdQx1ujSxeuX8uUcziExBN46RfVA5VdmTGvWC4lm1Af+1FLdeYOLkqXjN2
         gXQnzQIcvT0qqWLnp5Cu9AOpkvGDGrIEqrNSnSqmCbck+/1qfYjo7TtKX2krly4NWY9a
         Hox31A2GRHchd/z/8kSHjpbF0tNr04+Led3dfrHEy3E5aPhFruW/1IKP8qBfImHIW9ed
         L1E9Miw78tQ01/RR0Y5RsD7Anq1RsG7siPMxHWZuUJH4308N7M9o6b4m12Yfva9+TN2e
         JID7wSWyAxd0Nh59xVVfVn4NswTwW9CGChAvsjVpNdC/k4nbn/QmV3wY7gZChL/EtdCl
         bTJw==
X-Forwarded-Encrypted: i=1; AJvYcCVk7HNhTpbIKdT8BtxgPyBo7/BAWEFTowGtQW9BFlvsZcupraDIq4ox/5QqYpn7OdhJox3MYxhHvW1l0FKp@vger.kernel.org, AJvYcCWbPce7eTQkaXCGDobnT+nVsuNWT+B20LbPNKDAHCSSFC06RWXhnxVcjHFTC3gXvSs3ri+1o2yx@vger.kernel.org, AJvYcCWw3/SNFyW7KH8qJXI5NBdgcAglqpO7275lTFEEN+NAIULk4ECzOHCaLDf8afRbJJ1/bNFldwt7FaijkGvjqGlx@vger.kernel.org, AJvYcCWzh/uQiYEXd3uTC0+0TCrSUS9Cz2XS2ZvqVHE+eeLVeUw6vJ6HOlsS45M8OTdErQ6E7Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN8bq0zjKU4+btEAobfCkEB0jvzeewLsazIXWqHa+J/a8AvRU
	iR7D0aCzbmLmfyk4lbQdeeb4DUhvZaA8m7VtbkK7wOtdW90C/jjD
X-Google-Smtp-Source: AGHT+IFVKsMCCaGMAa35EAsJT8GlSeOwzSVb29rITdxcHpxoMjKmc4qwLx0o5XFUlgbG+QD/fUFC8g==
X-Received: by 2002:a17:902:e5d2:b0:20c:ce9c:bbb0 with SMTP id d9443c01a7336-20cce9cbddfmr147567465ad.0.1729001307715;
        Tue, 15 Oct 2024 07:08:27 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:27 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	idosch@nvidia.com,
	ast@kernel.org,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 02/10] net: ip: make fib_validate_source() return drop reason
Date: Tue, 15 Oct 2024 22:07:52 +0800
Message-Id: <20241015140800.159466-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015140800.159466-1-dongml2@chinatelecom.cn>
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make __fib_validate_source return -reason instead of
errno on error.

The return value of __fib_validate_source can be -errno, 0, and 1.
It's hard to make __fib_validate_source() return drop reasons directly.

The __fib_validate_source() will return 1 if the scope of the
source(revert) route is HOST. And the __mkroute_input() will mark the skb
with IPSKB_DOREDIRECT in this case (combine with some other conditions).
And then, a REDIRECT ICMP will be sent in ip_forward() if this flag
exists. We can't pass this information to __mkroute_input if we make
__fib_validate_source() return drop reasons.

However, we can make fib_validate_source() return drop reasons, and call
__fib_validate_source() directly in __mkroute_input().

In the origin logic, LINUX_MIB_IPRPFILTER will be counted if
__fib_validate_source() return -EXDEV. And now, we need to adjust it by
checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
effect only after the patch "net: ip: make ip_route_input_noref() return
drop reasons", as we can't pass the drop reasons from
fib_validate_source() to ip_rcv_finish_core() in this patch.

Following new drop reasons are added in this patch:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- make fib_validate_source() return drop reasons, instead of -reason.
---
 include/net/dropreason-core.h | 10 ++++++++++
 include/net/ip_fib.h          |  9 ++++++---
 net/ipv4/fib_frontend.c       | 19 ++++++++++++------
 net/ipv4/ip_input.c           |  4 +---
 net/ipv4/route.c              | 37 ++++++++++++++++++++---------------
 5 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index d59bb96c5a02..62a60be1db84 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -76,6 +76,8 @@
 	FN(INVALID_PROTO)		\
 	FN(IP_INADDRERRORS)		\
 	FN(IP_INNOROUTES)		\
+	FN(IP_LOCAL_SOURCE)		\
+	FN(IP_INVALID_SOURCE)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -373,6 +375,14 @@ enum skb_drop_reason {
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
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 90ff815f212b..b3f7a1562140 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -452,13 +452,16 @@ int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 			  dscp_t dscp, int oif, struct net_device *dev,
 			  struct in_device *idev, u32 *itag);
 
-static inline int
+static inline enum skb_drop_reason
 fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 		    dscp_t dscp, int oif, struct net_device *dev,
 		    struct in_device *idev, u32 *itag)
 {
-	return __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
-				     itag);
+	int err = __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
+					itag);
+	if (err < 0)
+		return -err;
+	return SKB_NOT_DROPPED_YET;
 }
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index f74138f4d748..71fa9cee9149 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -347,6 +347,7 @@ int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 {
 	int rpf = secpath_exists(skb) ? 0 : IN_DEV_RPFILTER(idev);
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	struct flow_keys flkeys;
 	int ret, no_addr;
 	struct fib_result res;
@@ -369,7 +370,7 @@ int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 		 * and the same host but different containers are not.
 		 */
 		if (inet_lookup_ifaddr_rcu(net, src))
-			return -EINVAL;
+			return -SKB_DROP_REASON_IP_LOCAL_SOURCE;
 
 		goto last_resort;
 	}
@@ -400,9 +401,15 @@ int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 
 	if (fib_lookup(net, &fl4, &res, 0))
 		goto last_resort;
-	if (res.type != RTN_UNICAST &&
-	    (res.type != RTN_LOCAL || !IN_DEV_ACCEPT_LOCAL(idev)))
-		goto e_inval;
+	if (res.type != RTN_UNICAST) {
+		if (res.type != RTN_LOCAL) {
+			reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
+			goto e_inval;
+		} else if (!IN_DEV_ACCEPT_LOCAL(idev)) {
+			reason = SKB_DROP_REASON_IP_LOCAL_SOURCE;
+			goto e_inval;
+		}
+	}
 	fib_combine_itag(itag, &res);
 
 	dev_match = fib_info_nh_uses_dev(res.fi, dev);
@@ -435,9 +442,9 @@ int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return 0;
 
 e_inval:
-	return -EINVAL;
+	return -reason;
 e_rpf:
-	return -EXDEV;
+	return -SKB_DROP_REASON_IP_RPFILTER;
 }
 
 static inline __be32 sk_extract_addr(struct sockaddr *addr)
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 89bb63da6852..c40a26972884 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -425,10 +425,8 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	return NET_RX_DROP;
 
 drop_error:
-	if (err == -EXDEV) {
-		drop_reason = SKB_DROP_REASON_IP_RPFILTER;
+	if (drop_reason == SKB_DROP_REASON_IP_RPFILTER)
 		__NET_INC_STATS(net, LINUX_MIB_IPRPFILTER);
-	}
 	goto drop;
 }
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a0b091a7df87..df5401efbf56 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1669,7 +1669,7 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  dscp_t dscp, struct net_device *dev,
 			  struct in_device *in_dev, u32 *itag)
 {
-	int err;
+	enum skb_drop_reason reason;
 
 	/* Primary sanity checks. */
 	if (!in_dev)
@@ -1687,10 +1687,10 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
 			return -EINVAL;
 	} else {
-		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
-					  itag);
-		if (err < 0)
-			return err;
+		reason = fib_validate_source(skb, saddr, 0, dscp, 0, dev,
+					     in_dev, itag);
+		if (reason)
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -1785,9 +1785,10 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 		return -EINVAL;
 	}
 
-	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
-				  in_dev->dev, in_dev, &itag);
+	err = __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
+				    in_dev->dev, in_dev, &itag);
 	if (err < 0) {
+		err = -EINVAL;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -2140,6 +2141,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	int err = -EINVAL;
 	u32 tag = 0;
 
@@ -2158,9 +2160,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
 
-	err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev, in_dev,
-				  &tag);
-	if (err < 0)
+	reason = fib_validate_source(skb, saddr, daddr, dscp, 0, dev, in_dev,
+				     &tag);
+	if (reason)
 		goto martian_source;
 
 skip_validate_source:
@@ -2202,6 +2204,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			       dscp_t dscp, struct net_device *dev,
 			       struct fib_result *res)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct flow_keys *flkeys = NULL, _flkeys;
 	struct net    *net = dev_net(dev);
@@ -2296,10 +2299,11 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto brd_input;
 	}
 
+	err = -EINVAL;
 	if (res->type == RTN_LOCAL) {
-		err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev,
-					  in_dev, &itag);
-		if (err < 0)
+		reason = fib_validate_source(skb, saddr, daddr, dscp, 0, dev,
+					     in_dev, &itag);
+		if (reason)
 			goto martian_source;
 		goto local_input;
 	}
@@ -2320,9 +2324,10 @@ out:	return err;
 		goto e_inval;
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
-					  &itag);
-		if (err < 0)
+		err = -EINVAL;
+		reason = fib_validate_source(skb, saddr, 0, dscp, 0, dev,
+					     in_dev, &itag);
+		if (reason)
 			goto martian_source;
 	}
 	flags |= RTCF_BROADCAST;
-- 
2.39.5


