Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECB916C2E1
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 14:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgBYN4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 08:56:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36921 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgBYN4o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 08:56:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so3245762wme.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1l3ad/jyN4Df3AeGsUOqno7cqBsAfUEwYTf8KTkCXE0=;
        b=bTWWed710QEJeE/XIjd9StabwkGR7Kwf/L5VgOQfDsKk5pvpsUQX6lMFE4oqK3cllO
         31SWFnVt5XbedmVDMpAuFspAYY4AgLGv8e9nLQXmGJfnu2+xni8MOqTntPiXB5f6GdwJ
         gVjJvKheesdBAAggEoubJWHj6pi36eBctGtXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1l3ad/jyN4Df3AeGsUOqno7cqBsAfUEwYTf8KTkCXE0=;
        b=S3juurZ+KTYYYMcIFd9E6rqOU8oJHV1zjw+yrO8E3kt40TopAQrflH54p1UPi0nipB
         opYjONFd+SurZ9tjcN/h5ue5dO26ooO7qQF+BT9Rp84bY9I2olhCgSzo/hc0Isxijiqe
         HuvSkkiKeBqeaQVZSLwY49Yiy0MghnducHz01pHMNf1I1XR0v6gNNQK9ioaEf5xlabPD
         xsIebvLclYEWUponZ89RWLc9Ug088vs3xPAojXjnNuL3eFWTHWT9fmglxHOSy6hxpO5x
         SnooyXQqjQPPZFc5g8t+dYG6r1aGfKszhK4ONL6nlEraZ7MGHhzOH3gU3um0Mjghjk+W
         uxdA==
X-Gm-Message-State: APjAAAXIdBmUrr+1kcLkw3/Yvj9eYz81V25F+TG5swwrJiq3RFjgZwcE
        fytKn9DxkyFkK5n3RrwXV4V6D/JzG1tGkA==
X-Google-Smtp-Source: APXvYqxSyOXKEpIxFtldnNXgJf/lPkF5tOmtky3OIcKKiLi3A/kGmApdP0nyUXlfBnFkZQ5jNdm1bQ==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr5275392wmh.108.1582639002429;
        Tue, 25 Feb 2020 05:56:42 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8800:3dea:15ba:1870:8e94])
        by smtp.gmail.com with ESMTPSA id t128sm4463580wmf.28.2020.02.25.05.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 05:56:41 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 2/7] bpf: sockmap: move generic sockmap hooks from BPF TCP
Date:   Tue, 25 Feb 2020 13:56:31 +0000
Message-Id: <20200225135636.5768-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225135636.5768-1-lmb@cloudflare.com>
References: <20200225135636.5768-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The close, unhash and clone handlers from TCP sockmap are actually generic,
and can be reused by UDP sockmap. Move the helpers into the sockmap code base
and expose them.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h   |  4 ++-
 include/linux/skmsg.h | 28 ----------------
 net/core/sock_map.c   | 77 +++++++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_bpf.c    | 55 ++-----------------------------
 4 files changed, 79 insertions(+), 85 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 49b1a70e12c8..8422ab6a63d8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1355,6 +1355,8 @@ static inline void bpf_map_offload_map_free(struct bpf_map *map)
 #if defined(CONFIG_BPF_STREAM_PARSER)
 int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog, u32 which);
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
+void sock_map_unhash(struct sock *sk);
+void sock_map_close(struct sock *sk, long timeout);
 #else
 static inline int sock_map_prog_update(struct bpf_map *map,
 				       struct bpf_prog *prog, u32 which)
@@ -1367,7 +1369,7 @@ static inline int sock_map_get_from_fd(const union bpf_attr *attr,
 {
 	return -EINVAL;
 }
-#endif
+#endif /* CONFIG_BPF_STREAM_PARSER */
 
 #if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
 void bpf_sk_reuseport_detach(struct sock *sk);
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 54a9a3e36b29..c881094387db 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -323,14 +323,6 @@ static inline void sk_psock_free_link(struct sk_psock_link *link)
 }
 
 struct sk_psock_link *sk_psock_link_pop(struct sk_psock *psock);
-#if defined(CONFIG_BPF_STREAM_PARSER)
-void sk_psock_unlink(struct sock *sk, struct sk_psock_link *link);
-#else
-static inline void sk_psock_unlink(struct sock *sk,
-				   struct sk_psock_link *link)
-{
-}
-#endif
 
 void __sk_psock_purge_ingress_msg(struct sk_psock *psock);
 
@@ -387,26 +379,6 @@ static inline bool sk_psock_test_state(const struct sk_psock *psock,
 	return test_bit(bit, &psock->state);
 }
 
-static inline struct sk_psock *sk_psock_get_checked(struct sock *sk)
-{
-	struct sk_psock *psock;
-
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (psock) {
-		if (sk->sk_prot->recvmsg != tcp_bpf_recvmsg) {
-			psock = ERR_PTR(-EBUSY);
-			goto out;
-		}
-
-		if (!refcount_inc_not_zero(&psock->refcnt))
-			psock = ERR_PTR(-EBUSY);
-	}
-out:
-	rcu_read_unlock();
-	return psock;
-}
-
 static inline struct sk_psock *sk_psock_get(struct sock *sk)
 {
 	struct sk_psock *psock;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 695ecacc7afa..459b3ba16023 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -146,6 +146,26 @@ static void sock_map_unref(struct sock *sk, void *link_raw)
 	}
 }
 
+static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
+{
+	struct sk_psock *psock;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (psock) {
+		if (sk->sk_prot->recvmsg != tcp_bpf_recvmsg) {
+			psock = ERR_PTR(-EBUSY);
+			goto out;
+		}
+
+		if (!refcount_inc_not_zero(&psock->refcnt))
+			psock = ERR_PTR(-EBUSY);
+	}
+out:
+	rcu_read_unlock();
+	return psock;
+}
+
 static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 			 struct sock *sk)
 {
@@ -177,7 +197,7 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 		}
 	}
 
-	psock = sk_psock_get_checked(sk);
+	psock = sock_map_psock_get_checked(sk);
 	if (IS_ERR(psock)) {
 		ret = PTR_ERR(psock);
 		goto out_progs;
@@ -240,7 +260,7 @@ static int sock_map_link_no_progs(struct bpf_map *map, struct sock *sk)
 	struct sk_psock *psock;
 	int ret;
 
-	psock = sk_psock_get_checked(sk);
+	psock = sock_map_psock_get_checked(sk);
 	if (IS_ERR(psock))
 		return PTR_ERR(psock);
 
@@ -1132,7 +1152,7 @@ int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	return 0;
 }
 
-void sk_psock_unlink(struct sock *sk, struct sk_psock_link *link)
+static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
 {
 	switch (link->map->map_type) {
 	case BPF_MAP_TYPE_SOCKMAP:
@@ -1145,3 +1165,54 @@ void sk_psock_unlink(struct sock *sk, struct sk_psock_link *link)
 		break;
 	}
 }
+
+static void sock_map_remove_links(struct sock *sk, struct sk_psock *psock)
+{
+	struct sk_psock_link *link;
+
+	while ((link = sk_psock_link_pop(psock))) {
+		sock_map_unlink(sk, link);
+		sk_psock_free_link(link);
+	}
+}
+
+void sock_map_unhash(struct sock *sk)
+{
+	void (*saved_unhash)(struct sock *sk);
+	struct sk_psock *psock;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (unlikely(!psock)) {
+		rcu_read_unlock();
+		if (sk->sk_prot->unhash)
+			sk->sk_prot->unhash(sk);
+		return;
+	}
+
+	saved_unhash = psock->saved_unhash;
+	sock_map_remove_links(sk, psock);
+	rcu_read_unlock();
+	saved_unhash(sk);
+}
+
+void sock_map_close(struct sock *sk, long timeout)
+{
+	void (*saved_close)(struct sock *sk, long timeout);
+	struct sk_psock *psock;
+
+	lock_sock(sk);
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (unlikely(!psock)) {
+		rcu_read_unlock();
+		release_sock(sk);
+		return sk->sk_prot->close(sk, timeout);
+	}
+
+	saved_close = psock->saved_close;
+	sock_map_remove_links(sk, psock);
+	rcu_read_unlock();
+	release_sock(sk);
+	saved_close(sk, timeout);
+}
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 7d6e1b75d4d4..90955c96a9a8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -528,57 +528,6 @@ static int tcp_bpf_sendpage(struct sock *sk, struct page *page, int offset,
 	return copied ? copied : err;
 }
 
-static void tcp_bpf_remove(struct sock *sk, struct sk_psock *psock)
-{
-	struct sk_psock_link *link;
-
-	while ((link = sk_psock_link_pop(psock))) {
-		sk_psock_unlink(sk, link);
-		sk_psock_free_link(link);
-	}
-}
-
-static void tcp_bpf_unhash(struct sock *sk)
-{
-	void (*saved_unhash)(struct sock *sk);
-	struct sk_psock *psock;
-
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (unlikely(!psock)) {
-		rcu_read_unlock();
-		if (sk->sk_prot->unhash)
-			sk->sk_prot->unhash(sk);
-		return;
-	}
-
-	saved_unhash = psock->saved_unhash;
-	tcp_bpf_remove(sk, psock);
-	rcu_read_unlock();
-	saved_unhash(sk);
-}
-
-static void tcp_bpf_close(struct sock *sk, long timeout)
-{
-	void (*saved_close)(struct sock *sk, long timeout);
-	struct sk_psock *psock;
-
-	lock_sock(sk);
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (unlikely(!psock)) {
-		rcu_read_unlock();
-		release_sock(sk);
-		return sk->sk_prot->close(sk, timeout);
-	}
-
-	saved_close = psock->saved_close;
-	tcp_bpf_remove(sk, psock);
-	rcu_read_unlock();
-	release_sock(sk);
-	saved_close(sk, timeout);
-}
-
 enum {
 	TCP_BPF_IPV4,
 	TCP_BPF_IPV6,
@@ -599,8 +548,8 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 				   struct proto *base)
 {
 	prot[TCP_BPF_BASE]			= *base;
-	prot[TCP_BPF_BASE].unhash		= tcp_bpf_unhash;
-	prot[TCP_BPF_BASE].close		= tcp_bpf_close;
+	prot[TCP_BPF_BASE].unhash		= sock_map_unhash;
+	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
 	prot[TCP_BPF_BASE].stream_memory_read	= tcp_bpf_stream_read;
 
-- 
2.20.1

