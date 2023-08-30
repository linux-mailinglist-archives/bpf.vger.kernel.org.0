Return-Path: <bpf+bounces-8959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9078D304
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 07:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0542812E7
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F64915C8;
	Wed, 30 Aug 2023 05:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F815A0;
	Wed, 30 Aug 2023 05:35:22 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A48CFC;
	Tue, 29 Aug 2023 22:35:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f38171174so3286089a91.3;
        Tue, 29 Aug 2023 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693373720; x=1693978520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcXw+zHITcyTt8fguxH0pg2GRFn+w02Glz+Wr2nO71o=;
        b=qj4ofPt9RsynglfvS3vqpyPzQQJRTUfJYf5pGHw4Uw77biz5Ij643IDkZ4v/LuwmgK
         NLg3bsaDox3D025nf3IfoWBtt5Jh6oET2CmCBHqKjqUZNaOR+4N+wjEmIefF8qjFj/DG
         Jw4Qf3P0ZWQyCofrBXLvLLn+ZUI4gntyl2jBveE/6zZf57a1rpvwcVklfhtYEOQ0juE/
         5VmEUnL4zfqqSovrDod0E4tD7YqMgebKYHPUooTe5HxM7DlfuRc4tDOBKAOmzFOA/pje
         tUcW1CkrRq6YAHXSqNK4JXhE40afMUiRufC2wVy4PbBZ19pWWSToE2/JzdE6EFX4j7+L
         a6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693373720; x=1693978520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcXw+zHITcyTt8fguxH0pg2GRFn+w02Glz+Wr2nO71o=;
        b=D33+rFbtFRXlf1ZPbEjbDLu5qYNyuC/Bg0TPhbafYS9CPgMH5unbmPE5KS4p2VTjFH
         P0aV4FQ3W14sUVHa+3uz4KnmIGLL9JLhxF3SBiVdJAkpxjQZOsfIIaWPSXWDeR8vFrSG
         v2T4L+Er8C8hRztoBq/1NhrsKQWlJTtjF4nsoBay7d8rNo0qvRtXLaCfMnymiCS0l73H
         sXZJsR1nPsodYcHDA0PAEwm1rOz5g0pYGu6yTXNIoeYh4AyKLtl/uRTtffhX0HYKLxZ1
         tCHNow3E7mCk8YW4wMItZEQXmMOlsgvsbYDlutAWcgL+8NJV4yQPvNsfF0kOo/f5jDcf
         UtTw==
X-Gm-Message-State: AOJu0YxhK9df/GvpsHbZkpkf/KuuFbADh7Pb5Q64v3DGzhnJgTrijSIh
	Pif+x94uRx9pv3bpxb25oOCkrVaMntA=
X-Google-Smtp-Source: AGHT+IFwolUX4ai10qXL09aQU0B2qSYjhqyJH5hVmGqOo+zQ1v3ya0oQzWHk3Go229B/NKHrrUI2aw==
X-Received: by 2002:a17:90a:928a:b0:26d:2162:f596 with SMTP id n10-20020a17090a928a00b0026d2162f596mr1190310pjo.6.1693373720037;
        Tue, 29 Aug 2023 22:35:20 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:2873:7391:ec8:280a])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a195400b0026b55e28035sm524533pjh.52.2023.08.29.22.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 22:35:19 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf] bpf: sockmap, fix preempt_rt splat when using raw_spin_lock_t
Date: Tue, 29 Aug 2023 22:35:17 -0700
Message-Id: <20230830053517.166611-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sockmap and sockhash maps are a collection of psocks that are
objects representing a socket plus a set of metadata needed
to manage the BPF programs associated with the socket. These
maps use the stab->lock to protect from concurrent operations
on the maps, e.g. trying to insert to objects into the array
at the same time in the same slot. Additionally, a sockhash map
has a bucket lock to protect iteration and insert/delete into
the hash entry.

Each psock has a psock->link which is a linked list of all the
maps that a psock is attached to. This allows a psock (socket)
to be included in multiple sockmap and sockhash maps. This
linked list is protected the psock->link_lock.

They _must_ be nested correctly to avoid deadlock,

  lock(stab->lock)
    : do BPF map operations and psock insert/delete
    lock(psock->link_lock)
       : add map to psock linked list of maps
    unlock(psock->link_lock)
  unlock(stab->lock)

For non PREEMPT_RT kernels both raw_spin_lock_t and spin_lock_t
are guaranteed to not sleep. But, with PREEMPT_RT kernels the
spin_lock_t variants may sleep. In the current code we have
many patterns like this,

   rcu_critical_section:
      raw_spin_lock(stab->lock)
         spin_lock(psock->link_lock) <- may sleep ouch
         spin_unlock(psock->link_lock)
      raw_spin_unlock(stab->lock)
   rcu_critical_section

Nesting spin_lock() inside a raw_spin_lock() violates locking
rules for PREEMPT_RT kernels. And additionally we do alloc(GFP_ATOMICS)
inside the stab->lock, but those might sleep on PREEMPT_RT kernels.
The result is splats like this,

./test_progs -t sockmap_basic
[   33.344330] bpf_testmod: loading out-of-tree module taints kernel.
[   33.441933]
[   33.442089] =============================
[   33.442421] [ BUG: Invalid wait context ]
[   33.442763] 6.5.0-rc5-01731-gec0ded2e0282 #4958 Tainted: G           O
[   33.443320] -----------------------------
[   33.443624] test_progs/2073 is trying to lock:
[   33.443960] ffff888102a1c290 (&psock->link_lock){....}-{3:3}, at: sock_map_update_common+0x2c2/0x3d0
[   33.444636] other info that might help us debug this:
[   33.444991] context-{5:5}
[   33.445183] 3 locks held by test_progs/2073:
[   33.445498]  #0: ffff88811a208d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: sock_map_update_elem_sys+0xff/0x330
[   33.446159]  #1: ffffffff842539e0 (rcu_read_lock){....}-{1:3}, at: sock_map_update_elem_sys+0xf5/0x330
[   33.446809]  #2: ffff88810d687240 (&stab->lock){+...}-{2:2}, at: sock_map_update_common+0x177/0x3d0
[   33.447445] stack backtrace:
[   33.447655] CPU: 10 PID

To fix observe we can't readily remove the allocations (for that
we would need to use/create something similar to bpf_map_alloc). So
convert raw_spin_lock_t to spin_lock_t. We note that sock_map_update
that would trigger the allocate and potential sleep is only allowed
through sys_bpf ops and via sock_ops which precludes hw interrupts
and low level atomic sections in RT preempt kernel. On non RT
preempt kernel there are no changes here and spin locks sections
and alloc(GFP_ATOMIC) are still not sleepable.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/sock_map.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8f07fea39d9e..cb11750b1df5 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -18,7 +18,7 @@ struct bpf_stab {
 	struct bpf_map map;
 	struct sock **sks;
 	struct sk_psock_progs progs;
-	raw_spinlock_t lock;
+	spinlock_t lock;
 };
 
 #define SOCK_CREATE_FLAG_MASK				\
@@ -44,7 +44,7 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 
 	bpf_map_init_from_attr(&stab->map, attr);
-	raw_spin_lock_init(&stab->lock);
+	spin_lock_init(&stab->lock);
 
 	stab->sks = bpf_map_area_alloc((u64) stab->map.max_entries *
 				       sizeof(struct sock *),
@@ -411,7 +411,7 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	struct sock *sk;
 	int err = 0;
 
-	raw_spin_lock_bh(&stab->lock);
+	spin_lock_bh(&stab->lock);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
 		sk = xchg(psk, NULL);
@@ -421,7 +421,7 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	else
 		err = -EINVAL;
 
-	raw_spin_unlock_bh(&stab->lock);
+	spin_unlock_bh(&stab->lock);
 	return err;
 }
 
@@ -487,7 +487,7 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	psock = sk_psock(sk);
 	WARN_ON_ONCE(!psock);
 
-	raw_spin_lock_bh(&stab->lock);
+	spin_lock_bh(&stab->lock);
 	osk = stab->sks[idx];
 	if (osk && flags == BPF_NOEXIST) {
 		ret = -EEXIST;
@@ -501,10 +501,10 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	stab->sks[idx] = sk;
 	if (osk)
 		sock_map_unref(osk, &stab->sks[idx]);
-	raw_spin_unlock_bh(&stab->lock);
+	spin_unlock_bh(&stab->lock);
 	return 0;
 out_unlock:
-	raw_spin_unlock_bh(&stab->lock);
+	spin_unlock_bh(&stab->lock);
 	if (psock)
 		sk_psock_put(sk, psock);
 out_free:
@@ -835,7 +835,7 @@ struct bpf_shtab_elem {
 
 struct bpf_shtab_bucket {
 	struct hlist_head head;
-	raw_spinlock_t lock;
+	spinlock_t lock;
 };
 
 struct bpf_shtab {
@@ -910,7 +910,7 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 	 * is okay since it's going away only after RCU grace period.
 	 * However, we need to check whether it's still present.
 	 */
-	raw_spin_lock_bh(&bucket->lock);
+	spin_lock_bh(&bucket->lock);
 	elem_probe = sock_hash_lookup_elem_raw(&bucket->head, elem->hash,
 					       elem->key, map->key_size);
 	if (elem_probe && elem_probe == elem) {
@@ -918,7 +918,7 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 		sock_map_unref(elem->sk, elem);
 		sock_hash_free_elem(htab, elem);
 	}
-	raw_spin_unlock_bh(&bucket->lock);
+	spin_unlock_bh(&bucket->lock);
 }
 
 static long sock_hash_delete_elem(struct bpf_map *map, void *key)
@@ -932,7 +932,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	raw_spin_lock_bh(&bucket->lock);
+	spin_lock_bh(&bucket->lock);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -940,7 +940,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	raw_spin_unlock_bh(&bucket->lock);
+	spin_unlock_bh(&bucket->lock);
 	return ret;
 }
 
@@ -1000,7 +1000,7 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	raw_spin_lock_bh(&bucket->lock);
+	spin_lock_bh(&bucket->lock);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem && flags == BPF_NOEXIST) {
 		ret = -EEXIST;
@@ -1026,10 +1026,10 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 		sock_map_unref(elem->sk, elem);
 		sock_hash_free_elem(htab, elem);
 	}
-	raw_spin_unlock_bh(&bucket->lock);
+	spin_unlock_bh(&bucket->lock);
 	return 0;
 out_unlock:
-	raw_spin_unlock_bh(&bucket->lock);
+	spin_unlock_bh(&bucket->lock);
 	sk_psock_put(sk, psock);
 out_free:
 	sk_psock_free_link(link);
@@ -1115,7 +1115,7 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
 
 	for (i = 0; i < htab->buckets_num; i++) {
 		INIT_HLIST_HEAD(&htab->buckets[i].head);
-		raw_spin_lock_init(&htab->buckets[i].lock);
+		spin_lock_init(&htab->buckets[i].lock);
 	}
 
 	return &htab->map;
@@ -1147,11 +1147,11 @@ static void sock_hash_free(struct bpf_map *map)
 		 * exists, psock exists and holds a ref to socket. That
 		 * lets us to grab a socket ref too.
 		 */
-		raw_spin_lock_bh(&bucket->lock);
+		spin_lock_bh(&bucket->lock);
 		hlist_for_each_entry(elem, &bucket->head, node)
 			sock_hold(elem->sk);
 		hlist_move_list(&bucket->head, &unlink_list);
-		raw_spin_unlock_bh(&bucket->lock);
+		spin_unlock_bh(&bucket->lock);
 
 		/* Process removed entries out of atomic context to
 		 * block for socket lock before deleting the psock's
-- 
2.33.0


