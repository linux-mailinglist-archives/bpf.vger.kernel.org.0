Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60ED5FAD01
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJKGpu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 02:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJKGpt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 02:45:49 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634077542;
        Mon, 10 Oct 2022 23:45:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MmmSs14nqz6PmRS;
        Tue, 11 Oct 2022 14:43:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD39sgQEUVj3FxfAA--.20636S6;
        Tue, 11 Oct 2022 14:45:39 +0800 (CST)
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
Subject: [PATCH bpf-next 2/3] bpf: Free local storage memory after one RCU-tasks-trace grace period
Date:   Tue, 11 Oct 2022 15:11:27 +0800
Message-Id: <20221011071128.3470622-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221011071128.3470622-1-houtao@huaweicloud.com>
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD39sgQEUVj3FxfAA--.20636S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrtFy8tr15Cw13WrWfXwb_yoW8AF4kpF
        yUXrn8Jr4Fya1ruanxGF4fAryDXw47Wr1UKFZ5A3yftrZxArWDWFnIkF1Uua43Gw4rWr4I
        vF90gF1UGw1UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
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

Local storage map is accessible for both sleepable and normal bpf
program, so its memory is freed by using both call_rcu_tasks_trace() and
kfree_rcu() to wait for both RCU-tasks-trace grace period and RCU grace
period to expire.

However According to the current implementation of RCU-tasks-trace, one
RCU-tasks-trace grace period waits for one RCU grace period, so there is
no need to call kfree_rcu(), it is safe to call kfree() directly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 802fc15b0d73..18a2dd611635 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -84,20 +84,26 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
+/* Now RCU Tasks grace period implies RCU grace period, so no need to call
+ * kfree_rcu(), just call kfree() directly.
+ */
 void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	kfree_rcu(local_storage, rcu);
+	kfree(local_storage);
 }
 
+/* Now RCU Tasks grace period implies RCU grace period, so no need to call
+ * kfree_rcu(), just call kfree() directly.
+ */
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	kfree_rcu(selem, rcu);
+	kfree(selem);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
-- 
2.29.2

