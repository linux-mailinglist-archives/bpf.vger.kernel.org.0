Return-Path: <bpf+bounces-70928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC85BDB67F
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D1B19A26E9
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04730BF68;
	Tue, 14 Oct 2025 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgNw/eoJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA93090C6
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477149; cv=none; b=eAnMpgzcAMAiA0dMkORrv5ad1xVpNOSwhjENRttdqvxRA3cUJ/uvn9vqCE1cE+h1RdaARIaPGIPmRAFYpMEhwYVvlq5Jw5PYDdQ8I6mxvz5cYyNxlJMmQWqSZAYvlpsVrUjIbNU119beMgdYuNN9HMtJtamTyConn9N94PaUteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477149; c=relaxed/simple;
	bh=NrhBTOGaDD6fBUrNPuuKKNkOUv86IJ77KR7gKFQQ3GA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYhmZ4y5LwkXq5nFgxkwPyuZspZaEVGY+r2WaiSFaaqAlDRFW5S7YkpIFqXQmuV3mP8o5aZOMFmxD4qiZboqtdfVOXTF+zdsQVFNxVeKt6QUOpk4YN6OWfNApVh9WAy047V0CqSquh0KlRtjrLl4Zgufs3B6YNoF+i/iSs5AmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgNw/eoJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eec33b737so86639355ad.1
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760477146; x=1761081946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJcSs2MixD9Ddu+ViQQpliBg+ecuONXrJgOOzTDyEAM=;
        b=JgNw/eoJYuBA4BTh3l8K/yCSxFyMdvwvOs0joi3sLCAe2NeHCJ4iw3QH5nQvi7B9Iu
         Mnv5VsVzcYxTwuyvjvJ2l8+xkUwTrhYDQBVXXWsNQExRXapKDJrt/mdCtrt/yMogjVg1
         cejRzvc+KCBrAJtKDKiXU7XpC2pR161LQBj9hVqXsQp4L3a9UDNBqL39srzzJbUIJGiv
         mc9kd931QORkFZqDbmjogEO5dZufR3JmaU5MGt1yyqynP0nYpbYn4c2xT80IAhZte5tf
         2qP13YEQpQXkLy+Ihf6dcD/V/0FTrodAVxOK04wRoAjJM7whTXZZSEE5dm4sEMKcCYYH
         FwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760477146; x=1761081946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJcSs2MixD9Ddu+ViQQpliBg+ecuONXrJgOOzTDyEAM=;
        b=cgZTT/Bw4MFhH5UcyClTVKXBc70ETeKQhuO3q9PDTUYCAdNzxMfwazMtqUOgO8/BRS
         4TYNP//8E6V92rEOcd2sFqy8zEpL5+OvH5QJm695+MqVbHGkT9S+d9DljSgbH+/g3X5z
         aaRE3WLlAabH0WMYkEl8Z7TeNrnWEqOjZ0iztVynuyapiKuzwnrIJFRH2kUS4mUGh485
         ffeUDoqrr4Ndsa6kv3IrXXuPstB0whF6OTg/QrcpyZDz+YRbtuwUh8nqSnRSALlD57+J
         ddjqLswPlDNO3xjDIP4QL3OQMogzLg6WzmzHbTOdY5EBVAy16mP125/AzPisvnanKU/g
         VIvQ==
X-Gm-Message-State: AOJu0YwI1n0yA6QTweRryi3Nf2TO1WvTTeK3lBhQjOkiPdz9TFZ4PWz4
	vLjGc5eyag+8iZwgxTIn1lYu625I0TN8ennvath2JU3Nmxd+Mh/A0Lxt9yDMVA==
X-Gm-Gg: ASbGncv3MTFhFd80MsUmZkf2oo4fyd/VVqxMpVo6maCUBQrruY1Srz6ofHtkLpOnVJC
	/dP905mUn9SSGXqA+n2tH4OcWIBrJeAhnQCt6CjOvFpB3t/sqWGAMCH9afrjKKBWR6dEFmixsiK
	tQpOZp3c69+7DjnnNWYXSN5aXjCbNYNLCK3wZprIWnp9p1NbdF8BIsgooZrAfIH3WrNsf3olUs6
	DEvNWjejYTJSRXnUzwVgBtuSYHegW3/KayVpP+xCB4PTeof98S0XAuRo3nM4lw5tPGz3FPV4T0C
	FEVzTOoXWWvn4H8mJuVqIRZzV7QX5Y2+wOJzCYIfwVYVjTAsH6fUEefVSbB8tCCKFXNW84RWDRd
	cgJpqQPXDi9IRLLxrcGikNQuFUQgs5Pb/8MlpLW0e09Py/O7RJZ/nyOHMYByw2EAf1YrCdJM=
X-Google-Smtp-Source: AGHT+IHm2e1raOsbTmENb3x5Xd6TCpwziKXblzgIgDqffemH81B8E878HilCMVF9PUA9s41E3nITDg==
X-Received: by 2002:a17:903:1b4b:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-29027214ee7mr350403855ad.6.1760477145892;
        Tue, 14 Oct 2025 14:25:45 -0700 (PDT)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::4:c3af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm174156995ad.92.2025.10.14.14.25.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Oct 2025 14:25:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	vbabka@suse.cz,
	yepeilin@google.com,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org
Subject: [PATCH bpf] bpf: Replace bpf_map_kmalloc_node() with kmalloc_nolock() to allocate bpf_async_cb structures.
Date: Tue, 14 Oct 2025 14:25:41 -0700
Message-Id: <20251014212541.67930-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The following kmemleak splat:
[    8.105530] kmemleak: Trying to color unknown object at 0xff11000100e918c0 as Black
[    8.106521] Call Trace:
[    8.106521]  <TASK>
[    8.106521]  dump_stack_lvl+0x4b/0x70
[    8.106521]  kvfree_call_rcu+0xcb/0x3b0
[    8.106521]  ? hrtimer_cancel+0x21/0x40
[    8.106521]  bpf_obj_free_fields+0x193/0x200
[    8.106521]  htab_map_update_elem+0x29c/0x410
[    8.106521]  bpf_prog_cfc8cd0f42c04044_overwrite_cb+0x47/0x4b
[    8.106521]  bpf_prog_8c30cd7c4db2e963_overwrite_timer+0x65/0x86
[    8.106521]  bpf_prog_test_run_syscall+0xe1/0x2a0

happens due to the combination of features and fixes, but mainly due to
commit 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()")
It's using __GFP_HIGH, which instructs slub/kmemleak internals to skip
kmemleak_alloc_recursive() on allocation, so subsequent kfree_rcu()->
kvfree_call_rcu()->kmemleak_ignore() complains with the above splat.

To fix this imbalance, replace bpf_map_kmalloc_node() with
kmalloc_nolock() and kfree_rcu() with call_rcu() + kfree_nolock() to
make sure that the objects allocated with kmalloc_nolock() are freed
with kfree_nolock() rather than the implicit kfree() that kfree_rcu()
uses internally.

Note, the kmalloc_nolock() happens under bpf_spin_lock_irqsave(), so
it will always fail in PREEMPT_RT. This is not an issue at the moment,
since bpf_timers are disabled in PREEMPT_RT. In the future
bpf_spin_lock will be replaced with state machine similar to
bpf_task_work.

Fixes: 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  4 ++++
 kernel/bpf/helpers.c | 21 ++++++++++++---------
 kernel/bpf/syscall.c | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..d808253f2e94 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2499,6 +2499,8 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 #ifdef CONFIG_MEMCG
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
+void *bpf_map_kmalloc_nolock(const struct bpf_map *map, size_t size, gfp_t flags,
+			     int node);
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags);
 void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
 		       gfp_t flags);
@@ -2511,6 +2513,8 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
  */
 #define bpf_map_kmalloc_node(_map, _size, _flags, _node)	\
 		kmalloc_node(_size, _flags, _node)
+#define bpf_map_kmalloc_nolock(_map, _size, _flags, _node)	\
+		kmalloc_nolock(_size, _flags, _node)
 #define bpf_map_kzalloc(_map, _size, _flags)			\
 		kzalloc(_size, _flags)
 #define bpf_map_kvcalloc(_map, _n, _size, _flags)		\
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..c5f63f2685e9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1215,13 +1215,20 @@ static void bpf_wq_work(struct work_struct *work)
 	rcu_read_unlock_trace();
 }
 
+static void bpf_async_cb_rcu_free(struct rcu_head *rcu)
+{
+	struct bpf_async_cb *cb = container_of(rcu, struct bpf_async_cb, rcu);
+
+	kfree_nolock(cb);
+}
+
 static void bpf_wq_delete_work(struct work_struct *work)
 {
 	struct bpf_work *w = container_of(work, struct bpf_work, delete_work);
 
 	cancel_work_sync(&w->work);
 
-	kfree_rcu(w, cb.rcu);
+	call_rcu(&w->cb.rcu, bpf_async_cb_rcu_free);
 }
 
 static void bpf_timer_delete_work(struct work_struct *work)
@@ -1230,13 +1237,13 @@ static void bpf_timer_delete_work(struct work_struct *work)
 
 	/* Cancel the timer and wait for callback to complete if it was running.
 	 * If hrtimer_cancel() can be safely called it's safe to call
-	 * kfree_rcu(t) right after for both preallocated and non-preallocated
+	 * call_rcu() right after for both preallocated and non-preallocated
 	 * maps.  The async->cb = NULL was already done and no code path can see
 	 * address 't' anymore. Timer if armed for existing bpf_hrtimer before
 	 * bpf_timer_cancel_and_free will have been cancelled.
 	 */
 	hrtimer_cancel(&t->timer);
-	kfree_rcu(t, cb.rcu);
+	call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
 }
 
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
@@ -1270,11 +1277,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		goto out;
 	}
 
-	/* Allocate via bpf_map_kmalloc_node() for memcg accounting. Until
-	 * kmalloc_nolock() is available, avoid locking issues by using
-	 * __GFP_HIGH (GFP_ATOMIC & ~__GFP_RECLAIM).
-	 */
-	cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
+	cb = bpf_map_kmalloc_nolock(map, size, 0, map->numa_node);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
@@ -1607,7 +1610,7 @@ void bpf_timer_cancel_and_free(void *val)
 		 * completion.
 		 */
 		if (hrtimer_try_to_cancel(&t->timer) >= 0)
-			kfree_rcu(t, cb.rcu);
+			call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
 		else
 			queue_work(system_dfl_wq, &t->cb.delete_work);
 	} else {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2a9456a3e730..8a129746bd6c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -520,6 +520,21 @@ void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 	return ptr;
 }
 
+void *bpf_map_kmalloc_nolock(const struct bpf_map *map, size_t size, gfp_t flags,
+			     int node)
+{
+	struct mem_cgroup *memcg, *old_memcg;
+	void *ptr;
+
+	memcg = bpf_map_get_memcg(map);
+	old_memcg = set_active_memcg(memcg);
+	ptr = kmalloc_nolock(size, flags | __GFP_ACCOUNT, node);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+
+	return ptr;
+}
+
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 {
 	struct mem_cgroup *memcg, *old_memcg;
-- 
2.47.3


