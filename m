Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A51622397A
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQKgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGQKfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64723C08C5DF
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so12011987ljn.8
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eschEy53g/sALZZ57s8UKjarobS3HOdi5PTUrjQnJfg=;
        b=tW0U2y/HC9CMfXLuQIbhwms6hbzo+1g9TtKf0+IPSeujofEx7+9hbj4bg8eW3i8GZb
         aSP20/w+dQiLEupJkWGfVPR05A1Efgycbjq7yeRXXyuUlML4gPFj3DyiKOhcoiPv+tUZ
         z0TNd+flH2p+VVuJj4sll/QCPzEHKTFz6sku4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eschEy53g/sALZZ57s8UKjarobS3HOdi5PTUrjQnJfg=;
        b=thDP2Mb9HpkmP10UervqNGeB4lBHlk4oJnsrkpWwrolQpCjAs9sfxMxf+MNwzZLDiY
         cEy08nlKZuo0X5T2TudILLUINnXI+0YDpou066g5HYw1f7COLn/UzEXzmYs2BUDpcZ1W
         7zIUmgAABcLRCjx9ujlL+TDHT1RYbAznLrw599tfDXb1efEcFfre+Yim6OXnDhMt8iGM
         2CS3J+gW24D0JKYGX+WaCKdg6iGoLu56KIdE9gv72KBbnJQaPqD4wCS9LT2Dz9Y3XW/B
         Xk0UYmkhSVUBxwLtBWxm8eMhpnXZNkIDSwB4gR9pvujnU93uAeanHKGop8v3bNMNHd7F
         KthQ==
X-Gm-Message-State: AOAM530rpkgyLcXP+W6fXbalfkFYegHeFYnNoc+jhd736O2uQ/niVZvK
        iZfQxuf9ZRScSHow7JSWrnW5+nCoZZ8uUg==
X-Google-Smtp-Source: ABdhPJxFyv1+RIznDtI7Wo3fHMt61+PZGg8RLnUlfjR59ExA+UxISQJSVoNVycG5LHhSxgR2R0lVsA==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr3872568ljm.116.1594982152548;
        Fri, 17 Jul 2020 03:35:52 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j17sm1788180lfk.31.2020.07.17.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:35:51 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v5 09/15] udp6: Extract helper for selecting socket from reuseport group
Date:   Fri, 17 Jul 2020 12:35:30 +0200
Message-Id: <20200717103536.397595-10-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717103536.397595-1-jakub@cloudflare.com>
References: <20200717103536.397595-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for calling into reuseport from __udp6_lib_lookup as well.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv6/udp.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 38c0d9350c6b..084205c18a33 100644
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

