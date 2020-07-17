Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3322397C
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGQKgX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgGQKfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614BC08C5DB
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so12002382ljm.11
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CSImEKhTKz9014ktyOGoqavC0QLsyRB1xlDmWNPgHzk=;
        b=jld1eH43Rl3jAaZG9nfqDO/v6NmI7vDBccn7gbCD8iEN57dtEQGTFczd71GZZ68G62
         aKg8NYJ8Vi8ilKuHWsrNO2kNC/pTCYkPBeMp0Lfus6etPmHIjhB4rUtjIHCt3iZCMx5E
         ojfnwO0ZXGEnPZQ3lEcmv6hc88JbdvHRU0QKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CSImEKhTKz9014ktyOGoqavC0QLsyRB1xlDmWNPgHzk=;
        b=obNZ0eIC8SHM3FpCPOX0imV71tzYxQNyPf4afMy0zGpFQIhCuqIQptT0fTI949QG8u
         Ptdi+7eWG+MKa+jGwextMie5xYWk+syza5X+hPsvrpQExnKYpYwGzt0AkjzfSYjr2TWo
         FcRd7RzWlYY7hOi5N5tqA4zr/CSXzn0L1AztE1QvgLCCeTH8CojoGiqRDXmsQ+xTZa96
         xNQAU3/ntVlNY5OHRITPYKrPCsEPC1wwSuJG4C9WyI5Zl8ybqrB476VwKzdq9b7GkR7P
         yMqmYHRrzeNezCoRUsfoHPojZhekvlcLMvoRfUgoszI9qSYvLMJTCb49JkNubOkOBNgA
         an3w==
X-Gm-Message-State: AOAM530XQPif+j2Lplcjbbi+Ja88MxoIIFraeuK9EZia88Jmg859ZcBA
        BhRNti7tHXEyZ2Cc9YvLUPiPOKGyV29EBg==
X-Google-Smtp-Source: ABdhPJxxUChiTJ/6xSYiFLsHevu0HfKyACguUTGkSb4NUiU+no3MkKYf9/si0MS0PLS/THhZTg8vxg==
X-Received: by 2002:a2e:9908:: with SMTP id v8mr4059749lji.186.1594982149229;
        Fri, 17 Jul 2020 03:35:49 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id e24sm1723466ljg.18.2020.07.17.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:35:48 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v5 07/15] udp: Extract helper for selecting socket from reuseport group
Date:   Fri, 17 Jul 2020 12:35:28 +0200
Message-Id: <20200717103536.397595-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717103536.397595-1-jakub@cloudflare.com>
References: <20200717103536.397595-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for calling into reuseport from __udp4_lib_lookup as well.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 073d346f515c..9296faea3acf 100644
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

