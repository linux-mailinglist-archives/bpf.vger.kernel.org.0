Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC09FB83
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 09:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1HXK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 03:23:10 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44839 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfH1HXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 03:23:09 -0400
Received: by mail-lj1-f180.google.com with SMTP id e24so1576172ljg.11
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHgvfVC1U/7DlItOuwqPgoPx/xxqHmQYB5wrJeGRtiI=;
        b=X9lpk9rkCYruKaEHcwMFxgS4DGe2S+luCkFihWcYC9Qg9CdmjijalshjAfmf2thYjk
         Q7/ZActUENPjHlpYMD+gZ6Zgel9yHAvqRb0KQjzx7OGZG1iH2+w4h7YUglDKo6dU9bWE
         XcfwjwnX5NBfqxLSghu+9JDc25zTB+2vF6+hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHgvfVC1U/7DlItOuwqPgoPx/xxqHmQYB5wrJeGRtiI=;
        b=M1GF5AJJ5LkMzNwA9Rl/bd40QGY3PN83f9qoGTINbfZtYup3N2rUT+/WWXxVpJ6sK0
         yQI08M+7h+LLPiNn7Via02QALfcJeA2Eq7sCy8rkjqd0C/i1mNY710Lt8mU0wck0pSkp
         cObm87+29lWO/WOVqHR/MGFm3dpHGLPMuPfmIwayoSRF/HSTcBZKRZ8PU/R7fN8eWqdm
         KjQJB7UCazesdeOFdPDzC15rCsLYjhGrV4RE5WwL1boIpdmyU0hpTRFgjVfQMhTq8cNQ
         BFdPUIOOKnZpYweiB2HqlG3CE/6SypNBbf5RDkpJ/33gxmDOXKO6C4ElKIifM0WJATZ5
         Iyug==
X-Gm-Message-State: APjAAAV+PxTjd2fg0WMjHlZYagiDyi6fBNtO68N8fGw7a0HvQCHWDMhO
        j8ICqqTUx0ZTTDldFpftwWutqZzuLy9szw==
X-Google-Smtp-Source: APXvYqya0lCSDUrxeFaZ9PdNLYXc7NjB0miRgLZtQ69EotIP5LcBpJezpcR+3w+guP00Pkbrtzxg+g==
X-Received: by 2002:a2e:9b02:: with SMTP id u2mr1190072lji.219.1566976986901;
        Wed, 28 Aug 2019 00:23:06 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id b21sm586231lff.11.2019.08.28.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:23:06 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [RFCv2 bpf-next 08/12] udp: Run inet_lookup bpf program on socket lookup
Date:   Wed, 28 Aug 2019 09:22:46 +0200
Message-Id: <20190828072250.29828-9-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828072250.29828-1-jakub@cloudflare.com>
References: <20190828072250.29828-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following the TCP socket lookup changes, allow selecting the receiving
socket from BPF before searching for bound socket by destination address
and port.

As connected and bound but non-connected socket lookup currently happens in
one step, we split the lookup in two phases to run BPF only after a lookup
for a connected socket was a miss. Hence making sure connected UDP sockets
continue to work as expected in presence of a BPF inet_lookup program.

Suggested-by: Marek Majkowski <marek@cloudflare.com>
Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9fffe9e9eec6..3a4b98f89249 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -353,7 +353,7 @@ int udp_v4_get_port(struct sock *sk, unsigned short snum)
 static int compute_score(struct sock *sk, struct net *net,
 			 __be32 saddr, __be16 sport,
 			 __be32 daddr, unsigned short hnum,
-			 int dif, int sdif)
+			 int dif, int sdif, unsigned char state)
 {
 	int score;
 	struct inet_sock *inet;
@@ -364,6 +364,9 @@ static int compute_score(struct sock *sk, struct net *net,
 	    ipv6_only_sock(sk))
 		return -1;
 
+	if (state && sk->sk_state != state)
+		return -1;
+
 	if (sk->sk_rcv_saddr != daddr)
 		return -1;
 
@@ -411,7 +414,8 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 				     __be32 daddr, unsigned int hnum,
 				     int dif, int sdif,
 				     struct udp_hslot *hslot2,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb,
+				     unsigned char state)
 {
 	struct sock *sk, *result;
 	int score, badness;
@@ -421,7 +425,7 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 	badness = 0;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
 		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+				      daddr, hnum, dif, sdif, state);
 		if (score > badness) {
 			if (sk->sk_reuseport) {
 				hash = udp_ehashfn(net, daddr, hnum,
@@ -454,18 +458,34 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr,
 	slot2 = hash2 & udptable->mask;
 	hslot2 = &udptable->hash2[slot2];
 
+	/* Lookup connected sockets */
 	result = udp4_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
-				  hslot2, skb);
-	if (!result) {
-		hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
-		slot2 = hash2 & udptable->mask;
-		hslot2 = &udptable->hash2[slot2];
+				  hslot2, skb, TCP_ESTABLISHED);
+	if (result)
+		goto done;
 
-		result = udp4_lib_lookup2(net, saddr, sport,
-					  htonl(INADDR_ANY), hnum, dif, sdif,
-					  hslot2, skb);
-	}
+	/* Lookup redirect from BPF */
+	result = inet_lookup_run_bpf(net, udptable->protocol,
+				     saddr, sport, daddr, hnum);
+	if (result)
+		goto done;
+
+	/* Lookup bound sockets */
+	result = udp4_lib_lookup2(net, saddr, sport,
+				  daddr, hnum, dif, sdif,
+				  hslot2, skb, 0);
+	if (result)
+		goto done;
+
+	hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
+	slot2 = hash2 & udptable->mask;
+	hslot2 = &udptable->hash2[slot2];
+
+	result = udp4_lib_lookup2(net, saddr, sport,
+				  htonl(INADDR_ANY), hnum, dif, sdif,
+				  hslot2, skb, 0);
+done:
 	if (IS_ERR(result))
 		return NULL;
 	return result;
-- 
2.20.1

