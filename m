Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2BD3A111C
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbhFIKfa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234299AbhFIKfa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZ38gMUjEr+gzQd0/QpPSZkBw8zgTtRoyYxgvJDwPiA=;
        b=NIlDDVp5b60dA/Hy6kVPmTvgIbkYN/BuMhgdUNDbTYENJGtvz2fIMF1pH/kIuFMkVZBZr6
        P/1+0ka8B0uKhvTSuLLd7MJVHy3GItNh98rbiDEzjIGeefL8DOHVC5TEzypduzw/JEnXTY
        JItpvplEtPedJhpqPfNvE1ttwhdIb0A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-G9ZEKnjRNP-wx-tBICtpNA-1; Wed, 09 Jun 2021 06:33:33 -0400
X-MC-Unique: G9ZEKnjRNP-wx-tBICtpNA-1
Received: by mail-ej1-f71.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso7871154ejc.7
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZ38gMUjEr+gzQd0/QpPSZkBw8zgTtRoyYxgvJDwPiA=;
        b=pegUqml2c6JkLS16gdpk3D9Ani8M97ivnDKZgxftj056Gv56DhE3ubVISBGAwoYU1W
         P/DwroT+c7gp6yzFrl7SkiiArVOLP02/XlnZTxwVZ1pJF9QY4ZWGUV3zpCDkHfply6k7
         Z7kJUrTC6cSo7UQ0hf3rpqD9NVOtB42XoJBcLRAexhNDhIF3nPryfZ51ydjhvc6Ij54V
         kC6q1RYf1GzhsNerG+AxRnHN0gAQiug2tpTxZv0KLkGHaaIQxHzqVX0kgF5QS9K3VeR7
         a0g5gBkT3wTMdLnUgrGiHc9kCFMQzCS24KQGoAeUQrO65WTxdTXSBsvz8RzPR0yLC2fA
         DHvw==
X-Gm-Message-State: AOAM532AViaH4GCKi2PHPVJS1C00AqO1BLf54FdKOv7gk1bHps603Vgv
        6YxMatok65rFjolky6VTvTJd3hjcot1pX6Weo2rSpvH+OiwljAyCpBiz8WISxPjKHhbkw5/eRbh
        Ty/wgmF0DWjnG
X-Received: by 2002:a05:6402:22fa:: with SMTP id dn26mr29419029edb.230.1623234812774;
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4ZjOdgxvzRTTNY2mqpmg+pC9YqQNk4wWQ4bO1hEvEggwyYS0+lnFyVMWnGslD9Q5MForIEg==
X-Received: by 2002:a05:6402:22fa:: with SMTP id dn26mr29419016edb.230.1623234812620;
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a19sm717702ejk.46.2021.06.09.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64B9F1802B1; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next 02/17] bpf: allow RCU-protected lookups to happen from bh context
Date:   Wed,  9 Jun 2021 12:33:11 +0200
Message-Id: <20210609103326.278782-3-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

XDP programs are called from a NAPI poll context, which means the RCU
reference liveness is ensured by local_bh_disable(). Add
rcu_read_lock_bh_held() as a condition to the RCU checks for map lookups so
lockdep understands that the dereferences are safe from inside *either* an
rcu_read_lock() section *or* a local_bh_disable() section. This is done in
preparation for removing the redundant rcu_read_lock()s from the drivers.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/hashtab.c  | 21 ++++++++++++++-------
 kernel/bpf/helpers.c  |  6 +++---
 kernel/bpf/lpm_trie.c |  6 ++++--
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6f6681b07364..72c58cc516a3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -596,7 +596,8 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l;
 	u32 hash, key_size;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
 
@@ -989,7 +990,8 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
 
@@ -1082,7 +1084,8 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
 
@@ -1148,7 +1151,8 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
 
@@ -1202,7 +1206,8 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
 
@@ -1276,7 +1281,8 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
 
@@ -1311,7 +1317,8 @@ static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 544773970dbc..e880f6bb6f28 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -28,7 +28,7 @@
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -44,7 +44,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -61,7 +61,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 1b7b8a6f34ee..423549d2c52e 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -232,7 +232,8 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 
 	/* Start walking the trie from the root node ... */
 
-	for (node = rcu_dereference(trie->root); node;) {
+	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
+	     node;) {
 		unsigned int next_bit;
 		size_t matchlen;
 
@@ -264,7 +265,8 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 * traverse down.
 		 */
 		next_bit = extract_bit(key->data, node->prefixlen);
-		node = rcu_dereference(node->child[next_bit]);
+		node = rcu_dereference_check(node->child[next_bit],
+					     rcu_read_lock_bh_held());
 	}
 
 	if (!found)
-- 
2.31.1

