Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AE1CE339
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgEKSxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731212AbgEKSwb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 14:52:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253FC061A0C
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z72so10938651wmc.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0vCBt1D4iC0eNJSSMfqS7W0wA2E5Kan2xeXfsA3ILU=;
        b=vGtK6+5IMQq2lXuqJCle4VpwFMNrCzuQ45bkU70sjzrX0aB/IzvNSrCP/uyR0uEDH4
         J++9ehUEcJy1GI6K4InFE9cWncot0Gmu9gs81y6G98x5NkCnN6Yw1PcL/9tofskOFj5k
         k0JdFguYx9bWxDmHE9oUwr4bzh1R3moJ0A6Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0vCBt1D4iC0eNJSSMfqS7W0wA2E5Kan2xeXfsA3ILU=;
        b=U5Ih2+m2m9hXRKB/4xq9CIN5eh57wnPJcY51I1C8tFnm66T2gd+Gfhj8IAvyNHwDGO
         GZNVwmSS429YDNLGOP/GIwWYA+q9RkGWvFX94c5QidOvmS41i9E7P3i0MTO2RjjrLFMt
         sSwnZiO0LJi/xSvgcGazwI2FNNBAOxTsiHPiZVyT3GECsJDya5n0Wc3gxAKjtLQyAG7z
         43pOTqOr2578nIkvC8CCohAoPyaVbeX+e/l5mkywSSnmaFAVO+O4QTobt7LSLG6qs+rv
         C+E46oOwVI2CKgfK7ApweFUE4zIPaMvYehTesy+9QavqW/uMF2EXHd7QrzVXErpZAFJ5
         3WVg==
X-Gm-Message-State: AGi0PuYUagzmrowyXxHXr/03E90qIqAJoHVtHtFTey0toahJFAzRSBlb
        q/ECk86iiSVzlhWsE0Ed6y89aA==
X-Google-Smtp-Source: APiQypKw+cunp3PJFKZ9BE3HaSOt/lJ2FAuAJGIRZ2whrxILB22+1PKRkJk8LWco5pqyuzI75b1iEA==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr18978565wmb.65.1589223150101;
        Mon, 11 May 2020 11:52:30 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id b2sm15346343wrm.30.2020.05.11.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:52:29 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 06/17] inet6: Extract helper for selecting socket from reuseport group
Date:   Mon, 11 May 2020 20:52:07 +0200
Message-Id: <20200511185218.1422406-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200511185218.1422406-1-jakub@cloudflare.com>
References: <20200511185218.1422406-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for calling into reuseport from inet6_lookup_listener as well.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv6/inet6_hashtables.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index fbe9d4295eac..03942eef8ab6 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -111,6 +111,23 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
+					    struct sk_buff *skb, int doff,
+					    const struct in6_addr *saddr,
+					    __be16 sport,
+					    const struct in6_addr *daddr,
+					    unsigned short hnum)
+{
+	struct sock *reuse_sk = NULL;
+	u32 phash;
+
+	if (sk->sk_reuseport) {
+		phash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
+		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
+	}
+	return reuse_sk;
+}
+
 /* called with rcu_read_lock() */
 static struct sock *inet6_lhash2_lookup(struct net *net,
 		struct inet_listen_hashbucket *ilb2,
@@ -123,21 +140,17 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	struct inet_connection_sock *icsk;
 	struct sock *sk, *result = NULL;
 	int score, hiscore = 0;
-	u32 phash = 0;
 
 	inet_lhash2_for_each_icsk_rcu(icsk, &ilb2->head) {
 		sk = (struct sock *)icsk;
 		score = compute_score(sk, net, hnum, daddr, dif, sdif,
 				      exact_dif);
 		if (score > hiscore) {
-			if (sk->sk_reuseport) {
-				phash = inet6_ehashfn(net, daddr, hnum,
-						      saddr, sport);
-				result = reuseport_select_sock(sk, phash,
-							       skb, doff);
-				if (result)
-					return result;
-			}
+			result = lookup_reuseport(net, sk, skb, doff,
+						  saddr, sport, daddr, hnum);
+			if (result)
+				return result;
+
 			result = sk;
 			hiscore = score;
 		}
-- 
2.25.3

