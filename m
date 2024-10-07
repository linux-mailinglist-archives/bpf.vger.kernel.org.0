Return-Path: <bpf+bounces-41092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C93999264D
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB6B1C22444
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC118C331;
	Mon,  7 Oct 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nut1PKQe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486118C00D;
	Mon,  7 Oct 2024 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287273; cv=none; b=pKO/TsiTXhw/8SxJlgf7UswIZ0sg1VgJl9lbZ5urI0+bQkODxGVN9Tca6t0K+/sGsFN3lUplK3wohWMnMDgpj20WDx2q4qsoWXuWJXd4esTG3pvNjcO14cPv8KSsfnU44C/7aNmP3EDFsfPa7MOo7d9E576OPShAn8+blRcecIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287273; c=relaxed/simple;
	bh=sxNsyzxLuCMZK6+D+DlL45J8fo/1coelPi2WFJqDz4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzUF3N4cmq0Oi7t2l/6Hp6CgVwVOShxnxmuevkVKcoxhhpGg6UBYSuiyCZo5Ce/9+x1v0wQYCM3nyWcYaHnep9JwqlEBiUA8nYYX0pUB4nBCGP6Zmw3ACOFY3Otapck20kdTKvg0d0LSXS0Mo4oJ9yBVhCIt6ZSgn3kIXHcG56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nut1PKQe; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b7a4336easo29382925ad.3;
        Mon, 07 Oct 2024 00:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287271; x=1728892071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQaiVJWmvcIfsn12maTEx9RMWPk2LP/M/KAqPR16eM4=;
        b=Nut1PKQeGkzQ9L/0Ev5ICSq9/46odUXvgLz6kdf9UnKcmdEvE61M+zcUB1tIx8azxV
         4e+jwqEqNZt9ZLesh3jL368/jD+ewLs1uIS44BTXSbyyDK5uuHleIPAz/ysAhTJIBPub
         U11N3bNu3d7ob75DhAKFGousqNN0sAztnF3Ck83fZQRoMwZNC57xEWWEs9JFrdU6KnD8
         F0uFh028oQLVEe7bMjQQ4TlB5BpjlGkgQNHaT0D5b7y+LUcxwxur11aNmUkGpf3sm7vK
         tUEBaEnk9lHbBeEoUoQzrwEmk1bs9AcTIJqyWQJKRrtuY+iCWzhmsZ+v/RqdfPtHdjim
         Y4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287271; x=1728892071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQaiVJWmvcIfsn12maTEx9RMWPk2LP/M/KAqPR16eM4=;
        b=KRSvykdDLWWnCBY2J3k6o8iNl/uYFtTTtETgPRlzzGMIYgHuVv0z2IoxoMzTHlVk33
         riDlixiG9+twNMRTGNKEPaBp2v+sMo9+ue357WRlfchqUSaFUst3JCPe/kvonnp8Ntsl
         HR8Dl7zU6WylsM2s1MNYHHm5ceHADOs5HAIACPJ4uyKo6ulgDkw8esrXmsbAUOdvUsVK
         cRk7Pw6YCeIer7qpH4awBMi0olI6w2HYi4LrxD1xOVmmibhsX5u5Vx8ElpWDMREARuI3
         Qqdj8NwsQLS+MNAGbILjU7BgPiPUxCxBSBOmc5B0KCyz8NTkTTzmx34Jwmdr7YcFpvZ3
         KE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB0Ti1dnh77sMd+VNSkSy2hjqlvgLAY7P/A/8vljkv19eAl74/kQiDdI+/yoZIpP988tU=@vger.kernel.org, AJvYcCVv4/lRkghQ+3P0X7HEkGPqKOLMm9Kyj6ZBsyXfucM66o5vD7yworU32SlCZQgv00b5sv7jyLVW@vger.kernel.org, AJvYcCXrvNI3czOfKi8sNM6lPktszHb+SIJUQbEwRpMF6czOaomPQgmfUg9V7woVtNVL3aPe//GQ6EGimwmsJ8+a@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcYZ4JUVx/C88x42mGYNOqYDbXqb8FupsUCqQrGsDi8mbTunq
	gkZV4xfjaWx3Fv1k5kJ2VzD2sTKjvDqpOtSJ8BPp3asL0SXH9jkNJvzMmXo0
X-Google-Smtp-Source: AGHT+IFr660uiVmoH0l70a1m4ey/6uGJ588TuModB7Z8souAdt6GbddUVdIMOh7K6QAbhw2k+NXDgw==
X-Received: by 2002:a17:902:e848:b0:205:4e15:54ce with SMTP id d9443c01a7336-20bfdfc0564mr193949975ad.20.1728287271183;
        Mon, 07 Oct 2024 00:47:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:47:50 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
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
Subject: [PATCH net-next v2 5/7] net: ip: make ip_route_input_rcu() return drop reasons
Date: Mon,  7 Oct 2024 15:47:00 +0800
Message-Id: <20241007074702.249543-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007074702.249543-1-dongml2@chinatelecom.cn>
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input_rcu() return drop reasons, which
come from ip_route_input_mc() and ip_route_input_slow().

The only caller of ip_route_input_rcu() is ip_route_input_noref(). We
adjust it by making it return -EINVAL on error and ignore the reasons that
ip_route_input_rcu() returns. In the following patch, we will make
ip_route_input_noref() returns the drop reasons.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 9b3f7bebcd86..56a1ebddde24 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2439,9 +2439,10 @@ out:	return reason;
 }
 
 /* called with rcu_read_lock held */
-static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			      dscp_t dscp, struct net_device *dev,
-			      struct fib_result *res)
+static enum skb_drop_reason
+ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		   dscp_t dscp, struct net_device *dev,
+		   struct fib_result *res)
 {
 	/* Multicast recognition logic is moved from route cache to here.
 	 * The problem was that too many Ethernet cards have broken/missing
@@ -2485,23 +2486,23 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 						   inet_dscp_to_dsfield(dscp),
 						   dev, our);
 		}
-		return reason ? -EINVAL : 0;
+		return reason;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev)
 {
+	enum skb_drop_reason reason;
 	struct fib_result res;
-	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
+	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return err;
+	return reason ? -EINVAL : 0;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
@@ -3314,6 +3315,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		err = ip_route_input_rcu(skb, dst, src,
 					 inet_dsfield_to_dscp(rtm->rtm_tos),
 					 dev, &res);
+		err = err ? -EINVAL : 0;
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.5


