Return-Path: <bpf+bounces-43470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BA99B5955
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52596B221F1
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D71194C9D;
	Wed, 30 Oct 2024 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWstQQNC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C01946DA;
	Wed, 30 Oct 2024 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252589; cv=none; b=MmY1F7aNYb/I5BJE/oCebfPlD8wROmf/x6oO4PCCHnFGz8Yy79j2YfL2MOYvvVM4cErLFTr8CfsyDiFJ9HyIeQbHPekMDKgF847a2c8vG2rCKY2D4Uc4s8qhpxRki+htrt55oL/JCRLECWcx6QMdATlL5+2Vl8iEZ9RIOJEirYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252589; c=relaxed/simple;
	bh=jalKiGNYxieOdmuauWZ46l1HYvkQABXljddM93EYgn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scffEXbfNdnF22npUwsRL9Q9clR2JzYEf03unOw/U2FZwMc+nEWy5ocLw8oUB8S8ecIo1ccU70xvF/5SBUazNzhb804MqlzMV1825jJvACLiNxOuXp9VXvdeojbf2wmhZTuzgjqqMs5SIfBsJFKoCJuj25zhXqTkZVrK3qqjY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWstQQNC; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-27beb2496f4so2157014fac.1;
        Tue, 29 Oct 2024 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252587; x=1730857387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=lWstQQNCFg5Yc+SH+fKKaQmr86FDtU7GJYjBW9xtR14tQabEiz6hR7fjNOnNcLlV+x
         KmHMckct7IG95PiLlbvRajNw+jnt1vCBFT8l6cNgPkfMjtRcrjQSTFqEZP/mXqPBvt1K
         6BTy1H+uEqp4Ff1/l+lAVEe+aRpUSIhwtOLDKercCjJTC6jyuVrfsiZQSxduCOygVFol
         Rscwi0KaIj6yL7dKJx7KVZZYN8Muoh131Ng85Dy/LDQGUGw5fnFo5KjQOGKDswHihknC
         j4y/Wf8E1AAwc6Ass/8KiTTWDccvlig6Qy9rt2JKmY7dKKvBEx0+xcP79zm/gxnXqW0U
         EbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252587; x=1730857387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=MU6X/fBl9qKPgnwwlQGYHU8c4P3pBDVKTjOkgZ7oY2QMep03Ind1AmVTYIdiId6k2r
         lSg1/UQLA8LPZOM0WkJoJVJyhcJewbKEbkfzmRaT13L1M/GDe65zURgxP5D1hCozqSnJ
         Rrs0/VyeUFCq0V1W2NKrzIpEvOVCNvPPpHH/qEyGsdaMRqVUpDDo9OgGhJsHd0FtAvrU
         m0oLvckPH0hMfFXD+VXV5yef9fEiqGEPDiguQNNVA582Tsb1Oofusmd2zKn7+rOwUmvI
         tI1BIJEIXn8HxNK2Lx91MyB53jYTUO+1DOZbhWwb1Wocx6cm2CDLGlf+Rto/WM0/Sh0Y
         f4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUReyO7V65qZTUQDfuI+hr1kg91fXYdiLk9okg8AlJ8RHITs+q0TRp+q1a1gtqvI7jEv9pCYNRE8E682fVH8TEn@vger.kernel.org, AJvYcCVlQszUs2ohNBBT4ZHZQ2S6AN5WYCYUx9E/RgR3oBkc+r9XS9stbfev3F+GVDv7oLSmP+U=@vger.kernel.org, AJvYcCWkFd48DwlcL8n69UitqhKDAgJjlmCondIR5pFnovZBaeyycX4ik5w26F1WrWcnyscGiSGEzaPkuJ1uVZfB@vger.kernel.org, AJvYcCXxeURpKFjmQ0FJiKxMvVe6nCfNG3RBcmizgUA5i0ITJmK/uSI6GgFG9oZprPiF7CWpUmDujf5c@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8S/hT9+RGa4Vynx5b1TeidpWWmqzZOqUMycFofY4jqrGx54ok
	0m60VGs9T+wtdrVxO301zTbWfffpI0NyH/b29fyxnFs12zkWuDKM
X-Google-Smtp-Source: AGHT+IH8gM6H0784jdmZBrZyrQbLM9r7PuEpBa67ybDtGWd3l7ClBj6fVFjmhgiCBl1je3xf2Fcysg==
X-Received: by 2002:a05:6870:4191:b0:277:fdce:6759 with SMTP id 586e51a60fabf-29051d49f6emr12807010fac.31.1730252586843;
        Tue, 29 Oct 2024 18:43:06 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:06 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 2/9] net: ip: make ip_route_input_mc() return drop reason
Date: Wed, 30 Oct 2024 09:41:38 +0800
Message-Id: <20241030014145.1409628-3-dongml2@chinatelecom.cn>
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

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f64c0221c221..ccbaf6207299 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1696,8 +1696,9 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 }
 
 /* called in rcu_read_lock() section */
-static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			     dscp_t dscp, struct net_device *dev, int our)
+static enum skb_drop_reason
+ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev, int our)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
@@ -1708,7 +1709,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	err = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
 				    &itag);
 	if (err)
-		return err;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (our)
 		flags |= RTCF_LOCAL;
@@ -1719,7 +1720,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	rth = rt_dst_alloc(dev_net(dev)->loopback_dev, flags, RTN_MULTICAST,
 			   false);
 	if (!rth)
-		return -ENOBUFS;
+		return SKB_DROP_REASON_NOMEM;
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	rth->dst.tclassid = itag;
@@ -1735,7 +1736,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, &rth->dst);
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 
@@ -2433,12 +2434,12 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
 
@@ -2459,10 +2460,10 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     IN_DEV_MFORWARD(in_dev))
 #endif
 		   ) {
-			err = ip_route_input_mc(skb, daddr, saddr, dscp, dev,
-						our);
+			reason = ip_route_input_mc(skb, daddr, saddr, dscp,
+						   dev, our);
 		}
-		return err;
+		return reason ? -EINVAL : 0;
 	}
 
 	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
-- 
2.39.5


