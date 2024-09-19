Return-Path: <bpf+bounces-40092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50E97C758
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54D62880E8
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF619AA43;
	Thu, 19 Sep 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIzp5wj2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA919ABB7;
	Thu, 19 Sep 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739011; cv=none; b=EvPA18H/E+8p68dgsHUbkclqZy0lJV8dPjpbMOlSEG5BaAt2ZmceV+SrftOPLaDHQmfDA3ahh81cy3GTgj6N0c2uy5VU9u735UHCc3kSXM9xNCfFI794/u3dzz/d5QisE2ai9N7uUxzugCqgDoWbAz0Vbv9PC0Gl9ip1nfv4Elc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739011; c=relaxed/simple;
	bh=ygDIUVguhvUUlD+q1fPFNHG78N/uaop98AOq8nYMtK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G395BPdvvSV42PwF2Fpbn1a95J6OlJZuPPyMZsUvGxmgt9BiCojCycTgzDnjHqK3Eg1DdKYp4QlIQh1mTazUc/1uRYtrHUxz0TOnYUTrr5Ahu7oZ9Qmszw/Vi7Rr7gRFvdEqn/q8lAqa66zLAswnxpH+FrjgqvycZjai0pw7Nz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIzp5wj2; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7db4f323b12so320050a12.1;
        Thu, 19 Sep 2024 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738984; x=1727343784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfG1gPBCDmahTiIg8wcVbKxBcbnaI0pXkmFsdr6cl6w=;
        b=CIzp5wj2rIZ08iNMT3pywa/x7xOqBXjW5Z60SjlDUnP72G0NZxnoy13TwcNTYHm502
         8QNGO0Z1mubjYvpLppwYCbDhvi6mIQoOwkYMaDnxjdzWyqVDBYGs8Rx/bD+lp2cWQ5ks
         RQu2gruYlPecjnuVu6pQx7F287hQM6MG3L+ablJclYfkVOgrRf1S/RPtOyL33+sA/FNC
         uhVWTFlGTy+iPi5j265XX9Z8GdWEuU9pvh4zpfDdfQ/pfn3KGr9E368xAnfBgW3ZHNRt
         W/zdQBrEsOweNBdTRGvNNdS1vyQb6cBwcqrnX5uSfVXWYzQbsCTShesFWtKgtpgE/SDs
         8nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738984; x=1727343784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfG1gPBCDmahTiIg8wcVbKxBcbnaI0pXkmFsdr6cl6w=;
        b=uMjqTVPFlqdLxjVSLvBhD0lehUdL+otxT5TND6ucXyTFCWOFbxRkxtHeW2PlJdmfqZ
         K187Jps0wbvJrz+EcxKCUuJSEDa7miZ7qC4963mKqxU5cvUwB57SeEomphSooEbXYStU
         eW54fwEhubPI7kwa3tFq1TwL2FBVlOGw236Lsw4qTim8/uASTmIQR2pEp0DYrKMuZtZY
         qDYV4UOF7JKYDxIK0l0wq8aEiQ5Scme7YNxAUaE3DCt0AyNDjEO1Hrd0QY0kn9d8t87H
         CNX05R3qrcRKCSa4qAaXjDpMmKVWqoZHDi8MTnvF2OsqY6zn3pfepGsk+tbYZ25+deWn
         lUzg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Kt3Fp3mBSmsr3IFQvFWhxCYcRf1wWqL8OuQ98EunlwaRvwQ/dJw5CjoZAgR30Bw0vO76ezOW@vger.kernel.org, AJvYcCUaijtRG3ARGZdwyFw+bum7FT/x6T9qg6nSC4AgE3pGJ71DbHrxvgBxlcbrUumtmrBJPAQ=@vger.kernel.org, AJvYcCVBdHPGF4RfMXTyYZrwtKxzn+jjUr9oz4U+SQvc68YVaNFxyQztz0KhpnIHCrrlPSYjlo8zPRKXIUCRzgxa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrwzi8RheW7f/+mz7HJH+58IL27iAh2hLA6SkOJvUGrZneop4j
	xqcqa4tEgX1wWcyXf19usJvAEs/uE3FqKWQa2+/jc38EigU4Dbrk
X-Google-Smtp-Source: AGHT+IHI17plJZDoTpizWv7sXaV3B9qvSJqOn6vvB4MA0FegjUiCa+dEjiNCogZ7t623yNvGNX0NVQ==
X-Received: by 2002:a05:6a20:cf8f:b0:1d2:bbd9:4646 with SMTP id adf61e73a8af0-1d2bbd946c4mr26385496637.38.1726738984551;
        Thu, 19 Sep 2024 02:43:04 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:43:04 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
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
Subject: [RFC PATCH net-next 5/7] net: ip: make ip_route_input_mc() return drop reason
Date: Thu, 19 Sep 2024 17:41:45 +0800
Message-Id: <20240919094147.328737-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919094147.328737-1-dongml2@chinatelecom.cn>
References: <20240919094147.328737-1-dongml2@chinatelecom.cn>
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
 net/ipv4/route.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 89b498bd9752..3e11a1849ac0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1696,8 +1696,9 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 }
 
 /* called in rcu_read_lock() section */
-static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			     u8 tos, struct net_device *dev, int our)
+static enum skb_drop_reason
+ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  u8 tos, struct net_device *dev, int our)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
@@ -1718,7 +1719,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	rth = rt_dst_alloc(dev_net(dev)->loopback_dev, flags, RTN_MULTICAST,
 			   false);
 	if (!rth)
-		return -ENOBUFS;
+		return SKB_DROP_REASON_NOMEM;
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	rth->dst.tclassid = itag;
@@ -1734,7 +1735,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, &rth->dst);
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 
@@ -2455,12 +2456,12 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	 * route cache entry is created eventually.
 	 */
 	if (ipv4_is_multicast(daddr)) {
+		enum skb_drop_reason __reason = SKB_DROP_REASON_NOT_SPECIFIED;
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 		int our = 0;
-		int err = -EINVAL;
 
 		if (!in_dev)
-			return err;
+			return -EINVAL;
 		our = ip_check_mc_rcu(in_dev, daddr, saddr,
 				      ip_hdr(skb)->protocol);
 
@@ -2481,10 +2482,12 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     IN_DEV_MFORWARD(in_dev))
 #endif
 		   ) {
-			err = ip_route_input_mc(skb, daddr, saddr,
-						tos, dev, our);
+			__reason = ip_route_input_mc(skb, daddr, saddr,
+						     tos, dev, our);
 		}
-		return err;
+		if (reason && __reason)
+			*reason = __reason;
+		return __reason ? -EINVAL : 0;
 	}
 
 	return ip_route_input_slow(skb, daddr, saddr, tos, dev, res, reason);
-- 
2.39.5


