Return-Path: <bpf+bounces-14989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92357E9C36
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3046FB20CDE
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A21DFCD;
	Mon, 13 Nov 2023 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007C1CF86
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 12:32:26 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8C19B9
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 04:32:22 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4STTMj45nZz4f3kkH
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:32:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 108591A0173
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:32:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA5NF1Jl2c5BAw--.31533S8;
	Mon, 13 Nov 2023 20:32:19 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf v2 4/5] bpf: Optimize the free of inner map
Date: Mon, 13 Nov 2023 20:33:23 +0800
Message-Id: <20231113123324.3914612-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231113123324.3914612-1-houtao@huaweicloud.com>
References: <20231113123324.3914612-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA5NF1Jl2c5BAw--.31533S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry7trWDGw17XFy8Xw48Crg_yoW7XF15pF
	W5GFykGr4kXr43u398Jw4xZa4rXw4Fkw15Ka4rC34rAr1UXryxZr40gFW5AF1YvFW8A3yF
	vr1293yrK34UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When removing the inner map from the outer map, the inner map will be
freed after one RCU grace period and one RCU tasks trace grace
period, so it is certain that the bpf program which may access the inner
map, has exited before the inner map is freed.

However there is unnecessary to wait for one RCU grace period or one RCU
tasks trace grace period if the outer map is only accessed by sleepable
program or non-sleepable program. So recording the context of the owned
bpf programs when adding map into env->used_maps and using the recorded
access context to decide which, and how many, RCU grace periods are
needed when freeing the inner map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     |  9 ++++++++-
 kernel/bpf/map_in_map.c | 18 +++++++++++++-----
 kernel/bpf/syscall.c    | 15 +++++++++++++--
 kernel/bpf/verifier.c   |  5 +++++
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ec3c90202ffe6..8faa1af4b39df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -245,6 +245,12 @@ struct bpf_list_node_kern {
 	void *owner;
 } __attribute__((aligned(8)));
 
+enum {
+	BPF_MAP_ACC_NORMAL_PROG_CTX = 1,
+	BPF_MAP_ACC_SLEEPABLE_PROG_CTX = 2,
+	BPF_MAP_ACC_PROG_CTX_MASK = BPF_MAP_ACC_NORMAL_PROG_CTX | BPF_MAP_ACC_SLEEPABLE_PROG_CTX,
+};
+
 struct bpf_map {
 	/* The first two cachelines with read-mostly members of which some
 	 * are also accessed in fast-path (e.g. ops, max_entries).
@@ -292,7 +298,8 @@ struct bpf_map {
 	} owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	bool free_after_mult_rcu_gp;
+	atomic_t owned_prog_ctx;
+	atomic_t may_be_accessed_prog_ctx;
 	s64 __percpu *elem_count;
 };
 
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index cf33630655661..e3d26a89ac5b6 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -131,12 +131,20 @@ void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool deferred)
 {
 	struct bpf_map *inner_map = ptr;
 
-	/* The inner map may still be used by both non-sleepable and sleepable
-	 * bpf program, so free it after one RCU grace period and one tasks
-	 * trace RCU grace period.
+	/* Defer the freeing of inner map according to the owner program
+	 * context of outer maps, so unnecessary multiple RCU GP waitings
+	 * can be avoided.
 	 */
-	if (deferred)
-		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+	if (deferred) {
+		/* owned_prog_ctx may be updated concurrently by new bpf program
+		 * so add smp_mb() below to ensure that reading owned_prog_ctx
+		 * will return the newly-set bit when the new bpf program finds
+		 * the inner map before it is removed from outer map.
+		 */
+		smp_mb();
+		atomic_or(atomic_read(&map->owned_prog_ctx),
+			  &inner_map->may_be_accessed_prog_ctx);
+	}
 	bpf_map_put(inner_map);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e2d2701ce2c45..5a7906f2b027e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -694,12 +694,20 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 	struct btf_record *rec = map->record;
+	int acc_ctx;
 
 	security_bpf_map_free(map);
 	bpf_map_release_memcg(map);
 
-	if (READ_ONCE(map->free_after_mult_rcu_gp))
-		synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
+	acc_ctx = atomic_read(&map->may_be_accessed_prog_ctx) & BPF_MAP_ACC_PROG_CTX_MASK;
+	if (acc_ctx) {
+		if (acc_ctx == BPF_MAP_ACC_NORMAL_PROG_CTX)
+			synchronize_rcu();
+		else if (acc_ctx == BPF_MAP_ACC_SLEEPABLE_PROG_CTX)
+			synchronize_rcu_tasks_trace();
+		else
+			synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
+	}
 
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -5326,6 +5334,9 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 		goto out_unlock;
 	}
 
+	/* No need to update owned_prog_ctx, because the bpf program doesn't
+	 * access the map.
+	 */
 	memcpy(used_maps_new, used_maps_old,
 	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
 	used_maps_new[prog->aux->used_map_cnt] = map;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bd1c42eb540f1..d8d5432b240dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18012,12 +18012,17 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
+			atomic_or(env->prog->aux->sleepable ? BPF_MAP_ACC_SLEEPABLE_PROG_CTX :
+							      BPF_MAP_ACC_NORMAL_PROG_CTX,
+				  &map->owned_prog_ctx);
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
 			 * will be used by the valid program until it's unloaded
 			 * and all maps are released in free_used_maps()
 			 */
 			bpf_map_inc(map);
+			/* Paired with smp_mb() in bpf_map_fd_put_ptr() */
+			smp_mb__after_atomic();
 
 			aux->map_index = env->used_map_cnt;
 			env->used_maps[env->used_map_cnt++] = map;
-- 
2.29.2


