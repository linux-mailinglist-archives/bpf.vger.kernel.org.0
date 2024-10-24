Return-Path: <bpf+bounces-43037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4C19AE10E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC38B21B06
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB44B1D63C7;
	Thu, 24 Oct 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP9IslTA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006D1C07C3;
	Thu, 24 Oct 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762530; cv=none; b=KG6lTxnSyNU7ODvV2jEXxBVxtXNAdJrK23SMb+E+GY73v3gDF7OEwqvPaM0yD5Ttz9IHbrG+2fAjW9QcT1rIRH+N2pYSZ10A9ZN6heVGJeswf7RohsyP8vK2zlkp2gR/nAh3dWPztiVXef66NeS77lGaFCYgX/Dv0kqUntoxBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762530; c=relaxed/simple;
	bh=hEGV0orOzX8fGmrpn/mSJk8E7gQJlPcmRUdkkpTUsTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qm4KMm+/0a2ruV0bR8+zcqQs0vZK+oBXPhNxQKMZ0ocIgmUqY3rupQJ0uc1+g83E1hykwafzwsCvPTvSVIQdh/41hYN/iQrUXgS3kjoHPFuaQAHtSFGEKN9gzXkFYzZJ+nLUCo+FTih5fDrpEIeqgm71vKFOTGgOu8tKDOnZPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP9IslTA; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e52582d0bso501572b3a.3;
        Thu, 24 Oct 2024 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762525; x=1730367325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjiOcvjWN3rfOnxH2qS/gj/uoa+l778sjVnoaX+Yeyw=;
        b=BP9IslTAqgrP1bpVLJCXH6thL4jnxZPTE4eMmwHB/dVEUPKPmALChxvkybl/sODnLD
         TyUrfh4ydZbSMRjy6r817yPXZhJRvOYbsTJQfD60zP2eFKb7HSSY05LfbgRBesiqZE9s
         eG2fc8AdFFCodmn3zWV/2HSwrkikGE5yxmUcKzOFHP/RLv0+LPn3ynKeMndg+IZb88mu
         6nq7cFqmRRyswJxf7xL2pnhJ83FoaEc5ZIhgzyHB92xMDhylKuQ6oFuEMSh8uqTOpXWY
         ZE8Yh6++3u0lIozhNbpWUyJ0LczqbH4S98hi8XdlEYpYB101zCrF+cRLti3LyFXRXkce
         cgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762525; x=1730367325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjiOcvjWN3rfOnxH2qS/gj/uoa+l778sjVnoaX+Yeyw=;
        b=CrfZqH2yK2+IiQsx6EO6T6RHczf/oIPbdBPz9HhcdqVdbeW7jQkW7o5kbFT6SxXr/r
         Dus0YvTGSJ9joAfUi/gtS7gxoPhxtJ5pN2a8twtbX4je/22e/OqjJBUt1vcLPIEjXHSU
         fZfRC5/LSvLzwghFESzut5vr7af8AGFwCEE/Lj1TJLp266hTPU1FIlkhUl3bZ43CEI4E
         iSUjvM0ZNyB0x8RAlNA4DpEd0G25ItdfSlrvFPza6UotpQJoTa9whOFvxSRPNrgzhCe5
         Pvm3eZeJETwC5omp62eMejUHb+U2v1asyFJymKGG0j9kbIeXNDvAUZEV4UPoJ04nU7/O
         lejg==
X-Forwarded-Encrypted: i=1; AJvYcCUKyBUiBVHxBh2n8fWQv3nfhK7oQT7hi35zRNsfF9d/46OaLrXHcZYRbaQ+TUbTeusOxpdEOS77iKAAJHdmSM7N@vger.kernel.org, AJvYcCUnN0JngpwswTJX4hYKCmiYGpI3VL1w9D3KLeCNsI61hd9caiOn+DhJ9gmHKjuN2t6mGic=@vger.kernel.org, AJvYcCVtNA3fHE6kgO0lgV5VQVSJJj8vjTEfKCpueqEhnoQvM0258ks2lBlFE4/cgaZvsfKEShCBtga+NznIpyiq@vger.kernel.org, AJvYcCWHct96D4iVaRix0QjxZg36Ft+rck5LeDLGm7oOrTgsWsAsa2XCS+0KJhqt8d+m7UQ4Q/uGpgsN@vger.kernel.org
X-Gm-Message-State: AOJu0YykJJBdBoVPrHZA6p8U7N89ISjNo4oKgHUoFshePpg8cEnV5hNQ
	/qpCvjllaVrU5GLYEdsRJteljATT/vGSNVcN5u2ldN53ISZNnkbj
X-Google-Smtp-Source: AGHT+IFN5Ipw66nqfwr0BFzwrNhHZ1wx9abARssLV7ZYEHowb7n28tDKYtncRE2WZmFRVkX9pjzV7Q==
X-Received: by 2002:a05:6a00:b89:b0:71e:452:13dc with SMTP id d2e1a72fcca58-72030bcce48mr7521175b3a.13.1729762525269;
        Thu, 24 Oct 2024 02:35:25 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 8/9] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
Date: Thu, 24 Oct 2024 17:33:47 +0800
Message-Id: <20241024093348.353245-9-dongml2@chinatelecom.cn>
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
index 757526e450fd..d47d7ae9fc61 100644
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
 
 	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
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
 
 out:
 	return reason;
-- 
2.39.5


