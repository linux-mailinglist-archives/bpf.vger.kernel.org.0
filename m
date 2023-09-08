Return-Path: <bpf+bounces-9496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F46798808
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D61C20C86
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2AE63D4;
	Fri,  8 Sep 2023 13:39:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAE63C9
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:39:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3B1BEA
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:39:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rhxzl1P2Nz4f3l7b
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:39:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHVqkPJPtkRmSwCg--.44307S7;
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
Subject: [PATCH bpf 3/4] bpf: Ensure unit_size is matched with slab cache object size
Date: Fri,  8 Sep 2023 21:39:22 +0800
Message-Id: <20230908133923.2675053-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHVqkPJPtkRmSwCg--.44307S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48ur4fAFyUury3tFyxKrg_yoW5XFyfpF
	y7CF1rKrsYyFW7Wa1aqrs7Ca4ft340qF17J3yaq3409r4rXr1DGF4DJry2gF98urWrJa13
	Jr1kKr40krWUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
bpf_mem_cache is matched with the object_size of underlying slab cache.
If these two sizes are unmatched, print a warning once and return
-EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early and
the potential issue can be prevented.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 90c1ed8210a2..1c22b90e754a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -486,6 +486,24 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
 }
 
+static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
+{
+	struct llist_node *first;
+	unsigned int obj_size;
+
+	first = c->free_llist.first;
+	if (!first)
+		return 0;
+
+	obj_size = ksize(first);
+	if (obj_size != c->unit_size) {
+		WARN_ONCE(1, "bpf_mem_cache[%u]: unexpected object size %u, expect %u\n",
+			  idx, obj_size, c->unit_size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /* When size != 0 bpf_mem_cache for each cpu.
  * This is typical bpf hash map use case when all elements have equal size.
  *
@@ -496,10 +514,10 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
+	int cpu, i, err, unit_size, percpu_size = 0;
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
-	int cpu, i, unit_size, percpu_size = 0;
 
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
@@ -537,6 +555,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
 	if (!pcc)
 		return -ENOMEM;
+	err = 0;
 #ifdef CONFIG_MEMCG_KMEM
 	objcg = get_obj_cgroup_from_current();
 #endif
@@ -557,10 +576,20 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			if (i != bpf_mem_cache_idx(c->unit_size))
 				continue;
 			prefill_mem_cache(c, cpu);
+			err = check_obj_size(c, i);
+			if (err)
+				goto out;
 		}
 	}
+
+out:
 	ma->caches = pcc;
-	return 0;
+	/* refill_work is either zeroed or initialized, so it is safe to
+	 * call irq_work_sync().
+	 */
+	if (err)
+		bpf_mem_alloc_destroy(ma);
+	return err;
 }
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
-- 
2.29.2


