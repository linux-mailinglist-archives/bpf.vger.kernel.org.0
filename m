Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB818055C
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 18:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCJRro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 13:47:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44981 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgCJRre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id l18so6941823wru.11
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhoHurRJpXCe6JuLpPX2VzUmWh/fngf5qonhzaAJqZ0=;
        b=tzN1vBaEsCKdVw/bKo57nPjBO7RbHbgPHCF5FBWpYvSmzzdAgUhInphA8rELnFsYs/
         4x8qxivOOpWCnf00Tdxk1Y2uMVe/tg9O6bjwohK/VohtUig4mUI0+r0hMUBUp7Dt+Eqs
         jr4XjOp/ctCv4hmnNXBw/EqEtaI7JSxIF0iBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhoHurRJpXCe6JuLpPX2VzUmWh/fngf5qonhzaAJqZ0=;
        b=Az2LsxIT/g1qPvTGgeQ0MZCWLxg3SLFbn+fM2o6EfptjFbmyjQNJQi+7YqaQrToi7F
         2+7CEgg8AWh1u0aQJdv6BmRcSLClqncQDgXgIBNqNdQPZSCtCcM1yP/beqWzm0H+OG7e
         2Yzd89IAFI47VZlGVUpqk2Z0IxIYNS6s++NlxcRpS81i/GJxQEoZoH9NpUNGd6xOAvEh
         V1XyMikJ3HjoOxHrKudvLEl9bL9NMG6TcvA/iLA1ofT1Ma4vC3JCiLsw4qK243M0Ff4H
         JDKNvYXYSgmpsl7NUx3jqbTLsearNR/HhnribuoKXJAYj6A/OrZKCLS1zeuasGVq/9zz
         JLHw==
X-Gm-Message-State: ANhLgQ3YSijE0Ga4GYvPE3CgG6nTTx9xrgUPRO329FM9PWCfVaZuYERD
        LGn/ICQH0Im+MsFy4r4YtjIilA==
X-Google-Smtp-Source: ADFU+vv6iU7EpC0gfT6FwUOzsELNAzfDmLq39QsHecrEKk2xYWIbT1ayPDCO41hfl+hzeXcOvowH5Q==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr21328457wrr.396.1583862452605;
        Tue, 10 Mar 2020 10:47:32 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:9494:775c:e7b6:e690])
        by smtp.gmail.com with ESMTPSA id k4sm9118691wrx.27.2020.03.10.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:47:31 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] bpf: convert sock map and hash to map_copy_value
Date:   Tue, 10 Mar 2020 17:47:09 +0000
Message-Id: <20200310174711.7490-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310174711.7490-1-lmb@cloudflare.com>
References: <20200310174711.7490-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Migrate sockmap and sockhash to use map_copy_value instead of
map_lookup_elem_sys_only.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 48 ++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index a7075b3b4489..03e04426cd21 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -344,19 +344,34 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
 	return __sock_map_lookup_elem(map, *(u32 *)key);
 }
 
-static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
+static int __sock_map_copy_value(struct bpf_map *map, struct sock *sk,
+				 void *value)
+{
+	switch (map->value_size) {
+	case sizeof(u64):
+		sock_gen_cookie(sk);
+		*(u64 *)value = atomic64_read(&sk->sk_cookie);
+		return 0;
+
+	default:
+		return -ENOSPC;
+	}
+}
+
+static int sock_map_copy_value(struct bpf_map *map, void *key, void *value)
 {
 	struct sock *sk;
+	int ret = -ENOENT;
 
-	if (map->value_size != sizeof(u64))
-		return ERR_PTR(-ENOSPC);
-
+	rcu_read_lock();
 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
 	if (!sk)
-		return ERR_PTR(-ENOENT);
+		goto out;
 
-	sock_gen_cookie(sk);
-	return &sk->sk_cookie;
+	ret = __sock_map_copy_value(map, sk, value);
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
@@ -636,7 +651,7 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_alloc		= sock_map_alloc,
 	.map_free		= sock_map_free,
 	.map_get_next_key	= sock_map_get_next_key,
-	.map_lookup_elem_sys_only = sock_map_lookup_sys,
+	.map_copy_value		= sock_map_copy_value,
 	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_map_delete_elem,
 	.map_lookup_elem	= sock_map_lookup,
@@ -1030,19 +1045,20 @@ static void sock_hash_free(struct bpf_map *map)
 	kfree(htab);
 }
 
-static void *sock_hash_lookup_sys(struct bpf_map *map, void *key)
+static int sock_hash_copy_value(struct bpf_map *map, void *key, void *value)
 {
 	struct sock *sk;
+	int ret = -ENOENT;
 
-	if (map->value_size != sizeof(u64))
-		return ERR_PTR(-ENOSPC);
-
+	rcu_read_lock();
 	sk = __sock_hash_lookup_elem(map, key);
 	if (!sk)
-		return ERR_PTR(-ENOENT);
+		goto out;
 
-	sock_gen_cookie(sk);
-	return &sk->sk_cookie;
+	ret = __sock_map_copy_value(map, sk, value);
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static void *sock_hash_lookup(struct bpf_map *map, void *key)
@@ -1139,7 +1155,7 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_update_elem	= sock_hash_update_elem,
 	.map_delete_elem	= sock_hash_delete_elem,
 	.map_lookup_elem	= sock_hash_lookup,
-	.map_lookup_elem_sys_only = sock_hash_lookup_sys,
+	.map_copy_value		= sock_hash_copy_value,
 	.map_release_uref	= sock_hash_release_progs,
 	.map_check_btf		= map_check_no_btf,
 };
-- 
2.20.1

