Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D41C70FD
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgEFMzh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728740AbgEFMze (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 08:55:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B90EC03C1A8
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 05:55:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so2082517wrx.4
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0YntHSMaYWhZww4u6NbDT+gNV0qs5iMn1AmJfoZVDYM=;
        b=NUv7pGLRx/073A2UdDBSLe1useV+sIU/rIVsNzbcEhWj1TCoJ1J6zL+c+lz2Txpro+
         EC+eS9x+C2JBI+cX1ZfXZXFceoawAYaM+iJkZyQYjeUahvxtxlydF1pl4IXQMDnGHL/y
         U4M5iC/awbmlcCyvXMx8b+5sC6Ht8oKDcUTx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YntHSMaYWhZww4u6NbDT+gNV0qs5iMn1AmJfoZVDYM=;
        b=hYUnTqRt04H4P7vansH6x4qUfeIv/aYQUJ7T/o2JPjT8fqVn682E354yumXr/nLADE
         ExnaSPRJcLw5GQloYLXmHO4qENvq28X+gc0NbZrir2tL/J9bwXKKy6Oz/VqtRnPrm8ht
         JSvBmQHycGmoe7dFZgzu92BCxQ71YBI6QRlSBOK/3vbJnSF1kCKCJqtvPshk8+nF8GhX
         LMPnfsuvhYw7Z1eOi2tU8seH/ihKVUu9w6aYoWLLJxGgHAyS9a9efYyQ/PN8T1iLOuew
         VCNQUVNezy7o76hAPrJCOO6eYuXLN2O1ZbFtZiKgcpjUy5msziUlDI84gnOzqTbIOOSi
         5nJQ==
X-Gm-Message-State: AGi0PuauSNCukr/3NJJ90b57xWQU6oUy5F50brB2vt/0ZEa/sgO7TIve
        7xEKK7aL6A9joHUoegFn7NUhWA==
X-Google-Smtp-Source: APiQypJRsTh056Sw4fsyQYnCKOA2Rapj3Ng0f9/oFRMv9+/SYQstnRhPyDe4WgaNyq2MRVPo4yCVCw==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr9229157wru.405.1588769732275;
        Wed, 06 May 2020 05:55:32 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id y63sm3060394wmg.21.2020.05.06.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:55:31 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 11/17] udp6: Extract helper for selecting socket from reuseport group
Date:   Wed,  6 May 2020 14:55:07 +0200
Message-Id: <20200506125514.1020829-12-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200506125514.1020829-1-jakub@cloudflare.com>
References: <20200506125514.1020829-1-jakub@cloudflare.com>
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
index f7866fded418..ee2073329d25 100644
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
2.25.3

