Return-Path: <bpf+bounces-70957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D4BDBDCB
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 02:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A219246A9
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288B1BC58;
	Wed, 15 Oct 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffCniQrd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2343171C9
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486826; cv=none; b=AMXaCiSLMaOPaZmpxj3Egcf3diRmsmPvtpfojDz1aXShdk+26bHZVVs8a681RQ+oyrjHlFYlWXD1FHbxvgZGHzbkTeL0mGCRCkQ6y8xiUHoDLTnE7WVCaLgrzIH93gc+T8GL2HtfAq7qOLnkJrFUm4tZ5YJH/6AeKv9p5SN/seA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486826; c=relaxed/simple;
	bh=9n7TVaPF4/KyIcs49sLRhVjNUzeiq8Fkk+B1Z66g/d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myf4VSKKtNTcUpWokbnoY1y9MdWbc7C+7dvXtBT1fMy1YDaSVBlg0y6/xUG7p2gBCW8x6+sgyvDsjxIgjZ2X9IwJpyPcWBcuGj5blzlv86kImVb22L5yYOkEKXgI5BVT4m447xGLy6mqpcc/syzesRidAzczxm7r6zW4+SPvh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffCniQrd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781206cce18so405348b3a.0
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760486823; x=1761091623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXPxuwObJkkCRWy8ktvoowrkbeuhTp2+JLZJZCgaOMQ=;
        b=ffCniQrd823WhuZCcCS4rzmEZtMHFctRE2CwD5GefW0a4apdvhJF8ZsEl//aZD7OJU
         /neh3Nd8/K7j6JMy8N2e3p//RrKo8N5BhvXjDm0XuZeOYGuk2BN/WgYwg23kZVHXTNF1
         3D57yatuQicTxEaivFbFBc6+vnqBtBfhzD4B6URJZP/Hj7NOuqEOqB8dHVHdzAahDNQG
         cCdvpr1UwaiIQs9HDCKkzMl2VPsvz6P/ilBNfYS8ZcjZtme4cNsxk4ThQ0eBsde1F8gM
         ydxpvFWup/mKG13p8vkWPCX6mo8/MnL2vyhvI7gSqvDb3LbDcYgkaUNNtzPTVHgBU2Dx
         E/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486823; x=1761091623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXPxuwObJkkCRWy8ktvoowrkbeuhTp2+JLZJZCgaOMQ=;
        b=emc8HRmyRfnJaC8J5axFV90C/svsdmh5Thpd7ilT+w93iDADv9XD2GRYr1V+SxxL0N
         nvxbsvj3lnQ6gb/saK7WrDSPa/g9U2Gl4Hz47YMDuMN42aomtXRZ0exL2OIKWmxsKHdZ
         kAQ41MsoUfvP7khP3m3iRKeRyDFPh1tfrPSVd/CzLiqd3xV1DY7MYUw+OODuPr42JFpX
         E23R++46qLQxubuYvfLa/Ri/GnDnxDqgw2ddm/P69Q7DbA+JqLBLif9ZEih+MBncJVzn
         89nwtx4YuolgALTRslwd3Q6qMa99z8r4t+nM6myMKZnrrOFHMvHAil64qpMDk3xabhq/
         MxZg==
X-Gm-Message-State: AOJu0YwOS5Um3ps9/2lt6fyxPTxRWFv9G3pIKC1Q1mK5gCutBo9dvXZX
	pIbQlqCjleVx1Gbb4lfk41MHYWxmkupe+/HT17N05pAIltFaAAsi1tbbcYUgOg==
X-Gm-Gg: ASbGncs6QSWR1tlkEaY+1l7FoXOEIuKjuPGc8CnJfEnlEBUdr67rxG2FVDoaPZP0hXW
	ahlCv3LqNtriMRyImUfNESOf4JryKItHC8iuHBnMCjeJvsXD2b0fkdT4vFslCM0mBnKwoBFFNEp
	VheqiKYPxoDDNOsh6YBluqDr1LRcqF1tPzANW0iEJjuT9PhS1iUXv9fDle+WzIqvh2nNoC5UMqV
	WuQiq7hD4pLVzCqUXN+TgYA7X0k5mNdSOqZ0i6EoKYt7KzEe+XESQzF4g8z8IVWNiuApEbh7hpO
	cI0L/G6RowzdP2zBC38X3ovnrUc5H6NHIr3KEM8k3usA+FsnhdDW3HK7kIfI8Bwg2DNtFM17MJU
	xMcmXHuJJ3NGWsmrCMwyfayEVjlyBn4vg9e21k+DlCdHVfFiyONcrE8rBssLp+t1p0lggxprJsi
	4BLW2nFkCESS5XpuWk7wPq
X-Google-Smtp-Source: AGHT+IHd5BU73GIkW3P76RXF0BBUnl6Dvwja0oj9zpaxg6vbkP5JLSk159tuTRDYwjGLXwYbSXAsPw==
X-Received: by 2002:a05:6a00:1701:b0:78c:a3a6:a1bf with SMTP id d2e1a72fcca58-79397b19445mr30372445b3a.7.1760486822692;
        Tue, 14 Oct 2025 17:07:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837e:3c50:1021:a424:7dd1:a498])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e3f89sm16117780b3a.66.2025.10.14.17.07.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Oct 2025 17:07:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	yepeilin@google.com,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf] bpf: Replace bpf_map_kmalloc_node() with kmalloc_nolock() to allocate bpf_async_cb structures.
Date: Tue, 14 Oct 2025 17:07:00 -0700
Message-ID: <20251015000700.28988-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
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
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
v1->v2: Fix one missing kfree->kfree_nolock() conversion (caught by BPF AI bot)

 include/linux/bpf.h  |  4 ++++
 kernel/bpf/helpers.c | 25 ++++++++++++++-----------
 kernel/bpf/syscall.c | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

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
index c9fab9a356df..8eb117c52817 100644
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
@@ -1315,7 +1318,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		 * or pinned in bpffs.
 		 */
 		WRITE_ONCE(async->cb, NULL);
-		kfree(cb);
+		kfree_nolock(cb);
 		ret = -EPERM;
 	}
 out:
@@ -1580,7 +1583,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 * timer _before_ calling us, such that failing to cancel it here will
 	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
 	 * Therefore, we _need_ to cancel any outstanding timers before we do
-	 * kfree_rcu, even though no more timers can be armed.
+	 * call_rcu, even though no more timers can be armed.
 	 *
 	 * Moreover, we need to schedule work even if timer does not belong to
 	 * the calling callback_fn, as on two different CPUs, we can end up in a
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


