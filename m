Return-Path: <bpf+bounces-43477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7F9B5976
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C981F21828
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA1BE46;
	Wed, 30 Oct 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPq6wEsC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F971D0146;
	Wed, 30 Oct 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252629; cv=none; b=W3m1QJBzY32xpswcHNQylQUCvjiy3E1KyZ8KdQvstb0wayxW1QcUW+K4z/ZaJLX7l5gYM09FneLQa9Vlm0pcnalWvB9FV3jrcBI7YLhiRdEX1fhQJqjd3l41HvMRc8/7PNedc7EfRhNA51KHG0byHYiHLy/AtRNElGBIdNFfk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252629; c=relaxed/simple;
	bh=EMREDF0iOw1a8AUc1cBDT7vV5AQ/kyb1iJVNxRQBLoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBjEOgXAoqrhJtT/xtgnxXvzsOjcW9xf5wU4pSwMZ5kfZ5Le2+lzFmUhpUA+zj3/khEBOUWjADml+UX7KScIrwTMQiuGhH2Mpnk9c3Vl+s8AfoavhLXg08fVKdXgB2V3MxPuLqfPHABAsVlyzLgJrOqQBVw1n+MxXt4s5Qge4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPq6wEsC; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso3110612a12.1;
        Tue, 29 Oct 2024 18:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252626; x=1730857426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKE65jm2ZhKpehsNXTCP/V6ZnTRszfwNpxwi3OTB6Pg=;
        b=mPq6wEsC3VaF0cNMqS8E2O4qb+s7YUK2QOWSXb417v1w+rAVU6U3s0Uobkwpd+q8HK
         YSL60w7RPv9EU2HKksqh+MdC7QSBc5gNg6Jw1vDjer46c9gV4TEn9BEHgXm44mednJ/s
         yyYtmLLrveaXEOi/TcKLVKwi9aWExTkWLmYKgCxgpO85UkJPU74MBDRozOT7ySRv541d
         7PKsgd1JADJ77/Udokjypm1JWrGGTkzyN/aMziSsqr1r1sBf6s1AtgbAuyGb6/D5NuOe
         N2ZYjGEuirZfJXztF6XClJYq8y3WUc/tfPsPhRGAPTXA8lHZykZbn72KpiDqp5NLSPqd
         mXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252626; x=1730857426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKE65jm2ZhKpehsNXTCP/V6ZnTRszfwNpxwi3OTB6Pg=;
        b=BQ4/vqmYRCuhRAgCMI0wEAlW6lEwKEbcqKXU7wAe/yvF8GTrHso/XbYssGH5ee3iPm
         m4gxzWmBjSX1mAbdkm3KLrJbEjKnzU8EapatBVJjuxvn+AO3hNO2M3WEq2AZv0dwzcDo
         thcR7vtkai505UlIr6t9HP4oPIvGFm2SkN6eFlkX3djGiodWeB+Gt9NoxFfFS13KikFJ
         UoNFaxmeg1A4ZGrQfFxQ6qJSRmu2H1FM9cG3HI+2FpwTeIiNEgMJeFRFB7p2eVzR8uv/
         dMHxHSfgTcoqfpSMPftLshCBTCHKmiCHOyjKMAFVEGP161Ebpz1p6q79dPXcz9Ax5ZJp
         MwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw3dmxa5WD+NRmjCE5D4OCDPl8D+Dzawg5oePI0+bpaesf88sHCfF0ywK/xg/4lHGA8Dg=@vger.kernel.org, AJvYcCVR3FrwqQCkuozHwubDksLppwqkD5hLhn5j7tCefHDNOX65pYZxyYpd19lVNFNHldddlI2AvfEUJ6megXuW0eur@vger.kernel.org, AJvYcCX6fla8hl8sSVR0Q45arLfT2h+cFcJjiEKT7VJ78RFmjQhSPYbObyZRDAuCbP8SQLK+Ghgjd/d5y7P2lDeU@vger.kernel.org, AJvYcCXPcWJK37ptqQcDreNET4GZEeh/sxvOlz5F7F58qTe9rv1mtT7WM+z75rDqLtzmu1YHqA2QXVvD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RjpmOQ++ZI1ylhESwx4reCw2oL66DSRJn8VF/MX0Wd6jUDHX
	CgLKEon6on1PTolPU8BjIzcqcLfg5eNEK/pheGTDTuF0Onu5/sin
X-Google-Smtp-Source: AGHT+IEvIzgXUf05JXSQhRN/QPYHDdkNnuHWw6LIIFNVmixhsH0arx2gxEoTUbpvghWxKbrNn90HSw==
X-Received: by 2002:a05:6a21:2d85:b0:1c4:9f31:ac9e with SMTP id adf61e73a8af0-1d9a8514483mr17967010637.42.1730252626407;
        Tue, 29 Oct 2024 18:43:46 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:46 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 9/9] net: ip: make ip_route_use_hint() return drop reasons
Date: Wed, 30 Oct 2024 09:41:45 +0800
Message-Id: <20241030014145.1409628-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_use_hint() return drop reasons. The
drop reasons that we return are similar to what we do in
ip_route_input_slow(), and no drop reasons are added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h |  7 ++++---
 net/ipv4/ip_input.c |  9 ++++-----
 net/ipv4/route.c    | 26 ++++++++++++++++----------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f4ab5412c9c9..4debc335d276 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -206,9 +206,10 @@ ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 enum skb_drop_reason
 ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     dscp_t dscp, struct net_device *dev);
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint);
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint);
 
 static inline enum skb_drop_reason
 ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src, dscp_t dscp,
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 513eb0c6435a..f0a4dda246ab 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -322,15 +322,14 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	int err, drop_reason;
 	struct rtable *rt;
 
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
 	if (ip_can_use_hint(skb, iph, hint)) {
-		err = ip_route_use_hint(skb, iph->daddr, iph->saddr,
-					ip4h_dscp(iph), dev, hint);
-		if (unlikely(err))
+		drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
+						ip4h_dscp(iph), dev, hint);
+		if (unlikely(drop_reason))
 			goto drop_error;
 	}
 
+	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
 	    !skb_dst(skb) &&
 	    !skb->sk &&
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e248e5577d0e..7f969c865c81 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2142,28 +2142,34 @@ ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
  * assuming daddr is valid and the destination is not a local broadcast one.
  * Uses the provided hint instead of performing a route lookup.
  */
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint)
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
-	enum skb_drop_reason reason;
-	int err = -EINVAL;
 	u32 tag = 0;
 
 	if (!in_dev)
-		return -EINVAL;
+		return reason;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+		reason = SKB_DROP_REASON_IP_LOCALNET;
 		goto martian_source;
+	}
 
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
@@ -2179,7 +2185,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 martian_source:
 	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
-	return err;
+	return reason;
 }
 
 /* get device for dst_alloc with local routes */
-- 
2.39.5


