Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200D1643C42
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 05:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiLFE36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 23:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLFE35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 23:29:57 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F8B2670
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 20:29:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NR6rs4hg6z4f3tbr
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 12:29:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXSNY7xY5jzaDzBg--.51441S6;
        Tue, 06 Dec 2022 12:29:52 +0800 (CST)
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
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf-next 2/2] bpf: Skip rcu_barrier() if rcu_trace_implies_rcu_gp() is true
Date:   Tue,  6 Dec 2022 12:29:46 +0800
Message-Id: <20221206042946.686847-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221206042946.686847-1-houtao@huaweicloud.com>
References: <20221206042946.686847-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXSNY7xY5jzaDzBg--.51441S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1xCFW7CF47tw15Jr4fXwb_yoW8Gw43pa
        1avFyUtr15CF4UK3Z3tr1xA3yUAr9Yga17t3s7Wry8ZrnIyryDWrZFyry3WF1YvrZ5Ca4a
        yrsI9r15t3WUXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 7daf147bc8f6..d43991fafc4f 100644
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

