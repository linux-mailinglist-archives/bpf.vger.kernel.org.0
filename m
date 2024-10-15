Return-Path: <bpf+bounces-42029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03199EEC6
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DF9284BF9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4B1C4A1C;
	Tue, 15 Oct 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXDjEuPo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C31B21A9;
	Tue, 15 Oct 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001303; cv=none; b=sZ1Hni27MhOJfVWm2yXdxTyHkun5ChOm3KpTDeN5TMCRuD7q2Sd2+hgjFso2kTaEEBl+f4/YKXBLCwFWNLLwvJyqBrO7o1+WwbCm7pGO3GbwHoFKaLaLcI+GXRH8b7FSDJr1Ba8M+AfIhN4xI5VlUO3BtHgxeUak6/F3JNdbhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001303; c=relaxed/simple;
	bh=Q02mPHSdawuoacP3FWbSIcLy+LqtdxaSYcl7vnKHZ/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVpTaT47MwNQltQ4XtZG1fEwSOHaJ17u42fw0L+f1GuePPyoTLkVQOHXwKBKjqKEq9RehNdFe7bNm0da345v9VXLvxvdrzeJ2N3RPni8eQX7B3LqjwPiBFavkU7RHJgCggWBodT8QLcOyofoKLHQdq5urWooew8bgBXLYLMQbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXDjEuPo; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cbcd71012so29859255ad.3;
        Tue, 15 Oct 2024 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001301; x=1729606101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuHCIlXMzbgZGREkpMiEjnEhIkYiYw79l5/zuLO8F5Q=;
        b=SXDjEuPofB5miKv6kOIaoWj4sgAKcrlp6Uoey0U2QI0Lh4dFbRpiHqXUdEA1ash7Xh
         rfCdOHBS0z+bhHRPJWBhX+z1sO5sz/Qn/1Dv4xYLopo9ZAfyJjaPVosHxm70GZlyZyVE
         /Zw/Vs85SJHvEinBh0ZIY40g0nWa5Hqkupa2zRcooDaWH3AVvu1dgDS+3l4u2SzELew6
         Sf12vlVzP+Ypc0LJINY0lPyr6ev2QduH6gLCc2xKl6N97V4S+ZJcGWZwmF6AYHvVk7sN
         g2hydw5hAPK+Jx99nO8IHaHOTEInMn/UhWJC899O0x7m0dxLzz7sCBYrY25oorPEYDo7
         3XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001301; x=1729606101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuHCIlXMzbgZGREkpMiEjnEhIkYiYw79l5/zuLO8F5Q=;
        b=E3WzsK+hWVAZiNKttUSufoW6ApzY/w4h01+YMmDzF5fWkB8gJajX5kQyq4eakk6rjK
         NMPSf2XAEvB9Zj+FYuSxBv/oGnNnGCuDiSXXCH+eOQQxd4hKpPhmrpn2Q0RvFX45Kak/
         AJW7I2fc4i7r8tdRypyxjqr52mCpe6T1YmDv9+UHpaMe+Z+lf9HN8rJ6g/RzG1HMesrq
         3vzKV8H3tEuiuwvBJVyW2ioYlwots8QxFPTNsCZIV0L4bs7Qaq3N7pfJ0eNm3DDzwslU
         VI6aZBdr1Sy1qhbqGh2QDG0CSARiMT6hISIyrqtmRLtAMLU/5RWoQCiRabEPV8/cKQ8c
         0/WA==
X-Forwarded-Encrypted: i=1; AJvYcCV8NYTopcF3ZkFcf1mLgRxZ9QlQ6yVYDTLES6CDAGvJ4Zyu5+KBr42NHWhp1RAiJZ92kwfv9Ua/@vger.kernel.org, AJvYcCVoId+iGCCsDkQc27JPdzFR6CDOQbg2r61Yuk0ywz0div2scXX+6BmBSWibmAOShg8bsh48UJHNlUf9IvLdS+h9@vger.kernel.org, AJvYcCWBy9inYAnpg1+MiZMM9L1OUA4BmJjAYfofbRbgqronEH000E+Pqx1QggAZ9Om07jIUr0VULEWOOieLMVzJ@vger.kernel.org, AJvYcCXVHnwFwW9CVqOTZIeQzfGxmusHdtpgCkYY3+xZu9AjZwjwwu9mjOz/Mx1gWKgQCMXoM2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTHvMPzPK1q5QyfOVW3T47wu9YsdasiTi4vzfdMZLzHYm2duQ
	+YsDTHeU1NDjezqYCXT+SjHXo0gEbQlRuO7bElRfcS9RnSH1B9zS
X-Google-Smtp-Source: AGHT+IGbmeVE+JhrsrK3HAk9iuaIB4S9x5eE0tZ4XUwVZrEWYa3we3NvOttIji7BlAsXUq/hEJEBYg==
X-Received: by 2002:a17:902:d48e:b0:20c:ef81:db with SMTP id d9443c01a7336-20cef810287mr103721535ad.28.1729001300614;
        Tue, 15 Oct 2024 07:08:20 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 01/10] net: ip: refactor fib_validate_source/__fib_validate_source
Date: Tue, 15 Oct 2024 22:07:51 +0800
Message-Id: <20241015140800.159466-2-dongml2@chinatelecom.cn>
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

The only caller of __fib_validate_source() is fib_validate_source(), so
we can combine fib_validate_source() into __fib_validate_source(), and
make fib_validate_source() an inline call to __fib_validate_source().

This will make it easier to make fib_validate_source() return drop reasons
in the next patch.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/ip_fib.h    | 15 ++++++++--
 net/ipv4/fib_frontend.c | 64 +++++++++++++++++------------------------
 2 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b6e44f4eaa4c..90ff815f212b 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -448,9 +448,18 @@ int fib_gw_from_via(struct fib_config *cfg, struct nlattr *nla,
 		    struct netlink_ext_ack *extack);
 __be32 fib_compute_spec_dst(struct sk_buff *skb);
 bool fib_info_nh_uses_dev(struct fib_info *fi, const struct net_device *dev);
-int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-			dscp_t dscp, int oif, struct net_device *dev,
-			struct in_device *idev, u32 *itag);
+int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+			  dscp_t dscp, int oif, struct net_device *dev,
+			  struct in_device *idev, u32 *itag);
+
+static inline int
+fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+		    dscp_t dscp, int oif, struct net_device *dev,
+		    struct in_device *idev, u32 *itag)
+{
+	return __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
+				     itag);
+}
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
 static inline int fib_num_tclassid_users(struct net *net)
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8353518b110a..f74138f4d748 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -341,10 +341,11 @@ EXPORT_SYMBOL_GPL(fib_info_nh_uses_dev);
  * - check, that packet arrived from expected physical interface.
  * called with rcu_read_lock()
  */
-static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-				 dscp_t dscp, int oif, struct net_device *dev,
-				 int rpf, struct in_device *idev, u32 *itag)
+int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+			  dscp_t dscp, int oif, struct net_device *dev,
+			  struct in_device *idev, u32 *itag)
 {
+	int rpf = secpath_exists(skb) ? 0 : IN_DEV_RPFILTER(idev);
 	struct net *net = dev_net(dev);
 	struct flow_keys flkeys;
 	int ret, no_addr;
@@ -352,6 +353,28 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	struct flowi4 fl4;
 	bool dev_match;
 
+	/* Ignore rp_filter for packets protected by IPsec. */
+	if (!rpf && !fib_num_tclassid_users(net) &&
+	    (dev->ifindex != oif || !IN_DEV_TX_REDIRECTS(idev))) {
+		if (IN_DEV_ACCEPT_LOCAL(idev))
+			goto last_resort;
+		/* with custom local routes in place, checking local addresses
+		 * only will be too optimistic, with custom rules, checking
+		 * local addresses only can be too strict, e.g. due to vrf
+		 */
+		if (net->ipv4.fib_has_custom_local_routes ||
+		    fib4_has_custom_rules(net))
+			goto full_check;
+		/* Within the same container, it is regarded as a martian source,
+		 * and the same host but different containers are not.
+		 */
+		if (inet_lookup_ifaddr_rcu(net, src))
+			return -EINVAL;
+
+		goto last_resort;
+	}
+
+full_check:
 	fl4.flowi4_oif = 0;
 	fl4.flowi4_l3mdev = l3mdev_master_ifindex_rcu(dev);
 	fl4.flowi4_iif = oif ? : LOOPBACK_IFINDEX;
@@ -417,41 +440,6 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return -EXDEV;
 }
 
-/* Ignore rp_filter for packets protected by IPsec. */
-int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-			dscp_t dscp, int oif, struct net_device *dev,
-			struct in_device *idev, u32 *itag)
-{
-	int r = secpath_exists(skb) ? 0 : IN_DEV_RPFILTER(idev);
-	struct net *net = dev_net(dev);
-
-	if (!r && !fib_num_tclassid_users(net) &&
-	    (dev->ifindex != oif || !IN_DEV_TX_REDIRECTS(idev))) {
-		if (IN_DEV_ACCEPT_LOCAL(idev))
-			goto ok;
-		/* with custom local routes in place, checking local addresses
-		 * only will be too optimistic, with custom rules, checking
-		 * local addresses only can be too strict, e.g. due to vrf
-		 */
-		if (net->ipv4.fib_has_custom_local_routes ||
-		    fib4_has_custom_rules(net))
-			goto full_check;
-		/* Within the same container, it is regarded as a martian source,
-		 * and the same host but different containers are not.
-		 */
-		if (inet_lookup_ifaddr_rcu(net, src))
-			return -EINVAL;
-
-ok:
-		*itag = 0;
-		return 0;
-	}
-
-full_check:
-	return __fib_validate_source(skb, src, dst, dscp, oif, dev, r, idev,
-				     itag);
-}
-
 static inline __be32 sk_extract_addr(struct sockaddr *addr)
 {
 	return ((struct sockaddr_in *) addr)->sin_addr.s_addr;
-- 
2.39.5


