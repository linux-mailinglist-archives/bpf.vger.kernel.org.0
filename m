Return-Path: <bpf+bounces-40647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F093A98B40D
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50BB283A8D
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6BA1BDA99;
	Tue,  1 Oct 2024 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj3UDKep"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66621BC07D;
	Tue,  1 Oct 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762476; cv=none; b=iOVBROONVc0D106R/Swr4Avf2D0HEg8aOoWq+fZjs/cmuxhl6BBYDn3z+H63axnkx2eArrfy953cPX04RvCKCmkAINvLwwvczEwNtDNcpsKGXSwIIPO6U5NY8MmzQTuckjd6NmvymI2FloFeOmTuE0H5zONI2olAlrDX93X0zH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762476; c=relaxed/simple;
	bh=tbqvRbrw1RjNz1z+80bZjGq2kW1Hepr/9XwWvg0Kr38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSMvaSt9+ZGmTnKN2I6/uT2V63t4eIZ8HL7Ew+YtpH+VxES3pgLgmkc4GBoPUU7gS02JcIj19gIur7AaMzFma3BCkKx4wwRduZaV9D2DIBzKp95qreKfzElnYAXVW/Lf9w7OFF7UUpULCyMZBzyWd/OgXkTVEGWI9MXR+IM5HIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj3UDKep; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so4380252a91.3;
        Mon, 30 Sep 2024 23:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762473; x=1728367273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxfX5kMCBU6PnxHPyQyfr0yY+I8adUvz9J1OqvvM57k=;
        b=gj3UDKepf0XJtzIhxOV/ERLsTnhBzccpJ77zhqppBJ3rmr9LmSXlC8N4MAAlsP/gM/
         zz14079dFpQLAF9LB3e0R6yUMcLHNh1ClL3M+YobNifELlQObxWptoumnz44MWb9D2vz
         eWFZwW3hgHmmu8UQSAtLmtZA1ccVvvjzHz0RW5mfupRv2pBjV4OONtFNXISeEIUTZA3G
         uMpdfEcS/wNTdp/SSKe9bumu/ZQC5XI++UPzZXgHQMVBzA2dMM+DYlyPKN4Ty7XR4KeX
         /UjosGGHYGbSGs7SMVtFgaUcygBNqw3j/UIZlG0h5UDjyh6tX0mmcBP6DT2xmqJ0WTLr
         kHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762473; x=1728367273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxfX5kMCBU6PnxHPyQyfr0yY+I8adUvz9J1OqvvM57k=;
        b=ZPbZ+vDzPZB3SskQ0JtzTKTx8X1xdXk22x9xT8cO6uUj7yTxZhzSB/asKEcrKMBDG2
         jo6lUE3rR5a2ZSFHFQ5HdmkQ9egfEbCeLGOSFcjtj2BpyoGJ7093KOCS5sHhmFIfndgU
         zIMI87BqxJiWTPWaIPZCNTY+qK0vdlg5SxKxxWQx+PIxWB1mvMgrpHzHkeOLgPJst4LH
         gv3RZ7c5XI2pbs4if4HpgbA7RvXg3mtW6WDyd6nhDhNBylo/nXisYXDIBp/Iwf99+qTS
         +SmLhgZccstood6uQkknNDCvf8sr0yiCfInciwldtlUtW0NRtwFGDsrPGgRdL5v/jnKn
         M8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0UK+EnYGJNp5C8cPCuVoCJ7JCXBMpXS4f1BaxwgN2DbYkWQl/nRvZDkGr3hxuXZ5oItQ=@vger.kernel.org, AJvYcCWJaMe9sYd+LYh7ifpiyRz2bebZVAwXna9EGzJvnzQA5LUSsSf3DqkYThVt8QJ4hJlI3L+z3iX5@vger.kernel.org, AJvYcCXBT17QETWrhDd46H/bmT/wu7qp/dFDTvCIZHaNPRltH6zzcoLOoNyYmfERYVWpYUA2/UqHrv9HlaAmFN1U@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlx5JbIIML0yV7sRJ3+UYtGH/Y9QIO15H9PR4oZN9DNaOX9aO
	pR5SdZObZhbgAMmSOQAdh68yl+rnMN/GXE9+a+YpiSOsvlOkOO5V
X-Google-Smtp-Source: AGHT+IGm4YLpwAmi2xMA/Da5bnFPDS63PDzPodznmvqVhBrYlqTWb+5nWy49OzncasiGvQUnbck0XA==
X-Received: by 2002:a17:90b:190b:b0:2dd:66a8:8ab0 with SMTP id 98e67ed59e1d1-2e0b89e2343mr16095285a91.16.1727762473214;
        Mon, 30 Sep 2024 23:01:13 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:01:12 -0700 (PDT)
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
Subject: [PATCH net-next 5/7] net: ip: make ip_route_input_mc() return drop reason
Date: Tue,  1 Oct 2024 14:00:03 +0800
Message-Id: <20241001060005.418231-6-dongml2@chinatelecom.cn>
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

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 9de85051463b..f577012985c5 100644
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
@@ -1707,7 +1708,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	err = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
 	if (err)
-		return err;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (our)
 		flags |= RTCF_LOCAL;
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


