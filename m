Return-Path: <bpf+bounces-67910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FE5B503CF
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6319A3677C6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFD35E4EE;
	Tue,  9 Sep 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="N285UPjI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49920F08C
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437228; cv=none; b=VoZpERSAXL8jXtPV7K08w5hu/fB0q1XsjxwWXzEcbTboUI9uyYx6QZs+W5OEwdzPo+rubVsxxNItUZF4KlF9HWknkQvhQyLnu8Q+GujbxxYIsMwbj8uUfSX/gilSy6LNEFQv6xnZ76rUwdEvTt+E523ruetQ8ht/2p4cPYAfFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437228; c=relaxed/simple;
	bh=YOheNea8w4oFvaJYrcoKVJ05SYnlnHJweU0Z+hN4aqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oso9pXFJBHMxxm1Sb2cp5PWrfTdR99XL6gF1ApKxZ/CzvJ13LqeJcH0k2Hq+JcttRfT3DcoDlES86cmkCc7XbN2amDZsK+DINwwH2MTMuFmBneiq6cFc55Sf+I3dMzCN/h7z2jJsCH7e0gL+p0x8fvcKINM3nb1NL99uDU0cjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=N285UPjI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5232a989a9so72514a12.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437223; x=1758042023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqze7iwG5Ry+dDBARlSyhuUqRONuSWeSjCIo66sdoYI=;
        b=N285UPjI5uT8wPT9LdT8CKMfrgJTX+vJOqWX1awm+E4mRW68tns5QjLu9TrAIC3D0A
         +UBuhNEHDYl8eW2N7s7JL7ysTNxQTBO87u/Cy00TQwVGPhyLuPpi4MJBM0bn3Icpqq9K
         K/j5wwr8c4KzWstseJRILsmV0dlGgwS954mdtpeYAurjZcAc2Q/n55nNK/cB83qh/Liy
         BGMs3Z3w4UW49yglQyX/LBqOeFfYH4bS5n/gDkWkU9yOSNu+O4hbO2lfrP5NGbX7VWq/
         vi9CAc9FNvqdhVwMq1/27raeeB+f96Fd+T9FdzlQFyKVHEKME7CxRQCZjACD9EaocWd1
         BgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437223; x=1758042023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqze7iwG5Ry+dDBARlSyhuUqRONuSWeSjCIo66sdoYI=;
        b=IaeFo6nZxIqC6DlpLBo6dJkhu80dUp81ldVGIy7rBejwhbBtLd6SwXEEXHMTkvCU8P
         e9/aDHmxjierozGXm4cj22BPskC9j3TRkr04gVpQjeNCJJbds6TA11HENuhw8SswbIVC
         k6ahM0hJHvy2QxL0Poc0LE9j60OBNesb9r1ITau4otXw5wwpZF4nkASMCSWRCkRRuROo
         5EbfZWJlE9Dk4oUh013iIxH6DkVseTbnZ0oIkFlUhRL3Q5sS0jkjWHOE5FsqY/Q+m1lS
         buL04HQbgyihACGnV1oUD1gyf7IT37QNI6pSl6a3QVwB2a0k7cSQI9kkToyg8shJJtZj
         jWZQ==
X-Gm-Message-State: AOJu0Yx1hr+q+8qTvhY9traTHbzYhK3JnCVPcDakRvO4xoi6xpbVarky
	05+JUG/473sketTpnRA//MbeiiCQbRf/PQr09ZDX6KC/CEIqryJzytlimGVGt7K2xBRFww5Pxj8
	pCXmC
X-Gm-Gg: ASbGncvy3gMnIVyY4JVupVQ2pn5RvQ5KkabOjn7z8GAc+J04/Uu9Zq0t4KjHeNBnjMo
	jUNdA8B5LWvaMtjirwEQgIRxNZ7a2Fz+qtS7QTSWvLESqzQjzu2PYIiAd7WmzrCs1rRNuYy3bfy
	D+kIiNeCe2RJAxlxvh36ErtBOSa4GtolNfi/QX3BQ+cZOJW4HF8DpPK63AA81mJS1bHVj8BjUV7
	cjCm6aAN1zeXqMpsrf5JWhXAE/4tYT21kr9WpnWf28zzeCOrZI89KR/8JFjULhMkId0C8wemicy
	UVcg1H+Dg9peXK3TZcJwM4zeAOtEIX0plU2u216Ykf6AbmRKvck8TQe2Fh/fgRHUGSYg5FPJaT4
	knf0Q2KK8GVuyLq8hrzq8mA9D
X-Google-Smtp-Source: AGHT+IGgBbvSKHyPB+9E0Dr0eVfimKEokb7a96nOk+yHQ1AsR/F/uGf1DXWJ1JgkdL3C3K+6oI879g==
X-Received: by 2002:a05:6a20:4322:b0:24a:3b34:19cb with SMTP id adf61e73a8af0-2534441f6cdmr11016881637.3.1757437223313;
        Tue, 09 Sep 2025 10:00:23 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:22 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 01/14] bpf: Use reference counting for struct bpf_shtab_elem
Date: Tue,  9 Sep 2025 09:59:55 -0700
Message-ID: <20250909170011.239356-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use reference counting to decide when to free socket hash elements
instead of freeing them immediately after they are unlinked from a
bucket's list. In the next patch this is essential, allowing socket
hash iterators to hold a reference to a `struct bpf_shtab_elem` outside
of an RCU read-side critical section.

sock_hash_put_elem() follows the list, scheduling elements to be freed
until it hits an element where the reference count is two or greater.
This does nothing yet; in this patch the loop will never iterate more
than once, since we always take a reference to the next element in
sock_hash_unlink_elem() before calling sock_hash_put_elem(), and in
general, the reference count to any element is always one except during
these transitions. However, in the next patch it's possible for an
iterator to hold a reference to an element that has been unlinked from
a bucket's list. In this context, sock_hash_put_elem() may free
several unlinked elements up until the point where it finds an element
that is still in the bucket's list.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 67 +++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 5947b38e4f8b..005112ba19fd 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -847,6 +847,7 @@ struct bpf_shtab_elem {
 	u32 hash;
 	struct sock *sk;
 	struct hlist_node node;
+	refcount_t ref;
 	u8 key[];
 };
 
@@ -906,11 +907,46 @@ static struct sock *__sock_hash_lookup_elem(struct bpf_map *map, void *key)
 	return elem ? elem->sk : NULL;
 }
 
-static void sock_hash_free_elem(struct bpf_shtab *htab,
-				struct bpf_shtab_elem *elem)
+static void sock_hash_free_elem(struct rcu_head *rcu_head)
 {
+	struct bpf_shtab_elem *elem = container_of(rcu_head,
+						   struct bpf_shtab_elem, rcu);
+
+	/* Matches sock_hold() in sock_hash_alloc_elem(). */
+	sock_put(elem->sk);
+	kfree(elem);
+}
+
+static void sock_hash_put_elem(struct bpf_shtab_elem *elem)
+{
+	while (elem && refcount_dec_and_test(&elem->ref)) {
+		call_rcu(&elem->rcu, sock_hash_free_elem);
+		elem = hlist_entry_safe(rcu_dereference(hlist_next_rcu(&elem->node)),
+					struct bpf_shtab_elem, node);
+	}
+}
+
+static bool sock_hash_hold_elem(struct bpf_shtab_elem *elem)
+{
+	return refcount_inc_not_zero(&elem->ref);
+}
+
+static void sock_hash_unlink_elem(struct bpf_shtab *htab,
+				  struct bpf_shtab_elem *elem)
+{
+	struct bpf_shtab_elem *elem_next;
+
+	elem_next = hlist_entry_safe(rcu_dereference(hlist_next_rcu(&elem->node)),
+				     struct bpf_shtab_elem, node);
+	hlist_del_rcu(&elem->node);
+	sock_map_unref(elem->sk, elem);
+	/* Take a reference to the next element first to make sure it's not
+	 * freed by the call to sock_hash_put_elem().
+	 */
+	if (elem_next)
+		sock_hash_hold_elem(elem_next);
+	sock_hash_put_elem(elem);
 	atomic_dec(&htab->count);
-	kfree_rcu(elem, rcu);
 }
 
 static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
@@ -930,11 +966,8 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 	spin_lock_bh(&bucket->lock);
 	elem_probe = sock_hash_lookup_elem_raw(&bucket->head, elem->hash,
 					       elem->key, map->key_size);
-	if (elem_probe && elem_probe == elem) {
-		hlist_del_rcu(&elem->node);
-		sock_map_unref(elem->sk, elem);
-		sock_hash_free_elem(htab, elem);
-	}
+	if (elem_probe && elem_probe == elem)
+		sock_hash_unlink_elem(htab, elem);
 	spin_unlock_bh(&bucket->lock);
 }
 
@@ -952,9 +985,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	spin_lock_bh(&bucket->lock);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
-		hlist_del_rcu(&elem->node);
-		sock_map_unref(elem->sk, elem);
-		sock_hash_free_elem(htab, elem);
+		sock_hash_unlink_elem(htab, elem);
 		ret = 0;
 	}
 	spin_unlock_bh(&bucket->lock);
@@ -985,6 +1016,11 @@ static struct bpf_shtab_elem *sock_hash_alloc_elem(struct bpf_shtab *htab,
 	memcpy(new->key, key, key_size);
 	new->sk = sk;
 	new->hash = hash;
+	refcount_set(&new->ref, 1);
+	/* Matches sock_put() in sock_hash_free_elem(). Ensure that sk is not
+	 * freed until elem is.
+	 */
+	sock_hold(sk);
 	return new;
 }
 
@@ -1038,11 +1074,8 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	 * concurrent search will find it before old elem.
 	 */
 	hlist_add_head_rcu(&elem_new->node, &bucket->head);
-	if (elem) {
-		hlist_del_rcu(&elem->node);
-		sock_map_unref(elem->sk, elem);
-		sock_hash_free_elem(htab, elem);
-	}
+	if (elem)
+		sock_hash_unlink_elem(htab, elem);
 	spin_unlock_bh(&bucket->lock);
 	return 0;
 out_unlock:
@@ -1182,7 +1215,7 @@ static void sock_hash_free(struct bpf_map *map)
 			rcu_read_unlock();
 			release_sock(elem->sk);
 			sock_put(elem->sk);
-			sock_hash_free_elem(htab, elem);
+			call_rcu(&elem->rcu, sock_hash_free_elem);
 		}
 		cond_resched();
 	}
-- 
2.43.0


