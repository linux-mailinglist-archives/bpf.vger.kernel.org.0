Return-Path: <bpf+bounces-3644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509F740D8D
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D556A2810B7
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C14C148;
	Wed, 28 Jun 2023 09:48:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D148C132
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 09:48:44 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AC2972
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 02:48:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fba545d743so19697045e9.0
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687945720; x=1690537720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EB6riD1WXxwAhPHQKptx8Hj/oVT2Y4njsIUAGTnV+oQ=;
        b=YHqeou5c6IyzYc35Am3dvA003R8/c/sUdngsOS4SuRzyMtyvrIFs3vUWsrjNA7ruj/
         T82MvEwOoPDT9loqH9qK15lvk/TmrXnQWgqlvbb3fDEClVw7pjmRGlyiYje/T2Lnu1Kz
         S1wfk/F64MQYlBGhEuGr2DWde0/f7xvLB4Eqmk6BpwYDEwTJD1oLrOh9ocyP43Awg3Wz
         +0kMkOw6ydaLwfvGoLnhX+OetnVcNdROVXxCOt5nSY0VNUrLrp1va0AB6L4VAAXoZ1MB
         IOLZ/QbqPA2trW23k3HtyNLYCc6IF6EhH8ZHBLcFQAUEWmwu9adHEd7deaPRM7dcRd6p
         m6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945720; x=1690537720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB6riD1WXxwAhPHQKptx8Hj/oVT2Y4njsIUAGTnV+oQ=;
        b=TQyDubqd8eaf0UJkKiTaAGwehjN68/T/oitk9Ugrz4s7jxNr6ytDsxML8UVsRj5kfc
         Zf+RCGsuKqjyMrnkV8/k49bdHw0AnqLL5oDOzLn7aMQSNNk4GuhFhx4aUHGD2readL07
         c7MxtHhjL8s3mRMpfYribxEWp6Tdyk9CLnz3+XPy8liEbsxp6fZt/UumyMNlvZpWm1UB
         P5MamPfRwBsKhFlB5+czsn8I3zG2TyF2NPotcyhTsbtHyAJQVs8tjVUX27VBUkq6We9U
         OKId2LSOmMT85HPOLMhWJwgz1LJ4AWynC3qInBteCdFXqIXs/qUffUhaRs7lM6vh/6Kk
         0lwA==
X-Gm-Message-State: AC+VfDxMPVfrf8SqIUW6OrRaUrlHLe7CDaTwU1RQcj9w76yIyj6qu4HW
	jhv3zovclkRpLYoNNAw5IjF3Dw==
X-Google-Smtp-Source: ACHHUZ4P5NKU1ykLHA5DLQTtECISZ00C+OSVji0anJvKktZD8iKpsd8voDo+TT3dppPu0iM51moOxA==
X-Received: by 2002:a7b:cd16:0:b0:3fa:98f8:225f with SMTP id f22-20020a7bcd16000000b003fa98f8225fmr5768761wmj.26.1687945720442;
        Wed, 28 Jun 2023 02:48:40 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003fbb1a9586esm1187613wmi.15.2023.06.28.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:48:40 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 28 Jun 2023 10:48:19 +0100
Subject: [PATCH bpf-next v4 4/7] net: document inet[6]_lookup_reuseport
 sk_state requirements
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v4-4-4ece76708bba@isovalent.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The current implementation was extracted from inet[6]_lhash2_lookup
in commit 80b373f74f9e ("inet: Extract helper for selecting socket
from reuseport group") and commit 5df6531292b5 ("inet6: Extract helper
for selecting socket from reuseport group"). In the original context,
sk is always in TCP_LISTEN state and so did not have a separate check.

Add documentation that specifies which sk_state are valid to pass to
the function.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/ipv4/inet_hashtables.c  | 14 ++++++++++++++
 net/ipv6/inet6_hashtables.c | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 352eb371c93b..ac927a635a6f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -335,6 +335,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
 
 INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
 
+/**
+ * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
+ * @net: network namespace.
+ * @sk: AF_INET socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
+ * @skb: context for a potential SK_REUSEPORT program.
+ * @doff: header offset.
+ * @saddr: source address.
+ * @sport: source port.
+ * @daddr: destination address.
+ * @hnum: destination port in host byte order.
+ *
+ * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
+ *         the selected sock or an error.
+ */
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 3616225c89ef..d37602fabc00 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -114,6 +114,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
 
 INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
 
+/**
+ * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
+ * @net: network namespace.
+ * @sk: AF_INET6 socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
+ * @skb: context for a potential SK_REUSEPORT program.
+ * @doff: header offset.
+ * @saddr: source address.
+ * @sport: source port.
+ * @daddr: destination address.
+ * @hnum: destination port in host byte order.
+ *
+ * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
+ *         the selected sock or an error.
+ */
 struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,

-- 
2.40.1


