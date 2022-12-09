Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26F1647B2B
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 02:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLIBJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 20:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLIBJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 20:09:58 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF183243;
        Thu,  8 Dec 2022 17:09:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NStGl6gqqz4f3pFy;
        Fri,  9 Dec 2022 09:09:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9jdipJjIEibBw--.55652S6;
        Fri, 09 Dec 2022 09:09:54 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/2] bpf: Skip rcu_barrier() if rcu_trace_implies_rcu_gp() is true
Date:   Fri,  9 Dec 2022 09:09:47 +0800
Message-Id: <20221209010947.3130477-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221209010947.3130477-1-houtao@huaweicloud.com>
References: <20221209010947.3130477-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9jdipJjIEibBw--.55652S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1xCFWxJF4xuF1rArW7XFb_yoW8XFW5pa
        y2vFyUtr15uF45K3Zaqr1xAw4UAr9Yga17t3s7Wry8Zr1ayryDWrZFvry3XF1YyrZ5Ca4a
        yrnI9r15t3WUXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

If there are pending rcu callback, free_mem_alloc() will use
rcu_barrier_tasks_trace() and rcu_barrier() to wait for the pending
__free_rcu_tasks_trace() and __free_rcu() callback.

If rcu_trace_implies_rcu_gp() is true, there will be no pending
__free_rcu(), so it will be OK to skip rcu_barrier() as well.

Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 04d96d1b98a3..ebcc3dd0fa19 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -464,9 +464,17 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
 	/* waiting_for_gp lists was drained, but __free_rcu might
 	 * still execute. Wait for it now before we freeing percpu caches.
+	 *
+	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
+	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
+	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
+	 * so if call_rcu(head, __free_rcu) is skipped due to
+	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
+	 * using rcu_trace_implies_rcu_gp() as well.
 	 */
 	rcu_barrier_tasks_trace();
-	rcu_barrier();
+	if (!rcu_trace_implies_rcu_gp())
+		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
 }
 
-- 
2.29.2

