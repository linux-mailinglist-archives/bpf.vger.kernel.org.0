Return-Path: <bpf+bounces-40644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF998B402
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDCE1F23F22
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015CA1BCA00;
	Tue,  1 Oct 2024 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW/d9oLN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE581BC9E9;
	Tue,  1 Oct 2024 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762458; cv=none; b=AmZjz0RoEt+2aw6n5+YhQjq7Lg2rMZ3jB+Vcu/JIvq4DF8d5/xISGwAl+IIRLdw0Ck4cgiU3lyzup46rBGdh62FP8S3lxn28bIpRBtLD4Q6oYbAJsrNoGeJK7F9vCNmWP1pXhulepqaUhnDuds2Jl+V+GXSmJzsjiBkkaGWl2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762458; c=relaxed/simple;
	bh=zvB8Xh9fDLbp9WfQKRxYAZgiU3vdvZ9bHwKeXqUqhC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SB/wDaPYd8lVnbCNyst8uBqjxajgLger55+PRVCRXWEWmOAon6/eHSPfLsD8WXdIgfpnE9QuP9LZW8xRjR8lgxxIudQGkapWnvOHIWK+OEYEjmuOaJMRB+jVFetEnsT3j4H4aPJrWNWgF19aYWoP4Jq2dKEl5E69poGVmI3cpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW/d9oLN; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e09fe0a878so3411644a91.1;
        Mon, 30 Sep 2024 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762456; x=1728367256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrcolmE9x3EsGlnudoge00ElKatztC69V36dDAFu6ds=;
        b=eW/d9oLNU0JOS7DQPFGP4DdrjC6jmvmXkG6RUR7ZeY0fKhZVTHMXM+N6Kv0AKTiNsU
         nBobuBHdnjdPR5omyHMP5jtrxLNUwNmn+vlWHZ1ZraqpE7A5j3SG8cY10rLLbgSpCCyK
         U6OxQPdvR9Ds/NX8xWtQYIxmbfIqy0X3R9s5oHffXEqj+vtGoXEfws6QWUa1/Qd0z2LE
         RHBsyZExJQphCSpEZPZgJS5U0NYAATtHbteQJw5f70r0uSpfdw22vZ11a7Ogas4kryh0
         3YE3d+EHWzQr0TzAI/dHaZRuoXluJdARE+SXcwlgKAt0/wsFjpeswwwjwNn/xGSbLM7i
         7G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762456; x=1728367256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrcolmE9x3EsGlnudoge00ElKatztC69V36dDAFu6ds=;
        b=Njygoo+FW2yPGfnXC/9RhlVODR8j+jfsyx0lI+zJhKxuZ+fMPJSsBA7gnXBtz+Z1Z7
         mbXE4NB7chcFp6dkaxwMcd2uvvsxP+C7TS70o+/+NkxLwCd04pC9Gpzvpv3cwbafSte/
         /AGe8p/6BaTZmjnND3U1VDi+sSWB9UvI+YJsKJcXV45hX1Y6VKWAtjdzAA8QDzNWIjOy
         4Dl1DAmwuEf+DMjiU7q9Z6Ev7nLijeS2dErmjr+NVyLtCT+oJzWvDb3Z06DPBUxkn/cg
         e22YEUujT3U97uAUKHiXy153Bupi3Z4Y1UJm08C9/3FrCfj7fR0vl7R7b0UCnP+Vcaeu
         u8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm3zrJKcNN9da6ggVggg8wTf9x17O7R9R+pl5CRCNBvURziFUiIebgy83oJd+YOvc7hOIH2JFSR8PxjDd+@vger.kernel.org, AJvYcCW6kJ+Mwp9h85G/sZJ3QBcY26s9MH1y9v+JttRmN7kLmfZYtiZBAu9Hwa8+5NIQlVLWstU=@vger.kernel.org, AJvYcCWvKEWGIGPgTw36deIfPcs1UZiTWfPllzuwdZZOvbiBk93OPuHmknmydF7Qhi55eFP1+bSuC4+2@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/llIxI5G9ABFY7qGxvQNOPvI/3qsFd5SGaoJQrrve7qNHgqY
	33GkgKylWNQuiVK3GOrlv4+3m874Q19Co6rEdqL87SQ8iLnsSaHQ
X-Google-Smtp-Source: AGHT+IGcZQQgOw04X55Pu+VemUxvEiTVGoDC/zOXtfxRwUl+zVFoxoELNp66iiJT0ZW9D8XQExnY7w==
X-Received: by 2002:a17:90a:398e:b0:2d8:8c82:10a with SMTP id 98e67ed59e1d1-2e0b8865133mr16333972a91.5.1727762455705;
        Mon, 30 Sep 2024 23:00:55 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:00:55 -0700 (PDT)
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
Subject: [PATCH net-next 2/7] net: ip: add drop reason to ip_route_input_rcu()
Date: Tue,  1 Oct 2024 14:00:00 +0800
Message-Id: <20241001060005.418231-3-dongml2@chinatelecom.cn>
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

Add the pointer of the skb drop reason to the function arguments of
ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f1767e0cc9d9..385efe6d71a7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2415,7 +2415,8 @@ out:	return err;
 
 /* called with rcu_read_lock held */
 static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			      u8 tos, struct net_device *dev, struct fib_result *res)
+			      u8 tos, struct net_device *dev, struct fib_result *res,
+			      enum skb_drop_reason *reason)
 {
 	/* Multicast recognition logic is moved from route cache to here.
 	 * The problem was that too many Ethernet cards have broken/missing
@@ -2473,7 +2474,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	tos &= INET_DSCP_MASK;
 	rcu_read_lock();
-	err = ip_route_input_rcu(skb, daddr, saddr, tos, dev, &res);
+	err = ip_route_input_rcu(skb, daddr, saddr, tos, dev, &res, reason);
 	rcu_read_unlock();
 
 	return err;
@@ -3288,7 +3289,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		skb->mark	= mark;
 		err = ip_route_input_rcu(skb, dst, src,
 					 rtm->rtm_tos & INET_DSCP_MASK, dev,
-					 &res);
+					 &res, NULL);
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.5


