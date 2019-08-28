Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB069FB7F
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfH1HXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 03:23:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35938 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfH1HXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 03:23:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id r5so1246344lfc.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 00:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUOQ5oa1ZHxkv7QVhvg7zNwIQm1dIN9rUB7dlg1DwGU=;
        b=aqGvTP9fAIyReK8/fPYCFrDrtPsWF2xlKWNBmrCXzGsK+uRSv6lXRYCnbAsLKhnZRu
         bApNJexfTCTD7qWgpHnGRBrDo3WvoQQHhXBejHeVUU9O9F53OS5OjBN7TpYH8sfxIVrU
         KaaJTTW+GqRnU9YWif+t70Z9pEYpHA+2jz70k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUOQ5oa1ZHxkv7QVhvg7zNwIQm1dIN9rUB7dlg1DwGU=;
        b=DznQPTlSSdmmgQpPCFTvW4st3LsBgxtpCwvHCHKENEchtJg4YL1sgA2IEfxYMXk7Pb
         LlRaQ3XOP69xalkDpTw82R4dfEg1Gf3TLrM4J8Szdz0O162ilmm246bwhhNYfKrq8Csx
         1qXF6SFDknz1SxCcN67taI82ZM6C9Rs1B6P8EOSO17LPDGgqNWvudoA5EbCAhoMCCpGg
         t4Nf7d4lrtyrKzxXzfXejYjcOB3BX+rQ+Qm7QXEtaEO6I+ml3mAVmn1F2qkLCo6Idk48
         vBhMy4xSDiFnBEcw+aldptbQHR+wlfm21u6T1IACLJEHj/pPEDLePlNNhTurRfAkelSQ
         snSA==
X-Gm-Message-State: APjAAAVpZ4I9/QFl3w7I+twz8G8lWOqJ+68ph5m/QJ9LUjcmXXZnn5Hz
        g6I6pEMMZbyQq81JrZby30ZtOSkFEIi7TA==
X-Google-Smtp-Source: APXvYqwlE+EtT2/p7367j86OfDaPYOt8ajL8OKE5nB8hwq3maKuNvxpyFZxyGnKn3Y1cISSrgY6FZw==
X-Received: by 2002:ac2:5df7:: with SMTP id z23mr875407lfq.105.1566976983387;
        Wed, 28 Aug 2019 00:23:03 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id t2sm486554lfl.33.2019.08.28.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:23:02 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [RFCv2 bpf-next 06/12] inet: Run inet_lookup bpf program on socket lookup
Date:   Wed, 28 Aug 2019 09:22:44 +0200
Message-Id: <20190828072250.29828-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828072250.29828-1-jakub@cloudflare.com>
References: <20190828072250.29828-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Run a BPF program before looking up the listening socket. The program can
redirect the skb to a listening socket of its choice, providing it calls
bpf_redirect_lookup() helper and returns BPF_REDIRECT.

This lets the user-space program mappings between packet 4-tuple and
listening sockets. With the possibility to override the socket lookup from
BPF, applications don't need to bind sockets to every addresses they
receive on, or resort to listening on all addresses with INADDR_ANY.

Also port sharing conflicts become a non-issue. Application can listen on
any free port and still receive traffic destined to its assigned service
port.

Suggested-by: Marek Majkowski <marek@cloudflare.com>
Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/inet_hashtables.h | 33 +++++++++++++++++++++++++++++++++
 net/ipv4/inet_hashtables.c    |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index b2d43ee72dc1..c9c7efb961cb 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -417,4 +417,37 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 int inet_hash_connect(struct inet_timewait_death_row *death_row,
 		      struct sock *sk);
+
+static inline struct sock *__inet_lookup_run_bpf(const struct net *net,
+						 struct bpf_inet_lookup_kern *ctx)
+{
+	struct bpf_prog *prog;
+	int ret = BPF_OK;
+
+	rcu_read_lock();
+	prog = rcu_dereference(net->inet_lookup_prog);
+	if (prog)
+		ret = BPF_PROG_RUN(prog, ctx);
+	rcu_read_unlock();
+
+	return ret == BPF_REDIRECT ? ctx->redir_sk : NULL;
+}
+
+static inline struct sock *inet_lookup_run_bpf(const struct net *net, u8 proto,
+					       __be32 saddr, __be16 sport,
+					       __be32 daddr,
+					       unsigned short hnum)
+{
+	struct bpf_inet_lookup_kern ctx = {
+		.family		= AF_INET,
+		.protocol	= proto,
+		.saddr		= saddr,
+		.sport		= sport,
+		.daddr		= daddr,
+		.hnum		= hnum,
+	};
+
+	return __inet_lookup_run_bpf(net, &ctx);
+}
+
 #endif /* _INET_HASHTABLES_H */
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 97824864e40d..ab6d89c27c94 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -299,6 +299,11 @@ struct sock *__inet_lookup_listener(struct net *net,
 	struct sock *result = NULL;
 	unsigned int hash2;
 
+	result = inet_lookup_run_bpf(net, hashinfo->protocol,
+				     saddr, sport, daddr, hnum);
+	if (result)
+		goto done;
+
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
-- 
2.20.1

