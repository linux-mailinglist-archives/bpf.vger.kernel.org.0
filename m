Return-Path: <bpf+bounces-42034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D645599EEE5
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9041F24BB7
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871971E8857;
	Tue, 15 Oct 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3OQt+r7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E01EF092;
	Tue, 15 Oct 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001336; cv=none; b=usYBJBqDfkdkAv1AQ+bY8qrrqpuEPMeIR1vItC+Jm2m1s2fXP6mJ2w/PnkjDbxQ9EgEqkDZTNuP7r9/c2ftzesATSf6wQxFsX8O388hT5lF19qkLVsRfgb3SKQWoMgokk2hjp1bQSHnfUkqN5dvG2VmSzsv6EPoJzI5sNzRkUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001336; c=relaxed/simple;
	bh=lZdovlYfC6CbOD44SDy1x+Dvebj19MuTrfjxQ1Wc7DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD7xOgzE7Pv5DlVSHE9fcLHfksmzoRRuHH41YZq664fj7ZQRL048wpSDazmOf7Ln4ftQ+K0YrxIunoi+zHrjxOTesoQIo3RVY3p/49AQRiUJOcydFjpS7BVdA6W75n1ApBwr9ubolWwTGXnqj6dv+zXOd5zKl9YfiCX/dPe01Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3OQt+r7; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20caccadbeeso40415475ad.2;
        Tue, 15 Oct 2024 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001334; x=1729606134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOE1KEGRuQOpIUWAn8WtgPiDE4IJ9ftyaosDtmgCxs0=;
        b=Q3OQt+r7c5LwqF6yjzYchbCCqD72KLPvkAAX2cppde/mcb0H74AJcLTNHfa3PR4zR7
         M4n2dtEXNCQoEnD/VF2Zf2cBy8Jd8G8EigC2IMpVl8mAsp3uG0fc4zV284knWsjJrWGH
         B9CFOKNjPQQtyOMjllcwOrBJ7U8vnK8xA5KcgOzkP8OAasEvZ8ejnjC0gvwQEF9a/IEB
         IkIsJRhLKnVrXlT43XVE0EYd+n60bg+5OoTlefabmqpbxAXzf7oYHp8lX8s0bG3o8xg8
         85lUu3J00lZkHmEJBpEnAl+51XbkctKJIX29CSzd1UvAkZ/k2wURGPjBErwb24p8lHf2
         GVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001334; x=1729606134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOE1KEGRuQOpIUWAn8WtgPiDE4IJ9ftyaosDtmgCxs0=;
        b=VLvfH0ix2FPGh1ytluxdVMGs0PfVB83ldeEvA01LdlesgH8l9CVsSpBvxz+D+VFUCj
         9YtH8Y8Fpp3J59NJ8pPXAHikXHKTqARkuvsWnzJbjFZrKOQzX5Hawb4NqNB0lVShc0Z/
         VCGqV2DgRWwBKQebBp4DlezZmjtrUQctyxmCrW70CIieefxwlrV+IbVN4Ac+/Ja/U0xs
         oVgXo58ead68QGBtBiuM6ohBxzK4n7gc/QY+KoGFo7kNHKuDL7O7k/No3OhcDRu+uFoC
         9yoHHKxhc3NDA1NE+FXlSrvTloZ/40MXfRRhrsDztW7Z1B9mpMI5yDdYADvGjSg5Ap6Q
         bctQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpmsoz+rZlSQO7Hq4pwGhJbpDEziTAuiDIWNR5I5gSAIonT9KKTxPEIKD9lEHygtU84vs=@vger.kernel.org, AJvYcCVwf/d4Hm3cUg/mQZ7D+PH8Hkvp5Z3NmJ2YbXlnEiKnkt5IepDdpJrJGfj713M7TV+NaK5o9/TRxbowqU7K8Px0@vger.kernel.org, AJvYcCWb5Nlxp2TZfC84YB0VgqkTx/V/NesZW3LLXk9ymCS6xO48uok2J8V+qSlgR3sRlL5nluw04EBgF/Q7xkfh@vger.kernel.org, AJvYcCWgdm4x1SBVV4+/4azW9OjhnU6Gs4BKSnSSfKAXePEnO7d/SHo7NXw1DdqLwHjCICh4pA57v55z@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9Hy4NKmZIn5nxC2KTpr4pzWlO2nGQBsXWg5LQNZC+XOhFxYa
	Zt5bvUpwMNAtxvz4nqAg7N9E6UEWSrF3IApYAIr+1mcfYoeiIf1V
X-Google-Smtp-Source: AGHT+IEgiCflMtLy1/C38zFztiqfgmUIReH+WTEDV3zas5tvZpSawhYMZAytpJvBcWJRH6Z+Rclfkg==
X-Received: by 2002:a17:903:110f:b0:205:968b:31ab with SMTP id d9443c01a7336-20ca16e9c13mr213326295ad.58.1729001333801;
        Tue, 15 Oct 2024 07:08:53 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:53 -0700 (PDT)
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
Subject: [PATCH net-next v3 06/10] net: ip: make ip_route_input_rcu() return drop reasons
Date: Tue, 15 Oct 2024 22:07:56 +0800
Message-Id: <20241015140800.159466-7-dongml2@chinatelecom.cn>
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
index 33bf83bcccdb..8ac298d69c8c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2434,9 +2434,10 @@ out:	return reason;
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
@@ -2479,23 +2480,23 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			reason = ip_route_input_mc(skb, daddr, saddr, dscp,
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
 
@@ -3308,6 +3309,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		err = ip_route_input_rcu(skb, dst, src,
 					 inet_dsfield_to_dscp(rtm->rtm_tos),
 					 dev, &res);
+		err = err ? -EINVAL : 0;
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.5


