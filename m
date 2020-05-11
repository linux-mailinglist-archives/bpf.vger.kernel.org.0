Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0C01CE31A
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgEKSwh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731232AbgEKSwe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 14:52:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A92C061A0C
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so19122007wmj.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXY32cPktzhafRRWtWGOpRuM3Po7H5+m/zDtuRoVn8o=;
        b=G3uudaq2H+LHMIuy2V8uCDg/wetvQgEYQYys19LPCNs7x0UaZBnNFJVzHRDkPfEAnk
         PkhuWRV400r55AKOYpUdln06fXPs1gzCKaThph47657LpUN1X+S2Fvlm7W1yNeVL1kzx
         Pf0To8XIPcAGPxFGbyLybGWCfndXoWUF5Fm8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXY32cPktzhafRRWtWGOpRuM3Po7H5+m/zDtuRoVn8o=;
        b=oyeLigt+B2nrm0CM7Z2bcdZmixE762Lr0Z55AcR10AWbcEexEZWmAr5mLn1B9D6tP2
         418SNxOAsbY067MIeb6KOlVkJNXepAn4hAa51wP+fLgd4Xxce75Kl+exD/8hD+9x+z3x
         fbGF7UJ0x1MM4/IxKMTlwbwOSyQv5jO6vR7eyujbWJ9bTxrb8P5nzlaqbSJWnk3mpDL+
         l9AYIuOqQk8mGUTshsh1mI6HPxJISBoR7pJMBkbaI0kVWa/W0IgtOUufGp8J/DRgjQP+
         pfJj2KyARy3rq/kRp07FFJpRVf6W4w9w22HrsqwV/RivYlud87OWR0N0r653ZffmNqmU
         GmAQ==
X-Gm-Message-State: AGi0PuYTDIbl6E8hXoyuhxxPBHkYU86kHzPUPfbyNVPZlHXJDPAEJjln
        zrHV+8Qc1rTfQq/XWUgTqpvEPQ==
X-Google-Smtp-Source: APiQypIb/6QR1xwc8HMNRkKb5PiaCQAJx5viEmcQac4oH43IjJL4Zjtq18xZr/EjQmvQtDmTYWXxyA==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr13593932wmc.62.1589223151527;
        Mon, 11 May 2020 11:52:31 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id c17sm19072157wrn.59.2020.05.11.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:52:31 -0700 (PDT)
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
        Martin KaFai Lau <kafai@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 07/17] inet6: Run SK_LOOKUP BPF program on socket lookup
Date:   Mon, 11 May 2020 20:52:08 +0200
Message-Id: <20200511185218.1422406-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200511185218.1422406-1-jakub@cloudflare.com>
References: <20200511185218.1422406-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following ipv4 stack changes, run a BPF program attached to netns before
looking up a listening socket. Program can return a listening socket to use
as result of socket lookup, fail the lookup, or take no action.

Suggested-by: Marek Majkowski <marek@cloudflare.com>
Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/inet6_hashtables.h | 20 ++++++++++++++++++++
 net/ipv6/inet6_hashtables.c    | 15 ++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 81b965953036..8b8c0cb92ea8 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -21,6 +21,7 @@
 
 #include <net/ipv6.h>
 #include <net/netns/hash.h>
+#include <net/inet_hashtables.h>
 
 struct inet_hashinfo;
 
@@ -103,6 +104,25 @@ struct sock *inet6_lookup(struct net *net, struct inet_hashinfo *hashinfo,
 			  const int dif);
 
 int inet6_hash(struct sock *sk);
+
+static inline struct sock *inet6_lookup_run_bpf(struct net *net, u8 protocol,
+						const struct in6_addr *saddr,
+						__be16 sport,
+						const struct in6_addr *daddr,
+						u16 dport)
+{
+	struct bpf_sk_lookup_kern ctx = {
+		.family		= AF_INET6,
+		.protocol	= protocol,
+		.v6.saddr	= *saddr,
+		.v6.daddr	= *daddr,
+		.sport		= sport,
+		.dport		= dport,
+	};
+
+	return bpf_sk_lookup_run(net, &ctx);
+}
+
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 
 #define INET6_MATCH(__sk, __net, __saddr, __daddr, __ports, __dif, __sdif) \
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 03942eef8ab6..6d91de89fd2b 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -167,9 +167,22 @@ struct sock *inet6_lookup_listener(struct net *net,
 		const unsigned short hnum, const int dif, const int sdif)
 {
 	struct inet_listen_hashbucket *ilb2;
-	struct sock *result = NULL;
+	struct sock *result, *reuse_sk;
 	unsigned int hash2;
 
+	/* Lookup redirect from BPF */
+	result = inet6_lookup_run_bpf(net, hashinfo->protocol,
+				      saddr, sport, daddr, hnum);
+	if (IS_ERR(result))
+		return NULL;
+	if (result) {
+		reuse_sk = lookup_reuseport(net, result, skb, doff,
+					    saddr, sport, daddr, hnum);
+		if (reuse_sk)
+			result = reuse_sk;
+		goto done;
+	}
+
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
-- 
2.25.3

