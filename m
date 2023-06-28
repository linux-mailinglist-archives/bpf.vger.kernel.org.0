Return-Path: <bpf+bounces-3643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81C4740D8B
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA1281131
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B56C128;
	Wed, 28 Jun 2023 09:48:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CBBE4B
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 09:48:43 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E315A2968
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 02:48:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso6955295e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687945719; x=1690537719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/PWucZQ213a5PDLOS2NZqrmnh7Xejco/gIkhplqP/Y=;
        b=DCqEsdv14XBjYf/yMPZStSV7KwrUn87VZr3bMCCcqH8f2OcqC4Wf0WgdFAdEq6/YLU
         LvpDowPWSzImPSg8fcKoAqCrg5EIUuasbv+rTYA0DRpFM9iE/CVXSMSgV4JH5wq1Hq/A
         q8Z0pyfI5QpA9p+HSvW+4whfwL/uJY/DwszIKaGXuckwsFMkUqxe1FgO6dTv1/JcDkmt
         ttOzfZA3bouH4O72BrXi8kq16c/tzeTd1p58IPDlik/5BcEHOJVgk40bBAtJKwEialsB
         QWVx4Z36ENxFx24/JWTVq6CR3TT7LxNl/3wQdSBW6uYCM9VVAM41fNonAJPc1sphVcRB
         5IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945719; x=1690537719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/PWucZQ213a5PDLOS2NZqrmnh7Xejco/gIkhplqP/Y=;
        b=JPsOrK7wNdM5fpHHsiD5vewouoFl0nlb1J92CvuGgu7J/ZXUbfCpXQGojBUJ0hx73b
         oVY/rwsAX68Rpmaxq2Wb4gGVBdCSrUAEj5OTPnBpQE/RPnpp8FbdeY3Wod2Y511GRSaC
         nvoeLA+6IIqPaEre5xKldP24aQ0kxAdvvgvVbRexXw5dwTTejJahB5UVKe4VumE+UifT
         61ijH5+UXEGK7+Uv5IUNgPDZNYqpAStqUflgrQewRfDahvjjx9M4eUergTEsfoi2NqLo
         Z/6SnWXDRaOm3/YYGD9cyXw4xDzhqkN+7aesSshBGTNoC6bI7jBolqsM0BTJhIm6Tbcd
         Vtpg==
X-Gm-Message-State: AC+VfDyVk1aj4nED2qkR9i4MzJXCNRgLZ6JfUBUw9uB916BRHq1hKGnJ
	Y2M2B6lPnbasst7BVi2OtfDXfA==
X-Google-Smtp-Source: ACHHUZ47+NM/gCQZXDoGOr3lZR3vWhuByXJVOZrZ4LwZGlxuxK9sthd+S72QqSYJQO6K70N+2Ra46w==
X-Received: by 2002:a05:600c:28c:b0:3fb:2d92:ecf1 with SMTP id 12-20020a05600c028c00b003fb2d92ecf1mr979693wmk.7.1687945719370;
        Wed, 28 Jun 2023 02:48:39 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003fbb1a9586esm1187613wmi.15.2023.06.28.02.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:48:39 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 28 Jun 2023 10:48:18 +0100
Subject: [PATCH bpf-next v4 3/7] net: remove duplicate reuseport_lookup
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v4-3-4ece76708bba@isovalent.com>
References: <20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are currently four copies of reuseport_lookup: one each for
(TCP, UDP)x(IPv4, IPv6). This forces us to duplicate all callers of
those functions as well. This is already the case for sk_lookup
helpers (inet,inet6,udp4,udp6)_lookup_run_bpf.

There are two differences between the reuseport_lookup helpers:

1. They call different hash functions depending on protocol
2. UDP reuseport_lookup checks that sk_state != TCP_ESTABLISHED

Move the check for sk_state into the caller and use the INDIRECT_CALL
infrastructure to cut down the helpers to one per IP version.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h | 11 ++++++++++-
 include/net/inet_hashtables.h  | 15 ++++++++++-----
 net/ipv4/inet_hashtables.c     | 20 +++++++++++++-------
 net/ipv4/udp.c                 | 34 +++++++++++++---------------------
 net/ipv6/inet6_hashtables.c    | 14 ++++++++++----
 net/ipv6/udp.c                 | 41 ++++++++++++++++-------------------------
 6 files changed, 72 insertions(+), 63 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 032ddab48f8f..f89320b6fee3 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -48,12 +48,21 @@ struct sock *__inet6_lookup_established(struct net *net,
 					const u16 hnum, const int dif,
 					const int sdif);
 
+typedef u32 (inet6_ehashfn_t)(const struct net *net,
+			       const struct in6_addr *laddr, const u16 lport,
+			       const struct in6_addr *faddr, const __be16 fport);
+
+inet6_ehashfn_t inet6_ehashfn;
+
+INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
+
 struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,
 				    __be16 sport,
 				    const struct in6_addr *daddr,
-				    unsigned short hnum);
+				    unsigned short hnum,
+				    inet6_ehashfn_t *ehashfn);
 
 struct sock *inet6_lookup_listener(struct net *net,
 				   struct inet_hashinfo *hashinfo,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 8734f3488f5d..ddfa2e67fdb5 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -379,10 +379,19 @@ struct sock *__inet_lookup_established(struct net *net,
 				       const __be32 daddr, const u16 hnum,
 				       const int dif, const int sdif);
 
+typedef u32 (inet_ehashfn_t)(const struct net *net,
+			      const __be32 laddr, const __u16 lport,
+			      const __be32 faddr, const __be16 fport);
+
+inet_ehashfn_t inet_ehashfn;
+
+INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
+
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
-				   __be32 daddr, unsigned short hnum);
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t *ehashfn);
 
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
@@ -453,10 +462,6 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 			     refcounted);
 }
 
-u32 inet6_ehashfn(const struct net *net,
-		  const struct in6_addr *laddr, const u16 lport,
-		  const struct in6_addr *faddr, const __be16 fport);
-
 static inline void sk_daddr_set(struct sock *sk, __be32 addr)
 {
 	sk->sk_daddr = addr; /* alias of inet_daddr */
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 920131e4a65d..352eb371c93b 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -28,9 +28,9 @@
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
 
-static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
-			const __u16 lport, const __be32 faddr,
-			const __be16 fport)
+u32 inet_ehashfn(const struct net *net, const __be32 laddr,
+		 const __u16 lport, const __be32 faddr,
+		 const __be16 fport)
 {
 	static u32 inet_ehash_secret __read_mostly;
 
@@ -39,6 +39,7 @@ static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 	return __inet_ehashfn(laddr, lport, faddr, fport,
 			      inet_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet_ehashfn);
 
 /* This function handles inet_sock, but also timewait and request sockets
  * for IPv4/IPv6.
@@ -332,16 +333,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
+
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
-				   __be32 daddr, unsigned short hnum)
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t *ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_2(ehashfn, udp_ehashfn, inet_ehashfn,
+					net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
@@ -371,7 +376,7 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet_lookup_reuseport(net, sk, skb, doff,
-						       saddr, sport, daddr, hnum);
+						       saddr, sport, daddr, hnum, inet_ehashfn);
 			if (result)
 				return result;
 
@@ -400,7 +405,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
+					 inet_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5ef478d2c408..7258edece691 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -405,9 +405,9 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
-		       const __u16 lport, const __be32 faddr,
-		       const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
+		const __be32 faddr, const __be16 fport)
 {
 	static u32 udp_ehash_secret __read_mostly;
 
@@ -417,22 +417,6 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned short hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp4_lib_lookup2(struct net *net,
 				     __be32 saddr, __be16 sport,
@@ -451,7 +435,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+						       saddr, sport, daddr, hnum, udp_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -490,7 +481,8 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					 saddr, sport, daddr, hnum, udp_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b7c56867314e..3616225c89ef 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -39,6 +39,7 @@ u32 inet6_ehashfn(const struct net *net,
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
 			       inet6_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
 /*
  * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
@@ -111,18 +112,22 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
+
 struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,
 				    __be16 sport,
 				    const struct in6_addr *daddr,
-				    unsigned short hnum)
+				    unsigned short hnum,
+				    inet6_ehashfn_t *ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_INET(ehashfn, udp6_ehashfn, inet6_ehashfn,
+					   net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
@@ -145,7 +150,7 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet6_lookup_reuseport(net, sk, skb, doff,
-							saddr, sport, daddr, hnum);
+							saddr, sport, daddr, hnum, inet6_ehashfn);
 			if (result)
 				return result;
 
@@ -176,7 +181,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, hnum, inet6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8b3cb1d7da7c..ebac9200b15c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -70,11 +70,12 @@ int udpv6_init_sock(struct sock *sk)
 	return 0;
 }
 
-static u32 udp6_ehashfn(const struct net *net,
-			const struct in6_addr *laddr,
-			const u16 lport,
-			const struct in6_addr *faddr,
-			const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp6_ehashfn(const struct net *net,
+		 const struct in6_addr *laddr,
+		 const u16 lport,
+		 const struct in6_addr *faddr,
+		 const __be16 fport)
 {
 	static u32 udp6_ehash_secret __read_mostly;
 	static u32 udp_ipv6_hash_secret __read_mostly;
@@ -159,24 +160,6 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     const struct in6_addr *saddr,
-				     __be16 sport,
-				     const struct in6_addr *daddr,
-				     unsigned int hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp6_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp6_lib_lookup2(struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
@@ -194,7 +177,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+							saddr, sport, daddr, hnum, udp6_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -234,7 +224,8 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					  saddr, sport, daddr, hnum, udp6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;

-- 
2.40.1


