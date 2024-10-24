Return-Path: <bpf+bounces-43031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C2B9AE0EA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6862A1F214C3
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC41C07ED;
	Thu, 24 Oct 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM/nkeLR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531B1BD028;
	Thu, 24 Oct 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762495; cv=none; b=NH9m+eEXxHsV+VEJDPzjwAM0T6+RTqpYMo0szceTt5h5F3r8MKDFPGI4bGIWL1SoJrIruAUJslG3r6WOC/ai0iz1Rl75kZH7mD/uHDHf/Zc30DuRmrlhP/INFD1fXNavpuBWXo9A0Z38RvvMRTDSKnG0GCzxCjbBJlgrumHICmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762495; c=relaxed/simple;
	bh=cCy/lda6L2Cz0Ny93zsNxAuokNc2e7IJ437qVAXid0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csGTOXZKNxTncclATnqNWT1knFjP3F5xZuzkEtu5hiEaHP5fHC5/B1YMybCpr8e6MbDo2wADQYVmVw/a5Ye6vtqwZDkyjw3w7nvFxrkJsdUrxsKx5mMJI1viZWZwA0T09crP2qzCnKiBTwoHLRENYrJqY+Nxr03+xdZDmiDfq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM/nkeLR; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-288661760d3so425498fac.3;
        Thu, 24 Oct 2024 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762492; x=1730367292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znmG4LU+dkvIoogMrj5tdOh7xv17KQWidIX+N22GnQg=;
        b=iM/nkeLR8yM/D8hNy1kjQSKkymYfsBr5p1nBZSWEqGZ49KEFmUX0p7B8w3OQ5tHhSe
         AUFHQ/Tk/CYvo4wMolwGbhqPc0xAOaB2zfGRmkemAxFygWULExxfDS1xOj5gLBOR+7du
         hOn2TJDO9ajc9qrl4Q/+yQBoRZ/duhlSJKnS9mv1WXepdApAkrcYX0Dp/yHuJ06FLZW7
         1aKjwMv+FtVvW4xL/JTHEfLkxBybMpi+mLuVtaLMtMezZQcs01ov/PQNEioucLP7XmCC
         W55iV7oGyx1PzB7+RxTddKwfkJXuTeLvLzg1EchtVOLfIc/6ERY7Fbzp4FmtfSUhK+/R
         GpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762492; x=1730367292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znmG4LU+dkvIoogMrj5tdOh7xv17KQWidIX+N22GnQg=;
        b=HUQKX/VOU/cR17W2p4i3RhTlrMJtP94qd4lCzdIwNRS65tTQEYGJOzwL7SHlgLs6+4
         pS5nLG4/UKkRznQZGwKM0KnF57/zfeyCKKSHhasQzOF3PYP3fRFX4dRsO9NWKHfFJ6hA
         7AEwbuC6ZcLLrWlNDCShLW1sesDQg2VAZ8U5BSAXlOFQ8yZezeyqHi2x2f+BZSR8Rfov
         vxnwVUCv/PpBurnufXLYXEinJ/eoyKUJFmI+G4bngEqTQTyN1OCjX6Z24mHgR07WdX9I
         drOX2EuSJpILhsSJ5e7Iy63SRI7Jg1skdmbP79y194YERWRDNbOZQSdqiC2Gicw2mqIW
         w+/A==
X-Forwarded-Encrypted: i=1; AJvYcCV+2Vh4Xs2SI0JyKzs+0Q/VB8pfOQYpp7vQQR1hWeRn71myzB/+nTaP1q2sVuDldI9m3K7vxSi8+eTvdA2+YAE5@vger.kernel.org, AJvYcCWXCtukQd3/x58hq7iMJW7ixuAHRT6SIrxputyJLmNu3Oq5zXnV9gE184+sgAsP30er9aI=@vger.kernel.org, AJvYcCXP0ByXrLJVd3IsIRTZemJ6ao7/5hlYZj63ZlMFh4+ThQi0zX20BAqiQs8PzhGrpdzVtIIhgvC7eZcSAzDj@vger.kernel.org, AJvYcCXQfi3EbPYU0a66+zU8Vd0eKP+ZUv69jJo80ogu1ZuAPllmSPc53jLmgxnwIvkiXdr5o8S9TXwP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywywk2pamkegiErsGvMwb77pLCanEgYpc3NSsHvtHlUzMlMmhvC
	cWffuvys04SudBtqXI9HIGwMlvxVNEKjFH3ePYJUlMGHmH+DugFE
X-Google-Smtp-Source: AGHT+IHlP78/7AG+7AUKWTVBYlw/SMFQGR68T7fk+J3NIh7b170uLsi52Y+9MJB2QEu/FZGvx+zaeA==
X-Received: by 2002:a05:6870:1f0a:b0:287:886:2e62 with SMTP id 586e51a60fabf-28ced26f849mr1367558fac.12.1729762491885;
        Thu, 24 Oct 2024 02:34:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:34:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/9] net: ip: make ip_route_input_mc() return drop reason
Date: Thu, 24 Oct 2024 17:33:41 +0800
Message-Id: <20241024093348.353245-3-dongml2@chinatelecom.cn>
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

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3e7a3e947b7d..e579fe5bd3d3 100644
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


