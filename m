Return-Path: <bpf+bounces-16269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14DC7FF112
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFDD28260C
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7748CE3;
	Thu, 30 Nov 2023 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B33D1A3
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:00:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SgyWP3557z4f3jqr
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5A8AC1A0B65
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBslWhlJ5NxCQ--.49902S8;
	Thu, 30 Nov 2023 22:00:18 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf v4 4/7] bpf: Defer the free of inner map when necessary
Date: Thu, 30 Nov 2023 22:01:17 +0800
Message-Id: <20231130140120.1736235-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231130140120.1736235-1-houtao@huaweicloud.com>
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhBslWhlJ5NxCQ--.49902S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4UGry7GFWkur4xXrWrXwb_yoWrtF15pF
	Z8K34rCw40qr429rZxZa17ZrWYyw4fW34DGas5Ga4Yyrn8Wr9Fv3W0gFy5AF15Ar4kJrW2
	vrnIg34FkayUZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When updating or deleting an inner map in map array or map htab, the map
may still be accessed by non-sleepable program or sleepable program.
However bpf_map_fd_put_ptr() decreases the ref-counter of the inner map
directly through bpf_map_put(), if the ref-counter is the last one
(which is true for most cases), the inner map will be freed by
ops->map_free() in a kworker. But for now, most .map_free() callbacks
don't use synchronize_rcu() or its variants to wait for the elapse of a
RCU grace period, so after the invocation of ops->map_free completes,
the bpf program which is accessing the inner map may incur
use-after-free problem.

Fix the free of inner map by invoking bpf_map_free_deferred() after both
one RCU grace period and one tasks trace RCU grace period if the inner
map has been removed from the outer map before. The deferment is
accomplished by using call_rcu() or call_rcu_tasks_trace() when
releasing the last ref-counter of bpf map. The newly-added rcu_head
field in bpf_map shares the same storage space with work field to
reduce the size of bpf_map.

Fixes: bba1dc0b55ac ("bpf: Remove redundant synchronize_rcu.")
Fixes: 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in sleepable programs")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     |  7 ++++++-
 kernel/bpf/map_in_map.c | 11 ++++++++---
 kernel/bpf/syscall.c    | 32 +++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6f68ac24bb9a..15a6bb951b70 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -276,7 +276,11 @@ struct bpf_map {
 	 */
 	atomic64_t refcnt ____cacheline_aligned;
 	atomic64_t usercnt;
-	struct work_struct work;
+	/* rcu is used before freeing and work is only used during freeing */
+	union {
+		struct work_struct work;
+		struct rcu_head rcu;
+	};
 	struct mutex freeze_mutex;
 	atomic64_t writecnt;
 	/* 'Ownership' of program-containing map is claimed by the first program
@@ -292,6 +296,7 @@ struct bpf_map {
 	} owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
+	bool free_after_mult_rcu_gp;
 	s64 __percpu *elem_count;
 };
 
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 2dfeb5835e16..3248ff5d8161 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -129,10 +129,15 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 
 void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
-	/* ptr->ops->map_free() has to go through one
-	 * rcu grace period by itself.
+	struct bpf_map *inner_map = ptr;
+
+	/* The inner map may still be used by both non-sleepable and sleepable
+	 * bpf program, so free it after one RCU grace period and one tasks
+	 * trace RCU grace period.
 	 */
-	bpf_map_put(ptr);
+	if (need_defer)
+		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+	bpf_map_put(inner_map);
 }
 
 u32 bpf_map_fd_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a144eb286974..88882cb58121 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -718,6 +718,28 @@ static void bpf_map_put_uref(struct bpf_map *map)
 	}
 }
 
+static void bpf_map_free_in_work(struct bpf_map *map)
+{
+	INIT_WORK(&map->work, bpf_map_free_deferred);
+	/* Avoid spawning kworkers, since they all might contend
+	 * for the same mutex like slab_mutex.
+	 */
+	queue_work(system_unbound_wq, &map->work);
+}
+
+static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
+{
+	bpf_map_free_in_work(container_of(rcu, struct bpf_map, rcu));
+}
+
+static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_map_free_rcu_gp(rcu);
+	else
+		call_rcu(rcu, bpf_map_free_rcu_gp);
+}
+
 /* decrement map refcnt and schedule it for freeing via workqueue
  * (underlying map implementation ops->map_free() might sleep)
  */
@@ -727,11 +749,11 @@ void bpf_map_put(struct bpf_map *map)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
 		btf_put(map->btf);
-		INIT_WORK(&map->work, bpf_map_free_deferred);
-		/* Avoid spawning kworkers, since they all might contend
-		 * for the same mutex like slab_mutex.
-		 */
-		queue_work(system_unbound_wq, &map->work);
+
+		if (READ_ONCE(map->free_after_mult_rcu_gp))
+			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
+		else
+			bpf_map_free_in_work(map);
 	}
 }
 EXPORT_SYMBOL_GPL(bpf_map_put);
-- 
2.29.2


