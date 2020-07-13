Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3914C21DF0F
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgGMRrX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbgGMRrO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 13:47:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F850C061794
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so19004014ljm.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Htoi5B3nTzd0JCiGoeXt1gyzcrOgoKflVk9EqYXpwIA=;
        b=HQFFUQ/gwR7+Tm9gVtPMta13OFDeILtTCdYDunOYGsCbwIYv5mJ9ZWl9FW6kApiJpK
         wRoWTZ6pORqflBmUXe9/duod6Ebaacs0P6M5aeZWuJYSdD3P9ub8SZgeVE2y/KxTCqaT
         GOvo773DH1Cez5gXNYEIK2+oPF5IZpKdh5jEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Htoi5B3nTzd0JCiGoeXt1gyzcrOgoKflVk9EqYXpwIA=;
        b=OWhhwiQNha/KoXblDYbN9lZZEN68NoSD9aJEgC0wVnQTfEGb986u8Ht//0yrhPtVVk
         50oa0AGZo/uUH9K14ObtzC5NSpprTa1eQYpZcAgHDOYMaM72mjCcx4f9na9TuReJDtt2
         MTKGHX1D2xdxQxf1AXYmNjWX1llGs6Rfvy/JMc3IqAKncF6lEDckcySeforktdpR5V/r
         J87thbdtr57/F49ogqoJuaPKPr6+oUn+wsILOeum4wGKy26SGtl2GZvGlFSl/wQQWKi0
         F7ezv0I5+9n7J3MQ0ES1YXRhcxXg3voTs6sTw8sbkQGNBEu8qBlgrcGKNyaQjdyOGpvp
         pW5Q==
X-Gm-Message-State: AOAM530m41uSut9poDNFk3Y+yUoMMz9aX0SQRNoc5TeWRIIpDZfvaJTa
        6RckcKQ//W21GisSCUrvk4y5o+XgO1nLCw==
X-Google-Smtp-Source: ABdhPJzHDaCgFe74GEpCI8eS4qXtdM8DqQGYrEFuNA2bNi98V41lpwwgD/4Gyi5Dyifdd2IjU2jJFQ==
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr359282ljj.209.1594662432404;
        Mon, 13 Jul 2020 10:47:12 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id g142sm4758350lfd.41.2020.07.13.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:47:11 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v4 09/16] udp6: Extract helper for selecting socket from reuseport group
Date:   Mon, 13 Jul 2020 19:46:47 +0200
Message-Id: <20200713174654.642628-10-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713174654.642628-1-jakub@cloudflare.com>
References: <20200713174654.642628-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for calling into reuseport from __udp6_lib_lookup as well.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv6/udp.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7d4151747340..65b843e7acde 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -141,6 +141,27 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
+					    struct sk_buff *skb,
+					    const struct in6_addr *saddr,
+					    __be16 sport,
+					    const struct in6_addr *daddr,
+					    unsigned int hnum)
+{
+	struct sock *reuse_sk = NULL;
+	u32 hash;
+
+	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
+		hash = udp6_ehashfn(net, daddr, hnum, saddr, sport);
+		reuse_sk = reuseport_select_sock(sk, hash, skb,
+						 sizeof(struct udphdr));
+		/* Fall back to scoring if group has connections */
+		if (reuseport_has_conns(sk, false))
+			return NULL;
+	}
+	return reuse_sk;
+}
+
 /* called with rcu_read_lock() */
 static struct sock *udp6_lib_lookup2(struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
@@ -150,7 +171,6 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
-	u32 hash = 0;
 
 	result = NULL;
 	badness = -1;
@@ -158,16 +178,11 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			if (sk->sk_reuseport &&
-			    sk->sk_state != TCP_ESTABLISHED) {
-				hash = udp6_ehashfn(net, daddr, hnum,
-						    saddr, sport);
-
-				result = reuseport_select_sock(sk, hash, skb,
-							sizeof(struct udphdr));
-				if (result && !reuseport_has_conns(sk, false))
-					return result;
-			}
+			result = lookup_reuseport(net, sk, skb,
+						  saddr, sport, daddr, hnum);
+			if (result)
+				return result;
+
 			result = sk;
 			badness = score;
 		}
-- 
2.25.4

