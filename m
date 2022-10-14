Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE65FED0A
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJNLOV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJNLOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 07:14:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21CC193EDA;
        Fri, 14 Oct 2022 04:14:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MpkHH30sXz6S3gk;
        Fri, 14 Oct 2022 19:11:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBnZ8lyREljUWYIAQ--.52658S6;
        Fri, 14 Oct 2022 19:14:12 +0800 (CST)
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
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
Date:   Fri, 14 Oct 2022 19:39:44 +0800
Message-Id: <20221014113946.965131-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221014113946.965131-1-houtao@huaweicloud.com>
References: <20221014113946.965131-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnZ8lyREljUWYIAQ--.52658S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxGFW7GrykJFy8uw1DGFg_yoW8Zr4xpF
        yxKrn8Grs5ZF4Sk3s3Ar17G3y5Aws3W3sFqay8A345Ar15ZryDuFsrCFy5uF1Fkrs5Ar4a
        vFn09r1UGa1UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UXXocUUUUU=
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

The memory free logic in bpf memory allocator chains a RCU Tasks Trace
grace period and a normal RCU grace period one after the other, so it
can ensure that both sleepable and non-sleepable programs have finished.

With the introduction of rcu_trace_implies_rcu_gp(),
__free_rcu_tasks_trace() can check whether or not a normal RCU grace
period has also passed after a RCU Tasks Trace grace period has passed.
If it is true, freeing these elements directly, else freeing through
call_rcu().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 5f83be1d2018..2433be58bb85 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -222,9 +222,13 @@ static void __free_rcu(struct rcu_head *head)
 
 static void __free_rcu_tasks_trace(struct rcu_head *head)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
-
-	call_rcu(&c->rcu, __free_rcu);
+	/* If RCU Tasks Trace grace period implies RCU grace period,
+	 * there is no need to invoke call_rcu().
+	 */
+	if (rcu_trace_implies_rcu_gp())
+		__free_rcu(head);
+	else
+		call_rcu(head, __free_rcu);
 }
 
 static void enque_to_free(struct bpf_mem_cache *c, void *obj)
@@ -253,8 +257,9 @@ static void do_call_rcu(struct bpf_mem_cache *c)
 		 */
 		__llist_add(llnode, &c->waiting_for_gp);
 	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
-	 * Then use call_rcu() to wait for normal progs to finish
-	 * and finally do free_one() on each element.
+	 * If RCU Tasks Trace grace period implies RCU grace period, free
+	 * these elements directly, else use call_rcu() to wait for normal
+	 * progs to finish and finally do free_one() on each element.
 	 */
 	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
 }
-- 
2.29.2

