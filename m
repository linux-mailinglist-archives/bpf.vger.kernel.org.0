Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5DE5FAD04
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJKGpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 02:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJKGpu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 02:45:50 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460357697B;
        Mon, 10 Oct 2022 23:45:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmmTC3JHWzl4wS;
        Tue, 11 Oct 2022 14:43:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD39sgQEUVj3FxfAA--.20636S5;
        Tue, 11 Oct 2022 14:45:38 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [PATCH bpf-next 1/3] bpf: Free elements after one RCU-tasks-trace grace period
Date:   Tue, 11 Oct 2022 15:11:26 +0800
Message-Id: <20221011071128.3470622-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221011071128.3470622-1-houtao@huaweicloud.com>
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD39sgQEUVj3FxfAA--.20636S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw17XrWfGw1xtw1kZF43Wrg_yoW8try5pF
        yfJFyDGrs5AF4a9a93Xr1xC398A39ag3srtay0y3sa9ry5C34DuF4UCa45XFyF9rWrAa1a
        vr4vkr13Ga18ZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

According to the implementation of RCU Tasks Trace, it inovkes
->postscan_func() to wait for one RCU-tasks-trace grace period and
rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
normal RCU grace period in turn, so one RCU-tasks-trace grace period
will imply one RCU grace period.

So there is no need to do call_rcu() again in the callback of
call_rcu_tasks_trace() and it can just free these elements directly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 5f83be1d2018..6f32dddc804f 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -209,6 +209,9 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 	kfree(obj);
 }
 
+/* Now RCU Tasks grace period implies RCU grace period, so no need to do
+ * an extra call_rcu().
+ */
 static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
@@ -220,13 +223,6 @@ static void __free_rcu(struct rcu_head *head)
 	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
-static void __free_rcu_tasks_trace(struct rcu_head *head)
-{
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
-
-	call_rcu(&c->rcu, __free_rcu);
-}
-
 static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 {
 	struct llist_node *llnode = obj;
@@ -252,11 +248,10 @@ static void do_call_rcu(struct bpf_mem_cache *c)
 		 * from __free_rcu() and from drain_mem_cache().
 		 */
 		__llist_add(llnode, &c->waiting_for_gp);
-	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
-	 * Then use call_rcu() to wait for normal progs to finish
-	 * and finally do free_one() on each element.
+	/* Use call_rcu_tasks_trace() to wait for both sleepable and normal
+	 * progs to finish and finally do free_one() on each element.
 	 */
-	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
+	call_rcu_tasks_trace(&c->rcu, __free_rcu);
 }
 
 static void free_bulk(struct bpf_mem_cache *c)
-- 
2.29.2

