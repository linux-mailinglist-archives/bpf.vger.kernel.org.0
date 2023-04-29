Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55B96F23E1
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjD2Jlc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Apr 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2Jla (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Apr 2023 05:41:30 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE411173A;
        Sat, 29 Apr 2023 02:41:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q7kxw05WYz4f3l8K;
        Sat, 29 Apr 2023 17:41:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBA5kxkK36NIQ--.13426S5;
        Sat, 29 Apr 2023 17:41:25 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v3 1/6] bpf: Factor out a common helper free_all()
Date:   Sat, 29 Apr 2023 18:12:10 +0800
Message-Id: <20230429101215.111262-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230429101215.111262-1-houtao@huaweicloud.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBA5kxkK36NIQ--.13426S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3CrW5ZrW5Aw1DuF1fCrg_yoW5Ww1UpF
        y3Gry8JF4kZFsrua1xtrn7uwn8Xr1Fqa43K3yUu34Fkr13Zw1DtFZ2kr1IgFy5urW8tw43
        ArnYgF1xCr48JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Factor out a common helper free_all() to free all normal elements or
per-cpu elements on a lock-less list.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 410637c225fb..0668bcd7c926 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -211,9 +211,9 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
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
@@ -222,14 +222,19 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 	kfree(obj);
 }
 
-static void __free_rcu(struct rcu_head *head)
+static void free_all(struct llist_node *llnode, bool percpu)
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
+	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
@@ -432,7 +437,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	bool percpu = !!c->percpu_size;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
@@ -441,14 +446,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
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
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(__llist_del_all(&c->free_llist), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
-- 
2.29.2

