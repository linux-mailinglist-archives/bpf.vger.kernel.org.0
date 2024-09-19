Return-Path: <bpf+bounces-40088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1097C74B
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B823E289BD1
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E919ABC4;
	Thu, 19 Sep 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAAH60m3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924E199FC9;
	Thu, 19 Sep 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738995; cv=none; b=sY4cwOctauY9568hveWHB2ffLV1XqC+8u+p/tNFFMju1SOA8c4HxIEGyofgJhyl/BvdQTCVYbli7RGvC50TD7GgWsQO1bYeu90mA+dy66wjztRExchnIyvvtACxUkfHGESxdWP3YCk33UB7yt+N+fvETPQIo0vRK8t6YV+sLMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738995; c=relaxed/simple;
	bh=zvB8Xh9fDLbp9WfQKRxYAZgiU3vdvZ9bHwKeXqUqhC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVSXfn4+1e48xwdtwY38mRzOjgerPFkbV5WDFRLN5WqRWn1+S/W8ywMfxKzTxaU+lsksIXcyxjNLlB3CBLnMuAzOh9biWYuLbXlUFX4ekGsEvmUTSkq++e+VrMCoQDhe7AweS2qjimYabboff0nbgNjLnkf0Soq6/T8PUG6YD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAAH60m3; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so492322a12.2;
        Thu, 19 Sep 2024 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738972; x=1727343772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrcolmE9x3EsGlnudoge00ElKatztC69V36dDAFu6ds=;
        b=CAAH60m3BA/p2Q79j2NjW/S+ok+IfXRPbBrXe7fjhhDwe7D+kXKrC97exKPsX4h2qC
         Xfyfuj/8FRos0kK/AhXS+SABJx8YF4hZjxlu5YR86F47r8xn6ukdLiprY/8eoOBjMxRL
         7SY/JFwraKERg+prWwN7rVMz5QVemzrgKXJ69GTQQDq/EznuehPRiWBMwhHuRxVBgCOn
         P+MnpnQhIl7vj4078yS+U2Xm61+p2FHk0aOMaxHG3gtquuUSHJYRzhg9CviRGlZ1FtBV
         23aLHOzUVTeC1fof97Eoej0dYhZnyVpFe4+RyOCYRUTCX9/hMOScSzFsxdyExdwvo2Lk
         JMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738972; x=1727343772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrcolmE9x3EsGlnudoge00ElKatztC69V36dDAFu6ds=;
        b=R6jZRdIuHEkzdoo/snP8kRAGs08gUR1JLvC+m5mvIu5CmNtFA7J7V5J5TFdzZ3fqcE
         SSmCtVlLpwIB1mF2WaEiz3kM1SVvQD4ohUYf/SJOVDoHmBllGVzdWN29FFHBm3Vysc71
         9GFQfXzWeN9kdaCiw/aTaCGkyBrep/Z1feNmvEk/XjBNeLA36K/at/JFNYYGwF69+bvo
         XHXWtOY8pGSDg3jO36PZww2uTBjpO4U1oJQw+BswDYeLUSc/aOtOlaBB6oxI78ab7IlD
         S5pmgLtFAdCoC6kADitTqipnuuML9h7CylOKay1GItn+5bceLlVO7zqMcDd4BHj5gUJ6
         v+cg==
X-Forwarded-Encrypted: i=1; AJvYcCUZuMDA50TcC63TQ03kD3vj+P1eJLIfqnqLA5LSGH39JOPmxZWYrTIGyRnFPXwYu8o1bCqBRSaZ@vger.kernel.org, AJvYcCUpxbrX+mBksXh4VqAXbWclwIBsJ7yS2sm6BRoMtxqXkUee4I6mABiD5knu5JPVyZA/XSJdb9lXfBsQACCQ@vger.kernel.org, AJvYcCXbBVu8HomOFptybIxY4zEiECZGko77ImdW/jvKUAUQElRQXjm/6TPQWpR0TEMeDkCygW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaj6d4ezVcC5eJ4oJVqDXcqZ+ZRhTEH34RTl4xW9WbFfvNTHi
	SsmRZOktl9hJXqlKDKgvrpYj16Z94n53Gb7+k0n8jHs+3lvgEhfW
X-Google-Smtp-Source: AGHT+IGBKDjP2YdqEPEr0dR0+FTOQdTVyCZ5sAHSk7tNBUUCY2CcvUWtFa+bFFgC/zYBjSy/jGidAA==
X-Received: by 2002:a05:6a20:1b08:b0:1d2:e1cc:649c with SMTP id adf61e73a8af0-1d2e1cc6617mr10816659637.15.1726738971628;
        Thu, 19 Sep 2024 02:42:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:42:51 -0700 (PDT)
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
Subject: [RFC PATCH net-next 2/7] net: ip: add drop reason to ip_route_input_rcu()
Date: Thu, 19 Sep 2024 17:41:42 +0800
Message-Id: <20240919094147.328737-3-dongml2@chinatelecom.cn>
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


