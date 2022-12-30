Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3189C65949B
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 05:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiL3EMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 23:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiL3EMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 23:12:09 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59880186E2;
        Thu, 29 Dec 2022 20:12:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NjsKC4w7sz4f3lXL;
        Fri, 30 Dec 2022 12:11:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMPZa5j3H4SAw--.35465S6;
        Fri, 30 Dec 2022 12:12:02 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next 2/6] bpf: Factor out a common helper free_llist()
Date:   Fri, 30 Dec 2022 12:11:47 +0800
Message-Id: <20221230041151.1231169-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221230041151.1231169-1-houtao@huaweicloud.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMPZa5j3H4SAw--.35465S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43AF4ruF48Xry5Jw1xGrg_yoW5Ww48pF
        y3Gry8Jr4kAFsrua1xtrn7Cas8Xw1Fqa47K3yUu34Skr13Zwn7tFWIkryIgFy5urW8t3y3
        Ar4vgr1xGay8JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Factor out a common helper free_llist() to free normal elements or
per-cpu elements on a lock-less list.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ac5b92fece14..3ad2e25946b5 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -217,9 +217,9 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	mem_cgroup_put(memcg);
 }
 
-static void free_one(struct bpf_mem_cache *c, void *obj)
+static void free_one(void *obj, bool percpu)
 {
-	if (c->percpu_size) {
+	if (percpu) {
 		free_percpu(((void **)obj)[1]);
 		kfree(obj);
 		return;
@@ -228,14 +228,19 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 	kfree(obj);
 }
 
-static void __free_rcu(struct rcu_head *head)
+static void free_llist(struct llist_node *llnode, bool percpu)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
-	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
 	struct llist_node *pos, *t;
 
 	llist_for_each_safe(pos, t, llnode)
-		free_one(c, pos);
+		free_one(pos, percpu);
+}
+
+static void __free_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+
+	free_llist(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
@@ -441,7 +446,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	bool percpu = !!c->percpu_size;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
@@ -450,14 +455,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
-		free_one(c, llnode);
+	free_llist(__llist_del_all(&c->free_by_rcu), percpu);
+	free_llist(llist_del_all(&c->waiting_for_gp), percpu);
+	free_llist(__llist_del_all(&c->free_llist), percpu);
+	free_llist(__llist_del_all(&c->free_llist_extra), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
-- 
2.29.2

