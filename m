Return-Path: <bpf+bounces-44231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0F49C0693
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D046E2813FA
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFA212EF1;
	Thu,  7 Nov 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jChOgILa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40640210198;
	Thu,  7 Nov 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984211; cv=none; b=q1D3rWEd9JphA2CDOT6lW2tCf7JQlgkFgEG2zZNEHDugwyHrL43ByE+ixPKyePteRlBR+Ljbj3OkxhHzi4sA6JHa0pbZ3W/vMGo0PvEAFVcJHdha/wH+Y9pwB74OSrb3XaqYj35N59cTBCx+RRiCjCgTu6R2XL2E1VoUcX5Ag54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984211; c=relaxed/simple;
	bh=VRFZX0PxZ+x+OxZ+v3J66P8Bzgc+fTvBmulPtkU+gqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXTrYSkVFtcFpzICkpqV7CIzeo/TcoXn8eMzz1KsEJj0VLxhRh/73GRfA8SeX8DRWHP39xGbtX/YN9cLDvaR/eHGhHtml+iJvv+OpHBC9PcjrL0ft5Jys2ZONv/VOXIM/vEVGQJGZoSU4+7g3Hg7b6H58PHAjQ0cu4uCIJRVzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jChOgILa; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso711714b3a.0;
        Thu, 07 Nov 2024 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984209; x=1731589009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G2CC+sHGPF4Txdej5kZadhy+Szsb6AhNP7Za8Jlvvk=;
        b=jChOgILaYGu0yDtrsh3vz+Km6VHGeVoVa9i+3guLmEleKnUOpc4SuNVHU/mNJgjBCo
         YYKmaDecVWTUIZ6mEKMcvXHotW4VFouVtJcmEXq+Di9o6oPN3rc9/M+LwY/qX9eqbof2
         QF4QYPKhmPFho7UOhv7C1w/UWE+5RdcpndNMf0wGxxSjaklECcAJhp6u8kAxUmUvDw4l
         ULAJP/pxl8rOsCeWe4+eH/fOlKYCvZqNuWeebRDEGDYaXp8ESlEJIPut1B7vHErSiLt+
         1M55avYjBydquKENnV429RGN8hH3/ze8tkiVvuU/EHwRVxL72KALh3UDWNkomAWqjipU
         TyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984209; x=1731589009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G2CC+sHGPF4Txdej5kZadhy+Szsb6AhNP7Za8Jlvvk=;
        b=qqsRlYiepfo1RdP9vNlgpVRpE1Qpg6ttafVb91DvOn4yrSErcR7C+fEueckp1eR/hD
         qtDCv4a+tdc7Ax2TQ4yMXPGdKD9UzPyyUtG9cxBXIzu40uYsuqhzhinq8Sq7agRYTgRh
         KVmjiMi4pY9hf26vEfjLkC6n9kviWZPSvHobxcSycecqq5F/iAYxeW/zefk1OZFRCsCY
         1AQcf4AH5eG6rlJLZO3uLdli5U7e+IKbbNgQFBOXTVJl/e33d6sL7Im8vtD2XN3OdOfq
         1uAsVabdNdxbbkL6gahee5FulZmJlTX3Cr7/LGO5tU56uVOWr+4WI0hOc1qpMGiWv/HL
         Xv2w==
X-Forwarded-Encrypted: i=1; AJvYcCU3o6MOfcvVzrsnqmwIeedvr7KJINFp5j3xqTuja21sta+rmPi+jxWWWYx0XgLS9XcaKUXeDA61el2ET1H1@vger.kernel.org, AJvYcCUHKODIOYt8bKSHNcqIb+mpsx7TAFlK+gYx36sa2s/4xQV47dfa3c/5JXj8A6GVj/QbEy8=@vger.kernel.org, AJvYcCXrhEJ/Ghp9yRLmzzPeJeDAIpEsliMbIBN3Cku24y5rnyQWPvRMC2cKSlE46fEMX9gfbBs4sF9ZrRPb7JYEZf4b@vger.kernel.org, AJvYcCXsGEFkean84RPUWH2YHYBq/PbcikK/4fecgsTI4BY0p+vfvI4olmBr9VS1OcsyMKLKDXYCaINl@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkybRXxeCYswgPsEBnx4B8ObE4JnnubOebqwDrnHuhkBnL8hT
	eQ4KcfMEkCad8/kGOJ360YSSNnVZqZHplE4eHXupcpNsopcoIBMm
X-Google-Smtp-Source: AGHT+IHLFBcTBrHyLFQ+zhJ46XQjTNNwOxfse01LfUXbkhPkh8gt9DOvj7vsWJDsF3rCIFHVjsSBig==
X-Received: by 2002:a05:6a00:843:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-7240cdcd278mr1093669b3a.2.1730984209347;
        Thu, 07 Nov 2024 04:56:49 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:56:48 -0800 (PST)
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
Subject: [PATCH net-next v5 1/9] net: ip: make fib_validate_source() support drop reasons
Date: Thu,  7 Nov 2024 20:55:53 +0800
Message-Id: <20241107125601.1076814-2-dongml2@chinatelecom.cn>
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

In this commit, we make fib_validate_source() and __fib_validate_source()
return -reason instead of errno on error.

The return value of fib_validate_source can be -errno, 0, and 1. It's hard
to make fib_validate_source() return drop reasons directly.

The fib_validate_source() will return 1 if the scope of the source(revert)
route is HOST. And the __mkroute_input() will mark the skb with
IPSKB_DOREDIRECT in this case (combine with some other conditions). And
then, a REDIRECT ICMP will be sent in ip_forward() if this flag exists. We
can't pass this information to __mkroute_input if we make
fib_validate_source() return drop reasons.

Therefore, we introduce the wrapper fib_validate_source_reason() for
fib_validate_source(), which will return the drop reasons on error.

In the origin logic, LINUX_MIB_IPRPFILTER will be counted if
fib_validate_source() return -EXDEV. And now, we need to adjust it by
checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
effect only after the patch "net: ip: make ip_route_input_noref() return
drop reasons", as we can't pass the drop reasons from
fib_validate_source() to ip_rcv_finish_core() in this patch.

Following new drop reasons are added in this patch:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- don't refactor fib_validate_source/__fib_validate_source, and introduce
  a wrapper for fib_validate_source() instead.
v2:
- make fib_validate_source() return drop reasons, instead of -reason.
---
 include/net/dropreason-core.h | 10 ++++++++++
 include/net/ip_fib.h          | 12 ++++++++++++
 net/ipv4/fib_frontend.c       | 17 ++++++++++++-----
 net/ipv4/ip_input.c           |  4 +---
 net/ipv4/route.c              | 33 +++++++++++++++++++--------------
 5 files changed, 54 insertions(+), 22 deletions(-)

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
index b6e44f4eaa4c..a113c11ab56b 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -452,6 +452,18 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 			dscp_t dscp, int oif, struct net_device *dev,
 			struct in_device *idev, u32 *itag);
 
+static inline enum skb_drop_reason
+fib_validate_source_reason(struct sk_buff *skb, __be32 src, __be32 dst,
+			   dscp_t dscp, int oif, struct net_device *dev,
+			   struct in_device *idev, u32 *itag)
+{
+	int err = fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
+				      itag);
+	if (err < 0)
+		return -err;
+	return SKB_NOT_DROPPED_YET;
+}
+
 #ifdef CONFIG_IP_ROUTE_CLASSID
 static inline int fib_num_tclassid_users(struct net *net)
 {
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 0c9ce934b490..87bb36a5bdec 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -346,6 +346,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 				 int rpf, struct in_device *idev, u32 *itag)
 {
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	struct flow_keys flkeys;
 	int ret, no_addr;
 	struct fib_result res;
@@ -377,9 +378,15 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 
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
@@ -412,9 +419,9 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return 0;
 
 e_inval:
-	return -EINVAL;
+	return -reason;
 e_rpf:
-	return -EXDEV;
+	return -SKB_DROP_REASON_IP_RPFILTER;
 }
 
 /* Ignore rp_filter for packets protected by IPsec. */
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
index 763398e08b7d..f64c0221c221 100644
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
+		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
+						    dev, in_dev, itag);
+		if (reason)
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -1788,6 +1788,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
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
+	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, 0, dev,
+					    in_dev, &tag);
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
+		reason = fib_validate_source_reason(skb, saddr, daddr, dscp,
+						    0, dev, in_dev, &itag);
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
+		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
+						    dev, in_dev, &itag);
+		if (reason)
 			goto martian_source;
 	}
 	flags |= RTCF_BROADCAST;
-- 
2.39.5


