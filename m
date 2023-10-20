Return-Path: <bpf+bounces-12819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F987D1088
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B21A1C20F4F
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833211C2AC;
	Fri, 20 Oct 2023 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54311BDD4
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 13:31:01 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320CD19E
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:30:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBlpN5Kwxz4f3mHm
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 21:30:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBn+dgIgTJlmYjjDQ--.7231S6;
	Fri, 20 Oct 2023 21:30:55 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/7] mm/percpu.c: introduce pcpu_alloc_size()
Date: Fri, 20 Oct 2023 21:31:57 +0800
Message-Id: <20231020133202.4043247-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231020133202.4043247-1-houtao@huaweicloud.com>
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn+dgIgTJlmYjjDQ--.7231S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Xr4kXw1kZFyUur15urg_yoW5JFy3pF
	Wkuryrtr48Xrn7Ww1ft3WUZw4rWw4kWF4xJay3WFy3Zr1aqFyYgr1qyrW5uFyrGFn2vr12
	qrZ0qFWxCFW5J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Hou Tao <houtao1@huawei.com>

Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
area. It will be used by bpf memory allocator in the following patches.
BPF memory allocator maintains per-cpu area caches for multiple area
sizes and its free API only has the to-be-freed per-cpu pointer, so it
needs the size of dynamic per-cpu area to select the corresponding cache
when bpf program frees the dynamic per-cpu pointer.

Acked-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/percpu.h |  1 +
 mm/percpu.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 68fac2e7cbe67..8c677f185901b 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
 extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
 extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
 extern void free_percpu(void __percpu *__pdata);
+extern size_t pcpu_alloc_size(void __percpu *__pdata);
 
 DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
 
diff --git a/mm/percpu.c b/mm/percpu.c
index 76b9c5e63c562..1759b91c8944a 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2244,6 +2244,37 @@ static void pcpu_balance_workfn(struct work_struct *work)
 	mutex_unlock(&pcpu_alloc_mutex);
 }
 
+/**
+ * pcpu_alloc_size - the size of the dynamic percpu area
+ * @ptr: pointer to the dynamic percpu area
+ *
+ * Returns the size of the @ptr allocation. This is undefined for statically
+ * defined percpu variables as there is no corresponding chunk->bound_map.
+ *
+ * RETURNS:
+ * The size of the dynamic percpu area.
+ *
+ * CONTEXT:
+ * Can be called from atomic context.
+ */
+size_t pcpu_alloc_size(void __percpu *ptr)
+{
+	struct pcpu_chunk *chunk;
+	unsigned long bit_off, end;
+	void *addr;
+
+	if (!ptr)
+		return 0;
+
+	addr = __pcpu_ptr_to_addr(ptr);
+	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */
+	chunk = pcpu_chunk_addr_search(addr);
+	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
+	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk),
+			    bit_off + 1);
+	return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;
+}
+
 /**
  * free_percpu - free percpu area
  * @ptr: pointer to area to free
-- 
2.29.2


