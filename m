Return-Path: <bpf+bounces-40648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91D98B410
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B7C283432
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ACF1BDABA;
	Tue,  1 Oct 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UULuon5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7A1BBBD7;
	Tue,  1 Oct 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762481; cv=none; b=HfJ24P+XpUb/QCsgPGFb8yXe2YmSn5FKGnq7V0OfCBPf4enuLjv3XyIUS2YqZ59oXYG8G9n63iG+xPTV/qV0Ne2iAjvZvZd4xPZzoMUNC8doxvfoomkzazDWYOO0GpWM2QyI6HYX+JG/baYGkWHk1/NvFUWMUsSG2ypIRFqueq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762481; c=relaxed/simple;
	bh=AqI7arKaEVMpTT2qhZmIJZA5E+txg/W+R4/pPMw2DaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvtboWywFSO0I6WsEp/nWIAT/y2/t6RRbmbiYfSsVxYIKsnMX9jPCS1cwFiwc/tw4I1/JbyDAE3i3xUF5QrzSAWhlxh6nb0+i+NBpqKH74vZVU8tOQjMW6/8gGsS+VrOEjzAh1ToUQWS1G8159QGIdFISwmVlkJCZM3fkX5d01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UULuon5K; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so3441120a12.3;
        Mon, 30 Sep 2024 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762479; x=1728367279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbPGgSOikK+F605onoyc1YqeJXlzGc1QhlYtJFewpEo=;
        b=UULuon5K2hhOO/MvMC1iND6N4ePe2AKyv4d1UJXnFJGxagii+xeGFvQ9KTu9v5dvTN
         iSZ8zgjalzbL6chu9rAD+2PsT8PKUOAbIdeTZgDBBrjkHV5aEM63aJv+B09coal6NzMg
         gKekc+uTAn+kLMSMVgOwDrxunTMlhZ7jS7TG7DiasLReenqTZ3wWN8sF+aK9nIYCo8kv
         OZTdZLD5XjGq0KHK65kY31d73nnDFknsClo3E2/Y1q3hMDoQF5IqFx8kM3g6zuzqP9sp
         LjXMkJbIzMXZh8sfhWnPRgS0RtWw7sL5XuDRRb99ps1tkZw+8Z3581DS3fQnOZCNOhtI
         fliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762479; x=1728367279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbPGgSOikK+F605onoyc1YqeJXlzGc1QhlYtJFewpEo=;
        b=MKXRikUxBxaKKlY4LU1Ol1fAxKyrKsFZByDbgNy0zFleGW9bIAxu0+h8rjiLEgRIVu
         lPYwn4AUbmRKizw5mjYHxa57B8to20THVsVV/WSSnD0Ma5WxvJWr1WCIHWqxrjE1C+d7
         i3AhjDaU3GDD2kNyVtAztrLJsybrO2O/9eRf9ENG92eMlNfnPf4FrVb9p7mzuKY91mcl
         fyViUcFVd9wSjNYMkHWdcOI1xZC6XJm3ctS3YK3om/GIAt34WNEDkmjzkhBpx93QXes3
         Ef6+xhK3XbfcPNxazio8LxiCOFA0+fYLDtTQRk5OrwRuDrSYgGq//YnyMbTVqIt4HmbX
         ZQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCU1hXS0ko0Bm8YLZoTqVgfmi+GZN7UI9NzG1iTXuVrCUzYUARYPOXQB9Y1vQvT9gCMgPCNB2IpJbRJdD0G+@vger.kernel.org, AJvYcCVCf71HlPCILDwSquZHy1L6Lck3cqMLBgsPP75MhF/fCwy8fjsoJqVe/ILncqDetGySrLs=@vger.kernel.org, AJvYcCVE0a+UjjN4a8dfHDztL0/bR+Wi2rQj2aOaPxKYjJ1IjQfS++gNT/f/vdrOgQvby3laD+pDouiG@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcwomUfK3gCD/faE7zNOIxjRe7LXA/UmYjDS+jS8KBcasYI02
	tuBAAz7v8otB761F7xKO32eG8i8CRXJ0dYduE0Y46pP4y/AWx6vJ
X-Google-Smtp-Source: AGHT+IFMaUccJG2q6m6uvtlz1CAeZzt/87PRSN0BUde3JiMNj/hQhrk337sjxmHRYIrjlH0Rr5BT7w==
X-Received: by 2002:a05:6a20:cf84:b0:1cf:49a6:9933 with SMTP id adf61e73a8af0-1d4fa6c2f99mr18043236637.20.1727762479311;
        Mon, 30 Sep 2024 23:01:19 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:01:18 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	atenart@kernel.org
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
Subject: [PATCH net-next 6/7] net: ip: make ip_mc_validate_source() return drop reason
Date: Tue,  1 Oct 2024 14:00:04 +0800
Message-Id: <20241001060005.418231-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001060005.418231-1-dongml2@chinatelecom.cn>
References: <20241001060005.418231-1-dongml2@chinatelecom.cn>
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

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h |  7 ++++---
 net/ipv4/route.c    | 33 ++++++++++++++++++---------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index cb9f31080517..cd0f585dacf0 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -198,9 +198,10 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	fl4->fl4_gre_key = gre_key;
 	return ip_route_output_key(net, fl4);
 }
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag);
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      u8 tos, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 dst, __be32 src,
 			 u8 tos, struct net_device *devin,
 			 enum skb_drop_reason *reason);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f577012985c5..89f97637af20 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1665,34 +1665,37 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag)
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      u8 tos, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag)
 {
 	int err;
 
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
 		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
 					  in_dev, itag);
 		if (err < 0)
-			return -EINVAL;
+			return -err;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* called in rcu_read_lock() section */
@@ -1702,13 +1705,13 @@ ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
+	enum skb_drop_reason reason;
 	struct rtable *rth;
 	u32 itag = 0;
-	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
-	if (err)
-		return SKB_DROP_REASON_NOT_SPECIFIED;
+	reason = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
+	if (reason)
+		return reason;
 
 	if (our)
 		flags |= RTCF_LOCAL;
-- 
2.39.5


