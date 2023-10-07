Return-Path: <bpf+bounces-11620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365997BC80A
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682771C20CA3
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C727EF5;
	Sat,  7 Oct 2023 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D1262A3
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 13:50:01 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E0FBD
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 06:49:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S2mrF6GDWz4f3kFX
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 21:49:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnvdz9YSFl4YF2CQ--.30763S5;
	Sat, 07 Oct 2023 21:49:54 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
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
	houtao1@huawei.com,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH bpf-next 1/6] mm/percpu.c: introduce alloc_size_percpu()
Date: Sat,  7 Oct 2023 21:51:01 +0800
Message-Id: <20231007135106.3031284-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231007135106.3031284-1-houtao@huaweicloud.com>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnvdz9YSFl4YF2CQ--.30763S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17ZFykAw4rCFWDJrWUJwb_yoW8tw4UpF
	Wku3s3tr1rXFn7Ww1ftw1UZw4rWw4kWayxJ343WFy5ZryavFyagF1vvrW5uFyrGFn2vry2
	qa90qF4fCFW3X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Introduce alloc_size_percpu() to get the size of the dynamic per-cpu
area. It will be used by bpf memory allocator in the following patches.
BPF memory allocator maintains multiple per-cpu area caches for multiple
area sizes and it needs the size of dynamic per-cpu area to select the
corresponding cache when bpf program frees the dynamic per-cpu area.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/percpu.h |  1 +
 mm/percpu.c            | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 68fac2e7cbe6..d140d9d79567 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
 extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
 extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
 extern void free_percpu(void __percpu *__pdata);
+extern size_t alloc_size_percpu(void __percpu *__pdata);
 
 DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
 
diff --git a/mm/percpu.c b/mm/percpu.c
index 7b40b3963f10..f541cfc3cb2d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2244,6 +2244,35 @@ static void pcpu_balance_workfn(struct work_struct *work)
 	mutex_unlock(&pcpu_alloc_mutex);
 }
 
+/**
+ * alloc_size_percpu - the size of the dynamic percpu area
+ * @ptr: pointer to the dynamic percpu area
+ *
+ * Return the size of the dynamic percpu area @ptr.
+ *
+ * RETURNS:
+ * The size of the dynamic percpu area.
+ *
+ * CONTEXT:
+ * Can be called from atomic context.
+ */
+size_t alloc_size_percpu(void __percpu *ptr)
+{
+	struct pcpu_chunk *chunk;
+	int bit_off, end;
+	void *addr;
+
+	if (!ptr)
+		return 0;
+
+	addr = __pcpu_ptr_to_addr(ptr);
+	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */
+	chunk = pcpu_chunk_addr_search(addr);
+	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
+	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk), bit_off + 1);
+	return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;
+}
+
 /**
  * free_percpu - free percpu area
  * @ptr: pointer to area to free
-- 
2.29.2


