Return-Path: <bpf+bounces-40646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919898B40A
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC621C22FBE
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13EB1BD514;
	Tue,  1 Oct 2024 06:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJZAkfAv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA81BC073;
	Tue,  1 Oct 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762470; cv=none; b=g0rudayrzgRy4qOQFjBwGy+rzLkLhVkkRfHZnFKZpCu8yigrqV8PcIxJW/wCNJJEHxuZmYacC441x38ifVDboBCexBHkfyuh+lJ2f0sGcaJItyHNa83V9RKbKqUCLR+1H1plOHQ01siMyw8qO+NYJIAKs0EcFBBxhAjFJILqsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762470; c=relaxed/simple;
	bh=aHFVAhSauYhcaI4Qxqi6+hVTR2IUnewnJG9ZCTMkUYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSUj/LxX3Cz7jFy2aCt1iJF1kRK26W8zp8zeHjsoR4cWlRJ9KARr/Af05s5dmjQjXf7iK6JIHY3n2ChjN8yGaFr2dWGzFctSvL1tWYug4rh0O5DZWVXy0/0qshYYfy4eW6kUIuz3pK48um+6O59VSh04GHbqWHmo28Xy2sFeKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJZAkfAv; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so4382155a91.2;
        Mon, 30 Sep 2024 23:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762468; x=1728367268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYpoCxYLAImw/g0O6S5ba1T5oz021gTBCQ/UN1xsnUk=;
        b=XJZAkfAvtwi7djN1wfMY29KaMSTJnGDtclqv83kDAVGT0UmF5/4g4ROOsX8lxrSiSW
         iUe8EkIzuYYMMUB8ArTbe3nB0p2JVVYCtXR1zD5U/PJMB7FhXerqppscYbm5ug4CKPbH
         eaFpt9wNW6iPAvBIKNL1JGYhP8NBImsx2BWJpHN1Kr/kEOwRDsKcpLsyXH9WTdCvB05i
         PhEWgn55yTzXUuqZa4ezzZia/Wwx5WBUBdwafbkmaTtXvM483RCn599DHPXyPiZZzPyZ
         OQJ71Xf/sSDOsXBHZ2aBxAnzl3+Lds9fytmNDm97cLo4DM2R0VCBE3EtgAHIrUVezd9/
         vaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762468; x=1728367268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYpoCxYLAImw/g0O6S5ba1T5oz021gTBCQ/UN1xsnUk=;
        b=ihOsxW7h0zeRD8GLh0BPwxSR7u+okctlv6vl8fRMxAVyTSShAEzADHKu+sQK/xhnLK
         GaAkMdVdJr9i1DU6bQHg1b/30rwMRKFw0uF1cia+4RsdTOVuLF/XfwkB9AOWc777bO9w
         csk3P1fR+d1xqCP3hTH4Mcf2lcFDIX8fmILRFwcaZ9+9/rDr+/UbaJ/uVtzeA24BYToA
         d0T0uFRXiMTaD2hy0x0aAc1gmqmvjb5rL10K35JEcPL+BpuJ+/P/K+GXsCbYv1vqRI80
         oGlwkAimWTjd/UZEN/n6wtARPaU/7e989+Z2wcE1zcMzc2ienl8vhtNUgwI1amhIX9qf
         8IpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYLcz96mchlG+16vIRnWdlHyK8YWxIsbR6juIc1dCIPkHv+6WxqFOjWgpv8PwmxZw1Wdc=@vger.kernel.org, AJvYcCVp9muAl39u6AfBBMzMQ9IdQ/5eK0KMyLhqNJErSoHCLOYmeHDgaGWru4iEWYlR10eBXTX4Kfe0PqHqrJJT@vger.kernel.org, AJvYcCXajOT156CIWkLObYkDN3I/fZ0UfnMkrs6Y0CvXV2U+kV0ZjpXz+hO4n8sJrYcLVTSYkuGvclA3@vger.kernel.org
X-Gm-Message-State: AOJu0YyOm8EGqequnfzHb05AETL3Q6umBxqUNoKUzupoBCefs1MHXEZ7
	5r+1Mvizmzl5XloHaowVWKtbXoibLuHmS52oxGxIhqEIxZ5ZwbAP0Z/b+raW
X-Google-Smtp-Source: AGHT+IHn1ToQ3k6iUZaeM1D4hzw48Kca4247nxPSj0gjkQYcCt8MkqBMWA7bFTJ50AHOQ1TZR2qTkA==
X-Received: by 2002:a17:90b:d98:b0:2d3:d063:bdb6 with SMTP id 98e67ed59e1d1-2e0b89a2d65mr16684678a91.4.1727762467954;
        Mon, 30 Sep 2024 23:01:07 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:01:07 -0700 (PDT)
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
Subject: [PATCH net-next 4/7] net: ip: make fib_validate_source() return drop reason
Date: Tue,  1 Oct 2024 14:00:02 +0800
Message-Id: <20241001060005.418231-5-dongml2@chinatelecom.cn>
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

In this commit, we make fib_validate_source/__fib_validate_source return
-reason instead of errno on error. As the return value of them can be
-errno, 0, and 1, we can't make it return enum skb_drop_reason directly.

In the origin logic, if __fib_validate_source() return -EXDEV,
LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it by
checking "reason == SKB_DROP_REASON_IP_RPFILTER".

We set the errno to -EINVAL when fib_validate_source() is called and the
validation fails, as the errno can be checked in the caller and now its
value is -reason, which can lead misunderstand.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/fib_frontend.c | 19 +++++++++++++------
 net/ipv4/ip_input.c     |  4 +---
 net/ipv4/route.c        | 17 +++++++++++++----
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 793e6781399a..779c90de3a54 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -346,6 +346,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 				 int rpf, struct in_device *idev, u32 *itag)
 {
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	struct flow_keys flkeys;
 	int ret, no_addr;
 	struct fib_result res;
@@ -377,9 +378,15 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 
 	if (fib_lookup(net, &fl4, &res, 0))
 		goto last_resort;
-	if (res.type != RTN_UNICAST &&
-	    (res.type != RTN_LOCAL || !IN_DEV_ACCEPT_LOCAL(idev)))
-		goto e_inval;
+	if (res.type != RTN_UNICAST) {
+		if (res.type != RTN_LOCAL) {
+			reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
+			goto e_inval;
+		} else if (!IN_DEV_ACCEPT_LOCAL(idev)) {
+			reason = SKB_DROP_REASON_IP_LOCAL_SOURCE;
+			goto e_inval;
+		}
+	}
 	fib_combine_itag(itag, &res);
 
 	dev_match = fib_info_nh_uses_dev(res.fi, dev);
@@ -412,9 +419,9 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return 0;
 
 e_inval:
-	return -EINVAL;
+	return -reason;
 e_rpf:
-	return -EXDEV;
+	return -SKB_DROP_REASON_IP_RPFILTER;
 }
 
 /* Ignore rp_filter for packets protected by IPsec. */
@@ -440,7 +447,7 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 		 * and the same host but different containers are not.
 		 */
 		if (inet_lookup_ifaddr_rcu(net, src))
-			return -EINVAL;
+			return -SKB_DROP_REASON_IP_LOCAL_SOURCE;
 
 ok:
 		*itag = 0;
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index dc062ae49137..aac0575bb1a4 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -424,10 +424,8 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	return NET_RX_DROP;
 
 drop_error:
-	if (err == -EXDEV) {
-		drop_reason = SKB_DROP_REASON_IP_RPFILTER;
+	if (drop_reason == SKB_DROP_REASON_IP_RPFILTER)
 		__NET_INC_STATS(net, LINUX_MIB_IPRPFILTER);
-	}
 	goto drop;
 }
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ab70917c62e5..9de85051463b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1690,7 +1690,7 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
 					  in_dev, itag);
 		if (err < 0)
-			return err;
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -1788,6 +1788,7 @@ static int __mkroute_input(struct sk_buff *skb,
 	err = fib_validate_source(skb, saddr, daddr, tos, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
+		err = -EINVAL;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -2162,8 +2163,10 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	tos &= INET_DSCP_MASK;
 	err = fib_validate_source(skb, saddr, daddr, tos, 0, dev, in_dev, &tag);
-	if (err < 0)
+	if (err < 0) {
+		err = -EINVAL;
 		goto martian_source;
+	}
 
 skip_validate_source:
 	skb_dst_copy(skb, hint);
@@ -2313,8 +2316,11 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (res->type == RTN_LOCAL) {
 		err = fib_validate_source(skb, saddr, daddr, tos,
 					  0, dev, in_dev, &itag);
-		if (err < 0)
+		if (err < 0) {
+			__reason = -err;
+			err = -EINVAL;
 			goto martian_source;
+		}
 		goto local_input;
 	}
 
@@ -2339,8 +2345,11 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (!ipv4_is_zeronet(saddr)) {
 		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
 					  in_dev, &itag);
-		if (err < 0)
+		if (err < 0) {
+			__reason = -err;
+			err = -EINVAL;
 			goto martian_source;
+		}
 	}
 	flags |= RTCF_BROADCAST;
 	res->type = RTN_BROADCAST;
-- 
2.39.5


