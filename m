Return-Path: <bpf+bounces-3939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FA746A4F
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 09:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546FC1C20A83
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7FC1370;
	Tue,  4 Jul 2023 07:08:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0615ED9
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 07:08:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C321FB
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 00:08:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QwDQS1XX1z4f3kFN
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 15:08:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXwLNRxaNkARmvNA--.4479S4;
	Tue, 04 Jul 2023 15:08:02 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com
Subject: [PATCH bpf-next] bpf: Remove unnecessary ring buffer size check
Date: Tue,  4 Jul 2023 15:40:14 +0800
Message-Id: <20230704074014.216616-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXwLNRxaNkARmvNA--.4479S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur4ruFyDtF4ruF18WFWrAFb_yoW5Xr47pF
	4akFW29w47JF4Uur4xZw48AFZ8J397WFWfWFW3J3WxArnrXF47XF12gFWfXry3ZrykCrW0
	krWq9Fyvy3yqvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UQ6p9UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The theoretical maximum size of ring buffer is about 64GB, but now the
size of ring buffer is specified by max_entries in bpf_attr and its
maximum value is (4GB - 1), and it won't be possible for overflow.

So just remove the unnecessary size check in ringbuf_map_alloc() but
keep the comments for possible extension in future.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/9c636a63-1f3d-442d-9223-96c2dccb9469@moroto.mountain
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/ringbuf.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 875ac9b698d9..f045fde632e5 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -23,15 +23,6 @@
 
 #define RINGBUF_MAX_RECORD_SZ (UINT_MAX/4)
 
-/* Maximum size of ring buffer area is limited by 32-bit page offset within
- * record header, counted in pages. Reserve 8 bits for extensibility, and take
- * into account few extra pages for consumer/producer pages and
- * non-mmap()'able parts. This gives 64GB limit, which seems plenty for single
- * ring buffer.
- */
-#define RINGBUF_MAX_DATA_SZ \
-	(((1ULL << 24) - RINGBUF_POS_PAGES - RINGBUF_PGOFF) * PAGE_SIZE)
-
 struct bpf_ringbuf {
 	wait_queue_head_t waitq;
 	struct irq_work work;
@@ -161,6 +152,17 @@ static void bpf_ringbuf_notify(struct irq_work *work)
 	wake_up_all(&rb->waitq);
 }
 
+/* Maximum size of ring buffer area is limited by 32-bit page offset within
+ * record header, counted in pages. Reserve 8 bits for extensibility, and
+ * take into account few extra pages for consumer/producer pages and
+ * non-mmap()'able parts, the current maximum size would be:
+ *
+ *     (((1ULL << 24) - RINGBUF_POS_PAGES - RINGBUF_PGOFF) * PAGE_SIZE)
+ *
+ * This gives 64GB limit, which seems plenty for single ring buffer. Now
+ * considering that the maximum value of data_sz is (4GB - 1), there
+ * will be no overflow, so just note the size limit in the comments.
+ */
 static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 {
 	struct bpf_ringbuf *rb;
@@ -193,12 +195,6 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 	    !PAGE_ALIGNED(attr->max_entries))
 		return ERR_PTR(-EINVAL);
 
-#ifdef CONFIG_64BIT
-	/* on 32-bit arch, it's impossible to overflow record's hdr->pgoff */
-	if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
-		return ERR_PTR(-E2BIG);
-#endif
-
 	rb_map = bpf_map_area_alloc(sizeof(*rb_map), NUMA_NO_NODE);
 	if (!rb_map)
 		return ERR_PTR(-ENOMEM);
-- 
2.29.2


