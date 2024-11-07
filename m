Return-Path: <bpf+bounces-44232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA38F9C0698
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE901F241D5
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145BF213147;
	Thu,  7 Nov 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGXnH+tt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26007212F12;
	Thu,  7 Nov 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984217; cv=none; b=udeYZ2JptMlvtHG/weDr63qKUdv9py4gNYjrW6Dw4lftChx6Nr5T4BgGpvd7Q6qSs5Hekk6Yd3XM4zY8v1FbAcz87zF/NyUs6c7jfqMoTk+YmhusQOpOFCerUkSVmbZzQ+8meOqOiPlv4ktMv63KmXTV2+xzZdxv/+ThsJMthbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984217; c=relaxed/simple;
	bh=jalKiGNYxieOdmuauWZ46l1HYvkQABXljddM93EYgn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suHInQ6JVf6l/m3XwO4mwlZwsqoiB4ANthyWs3ZlGxZ9KfwglFy8bI+E4jQCA8Qr0mE+RrQbLtC8XGbzs++0yvOO51i8ZDMD3e3DjHkxeRZ5VlfACb8mpBUBJWpx8NDaq8mdImCDgaEoTXESaov4jmS8HShWeFVZfriIxgK050U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGXnH+tt; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so726802b3a.1;
        Thu, 07 Nov 2024 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984215; x=1731589015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=IGXnH+tt3Aj/SvVzzm8esRRUDdLI5bQFbE0HCe78m3AJhwAI8HUqH0JVrb4O2H20PF
         StMTwCxlqPnX2rEWApYnxvu4TtPMjEgR3656s4R7wVZxlj+BmdY9m7uUFSWurEvwgk6h
         AqaFQEcgvQv5LVNDuivTZaOJ51NNm9l/VnxHNpdmzqhFYpmAVmMyYS7jV/j66E67UGAb
         36aO0B6KkCOcqAqKukP70Bw+qCO0VUVXgi7w2SUK+gNkP+hdrSa0zzfVjciy7ZoSyOCj
         2F1mSr7lJIJPxNbfbnZPBQSIS1Bh+It2jpiW2JKkIl/mDBfpWvz0J7GNAfzwz0Pb+L2G
         +Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984215; x=1731589015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=h5v4NdUPMX70+f8yezvZ5Z5FQ/1uhbI52BEYqzVdCqOy6aGOpXHsXr7Wtw+9Qkd+Z/
         WpNOleMEYsBcluai2n2hf5jrrpS1RCTRxg2Y0B9D7t05unLNLC+AUmGUsBACqcol3bRA
         n0Vx15FjIHcunmSfWlOUrA8EpUNwv+6XT7y+2sgG7aVnTG6Fh8PSr40wx3fm80TVYiGe
         lcFj1VGP+1iWryrqIyLgSGz6TgnV+iqncsTT7wVbWVeqV/LgAEjbwwtHVyjr8Nmx+t3A
         yXb8sQzwI3/8hdLSxfEWxp2Gr+Nchpbvmr6s3cSLq6XQJ0+5ZwF44Eje8WnVqXpx3qeZ
         +vWA==
X-Forwarded-Encrypted: i=1; AJvYcCUCVdeJN4HFQCTPLH5DeCdyIBJHtT53+AhcGtKqQIJ71ouKE6aXApH0MbR4BR5j2tQlu/0=@vger.kernel.org, AJvYcCVviQLDSOgD4en7JqL5kkht4YjRd0dwdqe3Qv/oPtVbRNMcF/0BZ/Bkb4M1R21SHgGwnDQCvWxX@vger.kernel.org, AJvYcCW4p/9HZm/VXmad70kfjBiSoAgjG/SWZotqlf5FZiui6xeKzaE+xi78Qrz2crNp8TWzMP462HhwFQGqTbJFi3pb@vger.kernel.org, AJvYcCWjOgS0LO7OZamSbKer3Fyjxxp1abI+uB4PW/KIEXT2TRhPqmQnShV5vDyAR+jeKi1E+f6ZCWqzmxY8NaDt@vger.kernel.org
X-Gm-Message-State: AOJu0YzXeQGL8oj7V6YzT+kl7JVt/dtLDRO9qB2cYhp/oNVtGZj09Yqr
	NQ0UkBPGiwYlB95NM4C/SwVpQzKvQPxMt6LMZiO78tINACap2s5K
X-Google-Smtp-Source: AGHT+IHeCdO4Mk8XM+g3M+PuhA6QC1V3CjuvQ5OxvLfarz4l+oMySgbRHgUpRjZFu1qRaDeoTU2ZdQ==
X-Received: by 2002:a05:6a00:2305:b0:71e:7046:c0f8 with SMTP id d2e1a72fcca58-72063095e6emr51487563b3a.26.1730984215331;
        Thu, 07 Nov 2024 04:56:55 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:56:54 -0800 (PST)
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
Subject: [PATCH net-next v5 2/9] net: ip: make ip_route_input_mc() return drop reason
Date: Thu,  7 Nov 2024 20:55:54 +0800
Message-Id: <20241107125601.1076814-3-dongml2@chinatelecom.cn>
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


