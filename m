Return-Path: <bpf+bounces-42037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30C99EEF5
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFA51F22484
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732C1D0B91;
	Tue, 15 Oct 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLtN+ooL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD331C4A2E;
	Tue, 15 Oct 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001357; cv=none; b=WH9AlDkEwoyDl1kRKREPUI7cA06wf7lslMEJP3Pnlce/cK0cwe9wDilzSTY8nxkOiB+Lf9bU8pl/4mhen8y3w54+AtKN43pOAfQdgn10cp82jbypfrVSWkQQkAdIJZ1dWs83W/k/qj9eRXhCONo418OeOIfJo5hHfdUzVwtu1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001357; c=relaxed/simple;
	bh=deRFnQwRg+kHlAO3InS8HPWdrPzjO/lid9s4IAPn5Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQld4WzDYVnl9wG8XifMwsg5vfgUUvY536vDkFQ98atEwj/gm9L7Ila6TQiSHGLLsl1K2lE6s8eYQO0otwOLLSuNWe6u9uAhx713NlHcQ/FyaiB1zHgOxDNGTJcKh1hc7vn6FGIOYvt/7sySWBnSbQXZrVTQIRgGRCxXQcNnw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLtN+ooL; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cbca51687so28403545ad.1;
        Tue, 15 Oct 2024 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001356; x=1729606156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb6Keu+mjnQTG+TZRKzxO8S5SFad7ATh4n914sZaJ58=;
        b=YLtN+ooLJ8lEhtCFU+/UHIX/NSqQTpyqZYkSEOcRQg6mIhH70+lECSwjAIxGKe4tgE
         CZtDTviJblM29MIUfBTCM3nh3BQOc0gJ8lcyRITDMH6UpbllpKNwOASfF9JsTlTWpqyA
         UXKzKwarjyKcUPJR47INKP6I0Ka8z9buK6Ag4O8ObsVHXQHnik5OW8Y2iIEOHuOFQEEj
         82Zzc/drISTX526FmvLvN4Ewgeh+mrVh59IepYbRLhx4y5J8wCMETw/Ibi7nP1pYRgma
         sQS0Ny3mm/Zol4/8+8MQmOFbnKTxGsXk2idMZsFz4MQigz7JTxHyeEUCgspuT3G25uZj
         YJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001356; x=1729606156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb6Keu+mjnQTG+TZRKzxO8S5SFad7ATh4n914sZaJ58=;
        b=CPKzo+xEHSdM+XvALNOHsxmCy4MVtXATr7Fw+LTsZ8P2M+USStWXPj+MIUXj1FSMLm
         Bdi9yM2JW0sj2IKEUiAlx7a53uIeNUf3rclV/8B9hWqcEMXZB77sUuEtu0pZCPwxMiUK
         mNttuLLvYFQafQueHTPG3hLW/Q6pkKvuDME/Zo3adAf/o/NDwfwz2lDAvXYdhQ2mcwgC
         7jENjxIchrItsDBNIQxo4hx1JLw7OMASZjA/S9rXtx+iIntLlVVDTWbuFoZqVInQpMld
         n4ZGGiSrSbghIvwEaY/WfeYO/Fc7EY3hmy8+sn8PTvHJlCeRM0Y02GtBxxUik4vsmVaa
         kTyw==
X-Forwarded-Encrypted: i=1; AJvYcCU0x3vaubQDKkgo5NVoaA+OhTdaSbJtHT8+PlaLdUm9SrPNuNx6cTppFjcIvU+VKzzWVrmkWz3tyFS66Lvd1k+7@vger.kernel.org, AJvYcCUfE+2/RN4PSN1GRjMy/DbcslqR0Fc9QQG7toVdO4awM9vKUWJRPQhP7GbdLeyG4tGlAEhdxQ3g@vger.kernel.org, AJvYcCW9VEuH264xVbWdE4UNIzQhCQlHFca7OcjpGhzBZAsjZHdxTYyrkZyUHpJe1TWLyMhNqwk=@vger.kernel.org, AJvYcCXsX3VwHDh71XtagadQ+ZmAGSsc6tPaMZ1i0aE3w3WX88tTLtf1BL026Khbvg5ktAy7Rdagc42o9cQCom5a@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOJ6Yueri+H6BusaLBY7EELRCGJhMZpAhsUbU/Je/e+UPOFj+
	VECDawAQKTcQnA0zyiCTwyIxMX3ALcraf2Es0HDf6GBaJl0M+Qtd
X-Google-Smtp-Source: AGHT+IGWOmfDSpyBXQ2KoMTkoFeGQU4J/bwskUqMV7x2PbaD9NjoBS5aXiZoLhs/g3mwmYmhUchSjw==
X-Received: by 2002:a17:903:22c7:b0:20c:9062:fb88 with SMTP id d9443c01a7336-20cbb1a983dmr170607795ad.1.1729001355567;
        Tue, 15 Oct 2024 07:09:15 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:09:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 09/10] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
Date: Tue, 15 Oct 2024 22:07:59 +0800
Message-Id: <20241015140800.159466-10-dongml2@chinatelecom.cn>
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

In this commit, we make ip_mkroute_input() and __mkroute_input() return
drop reasons.

The drop reason "SKB_DROP_REASON_ARP_PVLAN_DISABLE" is introduced for
the case: the packet which is not IP is forwarded to the in_dev, and
the proxy_arp_pvlan is not enabled. This name is ugly, and I have not
figure out a suitable name for this case yet :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  7 +++++++
 net/ipv4/route.c              | 35 +++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 74624d369d48..6c5a1ea209a2 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -104,6 +104,7 @@
 	FN(IP_TUNNEL_ECN)		\
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
+	FN(ARP_PVLAN_DISABLE)		\
 	FNe(MAX)
 
 /**
@@ -477,6 +478,12 @@ enum skb_drop_reason {
 	 * the MAC address of the local netdev.
 	 */
 	SKB_DROP_REASON_LOCAL_MAC,
+	/**
+	 * @SKB_DROP_REASON_ARP_PVLAN_DISABLE: packet which is not IP is
+	 * forwarded to the in_dev, and the proxy_arp_pvlan is not
+	 * enabled.
+	 */
+	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 86a964734b1d..cb6beb270265 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1769,10 +1769,12 @@ static void ip_handle_martian_source(struct net_device *dev,
 }
 
 /* called in rcu_read_lock() section */
-static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
-			   struct in_device *in_dev, __be32 daddr,
-			   __be32 saddr, dscp_t dscp)
+static enum skb_drop_reason
+__mkroute_input(struct sk_buff *skb, const struct fib_result *res,
+		struct in_device *in_dev, __be32 daddr,
+		__be32 saddr, dscp_t dscp)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct fib_nh_common *nhc = FIB_RES_NHC(*res);
 	struct net_device *dev = nhc->nhc_dev;
 	struct fib_nh_exception *fnhe;
@@ -1786,13 +1788,13 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	out_dev = __in_dev_get_rcu(dev);
 	if (!out_dev) {
 		net_crit_ratelimited("Bug in ip_route_input_slow(). Please report.\n");
-		return -EINVAL;
+		return reason;
 	}
 
 	err = __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				    in_dev->dev, in_dev, &itag);
 	if (err < 0) {
-		err = -EINVAL;
+		reason = -err;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 		 */
 		if (out_dev == in_dev &&
 		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
-			err = -EINVAL;
+			/* what do we name this situation? */
+			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;
 			goto cleanup;
 		}
 	}
@@ -1843,7 +1846,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
 			   IN_DEV_ORCONF(out_dev, NOXFRM));
 	if (!rth) {
-		err = -ENOBUFS;
+		reason = SKB_DROP_REASON_NOMEM;
 		goto cleanup;
 	}
 
@@ -1857,9 +1860,9 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	lwtunnel_set_redirect(&rth->dst);
 	skb_dst_set(skb, &rth->dst);
 out:
-	err = 0;
- cleanup:
-	return err;
+	reason = SKB_NOT_DROPPED_YET;
+cleanup:
+	return reason;
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
@@ -2117,9 +2120,10 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 }
 #endif /* CONFIG_IP_ROUTE_MULTIPATH */
 
-static int ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
-			    struct in_device *in_dev, __be32 daddr,
-			    __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
+static enum skb_drop_reason
+ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
+		 struct in_device *in_dev, __be32 daddr,
+		 __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
 {
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	if (res->fi && fib_info_num_path(res->fi) > 1) {
@@ -2333,9 +2337,8 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 make_route:
-	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-	if (!err)
-		reason = SKB_NOT_DROPPED_YET;
+	reason = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp,
+				  flkeys);
 
 out:	return reason;
 
-- 
2.39.5


