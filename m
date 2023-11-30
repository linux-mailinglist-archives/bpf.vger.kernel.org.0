Return-Path: <bpf+bounces-16265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522437FF10E
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91B1B20FC4
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B09487BC;
	Thu, 30 Nov 2023 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B9D1AD
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:00:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SgyWN6QQkz4f3lx4
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DE59E1A0DCF
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBslWhlJ5NxCQ--.49902S9;
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
Subject: [PATCH bpf v4 5/7] bpf: Optimize the free of inner map
Date: Thu, 30 Nov 2023 22:01:18 +0800
Message-Id: <20231130140120.1736235-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXWhBslWhlJ5NxCQ--.49902S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fZFyfZFyUGw4rZF13Jwb_yoWrKw1UpF
	45KrW8Gr48XF4fu34DAw48Z34rXw4rK3y5Gas5G34aywsxW348XrW8WFW5AFn0vF4kJF4I
	vr1agrWYk3y7Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When removing the inner map from the outer map, the inner map will be
freed after one RCU grace period and one RCU tasks trace grace
period, so it is certain that the bpf program, which may access the
inner map, has exited before the inner map is freed.

However there is no need to wait for one RCU tasks trace grace period if
the outer map is only accessed by non-sleepable program. So adding
sleepable_refcnt in bpf_map and increasing sleepable_refcnt when adding
the outer map into env->used_maps for sleepable program. Considering the
max number of bpf program is INT_MAX - 1, atomic_t instead of atomic64_t
is used for sleepable_refcnt. When removing the inner map from the outer
map, using sleepable_refcnt to decide whether or not a RCU tasks trace
grace period is needed before freeing the inner map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     |  2 ++
 kernel/bpf/core.c       |  4 ++++
 kernel/bpf/map_in_map.c | 14 +++++++++-----
 kernel/bpf/syscall.c    |  8 ++++++++
 kernel/bpf/verifier.c   |  4 +++-
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 15a6bb951b70..c84095677519 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -297,6 +297,8 @@ struct bpf_map {
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	bool free_after_mult_rcu_gp;
+	bool free_after_rcu_gp;
+	atomic_t sleepable_refcnt;
 	s64 __percpu *elem_count;
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cd3afe57ece3..f9f86ab83748 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2664,12 +2664,16 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 			  struct bpf_map **used_maps, u32 len)
 {
 	struct bpf_map *map;
+	bool sleepable;
 	u32 i;
 
+	sleepable = aux->sleepable;
 	for (i = 0; i < len; i++) {
 		map = used_maps[i];
 		if (map->ops->map_poke_untrack)
 			map->ops->map_poke_untrack(map, aux);
+		if (sleepable)
+			atomic_dec(&map->sleepable_refcnt);
 		bpf_map_put(map);
 	}
 }
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 3248ff5d8161..7a8fe233555f 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -131,12 +131,16 @@ void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	struct bpf_map *inner_map = ptr;
 
-	/* The inner map may still be used by both non-sleepable and sleepable
-	 * bpf program, so free it after one RCU grace period and one tasks
-	 * trace RCU grace period.
+	/* Defer the freeing of inner map according to the sleepable attribute
+	 * of bpf program which owns the outer map, so unnecessary waiting for
+	 * RCU tasks trace grace period can be avoided.
 	 */
-	if (need_defer)
-		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+	if (need_defer) {
+		if (atomic_read(&map->sleepable_refcnt))
+			WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+		else
+			WRITE_ONCE(inner_map->free_after_rcu_gp, true);
+	}
 	bpf_map_put(inner_map);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 88882cb58121..7880bb3daffb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -750,8 +750,11 @@ void bpf_map_put(struct bpf_map *map)
 		bpf_map_free_id(map);
 		btf_put(map->btf);
 
+		WARN_ON_ONCE(atomic_read(&map->sleepable_refcnt));
 		if (READ_ONCE(map->free_after_mult_rcu_gp))
 			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
+		else if (READ_ONCE(map->free_after_rcu_gp))
+			call_rcu(&map->rcu, bpf_map_free_rcu_gp);
 		else
 			bpf_map_free_in_work(map);
 	}
@@ -5343,6 +5346,11 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 		goto out_unlock;
 	}
 
+	/* The bpf program will not access the bpf map, but for the sake of
+	 * simplicity, increase sleepable_refcnt for sleepable program as well.
+	 */
+	if (prog->aux->sleepable)
+		atomic_inc(&map->sleepable_refcnt);
 	memcpy(used_maps_new, used_maps_old,
 	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
 	used_maps_new[prog->aux->used_map_cnt] = map;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6da370a047fe..8fa28f969609 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18051,10 +18051,12 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
+			if (env->prog->aux->sleepable)
+				atomic_inc(&map->sleepable_refcnt);
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
 			 * will be used by the valid program until it's unloaded
-			 * and all maps are released in free_used_maps()
+			 * and all maps are released in bpf_free_used_maps()
 			 */
 			bpf_map_inc(map);
 
-- 
2.29.2


