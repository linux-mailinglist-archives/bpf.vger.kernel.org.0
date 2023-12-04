Return-Path: <bpf+bounces-16581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7508035D2
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 15:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6628C2810DC
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE7028684;
	Mon,  4 Dec 2023 14:03:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11883FE
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 06:03:27 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkQP740Ytz4f3jq8
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:03:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 90F9F1A01A5
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:03:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHShAl3G1l+wflCg--.13401S9;
	Mon, 04 Dec 2023 22:03:24 +0800 (CST)
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
Subject: [PATCH bpf v5 5/7] bpf: Optimize the free of inner map
Date: Mon,  4 Dec 2023 22:04:23 +0800
Message-Id: <20231204140425.1480317-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231204140425.1480317-1-houtao@huaweicloud.com>
References: <20231204140425.1480317-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHShAl3G1l+wflCg--.13401S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fZFyfZFW5KF1fCr47twb_yoW7JF4xpF
	45KrW8Gr4vqF43u34DAw48Z34rJws5K3y5Gas5CryFyrsxW348Xry8GFW5AFn0vF4kJF40
	vr1agrWYk3y3ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When removing the inner map from the outer map, the inner map will be
freed after one RCU grace period and one RCU tasks trace grace
period, so it is certain that the bpf program, which may access the
inner map, has exited before the inner map is freed.

However there is no need to wait for one RCU tasks trace grace period if
the outer map is only accessed by non-sleepable program. So adding
sleepable_refcnt in bpf_map and increasing sleepable_refcnt when adding
the outer map into env->used_maps for sleepable program. Although the
max number of bpf program is INT_MAX - 1, the number of bpf programs
which are being loaded may be greater than INT_MAX, so using atomic64_t
instead of atomic_t for sleepable_refcnt. When removing the inner map
from the outer map, using sleepable_refcnt to decide whether or not a
RCU tasks trace grace period is needed before freeing the inner map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     |  2 ++
 kernel/bpf/core.c       |  4 ++++
 kernel/bpf/map_in_map.c | 14 +++++++++-----
 kernel/bpf/syscall.c    |  8 ++++++++
 kernel/bpf/verifier.c   |  4 +++-
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 15a6bb951b70..4a78cc0c81c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -297,6 +297,8 @@ struct bpf_map {
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	bool free_after_mult_rcu_gp;
+	bool free_after_rcu_gp;
+	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cd3afe57ece3..4b813da8d6c0 100644
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
+			atomic64_dec(&map->sleepable_refcnt);
 		bpf_map_put(map);
 	}
 }
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 3248ff5d8161..8ef269e66ba5 100644
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
+		if (atomic64_read(&map->sleepable_refcnt))
+			WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+		else
+			WRITE_ONCE(inner_map->free_after_rcu_gp, true);
+	}
 	bpf_map_put(inner_map);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 88882cb58121..7ba10570ca97 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -750,8 +750,11 @@ void bpf_map_put(struct bpf_map *map)
 		bpf_map_free_id(map);
 		btf_put(map->btf);
 
+		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
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
+		atomic64_inc(&map->sleepable_refcnt);
 	memcpy(used_maps_new, used_maps_old,
 	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
 	used_maps_new[prog->aux->used_map_cnt] = map;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6da370a047fe..0c018cedf47e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18051,10 +18051,12 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
+			if (env->prog->aux->sleepable)
+				atomic64_inc(&map->sleepable_refcnt);
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
 			 * will be used by the valid program until it's unloaded
-			 * and all maps are released in free_used_maps()
+			 * and all maps are released in bpf_free_used_maps()
 			 */
 			bpf_map_inc(map);
 
-- 
2.29.2


