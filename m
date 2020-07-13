Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89721DF01
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgGMRrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbgGMRrD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 13:47:03 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE6AC061794
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so9600668lfe.9
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDSEEbaluBZs+0tECJKbkPZc+3U6GYzy2UWo7TMx4PQ=;
        b=LXhwG2Ana8/kJY+LED0FuwqzhBaLI5+UE19TVBMjlpjp33lylKcgcw7e1tCm3DQS3R
         XaMWDl0XAvahKKP/DUAKFxb/Ez/cIjRpkDBBXtcYC21XlLRnPB7fJZS42HNNQEgXaf/q
         rPyc5a813qGJ6VEPTkfrBdrR83VMXwJb0pxzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDSEEbaluBZs+0tECJKbkPZc+3U6GYzy2UWo7TMx4PQ=;
        b=nr43s5b5zcv+y6TUEV8fda/i5fzKCZ4KpZeefN8dCw46qx8b8Y03OTgEK/OPubwwnl
         2BgY4v+apFpBcQ9TeaYkn9+98aOsr7YAH/lsNOvQUhUtM+bo2hl189wUCjcQKb+t7nUA
         aZY5SJAISl++Z5mMU91yRhk/a9R6jkh+/+vZI3fOsz7xcxmW+JI24uzHjL858pwf3GrW
         BohEzGY6Hpzo9/AjFAZrZpIJJGlQf3mVnXw6dVcbu7CkhUTg/JkS1pVl1Fyf2XrcfG45
         A5JXtnRRBX+RPVMIkt867DUzmmG59RbgQyQMhf+UJhYLLKydFPABdfUIZTwez/69YJld
         RStw==
X-Gm-Message-State: AOAM530b96PeSue2o/gtRWdjsrJqqIQo+uWgO4mqSYKJD7tAxwsSGGic
        aqXuxZ9CeUt7YEI/2WraHj+KsN4w3EHnvA==
X-Google-Smtp-Source: ABdhPJytKuI10VUN5tx6g67NHROdnxuFoPpXxDYHGu+GqkdsG0zOStJQNKfZ1eHGJXHGQEit/WlQ5w==
X-Received: by 2002:a19:c886:: with SMTP id y128mr170168lff.98.1594662421680;
        Mon, 13 Jul 2020 10:47:01 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id b11sm4736057lfa.50.2020.07.13.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:47:01 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v4 03/16] inet: Extract helper for selecting socket from reuseport group
Date:   Mon, 13 Jul 2020 19:46:41 +0200
Message-Id: <20200713174654.642628-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713174654.642628-1-jakub@cloudflare.com>
References: <20200713174654.642628-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for calling into reuseport from __inet_lookup_listener as well.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/inet_hashtables.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 2bbaaf0c7176..ab64834837c8 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -246,6 +246,21 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
+					    struct sk_buff *skb, int doff,
+					    __be32 saddr, __be16 sport,
+					    __be32 daddr, unsigned short hnum)
+{
+	struct sock *reuse_sk = NULL;
+	u32 phash;
+
+	if (sk->sk_reuseport) {
+		phash = inet_ehashfn(net, daddr, hnum, saddr, sport);
+		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
+	}
+	return reuse_sk;
+}
+
 /*
  * Here are some nice properties to exploit here. The BSD API
  * does not allow a listening sock to specify the remote port nor the
@@ -265,21 +280,17 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 	struct inet_connection_sock *icsk;
 	struct sock *sk, *result = NULL;
 	int score, hiscore = 0;
-	u32 phash = 0;
 
 	inet_lhash2_for_each_icsk_rcu(icsk, &ilb2->head) {
 		sk = (struct sock *)icsk;
 		score = compute_score(sk, net, hnum, daddr,
 				      dif, sdif, exact_dif);
 		if (score > hiscore) {
-			if (sk->sk_reuseport) {
-				phash = inet_ehashfn(net, daddr, hnum,
-						     saddr, sport);
-				result = reuseport_select_sock(sk, phash,
-							       skb, doff);
-				if (result)
-					return result;
-			}
+			result = lookup_reuseport(net, sk, skb, doff,
+						  saddr, sport, daddr, hnum);
+			if (result)
+				return result;
+
 			result = sk;
 			hiscore = score;
 		}
-- 
2.25.4

