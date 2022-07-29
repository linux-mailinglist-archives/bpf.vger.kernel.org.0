Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6813C584F3F
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiG2Kya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 06:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiG2Ky3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 06:54:29 -0400
X-Greylist: delayed 954 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 03:54:27 PDT
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4186899;
        Fri, 29 Jul 2022 03:54:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LvP954M6qzkk2B;
        Fri, 29 Jul 2022 18:37:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mmnuONiUgtOBQ--.27701S4;
        Fri, 29 Jul 2022 18:38:31 +0800 (CST)
From:   Zhang Wensheng <zhangwensheng@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, yukuai3@huawei.com,
        zhangwensheng@huaweicloud.com
Subject: [PATCH -next] [RFC] block: fix null-deref in percpu_ref_put
Date:   Fri, 29 Jul 2022 18:50:36 +0800
Message-Id: <20220729105036.2202791-1-zhangwensheng@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mmnuONiUgtOBQ--.27701S4
X-Coremail-Antispam: 1UD129KBjvJXoWxArWDJrW5tFykKw1rCFyfWFg_yoWrZF4UpF
        WDGF4akw10gr4DWry8Jw47ZasFgw4qkFy3CayfKrWYyF1qgFn2vr18Crs8XF48Cr4kArW5
        ZrWDWwsIkryUWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: x2kd0wpzhq2xhhqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Zhang Wensheng <zhangwensheng5@huawei.com>

A problem was find in stable 5.10 and the root cause of it like below.

In the use of q_usage_counter of request_queue, blk_cleanup_queue using
"wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter))"
to wait q_usage_counter becoming zero. however, if the q_usage_counter
becoming zero quickly, and percpu_ref_exit will execute and ref->data
will be freed, maybe another process will cause a null-defef problem
like below:

	CPU0                             CPU1
blk_cleanup_queue
 blk_freeze_queue
  blk_mq_freeze_queue_wait
				scsi_end_request
				 percpu_ref_get
				 ...
				 percpu_ref_put
				  atomic_long_sub_and_test
  percpu_ref_exit
   ref->data -> NULL
   				   ref->data->release(ref) -> null-deref

Fix it by setting flag(QUEUE_FLAG_USAGE_COUNT_SYNC) to add synchronization
mechanism, when ref->data->release is called, the flag will be setted,
and the "wait_event" in blk_mq_freeze_queue_wait must wait flag becoming
true as well, which will limit percpu_ref_exit to execute ahead of time.

Although the problem was not reproduced in mainline, it may also has
problem when the passthrough IO which will go directly to
blk_cleanup_queue and cause the problem as well.

Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 block/blk-core.c       | 4 +++-
 block/blk-mq.c         | 7 +++++++
 include/linux/blk-mq.h | 1 +
 include/linux/blkdev.h | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 27fb1357ad4b..4b73f46e62ec 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -312,7 +312,8 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
 	 * after draining finished.
 	 */
-	blk_freeze_queue(q);
+	blk_freeze_queue_start(q);
+	blk_mq_freeze_queue_wait_sync(q);
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
@@ -403,6 +404,7 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
+	blk_queue_flag_set(QUEUE_FLAG_USAGE_COUNT_SYNC, q);
 	wake_up_all(&q->mq_freeze_wq);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93d9d60980fb..44e764257511 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -165,6 +165,7 @@ void blk_freeze_queue_start(struct request_queue *q)
 {
 	mutex_lock(&q->mq_freeze_lock);
 	if (++q->mq_freeze_depth == 1) {
+		blk_queue_flag_clear(QUEUE_FLAG_USAGE_COUNT_SYNC, q);
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
@@ -175,6 +176,12 @@ void blk_freeze_queue_start(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
+void blk_mq_freeze_queue_wait_sync(struct request_queue *q)
+{
+	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter) &&
+			test_bit(QUEUE_FLAG_USAGE_COUNT_SYNC, &q->queue_flags));
+}
+
 void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
 	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e2d9daf7e8dd..50fd56f85b31 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -868,6 +868,7 @@ void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
+void blk_mq_freeze_queue_wait_sync(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f7b43444c5f..93ed8b166d66 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -575,6 +575,8 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+/* sync for q_usage_counter */
+#define QUEUE_FLAG_USAGE_COUNT_SYNC    31
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-- 
2.31.1

