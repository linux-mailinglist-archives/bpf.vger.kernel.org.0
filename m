Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80930211FC4
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgGBJYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGBJYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 05:24:34 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01BC08C5DC
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 02:24:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e22so22860060edq.8
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGjtMtRZoUSNqJptItw87hhXT8ibCTYEznJMwbsQq/g=;
        b=xAxCWfILjqrpUN7ZckPc11Mx/2WMpaf6Y2dNk7Lt/EKIGtsX0I2oZnPB8hQk6UxcpK
         9Fy0tbEAdp459p1n8d7jF3OfW7En70lCyXFlVBUXDLQq/+2HrKayfbWMlheR1WzrJx0V
         +ruxkYusCQTRT3zyPlccPZdVgAWM0MxFinmHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGjtMtRZoUSNqJptItw87hhXT8ibCTYEznJMwbsQq/g=;
        b=VotitTGpfgIHDMgFNwqMgys4RVLfd7Fe5XdgtZdgMrRGZeXhCPHsYGo9a5DcVzbyaw
         BOz+hcofGWOIvJrOd1iD9oXnAeRUTPDKW17KrO0BtKaKFZY9QdyKtygOhsWnjRqxV7sH
         +hfk7NuN6SNjpP518aeN5zinAghOYsGbXUWa3+gr3cJdPxvcjPeIypnsZiiwCYzRkp7S
         SbkFQgG3zbtlmtVK2Papi2mDv/WfxzJ+rzLqf81JE0AMP/BITIqVSSCUx+edwalOA2Em
         92lpWk1MixDSW5td4e5XUmyu57Bb4GIEsliW/zNBTw8oI+4MuxfPDoh7080no3yw1woN
         7sbA==
X-Gm-Message-State: AOAM531gi14++8qCr2bxmm6MKoU0Kr0ku6cDPN+YkSwrsP1Em7dleeIg
        H22En0mjJ2efYD+kQFf0XYzw5GpdmmUC6A==
X-Google-Smtp-Source: ABdhPJx1j8fq0x65QnrOyr+sY3IUavODoQxLhqIJQL0Ne6AVZd6lK9PtSBjhyUoDEjYriAkErY0tGQ==
X-Received: by 2002:a05:6402:3113:: with SMTP id dc19mr32548877edb.20.1593681872550;
        Thu, 02 Jul 2020 02:24:32 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id v11sm6306081eja.113.2020.07.02.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 02:24:32 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [PATCH bpf-next v3 08/16] udp: Run SK_LOOKUP BPF program on socket lookup
Date:   Thu,  2 Jul 2020 11:24:08 +0200
Message-Id: <20200702092416.11961-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702092416.11961-1-jakub@cloudflare.com>
References: <20200702092416.11961-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following INET/TCP socket lookup changes, modify UDP socket lookup to let
BPF program select a receiving socket before searching for a socket by
destination address and port as usual.

Lookup of connected sockets that match packet 4-tuple is unaffected by this
change. BPF program runs, and potentially overrides the lookup result, only
if a 4-tuple match was not found.

Suggested-by: Marek Majkowski <marek@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v3:
    - Use a static_key to minimize the hook overhead when not used. (Alexei)
    - Adapt for running an array of attached programs. (Alexei)
    - Adapt for optionally skipping reuseport selection. (Martin)

 net/ipv4/udp.c | 59 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0d03e0277263..c8f88b113f82 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -456,6 +456,29 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 	return result;
 }
 
+static inline struct sock *udp4_lookup_run_bpf(struct net *net,
+					       struct udp_table *udptable,
+					       struct sk_buff *skb,
+					       __be32 saddr, __be16 sport,
+					       __be32 daddr, u16 hnum)
+{
+	struct sock *sk, *reuse_sk;
+	bool do_reuseport;
+
+	if (udptable != &udp_table)
+		return NULL; /* only UDP is supported */
+
+	do_reuseport = bpf_sk_lookup_run_v4(net, IPPROTO_UDP,
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
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
  * harder than this. -DaveM
  */
@@ -463,27 +486,45 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
 		__be16 sport, __be32 daddr, __be16 dport, int dif,
 		int sdif, struct udp_table *udptable, struct sk_buff *skb)
 {
-	struct sock *result;
 	unsigned short hnum = ntohs(dport);
 	unsigned int hash2, slot2;
 	struct udp_hslot *hslot2;
+	struct sock *result, *sk;
 
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	slot2 = hash2 & udptable->mask;
 	hslot2 = &udptable->hash2[slot2];
 
+	/* Lookup connected or non-wildcard socket */
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
 				  hslot2, skb);
-	if (!result) {
-		hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
-		slot2 = hash2 & udptable->mask;
-		hslot2 = &udptable->hash2[slot2];
-
-		result = udp4_lib_lookup2(net, saddr, sport,
-					  htonl(INADDR_ANY), hnum, dif, sdif,
-					  hslot2, skb);
+	if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
+		goto done;
+
+	/* Lookup redirect from BPF */
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
+		sk = udp4_lookup_run_bpf(net, udptable, skb,
+					 saddr, sport, daddr, hnum);
+		if (sk) {
+			result = sk;
+			goto done;
+		}
 	}
+
+	/* Got non-wildcard socket or error on first lookup */
+	if (result)
+		goto done;
+
+	/* Lookup wildcard sockets */
+	hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
+	slot2 = hash2 & udptable->mask;
+	hslot2 = &udptable->hash2[slot2];
+
+	result = udp4_lib_lookup2(net, saddr, sport,
+				  htonl(INADDR_ANY), hnum, dif, sdif,
+				  hslot2, skb);
+done:
 	if (IS_ERR(result))
 		return NULL;
 	return result;
-- 
2.25.4

