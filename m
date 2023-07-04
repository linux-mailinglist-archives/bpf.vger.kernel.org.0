Return-Path: <bpf+bounces-3977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A3747342
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE71B1C2083E
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE806FDA;
	Tue,  4 Jul 2023 13:46:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDD6FAA
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 13:46:51 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8FE3
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 06:46:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313f3a6db22so6432293f8f.3
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688478406; x=1691070406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVYMS1n+cQWde9kXlA/iGOdfMKTYAxMK1vKNV086zNc=;
        b=ad21p7MzUZFIaRLWIm2g41StkECKb0LfxwFFri4Yqe/Y7IDUR5mObYUlHmsnQZPwTy
         tdBCP7EmpjXFTHGuWBZIBF0aYJJwqBuzlncRGrVUo40Tskw55TAMrsxyReYY5S4mj7nU
         Fhf2azEvTXijHomCm5I9MdNYYhnPPY0FFIwM1tzwK4Y56dGUzOJ1BnkQfKqyNZm25SZI
         zKddsfgIG/0f88lg32RgiduKOHoOWY4kV3srWs8tuvCgYALbeZBSPUofYQHM6UXR8/00
         bNOO43PfujOpXfF4nIAO4/fMQXjyFeqeAqYUriK8AFQaauXx7qaZrBgKhlyu5wk049Ng
         s+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478406; x=1691070406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVYMS1n+cQWde9kXlA/iGOdfMKTYAxMK1vKNV086zNc=;
        b=ki9edG5d6w4vDmD8/YCkxNX3aNSNLUmyTLdrUXC+NUbpSWVLIVU+j3REg4hLBH7wQy
         0iyL0a20Msfa6ILPZQhQn7OvzQjpf6300s1RBkb7Rn46LUTsJiHUrQR97WJCugbkG/xk
         lSXFps+0Z4dySurLzXYnKP35RiIdnQvpVZKUPJy6ORMKdmZrG2UPWcB4AZ+7fV2lVXoZ
         8YgfR4US/Wj+wsGB/iwNiLeRvsTgOUwCn6KMIGZ1y2EmHoZ/3bDig2ior/eIFdCvGScL
         OdDN5cW99znbR3m6KuKrW51QR1XL0G9r4SjbVLNgrnWFLHchJORJs9qOXsYv++PGghLB
         gIxg==
X-Gm-Message-State: ABy/qLZwICA5+RcHnI9rEP8HEX5vSgsUn8e/60I8MUxEghiACAQLG33E
	lCwSFyxVN8ZUku+XUgEtSIjWtQ==
X-Google-Smtp-Source: APBJJlGT2y8YhG4EvwcCi60q03Uut9Jn/G538JjI59oeQy37zN1R3YwkCAIjR2icVuehBkp7xGtToA==
X-Received: by 2002:adf:fd43:0:b0:314:1f6:2c24 with SMTP id h3-20020adffd43000000b0031401f62c24mr12977829wrs.36.1688478406275;
        Tue, 04 Jul 2023 06:46:46 -0700 (PDT)
Received: from [192.168.133.175] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b003142b0d98b4sm9274680wrt.37.2023.07.04.06.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:46:46 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 04 Jul 2023 14:46:27 +0100
Subject: [PATCH bpf-next v5 5/7] net: remove duplicate sk_lookup helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v5-5-f6686a0dbce0@isovalent.com>
References: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that inet[6]_lookup_reuseport are parameterised on the ehashfn
we can remove two sk_lookup helpers.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 include/net/inet6_hashtables.h |  9 +++++++++
 include/net/inet_hashtables.h  |  7 +++++++
 net/ipv4/inet_hashtables.c     | 26 +++++++++++++-------------
 net/ipv4/udp.c                 | 32 +++++---------------------------
 net/ipv6/inet6_hashtables.c    | 31 ++++++++++++++++---------------
 net/ipv6/udp.c                 | 34 +++++-----------------------------
 6 files changed, 55 insertions(+), 84 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index f89320b6fee3..a6722d6ef80f 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -73,6 +73,15 @@ struct sock *inet6_lookup_listener(struct net *net,
 				   const unsigned short hnum,
 				   const int dif, const int sdif);
 
+struct sock *inet6_lookup_run_sk_lookup(struct net *net,
+					int protocol,
+					struct sk_buff *skb, int doff,
+					const struct in6_addr *saddr,
+					const __be16 sport,
+					const struct in6_addr *daddr,
+					const u16 hnum, const int dif,
+					inet6_ehashfn_t *ehashfn);
+
 static inline struct sock *__inet6_lookup(struct net *net,
 					  struct inet_hashinfo *hashinfo,
 					  struct sk_buff *skb, int doff,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ddfa2e67fdb5..c0532cc7587f 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -393,6 +393,13 @@ struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   __be32 daddr, unsigned short hnum,
 				   inet_ehashfn_t *ehashfn);
 
+struct sock *inet_lookup_run_sk_lookup(struct net *net,
+				       int protocol,
+				       struct sk_buff *skb, int doff,
+				       __be32 saddr, __be16 sport,
+				       __be32 daddr, u16 hnum, const int dif,
+				       inet_ehashfn_t *ehashfn);
+
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
 				const __be32 saddr, const __be16 sport,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 64fc1bd3fb63..75b1ed1b89f2 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -403,25 +403,23 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 	return result;
 }
 
-static inline struct sock *inet_lookup_run_bpf(struct net *net,
-					       struct inet_hashinfo *hashinfo,
-					       struct sk_buff *skb, int doff,
-					       __be32 saddr, __be16 sport,
-					       __be32 daddr, u16 hnum, const int dif)
+struct sock *inet_lookup_run_sk_lookup(struct net *net,
+				       int protocol,
+				       struct sk_buff *skb, int doff,
+				       __be32 saddr, __be16 sport,
+				       __be32 daddr, u16 hnum, const int dif,
+				       inet_ehashfn_t *ehashfn)
 {
 	struct sock *sk, *reuse_sk;
 	bool no_reuseport;
 
-	if (hashinfo != net->ipv4.tcp_death_row.hashinfo)
-		return NULL; /* only TCP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v4(net, IPPROTO_TCP, saddr, sport,
+	no_reuseport = bpf_sk_lookup_run_v4(net, protocol, saddr, sport,
 					    daddr, hnum, dif, &sk);
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
 	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
-					 inet_ehashfn);
+					 ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
@@ -439,9 +437,11 @@ struct sock *__inet_lookup_listener(struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		result = inet_lookup_run_bpf(net, hashinfo, skb, doff,
-					     saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+		result = inet_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
+						   saddr, sport, daddr, hnum, dif,
+						   inet_ehashfn);
 		if (result)
 			goto done;
 	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 55f683b31c93..045eca6ed177 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -465,30 +465,6 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 	return result;
 }
 
-static struct sock *udp4_lookup_run_bpf(struct net *net,
-					struct udp_table *udptable,
-					struct sk_buff *skb,
-					__be32 saddr, __be16 sport,
-					__be32 daddr, u16 hnum, const int dif)
-{
-	struct sock *sk, *reuse_sk;
-	bool no_reuseport;
-
-	if (udptable != net->ipv4.udp_table)
-		return NULL; /* only UDP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v4(net, IPPROTO_UDP, saddr, sport,
-					    daddr, hnum, dif, &sk);
-	if (no_reuseport || IS_ERR_OR_NULL(sk))
-		return sk;
-
-	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
-					 saddr, sport, daddr, hnum, udp_ehashfn);
-	if (reuse_sk)
-		sk = reuse_sk;
-	return sk;
-}
-
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
@@ -513,9 +489,11 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		sk = udp4_lookup_run_bpf(net, udptable, skb,
-					 saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    udptable == net->ipv4.udp_table) {
+		sk = inet_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
+					       saddr, sport, daddr, hnum, dif,
+					       udp_ehashfn);
 		if (sk) {
 			result = sk;
 			goto done;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index f76dbbb29332..7c9700c7c9c8 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -177,31 +177,30 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	return result;
 }
 
-static inline struct sock *inet6_lookup_run_bpf(struct net *net,
-						struct inet_hashinfo *hashinfo,
-						struct sk_buff *skb, int doff,
-						const struct in6_addr *saddr,
-						const __be16 sport,
-						const struct in6_addr *daddr,
-						const u16 hnum, const int dif)
+struct sock *inet6_lookup_run_sk_lookup(struct net *net,
+					int protocol,
+					struct sk_buff *skb, int doff,
+					const struct in6_addr *saddr,
+					const __be16 sport,
+					const struct in6_addr *daddr,
+					const u16 hnum, const int dif,
+					inet6_ehashfn_t *ehashfn)
 {
 	struct sock *sk, *reuse_sk;
 	bool no_reuseport;
 
-	if (hashinfo != net->ipv4.tcp_death_row.hashinfo)
-		return NULL; /* only TCP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_TCP, saddr, sport,
+	no_reuseport = bpf_sk_lookup_run_v6(net, protocol, saddr, sport,
 					    daddr, hnum, dif, &sk);
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
 	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
-					  saddr, sport, daddr, hnum, inet6_ehashfn);
+					  saddr, sport, daddr, hnum, ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
 }
+EXPORT_SYMBOL_GPL(inet6_lookup_run_sk_lookup);
 
 struct sock *inet6_lookup_listener(struct net *net,
 		struct inet_hashinfo *hashinfo,
@@ -215,9 +214,11 @@ struct sock *inet6_lookup_listener(struct net *net,
 	unsigned int hash2;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		result = inet6_lookup_run_bpf(net, hashinfo, skb, doff,
-					      saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    hashinfo == net->ipv4.tcp_death_row.hashinfo) {
+		result = inet6_lookup_run_sk_lookup(net, IPPROTO_TCP, skb, doff,
+						    saddr, sport, daddr, hnum, dif,
+						    inet6_ehashfn);
 		if (result)
 			goto done;
 	}
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5c1c61a5a401..ac3899e6112c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -205,32 +205,6 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 	return result;
 }
 
-static inline struct sock *udp6_lookup_run_bpf(struct net *net,
-					       struct udp_table *udptable,
-					       struct sk_buff *skb,
-					       const struct in6_addr *saddr,
-					       __be16 sport,
-					       const struct in6_addr *daddr,
-					       u16 hnum, const int dif)
-{
-	struct sock *sk, *reuse_sk;
-	bool no_reuseport;
-
-	if (udptable != net->ipv4.udp_table)
-		return NULL; /* only UDP is supported */
-
-	no_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_UDP, saddr, sport,
-					    daddr, hnum, dif, &sk);
-	if (no_reuseport || IS_ERR_OR_NULL(sk))
-		return sk;
-
-	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
-					  saddr, sport, daddr, hnum, udp6_ehashfn);
-	if (reuse_sk)
-		sk = reuse_sk;
-	return sk;
-}
-
 /* rcu_read_lock() must be held */
 struct sock *__udp6_lib_lookup(struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
@@ -255,9 +229,11 @@ struct sock *__udp6_lib_lookup(struct net *net,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		sk = udp6_lookup_run_bpf(net, udptable, skb,
-					 saddr, sport, daddr, hnum, dif);
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    udptable == net->ipv4.udp_table) {
+		sk = inet6_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
+						saddr, sport, daddr, hnum, dif,
+						udp6_ehashfn);
 		if (sk) {
 			result = sk;
 			goto done;

-- 
2.40.1


