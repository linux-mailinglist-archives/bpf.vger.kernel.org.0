Return-Path: <bpf+bounces-43032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF49AE0F1
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61451F212B4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EF1C8787;
	Thu, 24 Oct 2024 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqBG812n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333471C4A31;
	Thu, 24 Oct 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762500; cv=none; b=QtN4BGcnwGHDrc5U3I/XP9xMHO92mxN88v1nX8+4rY4w7YspkaqlcXjmSx48wMAZgjZKupuZK6ux2UY5xZ4tAm45kkvRcy0nT5yf3ZyqXFpewbZA7GgHQhKQnXeX84LWdLj8/CpNrkqn2vgNzvKSptxlIQ1pH2V7+5vwlX1TCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762500; c=relaxed/simple;
	bh=3YElXoEQ+yUNbFW9Wyxpt2iVq3RLFcdsi8PfQ7hukmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n89Lrav1s2nx1FJrVYSQ5BdJfigVy8TevHXZjnU+ckQfoAHR/vT9wCN5lptDKPbVNVIdtoTDZjPngqV8/jEKXo5gdQJx6CP8Jh67wnTa7F9VT2zlUIibAcIKJQOb+GHt5mgHr8mV6w9WME16o4UnAyb5A5fz2xXuAY/Ekfmj7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqBG812n; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so458843b3a.1;
        Thu, 24 Oct 2024 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762497; x=1730367297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4XG1zbVojbOWNVJydovPrjgNaiIX/ME9FvHgIXEZso=;
        b=aqBG812nBwclRbjrQ+c6/BCb/iM0k71Aq2NUnuRMKIQirEvmxSjTa2ez2dZQMgRkbh
         OOpKIV6Y5ANFgwdJT2y8EGXEgBFTNH+sFCfspXHUy7LTWrZ5x9X+hsH/WOaB1SFiVrHG
         p4B18G1i108S3V471c9gvNis1nV5ucWUmnwJ9EjvlaQF6zswLh6KLbze6VbzXiLJ2wUI
         FN+m+0U3PNoQU5cGI5vpjRYYtGNPOLBuBofkit8VlHvOcfd5WcPeSKE/IKsXKKAt2/NZ
         Ba2GezTo8McEP1k2Fn3wSYl8tM6+vGm1iPPO3JuiBwgfJksgiJb10O1MeSHHOPA9ZLhE
         /Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762497; x=1730367297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4XG1zbVojbOWNVJydovPrjgNaiIX/ME9FvHgIXEZso=;
        b=h2hPzoAbCg+3CYxD6CM/3kSd5EdlAU5i/qiN3hPaYBzgMUMX9tE3WYNVhlKEbftNzq
         daDnIbT6V1VQOpZ8L1mnzOVSvBE2Dk/RYB8Ev49doUEdSFYh7isXXJPEy4IEr4UGuV/r
         1VLMNJj4t98AIpsmftgF2K3JL5bdUODwR7PGNiVqBOSJsphPmEGOW5Y9Wd9d3JZbC/6g
         W75sg2jtPPJKvISZR7Z7mZrXTbBEufi6Rn2b46uUuD4+lH32eM0QtQqwuSOToR38W/ca
         FLPnkRRVufir3bGXI4M8zQ+QBUZpvedZGIWHpfkcBi8ow+WhORYFVYYEe6zMo8b83DFR
         scwg==
X-Forwarded-Encrypted: i=1; AJvYcCU0JjTlHz/PxxVU3C5cVCo6FIRi03r7XiCkjicaMqM7/cUKLpVXPtQ0BII0dxRzgUr2kgh3rssf@vger.kernel.org, AJvYcCWWwIFuctNzM9qhOWUmw16kNWRg2z45Nstp3zLaEVUmR2Dh1RI5PSXuq+oKJfGSojpp98th85mVO3Ussgyd@vger.kernel.org, AJvYcCXCf3RXLBYt9uk44LmbAto9YQ2WM78BazE9hU2AGkgAL5qE6nzm9+sIsQaVABiYQugtcp6m1iFbhqAsR3j/HcX+@vger.kernel.org, AJvYcCXMwZw2adJYdZGCZPD4xq+GZUVHIXIKBGhgurDlRGmp0Vj9E3m33l9wCM3xtLiqWR10zuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YzkfahkOe9Hmb5Q6E/gNEWzyKB7VYecZw9DUyTlr+nr/s4Kg
	5ZXpcOvotnkCs+Fztj+XKMIIMl3hRBmshuxVyC0DS4UU2D6kTQZo
X-Google-Smtp-Source: AGHT+IFpJ2ifGDdJxovxXUSpx2JOiU4f7ldmWt08Z0KdPCaCCYmMzpNca0VPAbmqmRgKECdIInsjfA==
X-Received: by 2002:a05:6a00:4610:b0:71e:60d9:910d with SMTP id d2e1a72fcca58-7204525ff55mr2542210b3a.6.1729762497299;
        Thu, 24 Oct 2024 02:34:57 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:34:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/9] net: ip: make ip_mc_validate_source() return drop reason
Date: Thu, 24 Oct 2024 17:33:42 +0800
Message-Id: <20241024093348.353245-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024093348.353245-1-dongml2@chinatelecom.cn>
References: <20241024093348.353245-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ip_mc_validate_source() return drop reason, and adjust the call of
it in ip_route_input_mc().

Another caller of it is ip_rcv_finish_core->udp_v4_early_demux, and the
errno is not checked in detail, so we don't do more adjustment for it.

The drop reason "SKB_DROP_REASON_IP_LOCALNET" is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  3 +++
 include/net/route.h           |  7 ++++---
 net/ipv4/route.c              | 35 +++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 62a60be1db84..a2a1fb90e0e5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -78,6 +78,7 @@
 	FN(IP_INNOROUTES)		\
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
+	FN(IP_LOCALNET)			\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -383,6 +384,8 @@ enum skb_drop_reason {
 	 * 2) source ip is zero and not IGMP
 	 */
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
+	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
+	SKB_DROP_REASON_IP_LOCALNET,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/route.h b/include/net/route.h
index 586e59f7ed8a..a828a17a6313 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -199,9 +199,10 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	return ip_route_output_key(net, fl4);
 }
 
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag);
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e579fe5bd3d3..61e316f93291 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1665,34 +1665,37 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag)
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag)
 {
 	enum skb_drop_reason reason;
 
 	/* Primary sanity checks. */
 	if (!in_dev)
-		return -EINVAL;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr) ||
-	    skb->protocol != htons(ETH_P_IP))
-		return -EINVAL;
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+		return SKB_DROP_REASON_IP_INVALID_SOURCE;
+
+	if (skb->protocol != htons(ETH_P_IP))
+		return SKB_DROP_REASON_INVALID_PROTO;
 
 	if (ipv4_is_loopback(saddr) && !IN_DEV_ROUTE_LOCALNET(in_dev))
-		return -EINVAL;
+		return SKB_DROP_REASON_IP_LOCALNET;
 
 	if (ipv4_is_zeronet(saddr)) {
 		if (!ipv4_is_local_multicast(daddr) &&
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
-			return -EINVAL;
+			return SKB_DROP_REASON_IP_INVALID_SOURCE;
 	} else {
 		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
 						    dev, in_dev, itag);
 		if (reason)
-			return -EINVAL;
+			return reason;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* called in rcu_read_lock() section */
@@ -1702,14 +1705,14 @@ ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
+	enum skb_drop_reason reason;
 	struct rtable *rth;
 	u32 itag = 0;
-	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
-				    &itag);
-	if (err)
-		return SKB_DROP_REASON_NOT_SPECIFIED;
+	reason = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
+				       &itag);
+	if (reason)
+		return reason;
 
 	if (our)
 		flags |= RTCF_LOCAL;
-- 
2.39.5


