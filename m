Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2D211FC8
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgGBJYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgGBJYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 05:24:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590CC08C5E0
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 02:24:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d15so22895416edm.10
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9asR5sh01iXalcrdSEirJj/xH3WCxxvJXMDr+dr/BJY=;
        b=FvFfqykVjxnJw2qodna3avrWjEbaEAUcXWt9/yMLTfF1WfmCGEHINl0GDe4Xx5ivGL
         q63gza88UE3qwQFDoql5lviGUnyC1uKQ1kNKL6m2zkY4fUWVvcDbnbJyQ7qbeuNsE4q5
         K9TSXSvsZ++96w3/EhTqcMo+NFHfVkrR43b7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9asR5sh01iXalcrdSEirJj/xH3WCxxvJXMDr+dr/BJY=;
        b=Sa8r8U1nPLo0fIBnrbAu7WFGC+7G3NTp59t6O3z1o4QAYs8kT7pwQGE8QiEK1bcROl
         v1787yAyFo1TmZj1Ab0a+wF08Iubwo6aBGXXRi6IySLgosy3OOH8W1VJQ0mfo91lOTSh
         Cb5gmSWciBf0OCFuplJVhz+5HTzONeOjT1L0TvCk3/zrFOvMa+CXtfN/Tors0fU9VZjF
         aWrq/8KaunZjGeKAYCqnBV6pmG4leAeymqPZfrAnknKFHSZ1FFceo7T6eCxOv4RcmsEV
         UEc3xsy3bjzZ2LWzuzmJiZQIOqqM4ljZ+MSr5aFrwSUSOG9B3VbdhMyPt+v/8cc5MHFC
         zumQ==
X-Gm-Message-State: AOAM530rIKMN2IlFTFu2wa4Lh3h4oy5Xpl9lAPemzjVER/Yjias/MIlp
        43fCelLB9gC1QoVli9CvJvjktTi68FuEQg==
X-Google-Smtp-Source: ABdhPJyjeDrkm82FQWpsUXquzibnqK8TehHY2J+iKUTdqZ6/YwdUDbonRPA3eEVex7S0vc4duAyOpQ==
X-Received: by 2002:a05:6402:1c0f:: with SMTP id ck15mr32256320edb.155.1593681876204;
        Thu, 02 Jul 2020 02:24:36 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id e8sm6341467eja.101.2020.07.02.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 02:24:35 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [PATCH bpf-next v3 10/16] udp6: Run SK_LOOKUP BPF program on socket lookup
Date:   Thu,  2 Jul 2020 11:24:10 +0200
Message-Id: <20200702092416.11961-11-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702092416.11961-1-jakub@cloudflare.com>
References: <20200702092416.11961-1-jakub@cloudflare.com>
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
    v3:
    - Use a static_key to minimize the hook overhead when not used. (Alexei)
    - Adapt for running an array of attached programs. (Alexei)
    - Adapt for optionally skipping reuseport selection. (Martin)

 net/ipv6/udp.c | 60 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 65b843e7acde..c4338cfe7a8c 100644
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
+	bool do_reuseport;
+
+	if (udptable != &udp_table)
+		return NULL; /* only UDP is supported */
+
+	do_reuseport = bpf_sk_lookup_run_v6(net, IPPROTO_UDP,
+					    saddr, sport, daddr, hnum, &sk);
+	if (do_reuseport) {
+		reuse_sk = lookup_reuseport(net, sk, skb,
+					    saddr, sport, daddr, hnum);
+		if (reuse_sk)
+			sk = reuse_sk;
+	}
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

