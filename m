Return-Path: <bpf+bounces-15809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336117F72B7
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 12:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570831C20BCA
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2741EB4A;
	Fri, 24 Nov 2023 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F41810FD
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 03:29:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ScCS768stz4f3k6Y
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 19:29:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9A0761A06D2
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 19:29:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xEUiWBloME3Bw--.31197S8;
	Fri, 24 Nov 2023 19:29:30 +0800 (CST)
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
Subject: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
Date: Fri, 24 Nov 2023 19:30:31 +0800
Message-Id: <20231124113033.503338-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231124113033.503338-1-houtao@huaweicloud.com>
References: <20231124113033.503338-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xEUiWBloME3Bw--.31197S8
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyxCF43KF43KFyxAr43KFg_yoW7Ww4DpF
	W5KrW8Gr4kXr42k39Iyw47Z345XwsYgw45Gas5C345Ar15Wr9FqFy0gFW5Jr98AF4kJ3yI
	vrnIgryUK3yUZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

When removing the inner map from the outer map, the inner map will be
freed after one RCU grace period and one RCU tasks trace grace
period, so it is certain that the bpf program, which may access the
inner map, has exited before the inner map is freed.

However there is unnecessary to wait for any RCU grace period, one RCU
grace period or one RCU tasks trace grace period if the outer map is
only accessed by userspace, sleepable program or non-sleepable program.
So recording the sleepable attributes of the owned bpf programs when
adding the outer map into env->used_maps, copying the recorded
attributes to inner map atomically when removing inner map from the
outer map and using the recorded attributes in the inner map to decide
which, and how many, RCU grace periods are needed when freeing the
inner map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     |  8 +++++++-
 kernel/bpf/map_in_map.c | 19 ++++++++++++++-----
 kernel/bpf/syscall.c    | 15 +++++++++++++--
 kernel/bpf/verifier.c   |  4 ++++
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 15a6bb951b70..c5b549f352d7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -245,6 +245,11 @@ struct bpf_list_node_kern {
 	void *owner;
 } __attribute__((aligned(8)));
 
+enum {
+	BPF_MAP_RCU_GP = BIT(0),
+	BPF_MAP_RCU_TT_GP = BIT(1),
+};
+
 struct bpf_map {
 	/* The first two cachelines with read-mostly members of which some
 	 * are also accessed in fast-path (e.g. ops, max_entries).
@@ -296,7 +301,8 @@ struct bpf_map {
 	} owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	bool free_after_mult_rcu_gp;
+	atomic_t used_in_rcu_gp;
+	atomic_t free_by_rcu_gp;
 	s64 __percpu *elem_count;
 };
 
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index cf3363065566..d044ee677107 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -131,12 +131,21 @@ void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool deferred)
 {
 	struct bpf_map *inner_map = ptr;
 
-	/* The inner map may still be used by both non-sleepable and sleepable
-	 * bpf program, so free it after one RCU grace period and one tasks
-	 * trace RCU grace period.
+	/* Defer the freeing of inner map according to the attribute of bpf
+	 * program which owns the outer map, so unnecessary multiple RCU GP
+	 * waitings can be avoided.
 	 */
-	if (deferred)
-		WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
+	if (deferred) {
+		/* used_in_rcu_gp may be updated concurrently by new bpf
+		 * program, so add smp_mb() to guarantee the order between
+		 * used_in_rcu_gp and lookup/deletion operation of inner map.
+		 * If a new bpf program finds the inner map before it is
+		 * removed from outer map, reading used_in_rcu_gp below will
+		 * return the newly-set bit set by the new bpf program.
+		 */
+		smp_mb();
+		atomic_or(atomic_read(&map->used_in_rcu_gp), &inner_map->free_by_rcu_gp);
+	}
 	bpf_map_put(inner_map);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 88882cb58121..014a8cd55a41 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -734,7 +734,10 @@ static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
 
 static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
+	struct bpf_map *map = container_of(rcu, struct bpf_map, rcu);
+
+	if (!(atomic_read(&map->free_by_rcu_gp) & BPF_MAP_RCU_GP) ||
+	    rcu_trace_implies_rcu_gp())
 		bpf_map_free_rcu_gp(rcu);
 	else
 		call_rcu(rcu, bpf_map_free_rcu_gp);
@@ -746,11 +749,16 @@ static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
 void bpf_map_put(struct bpf_map *map)
 {
 	if (atomic64_dec_and_test(&map->refcnt)) {
+		int free_by_rcu_gp;
+
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
 		btf_put(map->btf);
 
-		if (READ_ONCE(map->free_after_mult_rcu_gp))
+		free_by_rcu_gp = atomic_read(&map->free_by_rcu_gp);
+		if (free_by_rcu_gp == BPF_MAP_RCU_GP)
+			call_rcu(&map->rcu, bpf_map_free_rcu_gp);
+		else if (free_by_rcu_gp)
 			call_rcu_tasks_trace(&map->rcu, bpf_map_free_mult_rcu_gp);
 		else
 			bpf_map_free_in_work(map);
@@ -5343,6 +5351,9 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 		goto out_unlock;
 	}
 
+	/* No need to update used_in_rcu_gp, because the bpf program doesn't
+	 * access the map.
+	 */
 	memcpy(used_maps_new, used_maps_old,
 	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
 	used_maps_new[prog->aux->used_map_cnt] = map;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6da370a047fe..3b86c02077f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18051,6 +18051,10 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
+			atomic_or(env->prog->aux->sleepable ? BPF_MAP_RCU_TT_GP : BPF_MAP_RCU_GP,
+				  &map->used_in_rcu_gp);
+			/* Pairs with smp_mb() in bpf_map_fd_put_ptr() */
+			smp_mb__before_atomic();
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
 			 * will be used by the valid program until it's unloaded
-- 
2.29.2


