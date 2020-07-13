Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3584F21DF06
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgGMRrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgGMRrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 13:47:11 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98164C08C5DB
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t74so9598018lff.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWS55m6tjKFIXvF8FfZLoHa8RJokM3hk5iam/MiuzJ0=;
        b=cVOFjrb8nB2k7Yt0IvzlBgZfQPUdFQjnlodhZaKOx2YnK7BtWDJH0wEMAt3IHMLz/u
         fWs8C0Y/Q9BIml3hS7d6vUIPZfMapAB/d1sBVbwwRACkZdrKwuNsBIk4SzQXyzwvY6Q/
         4w3dbxfpYprvYND1Nieq9QfOoIe8BojwEm3MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWS55m6tjKFIXvF8FfZLoHa8RJokM3hk5iam/MiuzJ0=;
        b=IEMfLpOvBSmd+WF/TnGZi86aA7EfLptUEWvswAQCcoeMj1f/qYRGeGQ3CnhjBqpLdb
         S1VfVU9lv+HfXz77HYbI2LjzgtQSaDIH/5YB9Uh+BZMAIV59z49BP4qFJP9ILZZs5Ebu
         CUlo3bTxk2DEentk29GNgUg7uGgCGmIeX4YfL7kTp790gosN/GE4KI4h+KleSIi19bcA
         Xg3jE8rlfUbShn3ioe2raqcntZvvtifjKn30AzeooXnrbWtpZGS3nZT5xEd6IcEpZoD7
         PS+JFTsniqn7bjCJ3x2vgwScauULYvw94ziQ3ahBJWwKuhmasTqE3adlKOj9DZ1h4gxH
         jP4A==
X-Gm-Message-State: AOAM531E8w/Wk+YWhfwujU0Ojbt5MmBSf21D9pF4oRmw7Axq43zpiXWW
        md/E9YU4j3MfhHOsAx+1PzJSY1UsP/IwUg==
X-Google-Smtp-Source: ABdhPJyqO3bEy6jB31tdonFVj7PglltQYEVgBqFXsrOvaZtqcYatMVmXZ3XMCyBhvLasrTku4TjAAQ==
X-Received: by 2002:ac2:4422:: with SMTP id w2mr167186lfl.152.1594662428791;
        Mon, 13 Jul 2020 10:47:08 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id s28sm4194053ljm.24.2020.07.13.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:47:08 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v4 07/16] udp: Extract helper for selecting socket from reuseport group
Date:   Mon, 13 Jul 2020 19:46:45 +0200
Message-Id: <20200713174654.642628-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713174654.642628-1-jakub@cloudflare.com>
References: <20200713174654.642628-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for calling into reuseport from __udp4_lib_lookup as well.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 31530129f137..0d03e0277263 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -408,6 +408,25 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
+static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
+					    struct sk_buff *skb,
+					    __be32 saddr, __be16 sport,
+					    __be32 daddr, unsigned short hnum)
+{
+	struct sock *reuse_sk = NULL;
+	u32 hash;
+
+	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
+		hash = udp_ehashfn(net, daddr, hnum, saddr, sport);
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
 static struct sock *udp4_lib_lookup2(struct net *net,
 				     __be32 saddr, __be16 sport,
@@ -418,7 +437,6 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
-	u32 hash = 0;
 
 	result = NULL;
 	badness = 0;
@@ -426,15 +444,11 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			if (sk->sk_reuseport &&
-			    sk->sk_state != TCP_ESTABLISHED) {
-				hash = udp_ehashfn(net, daddr, hnum,
-						   saddr, sport);
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
 			badness = score;
 			result = sk;
 		}
-- 
2.25.4

