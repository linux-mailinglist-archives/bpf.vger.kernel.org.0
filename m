Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD964223975
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGQKf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgGQKf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F7FC061755
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so12002648ljm.11
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxJH2GAZm69sAYbUnzoD13o3dlmlVhw7Uh36sUPZfy8=;
        b=mWIffWZdY3rDJXD5U2n31gQ+qRbzhu6fe2jRdKO7Y/TZYd4k/giZFs4YwbE1NHbX0q
         qOdmUJGHrWuWP/MmBjxc5Ca+NayyIVQzVNURE2Uj9TN0dtIydKqWpjuDd/S/5ObKQrey
         pQN3vCMZ8yh46yD8GpkxcCQOuL/YBmAWf+9Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxJH2GAZm69sAYbUnzoD13o3dlmlVhw7Uh36sUPZfy8=;
        b=DFrhoFKzuCUtfvW+oxdwvLtqYOiOBC32N//V8/WcWG11dARVjTioiRtfiDxoWE1dAl
         OjHuNXY0Gg65DfODHZW7SfChFtgXEFQi9y3Z07z3PPmk9GYK8gFjFYy0gGAvBHnCFhc0
         QobkwWr9pd189+yCLfnWnQkJCrynrx794y1k3/GbEUYFeUdLdJh52urnT6662BRB3mk2
         potuh9Owhx1trbyjngJxLNVrKG3hVQzWbPB1a54m415AqxYOupg+5WnfXJwvWE5CwC4F
         fZ3D9zckJsbRjbIeUKzczxi2aHfkjW3obdx/qzixQmPmq6hNepWsw99q/3vOLVR80n0t
         FePQ==
X-Gm-Message-State: AOAM533ynbEM+mr3L2hUkoCjLXZ8cNFmJ4qxiayGoPTxe5K7esnA3lGV
        nlDLJpTJkJqYyNSd947K89Flx/QJ8vLJjg==
X-Google-Smtp-Source: ABdhPJz9Jc4U038Fwk/ocHCuTF43yxRkz6GCrztUblGnTr55PP2OzFeC3XX5sAPu6DW9N9ugIbGb5Q==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr4249671ljh.56.1594982154041;
        Fri, 17 Jul 2020 03:35:54 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id s7sm1574657ljc.86.2020.07.17.03.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:35:53 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v5 10/15] udp6: Run SK_LOOKUP BPF program on socket lookup
Date:   Fri, 17 Jul 2020 12:35:31 +0200
Message-Id: <20200717103536.397595-11-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717103536.397595-1-jakub@cloudflare.com>
References: <20200717103536.397595-1-jakub@cloudflare.com>
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
Acked-by: Andrii Nakryiko <andriin@fb.com>
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
index 084205c18a33..ff8be202726a 100644
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

