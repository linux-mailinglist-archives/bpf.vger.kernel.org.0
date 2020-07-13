Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63321DF0B
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgGMRrR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbgGMRrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 13:47:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE802C061794
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so18976072ljl.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5sob8efe4WSDw01Inzq02yiJzim8BxMO0L4N+ZlIM8o=;
        b=rGs721d7iQPNXL/HucdiRuHkUKTsDJYzQEpxJvwOoYJfrjIWorYpldlmrbbNqqif01
         KtLYbsU7uprBJn5zuJbF0itAW6NJ9JouthxhDxOAkQVyutKJ/CqxsjxtRb9FfgKviMa7
         unu3ASP5qHFuAj9y7X7b+9yFI9p6CFTWcWXvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sob8efe4WSDw01Inzq02yiJzim8BxMO0L4N+ZlIM8o=;
        b=KZqCPQ5tlqKZnqTBM9c1f00EGi/R5iP9+n4VWeTNQU+5uNrC4eYgxWX8dgOiZUj0hq
         XIsXfxTWuxcfNIwB4TD76lCe6Zgs+S3AFyfPK9Kl7q5U6fTXflXxHKkOh/+pIpMIqhKc
         lySGf6xW4TI6LKc9s+E/ARRAUXchpm89MVmwPBYPUksfl9v/5G/mNF50MOdR9RaFUOND
         OfRUdnHq2bX/FeQw8K4UePCr4jLNbB9nQC1dDer+OKQL9c31sz3BonBMik1tMuifA8iX
         ciAjlRF060xnrtv6iwKQjTpm1ET29dThsJNLD+Lhon20aWmhzsU/7/mes6e+joho196Y
         2xcA==
X-Gm-Message-State: AOAM533araZrlnjmebfQ54ZkCGvmD9Hal88TQDq0+i9gxy+31SxgR6az
        K6fHxGfGukoPrKVy70FLHYPWa1qGykBXSw==
X-Google-Smtp-Source: ABdhPJxJ/247X3MskwFQTvJkeGDTmI+Ln+PB9RT2BVvL/6uU2PYAIx02cPCPukjV3DRjNmFQ0N7wbA==
X-Received: by 2002:a2e:b5a8:: with SMTP id f8mr354652ljn.247.1594662434284;
        Mon, 13 Jul 2020 10:47:14 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id b6sm4711778lfe.28.2020.07.13.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:47:13 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [PATCH bpf-next v4 10/16] udp6: Run SK_LOOKUP BPF program on socket lookup
Date:   Mon, 13 Jul 2020 19:46:48 +0200
Message-Id: <20200713174654.642628-11-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713174654.642628-1-jakub@cloudflare.com>
References: <20200713174654.642628-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Same as for udp4, let BPF program override the socket lookup result, by
selecting a receiving socket of its choice or failing the lookup, if no
connected UDP socket matched packet 4-tuple.

Suggested-by: Marek Majkowski <marek@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v4:
    - Adapt to change in bpf_sk_lookup_run_v6 return value semantics.
    
    v3:
    - Use a static_key to minimize the hook overhead when not used. (Alexei)
    - Adapt for running an array of attached programs. (Alexei)
    - Adapt for optionally skipping reuseport selection. (Martin)

 net/ipv6/udp.c | 60 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 65b843e7acde..d46c62976b5b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -190,6 +190,31 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 	return result;
 }
 
+static inline struct sock *udp6_lookup_run_bpf(struct net *net,
+					       struct udp_table *udptable,
+					       struct sk_buff *skb,
+					       const struct in6_addr *saddr,
+					       __be16 sport,
+					       const struct in6_addr *daddr,
+					       u16 hnum)
+{
+	struct sock *sk, *reuse_sk;
+	bool no_reuseport;
+
+	if (udptable != &udp_table)
+		return NULL; /* only UDP is supported */
+
+	no_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_UDP,
+					    saddr, sport, daddr, hnum, &sk);
+	if (no_reuseport || IS_ERR_OR_NULL(sk))
+		return sk;
+
+	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	if (reuse_sk)
+		sk = reuse_sk;
+	return sk;
+}
+
 /* rcu_read_lock() must be held */
 struct sock *__udp6_lib_lookup(struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
@@ -200,25 +225,42 @@ struct sock *__udp6_lib_lookup(struct net *net,
 	unsigned short hnum = ntohs(dport);
 	unsigned int hash2, slot2;
 	struct udp_hslot *hslot2;
-	struct sock *result;
+	struct sock *result, *sk;
 
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
 	slot2 = hash2 & udptable->mask;
 	hslot2 = &udptable->hash2[slot2];
 
+	/* Lookup connected or non-wildcard sockets */
 	result = udp6_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
 				  hslot2, skb);
-	if (!result) {
-		hash2 = ipv6_portaddr_hash(net, &in6addr_any, hnum);
-		slot2 = hash2 & udptable->mask;
+	if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
+		goto done;
+
+	/* Lookup redirect from BPF */
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
+		sk = udp6_lookup_run_bpf(net, udptable, skb,
+					 saddr, sport, daddr, hnum);
+		if (sk) {
+			result = sk;
+			goto done;
+		}
+	}
 
-		hslot2 = &udptable->hash2[slot2];
+	/* Got non-wildcard socket or error on first lookup */
+	if (result)
+		goto done;
 
-		result = udp6_lib_lookup2(net, saddr, sport,
-					  &in6addr_any, hnum, dif, sdif,
-					  hslot2, skb);
-	}
+	/* Lookup wildcard sockets */
+	hash2 = ipv6_portaddr_hash(net, &in6addr_any, hnum);
+	slot2 = hash2 & udptable->mask;
+	hslot2 = &udptable->hash2[slot2];
+
+	result = udp6_lib_lookup2(net, saddr, sport,
+				  &in6addr_any, hnum, dif, sdif,
+				  hslot2, skb);
+done:
 	if (IS_ERR(result))
 		return NULL;
 	return result;
-- 
2.25.4

