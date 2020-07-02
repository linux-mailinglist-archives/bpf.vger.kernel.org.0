Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54B211FC6
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGBJYl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 05:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgGBJYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 05:24:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD75C08C5DE
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 02:24:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so24028151eje.7
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Htoi5B3nTzd0JCiGoeXt1gyzcrOgoKflVk9EqYXpwIA=;
        b=D3G8hUKuqzMRLFofTxtAvqxCdU6A2c/SFaU6exgWnpMJ3I3HtmDTDThIXDaA5Zfrnd
         0T2Bv/O7IluLxTilJDRRc3LIlikxGPOZAiHnH0Sh5D5exMLDPKnV76ezZTs4dgutu3aR
         4OuGkETVkhb1YXSzZYNFy2ugUEMRxLuSqcYuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Htoi5B3nTzd0JCiGoeXt1gyzcrOgoKflVk9EqYXpwIA=;
        b=Yj6bo4jRvDY5PFwOqbCKW+kfOG8lRUKG0j0lwv3wYQh1GUt+zy5aX+6TMeRqcbumvP
         A8vzWCkMzIaLPdChzo1GG+A6gZE7uNTTRGDt4PlNi7EchqVZMOVJAIZGjYIIJS+nMmcw
         J5yx/pMqEwG0hSdQx98Z76EZfZpPlG0P0lqjwLnO9NSoSqM1VhA91EEVzQMprYsdyuUV
         P3UaWlkfE83OWzK4ePz2WqXdT0R2TGht+ETrTBq4ZknFP9UhsYSeEChUwJfhLI4mxeIX
         3OTO7H6PKcoya7mknb2g51v3783yO8v+u47HZLW8eokh/JK5RwJX1k8fb+MuU6w8zZdo
         Rfcw==
X-Gm-Message-State: AOAM531PJnzRfVuQRwCoXu4rNyVeiWANlB33J9KnF/tpoIWSe6EfwLDY
        toNkfEi3I1JTPh4tdjCXz9TI/gpYdohmvg==
X-Google-Smtp-Source: ABdhPJzepGZnE4+RgFsQOkJhJ0V7hm18W7jfi5nUq6Vg0+85M6eHIjvgCsB6JHQHsCcK/Dw+xAPmXQ==
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr25961961ejb.405.1593681874385;
        Thu, 02 Jul 2020 02:24:34 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id y7sm8395029edq.25.2020.07.02.02.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 02:24:33 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v3 09/16] udp6: Extract helper for selecting socket from reuseport group
Date:   Thu,  2 Jul 2020 11:24:09 +0200
Message-Id: <20200702092416.11961-10-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702092416.11961-1-jakub@cloudflare.com>
References: <20200702092416.11961-1-jakub@cloudflare.com>
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

