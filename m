Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE3211FC2
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGBJYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgGBJYc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 05:24:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA89C08C5DE
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 02:24:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so28467008ejj.5
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWS55m6tjKFIXvF8FfZLoHa8RJokM3hk5iam/MiuzJ0=;
        b=Q8umSu7cmwPd6jEFw6ZnIhcJ38auitt9WijRWXZrfF+h09UuIrUzgyz1xuxryDNMMB
         hAKBz2izLJXjWVUovgM9BGZyA8lgivW3cGC5Xi8jdYlWUxiBsAHPA6a9BeC/qV33Lvtx
         rofm9imkTA5L47Q6T1NQxiL17Fs0fszeA074g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWS55m6tjKFIXvF8FfZLoHa8RJokM3hk5iam/MiuzJ0=;
        b=A21HEx6pXwE42YUR3WyVyeb8hBSBUnrGvBFFIZMIty/ooi1bDZqyQHb1jPAxWuIddJ
         cZK+L3d1Wf3N+qvNBXqPgGxp5/bNU/W5WAS4L6Kz2ZgUYygn6G/CjuaBiwxVgMPHgywx
         nGsJEPeURQ4ErcDCmf8tRfY+MCWCp1EzqwLOwhLTA9nRa9ZTrfB8igL4HMV9z0A+dzJv
         7S3cwVfh5Js1NkRaszNE8G7MqWIdR8gsl+EuvJxweGqPnGIbfn5EFxfV6yMC+FaX+cil
         iUven4weWHsgoyaP5ZvkESGZYTR9UgEcqRT2VXGewCY7/9LkUCb22o57q6rIZP7iyI6V
         dr8A==
X-Gm-Message-State: AOAM532zK6ci9JLIVb5FIeE4bt8ajiyBrl91i36fqVAj7CXwIGOz6ddj
        lDPGUlwVeJzXvChu00KaJutRLZcUrWQz5w==
X-Google-Smtp-Source: ABdhPJyiglgLFJjLuWkYzTFXXoiRW5v70w8qmarTgG7PsUsuJky7UxZWkebxgbLepMrbI1nDE+nwNA==
X-Received: by 2002:a17:906:dbcf:: with SMTP id yc15mr17411999ejb.222.1593681870819;
        Thu, 02 Jul 2020 02:24:30 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a2sm5947246edt.48.2020.07.02.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 02:24:30 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v3 07/16] udp: Extract helper for selecting socket from reuseport group
Date:   Thu,  2 Jul 2020 11:24:07 +0200
Message-Id: <20200702092416.11961-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702092416.11961-1-jakub@cloudflare.com>
References: <20200702092416.11961-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for calling into reuseport from __udp4_lib_lookup as well.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 31530129f137..0d03e0277263 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -408,6 +408,25 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
+static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
+					    struct sk_buff *skb,
+					    __be32 saddr, __be16 sport,
+					    __be32 daddr, unsigned short hnum)
+{
+	struct sock *reuse_sk = NULL;
+	u32 hash;
+
+	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
+		hash = udp_ehashfn(net, daddr, hnum, saddr, sport);
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
 static struct sock *udp4_lib_lookup2(struct net *net,
 				     __be32 saddr, __be16 sport,
@@ -418,7 +437,6 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
-	u32 hash = 0;
 
 	result = NULL;
 	badness = 0;
@@ -426,15 +444,11 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			if (sk->sk_reuseport &&
-			    sk->sk_state != TCP_ESTABLISHED) {
-				hash = udp_ehashfn(net, daddr, hnum,
-						   saddr, sport);
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
 			badness = score;
 			result = sk;
 		}
-- 
2.25.4

