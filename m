Return-Path: <bpf+bounces-9495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD5798807
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FD6281B10
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6843963C5;
	Fri,  8 Sep 2023 13:39:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE563B3
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:39:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B1A1BC5
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:39:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rhxzn6PN0z4f3kpV
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:39:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHVqkPJPtkRmSwCg--.44307S6;
	Fri, 08 Sep 2023 21:39:34 +0800 (CST)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf 2/4] bpf: Don't prefill for unused bpf_mem_cache
Date: Fri,  8 Sep 2023 21:39:21 +0800
Message-Id: <20230908133923.2675053-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230908133923.2675053-1-houtao@huaweicloud.com>
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHVqkPJPtkRmSwCg--.44307S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45Zw4rZFW3AFW5JFy8AFb_yoW8tryxpF
	y3CF10krs5ZFZru3WxWw1xCayft34vg3Zrt3yrtry09rs5ur1Dur4DJry7XFyY9rZ7ta1f
	Ar4kKry0gF4UZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

When the unit_size of a bpf_mem_cache is unmatched with the object_size
of the underlying slab cache, the bpf_mem_cache will not be used, and
the allocation will be redirected to a bpf_mem_cache with a bigger
unit_size instead, so there is no need to prefill for these
unused bpf_mem_caches.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 98d9e96fba3c..90c1ed8210a2 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -459,8 +459,7 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
  * Typical case will be between 11K and 116K closer to 11K.
  * bpf progs can and should share bpf_mem_cache when possible.
  */
-
-static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
+static void init_refill_work(struct bpf_mem_cache *c)
 {
 	init_irq_work(&c->refill_work, bpf_mem_refill);
 	if (c->unit_size <= 256) {
@@ -476,7 +475,10 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 		c->high_watermark = max(96 * 256 / c->unit_size, 3);
 	}
 	c->batch = max((c->high_watermark - c->low_watermark) / 4 * 3, 1);
+}
 
+static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
+{
 	/* To avoid consuming memory assume that 1st run of bpf
 	 * prog won't be doing more than 4 map_update_elem from
 	 * irq disabled region
@@ -521,6 +523,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
+			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -544,6 +547,15 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
 			c->tgt = c;
+
+			init_refill_work(c);
+			/* Another bpf_mem_cache will be used when allocating
+			 * c->unit_size in bpf_mem_alloc(), so doesn't prefill
+			 * for the bpf_mem_cache because these free objects will
+			 * never be used.
+			 */
+			if (i != bpf_mem_cache_idx(c->unit_size))
+				continue;
 			prefill_mem_cache(c, cpu);
 		}
 	}
-- 
2.29.2


