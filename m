Return-Path: <bpf+bounces-42031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A999EED1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE0CB21677
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D71D5175;
	Tue, 15 Oct 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej/3UfSo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724A1D5158;
	Tue, 15 Oct 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001316; cv=none; b=LdJcXlJYw7zDzg00EdWhhwkW2DJn/35Sbg5RaR7Fr3uLbcgIv4LsZKklOZn9kem6J5weXJxLBKKPupQZYUyBG+HYDfPFX9kPWQOH6cRsO2KyAmbV2x5mBBoUL9qP+5yf9geNXDgsnz6pAYkQxmywKx+21ytCwzBaUh3Zn1ogmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001316; c=relaxed/simple;
	bh=zjlkYbbC8QBM7Wf3cdYohzkjfajX7qpT0FaW94GtYUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AyKOUn9s4v4HAmw6AFdPh5D/6I5QVZ7HNbYRdVWlkW/kYfygEc32X8aicIfH5Xkk1iVAkMU3TLjEZ5ACs4CaqXUHTkHiiujr88gKYhcyjR0yXnbYXWiQOD04aGpFGabhkLGWEtwAJ/V+ccec/IwkzVZj5P6rpuKjjhPmYVxs/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej/3UfSo; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20c7edf2872so40884835ad.1;
        Tue, 15 Oct 2024 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001314; x=1729606114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXNVpwdypQN7MhzdxvEJ3Is8WZEvjSGwXelKg8lkKU8=;
        b=ej/3UfSoL6lt0zCO15ZS3WoX20tV2zCqyGkgnq2SkhUWzhCqXgO7GqLrdzPI2b0t7e
         g/7GIdha8Z/OYaGVY+Irz3Woc8VskTG2TE6tWuHBV19C8OH3TwXeeyBbMzneboqzHqV/
         AYk2Xk+p1px0+Ddl8Mhuv3dDfF4cpFHxuiokRybnPnMiK2T+9Wl0TPWcJ62bTEBglcoo
         Yr4cAOFTdRL5Y+jM4Uhs0jzxGG87r5S67TIuLfA6HuB6ZOdxu6Wk/WTu0+o7dl2nAb+v
         TEmA/bsFtg8UAJFJTq3pMglBk8IHZOywo399KEZSTef1XqYTQwTukn5fV7lmyuRV4rmh
         FpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001314; x=1729606114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXNVpwdypQN7MhzdxvEJ3Is8WZEvjSGwXelKg8lkKU8=;
        b=Khwt7K8975PIHYmQQz9iL6pKnEdYaQ78AuNeW+8rhPSAcp3GFSVRX8GYT8Me161hbw
         26pt+f8hJ6eBoi8wdWAW11u872W6BpGa0j343Uo4Ln6RAHj54gBwDereJpNaaqcGTJKc
         0X8Cohd2YdqbDJgF5Eq6Sq6RwGJ8BvV8aJNFulXHo1uScFVHYFH5eeIE1IwVbGbrN64x
         29bcXZBVdxq5C0pFcskjjY4aCnajmFA+yAici7+UO6+9IOUNL60RVlsZ+uSDUSFxGgZO
         2XbXLXoU6KjFDJzCoxB+095gVJDW4eSrq+aBL9+tr2iW+twfC11L/D6LGYym8rDok5o+
         cpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8NIoYRi58M3hIlJrm0cuq0/iWdBIGSG6yw9xjdHCTejqEUHITmVdl6dooHzQ6YHIibgUCd2k6AbT/LAgq3xs1@vger.kernel.org, AJvYcCVdV8VTtCzuLrX1k+C4l4Kg5CI8o6AvBNcBlao3n9CcDcYyHzzNT/UNqS6F+tTO8P2m3e92ZdaV1Zv5cw+Z@vger.kernel.org, AJvYcCWCvbmOHKHaAsPMnzlqfaS+8UT8koHCm3dzEk0NGl6eD9k2yKEpVrCFAS9TaDjWTuhNQdQ=@vger.kernel.org, AJvYcCWzIz2eLkxAV9vREh31JbtmCYYTEHCvt2nv9MtXlJGLCc7rU8XQ8s49p1Wj5fzDVO2hRjeecnE1@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFwEB/geIbYKEY3Ki60YPJUNg3dpSHTMQ4bKDBi/9ezdEzFG4
	n9ewHyTPIpoBhJE+70MS2SeiEg871kw1RloRRYEqPJZZm4SXK+6FXvMINiIW
X-Google-Smtp-Source: AGHT+IGRXJjST0HTxQYk+VFHEHpjAD+R//v1UjrCQMEfF2mjki+N/bHGaWK/rOjw6+eX9IGlKmdSOQ==
X-Received: by 2002:a17:902:f647:b0:205:8b84:d5e8 with SMTP id d9443c01a7336-20ca03a6a5cmr217260785ad.18.1729001314209;
        Tue, 15 Oct 2024 07:08:34 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:33 -0700 (PDT)
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
Subject: [PATCH net-next v3 03/10] net: ip: make ip_route_input_mc() return drop reason
Date: Tue, 15 Oct 2024 22:07:53 +0800
Message-Id: <20241015140800.159466-4-dongml2@chinatelecom.cn>
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

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index df5401efbf56..7f989e8eff30 100644
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


